import {Unity, useUnityContext} from "react-unity-webgl";

function Game4() {
    const { unityProvider } = useUnityContext({
        loaderUrl: "/Builds.loader.js",
        dataUrl: "/Builds.data",
        frameworkUrl: "/Builds.framework.js",
        codeUrl: "/Builds.wasm",
    });



    return (
        <>
            <div className="centered-container">
                <div className="centered-content">
                    <h1 className="centered-title">React + Unity / Tecsup</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />


                </div>
            </div>

        </>
    );
}


export default Game4