Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C620E2
	for <xenomai@lists.linux.dev>; Mon,  1 May 2023 12:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAoyvvBJlUrnKvuO5S31A46rxIU4eVsJxhv1QbsdSbfZEDWudluFFnuDxm7IqLWB7TmYNMzYncFohunGeY94LNDLHqLk7x4sAwsw8RNyCJ9NfMcKW4w1y0RwdUsmLtEAfea64/KpymT2bQZkzLnW2inSs5VkQfu6ys1nK+UKmYg0XjYUVv56ZpV3ZSOqRoOCtZZfZtql2cfu8bojnaFUfcsoeVGG5PUU2t1CUEqq+LJUE1gpXSJvBgMy3gbQG4drmryXa50NgJxgGDehoOk+MEWSvQKxuMBtn38bl0gU0nVMMC9x0uZyeK1mpdprZxaNFEeSEGA858whPPthVCV6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0VpKLZIIfr0in5Tl2vvv3kAI0XJBS/5NBE2lxfW6PA=;
 b=ayAf3PuWdAXeMT05Z49ly7V+6DdW8vxXX0eweXqnFybRs9Q67ou+Hq/ElSEY/Vk8ha9x6t0WB1yjox2/T+KP8XOYTv1s8imrOniBxqrDZP5BWrgS5AdYfxH5z82dF3+maIDdvHWPxh7cPIzlO4bjzOYg5ueFX78zQiYT6dUQDHRaqpupQE/XQHw113LQcYziGR86uOatl5qZiLXo6ywipbdWHy15neAh4T0VxupYtwrGOfkwO3WV/gqLLQnmmzfO6LvVLye4vh/uQW5/Xa0EQqhiCragydkwhOVd8vEdFJeYm48eWx7EkbroI+E0fa9JWCSncxwaLbmaD/VRW2/qdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0VpKLZIIfr0in5Tl2vvv3kAI0XJBS/5NBE2lxfW6PA=;
 b=N/DVCwq+HcYdDKwIYkssy28c/zApxr94bU1bjAEskE0E2duKa9zCmm58lVwAoh+8Nlx5qgclt5vqhWJZyOUw2AiD8+03Uaj4DsaHwxM3xkRCTUaNMp6aZZfUOiBGebqJyXYCIYy9zCfZ5SNUP2H8K3vxkEXBH5ynBOoOkVoTKRK6qA8lvBXmTfoTKfR/woiXjCTBeXVlGwzMVMSgBTM+9J2lNFPXVHvvKbONBMukIHe3CCqJBYx62KvsnYbDuRBdRLl1ge7jfPvlU/qAcrBvU/dlHbOA7cleuBe+/c6A6Cu0h+zQROnWAjXD8vkZ/bvDfXvT5/XMbBEQUNJeo6f02w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Mon, 1 May
 2023 12:04:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.029; Mon, 1 May 2023
 12:04:45 +0000
