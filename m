Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F163FFAA6
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806723; cv=fail; b=QSd1Cq2LT8Y2GtYCk9qwcx2o30r61MHyp8dvujPi95OvqlIpj66FkJq5NeXttJWKz5wvP++OnTtDDK4fVDNcZBsiYFo78WuM3JpIGpEPHrs91Os88zOIk32Djgn5F42tlCC+OLr+axFaurCmfAu9oQMNHdXG87a7a3KjrmYyELo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806723; c=relaxed/simple;
	bh=2km/dzLMq4phOEsS7lkk2yIQXoK3/tRRFjuiFO3k2q8=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=dNrxi3a8p7d+Jc/9BNJ3e5EAqy2sxTLal2F+W7U6ItENT3mxEYxk1qIhBAzwppW3ppVYC4SC91Cm9LfX1eS+5aOfxBLgJSCSH/qW7pkq4tfW+uXG0jW+fV4tmLe6qNWXHduqSCbdFEzvCGiARgRHfxF8yv0XFjyGkMe+EtEd8Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ljC3KRaz; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ljC3KRaz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQmXZqQc0JLDjVPCYOLdD5Qokew0Li0UT4Jk6JVnYb442NAubb7766ilRyKrOJUoOIi2zwcpcsXWU76wc9fggeWxVTA3YiuL59Dr89iQLpxqkCcq3Z0v2gSKg8SAKQaWpFtI7Y4/ExMuv41h+2CjrWo+1UbV5PxUaMGbr6B+QpJsHkICY9IPxp148DBlFUDb84TdKqImTzrQ/qiR+F0PaiI3fkYyew7BOphjX1zuNww04S+SH18uTkCd3bZsbciJxdG6rfwhuyPrpDQdAW9MYasWQWaruvcIQejOOZQxwHX12HBf5p4O3MuCJkoi7iuqJjqdHO7bIEOoDuJiITsnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXx1NhJ2Kr4tsHcRwHbwH+j+81+3UMkEW+GXTJSMFbI=;
 b=GSLQ3k6e3BbhOdHaiXNy+mg/TPEGgKrymXyLC1nopEgFUIcUI6iZuD5xwj1ZcPWBliF+ZLCvtOUSRH2NtVStZibowaG+5m+Fmj4oMzUGe20AssSwMoGQs8OG8hXoQ0PAITIp0UDp/ohnXZtePJqMVqohRvH8ur+/mNSbplil9+/fnCoBzw2PxYbOsbM8kLU/9Y68tyGcf4zuYilQc3sXcVFfylCwXFTBeNVfKo5wzvXMn/PRMSkYw4HG52WUDr1sfhhwRJ6ypmqx9eNjQsH0pYXLzPzoaAG+r370/g0hxowKNwWtC9Y9GUHAbBL3Ke9omBCmilO5ZOTkEkYjpV7cFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXx1NhJ2Kr4tsHcRwHbwH+j+81+3UMkEW+GXTJSMFbI=;
 b=ljC3KRazFb73FkuD0iLldot6dXkIMWmdzjZ7paVCCwCBsQ2tdNOUFkpckVtcV0lL/LtOLkb7ibu+5ln9TBso/+jz3fjrO0/GE7QhfMcdSQOTF65iXfKaYeCG/q7BbVYcmN2xjT7AhwOkkyteavNIjXzt3vuDIRGhZlPSdxJy6We4bvzIhZOpGgQesy4e81EhfgXBl9bHODiRautXM4ndq6j80VZUZt0JfzsfSyRH8otQXaZeTDpZKKRfQ5uRkZ4L0M9ERKbNN/OBrZedrTPU6QBEb0v5bekOneXsPvIYlmk0zWhMHXaIw4bQ7uWe6JhCM7AsRY95RdovXcWc4+R+gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7689.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 14:45:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 14:45:16 +0000
