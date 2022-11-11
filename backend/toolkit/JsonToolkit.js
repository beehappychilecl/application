class JsonToolkit {

    jsonObject;

    constructor () {

        this.jsonObject = {};

    }

    add (key, value) {

        this.jsonObject [key] = value;

    }

    get () {

        return this.jsonObject;

    }

}

export default JsonToolkit;