module Handler.Post
    ( getPostR
    , postPostR
    )
where

import Import

-- to use Html into forms
import Yesod.Form.Nic (YesodNic, nicHtmlField)
instance YesodNic App

getPostR :: PostId -> Handler Html
getPostR postId = do
    post <- runDB $ get404 postId
    defaultLayout $ do
        setTitle $ toHtml $ postTitle post
        $(widgetFile "post")

postPostR :: PostId -> Handler Html
postPostR = error "not yet implemented"

