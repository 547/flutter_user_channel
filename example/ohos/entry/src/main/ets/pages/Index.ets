/*
* Copyright (c) 2023 Hunan OpenValley Digital Industry Development Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import common from '@ohos.app.ability.common';
import { FlutterEngine, FlutterEngineCache, FlutterPage } from '@ohos/flutter_ohos'
import FlutterUserChannel from 'flutter_user_channel/src/main/ets/com/seven/user/flutter_user_channel/FlutterUserChannel';

let storage = LocalStorage.getShared()
const EVENT_BACK_PRESS = 'EVENT_BACK_PRESS'

@Entry(storage)
@Component
struct Index {
  private context = getContext(this) as common.UIAbilityContext
  @LocalStorageLink('viewId') viewId: string = "";

  build() {
    Column() {
      Button('token').margin(80).onClick((e) => {
        // FlutterUserChannel.updateUserToken("123", AppStorage.get<FlutterEngine>("flutterEngine"))
        let info: Map<string, object> = new Map().set('apiEnvironment', 'test')
        FlutterUserChannel.transmitOtherInfo(info, AppStorage.get<FlutterEngine>("flutterEngine"))
      })
      // FlutterPage({ viewId: this.viewId })
    }
  }

  onBackPress(): boolean {
    this.context.eventHub.emit(EVENT_BACK_PRESS)
    return true
  }
}