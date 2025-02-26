import { CloakWebview } from '@wisdomgarden/cloak'

@Entry
@Component
struct Index {
  build() {
    RelativeContainer() {
      CloakWebview()
    }
    .height('100%')
    .width('100%')
  }
}