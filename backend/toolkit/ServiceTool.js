import axios from 'axios';

import JsonTool from '../toolkit/JsonTool.js';
import LogTool from "../toolkit/LogTool.js";
import ResponseTool from '../toolkit/ResponseTool.js';

class ServiceTool {

    async get (traceTool, host, headers, params) {

        let logTool = new LogTool ('ServiceTool', 'get', traceTool);

        await logTool.initialize ();

        let config = new JsonTool ();

        if (headers) {

            config.add ("headers", headers.all ());

        }

        if (params) {

            config.add ("params", params.all ());

        }

        let suffix;

        if (config.all () === '{}') {

            suffix = null;

        } else {

            suffix = config.all ();

        }

        let result;

        try {

            result = await axios.get (host, suffix);
            result = result.data;

        } catch (error) {

            result = ResponseTool.SERVICE_EXCEPTION ();

        }

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async post (traceTool, host, headers, params) {

        let logTool = new LogTool ('ServiceTool', 'post', traceTool);

        await logTool.initialize ();

        let prefix;

        if (params) {

            prefix = params;

        }

        let suffix = new JsonTool ();

        if (headers) {

            suffix.add ("headers", headers.get ());

        }

        let result;

        try {

            result = await axios.post (host, prefix.get (), suffix.all ());
            result = result.data;

        } catch (error) {

            result = ResponseTool.SERVICE_EXCEPTION ();

        }

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

}

export default ServiceTool;