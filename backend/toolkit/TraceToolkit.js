import crypto from 'crypto';
import errorStackParser from "error-stack-parser";

import JsonToolkit from '../toolkit/JsonToolkit.js';

class TraceToolkit {

    jsonToolkit;

    constructor (jsonToolkit) {

        this.jsonToolkit = new JsonToolkit ();

        if (!jsonToolkit) {

            this.jsonToolkit.add ('level', 1);
            this.jsonToolkit.add ('thread', crypto.randomUUID ());

        } else {

            this.jsonToolkit.add ('level', jsonToolkit.get ('level') + 1);
            this.jsonToolkit.add ('thread', jsonToolkit.get ('thread'));

        }

        this.jsonToolkit.add ('offset', crypto.randomUUID ());

        let stackTrace = errorStackParser.parse (new Error ());

        let stackLine = stackTrace[1].functionName.split ('.');

        this.jsonToolkit.add ('class', stackLine[0]);
        this.jsonToolkit.add ('method', stackLine[1]);

    }

    async initialize () {

        this.jsonToolkit.add ('initial', new Date ());

    }

    async finalize () {

        this.jsonToolkit.add ('final', new Date ());

        let runtime = (this.jsonToolkit.get ('final') - this.jsonToolkit.get ('initial')) / 1000;

        this.jsonToolkit.add ('runtime', runtime);

    }

    async set (thread) {

        let jsonToolkit = new JsonToolkit ();

        if (!thread) {

            jsonToolkit.add ('thread', crypto.randomUUID ());

        }

        jsonToolkit.add ('offset', crypto.randomUUID ());

        return jsonToolkit;

    }

}

export default TraceToolkit;