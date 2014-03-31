module Handler.Create where

import Import

getCreateR :: Handler Html
getCreateR = do
    (postWidget, enctype) <- generateFormPost entryForm
    defaultLayout $ do
        $(widgetFile "entry")

postCreateR :: Handler Html
postCreateR = do
    ((res,postWidget),enctype) <- runFormPost entryForm
    case res of
        FormSuccess post -> do
            postId <- runDB $ insert post
            setMessage $ toHtml $ (postTitle post) <> " created"
            redirect $ HomeR 
        _ -> defaultLayout $ do
            setTitle "Please correct your entry form"
            $(widgetFile "postAddError")


entryForm :: Form Post
entryForm = renderDivs $ Post
    <$> areq textField "Title" Nothing
    <*> areq textField "link" Nothing