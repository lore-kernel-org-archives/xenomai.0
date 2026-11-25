Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795589207;
	b=tr4hUxgGEgu5q0m2ieumxmeuiE9UwUF1leuw5jiqrtwSsz0ZBgOUPgMHD4+eh2QO2lnx
	 zectEzDAisN4VeHfWRIQO+ap9NahqOECNKCqAGPjHCJPAdwqlP2CqB06llqRr0PkT+x8e
	 WNtaTD5hBqWPAx6+iaDRw6gkFR4hFBS71EcTcUdlqLue8BfqgGwvI7dmyZ8u0jNLGA/R2
	 LNuMfQ0ChN3+rWuq4pNTFR8erlGM+4UN56w4RpxUWzsYpMZdNXcwmvFL0s5owi9hlsENP
	 AfOtv5tIGPNYo/ck0L0cAEO6o4JSmogTr5bYGfji2XJPRn0Yiw6P3g6Na18R5YyTIfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589207;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:References:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZBlmrxZZNy7mODcjC1KF9IhBHQvfHIp6u8xoOTqEnzQ=;
	b=H6ey1bD7a3R7WI2q1Vu0Np5QFkkkdEhDjkZjicBaQBZj/R2O7Y7ZizP3BWn5UAeqbpRt
	 WvVUyZMoGxspS3sJUiAon0p09ZyE3ObrdSvMBnEpcQxd6T9SaTv0piH0ojikAnRlF/EE5
	 /0wFyqrtmPZGKkq0qRuzVxII+kwdyu307HKfrPFKaPrDPnwbbLKqELCIJRslX/5rSQ9iR
	 kzcYvK+bWMDyO/oP+v/4EUPxkWtpqlqlZ+Za+OCnbgJbfLj6b+LC7AnuFRLfkD9Yx1MvX
	 5CwzZURFSwVG4NStF7s/yZvMxW+Kvul7A79884HkD/acT2NO37U/JqFhJ+HfUgadu5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=UGClB35i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.38
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C905606A31E
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 06:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C905606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=UGClB35i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNyJ7XDGtkBW0HdNkVOTznJWNjE0U/tZWiup0xldITiZFg3LIow89AlvgmQXrRF30LabzNE1kf9AiXMz/hyKeb5vzFXl6jmmOFWX3RUzNsgvouP2Ny9S7BbMU6ZwPrL3jD/Lu2CPXI9MmuGdLtNxUlOXl15uE7fkTfDEszqpVUbQZuUJo/YyhrysdfQTmZvOslNDtRKy7mpYowyjbJhD+kTqjP2fiSrHrlgkDiJJSq3BeApZYSDpY0O6A0lp+dTh+hEx2BbwMCVEX+dgY4Mh+BK9aRQheEORWKVbI/2l3PMSrizeU4EqXvX/RnsZPwqvMmDhAhLHuy9Z1QwErqrk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBlmrxZZNy7mODcjC1KF9IhBHQvfHIp6u8xoOTqEnzQ=;
 b=QdTFCyLaQIAi4+Bx2JPA72R4NsakKxW4hJvYqr+dIrO2TkcCfu/ZNfpt0G69M3V7GQQ0SFUD7r7NHlZdsYXYW3KxFF1emkmW4c0dKB9cC5YL8jLCBhbbMj3O+ifHVWOXVXcbTYObAlOunJyjAE5niff8Zy4+i2HTj3gRio5PBuhJZOV1/Bszsbk3MVLmKsaoJXx3wFIC+96sx8AjwKvjEUB/O1GBbpmQwkYPOqPQoPClMXv7vXSGvyh5rtVLCpufJKcGXjItRPQFyZbm/EliP+H2zvPSZh8yY97BK3YdeTLUEHhneZHE/nz+DCd0naABP7NowZ4Enrh894ixafk69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBlmrxZZNy7mODcjC1KF9IhBHQvfHIp6u8xoOTqEnzQ=;
 b=UGClB35iWgITGbVmupDkcVuY7mBc1gYEwgbGueIMrBY31sgqinulyEcVoosV78wyvho4rbVdAXwxTW5Z7plYrLSUqG1S9Ir5e/3H+/Kc9A34sOJL8w9h7kcIbKsXQmifu9ZkrW6jxuSLsw0U98lC1eQV5kQWHRx0tvEsltChhgh0iz2IQlwBgNUzGdxil43YLc71EhN4LIW+GqwoJMKGyRwX5gNWIAn058YuhadKVhmdJqPN1UGAGuIIL2lnigJ3GypaW1jQgbZY9Rt6rFlYJhvtivit3HADcTa24RcerfWoeZvIa/rHoR04pDCs8os0EPDIsP4yDZutnDna3LjoYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB7046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:596::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 06:46:43 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 06:46:43 +0000