Message-ID: <2b67c0fa-e7d4-46ba-b0d7-77326bdcb45a@siemens.com>
Date: Tue, 26 May 2026 16:45:15 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: No Community Call tomorrow / Embedded Recipes
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 390ed95c-260a-429b-d015-08debb3566c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|11063799006|6133799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hnjeui1cOqptvoHbmIkvALNaaVQu6wasiNUwJjNhVZYLi/rIkmluWSdNT7tmJ5fH03n7hEckKF9llrGFCcyEV4+TzNbEKBScw5yOeY4P5lVWWT2Yszx/HDR/sHUwbHtSGwmJekx6n7xTcAX/ZZO5QTgWjLUWYYRc8H5k26sn+3g5wiey8ve5/h3VkAAYosCdH5CXi0IhwqgqoFYoGgcb0MZ2PTeve6/pAh1B1o5cIQlTm0LOaOwzAnV4+/VrYtE0kjMQpUDsBDNFP1u50SLRnDyhTNOfQjLzN090wpn9MY6ZfkRvbR8w3q5Q2ulVNa/0BNe8it/TC+0VRRZwHWS3OGxj5mstH3RAiFkd9CUu6GbwEUGviXUm+MLKtg2q+AE6mXDZTd6sAgRFhO6qvjB5xXgtAN6yF0Iix2/Hrz1oWw5LzW/sZj55fABnuClIuHdmkaqQgL9xLq7YGHdCyWw9IfsDwUay006EABx+eaDdcT8g8n8o1Rtl3RpXnmYyXcHucFbJJbK6BCxoPWbR7pApBoov8AOGhe4sjBuDHisZoyAOGsILMq6XuoP0fj5rDVuJiti0Z1IRZIH/lgbXeuorfaK56kdEXasF5sgQsULMDL6a1jVnkqCIuRKfZriamCJro00Ibsb2pNMw7VJB3tA1fgyVYrddII/6AoNcFODiLU4ghmRjNMNPc8cpCCrSf/79
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(11063799006)(6133799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVlWSnFzSE9uNHU3RG9tR1VObllNWldnYWRYN0lzOFQ2dVJnK00rcW5makFp?=
 =?utf-8?B?M0dKR3BLSHJxYlMvdGJWVE1POTF1NTE5SkdBS0lUMlpjV0hHMkRwQVgvWWNO?=
 =?utf-8?B?SkRsZ0MvTmwyZXQ4ejdnQmo0UzRqdW01SjQ2VUx1SkN4d1pSRDhjZzY1c1JD?=
 =?utf-8?B?K280RlRreHpOenNJWmpSc0ZUc2VoUkdDa2M0emR6OE81M3dVVkJsQkdCTkkr?=
 =?utf-8?B?TFlPeUhYcDhMQnZpTlQ2TzArTzBEcEplMmlxck5xNzNsV2FqOEtqUldtQmwv?=
 =?utf-8?B?Q3IxdHZxMFVYOGRhNkVUK1pSNitHbXRnc1ZwVy94R3NkZzV0N3BRZ2g3elVo?=
 =?utf-8?B?Tm9UUXF3MUhzcExBN2Evdnp4YzNXdDVzYTEyVGFhWlRhYThia2k2OFEyZCtL?=
 =?utf-8?B?NDlJYzJVaEpDb2M0NjEvUGRnS0hTRUo1clQvZ2wxbTYzODczZ1h6K0NiVU9z?=
 =?utf-8?B?aE9neEJUOWR6TzhqRkZkNTk5S3lkQ0ZZTDExVHNuc3pRT09OK0VYLzcwaHh5?=
 =?utf-8?B?dG1FaGJ4alI2NmI1SGwvNTZzMXhFcC83QkZ4SFM1QTlrb3EzSEl2c3lrbE4v?=
 =?utf-8?B?SFRFSnBQUkh1U3VKR0MrczYrRFNqM0dPR0txZmVtanV1VFEvNHhuYjdicmJi?=
 =?utf-8?B?UHF6YVV5VnhjVXdRWEIrR3ptZXNEZFM3eFUvR1FPQVlFSkd2UkcraUVGTlha?=
 =?utf-8?B?Z0xPZ0xZNHFVaExRVGp4azdKMHBJVCtVWGJZR1RydHVrbllWckdLVUV2MDJ5?=
 =?utf-8?B?Q0daSjZjREluM3ptUjNrSHRGTVp4WExXaVZBM0thRzhnZXpEZ3lZMHlnSmkx?=
 =?utf-8?B?N01FL0wzVGNrK09weG16UFduc2dCTnl0MUsxWm1nbkhtaEtLbXU2Z0hMQXJW?=
 =?utf-8?B?cU5Lc2NraVdDR1EwL1JJQU14dDN0QzVteXRNeGQwd0Q1WjRHN1RML2oweENt?=
 =?utf-8?B?UVBFSTRJN0VxTzdXakl0NjE2QWFyZHErRTUwTldGY3owZG9zNmlZZHVlY2tv?=
 =?utf-8?B?YmJOaGs0R1p0MlRFQk5xYUdCdmVlQWVMdXVvMGVHdXY0ZEFsWFVvS2M5WFlS?=
 =?utf-8?B?eGo1WkJGMUdsN2g1UzdyTUQrYmxvUzQ0UkxRK3EyYWlRVWtaTHd6djNraWhz?=
 =?utf-8?B?Z3lZQUlRYis1eFZnOWVYb3hhOEdyNXowSE1ZeVdCY1VmcjFkVGxzWCszMkts?=
 =?utf-8?B?TzRhNUJIdGlYOEZtQmI2WEFldVRodUozRjRDV0FMZ3MzMTFveGxwbGhadHRp?=
 =?utf-8?B?QlpnTXdEbDB2VkVkMnk1SVhKSW1MYmcwQlE0bmNibmZJK1doeGdySHRkSk9D?=
 =?utf-8?B?NWg1UnhBbjVkZzBlaEZIQkdOby9YYlVmc0dqeDg4SFEwQTg5aHE1NzluYnA5?=
 =?utf-8?B?TUJ4WGQ3eE1QK05zMnREUi84ZW4rNkZXUW1tTlpETlU4L0FIRTN4MUFCSkNP?=
 =?utf-8?B?WTdlK1RwMm54WFpoU1JjYTl6MVNXbGhuREdvVHJRWTd5QS9ISG1zZ3lIUzlm?=
 =?utf-8?B?czU1TUtiUFZyV0hnMmJVVzNJWjBhYTliczQ2Z1RJYkxWbWdGaEpYZ2loM3hk?=
 =?utf-8?B?bk1PaTRkajNzMjdyclg4WE9qcG8xMUR0SXk5U0dsNTFPaFBPVG9XaDNKLy9T?=
 =?utf-8?B?RVloL2cvcHhOd2dyYW15Q0t4aUtSSXhHOXZ0UVVNYThDNEJKck5MNnkxdnpU?=
 =?utf-8?B?TElScEFqK0VGeWhYd093Y2pod3FsQTNOSmh1aloxRHZ4TENMLzhtSTI1eUxn?=
 =?utf-8?B?dWhLdjVkdHNXdFI2eGNNMHo5T3pqRjh2NWxpMU16NHpCci9ZNmpXRTJGZGFI?=
 =?utf-8?B?cVJCQmkvc2FJcVZKZDUyZjhDcnZmdjF5T0Q4Z2NuNCtTcEpHdkIzZW1nWmtl?=
 =?utf-8?B?RVdvRXAxZXFFMksySDlyVUg2Q2JxTWZ6cHFVL2hraHE3RGdiNXVodHByWTNn?=
 =?utf-8?B?N2hOVHpuUmtJMmFzSmZUc1hZRFFBNEkyb2lVaW14WFhBanh4anhlN2RveXpy?=
 =?utf-8?B?TWhpMlFKT2N3bCsyUjlSdGYrNzlXRUlFcUJRbkt5VmI0R0JIbElWalpMYWNq?=
 =?utf-8?B?NlJNQ1I3Ynp1MDFQVTcrVTJDL0VkUy9uV0lVSE9ibGJXNlRKZHlkZjhzY2RB?=
 =?utf-8?B?OXIzZS9tVHQxYk5USms5Q2pzZnI1ZWFPWldBakQyWE9ET1ptQjhEaEhkWjFJ?=
 =?utf-8?B?Smt1R3p2Nng5T3J1NWhrQnpqK3NVUlArUGdaa0NGQjZuUkxnRGgzeENTZHZI?=
 =?utf-8?B?QUJZMDFKZEE4MVdMaTg4b0pHQTBMMTRqVVBzeDlsS0NkbmVSNTZXSUFsQ1ph?=
 =?utf-8?B?OTVtNExwTERCRUg5bWtLVXp6b0NtQ1BXOHBOcHZyVUtjWS9mQ1pHQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390ed95c-260a-429b-d015-08debb3566c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:45:16.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iogtTpRspeddzjsqOg1fV1Dvmf9BwZ9UJZuD/kI+c9LNxX8Jd04giUp8oi+S/usWGkR0/c7PCUrVSeqhAZJ+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7689

Hi all,

just a reminder that we will skip the regular call tomorrow due to me
being absent. In fact, I'm at Embedded Recipes, and if someone else from
the community happens to be here as well, just raise your hand, and we
could chat live.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

