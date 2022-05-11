const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/

const verifierRegex = /contract Verifier/

let content = fs.readFileSync("./contracts/circuits/HelloWorldVerifier.sol", { encoding: 'utf-8' });
let bumped = content.replace(solidityRegex, 'pragma solidity ^0.8.0');
bumped = bumped.replace(verifierRegex, 'contract HelloWorldVerifier');
fs.writeFileSync("./contracts/circuits/HelloWorldVerifier.sol", bumped);

let content2 = fs.readFileSync("./contracts/circuits/Multiplier3Verifier.sol", { encoding: 'utf-8'});
let bumped2 = content2.replace(solidityRegex, 'pragma solidity ^0.8.0');
bumped2 = bumped2.replace(verifierRegex, 'contract Multiplier3Verifier');
fs.writeFileSync("./contracts/circuits/Multiplier3Verifier.sol", bumped2);
