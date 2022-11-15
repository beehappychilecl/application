import crypto from 'crypto';

import DocumentTool from "../toolkit/DocumentTool.js";
import TraceTool from '../toolkit/TraceTool.js';

class LogTool {

    traceTool;

    get traceTool () {

        return this.traceTool;

    }

    constructor (aClass, aMethod, traceTool) {

        this.traceTool = new TraceTool (null);

        if (traceTool === null) {

            this.traceTool.level = 1;
            this.traceTool.thread = crypto.randomUUID ();

        } else {

            this.traceTool.level = traceTool.level + 1;
            this.traceTool.thread = traceTool.thread;

        }

        this.traceTool.aClass = aClass;
        this.traceTool.aMethod = aMethod;
        this.traceTool.offset = crypto.randomUUID ();

    }

    async finalize () {

        this.traceTool.final = new Date ();
        this.traceTool.runtime = (this.traceTool.final - this.traceTool.initial) / 1000;

        let documentTool = new DocumentTool ();

        //await documentTool.insert (this.traceTool);

    }

    async initialize () {

        this.traceTool.initial = new Date ();

    }

    async realize (result) {

        delete result.incoming['_locals'];
        delete result.outgoing['_locals'];
        delete result.status['_locals'];

        this.traceTool.incoming = result.incoming;
        this.traceTool.outgoing = result.outgoing;
        this.traceTool.status = result.status;

    }

    async utilize (request) {

        this.traceTool.agent = request.headers['user-agent'];

    }

}

export default LogTool;