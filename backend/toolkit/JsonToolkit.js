class JsonToolkit {

    jsonObject;

    constructor () {

        this.jsonObject = {};

    }

    add (key, value) {

        this.jsonObject [key] = value;

    }

    all () {

        return this.jsonObject;

    }

    get (key) {

        return this.jsonObject[key];

    }

}

export default JsonToolkit;