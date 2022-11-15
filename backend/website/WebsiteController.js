import express from 'express';

import JsonTool from '../toolkit/JsonTool.js';
import RebuildController from '../rebuild/RebuildController.js';
import LogTool from '../toolkit/LogTool.js';
import WebsiteModule from '../website/WebsiteModule.js';

class WebsiteController {

    async awake (request, response) {

        let traceTool = new LogTool ();

        await traceTool.initialize ();
        await traceTool.utilize (request);
        console.log('2');

        let params = new JsonTool ();

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.awake (traceTool, params);

        response.render ('pages/landing/landing.ejs', result.outgoing);

        await traceTool.realize (result);
        await traceTool.finalize ();

    }

    async landing (request, response) {

        let logTool = new LogTool ('WebsiteController', 'landing', null);

        await logTool.initialize ();
        await logTool.utilize (request);

        let params = new JsonTool ();

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.landing (logTool.traceTool, params);

        response.render ('pages/landing/landing.ejs', result.outgoing);

        await logTool.realize (result);
        await logTool.finalize ();

    }

    async mailing (request, response) {

        let traceTool = new LogTool ();

        await traceTool.initialize ();
        await traceTool.utilize (request);

        let params = new JsonTool ();

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.mailing (traceTool, params);

        response.render ('pages/mailing/mailing.ejs', result.outgoing);

        await traceTool.finalize ();

    }

    async rebuild (request, response) {

        let traceTool = new LogTool ();

        await traceTool.initialize ();
        await traceTool.utilize (request);

        let rebuildController = new RebuildController ();

        await rebuildController.run ();

        console.log ('111');
        response.render ('pages/landing/landing.ejs', {'txt_version': 'rebuild'});
        console.log ('222');

        await traceTool.finalize ();

    }

    async staff (request, response) {

        let traceTool = new LogTool ();

        await traceTool.initialize ();
        await traceTool.utilize (request);

        let params = new JsonTool ();

        params.add ('txt_first_name', request.params.txt_first_name);

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.staff (traceTool, params);

        response.render ('pages/staff/staff.ejs', result.outgoing);

    }

    async vcard (request, response) {

        let params = new JsonTool ();

        params.add ('txt_first_name', request.params.txt_first_name);

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.vcard (traceTool, params);

        response.setHeader ('content-type', 'text/x-vcard');
        response.send (result.outgoing.txt_vcard);

    }

}

const router = express.Router ();

let websiteController = new WebsiteController ();

router.get ('/', await websiteController.landing);
router.get ('/landing', await websiteController.landing);
router.get ('/mailing', await websiteController.mailing);
router.get ('/staff/:txt_first_name', await websiteController.staff);
router.get ('/staff/:txt_first_name/vcard', await websiteController.vcard);
router.get ('/system/awake', await websiteController.awake);
router.get ('/system/rebuild', await websiteController.rebuild);

export default router;