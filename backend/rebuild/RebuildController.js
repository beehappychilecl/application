import fs from 'fs';

import DatabaseTool from '../toolkit/DatabaseTool.js';
import LogTool from '../toolkit/LogTool.js';

class RebuildController {

    path = './scripts';

    async run () {

        let traceTool = new LogTool ();

        await this.readFile (this.path + '/setup.txt');
        await this.readFile (this.path + '/constants.txt');
        await this.readFile (this.path + '/indicators.txt');
        await this.readFile (this.path + '/organization.txt');
        await this.readFile (this.path + '/website.txt');

    }

    async readFile (file) {

        let traceTool = new LogTool ();

        let content = fs.readFileSync (file, 'utf8');

        let lines = content.split (/\r?\n/);

        for (let offset = 0; offset < lines.length; offset++) {

            let line = lines[offset].trim ();

            if (line.startsWith ('/*') || line.startsWith ('--') || line === '') {

                continue;

            }

            await this.readLine (this.path + '/' + line);

        }

    }

    async readLine (line) {

        let traceTool = new LogTool ();

        let content = fs.readFileSync (line, 'utf8');

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.exe (line, content);

        console.log (result);

    }

}

export default RebuildController;