declare module 'playwright-core/lib/server' {
  export interface Executable {
    type: 'browser' | string;
    name: string;
    downloadURLs: string[];
    executablePath: () => string;
  }

  export class Registry {
    constructor(browsersJson: object);

    executables(): Executable[];
  }
}
