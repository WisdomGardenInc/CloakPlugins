import { getLogger } from '@wisdomgarden/cloak';

export const PLUGIN_NAME = 'Jpush'

export const LOG_DOMAIN = 0xC001;

export const LOG_TAG = `CloakPlugin${PLUGIN_NAME}`;

export default getLogger(LOG_DOMAIN, LOG_TAG);