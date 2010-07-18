{-# LANGUAGE TypeFamilies, QuasiQuotes, GeneralizedNewtypeDeriving #-}
import Yesod
import Yesod.Helpers.Crud
import Database.Persist.Sqlite
import Data.Time (Day)

share2 mkToForm mkPersist [$persist|
Entry
    title String
    day JqueryDay Desc
    content NicHtml
    deriving
|]

instance Item Entry where
    itemTitle = entryTitle

data Blog = Blog { pool :: Pool Connection }

type EntryCrud = Crud Blog Entry

mkYesod "Blog" [$parseRoutes|
/ RootR GET
/entry/#EntryId EntryR GET
/admin AdminR EntryCrud defaultCrud
|]

instance Yesod Blog where
    approot _ = "http://localhost:3000"

instance YesodPersist Blog where
    type YesodDB Blog = SqliteReader
    runDB db = fmap pool getYesod>>= runSqlite db

getRootR = do
    entries <- runDB $ select [] [EntryDayDesc]
    applyLayoutW $ do
        setTitle $ string "Yesod Blog Tutorial Homepage"
        addBody [$hamlet|
%h1 Archive
%ul
    $forall entries entry
        %li
            %a!href=@EntryR.fst.entry@ $entryTitle.snd.entry$
%p
    %a!href=@AdminR.CrudListR@ Admin
|]

getEntryR entryid = do
    entry <- runDB $ get404 entryid
    applyLayoutW $ do
        setTitle $ string $ entryTitle entry
        addBody [$hamlet|
%h1 $entryTitle.entry$
%h2 $show.unJqueryDay.entryDay.entry$
$unNicHtml.entryContent.entry$
|]

withBlog f = withSqlite "test.db3" 100 $ f . Blog

main = withBlog $ basicHandler 3000
