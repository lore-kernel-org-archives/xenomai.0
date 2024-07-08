Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016A36B11
	for <xenomai@lists.linux.dev>; Mon,  8 Jul 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425263; cv=fail; b=cemulZ2KFPmNPibkqQYUjZ9KQAxskwJ9AsX3fEIOU0Q+52jX/ajbhH0jFeIfnFvgRKe6N3kFjLOvIIkyJY3SxgbOUNFfsGFyKX3Xn691TwwulSCyXfKWcAiiPPu5UMwAdJZ0i3ch7w69QS2O1ogBAt4eyTfyCOqskwnB72NhVHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425263; c=relaxed/simple;
	bh=ZgogA85o7xRk8+Z6jr1uOZ0v7ilvCGqbuMzV15MAkog=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DIjoeW30gaLaZKrUSs6o1WSG8JZYkGCoar/0rTMWMVF3YVqIHZwKtzVN1GtORytYxr9Kd/2AhgvMp4bKWWmJTy2A/cEUi7dkQY3EliWk/QNPFvi/egXWi3JRQ72QnddjLfX06FsqCn6EHI1blTbAHMp50cb2s3ddtvUG4MuxcJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jSvvhvtr; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jSvvhvtr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPiNlRBGwwXAZ7YdZwhXBMnRGcqpoXMtVVgV6f1NRcMX6WHotNSDEIr5cuRyGUPKukkiRYU9hScit5+DKorqX7S7r0M31guVGuFxsDp2m/CLY9GpVXTn0T4YmzTdnwIcq+g9H69fUQVEnfzdXlc/05+FREW3LjjR4L039500wl3MvBPp1nUXegPnyriZhK4N5oVP2mtXhb9j/wWQselaQHdegL3OnotvaXcbiYFCTQgYIShn6LHkoe3mDOdTI2jUBbl88jxE0gZ9ZaUlkKZzpJM8LAcFlbfyryW140JgMqdBzGYWm4R0DPVYuu9GrF63GbldxQPeRXVyfPk/9/lL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U30RnYC9nGFyAteBsSZ8Vk5Rx3ILyJM5Y/WZQBtJGI=;
 b=T4Tht9AGPQ4kUchr1DgQWlOEaXWUCb2mvYU3o3psh4/abuOWEpMFnq9Xvihm9PA4SqsRGc2LpMXKFgqkF0PaX/6g38jOZo+spqwgR0K7pILPbrHRyid3563o6i93NbhHBPLqWnTpGZHgWt5/BaO4X1vVtClWXsXJgDats85DzcmDUtc88N7xdUk3Qd471Js9QSsYzUEb7H696ICEtAzuAI8ZrjSHdjFdbE2LI5vIG01d/noKiHyEUAXh1bh756XSxpIElossuIMyGTv9EU1ABgdGmXldi5OqT55vvf9moPLPkgzUXO6f2dWHFxx0vF9aMSCZ5oRmCBS1AdzA2c4Bjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U30RnYC9nGFyAteBsSZ8Vk5Rx3ILyJM5Y/WZQBtJGI=;
 b=jSvvhvtrBqV7RtwegMtNHSfRu25a6WMCHCEwqD2Aez7wuoZ4xMUdRC2PaGjo4gAaBgXWsuJV15wj/NNjOAT+cZ61fH5ClIxPblPM0B7xcINkcfOffBHwCe8Zfp8qcrBtILvu7PCoh3qPEHEY5FOSz4NjaCnxVtdvuxxJ23WHIiDn+S+EgOkBdxbza6dcHWa/7u8SDbqKjn2wOzg2V8vgCNaa33Bk0tPsLWJl6bUEFm41e8RQ5krrfOi258yDhWsknPlXVdi7nGEg53trBP54S6AEUObXqd4APIbLH+WfKPS/HhY8AY/4yFCkXo156IXyiJ3mXZ5dOgj554vY2Sz5Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 07:54:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:54:16 +0000
