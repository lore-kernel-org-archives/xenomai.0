Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6A7D40D
	for <xenomai@lists.linux.dev>; Mon,  5 Aug 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866912; cv=fail; b=Vndq5Shxo3dY4yt6+ee/9egPG+R1aylSDSXw1n3eFQqIVnBrvplOq0tN+0o66kqPP0cNhF86OEtO2Zoe3tGVLQlXoFFix3YrjkglBozydXXIsvkB6nxzBTLsJBWyhwIhe385SizoRMejJRpPW2dzUZ9W7ccif9DmcBVByYVZteE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866912; c=relaxed/simple;
	bh=qcKGWUw9FngEwbU3O78zvmgNFoSHyranoVeDXmh5pyg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bfuaACDUC80t0csoXU8qfzuhVHUBBRazR5aUc2GFWAylY4tTWGSLrQuyWnjhM+nJW4gOA29nUOPKvpEXqikjhKOWVn4KdDjM9i1CwjTKo++n57HKxyhTPWvXj15uMtw97rzkjLQXaRklZfCVyjG2gFsuKWlt4QwuF78HfBOZ8I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cs1J8pwY; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cs1J8pwY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qskJAc6WaRJeau3MlRxlQA5uXn1nsAANuYFSsaocEhmVR13VcSY8zkd2oLvVyLh0eRSkDiKn1MrNVexnl+Psz41VHGmMlWLOFDDXirixkPWRoe4p4QDnFRWVzJ8oMabSDNIHyietjhHgMDXmg4GBZH/IrnCw8w2D3tQRvdfo2ilwFMylTPv9hEeYlU6XgU0okmT58KatzQxUz4wZ3Tgw3mNU8YFDs+FxbUkhkbVKW6xbebeDC5uicbV9v01Z0brBLwd9CK0toG7UWfrk3I/FeVGe5G0ULdtYZtKtagRVfUyd2/M7F+Cck60fZH/bYkuRDNQwenqaRN+BpxoN+Pd/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jucq5PpT8Ug9TS0yyfYIwGQByg65NNnyALzyLJovjno=;
 b=mVJEULLJDWlYQqdxqWE/U0NvOr1PAqqFTvBTlIeMhOkAF4fw1IMWavUMviddiVAStNjFK/9GYTOyB5xvi3bN8+zziqq1gxgDmNxkMchWVLJ+EL7NRyEjJbM9BX8CTfGihJhRM2C3se5P1OCNi7vwMNUhtC5f+lNZe39GBcHaxSHqimvOCJp42JqPIaEtOxQSQXc42QPv22Um06AZLeOJdHTg3onBEdjVvcjTJztUUMkMiaxvUPU3Y3slMYDnih7EQRcc+piaw4mXLPvczIqouLOqqD2RtlM5nYEaKKEYKi9+9Xu9C0Vs6guG6JJQd0uQ4EjK1+c2BDubgd4uiVO6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jucq5PpT8Ug9TS0yyfYIwGQByg65NNnyALzyLJovjno=;
 b=cs1J8pwYI557ltvh/Sgdb/HB/y8hDiDiLHZ3r+DIQJt+JtyKhDh8U5E5e/j7SZuZrJvSjA+XzUxxvCqKX2KLHdXfmMCnxcIlnLLcxqu8AqwiIeElvrA5e5xJde3b4WmyLtqd+N3roiQxwwS+X7kYXvQq1X68i4EiVw8WHAFD8jj20x5bb4I5WQvup1gJK43zhzEQ8yzVdpVelphVm/Oy5PEj4kQLowrYSNpqPs5FcbLl/PYP/mYyYm1eEmJRvIgEOP65C4A982+LFmfWO+38YyW2Qfkb3a+tct389yd4y//ZQilKfhSE6kgdtqO//xxxp1evl4UIqvkYqZUpQtD3Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:08:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 14:08:25 +0000
