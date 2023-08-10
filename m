Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2010.outbound.protection.outlook.com [40.92.42.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE040634
	for <xenomai@lists.linux.dev>; Thu, 10 Aug 2023 01:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRZIp+2dRJNWUB4sZ9WTiecP67gSsaIiuKviEQfVwJOL5FKICNlzB7ue7xQ8J48oqPDiHKS1g0Q/pgbgsc+owRhDgk2nhoy9nDMJiGek/vIjUdY+L+en2e67hGsA0gSfSB1k91/ZXb6tnQhUxNG6iRUX2nWAok8dJcp9FJPzz5iU0E0lZ6YF9McuiKihT7qlpTnf7WmqsN6/50xPB94UlQIxOonTfUO9NvNTkwypYSwOmJCEdIl3OzHXPSYPNTNygB6SoRCWRUZYa8PkOE8yr3xp3hlXKkhk1EzEg1QzbZ0S9YEwkPubRJCqLOqMkDGZUkoJoXbuThUkp0gUo4X35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S9qCwdpDtGCdy3Sod0Q5L803U6nbvzIwrp4Zf/ECKk=;
 b=cUHGWnH3J7cnz/HlK0D9PJDE+zKRBz1ZcAqKQLV9VK6aGZw1vUiXYASiLg6/NfXqhilUSnTWNcPZb20lL83FHaAra3pztKZpFsjNmgoMKZuziYjw4KMj7GyBX0T3Id6GflE10uwhyIog5XRy9lIjFE/MpVu851+g2ujd1Hgjxor9EBouWqBP00wAjC8tJV7M6nvGWz3N+quIAmU4Y1YyIsU2EoL4hQhMfyojSmdQFbVe+rUziFLhPxJGwLMl4wwd7VcUzbcc3Yu8OAf+HLqTvqTAgVN+AFlq7zDPZa7qC3X9voWz5+tG8qTA/3j/YEyrVvG4t4sZLEUi+fF7lL6ihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S9qCwdpDtGCdy3Sod0Q5L803U6nbvzIwrp4Zf/ECKk=;
 b=qhfrTobDJXtSSgaxgrp7K2d0eibrrVA5Q1W00KGc5XfXf/4Jqcdr3OxVoVrKS26ks3jO1TyEVLyr24XJoLIb5ejt5BlCZqC9q5BggYlaiIAvNTgq/qtmkpPGCCGOWCTxT/H8+Lxrzkr74QoNUcR4QjkuL3wtxXcdoditewwlTNZdJS23Y2lg2Uq/sJ0cK3zR/fGWoN5VcGNkFHcwbcGOs0ZhSHQ1Hg8K+njuekg15PqoKxJDXrUPbX/wuyNx5q/I9ASyPaYaZeJB7GYI8gqroCEmFAaxoLvpMWk/FxJbFppA7lppYF9zVxcraYRin36ui5Z8zrFCLcmWxvoOIqaSAA==
Received: from DM6PR14MB3871.namprd14.prod.outlook.com (2603:10b6:5:1b6::20)
 by SA1PR14MB4609.namprd14.prod.outlook.com (2603:10b6:806:190::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 01:17:23 +0000
Received: from DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a24d:c80e:726f:9848]) by DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a24d:c80e:726f:9848%4]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 01:17:23 +0000
From: sang yo <stlfatboy@hotmail.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: mutex release race patch
Thread-Topic: mutex release race patch
Thread-Index: AdnLJ9SI8V0wGRcUTYaYS2HMQKkBoQ==
Date: Thu, 10 Aug 2023 01:17:23 +0000
Message-ID:
 <DM6PR14MB38717D50B64F3FB699D8E645A313A@DM6PR14MB3871.namprd14.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [boqIOFMdPXiYrwkaQBSu9NXolz1TDUQB]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR14MB3871:EE_|SA1PR14MB4609:EE_
