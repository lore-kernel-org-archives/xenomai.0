Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9128A413
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294169; cv=fail; b=tX0cnKl3G2I0cwNtFwBnxn/ia5zXP2srWfcF1nbdcmwK0JqG5bfHm8rQxmgalrMVIxqy0Z+YyxKqBqKPhGRT3od08jSXsKmBMvY2qtqMLMNnaWv/+Kk9MXzcXbP04VW8qpQKkYhCD5WuntgudmHDs4/flx4waLzRfLDGMSmHuXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294169; c=relaxed/simple;
	bh=CWbD3mG7IzwxatcUOwsZynif57jOUAXmDmic91Xe3W0=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=GuyHUJ7duS07u4UGn0gW+XFrYl7UThZZSVru0HovFfovUy/56pB+ZJP+TMXnUMkeDn8aqX/mZNN+JGVv8L7rX34+iw8OxybONEYs/+os5r4TxuZZqbELLGkkJl7acMrfBL2clNIIurZoesjLDTvNDiqftPSnkoabYnJ0S+eli0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uOUw9Hjr; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uOUw9Hjr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaQs7zm5iMUwQc0m4yctPQUWHQEPJNekX5E4mvWxPgCgbh29quupEfJbDAslM+RtSK00h5jdo1bD/0w/kNByz51OfTGCSQhuZsvcW/6D++j44NP6A7lTCgMD7A+GJdb4YyW3zqnWIIFSpa+K40PcgSg7JbRNrdHVcf4ilT8UApBi2gRACZ1waYhOC/KgVXSATF1RjRIOiJxZWkDq4BLVZN+3cDktb78QBZcu/HTmDT8S7UaLiL30KpOAykWJUvAdbV+aPtmDVlc5hHu8au7r/gZxZsY5trwpbk+riAXqQlP+CQ2CBb/OwQINAp4JuSfgv9+GbgNWVX7DEXcR6amYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcSfj1GLd4/8JZWTcWjjL7CK+MVYCXEeKAEuv5JD6Eg=;
 b=skaKjkjrukIaM6vYT4V3NdxYG1LX9a5SvzP26WyqGpf7sjxlmMpw+NBP2E085ODbd01AUQD0LLNLLGdZHupTaoCOsQQxqptGMBdxj+UBVcXcGzX9ltTAoIyYKvKUJH9qW7K07gpZQijEGccTKPzWa+v33VKdqjR6+Qdbz2pSKtdCAD3DpRsN43BDZbAc6kMstmcmHJJch+L5lTPbSysYqYlXWsdFSku8GLnNWgGV8sZ4KAums22gaSw/MuaEfUOsZCJpzqKFgkpbX4qXJXtbl8MMopBABRwIMmWQA+Ii99lps5exwCSsIl9TbAI0871oPZMhWOsFA0DoFqxdBQz/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcSfj1GLd4/8JZWTcWjjL7CK+MVYCXEeKAEuv5JD6Eg=;
 b=uOUw9Hjrp247+P1xaOu72Q6LasgDaaFtsfNDUfQXkyhU8Kx5TOLK1u0JQJ5rfDU+Diz8SxzOn1zMWCT/CGmcTHguiGJhP2/yyqO6hDKMZMGfQO+qRxNz4kyO6vVZ/F2m25tJVsuAFNoGwW9JGeP5aycshwJt0F0IK3kPE2wd+LPwwViOlRER4vBfOGpG7E5bg6PjWZEu2IN9h3cvbH7FFm/HyWGiWyeD7QAStwvn+c9PioPb/vv5ze/rU1OTvHGmr6rs7YE98JndheqT+lsx+my7TMrPAx3mO7IV5xrU2Ze4aIEWhPHRP9REqH3WvfXevYRuFYKKoPMxa5O/pB1azQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 14:09:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 14:09:23 +0000
