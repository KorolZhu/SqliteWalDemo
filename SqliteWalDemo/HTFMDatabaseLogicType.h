//
//  HTDatabaseType.h
//  HelloTalk_Binary
//
//  Created by zhuzhi on 13-6-20.
//  Copyright (c) 2013年 HT. All rights reserved.
//

#define HTDatabaseLogicTypeInitPlugin @"pluginInited"

typedef enum{
    HTDatabaseOperationTypeInsert,
    HTDatabaseOperationTypeDelete,
	HTDatabaseOperationTypeUpdate,
    HTDatabaseOperationTypeQuery,
    HTDatabaseOperationTypeBatchQuery,    //批量查询
}HTDatabaseOperationType;

typedef enum {
    HTDatabaseTypeDefault,
    HTDatabaseTypeLog,
    HTDatabaseTypeOther
}HTDatabaseType;

typedef enum {
    HTDatabaseChangeTypeInsert,
	HTDatabaseChangeTypeDelete,
	HTDatabaseChangeTypeMove,
	HTDatabaseChangeTypeUpdate,
    HTDatabaseChangeTypeSelect
}HTDatabaseChangeType;

typedef enum {
    HTDatabaseLogicTypeInserUserInfo = 1,
    HTDatabaseLogicTypeInserUserLang,
    HTDatabaseLogicTypeQueryUserInfo,
    HTDatabaseLogicTypeInsertUserSettingInfo,
    HTDatabaseLogicTypeUpdateUserSettingInfo,
    HTDatabaseLogicTypeQueryUserSettingInfo,
    HTDatabaseLogicTypeQueryFriendList,
    HTDatabaseLogicTypeQueryFriendsInfo,
    HTDatabaseLogicTypeQueryNeedFreshFriendsInfo,
    HTDatabaseLogicTypeInsertFriendList,
    HTDatabaseLogicTypeInsertBlackList,
    HTDatabaseLogicTypeQueryBlackList,
    HTDatabaseLogicTypeUpdateBlackList,
    HTDatabaseLogicTypeQuerySearchUser,
    HTDatabaseLogicTypeInsertSearchUser,
    HTDatabaseLogicTypeUpdateUserInfo,
    HTDatabaseLogicTypeUpdateUserInfoHeadImage,
    HTDatabaseLogicTypeUpdatePrivacyAdvanceSetting,
    HTDatabaseLogicTypeUpdateLocation,
    
    HTDatabaseLogicTypeStarFriend,
    HTDatabaseLogicTypeUnstarFriend,
    
    HTDatabaseLogicTypeAddBlackList,                      //加入黑名单
    HTDatabaseLogicTypeRemoveBlackList,                   //移出黑名单
    
    HTDatabaseLogicTypeOnlineStatusUpdated,               //在线状态更新
    HTDatabaseLogicTypeLocationUpdated,                   //定位信息更新
    
    HTDatabaseLogicTypeQueryLanguageExchangeCount,          // 查询语言交换各类的记录条数
    HTDatabaseLogicTypeQueryReceiveLanguageExchange,        // 查询接收的语言交换
    HTDatabaseLogicTypeQuerySendLanguageExchange,           // 查询发送的语言交换
    HTDatabaseLogicTypeQueryRunningLanguageExchange,        // 查询进行中的语言交换
    HTDatabaseLogicTypeQueryLanguageExchangeWithChatId,     // 根据ChatId查询记录
    HTDatabaseLogicTypeQueryLanguageExchangeWithUserId,     // 根据UserId查询最后一条正在进行中的记录
    HTDatabaseLogicTypeInsertLanguageExchange,              // 插入一条语言交换
    HTDatabaseLogicTypeUpdateLanguageExchange,              // 更新一条语言交换
    HTDatabaseLogicTypeUpdateStateLanguageExchange,         // 更新一条语言交换的状态
    HTDatabaseLogicTypeUpdateLanguageExchangeProgres,       // 更新语言交换的进度
    HTDatabaseLogicTypeDeleteLanguageExchange,              // 根据chatId删除指定记录

    HTDatabaseLogicTypeQueryAllChatTextTranslateFavoriteList,  // 查询所有聊天文字翻译收藏
    HTDatabaseLogicTypeQueryAllChatAudioTranslateFavoriteList, // 查询所有聊天语音翻译收藏
    HTDatabaseLogicTypeQueryFriendTextTranslateFavoriteList,       // 查询指定好友聊天翻译收藏
    HTDatabaseLogicTypeQueryFriendAudioFavoriteList,      // 查询指定好友聊天语音收藏
    HTDatabaseLogicTypeQueryUserTranslateFavoriteList,    // 查询用户自己的翻译收藏
    HTDatabaseLogicTypeDeleteTranslateFavorite,           // 删除单条翻译收藏
    HTDatabaseLogicTypeInsertTranslateFavorite,           // 插入翻译收藏
    
    HTDatabaseLogicTypeUpdateMessageSourceTransliterate,  // 更新消息源语言Transliterate
    HTDatabaseLogicTypeUpdateMessageTragetTransliterate,  // 更新消息目标语言Transliterate
    
    HTDatabaseLogicTypeUpdateTranslateHistorySourceTransliterate,  // 更新翻译历史源语言Transliterate
    HTDatabaseLogicTypeUpdateTranslateHistoryTragetTransliterate,  // 更新翻译历史目标语言Transliterate
    
    HTDatabaseLogicTypeInsertTranslateHistory,            // 插入翻译历史
    HTDatabaseLogicTypeQueryUserTranslateHistoryList,     // 查询用户自己的翻译历史
    HTDatabaseLogicTypeQueryFriendTranslateHistoryList,   // 查询指定好友聊天翻译历史
    HTDatabaseLogicTypeUpdateTranslateHistory,            // 更新单条翻译历史
    HTDatabaseLogicTypeDeleteTranslateHistory,            // 删除单条翻译历史
    HTDatabaseLogicTypeDeleteAllTranslateHistory,         // 删除用户所有翻译历史
    
    HTDatabaseLogicTypeQueryMessage,                      // 查询历史消息
    HTDatabaseLogicTypeQueryMessageWithOffLineMessage,    // 离线消息接收到以后查询消息
    HTDatabaseLogicTypeQueryMessageWithMessageId,         // 根据messageId查询消息
    HTDatabaseLogicTypeQueryLastSpeechToTextMessageId,    // 查询最后一条可编辑的语音转文字消息id
    HTDatabaseLogicTypeInsertMessage,                     // 插入消息
    HTDatabaseLogicTypeInsertSpecialMessageWithHelloTalk, // 插入HelloTalk Team消息
    HTDatabaseLogicTypeInsertSpecialMessageWithWarn,      // 插入特殊的消息，比如消息拒收提示、禁言提示、禁止发图片提示
    HTDatabaseLogicTypeInsertSpecialMessageWithAddFriend, // 插入加好友成功的消息
    HTDatabaseLogicTypeInsertDateTimeMessage,             // 插入时间消息
    HTDatabaseLogicTypeInsertChatModelMessage,            // 插入语言交换描述消息 (背景信息)
    HTDatabaseLogicTypeUpdateMessageTransferStatus,       // 更新消息状态
    HTDatabaseLogicTypeUpdateMessageFileName,             // 更新消息的文件名
    HTDatabaseLogicTypeUpdateMessageIsRead,               // 更新消息为已读
    HTDatabaseLogicTypeUpdateMessageTranslation,          // 翻译后更新消息
    HTDatabaseLogicTypeUpdateMessageSpeechToText,         // 语音转文字翻译后更新消息
    HTDatabaseLogicTypeUpdateMessageFavorite,             // 添加或删除消息的收藏
    HTDatabaseLogicTypeDeleteDateTimeMessage,             // 删除时间类型的消息
    HTDatabaseLogicTypeDeleteMessage,                     // 删除消息
    HTDatabaseLogicTypeDeleteMessages,                    // 删除多条消息
    HTDatabaseLogicTypeDeleteAllMessagesWithUserId,       // 根据userid删除所有消息和最后一条消息记录
    HTDatabaseLogicTypeDeleteAllMessagesWithUserIds,      // 删除多个userid所有消息和最后一条消息记录
    
    HTDatabaseLogicTypeQueryLatestMessagesList,           // 查询最近消息列表
    HTDatabaseLogicTypeQueryLastMessage,                  // 查询最后一条消息记录
    HTDatabaseLogicTypeInsertLastMessage,                 // 插入最后一条消息
    HTDatabaseLogicTypeUpdateLastMessage,                 // 更新最后一条消息
    HTDatabaseLogicTypeUpdateLastMessageID,               // 更新最后一条消息ID
    HTDatabaseLogicTypeUpdateLastMessageUnreadCount,      // 更新未读消息条数
    HTDatabaseLogicTypeClearLastMessageUnreadCount,       // 未读条数清零
    HTDatabaseLogicTypeUpdateLastMessageTop,              // 更新最后一条消息记录置顶
    HTDatabaseLogicTypeHideLastMessage,                   // 隐藏最后一条消息记录
    HTDatabaseLogicTypeShowLastMessage,                   // 恢复显示最后一条消息记录
    HTDatabaseLogicTypeInsertBindingMessage,              // 时间消息、消息、最后一条消息同时打包插入数据库
    HTDatabaseLogicTypeInsertOfflineMessage,              // 插入离线消息
    HTDatabaseLogicTypeInsertSendGiftMessage,             // 插入发送礼物消息
    HTDatabaseLogicTypeInsertReceiveGiftMessage,          // 插入接收礼物消息
    
    HTDatabaseLogicTypeQueryFileWithFileName,             // 根据文件名查询文件信息
    HTDatabaseLogicTypeInsertFile,                        // 插入文件信息
    HTDatabaseLogicTypeInsertSpecialFile,                 // 插入HelloTalk Team自动发送的图片
    HTDatabaseLogicTypeUpdateFile,                        // 更新文件信息
    HTDatabaseLogicTypeUpdateFileAndMsgFileName,          // 更新文件信息，同时更新消息中的文件名
    
    HTDatabaseLogicTypeQueryPlugins,                      // 查询插件
    HTDatabaseLogicTypeUpdateLanguageExchangePluginUnreadCount,     // 更新语言交换插件的未读数
    HTDatabaseLogicTypeClearPluginsUnreadCount,
    
    HTDatabaseLogicTypeQueryMessageStatistics,            // 查询消息统计
    HTDatabaseLogicTypeInsertMessageStatistics,           // 插入消息统计
    HTDatabaseLogicTypeUpdateMessageStatistics,           // 更新消息统计
    
    HTDatabaseLogicTypeUpdateOwnInAppPurchase,            // 更新自己的购买信息
    HTDatabaseLogicTypeUpdateInAppPurchase,               // 更新购买信息
    
    HTDatabaseLogicTypeUpdateReceiptReaded,               // 更新消息已读回执
    
} HTDatabaseLogicType;