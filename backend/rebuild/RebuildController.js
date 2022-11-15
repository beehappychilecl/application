import fs from 'fs';

import DatabaseToolkit from '../toolkit/DatabaseToolkit.js';
import TraceToolkit from '../toolkit/TraceToolkit.js';

class RebuildController {

    path = './scripts';

    async run () {

        let traceToolkit = new TraceToolkit ();

        await this.readFile (this.path + '/setup.txt');
        await this.readFile (this.path + '/constants.txt');
        await this.readFile (this.path + '/indicators.txt');
        await this.readFile (this.path + '/organization.txt');
        await this.readFile (this.path + '/website.txt');

    }

    async readFile (file) {

        let traceToolkit = new TraceToolkit ();

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

        let traceToolkit = new TraceToolkit ();

        let content = fs.readFileSync (line, 'utf8');

        let databaseToolkit = new DatabaseToolkit ();

        let result = await databaseToolkit.exe (line, content);

        console.log (result);

    }

}

export default RebuildController;