Message-ID: <b9d451ff-3927-47c4-8b57-7401d712dedb@siemens.com>
Date: Mon, 8 Jul 2024 09:54:14 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogS2VybmVsT29wcyB4ZW5vbWFpMw==?=
To: =?UTF-8?B?TmluZ193ZWko6Z+m5a6BKQ==?= <Ning_wei@sgssemi.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <3f2cdc0ae2804139b7d7ff4112466647@sgssemi.com>
 <92566754-82f2-4f09-a870-4d0ce4f68648@siemens.com>
 <6e1b049535d04ce1968fb1e0ac2c7bf5@sgssemi.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6e1b049535d04ce1968fb1e0ac2c7bf5@sgssemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 3469a761-8f46-4013-51d3-08dc9f232a74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGZ3YWxIT0x5bk0vNURxUHpLb1NualZ1SC9yOVBwYno0RFpZSHZkVDJxYndl?=
 =?utf-8?B?dm5vNU14bnAza3ZjeDZRRmszY0thWExrbnVVTFFiZW93dllNdThGSDFpVFNQ?=
 =?utf-8?B?RS81M0Z2NmhOaGhSdUFFakRDK1NaK2FocW00ejNia2s5S3k5TS8rM0tGKzR4?=
 =?utf-8?B?SDRXUURwa2ZBb2UwTkduS0JTNXpKNC9OMWYyTXVnVlBHOUgzOW5ianpNbHVj?=
 =?utf-8?B?bFJrSjdZRFdUbmxRVFVMYmErcjkzVEFuNlg3SjFwT0VmSXNqZU4rc1g2M3Q3?=
 =?utf-8?B?T29UbklyUkMwcUZmbkJuVTRhRWMrWXNRd1V1SzJCZ2pIbUs0ZEIrQTBUMS9X?=
 =?utf-8?B?WkgvRzVPMVZMay94SlVhSjFXMHVwR0dQRDhzb3k3aW5QOWhPSVNzNkVIVlJU?=
 =?utf-8?B?V3p1RC9BRXp5RmlXZTJBMkxjSUZUMFRqc2c4cTZTUERWMDdwNFBlUm54aWtJ?=
 =?utf-8?B?ZjNjYm1PYkRFaXJLeEl5ek85aHV1dEY2NXlKOUFTNnJ6MGxTcWJvalF4R3V4?=
 =?utf-8?B?RGRCYm5HTXZVejhJcEdzRTV6dURWNDAvYkluenFyVWpnT01oUHlxSUZHWWF6?=
 =?utf-8?B?cFkwTklKazcyOG00Mm9LL2RDMEU3bGdkODE0SUROa1oyL0ZsTGpPTW9rbUVr?=
 =?utf-8?B?blYrMExwRld0S3NqQlhYVDc1SHhBRTBLVC81eEpMQU95aUhrbDM2cXZTQTZJ?=
 =?utf-8?B?SWVVZXY5N1R5eWV3RWxlR0tWMW1FQU5CZjYrLzlpZ0Vua25ISG9UOVBKRlEv?=
 =?utf-8?B?MVhYc0Z3elNWaWJVMG83MWZ0c1AweTlPUlFHQ1NsaHZLK0hXTkc2b2hyeE50?=
 =?utf-8?B?eFNQOFNBMHVGZTBRcXdzVmNTVzc1OHBNS0xQZXNTWmZYZ3VOZ0ZZMXVmVUpz?=
 =?utf-8?B?ekNUUVhpd2U3ODZDcXZZMXhlMEJIaTh3Ui8yd1NKeTN3cytIc2liOGcvUWxl?=
 =?utf-8?B?MWZpZ0FxK3I0WVRQdUpwVkJhN3gyS1ZyZGpDMnZlZ1V6QUxaYlZiZ3FTSFNv?=
 =?utf-8?B?bk0xQmh4bGJpVFlJY2QvQXJSd3BRcElQRzl2RURtbzNBeUJOWVZSS25iam0z?=
 =?utf-8?B?NytGYnZVMjJTR20rOC8wU01LT0txcEN5S2pMUGRSZEphVkdKUnAwZk11Umx5?=
 =?utf-8?B?ZEdzZC9LNDk5T0dNT2lpSGViNzlaS1BLd2tFZk5yU0F5dHljM3Uzc3BTQXh6?=
 =?utf-8?B?a21hdFU3OThPaE8wNzlTQ25EWWJGd3NLZ09CcUxMUTdpdEpEQlpEeFFkTW1W?=
 =?utf-8?B?ajlIY1J3a3ZwNmNoUEJqWXB2QmtSaFppTXF0QUpBMGVQaTFoOXBvaXZ6aDd3?=
 =?utf-8?B?cjJnUUR3VzlodnA0YlZpMlpGdE1zaStQZ3NORk9UbndYUHFJcWdHRk43QjBW?=
 =?utf-8?B?dmZWczhZNENQUjBpcGxrckRETndEMjBHYVpxcDZGVzVYUXlGSW5tcS9Ja3Ny?=
 =?utf-8?B?T2dDY05XZGEzT3FrU0ZwQ0RnQjJGTExySGJoRnVFZmZDL3dVNi9FU24xQnZU?=
 =?utf-8?B?QVVMaXNnZWxhTmM4NEMzZFVjZ2ZWN3Z3b0gyY1k2YSsycWZ1WHFSUmlWem1K?=
 =?utf-8?B?Snphb2RkbEVmQzlZNkluS2RIT1RscDVybSt0RTJqR3c4UlJlM3NhZXVTT1Nr?=
 =?utf-8?B?bzZCazNEdWtaaERJeVhlNUNqM0ZOcFhrZmhVL09lWUNwQmVsWmEyalk3OVpw?=
 =?utf-8?B?S3R6aXVvS00ranBQbFpTQ29kc3ZVSDhaWTZXbW5xeENQSUR2SlQxa1o2Um0r?=
 =?utf-8?B?M3ZkZEoyVVhrSEY4c0R6dE01ek1NUUYzeEgwZU01RzMxdytRaEw1Z3VSajhm?=
 =?utf-8?B?MWhtNDFHa3c4NHl6MHZpdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WC9MUiszL1MrYkFJcy9sTkdZeUFxT1NORFNvS1E5amxnc1pCaGt3WE5ObkhK?=
 =?utf-8?B?Sjk1RDczaWF1QzhjMExOTW5LckhQcElvQjNScm1ZV0RjZkdtTHdXeG9lSTM0?=
 =?utf-8?B?cG9ubjBac3BuZVR6ZE1jQlcxSjEvd2N5WFd5WXJXR2xKaEI0anY5WmVZekZL?=
 =?utf-8?B?ZzRhSy9tOVk1WUd4bzNld0pkbW1iNUYvc2hBc042MGVLeVBhU0FaZldHU29l?=
 =?utf-8?B?NldPVURia3VxNWNCTW1aSVhyZWNLeWQ0dEdwNjE4dm9DZGRvSEJQVVplai83?=
 =?utf-8?B?K2ZpS2Q2ZFdFZGMwSEtCSWtYNkFoc2RxT2s0QkVQaGNDZFpjUVYva2VwV0l4?=
 =?utf-8?B?aVZqVTBLdXNLN08yN2lpQlVFM3BOYXNCVDFNVVZ3MjBWc3g1UDVMNitjNER4?=
 =?utf-8?B?MXd6T25tV3cxck0zbXozK0xZQ1cramJsQ1NuMnRWREo5dDdDUUV2dmJSRFhy?=
 =?utf-8?B?d1VuaFlySUhOTFBUd0Yva0t1dHczNlRHbUJjUjNrWXp0U3BHZTIxSDF6VFN3?=
 =?utf-8?B?cENsQzRncDBjRzlEWnJVYk0yNkJScjZTZ3hTMS9xTmFZWHJrME9TMWtoS0dO?=
 =?utf-8?B?MXBlU0J2ME9QclowQXkvR1QxdE1saGtxMGhRakFpeUQ3eDFZSDZEbEJhLzUz?=
 =?utf-8?B?UDU5ZFkxZU1DVDFlUUxTSm80SUpHc0h2Y2RyYXBBaHNaejZPeU9lU0w4T0py?=
 =?utf-8?B?OTJDYm41dkNnbUZmaGxUaGFrYURkY3FLWmxwZC9WOTdOWURUS0M5dE85ZUNZ?=
 =?utf-8?B?bUpxL3N1WWQyZTVvMGJndU1sMGl5bHoweUZJejUrRUFxbmV3OUIwMGlEOUJZ?=
 =?utf-8?B?QzJWQlEvTTJBVUJxckVCaVo3K0RoajdJdUdRUW5PVm5BN09BYnN4SzN0dGhC?=
 =?utf-8?B?YXFpN2VuV3BWeHI1bmxTN0YwTSsyMnNleS9NQ3QrTVpWdDU1QjBqUE13QlFR?=
 =?utf-8?B?TWVwd3M2SmZBM0hNMU9Xb29nQjdzZjgwTUtBTXhnM2M3Y2NHOUkwVFA4TDR6?=
 =?utf-8?B?ZlhjTVZTbHBOaWs4VWtpaWhVM1o0aEEyZTg3T2lQS2M0OTdieWY3cER1Ky9H?=
 =?utf-8?B?elZRU3paVSsxaHd0SWtVUWV3NVpvcFpHRkdhVndKWU01THNSRjhHNXovclpH?=
 =?utf-8?B?OHpMOUhUYUt1OTNocUs1aVl1NTM1VlYxUkd6REdObUhrQUZFaERoWnZxc0pV?=
 =?utf-8?B?UVJRUnlWS0Iwb0RFZkI0bnRPLzNCSkt3cmREUlJ3ek4vdW55MU12ZlUraGlB?=
 =?utf-8?B?M3ZqVnAveTVlU3ZlRXR5T0lHN0dRWDVCMndTN1lLU3RJZnE0SlplNGowWHhG?=
 =?utf-8?B?WjcxSWtSRW1JeXJZeDY4K3I4MVJlVHpLVmd1aUhyTUI0cGZOdHMyV2FjVlBv?=
 =?utf-8?B?TlF4eEV6WnFLbFFwQnhNMmZUc2hkbVpOTlJpSkc0NjlSd3VMN1JpNmY5aS9E?=
 =?utf-8?B?WnBkZE5ocmFtWFdsaWFyaWVuREJIeWdJcStVQmgydUlOKzgwSmRxM3FYdEg3?=
 =?utf-8?B?Q2tueFRERFEzQzM1dFlNbkp4YXhzZk91OCtTWE84MjFNSS81SndDS1M4OTg5?=
 =?utf-8?B?bnliNXNsbW1TU0x1UHkxcUxBQUswdGdHL3dRSGlnaWVRY2RGS0c2bmRtTGhx?=
 =?utf-8?B?L2xrdlcvYVlodk9wbXdCWS9YaXVjYStSaEhQN1Ruc3BTcjF3aUpNMG9DaGNW?=
 =?utf-8?B?RFpJbDdzNXBoT0xnNjZvOHFLOFVzKzRJQjBPdktYZVRVejNLdkRrbjNiRGZE?=
 =?utf-8?B?VktoeW9QeS9sYUF0bTlRdVdxNmFkTUJoZy9CelVlYkJvWVdkbWRrSkIwQjY0?=
 =?utf-8?B?RzhCWmtqc1F5N0Nqd0EyZ3hyTFBnNTFGOXMrc1pndkNLM2V1UVV5bWZ6ZVhi?=
 =?utf-8?B?QmJQNGdreGYrclZPaTJ5ZEFHUjBmaGFOVjVGaW5HMTR4N1MrNFNqQUFodUxl?=
 =?utf-8?B?alJCTHorc0RISUtZSDlaQ20yNW9kemU0QmRUb0NFY01pNkpwYzZNWXNHaTVO?=
 =?utf-8?B?ejFRSnVCeDlSMklHREZyWUdqY2pEbS9XWThEemcwQ0RVd3V0cXNLejFPWjg1?=
 =?utf-8?B?UFk1L1ZySEVEYURjRTZTVnVGaVRnQ0xIRkprdnZLd3YweWZnZzJpZnB5bnNm?=
 =?utf-8?Q?7ktduOzspLcFjTUVfbEQ3p61E?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3469a761-8f46-4013-51d3-08dc9f232a74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:54:16.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFsIN0UDvkjmaKJfyeitRCG1cGRocJ1KvWDHTW7X/QazaPzU0BctT9FF7S5Y1mKYvjI2XHtFfqAC+WhhmHScuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8573

