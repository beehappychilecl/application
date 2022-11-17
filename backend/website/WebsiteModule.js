import DatabaseTool from '../toolkit/DatabaseTool.js';
import LogTool from "../toolkit/LogTool.js";

class WebsiteModule {

    async awake (traceTool, params) {

        let logTool = new LogTool ('WebsiteModule', 'awake', traceTool);

        await logTool.initialize ();

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run (logTool.traceTool, 'website_get_awake_page', params);

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async landing (traceTool, params) {

        let logTool = new LogTool ('WebsiteModule', 'landing', traceTool);

        await logTool.initialize ();

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run (logTool.traceTool, 'website_get_landing_page', params);

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async mailing (traceTool, params) {

        let logTool = new LogTool ('WebsiteModule', 'landing', traceTool);

        await logTool.initialize ();

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run (logTool.traceTool, 'website_get_mailing_page', params);

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async staff (traceTool, params) {

        let logTool = new LogTool ('WebsiteModule', 'landing', traceTool);

        await logTool.initialize ();

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run (logTool.traceTool, 'website_get_name_information', params);

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

    async vcard (traceTool, params) {

        let logTool = new LogTool ('WebsiteModule', 'landing', traceTool);

        await logTool.initialize ();

        let databaseTool = new DatabaseTool ();

        let result = await databaseTool.run (logTool.traceTool, 'website_get_vcard_information', params);

        await logTool.realize (result);
        await logTool.finalize ();

        return result;

    }

}

export default WebsiteModule;