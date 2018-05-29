var canvas = document.querySelector("canvas");	// Canvas
var ctx = canvas.getContext("2d");				// Canvas Rendering Context

var scoreDiv     = document.querySelector("#score");
var highscoreDiv = document.querySelector("#highscore");

var canvasWidth  = canvas.width;
var canvasHeight = canvas.height;

var tileWidth    = Math.floor(canvasWidth * (5/100));
var tileHeight   = Math.floor(canvasHeight * (6/100));
var tileCountHor = Math.ceil(canvasWidth / tileWidth);
var tileCountVer = Math.ceil(canvasHeight / tileHeight);

var marginHor = Math.floor(tileWidth * (18/100));
var marginVer = Math.floor(tileHeight * (18/100));;

var rectWidth  = tileWidth - marginHor;
var rectHeight = tileHeight - marginVer;

// ctx.fillStyle = "green";
// ctx.fillRect(1*tileWidth, 1*tileHeight, rectWidth, rectHeight);
// ctx.fillRect(2*tileWidth, 1*tileHeight, rectWidth, rectHeight);

var backgroundColor = "#DBCBA7";
var snakeColor 	    = "black";
var foodColor       = "red";

var posX = 1;
var posY = 1;

var foodPosX;
var foodPosY;

var velocityX = 0;
var velocityY = 0;

var trail      = [];

var startingTailLen = 5;
var tailLen         = startingTailLen;

var currentDir;

var score     = 0;
var highscore = 0;

var hasStarted = false;
var keyPressed = false;

var refreshSpeed = 100;


canvas.style.backgroundColor = backgroundColor;
generateRandomFoodPos();
updateScores();

document.addEventListener("keydown", keyPress);
setInterval(game, refreshSpeed);


function game() {
	if ((velocityX > 0 || velocityY > 0) && !hasStarted) {
		hasStarted = true;
	}

	posX += velocityX;
	posY += velocityY;

	// Wrap
	wrapPosition();

	// Trail
	// Refresh canvas by removing shifted tail
	ctx.fillStyle = backgroundColor;
	ctx.fillRect(0, 0, canvasWidth, canvasWidth);

	// Print the current Trail
	ctx.fillStyle = snakeColor;

	for (var i = 0; i < trail.length; i++) {
		ctx.fillRect((trail[i].x)*tileWidth, (trail[i].y)*tileHeight, rectWidth, rectHeight);

		// If tail cuts itself, reset to starting tail length
		if (trail[i].x == posX && trail[i].y == posY && hasStarted) {
			gameOver();
			//tailLen = startingTailLen;
		}
	}

	// Push the new position
	trail.push({x: posX, y: posY});

	// Keep the current tail length and shift the other ones
	while (trail.length > tailLen) {
		trail.shift();
	}

	// Food
	ctx.fillStyle = foodColor;
	ctx.fillRect(foodPosX*tileWidth, foodPosY*tileHeight, rectWidth, rectHeight);

	if (posX == foodPosX && posY == foodPosY) {
		tailLen++;
		score++;
		updateScores();
		generateRandomFoodPos();

	}	
} 


function wrapPosition() {
	if (posX < 0) {
		posX = tileCountHor-1;
	}
	else if (posX >= tileCountHor) {
		posX = 0;
	}

	if (posY < 0) {
		posY = tileCountVer-1;
	}
	else if (posY >= tileCountVer) {
		posY = 0;
	}
}


function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function generateRandomFoodPos() {
	foodPosX = getRandomInt(1, tileCountHor-1);
	foodPosY = getRandomInt(1, tileCountVer-1);
	//console.log("Food position: (" + foodPosX + "," + foodPosY + ")");

	var isValidFoodPos = false;
	var i;
	while (!isValidFoodPos) {
		for (i = 0; i < trail.length; i++) {
			if (foodPosX == trail[i].x && foodPosY == trail[i].y) {
				//console.log("Food position is on a tail. Regenerating position.");
				break;
			}
		}

		if (i == trail.length) {
			isValidFoodPos = true;
		}
		else {
			foodPosX = getRandomInt(1, tileCountHor-1);
			foodPosY = getRandomInt(1, tileCountVer-1);
		}
	}
	

	if (foodPosX == posX && foodPosY == posY) {
		generateRandomFoodPos();
	}
}

function updateScores() {
	scoreDiv.innerHTML     = "Score: " + score;
	highscoreDiv.innerHTML = "Highscore: " + highscore;
}


function gameOver() {
	tailLen = startingTailLen;
	if (score > highscore) {
		highscore = score;
		alert("Highscore!");
	}
	else {
		alert("What is inevitable in life other than death?");
	}
	score = 0;
	updateScores();
}

function keyPress(event) {
	if (!keyPressed) {
		//console.log("Keypress Detected");
		
		keyPressed = true;
		var pressedKey = event.keyCode;

		if (currentDir === undefined) {
			currentDir = pressedKey;
		}
		else {
			if (pressedKey == 37 && currentDir != 39) {
				velocityX = -1;
				velocityY = 0;
				currentDir = pressedKey;
				//console.log("Left Key Pressed");
			}
			else if (pressedKey == 38 && currentDir != 40) {
				velocityX = 0;
				velocityY = -1;
				currentDir = pressedKey;
				//console.log("Up Key Pressed");
			}
			else if (pressedKey == 39 && currentDir != 37) {
				velocityX = 1;
				velocityY = 0;
				currentDir = pressedKey;
				//console.log("Right Key Pressed");
			}
			else if (pressedKey == 40 && currentDir != 38) {
				velocityX = 0;
				velocityY = 1;
				currentDir = pressedKey;
				//console.log("Down Key Pressed");
			}
		}
		//console.log("Current direction: " + currentDir);

		setTimeout(function() { keyPressed = false;}, 70);	// To disable multiple keypress
	}
}