Message-ID: <b6649a4a-8819-4d68-8cf4-7308f04884c6@siemens.com>
Date: Wed, 25 Nov 2026 07:46:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ci: move downloads cache to S3
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>, xenomai@lists.linux.dev
References: <20261118144737.635199-1-quirin.gylstorff@siemens.com>
 <bbf9d784-e2dd-4747-9f66-8d88a205f16a@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bbf9d784-e2dd-4747-9f66-8d88a205f16a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cbebe6-1981-42ac-c73c-08df4abfddb4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|260925022911599003|11063799006|56012099006|260925021311599003|260925021911599003|4143699003|261026121527099003|261021123027099003|261026140227099003|261102123227099003|261022115727099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|18002099003|55112099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5a9AzulXyBrcw0Z/eLPoYyoaTvwHRaqi9tith4F9jBSmgRLYqkPbElD5BR9WPLQ1Gy5voJS29JTXwfjtmTDvTIeICuWKKVfcC0I6/wtsRqBhQvBnlKs3Ia8UaDl9D489GA38xxXmT2M+4TUJj45nueRilIfmWKbVeM4/FOEKoAdglPe7MKf1iOYklD0P9m6z1JUCOogvFQHi6gRRIPXkPafOJfCyyaxj+oCorYjjaNsELqFUG5KfEFoSPFVbnpQ/iBlauoIyyb0d7Xb76h9yxq8EB5MUOAQmhG3+URy3r3Sy0mQeFQL9Z17lFnNe0mTmpxjKefzRw32DeDVcYGxHUbnFAHmqYyu9vf4jb4tlccOdVqQ+8NvGILcsr4ZMbx7Y/V/ghgZHmLmeKRCmZMhgrt9w2ocTlpuCMrYjsVnvRDys2Sw2IM/5tPjM2MwyitrK7DV9iV6FC70E3oShOvQdyBU+UAd7rvTfpuorUkoyzTiVF89XdnEop/+S7L8C9EatBin7grHnEfCOq+9Zd4eZt7Yw+C1QpGOiI2QzbfaBnAHTDNBik5KjIr9Bf2F4QjnyLMdn5xkJ99vruS/az1QbCfOcE3vy2y3XQEMl8SWWl2iKzk62v5GHVzzv/JxkJ1S0qsgvK1Uxf4PUsWJfnsYpeCUsrUezQEgjMhuRUO2vf6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(260925022911599003)(11063799006)(56012099006)(260925021311599003)(260925021911599003)(4143699003)(261026121527099003)(261021123027099003)(261026140227099003)(261102123227099003)(261022115727099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(18002099003)(55112099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2pub3BlTkhwNmJUcDlzS1l0anV2c1BqdDBTUkUyZmlRZ1BOMjdTcmJXeWFn?=
 =?utf-8?B?WWJPMk0renZmeVBEQXJGVStlT0FhTVNJR1VlbHVGUmdVYTVFenF0Mm4vNkpn?=
 =?utf-8?B?Q3MzQkxvdmZpSFVyTi9wQ0dhZ080bWdmVDFMcWNQM0VYdnpwRWVmTEFLMVZY?=
 =?utf-8?B?TElrQUZPTEJjenBLKzJjb2hNaHhUaE9wRk1XRld6VDVveEdXSGtMdHBSR2hO?=
 =?utf-8?B?ckhURjRsc0hkTnJRQk94QlBpRFhsTm53WEJxOEJ3NVEvVEYvMzlURzN4R1Q1?=
 =?utf-8?B?V2Y3MXVxZExSMDBSLzdENkZ6ZG1CRGlib3ZWeVZmdWpCU25xM3hEeVV2YkJk?=
 =?utf-8?B?SnNCTEtadENlUjBDQlFwT3FrU0dMUkw1aWdqQ0J1Ylc3VlBxSDk1MWkzMDRS?=
 =?utf-8?B?Qmh4SFdrZ1ExWm83Vnd2RzU3MXYvdTJwZmRIeDQ2MWg5Ri96YjQwcDB3THZV?=
 =?utf-8?B?ZzJIbWwycHBFNkxjRzhHRms0a0tYSVBvY3RmQTlqcVd3SFZ6WElQZDhHVUxE?=
 =?utf-8?B?VzJWbzZqKytkcU5oRk5wZGRsUDlPSVlHaEU2ai9GaVZQeWFVRkpVOHFzUitm?=
 =?utf-8?B?Ri9UMG95WW9OM3prdysreitJME9YT2NBaGl5R0s0aXZ3b0F4VkwxY3hKSjNz?=
 =?utf-8?B?K0RCMjI3ejJ5WndpQXgxd0I4MEtjdUlWY3V6ay9EdzNtRWhqUC9RUHYwbUNC?=
 =?utf-8?B?UVRDVkZwRzh6QXlIUDZmZUFhNERxdFJRQUFtb0p1NXJkTkxUZE5semhpWWk3?=
 =?utf-8?B?ZW14UTJYLy85SUlQMWlLeEpHajVOdDNqRTI0cWc3OWtjeFFhN0ZHV3NsU3F0?=
 =?utf-8?B?OE0rdGFPdENyVEhxY1N1YlFHVjRUcXJybzhkUFdzWWQvQ1ZXRjBZZ0xFbGp6?=
 =?utf-8?B?ZUhPNTJvNVNWaWNMcHJ1YWh2WlNtNkM1YXdsazZmTXhXNUxXYVFEMExDRGxx?=
 =?utf-8?B?T29XMTRIemFOaWRoTUorVkovT0oxbmU5b0ZIT216L3dBaW4rS3krSUZPdHp6?=
 =?utf-8?B?Rzg4S0FSYnExNmJXZXdEeXB3TkIvam1GbzlLUnEwcGVTSWxUcGZEd2RvenVX?=
 =?utf-8?B?MjhCOXkrOGVzR05zUzZ1eXpEMlBmdmpUTzdkbU1CV1ZnMExHWXMyb09uRXo2?=
 =?utf-8?B?c2FXVUl5bVJ0dStTOWhUQVhJV3ZwMFoyZERwSnpib2NpcS84YVVGdStoUW02?=
 =?utf-8?B?SHNOWTJOdUFTN1dPK0xmQW9ENVJTV1U1SitZQUNxVWo1UFVEQUVpdVVkRHNl?=
 =?utf-8?B?b3F5VHJwUGhUN1hKbVE3SERsN21rQmJzSERMc3hBU1hJV0xlbkVya0JTRmVM?=
 =?utf-8?B?cmdiV1hWQVlCT2lFRUV0eHArbnowYjhSU1V4RGxBQjFCak81Y3RTM2R3OHBn?=
 =?utf-8?B?Q0RTWld5cU13TGtIYXprWjEzdjhmUjdPdDNkaGQwS0tKbVlhbms5Mm5IbW5l?=
 =?utf-8?B?QjJPZnNxa3pGU2N5dHdTeHkxcEU3dkViMFNmZ2JsNnNMeThGdzJtbFNiSVFs?=
 =?utf-8?B?Z0tmNnpaS2d3VXF6eGZFQzhRQkJxT3BBT08xYTN5WGtCNnF3andNTXNLTi9Y?=
 =?utf-8?B?V0JRcXVhSkxNemU1eGtUYi9kOExsTXdBeXBCR0QrYmxFYmtSWEpaUWtqZm9B?=
 =?utf-8?B?V25XK01EYzZSNWVzbzZDc0czbURLMkdNcm9INTVlOG16VEJ1ZjNzN2JDWDM1?=
 =?utf-8?B?VlNWR3lDUnA4K0wzVmRpV1gzVTNmYVFFaGg0cVpORWs0L01Kc0pvYjNJQlRa?=
 =?utf-8?B?cExDbTFSdmgraDVDUmF0WTVwZEJ4eVBiTmNvNlh1Y1BEYjBWRmhQUzFDampi?=
 =?utf-8?B?NkRpUjJEaDlWVkFJc2p5cWhVSTBFZjlyb25tcnVpS2lFOEJwb1YxOVdnd2lZ?=
 =?utf-8?B?a1NEV04xU1hNR2Q4aWxBenArMDllejVlQ0lpRVBIN3paSnpvTkR5UEc2QXlp?=
 =?utf-8?B?a2k0R0ZlR3RUVGp2VkhWdnpkRFFVQUk4ZTAwODJOSnFrMmNJMzhlSHNFeEo0?=
 =?utf-8?B?bExJNWhGdTI2cjN0a3RaeTErSlorem9kWFhvUmU1Y0VBTUJpTlFvYnljU3NM?=
 =?utf-8?B?OVg2bFN4aDFHbzlncFUrQVk0RlVvNThDc2VUNVc3b3NqenlxTlkyOG42S3FM?=
 =?utf-8?B?NHorbnF2aTQrVGZ1bVdqd2FHR1dMZE95ck54SnFGQ1BjaS9KQ2N6MDZyck5r?=
 =?utf-8?B?OExaZSsxT0xrcnZkV2Y4SWxIbDNJS1k1YkJta3h5WHduQkdENzVKeVhoL21v?=
 =?utf-8?B?YURnay8yS1gzbnBnWjFSZkQrTy9URXJYM1pMSUduY0xnYXBtTWI0S2xMYWdD?=
 =?utf-8?B?Q1dBdnd4eHNHZXE4ZE1JU2JEQk5DNlZzMi82QVdLVGdHeHpLbnAxZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cbebe6-1981-42ac-c73c-08df4abfddb4
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:46:42.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ui/x6Q64+rBIZqBDWCuPwNS7xyilRwKCv7F5Nud0n5jhmSETfEJUI8O9W8KP0JZeRKsbgtJ1RZrmgUAIMFPHIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7046

On 24.11.26 15:07, Jan Kiszka wrote:
> On 18.11.26 15:47, Quirin Gylstorff wrote:
>> The runner's native S3 cache fails for uploads larger than 5G as
>> multipart upload is not support by default. As sts access requires
>> a change for each fork/runner we stay for now with self implemented upload
>> script.
>>
>> Replace the GitLab cache: for build/downloads with a single tar.zst
>> per arch/kernel stored in S3, restored before and saved after the
>> build.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> Changes v2:
>>  - clean update remove unnecessary code
>>  - add comment to multipart upload in commit message
>>
>> Tested with https://gitlab.com/Xenomai/xenomai-images/-/jobs/18136100219
>> and https://gitlab.com/Xenomai/xenomai-images/-/jobs/18136323078
>>
>>
>>  .gitignore                |  1 +
>>  ci/lib/gitlab-ci-base.yml | 14 +++++---
>>  scripts/s3-cache.sh       | 75 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 86 insertions(+), 4 deletions(-)
>>  create mode 100755 scripts/s3-cache.sh
>>
>> diff --git a/.gitignore b/.gitignore
>> index a796dba..c85555f 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -1,3 +1,4 @@
>>  build
>>  isar
>>  .config.yaml*
>> +.s3-cache/
>> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
>> index 7e15321..3516ab3 100644
>> --- a/ci/lib/gitlab-ci-base.yml
>> +++ b/ci/lib/gitlab-ci-base.yml
>> @@ -54,6 +54,14 @@ default:
>>      - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
>>      - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>  
>> +.s3-cache-restore:
>> +  script:
>> +    - scripts/s3-cache.sh restore
>> +
>> +.s3-cache-save:
>> +  script:
>> +    - scripts/s3-cache.sh save
>> +
>>  .common-config:
>>    script:
>>      - if [ -n "$ALT_DNS_SERVER" ]; then
>> @@ -71,6 +79,7 @@ default:
>>      - build
>>    before_script:
>>      - !reference [.common-config, script]
>> +    - !reference [.s3-cache-restore, script]
>>      - !reference [.sstate-prepare, script]
>>    script:
>>      - echo "Building kas.yaml:kas/board/${TARGET}.yaml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:kas/opt/ci.yaml"
>> @@ -80,10 +89,7 @@ default:
>>    after_script:
>>      - !reference [.sstate-lint, script]
>>      - !reference [.sstate-upload, script]
>> -  cache:
>> -    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>> -      paths:
>> -        - build/downloads
>> +    - !reference [.s3-cache-save, script]
>>  
>>  .build-qemu-rules: &build-qemu-rules
>>    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
>> diff --git a/scripts/s3-cache.sh b/scripts/s3-cache.sh
>> new file mode 100755
>> index 0000000..ff66142
>> --- /dev/null
>> +++ b/scripts/s3-cache.sh
>> @@ -0,0 +1,75 @@
>> +#!/bin/bash
>> +
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# Best-effort build/downloads cache in S3, authenticated with the static
>> +# AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY CI/CD variables.
>> +# Usage: s3-cache.sh restore|save
>> +#
>> +# Defaults are built in; each can be overridden by a CI/CD variable:
>> +#   AWS_CACHE_BUCKET, AWS_REGION
>> +# Provided by the job: CACHE_ARCH, CACHE_KERNEL
>> +# Any failure only warns: the cache must never fail a build.
>> +set -o pipefail
>> +
>> +action="$1"
>> +downloads_dir="${CACHE_DOWNLOADS_DIR:-build/downloads}"
>> +state_dir="${CI_PROJECT_DIR:-.}/.s3-cache"
>> +
>> +warn() { echo "s3-cache: $*" >&2; }
>> +
>> +AWS_CACHE_BUCKET="${AWS_CACHE_BUCKET:-siemens-xenomai-gitlab-cache}"
>> +AWS_REGION="${AWS_REGION:-eu-central-1}"
>> +
>> +for t in aws zstd tar; do
>> +    command -v "${t}" >/dev/null || { warn "${t} not found - cache disabled"; exit 0; }
>> +done
>> +
>> +key="xenomai-cache/project/${CI_PROJECT_ID}/downloads-${CACHE_ARCH}-${CACHE_KERNEL}.tar.zst"
>> +object="s3://${AWS_CACHE_BUCKET}/${key}"
>> +
>> +fingerprint() {
>> +    (cd "${downloads_dir}" 2>/dev/null &&
>> +        find . -type f ! -name '*.lock' -printf '%P %s\n' | LC_ALL=C sort | sha256sum | cut -d' ' -f1)
>> +}
>> +
>> +case "${action}" in
>> +restore)
>> +    if ! aws s3api head-object --bucket "${AWS_CACHE_BUCKET}" --key "${key}" >/dev/null 2>&1; then
>> +        warn "no cache object ${object} - cold start"
>> +        exit 0
>> +    fi
>> +    mkdir -p "${downloads_dir}" "${state_dir}"
>> +    echo "s3-cache: restoring ${object}"
>> +    if aws s3 cp "${object}" - --only-show-errors |
>> +            zstd -d -T0 | tar -x -C "$(dirname "${downloads_dir}")"; then
>> +        fingerprint > "${state_dir}/fingerprint" 2>/dev/null
>> +    else
>> +        warn "restore failed - continuing with a possibly partial downloads dir"
>> +        rm -f "${state_dir}/fingerprint"
>> +    fi
>> +    ;;
>> +save)
>> +    [ -d "${downloads_dir}" ] || { warn "no ${downloads_dir} - not saving"; exit 0; }
>> +    new=$(fingerprint)
>> +    if [ -f "${state_dir}/fingerprint" ] && [ "${new}" = "$(cat "${state_dir}/fingerprint")" ]; then
>> +        warn "downloads unchanged - not saving"
>> +        exit 0
>> +    fi
>> +    echo "s3-cache: saving ${object}"
>> +    tar -c -C "$(dirname "${downloads_dir}")" --exclude='*.lock' "$(basename "${downloads_dir}")" |
>> +        zstd -T0 -3 |
>> +        aws s3 cp - "${object}" --only-show-errors ||
>> +        warn "upload failed"
>> +    ;;
>> +*)
>> +    echo "usage: $0 restore|save" >&2
>> +    exit 1
>> +    ;;
>> +esac
>> +exit 0
> 
> Thanks, applied.
> 

BTW, the artifacts pushed the old way, those are purged automatically?
Just to avoid storing now useless bits infinitely.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
