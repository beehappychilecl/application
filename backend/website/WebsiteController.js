import express from 'express';

import JsonToolkit from '../toolkit/JsonToolkit.js';
import PropertiesToolkit from '../toolkit/PropertiesToolkit.js';
import RebuildController from '../rebuild/RebuildController.js';
import ScheduleModule from '../schedule/ScheduleModule.js';
import WebsiteModule from '../website/WebsiteModule.js';

class WebsiteController {

    async landing2 () {

        let result = {'fecha': 'hoy mismo probando'};

        let propertiesToolkit = new PropertiesToolkit ()

        let dollar = await propertiesToolkit.get ('scheduler.indicators.dollar');
        let token = await propertiesToolkit.get ('scheduler.indicators.token');

        dollar = dollar + new Date ().getFullYear ().toString ();

        let params = new JsonToolkit ();

        params.add ('apikey', token);
        params.add ('formato', 'json');

        let scheduleModule = new ScheduleModule ();

        await scheduleModule.dollarIndicator (dollar, params)

        return result;

    }

    async awake (request, response) {
    }

    async landing (request, response) {

        response.render ('pages/landing/landing.ejs', {'txt_version': '2.221110'});

    }

    async member (request, response) {

        let params = new JsonToolkit ();

        params.add ('txt_member', request.params.member);

        let websiteModule = new WebsiteModule ();

        await websiteModule.staff (params);

        console.log (request.params.member);
        response.render ('pages/landing/landing.ejs', {'txt_version': request.params.member});

    }

    async rebuild (request, response) {

        let rebuildController = new RebuildController ();

        await rebuildController.run ();

        console.log ('111');
        response.render ('pages/landing/landing.ejs', {'txt_version': 'rebuild'});
        console.log ('222');

    }

}

const router = express.Router ();

let websiteController = new WebsiteController ();

router.get ('/', await websiteController.landing);
router.get ('/staff/:member', await websiteController.member);
router.get ('/system/awake', await websiteController.awake);
router.get ('/system/rebuild', await websiteController.rebuild);

export default router;