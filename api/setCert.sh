#Accept optional host address argument
if [ -n "$1" ]; then
    deploymentURL="$1"
else
    deploymentURL="http://localhost:8080"
fi

#todo this script is not working, probably something to do with a Java keystore
#todo "status":500,"error":"Internal Server Error","exception":"java.lang.RuntimeException","message":"Unable to append signing credential"


export CERT=MIID4zCCAkugAwIBAgIBZjANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDEwlkczAxemEwMTMwHhcNMTYxMTE2MTA0NTE3WhcNMjYxMTE0MTA0NTE3WjAUMRIwEAYDVQQDEwlkczAxemEwMTMwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQC290t7A6rUzo1jMIY45ZP/duo8jV5KUJrxM5nQySSyS5VI19zuychiD8c4x/L5Hg3RJNpNmm27mRnchmjMpIu3KckAYY8VxmMIGc0iiyi3aZ/gc3346G9GUE9Y8CxJktcm7lmKMENDX6RPRTiHUfIQ4x4/qB1enYKKj/1KfBuMDbZaRsdiSj1ego+hXkAqgMZ1YGfTQOnnMP5Ll7/Bg32WIq3ft6l+xX8fgrZ7ed7TfqcrMkLBQycekbKBt2jH/XRkV69y49IPhc7D5u36GUJn3qOXzrAYaHtoQCOy3bwu1lcRSd0DrBWChyOAofTW0q6OYyyZfiuA4ZfERc00940Q/nQhWyknQqzj3QP4T+7j7Xv0dZrhR5nIuTxtY5uiJmpF8c6d1Fk0D5Qt4P6NwXhrtqmNbeb5vVIbxcffSSLeYpJ2NIWhBY6MIEyqcpRPTH1VfjzJD/2cvL1WHvT6vWBFOirVKw+Fujp9x9Pg84e0v9SYC+2kUFAoyaMALt/TO88CAwEAAaNAMD4wDAYDVR0TAQH/BAIwADAPBgNVHQ8BAf8EBQMDB9gAMB0GA1UdDgQWBBSF8xaVuz6I7hQmFe911qmhmbWyTDANBgkqhkiG9w0BAQsFAAOCAYEAV9C6pBuv8S55YebvPO2gLT4tX2QNP4usg8WvYeGin8L0qS3fKJ4ieEJm7r5Bx/vrhlBGLkBRXfvt1/XK/TMeaxezUl7cWHK8cUjCL5omTJAlBiPIDdimUfr6NaHkQJ5mota6B00gP0qipyD/70R9Ca8U643sv3yAGPOC9uWNU7E6+BQZsVDE25I3AxuXGjHTuZpHgpIh+RSPKhqNSOJoy1sgvooejJExB8J1C37EEv8aUEVJZo/eRyXcIZlQcWEgPrgkCXHJn2k1Iz+A4gQ/h0llBnqQDNW1YlHJ1mlK9sW+Cj4EPQeO2KJpD0jQQ6ttHgNOoQ3aQg498bG4mmuROwBJu8kJAxsmPKjVb4qN5X218EeGbcp97ObU2QbbIkMR4IKa8Fe3rCJiDVcc5XaYJImMDAZzNZDbFxykkxTQHfHyPuuvyxUr/sJuB/3dW4I6tnqiU5xysnyjIJha8YtvmX+3osCGip/o3b7FvTn/v2k+TMeoRCG7aE7YJKKE6Dih
export KEY=MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANrJVXuOfVlAy+EV8SX+YebeaFGz\
	5D5RWfZUMrEqEt35xU3QoMwOhc0MxkQ3H0Y9B51gXQNWB/i8QYzXASCf5wXO0rLuHuKzDtzEgFeT\
	rqNzGhoB6launQg+O3+dm/fHX+kEwANwvu7B6jnYkNFAwgCtAvqj+S7U3JgfEKyYSplfAgMBAAEC\
	gYBaPvwkyCTKYSD4Co37JxAJJCqRsQtv7SyXoCl8zKcVqwaIz4rUQRVN/Hv3/WjIFzqB3xLe4mjN\
	YBIF31YWt/6ZslaLL5YJIXISrMgDuQzPKL8VqvvsH9XEpi/qSUsVAWa9Vaqqwa8JTPELK8QhHKaX\
	TxGtatEuW1x6kSNXFCoasQJBAPUaYdj9oCDOGTaOaupF0GB6TIgIItpQESY1Dfpn4cvwB0jH8wBJ\
	SBVeBqSa6dg4RI5ydD3J82xlF7NrQnvWpYkCQQDkg26KzQckoJ39HX2gYS4olSeQDAyIDzeCMkj7\
	McDhigy0cL6k9nOQrKlq6V3vkBISTRg7JceJ4z3QE00edXWnAkEAoggv2WBJxIYbOurJmVhP2gff\
	oiomyEYYIDcAp6KXLdffKOkuJulLIv0GzTiwEMWZ5MWbPOHN78Gg+naU/AM5aQJBALfbsANpt4eW\
	28ceBUgXKMZqS+ywZRzL8YOF5gaGH4TYSCSeWiXsTUtoQN/OaFAqAQBMm2Rrn0KoXcGe5fvN0h0C\
	QQDgNLxVcByrVgmRmTPTwLhSfIveOqE6jBlQ8o0KyoQl4zCSDDtMEb9NEFxxvI7NNjgdZh1RKrzZ\
	5JCAUQcdrEQJ

curl -v -H "Accept: application/json" \
        -H "Content-type: application/json" \
        -X POST -d "{\"certificate\": \"$CERT\",\"key\":\"$KEY\"}" \
        ${deploymentURL}/api/signing-credential