Message-ID: <b5c9e434-bd4f-49b1-96c9-517b87dc891e@siemens.com>
Date: Thu, 10 Apr 2025 16:09:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Tag build jobs
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5c1a79-23f5-4224-04fc-08dd78394be0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkxPNmt3amJKYXQ3aWFGV2szUmJmNHZYN3h3Rkc4MkhLazRUOXl1SWovYUtJ?=
 =?utf-8?B?V2tLWkprKzFiNFJIVllZZTFlK0ZEZy9rRnNHbHVMdnpHdFRKdG4rYnQ3N2lq?=
 =?utf-8?B?VXl6SUgxdHk1dmxST0UrdnlEVzlQVlNrZGZEcDJOVVB2MEh6K2xQdytWN0ht?=
 =?utf-8?B?R0FVZVllb0tJY25wbzNWTTc4THc4NUNxTzBpQ2FLZ0xuSTB6Snc5cnFkMlh0?=
 =?utf-8?B?RjRHTFEraXZ0TjlQUlZ6aWJSSWlTNlQ3emJDV3dORHJjbGtBdEZ2RlhXdk1K?=
 =?utf-8?B?ODNrUU03Y1l2NWhPdVBJeFhPUDl2WEVuTkp6SnZkeVQ3NWtSUUhpTVh4Szhh?=
 =?utf-8?B?RjRZL1dyMlVPM00xWWZkMVRCUy9wM0VraXBLSlZseWRxZzhmUm5xMnNVOEpq?=
 =?utf-8?B?eVd6NFEyQ0c3K0VkU09IblFDYU9uSXlCU00vTnlzdTNpZVFSVFRuSTkzM2l5?=
 =?utf-8?B?d2IzWDJtdko2a3FMMlZzeDdMRldVcXdDWWQ1TU10TDNkK00xb1hiZ05ZTXZk?=
 =?utf-8?B?S1BwUm9MNHU4ZEJVSjZpY3FSUmd2K2x1VWZEcnc0cGNYQzd2NFIyM1lxWkpx?=
 =?utf-8?B?YzZMR3lvdy9jK0VyMGJpSHBYVlF2YmMwM1B5UXk3V0tzZXFPTXZnV0lYdDJZ?=
 =?utf-8?B?b09JZEZwYXBSQWNGa0w1MFdKS1huMzlPZWZiQ2FQV0Rrd3QzVmxsb2dvRHo1?=
 =?utf-8?B?S05XWXpqdHhuVHJnbkRPdzhCdmJNc2hlalovRFJJVGdzbzVVaTg1emtlajNH?=
 =?utf-8?B?WmFYT1ZaWEwxOFUwVGFNc25KS1lKNHdWR2FpMFJ4S0ZwTXN0a05iZEdCYTFv?=
 =?utf-8?B?ejFpVGdjbGZIR1VnYzFBV2dBN1lWdDVaV3BoR1VhcHJmYWFwWXNhZklycUkv?=
 =?utf-8?B?Y0hMZWhtRTByOUgyaXZtSHZzYkUwSnJVZ1IxNjg1OEpscUNabjRSUDVEaXV0?=
 =?utf-8?B?cHkwR0o5NlZxdG41dzQ0MTd0RU5NQituSWVXWVR2Um9yNXIwRW5naHhCaEpk?=
 =?utf-8?B?bml3a0MxNk5uaEhHaXdhSkhkR3Yrc1J6eStkNDhBTDk2SHNKbjdvUEU0TElP?=
 =?utf-8?B?NjBBcFN0L3JJSUMvQnZiLzAyeG95bUQyaHBXOG1sSzZ0SEVNWUxFN3F3SFlw?=
 =?utf-8?B?Z2IxQXo1RFRwRmthTkV4MU5IN1FoekZPSEVIOFVjcVRtS0hlZ1F0YnFiSTF1?=
 =?utf-8?B?SG9OUGdPNlVPeXE3bFMrbHpDZ0N3Zm1uRkdIb2hKZjFmZEFFNGswS2JmcmpT?=
 =?utf-8?B?T2RiakNmY0RZSDBvQ1VmN2hYdWlqd09KUCsrcHhLMnMxSWxKTldROXdyQlZP?=
 =?utf-8?B?QjhVWVQrR3N4aktnT2FLYmhEOEhjSDhCVHJBU3JzTURFc2ZxaVRVcXVuZ1VE?=
 =?utf-8?B?T0JPTnkvaEFIYUp1VHR4Q3RSTmdVc3dFNmNLOVBlQzlZNWszemRIU2t3S1k1?=
 =?utf-8?B?aVpiM0xvUTZaM0dkMWZQenFIdHRFNXNPZnZHWDFUZVBCbGoyelorakcyeXdH?=
 =?utf-8?B?TnI4UkZUcDJaTnJybTZEVWcyenFCQVNXeDRzUVd0dnA3TDUyWktRN2YxNzlO?=
 =?utf-8?B?RmxYNlk3THhocks5N2YrQTlCNjBYOWo3R3BHSkZ3VDd0bUxtSk1wTUxyYnUr?=
 =?utf-8?B?SERBeEV6bmcreWhKSG0yajhPd1Rkb3lVSi83WVZXTlpEY3MzZFhWYzNPTWN2?=
 =?utf-8?B?cEgyZ3JoNmx2VHBWSjlOQmZPTUNPVUI4NXl2enY0VmJhMlJwemRuSnY1TUNn?=
 =?utf-8?B?Y0pzZXpsUmt3RlNaRmYwQktWcTUxM2pFMk41V2M1cUVFOEltY3o0Y1VZeWc4?=
 =?utf-8?B?Q2lmMGNPdDZ6cUZOeXI1UDNFcTR1ckU1dHhJY0ZZUXFFeFo4S0JFRXlQcXJV?=
 =?utf-8?B?SlZKMkZFcjQ2OVAvRFcwczg5eXN6eEY2TS9LUG5qR05mUWxLWVlHMXBuN0Fy?=
 =?utf-8?Q?m51ZDnsS8UI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1k2OW9OeklPaWc1dzIydGEyYTdqQ3RucnhwcEZoMDBTb1FFMVRHZi8xSkNp?=
 =?utf-8?B?Y0hOQmphZHFrNTVEc3RVSkhabTYyTDYzSDZQMGNPYzJTY0Nvd3hDcUF2Vmg1?=
 =?utf-8?B?bHF6KzQzTzd2ZUo3TWxtRmFZUGREUWM2emtCRk9kODk4ZU1JWldsQVEyNWls?=
 =?utf-8?B?cy9ZalN6TUgvcWNEL2ViK2lhaDV3cG9WQWRHSUppRWowQlNXeE41azNhWS9t?=
 =?utf-8?B?cEhJNmZ3NEhjVE9GWEx3LzVqWE80a083dklrSjFCaHpnZ1lTMGFBMUFkL3lL?=
 =?utf-8?B?b3pOYUdWc2VCcHQrL3ZNcklPM3Z1cFJGL1E1ZFlnVnFRYnlTMG94ZHZiRmFG?=
 =?utf-8?B?RStaeUE3VHJpSDJwTDdYY2lQS2pUMjNER1k0RXY0Wnd5VS81MUxsWGprL1Mz?=
 =?utf-8?B?bTVnSlNobnAzbWlodldHYnRkOE9xOCtFQUoxMEVGdStTV1QzNDVGc01BVjNj?=
 =?utf-8?B?NDNyZWVYck96bUhhRTcrcUE2YlFxaVBwWWpFeUlNdGcxNmo1UDJpc3hEZjll?=
 =?utf-8?B?Vy9qanNyekhueEN2Qk5icHJZcHNEcGoyVmxXSXFNbG5Ydm4xRitRUFhxUE9W?=
 =?utf-8?B?Ty9rZ2d3WDM5SEhNbndhYkZFdVNpS3orREF0bDdhNFJ5N2U3c0lZSWN5L29Y?=
 =?utf-8?B?UUl6UFcyYWtEb0FqMXlUQUw4NFQrbEpIZ0hYWGlkR0ZFT2t5cUZzd3BGTmM1?=
 =?utf-8?B?bk02TmxwWWlPR21YSVN6a3FCUDlHQXpBWWo0M3NHTllKTVE3ZklXVUZKUU9a?=
 =?utf-8?B?UGNSRktDT3RRTjU4WVpTc1lsRHBLc3Nka2VtTHIvdEt3WDQ2MjF5TGdEaDV4?=
 =?utf-8?B?U3B6aHRySUxYTUJhWlFpQkNBRkdTbjl0Y0xpS2pYTkl2R3N3bytLVmJRZ2RX?=
 =?utf-8?B?eVZMZFdZMWw0RENhWWFPUWFyTlJqVE9BNjB4N2Q3SGVoTForUE12dnhKbnFN?=
 =?utf-8?B?b0FxY2dyRTFweDZsV3N4TUdhYnhRQ0MvamJBRThRZmw2T3cvdHBaYmExS3Bm?=
 =?utf-8?B?UXRrajlqMDYvWGc1V3N1RDBVbmwzWWhiQ2pRUVo1Z3hONGtxcjZQaXk3REtB?=
 =?utf-8?B?Q0hKc0tnaDBCZUxYaGtySjYwSU9USnV1NUpvbGpkZWIrSGlKK2lrQ2drQnNT?=
 =?utf-8?B?M1NhTDdxU1NpY1hUTFhOWDVDbmluRlp3MnlwbGJRUzcxVm9rZG9EU2c2MTBa?=
 =?utf-8?B?QUNrUDl1TVEzbDZaTVpTYkF1REZQY1BtcFRtRHlVNjJIdkZ5YTZBSnNmNytm?=
 =?utf-8?B?MmdXOGMrZjFNSk9vRFZYNVRUUjMzYkZuc3B6SFRGbkZmTFhLVytvT2d2ejlq?=
 =?utf-8?B?ZnU1ZFUwcnFNeHBwbXl4c0JNRDNXa0JjbmZONklhZ2xBWWVhRnU3QngzVnJs?=
 =?utf-8?B?bjJlMDRnTm9DaXBrR0hGZGszeGw5K24yeTZTNllqODZrL3FaMXRWeDJpODNp?=
 =?utf-8?B?VThYMkNxRHNIVkJPWmwvOXVZR2cxWUVRUDRkNmlsUUVpRURyK3NDeGVFK1ly?=
 =?utf-8?B?Zi9uYnY4Qm9HVWNFT1N4R0J1cU9talI4cllTMDRod2k3eTI5N2wxV0NETkdW?=
 =?utf-8?B?U25wa2Rqb3poTUZ3bVY0WVFYWVJiQUpNRk9mRklDQlluUzBUVHo4eDQ1RFFH?=
 =?utf-8?B?MjVrVHVBbFMzcmhxUE5MMGc1OTdzT2xiREhVNExxVUZaUEJ6OXB6alNaKyt1?=
 =?utf-8?B?QnF5cjN5ZDFvMW5VWisvSmFYSmpvbDZNKzcwTHFwZ1ExQy95OVlUSzhsa3dC?=
 =?utf-8?B?UXJSU3RSblVNS1hsMktmYWkxWDFoS0RJQ2NOdjNSMnkyM2ova3Zjb21RTDJS?=
 =?utf-8?B?amhwWEpJSzRvOWJrSVdSU3FBdG9zUWpKVUR5MGY3RUdKK1BReTc3MDFlVVhO?=
 =?utf-8?B?NHUzNm9xdDFjekJ3Q24vL1FqR3RHWXNhSkRCV1FHYUdBS2VwU0hHTDdlcW1z?=
 =?utf-8?B?ZFJvbHZQRUZLcTZrb3RrOWdZSDBFS0tvUlI5b2QvSzQ3Y21rRkw4b0xHQ0F1?=
 =?utf-8?B?dmFjVlBLMEVSVFZNTkdqSy9EUy9rUjM1WmdHa3pxKzM4Q29JVEJya2ZSbzBs?=
 =?utf-8?B?Y1R3aW1VWm15NmR4NUpWS3pRRGxiN1JkUkcvbmVXS1NSZlNSTXJCN2lrRCt2?=
 =?utf-8?B?ODVCY3hTMXJVS0NtSmlDeXJjcDhtN2htbCs5OWs0OHlsMW82aUUxQS91OHlq?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5c1a79-23f5-4224-04fc-08dd78394be0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:09:23.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPka1uQ5ydYEz8kDoB1rMH2vz7aGyEU/xsRs7Sdi2qe2JZE6s7Xhsr4ik4iR4mgUkLxWOk2xrx4a8bbZ0tzTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5183

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows our bigger runners to pick up only build jobs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index aaf0df7..6b31381 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -69,6 +69,8 @@ default:
 
 .build:
   stage: build
+  tags:
+    - build
   before_script:
     - !reference [.common-config, script]
     - !reference [.sstate-prepare, script]
-- 
2.43.0
