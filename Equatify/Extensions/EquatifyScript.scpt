use scripting additions
use framework "Foundation"
property NSString : a reference to current application's NSString

-- Helper

on removeLastPath(myPath)
set myString to NSString's stringWithString:myPath
set removedLastPathString to myString's stringByDeletingLastPathComponent
removedLastPathString as text
end removeLastPath

on isFolderExists(myFolder)
tell application "System Events"
if exists folder myFolder then
return true
else
return false
end if
end tell
end isFolderExists

on homePath()
tell application "System Events"
"/Users/" & (name of current user)
end tell
end homePath

on libraryPath()
homePath() & "/Library"
end libraryPath

on xcodePath()
libraryPath() & "/Developer/Xcode"
end xcodePath

on projectPath()
tell application "Xcode"
tell active workspace document
set myPath to path
end tell
end tell
removeLastPath(myPath)
end projectPath

on openFolder(myPath)
tell application "Finder"
activate
open myPath as POSIX file
end tell
end openFolder

on openDerivedDataFolder()
set relativePath to projectPath() & "/DerivedData/"
if isFolderExists(relativePath) then
openFolder(relativePath)
else
openFolder(xcodePath() & "/DerivedData/")
end if
end openDerivedDataFolder
