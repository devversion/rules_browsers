import path from 'node:path';
import {Piscina} from 'piscina';
import {Platform} from './browsers.mjs';
import type {SerializableExecutable} from './playwright-download-worker.mjs';

// Taken from:
// https://github.com/microsoft/playwright/blob/5fce12dcca2ef518bbb91292b5d8e4989097a0ed/packages/playwright-core/src/server/utils/hostPlatform.ts#L21-L36
type HostPlatform =
  | 'win64'
  | 'mac10.13'
  | 'mac10.14'
  | 'mac10.15'
  | 'mac11'
  | 'mac11-arm64'
  | 'mac12'
  | 'mac12-arm64'
  | 'mac13'
  | 'mac13-arm64'
  | 'mac14'
  | 'mac14-arm64'
  | 'mac15'
  | 'mac15-arm64'
  | 'ubuntu18.04-x64'
  | 'ubuntu18.04-arm64'
  | 'ubuntu20.04-x64'
  | 'ubuntu20.04-arm64'
  | 'ubuntu22.04-x64'
  | 'ubuntu22.04-arm64'
  | 'ubuntu24.04-x64'
  | 'ubuntu24.04-arm64'
  | 'debian11-x64'
  | 'debian11-arm64'
  | 'debian12-x64'
  | 'debian12-arm64'
  | '<unknown>';

export interface PlatformDownloads {
  platform: Platform;
  executables: SerializableExecutable[];
}

export async function getDownloadUrlsForPlatform(
  platform: Platform,
  nodeProcessPlatformToFake: string
): Promise<PlatformDownloads> {
  let hostPlatform: HostPlatform;
  if (platform === Platform.LINUX64) {
    hostPlatform = 'debian12-x64';
  } else if (platform === Platform.MAC64) {
    hostPlatform = 'mac15';
  } else if (platform === Platform.MACARM) {
    hostPlatform = 'mac15-arm64';
  } else {
    throw new Error('Unexpected platform');
  }

  const worker = new Piscina({
    filename: path.join(import.meta.dirname, './playwright-download-worker.mjs'),
    env: {
      PLAYWRIGHT_HOST_PLATFORM_OVERRIDE: hostPlatform,
      PLAYWRIGHT_BROWSERS_PATH: '/tmp/',
    },
  });

  const executables: SerializableExecutable[] = await worker.run(nodeProcessPlatformToFake);

  return {
    platform,
    executables: executables.map(e => ({
      ...e,
      // Slice of `/tmp/<browser-dir>/` to get to an actual relative executable path.
      executablePath: e.executablePath.split('/').slice(3).join('/'),
    })),
  };
}
