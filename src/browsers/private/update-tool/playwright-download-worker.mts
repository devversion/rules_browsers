import path from 'node:path';
import fs from 'node:fs/promises';

export interface SerializableExecutable {
  type: 'browser' | string;
  name: string;
  downloadURLs: string[];
  executablePath: string;
}

export default async (nodeProcessPlatform: string): Promise<SerializableExecutable[]> => {
  Object.defineProperty(process, 'platform', {value: nodeProcessPlatform});

  const {Registry} = await import('playwright-core/lib/server');
  const browsersPath = path.join(
    import.meta.dirname,
    '../../../../node_modules/playwright-core/browsers.json'
  );
  const browserUrls = JSON.parse(await fs.readFile(browsersPath, 'utf8'));
  const registry = new Registry(browserUrls);
  const result: SerializableExecutable[] = registry
    .executables()
    .filter(e => e.type === 'browser' && (e.name === 'chromium' || e.name === 'firefox'))
    .map(e => ({
      executablePath: e.executablePath(),
      downloadURLs: e.downloadURLs,
      name: e.name,
      type: e.type,
    }));

  return result;
};
