module Handler.Post
where

import Import

getPostsR :: Handler Html
getPostsR = do
    (postWidget, enctype) <- generateFormPost entryForm
    defaultLayout $ do
        $(widgetFile "entry")

postPostsR :: Handler Html
postPostsR = do
    ((res,postWidget),enctype) <- runFormPost entryForm
    case res of
        FormSuccess post -> do
            postId <- runDB $ insert post
            setMessage $ toHtml $ (postTitle post) <> " created"
            redirect $ HomeR 
        _ -> defaultLayout $ do
            setTitle "Please correct your entry form"
            $(widgetFile "postAddError")


getPostR :: PostId -> Handler Html
getPostR postId = do
    post <- runDB $ get404 postId
    defaultLayout $ do
        setTitle $ toHtml $ postTitle post
        $(widgetFile "post")

postPostR :: PostId -> Handler Html
postPostR = error "not yet implemented"



entryForm :: Form Post
entryForm = renderDivs $ Post
    <$> areq textField "Title" Nothing
    <*> areq textField "link" Nothing
