const fs = require('node:fs');
let answerB = 0;
try {
    const input = fs.readFileSync('data.txt', 'utf8').replaceAll("\r","");
    const lines = input.split("\n");
    lines.forEach((line) => {
        const firstDigitText = line.match(/(\d|one|two|three|four|five|six|seven|eight|nine)/);
        const firstDigitInt = textToInt(firstDigitText[1]);
        const lastDigitText = line.match(/.*(\d|one|two|three|four|five|six|seven|eight|nine).*/);
        const lastDigitInt = textToInt(lastDigitText[1]);
        let lineScore = (10 * firstDigitInt) + (1 * lastDigitInt);
        //console.log(line, firstDigitText, firstDigitInt, lastDigitText, lastDigitInt, lineScore);
        fs.appendFileSync("test.csv",`${line};${lineScore}\n`);
        console.log(lineScore);
        answerB += lineScore;
    });
}
catch(e) {
    console.error(e);
}

function textToInt(x) {
    switch(x) {
        case 'one':
            return 1;
        case 'two':
            return 2;
        case 'three':
            return 3;
        case 'four':
            return 4;
        case 'five':
            return 5;
        case 'six':
            return 6;
        case 'seven':
            return 7;
        case 'eight':
            return 8;
        case 'nine':
            return 9;
        default:
            return x * 1;
    }
}

console.log("The answer to part 2 is:", answerB);