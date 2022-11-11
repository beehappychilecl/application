import fs from 'fs';

import DatabaseToolkit from "../toolkit/DatabaseToolkit.js";

class RebuildController {

    path = './scripts';

    async run () {

        await this.readFile (this.path + '/setup.txt');
        await this.readFile (this.path + '/constants.txt');
        await this.readFile (this.path + '/indicators.txt');

    }

    async readFile (file) {

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

        let content = fs.readFileSync (line, 'utf8');

        let databaseToolkit = new DatabaseToolkit ();

        let result = await databaseToolkit.exe (line, content);

        console.log (result);

    }

}

export default RebuildController;