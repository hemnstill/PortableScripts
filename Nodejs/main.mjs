import process from 'process';
import { hello } from "./foo.js"

console.log(hello(process.argv.slice(2)))

process.exitCode = 42