On 08.07.24 09:45, Ning_wei(韦宁) wrote:
> Hi Jan,
> 
> Thanks for your reply! 
> I attach the kernel log which dmesg reports to. But it seems that there are only the EtherCAT stack because I open the debug log for IgH.
> 

If there is nothing Xenomai-specific or kernel oops-like in the logs,
you need to talk to IgH for support specific to their stack.

> It is mentioned that latest release of I-pipe for that kernel is ipipe-core-5.4.255-x86-15. Is that means I need use the latest release?

If you want to rule out that there was no related issue fixed since
then, yet.

Jan

> 
> Thanks,
> Milton
> 
> -----邮件原件-----
> 发件人: Jan Kiszka <jan.kiszka@siemens.com> 
> 发送时间: 2024年7月8日 15:30
> 收件人: Ning_wei(韦宁) <Ning_wei@sgssemi.com>; xenomai@lists.linux.dev
> 主题: Re: KernelOops xenomai3
> 
> On 08.07.24 06:00, Ning_wei(韦宁) wrote:
>> Hi all,
>>
>> There are some KernelOopses when I run IgH EtherCAT master. It seems 
>> the oopses did not impact the system and the process running.
>> I attach the .config file.
>> Could you please give me some suggestions?
>>
> 
> Sorry, but you only shared what that Ethercat stack reported, not the actually kernel oops. Please provide the kernel log itself (what dmesg reports).
> 
>>
>> Kernel: 5.4.102
>>
> 
> Latest release of I-pipe for that kernel is ipipe-core-5.4.255-x86-15.
> 
> Jan
> 
> --
> Siemens AG, Technology
> Linux Expert Center
> 
> 

-- 
Siemens AG, Technology
Linux Expert Center

