module Auth exposing (..)

import Json.Decode exposing (string, decodeString, Decoder)
import Json.Decode.Pipeline exposing (decode, requiredAt)

type alias AuthInfo =
    { webId : WebId
    }

type alias WebId = String


authInfoDecoder : Decoder AuthInfo
authInfoDecoder =
    decode AuthInfo
        |> requiredAt [ "session", "webId" ] string


fromJson : String -> Result String AuthInfo
fromJson json =
    decodeString authInfoDecoder json


{--

{
  "rpConfig": {
    "provider": {
      "url": "https://e1010.net/profile/card#me",
      "configuration": {
        "issuer": "https://e1010.net",
        "authorization_endpoint": "https://e1010.net/authorize",
        "token_endpoint": "https://e1010.net/token",
        "userinfo_endpoint": "https://e1010.net/userinfo",
        "jwks_uri": "https://e1010.net/jwks",
        "registration_endpoint": "https://e1010.net/register",
        "response_types_supported": [
          "code",
          "code token",
          "code id_token",
          "id_token",
          "id_token token",
          "code id_token token",
          "none"
        ],
        "response_modes_supported": [
          "query",
          "fragment"
        ],
        "grant_types_supported": [
          "authorization_code",
          "implicit",
          "refresh_token",
          "client_credentials"
        ],
        "subject_types_supported": [
          "public"
        ],
        "id_token_signing_alg_values_supported": [
          "RS256",
          "RS384",
          "RS512",
          "none"
        ],
        "token_endpoint_auth_methods_supported": [
          "client_secret_basic"
        ],
        "token_endpoint_auth_signing_alg_values_supported": [
          "RS256"
        ],
        "display_values_supported": [],
        "claim_types_supported": [
          "normal"
        ],
        "claims_supported": [],
        "claims_parameter_supported": false,
        "request_parameter_supported": true,
        "request_uri_parameter_supported": false,
        "require_request_uri_registration": false,
        "check_session_iframe": "https://e1010.net/session",
        "end_session_endpoint": "https://e1010.net/logout"
      },
      "jwks": {
        "keys": [
          {
            "kid": "_hkeiWcxCtc",
            "kty": "RSA",
            "alg": "RS256",
            "n": "7fWMgAYotV5G4iyxwXf4TVJqomaQTe_JIqcH-obDK8X2MiRMxMTYiu3yVhghHpURXfZHhQPGmlueGpsEQAK4ysIMeuQvxrbJjFKCLzPrUeJtdHV5uOHeJnlxzHK3S-wZm1_w7jWZBdSxU4ogOsshBOL4xjzUpEaWDwHrl1vLfnWLdT5ZBLIoFGTJETxvqqd07dOy1zpfdKwjfXw-9d44LsadE7MbUu9jqVkCwb0vLK7kYnmUHuNC7_tY7dkBO_dqUtPbBhXUXJ5Y82a44ICsB0D0EmsYLBAs2OBAxOXWpeTPA-yiFnqL9GC6GCLg8a51pxIaY0GmEusQmE0mezfPZw",
            "e": "AQAB",
            "key_ops": [
              "verify"
            ],
            "ext": true
          },
          {
            "kid": "Wq9b2WCg6jU",
            "kty": "RSA",
            "alg": "RS384",
            "n": "uEJA8Sv8nJ_FKQ1qLgPDJ4fh4z0aPGbQKVQsN177k9bIjzkFuXh4T0xNfUKxFv7X5xDptl1l-QYoV0vVUWIQFX4bWd0Th00s6zv0gPxTbGVRA_TzfOpxV2ID4NAZJXKEUA1DgN37s575v3KOCqAX6v_5Ab4L_GRbPOmtkpR_GE726Uuct7LgVGWa3FpLT5nHhVf6i6P86JC1XP1w6emTue0-Eu5KXtoGZZnTy97MDz2ZWj9KbVkWTfzX2FOUfjGWElVNJth1Rkhvk3nT8LTgQuCLuQXWN9doVPl0saOdSV-3pTjAfxIFAwrAU9LArINntqI44Y2P3TdDedOYxF2lWQ",
            "e": "AQAB",
            "key_ops": [
              "verify"
            ],
            "ext": true
          },
          {
            "kid": "nUiHgPVxTqY",
            "kty": "RSA",
            "alg": "RS512",
            "n": "wmw9RiVEj_W0ZUd8Kn1AWPp09fezv3uuh0NCVQ33Nye8JMbd0Y8C6EHL2xQTdHazoUtmE_EZMYRbkuALcwyqzyM8b0iv8tLaiqa5E_boLrXjlozrOm-8Z456by7UmB1ZoTBvRbaZkq-TwrR7jK4QEyPZgkAG3DClGgDW-3vI-B7qT7kZhyA7-7AoYnwZu2KjO6P6xaHnO9rEKBapMGEEgr-jhbe1L8S-E5knqynpmVJAEvED5fj68_UJg6ia4gSPSOErxIfB9A0kfSb4jarbn8qMaaKKMZUXAaJaZo4VqwV7NFlMOAWObPQDs6q8kxrMfDlTzXRRp0vwliEalCrvFw",
            "e": "AQAB",
            "key_ops": [
              "verify"
            ],
            "ext": true
          },
          {
            "kid": "thKyvtKyzgY",
            "kty": "RSA",
            "alg": "RS256",
            "n": "vcu6e6pQ4H9RexXhPG958ZfumJ33yElzQv3k8yAzKGl-lJD2pVvxJyb_J5k74ePc7L-Su28WczWzgpN7UJQV9Cs-zElT2DcxTliidV5tOAZNPa3iRUTeRK4siXYzKshhdbYmlfDRU_5ncvmpc9jf9boDnxxrU8yjj8GDQrEO6tBf7Ygwmi74MWWgWthIaHA46Isk_joHBxXkcS_7j_nbT6IWDHi7qC2KRvFtfmYyCA0jQMPCw9iAf6UZ5OEXAlAqc26RJVq5_yda59UXKr6Yhtx_Thakc9Tb0vKHo2UIUSFnb8XLypZEnfLSpw1mFfbFE0NXSrFCWVN11H21pYRx7w",
            "e": "AQAB",
            "key_ops": [
              "verify"
            ],
            "ext": true
          },
          {
            "kid": "osP9IBWACSY",
            "kty": "RSA",
            "alg": "RS384",
            "n": "yl4ff8AUsCIzQTuJLZR-StJiyXBqC8_6E4XIuZ_bHn5Q2Ju3tUDU-K93xgizBwrCSktTgHDl038HlB3JmoTqcM-DAZwq2Dl7dPfPAx0gthmxbX-Su4H1C9T7yeJJATjY7DKoiX7KeYhryxYv3yawj-egpS_lZBE3EVy-u9P-CWP71s4yIScc7ffnovx-a3z0zNziVA-DHek2iBEt2o2zQTxWMXXcKP7sc2ObzufrUxjLD1DXFaTtbTJ5RUXtP1JvKvDvlHWxMhzHuuhs1iJPoAUo4Sn_BiVmitG9VZfZ1k3tCgA1VhggO2w8_BKxnM7Z4r1JyEj56-gy4k4WqgCUhw",
            "e": "AQAB",
            "key_ops": [
              "verify"
            ],
            "ext": true
          },
          {
            "kid": "hHtneo2-uXw",
            "kty": "RSA",
            "alg": "RS512",
            "n": "6sGGW3OtUMZgZbxuVB6hWAFTUrDfmCg8iGNGX0CZqP9yZaS6rwfZXGMcPPhhvfX_nZQBDMeYnY7izUHR2nhcDuwDpskTMWJhzJpw61yvEXOmob6dImgjOsuZMlRT_0e2z4T-MBXPf5oqGgK2UVuVGqgRvlXyhKJ7qB7Fi8rmRWsfRYrsiNDYUkLT4Hnhdp38fseTM2cPHC1YjO3UQKfUWWdiGzwI4mB_QpN9xhYUptzPan11axdsSpAmG3pAqleMhTwUrx7dPKfy3KAA_6Uh3vkDyWIf3X_J-k5CVnWMxfUq1hwsLv5nN80it41rQkgFIa7t0hk9IQGgyueqeUG1qw",
            "e": "AQAB",
            "key_ops": [
              "verify"
            ],
            "ext": true
          },
          {
            "kid": "LGUEfSDVIho",
            "kty": "RSA",
            "alg": "RS256",
            "n": "u5tMo-0sRNCO617DXkLreInNpsjqh8AY17kCP_2eUZgjXALyo13qOGcNPpQPkbqdBpmyMNQxxLId-sXUAN1dafDeje5Kv_uhJQMaIIEUPBIIEWXD9mznRXDfQ6dqabq-L8IPfqMnWXPvQUhcQF4fCiKm0pkneqQnBVtyyJTEVJvmM4kXZDK5i-7Ybn0wyQ8Um3Z5pBJfmlsDuDc0FuoPYBdIoidFvrmw5DpzI00KTOT3B4khlGbjGcATvhfiljPQfLJDVWF7cAoiBHbsweK1kvqVWHcB4niU_0eaxUx5OUtnLoMGb7kSLvrxTgkK4x3znBxMlp4_uzftp-HWxxIp6Q",
            "e": "AQAB",
            "key_ops": [
              "verify"
            ],
            "ext": true
          }
        ]
      }
    },
    "defaults": {
      "authenticate": {
        "redirect_uri": "http://localhost:3000/popup",
        "response_type": "id_token token",
        "display": "page",
        "scope": [
          "openid"
        ]
      }
    },
    "store": {},
    "registration": {
      "client_id": "cddbbfd620387c59a8bd57f6dba78d69",
      "redirect_uris": [
        "http://localhost:3000/popup"
      ],
      "response_types": [
        "id_token token"
      ],
      "grant_types": [
        "implicit"
      ],
      "application_type": "web",
      "id_token_signed_response_alg": "RS256",
      "token_endpoint_auth_method": "client_secret_basic",
      "frontchannel_logout_session_required": false,
      "registration_access_token": "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczovL2UxMDEwLm5ldCIsInN1YiI6ImNkZGJiZmQ2MjAzODdjNTlhOGJkNTdmNmRiYTc4ZDY5IiwiYXVkIjoiY2RkYmJmZDYyMDM4N2M1OWE4YmQ1N2Y2ZGJhNzhkNjkifQ.kRcXEwskhRjp4zKkOqKmoGGHtOSgmpQn6VHYyNRDiiEaLkdwYiP-b4apmEjVKvuvC8UzDt2ydJcTW_jkz1K45B2vaL_xWcx3jNg54I3VmDFjUgm_EOQGtgnb2dkjCwTfvT2jrJZNkKERmwaJ2ILXLyAmiqDfYSF0gxi08_I4upr_jZiN5tMF7ZjOF5srURY-f4JKucjjAq16p3dY0l3IimGMpSTLoL9UQZlGiNcApV2DOEzaP7Zq6NPlXiikdY31saGGhXFRH_X56vSqU0GeYpoH4joEA4BRm5oJzI3oi6L-2gdNE7azhyy6TNUlhvHulYQZHL9gZIc15LXbJKlkHA",
      "registration_client_uri": "https://e1010.net/register/cddbbfd620387c59a8bd57f6dba78d69",
      "client_id_issued_at": 1528367972
    }
  },
  "https://e1010.net/requestHistory/yUXPFF5SznJ9vef6wA74WmVtWJVtX0zTB_Q5rIQMB0E": "{\"redirect_uri\":\"http://localhost:3000/popup\",\"response_type\":\"id_token token\",\"display\":\"page\",\"scope\":[\"openid\"],\"client_id\":\"cddbbfd620387c59a8bd57f6dba78d69\",\"state\":[184,112,61,117,21,248,116,254,41,17,103,179,163,100,11,242],\"nonce\":[239,45,25,43,136,55,32,25,209,150,94,108,252,71,233,150]}",
  "oidc.session.privateKey": "{\"alg\":\"RS256\",\"d\":\"KATmQXdwFQ2Ok_HrMieKNG8rTO8dtm_JQ8OMGOuiom1UIio-cdJR7PlpoCHpzhCaowVVPMVyy2vJeJm5bXFQFHlOSVWgSvABuAbC-4P54kwoCICwr4wR9DxpTq3Lk0kcLuI4HrhvROAUcRSeE4a68-Wkzj0277ex1kwqrjIpXW1cr0YO5-QcRxzpKMocVri0lD5p80MyIwIMYJ9qM5SXgbyNqQJYRs68Yd1xL6ovz8UUb5efz9ZacB3vjuh61X2TUydoHPso3EjHtn0A2n02bqT-CNNPRq768X6zILlqs0oVhGCOkfH5fgw8E1uIBfDmFVAHTbH-w8Q5ZWkMFzYlkQ\",\"dp\":\"0othErAfAP-tWyJxWH86FDHRJr4JWkcy9TpU1KMl4YtiqJNoC0tlz4a4-61sMmzqkaFl2PjBCKqxgw2hKpnWB8YAqbqTks6-ewjJ0P5Nu7btq8CdSHoNHG8kRNhGUyCey8cv5jmjAkSEKlFwbrJc8uxO16SPxB5-lWEzNkHafBE\",\"dq\":\"sTaTVpCGKDtKj5z_MP_hAGyzwuBi8HDTtZQPfKgztqW_aMKEgYS0qZnOJMgrHIDf-6NE4zD7z_HI8kPhBnxR9eje5v73DAnZPDEXAHn7ZJPGPQlWlZAl6hl5cK4SHgl9xoV67qAsBtF5_oFyShv-RubojqEwIsmP-YtkfUR3ScE\",\"e\":\"AQAB\",\"ext\":true,\"key_ops\":[\"sign\"],\"kty\":\"RSA\",\"n\":\"5viYOsodIKGAX_YPnSLEK-zmEgLjltzxJlxw78dbmxymY_uSjBktOb0ihcIaL2MD1GuoDkOACKAKvW-LvbaBRwTHmiQv3_5NKOazESlCkyk5hUWjlWdIW7hGdDsvdsOBox0n62gd1WMhWk88lhkL70NFqno1COQkRi55q5nACvsCkFNWBuKrc4lsGFAv1awrJDXPaS6hpMZo5Ye9eiBj7G6a3T2zwvL09ojMSDd0C7_ysj9lOAxcFyEp5omxbEaMzqDr1WzUQhXeglU0wuHkqk6iBAM0oPkw8LrTJGQSANJp1ShoOp1H4FwckrZMdSjSc9x0Pe5Tzt98CZODV07djQ\",\"p\":\"-lI1icZH7LYZYSQVLCU4kVyYy6Ih-AYeEXoxWBON589Pw2Tej4eg5rSrYXDk8BIw7vN9qKMJsu79QQ5YycGYP2b3uj2-2U-cjIdj9uqlFzW-dvwUm0duDg3tLCnxM3A-jKTF9Y7KWHgSdbMiI80GKNP3tu9w2gHhJyUFdrIbYbE\",\"q\":\"7DYBkWOzUhBtBXRKDH24MQ4vENl1ofeGPVqUieltCrZjiwxQqVOBSE1D4yAn2D32JtZu1LYaKblRvpaNLLi73fvxa7QuYCPZYJsMq7MA6KuAIRIDU5dYBlP9uGVQnsI_kA2rdy-KPczarcDGVDaxSmtg_00NRDHqMKBwAjZsNJ0\",\"qi\":\"GCwgJUqcxfP2K6cqLAIGwuKi6w2B1rvQOkIhh_wLRw18kSoX9K2fGAEtO-xPpq5ZZ7_BH_EYe7LUmYTmKP5KT8U1FI-yd4QS9dl-SIzIqt_Qo_ycEvwyWP5x_RQ4S1ida5juzO-gG6kWe2TWs0ushpUn0N7kXGRNL_SdzjZlGcY\"}",
  "session": {
    "authType": "WebID-OIDC",
    "webId": "https://e1010.net/profile/card#me",
    "idp": "https://e1010.net",
    "idToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6Il9oa2VpV2N4Q3RjIn0.eyJpc3MiOiJodHRwczovL2UxMDEwLm5ldCIsInN1YiI6Imh0dHBzOi8vZTEwMTAubmV0L3Byb2ZpbGUvY2FyZCNtZSIsImF1ZCI6ImNkZGJiZmQ2MjAzODdjNTlhOGJkNTdmNmRiYTc4ZDY5IiwiZXhwIjoxNTI5NTc3NTc1LCJpYXQiOjE1MjgzNjc5NzUsImp0aSI6IjhhM2UyMzRlZWM3MGVhMDciLCJub25jZSI6Ik5ESVFIaDRtSVVFRFZQSkg1UU91NTJuWDh0YThCYVJiOUNUcXg5ZVJRcnMiLCJhenAiOiJjZGRiYmZkNjIwMzg3YzU5YThiZDU3ZjZkYmE3OGQ2OSIsImNuZiI6eyJqd2siOnsiYWxnIjoiUlMyNTYiLCJlIjoiQVFBQiIsImV4dCI6dHJ1ZSwia2V5X29wcyI6WyJ2ZXJpZnkiXSwia3R5IjoiUlNBIiwibiI6IjV2aVlPc29kSUtHQVhfWVBuU0xFSy16bUVnTGpsdHp4Smx4dzc4ZGJteHltWV91U2pCa3RPYjBpaGNJYUwyTUQxR3VvRGtPQUNLQUt2Vy1MdmJhQlJ3VEhtaVF2M181TktPYXpFU2xDa3lrNWhVV2psV2RJVzdoR2REc3Zkc09Cb3gwbjYyZ2QxV01oV2s4OGxoa0w3ME5GcW5vMUNPUWtSaTU1cTVuQUN2c0NrRk5XQnVLcmM0bHNHRkF2MWF3ckpEWFBhUzZocE1abzVZZTllaUJqN0c2YTNUMnp3dkwwOW9qTVNEZDBDN195c2o5bE9BeGNGeUVwNW9teGJFYU16cURyMVd6VVFoWGVnbFUwd3VIa3FrNmlCQU0wb1BrdzhMclRKR1FTQU5KcDFTaG9PcDFINEZ3Y2tyWk1kU2pTYzl4MFBlNVR6dDk4Q1pPRFYwN2RqUSJ9fSwiYXRfaGFzaCI6Ik02enR6bm1ic3FIT2l3cUZKX1hWNEEifQ.uE0p9oyt7NdRrEYH7syd6rHCr0W63JSu9RC0cplZSV5XvOpgYdXpLvDjA4Z_gFV8BG8e1OLBewsrI1qYSk366rYDMb-ZTQwpLA8FcTqgR2v3ZvXq4YaOFf9pws7OZVp2NChuVbDIH-z-abFxwXkfUGEbmjddn6Y2UL2h58f2wnukFc_I5sNFg0h5X6Fzyu19wzAYIO1nWwqpvv5bCSSUIv5iQ40gDE8n806SLyoNdCZ4ZJRBViDqh9KBZ8OxMmIP5vesZD6VglUbKzCtdk6dvh7vNFLClvFQQSaaa_H1_P7jykmj-hWWU-MLIh7ww_PkVCISsUpiqC0ukXNwLFoH6g",
    "accessToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6InRoS3l2dEt5emdZIn0.eyJpc3MiOiJodHRwczovL2UxMDEwLm5ldCIsInN1YiI6Imh0dHBzOi8vZTEwMTAubmV0L3Byb2ZpbGUvY2FyZCNtZSIsImF1ZCI6ImNkZGJiZmQ2MjAzODdjNTlhOGJkNTdmNmRiYTc4ZDY5IiwiZXhwIjoxNTI5NTc3NTc1LCJpYXQiOjE1MjgzNjc5NzUsImp0aSI6IjcxNGY1MDNiODExNTM1ZDYiLCJzY29wZSI6Im9wZW5pZCJ9.E0g9bGQBkLH2VIiUwmhCYq81G_hvJNt1I16Nv20LM2379CxDKoL3TcUmg0BHW9UL5NpUp0qA3Ec6kfWN58LHSOnevIHK0kV7ZPOPAKRw2uVai9Z4DrNp_2t---oeCDJsh0vAHZcVvQH5wBNxcaFDFUTHb4XGelI-7JPxyU300bjK94XaK39e1npMYWxoCLo2q6-UwwLY3sShuWuLG8qLtnanKItwO2OUVY798bexFiLMRWNnYWpcDmLyuhjptWtMtGKu8S6cY5mZ-JovUOLW0yT3m72bUzDsUeUtEHRgolyS2ABDIdhPZv29Ju3_91MkG1BGPPkgt3gG9sNiv_wwuw",
    "clientId": "cddbbfd620387c59a8bd57f6dba78d69",
    "sessionKey": "{\"alg\":\"RS256\",\"d\":\"KATmQXdwFQ2Ok_HrMieKNG8rTO8dtm_JQ8OMGOuiom1UIio-cdJR7PlpoCHpzhCaowVVPMVyy2vJeJm5bXFQFHlOSVWgSvABuAbC-4P54kwoCICwr4wR9DxpTq3Lk0kcLuI4HrhvROAUcRSeE4a68-Wkzj0277ex1kwqrjIpXW1cr0YO5-QcRxzpKMocVri0lD5p80MyIwIMYJ9qM5SXgbyNqQJYRs68Yd1xL6ovz8UUb5efz9ZacB3vjuh61X2TUydoHPso3EjHtn0A2n02bqT-CNNPRq768X6zILlqs0oVhGCOkfH5fgw8E1uIBfDmFVAHTbH-w8Q5ZWkMFzYlkQ\",\"dp\":\"0othErAfAP-tWyJxWH86FDHRJr4JWkcy9TpU1KMl4YtiqJNoC0tlz4a4-61sMmzqkaFl2PjBCKqxgw2hKpnWB8YAqbqTks6-ewjJ0P5Nu7btq8CdSHoNHG8kRNhGUyCey8cv5jmjAkSEKlFwbrJc8uxO16SPxB5-lWEzNkHafBE\",\"dq\":\"sTaTVpCGKDtKj5z_MP_hAGyzwuBi8HDTtZQPfKgztqW_aMKEgYS0qZnOJMgrHIDf-6NE4zD7z_HI8kPhBnxR9eje5v73DAnZPDEXAHn7ZJPGPQlWlZAl6hl5cK4SHgl9xoV67qAsBtF5_oFyShv-RubojqEwIsmP-YtkfUR3ScE\",\"e\":\"AQAB\",\"ext\":true,\"key_ops\":[\"sign\"],\"kty\":\"RSA\",\"n\":\"5viYOsodIKGAX_YPnSLEK-zmEgLjltzxJlxw78dbmxymY_uSjBktOb0ihcIaL2MD1GuoDkOACKAKvW-LvbaBRwTHmiQv3_5NKOazESlCkyk5hUWjlWdIW7hGdDsvdsOBox0n62gd1WMhWk88lhkL70NFqno1COQkRi55q5nACvsCkFNWBuKrc4lsGFAv1awrJDXPaS6hpMZo5Ye9eiBj7G6a3T2zwvL09ojMSDd0C7_ysj9lOAxcFyEp5omxbEaMzqDr1WzUQhXeglU0wuHkqk6iBAM0oPkw8LrTJGQSANJp1ShoOp1H4FwckrZMdSjSc9x0Pe5Tzt98CZODV07djQ\",\"p\":\"-lI1icZH7LYZYSQVLCU4kVyYy6Ih-AYeEXoxWBON589Pw2Tej4eg5rSrYXDk8BIw7vN9qKMJsu79QQ5YycGYP2b3uj2-2U-cjIdj9uqlFzW-dvwUm0duDg3tLCnxM3A-jKTF9Y7KWHgSdbMiI80GKNP3tu9w2gHhJyUFdrIbYbE\",\"q\":\"7DYBkWOzUhBtBXRKDH24MQ4vENl1ofeGPVqUieltCrZjiwxQqVOBSE1D4yAn2D32JtZu1LYaKblRvpaNLLi73fvxa7QuYCPZYJsMq7MA6KuAIRIDU5dYBlP9uGVQnsI_kA2rdy-KPczarcDGVDaxSmtg_00NRDHqMKBwAjZsNJ0\",\"qi\":\"GCwgJUqcxfP2K6cqLAIGwuKi6w2B1rvQOkIhh_wLRw18kSoX9K2fGAEtO-xPpq5ZZ7_BH_EYe7LUmYTmKP5KT8U1FI-yd4QS9dl-SIzIqt_Qo_ycEvwyWP5x_RQ4S1ida5juzO-gG6kWe2TWs0ushpUn0N7kXGRNL_SdzjZlGcY\"}"
  }
}

{
  "rpConfig": {
    "provider": {
      "url": "https://e1010.net/profile/card#me",
    },
    "store": {},
    "registration": {
    }
  }
}

--}
