export enum GrantStatus {
    /**
     * access_token permission check fail
     *
     * @syscap SystemCapability.Security.AccessToken
     * @since 8
     */
    /**
     * access_token permission check fail
     *
     * @syscap SystemCapability.Security.AccessToken
     * @crossplatform
     * @since 10
     */
    /**
     * access_token permission check fail
     *
     * @syscap SystemCapability.Security.AccessToken
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    PERMISSION_DENIED = -1,
    /**
     * access_token permission check success
     *
     * @syscap SystemCapability.Security.AccessToken
     * @since 8
     */
    /**
     * access_token permission check success
     *
     * @syscap SystemCapability.Security.AccessToken
     * @crossplatform
     * @since 10
     */
    /**
     * access_token permission check success
     *
     * @syscap SystemCapability.Security.AccessToken
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    PERMISSION_GRANTED = 0
}

export enum SwitchType {
    /**
     * switch of camera
     *
     * @syscap SystemCapability.Security.AccessToken
     * @atomicservice
     * @since 12
     */
    CAMERA = 0,
    /**
     * switch of microphone
     *
     * @syscap SystemCapability.Security.AccessToken
     * @atomicservice
     * @since 12
     */
    MICROPHONE = 1,
    /**
     * switch of location
     *
     * @syscap SystemCapability.Security.AccessToken
     * @atomicservice
     * @since 12
     */
    LOCATION = 2
}
