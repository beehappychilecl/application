import axios from 'axios';

import JsonTool from './JsonTool.js';
import ResponseTool from './ResponseTool.js';

class ServiceTool {

    async get (host, headers, params) {

        let config = new JsonTool ();

        if (headers) {

            config.add ("headers", headers.get ());

        }

        if (params) {

            config.add ("params", params.get ());

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

        return result;

    }

    async post (host, headers, params) {

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
console.log(error);
            result = ResponseTool.SERVICE_EXCEPTION ();

        }

        return result;

    }

}

export default ServiceTool;