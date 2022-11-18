import express from 'express';

import JsonTool from '../toolkit/JsonTool.js';
import LogTool from '../toolkit/LogTool.js';
import RebuildController from '../rebuild/RebuildController.js';
import WebsiteModule from '../website/WebsiteModule.js';
import TraceTool from "../toolkit/TraceTool.js";

import ServiceTool from '../toolkit/ServiceTool.js';
import PropertiesTool from "../toolkit/PropertiesTool.js";

class WebsiteController {

    async awake (request, response) {

        let traceTool = null;

        if (Object.keys (request.query).length !== 0) {

            traceTool = new TraceTool ();

            traceTool.level = parseInt (request.query.level) + 1;
            traceTool.thread = request.query.thread;

        }

        let logTool = new LogTool ('WebsiteController', 'awake', traceTool);

        await logTool.initialize ();
        await logTool.utilize (request);

        let params = new JsonTool ();

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.awake (logTool.traceTool, params);

        await logTool.realize (result);
        await logTool.finalize ();

        response.send (result);

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

        let logTool = new LogTool ('WebsiteController', 'mailing', null);

        await logTool.initialize ();
        await logTool.utilize (request);

        let params = new JsonTool ();

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.mailing (logTool.traceTool, params);

        response.render ('pages/mailing/mailing.ejs', result.outgoing);

        await logTool.realize (result);
        await logTool.finalize ();

    }

    async rebuild (request, response) {

        let logTool = new LogTool ('WebsiteController', 'rebuild', null);

        await logTool.initialize ();
        await logTool.utilize (request);

        let rebuildController = new RebuildController ();

        let result = await rebuildController.run ();

        response.render ('pages/landing/landing.ejs', {'txt_version': 'rebuild'});

        await logTool.realize (result);
        await logTool.finalize ();

    }

    async staff (request, response) {

        let logTool = new LogTool ('WebsiteController', 'staff', null);

        await logTool.initialize ();
        await logTool.utilize (request);

        let params = new JsonTool ();

        params.add ('txt_first_name', request.params.txt_first_name);

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.staff (logTool.traceTool, params);

        response.render ('pages/staff/staff.ejs', result.outgoing);

        await logTool.realize (result);
        await logTool.finalize ();

    }

    async test (request, response) {

        let propertiesTool = new PropertiesTool ();

        let headers = new JsonTool ();
        headers.add ('content-type', 'application/json');

        let host = await propertiesTool.get ('discord.beebee.notifications');

        let params = new JsonTool ();

        params.add ('embeds', [
            {
                "title": "Prueba de BeeBee®",
                "description": "*Hola!* @everyone **Wow!** I can __use__ hyperlinks [here](https://discord.com)."+ String.fromCharCode(10) +"Correo: [*+56 9 7800-8001*](mailto:cuentapahotmail@gmail.com)"+ String.fromCharCode(10) +"Telefono: [*+56 9 7800-8001*](https://api.whatsapp.com/send?phone=56991220195)",
                "color": "16761095"
            }
        ]);

        let result = null;

        let serviceTool = new ServiceTool ();

        try {

            result = await serviceTool.post (null, host, headers, params);
            console.log (result);

        } catch (error) {

            console.log (error);

        }

        host = await propertiesTool.get ('discord.beejay.notifications');

        params = new JsonTool ();

        params.add ('embeds', [
            {
                "title": "Prueba de BeeJay®",
                "description": "*Hola!* @everyone **Wow!** I can __use__ hyperlinks [here](https://discord.com)."+ String.fromCharCode(10) +"Correo: [*+56 9 7800-8001*](mailto:cuentapahotmail@gmail.com)"+ String.fromCharCode(10) +"Telefono: [*+56 9 7800-8001*](https://api.whatsapp.com/send?phone=56991220195)",
                "color": "16761095"
            }
        ]);

        result = null;

        try {

            result = await serviceTool.post (null, host, headers, params);
            console.log (result);

        } catch (error) {

            console.log (error);

        }

        let aaa = {};
        response.send (aaa);

    }

    async vcard (request, response) {

        let logTool = new LogTool ('WebsiteController', 'vcard', null);

        await logTool.initialize ();
        await logTool.utilize (request);

        let params = new JsonTool ();

        params.add ('txt_first_name', request.params.txt_first_name);

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.vcard (logTool.traceTool, params);

        response.setHeader ('content-type', 'text/x-vcard');
        response.send (result.outgoing.txt_vcard);

        await logTool.realize (result);
        await logTool.finalize ();

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
router.get ('/test', await websiteController.test);

export default router;