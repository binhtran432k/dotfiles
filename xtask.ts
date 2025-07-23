import { promises as fsPromises } from "node:fs";
import { initWasm as initResvgWasm, Resvg, type ResvgRenderOptions } from "@resvg/resvg-wasm";
import optimisePng, { init as initOxipngWasm } from "@jsquash/oxipng/optimise.js";
import { parseArgs } from "node:util";

const processPng =
  async (imgBuffer: Buffer, opts: ResvgRenderOptions): Promise<Uint8Array> =>
    new Uint8Array(await optimisePng((new Resvg(imgBuffer, opts))
      .render().asPng()));

const build = async () => {
  await initResvgWasm(
    fsPromises.readFile(
      new URL("./node_modules/@resvg/resvg-wasm/index_bg.wasm", import.meta.url)));
  await initOxipngWasm(
    await fsPromises.readFile(
      new URL("./node_modules/@jsquash/oxipng/codec/pkg/squoosh_oxipng_bg.wasm",
        import.meta.url)))

  await fsPromises.writeFile(
    new URL("./assets/avatar_gear.png", import.meta.url), await processPng(
      await fsPromises
        .readFile(new URL("./assets/avatar_gear.svg", import.meta.url)),
      { fitTo: { mode: 'width', value: 512 } }));
  await fsPromises.writeFile(
    new URL("./assets/background.png", import.meta.url), await processPng(
      await fsPromises
        .readFile(new URL("./assets/background.svg", import.meta.url)),
      { fitTo: { mode: 'width', value: 2560 } }));
  await fsPromises.writeFile(
    new URL("./assets/background_mobile.png", import.meta.url), await processPng(
      await fsPromises
        .readFile(new URL("./assets/background_mobile.svg", import.meta.url)),
      { fitTo: { mode: 'width', value: 1080 } }));
}


const main = async () => {
  const { values } = parseArgs({
    args: process.argv.slice(2),
    options: {
      build: {
        type: "boolean",
        short: "b"
      }
    }
  });
  if (values.build) {
    return await build();
  }
}

main()
