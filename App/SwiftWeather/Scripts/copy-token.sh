token_file=.access_tokens/openweathermap
token="$(cat $token_file)"
if [ "$token" ]; then
echo $TARGET_BUILD_DIR/$INFOPLIST_PATH
echo $token
  plutil -replace OWMAccessToken -string $token $TARGET_BUILD_DIR/$INFOPLIST_PATH
else
  echo 'error: Missing OpenWeatherMap access token'
  open 'http://openweathermap.org/appid'
  echo "error: Get an access token from <http://openweathermap.org/appid>, then create a new file at $token_file that contains the access token."
exit 1
fi