Message-ID: <45801c6e-7def-d5da-a889-d6e3c8ba75fd@siemens.com>
Date: Mon, 1 May 2023 14:04:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.0.14 released
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 374b3b6c-5b2a-424c-a0a3-08db4a3c4136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sGKZL0LDYJDPf5U1tQlOHpTQehapTDLN1uS8KhLB+3LLdTRVOgrX6XNk9/fkoVd1D6IMjO7rveZWYVrbKrySS3C1XYvRrqwGRJvaQwOTrdXhOAdC3pRkBrM1NSEzdQlDjzdLhg3SNrlHkqriKlify7RbnpMab1gV5bNv4XSFGwLS8GtJTTilgBlfRIzlpjjN12pdRb5wJXaIQkA7m+apaLS9XtFe+UY7iCEk0MXEVOksCkVLdVzUjArQpmeYYqYK4607utvVeDW/tlyfBu9adt73RYUfQ8/LGS9yS56F5fNAnO9cL9EE4v/Px/Mpqx3DM13bJck1l+mTKRFX/eaWLNLSmLdgAOdgA3FDi2jjqfC34XlYhdNnNjPun6x4S1j7IfLwe3CuHwbGYSyuH2AmYpolZZG6QAQIqGnIWmFAcRYxp4wJIEtzm8KRaKij5Kk2yBOnQBQaxBqaaoOKwV235PvL4Dedzt1L1qTOBnfwooAN6AkJvGGb0CmnBRxPPB2qMnZZ04lNOe8UvdaAMSqWgqhkxI5zNzgWN84Q7q8+T0j2al4K9Dhx2UNdqsXkuim9b9Ro70466P6UKgp1YyhkbiF7B31NhlZtrsyZ2X30vI1QFIxofeWGdXbOCMW/Wx2Jf3ELs4Pgzix5BKSlpAG7Zg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(6512007)(82960400001)(6506007)(26005)(31686004)(38100700002)(6486002)(316002)(41300700001)(5660300002)(31696002)(8936002)(86362001)(8676002)(6916009)(66946007)(66476007)(83380400001)(66556008)(966005)(478600001)(2616005)(186003)(2906002)(36756003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3pxSm5mM0gyQ0ZxdXNuUnNyNEhTMmJuRElLTFdaRTZ0cUhTcTdKaXVlbkl1?=
 =?utf-8?B?c01rSTVUYTBuN0poOVE3L0VKdUlicjV0M2d1ZEFXQThxcjEwRlZJWnNJMXoy?=
 =?utf-8?B?RXpBa2Q3U2tOOXNwZU5hQzJ3aWpoT0VQRUtiQ21odkRGc1BtclVHV1FOUVBl?=
 =?utf-8?B?cnVwdk9vUTFmUkRQRHBSQ09EckVkanlnaVlTYlVsWnhXT29zcGlxMGdPckI1?=
 =?utf-8?B?M2Y3dW1zWVlNRWdZLzM5cU1maWxMQk5FeitaaHY3VXBKNG1RbVBQT0FpN3hs?=
 =?utf-8?B?Z0xBdFVnL0N3TGpYZzdONDV2czhPTlkrTDIyOXJPV2FTL0hoZDRXR1Y4SUkz?=
 =?utf-8?B?Q3dDeHZmdTc2MXpKdmEvOTQrZ3NuQ0thS1hYZ29pZ3NWTldiTkp5dzdqaXE2?=
 =?utf-8?B?S3JvVG9TRGFtOHN3SWhEWkkwMVY1bnNLM1RGVG1rTHNJVWk1b0tROGZadlMr?=
 =?utf-8?B?ci91SU11czM2R1ZXcURLZkxSa2JxSnNBOUkwRXZWTlNycGs5N3JMUVFLRnpU?=
 =?utf-8?B?TnpEZ2gvdnErRllqWVFadFUvWHdZK3hyaEtkMW9MRlJsT1hNNzBHUFFZazI2?=
 =?utf-8?B?cXNoYlhXS2FPZktoNTNBMGRRRjBBRlVLL1lqaXhJTkRPUHppNUduQ0p6a2Ro?=
 =?utf-8?B?QUFtVmVlaHFoYUJlaXhpNUQ5TVIwK3JLc0hDUVUveDREUHF4V3NXTHN1Njdi?=
 =?utf-8?B?ZnMzWVNZV1lEUkQ2eDBrcVdrWEtCSTFpQ1dPc0JQdzBqNU5WcnpQeVVrOG9x?=
 =?utf-8?B?NEY3QU5ybHpodEROcmprU09PeEw3TnAvNGxRRjlKRlkwQWh6SUlKR0Nnd3Bs?=
 =?utf-8?B?elBQOXFZZDVibTNUcko0ZE52MGV4WkNSZWdBWjNlUy9ZUHV1eUI5Y0VWQVZX?=
 =?utf-8?B?QVd5V2F5UU1qSG1NRDZzMHQ1SHl0MkhVSzNOeEhQMHlBeXlhNnV6dnh3U20v?=
 =?utf-8?B?WlVYYUN6Z3BHUTlidVZvSlZRV05pcmNvbmxpdTUzelpQZTRkMS9FTERGaUdE?=
 =?utf-8?B?UjNRdlNLSE14S0dOOGdUSG1NM2tpRUpUMHBpSHZvRVBRUXhJOHJSYVdpbVY2?=
 =?utf-8?B?TXZNN0dMRXNIbG9VUVJEeGt1L2xUR1lTOWxENHBUQmNaaVI1blJNelhja3U3?=
 =?utf-8?B?L0tHT2VkOG9Dc3RGamZ2ZFFPdWFDMURMRXBBU0NOV2JZb1Zhc3crSEdwU09I?=
 =?utf-8?B?c2JRQU8yRDBzL1Y5K2p1N244RzdPVXBYT1RvYjdrNEVKaXNoMS9yb2x2dHdO?=
 =?utf-8?B?NkVma3F0RUlhS05IODRsZ0Q1Z1ZQV0lPQURnYXluWkVOL2RCRjh4bmY1cTBD?=
 =?utf-8?B?RkZzZGNJbjA4SWc4ZW04VUxMUEE4VjNZMnBzMUJtK1RsVTdnc1JNaG1EbDNy?=
 =?utf-8?B?d1RGRHIrRnpwTzlqRmtxOUhNckJqK0thdkhub09TSlBhRzRYa3E3UVpyZkpL?=
 =?utf-8?B?ckxTYzVHWkdrems5TVZ3VFNkYzRBSVlDWkZUUnFzOUpjQ1BRUG9CUlJRWnA2?=
 =?utf-8?B?K3lORlFkaUd2a3BHRis5L0VuV3JBR3ZGMWRYeXAzVHMxdElSeWNOSnpOUzhq?=
 =?utf-8?B?UTltRkdpVklsWGduY0pmekdiak51VEdNNVBYbVkzY3krTzZUOHpiVXR6MEJN?=
 =?utf-8?B?SE9abVF0bFh3SGowTUphRHN3S3RHYTJxNUt3dno5QUs1U3RVdEJEbXZGZzQ3?=
 =?utf-8?B?VFliTUxPczhlNk1pU2Z6ODdTUm5EK2RUcDlFYUIxNVV3MXdOUXBDOE1ES2Ix?=
 =?utf-8?B?ZzRyOHg1TlhnRlBXR2NrVTBCeWdIUkhXRTdkTVNaV0JYM0k2Y3N6amVZOFpn?=
 =?utf-8?B?QUNmZFRMWXdCckQrTlMyamVKbm16L0xFbkFLTURYS1hFK3I4MlBla3BKTGx0?=
 =?utf-8?B?TzVqQWE4cmVIa3Uxdkw2Tkh5Tk03TVFodFRFSTdvc0dkcHEyeTJMeitFcXNQ?=
 =?utf-8?B?cGxYTTJPYlU2YlVxbExDUFdXREQ1aEliMnpVSnBWeDM2c2NpVXN1RzIrUnBt?=
 =?utf-8?B?NXR3bzF6SUhLeXJQc2czVkpnVDV2dHR3RnZyOE1KdEgyUFdKaFp6Y0ZKSi9H?=
 =?utf-8?B?NHFnWHgwWVdNNDNzOFNLOHUzZ3g0cTYybHV2NjRTRTFCaXdRaXAxaUhOMDFt?=
 =?utf-8?Q?9LxVS8piTs/QzK/F1r8LrW4du?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374b3b6c-5b2a-424c-a0a3-08db4a3c4136
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:04:45.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTrmIbAY7bvbYbws/EXElFkG2Nnsxu8S1VlvX80HaXLsb9ABmkXrTjwCitxmf/itZdJRPi7lnTrm7i+EYB26ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6195

I haven't heard anyone asking for 3.0 anymore. Therefore I'm declaring 
this the final release of 3.0 series. Please migrate to the latest 
stable version of Xenomai to receive updates in the future.

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.0.14/xenomai-v3.0.14.tar.bz2

Changes 3.0.13:

Florian Bezdeka (2):
      lib: Fix fallback signature of pthread_mutexattr_setrobust
      lib/cobalt: Fix possible fd leak in __map_umm

Jan Kiszka (10):
      lib/boilerplate: Convert pthread_mutexattr_setrobust_np stub into inline function
      lib: Switch to pthread_mutexattr_setrobust
      lib: Re-add "static" to pthread_mutexattr_setrobust fallback stub
      ci: Switch to native trigger
      Fix several sign-conversion warnings in interface headers
      lib/copperplate: Release main threadobj on exit
      lib/copperplate: Also deregister main thread from registry sysgroup
      automake: Avoid usage of user variables CPPFLAGS and LDFLAGS
      lib/copperplate: Add libfuse if building with registry support
      config: Bump version number

Mauro Salvini via Xenomai (1):
      copperplate/clockobj: prevent warning with -Wconversion

Richard Weinberger (1):
      alchemy: Correctly translate return value from pthread_mutex_init

Thanks to all contributors!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
