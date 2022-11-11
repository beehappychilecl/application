class ResponseToolkit {

    static DATABASE_EXCEPTION () {

        let jsonObject = {};

        jsonObject ['message'] = 'Database Exception';
        jsonObject ['status'] = 200;

        return jsonObject;

    }

    static DOCUMENT_EXCEPTION () {

        let jsonObject = {};

        jsonObject ['message'] = 'Document Exception';
        jsonObject ['status'] = 300;

        return jsonObject;

    }

    static SERVICE_EXCEPTION () {

        let jsonObject = {};

        jsonObject ['message'] = 'Service Exception';
        jsonObject ['status'] = 100;

        return jsonObject;

    }

    static SUCCESSFUL () {

        let jsonObject = {};

        jsonObject ['message'] = 'OK';
        jsonObject ['status'] = 0;

        return jsonObject;

    }

    static WORKFLOW_EXCEPTION (aClass, aMethod) {

        let jsonObject = {};

        jsonObject ['message'] = 'Workflow Exception: ' + aClass + '.' + aMethod;
        jsonObject ['status'] = 900;

        return jsonObject;

    }

    static REBUILD_FAILED (line) {

        let jsonObject = {};

        jsonObject ['status'] = 'FAILURE';
        jsonObject ['file'] = line;

        return jsonObject;

    }

    static REBUILD_SUCCESSFUL (line) {

        let jsonObject = {};

        jsonObject ['status'] = 'SUCCESS';
        jsonObject ['file'] = line;

        return jsonObject;

    }

}

export default ResponseToolkit;