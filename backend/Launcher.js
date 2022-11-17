import ejs from 'ejs';
import express from 'express';

import LogTool from './toolkit/LogTool.js';
import PropertiesTool from './toolkit/PropertiesTool.js'
import ResponseTool from "./toolkit/ResponseTool.js";
import ScheduleController from './schedule/ScheduleController.js';
import WebsiteController from './website/WebsiteController.js';

class Launcher {

    async run () {

        let logTool = new LogTool ('Launcher', 'run', null);

        await logTool.initialize ();

        let app = express ();

        app.set ('view engine', ejs);
        app.use (express.json ())
        app.use (express.static ('frontend'));
        app.use (express.urlencoded ({extended: true}));
        app.use (ScheduleController);
        app.use (WebsiteController);

        let propertiesTool = new PropertiesTool ();

        let property = await propertiesTool.get ('server.port');
        property = process.env.PORT || property;

        app.listen (property);

        let result = ResponseTool.SUCCESSFUL ();

        await logTool.realize (result);
        await logTool.finalize ('BeeHappy started on port ' + property.toString ());

    }

}

let launcher = new Launcher ();

await launcher.run ();