x-ms-office365-filtering-correlation-id: 1627e32c-4b6c-4db6-60f3-08db993f8d03
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /BfwySyT9IVgC7giHDiKYbAM9YRmGoj7j2JWGPWQAB/Lkk3yG/tOAju9YnarOK5CDkqzmx+MpkaOKVHmVkYSaSf8SF6/Z63WgiPYbzi397gP5kxwWDDNqN2fLesvlWGcJHYRYvJiK1xw9BLUk0tFh8nj48fa9UlfndEo/4m2RqopM+ApNFP7/AEgFHJjOlLtb5HAhjfKN0pjysdtqvPWbYiCod9nQD3mTdqqmzmTHBTxOO7zRhv4z4xA9ehBwbxWmmwVddrhyaKZrAnSEz/hVE8DiuMmWbmE7eERe64pUinyCMSTL7w+Vfy+a+yAlP+zzGx3c71/cMS/oKmgCmvyLZjOZougSMlhCVp9Gdn1VfTpoGXqUlyVOj/YigRusZNmHrTBO1oPKxYCNpQl3KCqbL7Cl3t0/wacSEU1iUMCB2MXr6eQ/+LtTWjE2d1Xo9PIEYXEFgJv05KHOuz+zee4R8dWcO0lr7ho3fi62I+PzMVcX0O6TJ7f0zUpWvFbYQcp5L2cg8YujbcK4PMqLr9KfoNybbIdjCv31mCa0rGEyTc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3VnK2pWYmZCZ0xYbGYzT1QrdC8wTUpmOFdRWGhPWWRtREN2TVVRdWxDeGh5?=
 =?utf-8?B?VldCN1VxTE1zNmY1cG1rOEthMTl3SEFBYWYyaXNkSS9VZ09lVTY5Ri9rNTJ6?=
 =?utf-8?B?dit3amRXeS93WDljMzR4MnIwbm1uZUpVdFFiZWUzRFU5b1lPblZrUlQrSkJM?=
 =?utf-8?B?QmdqSHZoMDZHdFZiallwNVJTUkZBUkdlcTdFVWZRVVpIRmdrVy80THdRUFVr?=
 =?utf-8?B?QVVOc21CakE4ZnRYeGxaMkxQbksrRHkvOSsyY0h1Nmw4SmZpaFFkSGtjTkNS?=
 =?utf-8?B?enNsbkd2STd0MmZxRXFTSHlRYmtsY2Ezbmx4MDRQL0puVUw3LzVqVXFUVWN3?=
 =?utf-8?B?djgyZFdzRlg1TTJZRjg2UCtUcDZLRUxIZVU0MnhwSUQwSHFWOG5ORGMwMnZ6?=
 =?utf-8?B?WTBpd0hFYUwvOVJ6QnN4MWJhRFNhNkZhdXE2OUp3T2dXQXVCSDhSclJYZGts?=
 =?utf-8?B?czdmakpqUDY2R1F4dVFhZU85RDd5akExSzNMK3N2RjRZYmUvZmcwaDdqNzZZ?=
 =?utf-8?B?dFBCZ0pJTjdORFFIRGM2TGtZMy9VQy9VQTYvT3NXeFJtVmh4cEdEWTBTNVlQ?=
 =?utf-8?B?a1cyY1haZnRmVHJiQUR6NkxMMU5IWm1scklNUmwwZ0Z0cEU4czNiRWJBUk1K?=
 =?utf-8?B?VnZuRU92Nnl4cFBuM0RNcjVYcHVrSG9UUDdLakdLN0dhRUY0bjRyV1lmb0hK?=
 =?utf-8?B?a0ZvK0RVNitaUC9pVUk1UmlNK2k4R0NOUzAwYUQ0WU1yNmFFV083aVpjVVM4?=
 =?utf-8?B?RHkwSHBtZElrQTA3WGtUVDB2ODZQQUQxbnRzNGZaU1NkU1I4TDZHYXIwckJX?=
 =?utf-8?B?clNheDZoeEZ4bURyUnlLWmxYY0dmWnNkYWtTTTUrT0RDSjFVZVJPL3Qya215?=
 =?utf-8?B?cjQwVG9hNElWTlYwcXp3Ym0wckFxNlEvVTN2RWgzYkZhekFqdjFXbXB6d24w?=
 =?utf-8?B?L1dzNmgwN0VlZXFaOUh5bXEvaXlsZG9nSzFqL0NaTjNCRVdHS0Fvck9LNmNk?=
 =?utf-8?B?aHo5Z3RNeXY1TGpYSjhrdVRxazlNeWdUTzlOR3R2ZHVLUFh5MzVha0lyR3ZF?=
 =?utf-8?B?aUtMTGtLeXdZeEZ2cGtpZlhsbFZKUXNtTi83WXdSVHpIVHNUcE1lR1hQaHRT?=
 =?utf-8?B?ZDhvZEdha2VhdFhzTTdnUEVLQTJTR29naXFwMXBzRHRkMThMRysrQjNUTlA0?=
 =?utf-8?B?Tm5CQzRFeVovS09NOWNpOWg0TldRUmEwd21sUjN2dEJxNHZqY2RXc1BoUjZI?=
 =?utf-8?B?S3dRdmtzMXJvWVRlQ0NwbGNjZFpLeEVHVTB0RUVqTzgwK1Bxc0lEYnpUYlJj?=
 =?utf-8?B?QWQ0YXlVZEphZXRyN1VvUWV0b1Z2dWxxa0gzdXpVUlh2RTVEaG9BejdkRTRB?=
 =?utf-8?B?ckM5ZjV0RklSMEVhaWl6UGNDSHIyRGVndnZXMC9JL2g1ZUZEcGFuT3hITVVl?=
 =?utf-8?B?ZXBzaEs0NitNdXZSNzNiUXpaZmU4VDU0SmpSU0tJKzBtWGpQT1V2dXd1Z2pR?=
 =?utf-8?B?bkR0azFlaTVmUjN3Q1NWMHFKT3I2RHlaTmpCTnZwbG96bWxXZ0dDMU5RSE1r?=
 =?utf-8?B?RS9rVzA5UFRoMXNiU0xhdTRWZHRjMlFuSWVaQWhpQ0l6UE9DYmxqcGtKM2Fw?=
 =?utf-8?B?Zk44cjcvWVNYdjBGend1NThLbTI1UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-cd57b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR14MB3871.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1627e32c-4b6c-4db6-60f3-08db993f8d03
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 01:17:23.0664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR14MB4609

SGksDQoNCg0KSeKAmW0gd29uZGVyaW5nIGlzIHRoZXJlIGEgcGxhbiB0byBhcHBseSB0aGlzIHBh
dGNoKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3hlbm9tYWkvODdoNzF4Ymx1MS5mc2ZAeGVub21h
aS5vcmcvKSB0byB0aGUgeGVub21haTMgbWFpbmxpbmU/DQoNCg0KVGhhbmtzDQo=
