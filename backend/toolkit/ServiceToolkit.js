import axios from 'axios';

import JsonToolkit from '../toolkit/JsonToolkit.js';
import ResponseToolkit from '../toolkit/ResponseToolkit.js';

class ServiceToolkit {

    async get (host, headers, params) {

        let config = new JsonToolkit ();

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

            result = ResponseToolkit.SERVICE_EXCEPTION ();

        }

        return result;

    }

    async post (host, headers, params) {

        let prefix;

        if (params) {

            prefix = params;

        }

        let suffix = new JsonToolkit ();

        if (headers) {

            suffix.add ("headers", headers.get ());

        }

        let result;

        try {

            result = await axios.post (host, prefix.get (), suffix.all ());
            result = result.data;

        } catch (error) {

            result = ResponseToolkit.SERVICE_EXCEPTION ();

        }

        return result;

    }

}

export default ServiceToolkit;