Message-ID: <1df8237a-763f-4778-8a52-f6e22df23a8a@siemens.com>
Date: Mon, 5 Aug 2024 16:08:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Mauro S." <mau.salvi@yahoo.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: fa35ce9e-9c29-4020-1c0f-08dcb55812e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVc5NWJodERsbmJQT240ODJjaDZPRHVqU3loOExFMDZJaDIxMTAwT3BkTWpU?=
 =?utf-8?B?bmFzNHdEVUtja09uQktaKzhvOXBEZHNqRFZ6RFpEVDFoM05ISEtUOHVRd3lD?=
 =?utf-8?B?MDFPRkxMcURTRHhadVkwNnYwZzh5NzNGNFJnWjJMZGNyY0FubVFFcDg4dEtG?=
 =?utf-8?B?NjhMRjlqL3NWZFBOVDZ0MUtidTNQNnRIMDlxajRqdThLT2pwUE0zcTM4ZHlq?=
 =?utf-8?B?cjFTNFZnVUpMNXZhV1RIRm1zRWpPT0d0WWVvOGlINFhob0x1Z2R6WkV0VE9T?=
 =?utf-8?B?Z0N4V1c0RiszTDVWaEkxT1ZoVmFEVVA1WmlnTHp5TmNrVENmR3M4U0tjcWFn?=
 =?utf-8?B?OXFQZDVOR0R4amZUMGtOazg2ektRRUF1SWNMYkh4d2hSS29VODRYY3dZdmh5?=
 =?utf-8?B?UE9OeVFESmUzUHJBaVZOWHJUY01OTjE4aW1VeWFhakhMdXlXVlQrdkhzWlNl?=
 =?utf-8?B?Z1JBQTZGaTVZNktTTjlWdDhVUzd6cUs3SGhDeXplYmVjeXNhd3BERDE3Rjhr?=
 =?utf-8?B?Z0xyM1JlemE0MlNCWWNkemxKRUY1SmdYNzZsVGk1N1AvZzVxTWZhcS9qN2VG?=
 =?utf-8?B?NFJ5U3BrL3pjYmxIaWJVZFpwdVdoNmF3TDVlNjdIK2M1eVgxTTJWcjhDeW9h?=
 =?utf-8?B?L1hUWkJjRUpPZHB6VUpiVWx2am9HcVlTRjZuSTBmMHNaWTdVTEJjUzFla1p0?=
 =?utf-8?B?T0NOVmV2V1pvSkZEZDJUWHozZkpxQWRjdlhBTkZkbFVEa09GR2NoT2RKTUpq?=
 =?utf-8?B?SmU2Zjc0VHlRY1NPNktjb0Rjb2tQSUFGc1dhekM1UWwvUk56eFBIdjVxNnE0?=
 =?utf-8?B?c3F2dWk0OWhseHJUTXg5RlBpTkUxYnJFSkhCbjBEMjc1TTBOQnJWeHdLcFli?=
 =?utf-8?B?UGk0djQwWHdTZC9ZTW1Wa3hXaUlzV3dzeDYydk5OMUM2YmVPS1dWMEhMNVN1?=
 =?utf-8?B?SUp5S1BmSHVpaWhQblRSQ3kyUlpBUENRVVFienl4Tk5CT1JLZ3d3NHNkVFNm?=
 =?utf-8?B?RXFmOExTS2h6eXJQUHJtUDB1MjVWdWhpa213dU1SUnd5b2tzZmViQU9zZ293?=
 =?utf-8?B?U3B1SVFIckx3U3lPdjFOUDk0YVhrTEU0cVpjcklLdFBYSTJSVWtQNzdqd2Uw?=
 =?utf-8?B?ak9ZS1JaWUc1azZSTUROZzF2OVZ4WWR0eFRrc29QVE0xbnhXeGlpTlBDYVEr?=
 =?utf-8?B?emRDcTVVOHRVak11ZTlHbTZ2ZFBSRmliTnVpczNTS0dGTDZ2ZkdzS1A3cEF2?=
 =?utf-8?B?Qi9LK0pHL0Jwc1c4MkpSMkMwWTdLV3FJY0UzSE9iWXlQWStva2Q5aXRqaFpz?=
 =?utf-8?B?QnpmUVQrYVY4MG1JODZuQUpZWDlJRmU1UjdNN3UxMlZnUGNyNnFlM2drU3BM?=
 =?utf-8?B?em1hbDNzNndWZU8zTW0yNjZWRkpYS1VFS0wvaDZLWEl2MnJkWDlJTm9DYVZ1?=
 =?utf-8?B?bmdIMTMyNXNMeU9QejVqVGVYZXREYWN0dGQzbU84c3Z5cGN0V3k2cld3N2RV?=
 =?utf-8?B?L1dOQ2hObmplcS8rbjNhOXJ1OFFJSGJJeDJyV0RIbkdCazZRa2VPaThBM3Ex?=
 =?utf-8?B?Z1FmY0tpOGZadWtxSTNtNTM5U3hOSlN3S2J4WWR6Z2M4aHgxc2VXc0lWdmpC?=
 =?utf-8?B?U3Q0N0tXMU55bzVvUUVvb1hYeEthNWREdC9uMmtGaThTMFlvaXFzbEMxdGFH?=
 =?utf-8?B?NFZ5cGlJYmtKZkhocXFLSUs2NTh1cGNEcHlkT1gvY1FNZ0hjWHdxaHU0bEZJ?=
 =?utf-8?B?WXFQMjF3Q3hxU21TRG1wWmg5cWlRdERkL3lNamx5R2UrV0lWZG53dVptbUhT?=
 =?utf-8?B?RktLdnhSdVgrSEtSNWZUQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3FiRlZVUk1NSy9KUlpCKzlxSEp3ZndNaURkSXdLNDZVTHB5czN6cFJncS9s?=
 =?utf-8?B?QWM0cThuYUZLK0dZNkNsdWp1bWNRQ01QRmtqR0o2L25ha2E0cWU4eC9sWDV5?=
 =?utf-8?B?dGJPcWRsUktxaytIV3dyUGJtVnI0RVk5YWVraXVEblpBdUdLQ3FSNHh2NDhJ?=
 =?utf-8?B?V0EwNVVXaGFwRXFZSGVZSXFsTnI2QUk0d2hGcGtFVXo4T1RGMUI1aUhYdzdn?=
 =?utf-8?B?LytiOVRtTExNc0Nua0dkWjM2S3pubkNhZE4rZ29JSTBrSTRJRXJJc1YvaDlt?=
 =?utf-8?B?Nm5lWUJJUHEyZVBiL0dvRjZ5WUExdVdWRFd3TUM5UDZIblluY3FTZVVmZE0z?=
 =?utf-8?B?TmFCUE1weVZ1ejJYcDMrbHdCMXZvZVVzZ1lOc1hKemNuZHhrWllNT241a0VQ?=
 =?utf-8?B?V0IzWm05UE54OWZSd0xodmRGN1VRWVdDMUlTdUcvSWJ5RG9PeXoyMlp5WWlC?=
 =?utf-8?B?WC9qd0FhMGdWOUY2R0VIWmY1R1MxUVU0bXdlem12Z1U2WXkzVVV1Ulk1VVlT?=
 =?utf-8?B?eVJmeldxQWJGU2RFZzY5b1NiWHU4Sm1YK0NEaWJiNXRTcFJUUVpyejYwNWpn?=
 =?utf-8?B?RDJsclQ2OHROUHQ3aFNmODhIVFpwYTkzaDNQOFlWVjhsOW8ybUpNWXNIM2kr?=
 =?utf-8?B?akVXb0ZMbmlINCtkWGZuZFBOYWFRSms2YmtMNGxRZkF3eEwyQ01FdE5tNlpK?=
 =?utf-8?B?am5IbE9QZ3dxQWFVSFlqZkI2eHdlMG1ialpLMG53bHRMZ2tmUHpzdGlHSGs2?=
 =?utf-8?B?UWtNZ2tvL3NuRXFzbXkzeW9BZG5vYy9aZlBMWEw1ZGFRV0hUNVhlVDBLQnFs?=
 =?utf-8?B?bmcvVVJ0b2p4Yk1ablBVSmJ4dC8zZXprZDhmQUN5WWpPSGdDNDlHUUtlR1BL?=
 =?utf-8?B?bzlMcGk3N2lNaDJEYlc3ak44U2Q4a1czeEFrL1BxR3BWVkxiL2NFV0RzWHBJ?=
 =?utf-8?B?Z0pWbzV6MmhtY0NudkE2cG1kNCsvZXBDY2NWdjNnT01rYlpwYnYrUnMzdDlp?=
 =?utf-8?B?YU1PRVRJSmtGYjI4Ti94SDhkNnhiVVljN2FzSTNYRitlb25yWUtwS1NtYjJX?=
 =?utf-8?B?K3M0aWNDckwyQXRmejlmVGRrU29jUUlBL2Y3L2lBcTBSWWZFNDRUdExYemJ5?=
 =?utf-8?B?UUllOHVXRllUT0ZoY2pDcGkzcUlaWDB0Y09MRDNIT210WmZFcS8yRjlJOFl5?=
 =?utf-8?B?OHZ2a3hoamM1L2ZkR1d6ZFJVM3BqdmNRalgzZ0NaNmYvZ1ZkQzF5WlhPMEht?=
 =?utf-8?B?b2wxWEkrSk9sdXltd3VUUVkvN21TU2ZONWhXQjl2SCtKK3c4cXNGYzVhMUxs?=
 =?utf-8?B?OXRMWmk0ZnpCa2FvbWNvb1pNb1FIRUh0UGVOMXVOaEp4M3hYd2FuWEk3aGFR?=
 =?utf-8?B?Qm5MQU1nbEZVQ2hVTEIrR1NaSHdVTVBDamhsdlIrMVU5dVYzYmdmNEhDODl5?=
 =?utf-8?B?RXAzYzZPR0prVHdKSnNiWHVOVjY2U1Jjdm11dzBjNU5nN2daUm0vdjhGaWdR?=
 =?utf-8?B?OEJBakZHaCticHRvRnA1ZUJZTk0weHdUeTJabVZTVnpwd21ZcGRRYWowNzd0?=
 =?utf-8?B?MFZ3YmVZT2ZqVGVlTDhoM084R3NmdXV2RWkyQzJSd1MrWXpnTWVKRjFyeGQ5?=
 =?utf-8?B?ZFkyZlZnSS8wSHUvaEhBcWZGeHRKNkViZTdWSVZqTHJDY21rVThFVk1LZlBL?=
 =?utf-8?B?Unp6SGt2TDVWeDJVRUpvOThnRCthdEZmcXNiRkdRYXljQ3pKLzRwT1F1WlJB?=
 =?utf-8?B?c2NlUzVGQnRES2IxWXhYMjdSQlFNNTJoZTNWNU5vOGtZV2pPbkZvTXBuWTNx?=
 =?utf-8?B?Mk84WjZwNGFCRTJia05zNkZzV09ZWEE4cUN3MXZNQkxrSDYvUUF6eEllTXlG?=
 =?utf-8?B?bWcrKzNwMkRkemlrdUlqWDNVNWdBTlUyaXpqdDBNbUltbUdmSEVXYTRaTGVT?=
 =?utf-8?B?VWxmWE1Ed1I3QWdGVFZwUkNyVEpoaDVtMW9uRk5zMlBCL0lpMjE5b2lSN0J3?=
 =?utf-8?B?TFlCYTNUdGNPT2VwMXVJa1VuNndvZ1NwVmxETkgzd0xDZytQREVGdkRkaXNG?=
 =?utf-8?B?eDQ2NkhkZ0pEZVhoTk9UQzR1T3h6dlNCenR5Q21wK3FrQnlPQUdqd1VXSW1h?=
 =?utf-8?B?UlV0alRiZjM4SUJXRVJlcmZnN1FURm80dmNXeS9mQ2d0YVRQdHM1WlNxTi90?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa35ce9e-9c29-4020-1c0f-08dcb55812e2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:08:25.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSDO6NUMOjdmDooOs8sJPAp7gpOgSaVf2+Sl7nskZFr8lzQFG7xXNDVnmg6yNuDfMLiLbHrTVvD64EHZADGnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7627

