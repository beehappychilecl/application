import DatabaseTool from '../toolkit/DatabaseTool.js';
import LogTool from "../toolkit/LogTool.js";

class WebsiteModule {

    async awake (traceTool, params) {

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run ('website_get_landing_page', params);

        return result;

    }

    async landing (traceTool, params) {

        let logTool = new LogTool ('WebsiteModule', 'landing', traceTool);

        await logTool.initialize ();

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run ('website_get_landing_page', params);

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async mailing (params) {

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run ('website_get_mailing_page', params);

        return result;

    }

    async staff (params) {

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run ('website_get_name_information', params);

        return result;

    }

    async vcard (params) {

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run ('website_get_vcard_information', params);

        return result;

    }

}

export default WebsiteModule;