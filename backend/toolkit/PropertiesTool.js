import fs from 'fs';
import jsYaml from 'js-yaml';

class PropertiesTool {

    async get (property) {

        let yaml = jsYaml.load (fs.readFileSync ('./config.yml', 'utf8'), {});

        let array = property.split ('.');

        let result;

        for (let key of array) {

            if (!yaml || !Object.prototype.hasOwnProperty.call (yaml, key)) {

                return null;
            }

            result = yaml [key];

            yaml = yaml[key];

        }

        return result;

    }

}

export default PropertiesTool;