On 05.08.24 14:10, Jan Kiszka wrote:
> On 14.03.24 15:22, Mauro S. wrote:
>> Hi Jan,
>>
>> finally I managed to have a piece of code that makes the issue
>> reproducible. It's not exactly small, but not too big either.
>> I hope that this makes the issue reproducible also on your test system.
>>
>> The zip contains:
>> - a little main program (test.c)
>> - a little library (in mylib dir). Some pieces of code are never
>> reached, but leaved to avoid potential compiler optimizations that could
>> remove other relevant parts (maybe cycles?)
>> - a script (build.sh) to build the two components above
>> - a script to launch the test (start-test.sh)
>> - the configuration of the kernel in use
>>
>> After building the program and the library with build.sh, you can copy
>> on the target:
>> - the start-test.sh script
>> - the built program xeno-test-session-hang-on-exit
>> - the built library libmylib.so.2.0.0
>> and create the library link /usr/lib/libmylib.so.2
>>
>> Start the test with "./start-test.sh &" and follow what happening with
>> "tail -f log.txt": after a time that varies from a couple of minutes to
>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT ~~~~~~"
>> line: the hang is happened.
>>
>> A small recap:
>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
> 
> Can you only reproduce with this setup, specifically with this compiler
> version and only on real hardware? If you rather use xenomai-images and
> qemu/kvm target but still the same kernel and xenomai version, the issue
> does not occur?
> 
> I'm trying in kvm right now, also with different compiler. Iit would be
> good to align / rule out variables if my first setup turns out to be
> unhelpful.
> 
>>
>> Some potential interesting things:
>> - seems that application arguments "--session" and "--cpu-affinity" matters
>> - seems that compilation flags matters
> 
> Which compilation flags are you referring to? I was using your Makefile
> now, will that give me the right flags?
> 
>> - seems that splitting the code in an application and a library matters
>>
>> Thanks in advance, regards
>>
> 
> Jan
> 

So, my first tests do not expose the issue yet. I will need more
details, I'm afraid.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

