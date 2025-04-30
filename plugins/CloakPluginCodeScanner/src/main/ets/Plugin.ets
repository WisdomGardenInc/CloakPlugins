import { CloakPlugin, PluginMethod, getLogger } from '@wisdomgarden/cloak';
import { BusinessError } from '@ohos.base';
import BuildProfile from '../../../BuildProfile';
import { scanCore, scanBarcode } from '@kit.ScanKit';

const logger = getLogger(0xC002, 'CodeScanner');

interface ScanResult {
  error?: Error;
  result?: scanBarcode.ScanResult;
}

export default class CodeScanner extends CloakPlugin {
  protected _name = "CodeScanner";
  protected _version = BuildProfile.HAR_VERSION;
  private scanTypes = [scanCore.ScanType.QR_CODE];

  @PluginMethod()
  setScanTypes(scanTypes?: scanCore.ScanType[]) {
    if (scanTypes?.length && Array.isArray(scanTypes)) {
      this.scanTypes = scanTypes;
    }
  }


  @PluginMethod()
  async scan(scanTypes?: scanCore.ScanType[]): Promise<ScanResult> {
    this.setScanTypes(scanTypes)

    const options: scanBarcode.ScanOptions = {
      scanTypes: this.scanTypes,
      enableMultiMode: false,
      enableAlbum: false
    };

    try {
      const result: ScanResult = await scanBarcode.startScanForResult(getContext(this), options)
        .then((result: scanBarcode.ScanResult) => {
          logger.info(`Succeeded in getting ScanResult by promise with options, result is ${JSON.stringify(result)}`);
          return { result } as ScanResult;
        }).catch((error: BusinessError) => {
          logger.error(`Failed to get ScanResult by promise with options. Code:${error.code}, message: ${error.message}`);
          return { error } as ScanResult;
        });

      return result;

    } catch (error) {
      logger.error(
        `Failed to start the scanning service. Code:${error.code}, message: ${error.message}`);
      return { error };
    }

  }
}