import express from 'express';

import JsonToolkit from '../toolkit/JsonToolkit.js';
import RebuildController from '../rebuild/RebuildController.js';
import TraceToolkit from '../toolkit/TraceToolkit.js';
import WebsiteModule from '../website/WebsiteModule.js';

class WebsiteController {

    async awake (request, response) {

        let traceToolkit = new TraceToolkit ();

        await traceToolkit.initialize ();

        let params = new JsonToolkit ();

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.awake (params);

        response.render ('pages/landing/landing.ejs', result.outgoing);

        await traceToolkit.finalize ();

    }

    async landing (request, response) {

        //console.log (request.headers['user-agent']);

        let traceToolkit = new TraceToolkit ();

        await traceToolkit.initialize ();

        let params = new JsonToolkit ();

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.landing (params);

        response.render ('pages/landing/landing.ejs', result.outgoing);

        await traceToolkit.finalize ();

    }

    async mailing (request, response) {

        console.log (request.headers['user-agent']);

        let traceToolkit = new TraceToolkit ();

        await traceToolkit.initialize ();

        let params = new JsonToolkit ();

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.mailing (params);

        response.render ('pages/mailing/mailing.ejs', result.outgoing);

        await traceToolkit.finalize ();

    }

    async rebuild (request, response) {

        let traceToolkit = new TraceToolkit ();

        await traceToolkit.initialize ();

        let rebuildController = new RebuildController ();

        await rebuildController.run ();

        console.log ('111');
        response.render ('pages/landing/landing.ejs', {'txt_version': 'rebuild'});
        console.log ('222');

        await traceToolkit.finalize ();

    }

    async staff (request, response) {

        let params = new JsonToolkit ();

        params.add ('txt_first_name', request.params.txt_first_name);

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.staff (params);

        response.render ('pages/staff/staff.ejs', result.outgoing);

    }

    async vcard (request, response) {

        let params = new JsonToolkit ();

        params.add ('txt_first_name', request.params.txt_first_name);

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.vcard (params);

        response.setHeader ('content-type', 'text/x-vcard');
        response.send (result.outgoing.txt_vcard);

        console.log (result.outgoing.txt_vcard)

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