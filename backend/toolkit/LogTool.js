import crypto from 'crypto';

import DocumentTool from "../toolkit/DocumentTool.js";
import TraceTool from '../toolkit/TraceTool.js';

class LogTool {

    traceTool;

    get traceTool () {

        return this.traceTool;

    }

    constructor (aClass, aMethod, traceTool) {

        this.traceTool = new TraceTool ();

        if (traceTool === null) {

            this.traceTool.level = 1;
            this.traceTool.thread = crypto.randomUUID ();

        } else {

            this.traceTool.level = parseInt (traceTool.level) + 1;
            this.traceTool.thread = traceTool.thread;

        }

        this.traceTool.class = aClass;
        this.traceTool.method = aMethod;
        this.traceTool.offset = crypto.randomUUID ();

    }

    async finalize (caption) {

        this.traceTool.ending = new Date ();
        this.traceTool.runtime = ((this.traceTool.ending - this.traceTool.starting) / 1000).toFixed (3);

        let documentTool = new DocumentTool ();

        await documentTool.insert (this.traceTool);

        let message = '';
        message = message + this.traceTool.thread + ' [';
        message = message + this.traceTool.runtime + '] [';
        message = message + this.traceTool.level + '] ';
        message = message + this.traceTool.class + '.';
        message = message + this.traceTool.method;

        if (caption) {

            message = message + ' - ' + caption;

        }

        console.log (message);

    }

    async initialize () {

        this.traceTool.starting = new Date ();

    }

    async realize (result) {

        if (result.incoming) {

            delete result.incoming['_locals'];

            this.traceTool.incoming = result.incoming;

        }

        if (result.outgoing) {

            delete result.outgoing['_locals'];

            this.traceTool.outgoing = result.outgoing;

        }

        if (result.status) {

            delete result.status['_locals'];

            this.traceTool.status = result.status;

        }

    }

    async utilize (request) {

        this.traceTool.agent = request.headers['user-agent'];

    }

}

export default LogTool;