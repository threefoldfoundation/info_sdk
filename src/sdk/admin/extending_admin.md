

### Frontend

The frontend is written in webix, and located at `frontend_src`, the build is at `frontend`

#### To rebuild frontend

- `cd frontend_src`
- `bash build_frontend.sh`


#### Including other packages in the admin panel

If u want to add another view "menu" item to include another package in the admin view. It's very easy using

```python
import { ExternalView } from ".external";

const CODE_URL = "/codeserver/?folder=/sandbox/code";
const REQUIRED_PACKAGES = {
    "zerobot.codeserver": "https://github.com/threefoldtech/jumpscaleX_threebot/tree/development/ThreeBotPackages/zerobot/codeserver"
}

export default class CodeserverView extends ExternalView {
    constructor(app, name) {
        super(app, name, CODE_URL, REQUIRED_PACKAGES);
    }
}

```
- Make sure to pass the url of the remote view -in our example its `CODE_URL`-
- If it requires packages to be installed first you define them in `REQUIRED_PACKAGES` 
- Just extend `ExternalView` and pass the remote view url `CODE_URL` and required packages `REQUIRED_PACKGGES` to the super
- update `main.js` sidebarData with your view 

