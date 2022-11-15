import DatabaseToolkit from '../toolkit/DatabaseToolkit.js';
import TraceToolkit from "../toolkit/TraceToolkit.js";

class WebsiteModule {

    async awake (params) {

        let databaseToolkit = new DatabaseToolkit ();

        let result = await databaseToolkit.run ('website_get_landing_page', params);

        return result;

    }

    async landing (params) {

        let traceToolkit = new TraceToolkit (traceToolkit);

        await traceToolkit.initialize ();

        let databaseToolkit = new DatabaseToolkit ();

        let result = await databaseToolkit.run ('website_get_landing_page', params);

        return result;

    }

    async mailing (params) {

        let databaseToolkit = new DatabaseToolkit ();

        let result = await databaseToolkit.run ('website_get_mailing_page', params);

        return result;

    }

    async staff (params) {

        let databaseToolkit = new DatabaseToolkit ();

        let result = await databaseToolkit.run ('website_get_name_information', params);

        return result;

    }

    async vcard (params) {

        let databaseToolkit = new DatabaseToolkit ();

        let result = await databaseToolkit.run ('website_get_vcard_information', params);

        return result;

    }

}

export default WebsiteModule;