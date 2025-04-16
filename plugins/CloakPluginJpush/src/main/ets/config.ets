import { getLogger } from '@wisdomgarden/cloak';

export const PLUGIN_NAME = 'Jpush'

export const LOG_DOMAIN = 0xC001;

export const LOG_TAG = `CloakPlugin${PLUGIN_NAME}`;

// todo: export ILogger at framework 1.0.6 then delete this interface
interface ILogger {
  debug: (format: string, ...args: (string | number | boolean)[]) => void;
  info: (format: string, ...args: (string | number | boolean)[]) => void;
  warn: (format: string, ...args: (string | number | boolean)[]) => void;
  error: (format: string, ...args: (string | number | boolean)[]) => void;
  fatal: (format: string, ...args: (string | number | boolean)[]) => void;
}

export default getLogger(LOG_DOMAIN, LOG_TAG) as ILogger;