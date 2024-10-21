Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C01C3F1F
	for <xenomai@lists.linux.dev>; Mon, 21 Oct 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529728; cv=fail; b=cqFa4ZxYzcd7cDQeFR3gSTeq9GwyxOamTkpAWtXtkSe4abJGhVFNfGwh0vWCEkWNNVQ2QY8wY07svKpKQwZFePktgDcn69oMJKxZAavq5+Uk9EMrDCkJmooIjWWQfZJ4+pz6GPai3H0/3xnjFYKTZkqZTCJ0FgJnq51rb4pdDW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529728; c=relaxed/simple;
	bh=OjEgs2bSCDDZGOr9EfVR7YDZJ5OpjNi9HsqLWbGO7So=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=WlY2cU4ghyBo5MNQrDqKOQ5qSMR0BNCdxR37TB23/TFs2xxqYBpAP4tmuigfBNO+GOHtclzy67v71BhHsoXWyfG8i8coLiZ3xHXMP8Bp9aOOJJ+fzrwi5kiZk5rbUWGBD/9dVGNYahWJq7C0DH9bxbF7sQNKJF/UMJWc8wD+058=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sFvC6KwZ; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sFvC6KwZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpleXq0azkb7o5dsAByIFvkSgZxpnAsQSJf0ngrOBbLj7ST5z2hRJG6IM1r4HUPiixM97lUqBeWqXPV3EjAV7GsB7I9TiuTCoZOjnDvixo25KVNv9mno09VW4yTxcdltFo5MyBMAL2z5ABBi0lBlD/5XSXmx1cHHeMPw7n0CxIkudQBFg0usJ4dkD9rb4KBBf9sCRLRjQF25cxK6bpDN+iq8wZkYaLmG/PbFSUu2U9xa/V4TeFF+TQV0lgJk021osq9R0FTDW0qzpWqLJ/CP52pFyHyHGqZtp1bUSuSrVCxk5lMmIm54RbE7hrneW4hnCojxt5mUvNBwl26kpO5Mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwMJxKw4Ztv01B2s4NKygDPtOwk+kaQAf+7Nb19xpZI=;
 b=Ygm3H/8VZ7u0MWweVVLBeWH4ek5UkX7jWbIaPaS4R1sMsJCst08JmYKGv+tZEDoOgcZpcVBhBAtU02n9Hq12NKYM5CiLNp2c2Q6pWk6axFMVk2VZOA+lOR+ksatxI6bsqxKGHd+MRzNFiyhCJK3IBhRztfs18xPP/u1NWpWtScywHyU/j6OmRzqO33XvXD9g5aZZXjp+kM1zxJLnFrpmPlOhQ5ol0xQ6OLYUA/MsAFnxqkxitoTqs8+dTo1QyHCymwmH0g4dZ3tFKFuk5lRshvvFoplnn1rEXr46R3U4Ohmvxi7kTorZty3HqNt1cHsuB96K0eJL1Cffj9rtsXVQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwMJxKw4Ztv01B2s4NKygDPtOwk+kaQAf+7Nb19xpZI=;
 b=sFvC6KwZvRGnGTxRomdSkZNhNajhjd/H58sqpChTPzw8sEfpMSntS8IO1vdEs9qLHNgb/9/AUb6efoiJNyq4ZnxIUrTj41pzE5k90C4CYcqgADSnYbodYfwC4QKhZ+Z24M0rqp/cuRkrL0qAF9pum2qHHyIWocEM3gv0032995E8OiIgE7cHSghh7MjZzBllLeDxS8sBEB2a32yaO5Btn36rvVRUJbpHzaCRNeUThjx5xcc4fiOXHNneuoXf3GXHyCeiSKbtIqFHlxI4LNQi/mNi2SS0ZTEcIWSAfFKSSPUwL57qev8IZNjbvWTgPfXnJj1+IbQ2ICicRcZQIy2QIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5519.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.14; Mon, 21 Oct
 2024 16:55:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 16:55:23 +0000
Message-ID: <77a756c0-5cbc-4abf-993e-fd0476d0f08e@siemens.com>
Date: Mon, 21 Oct 2024 18:55:19 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [ANNOUNCE] Xenomai v3.3 has been released
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:610:51::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da149e0-d457-472f-da44-08dcf1f12771
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTcxY3lEVUdOK0NvZVFZNGE3L2hid05sVUdKM2ZqaGpvWDQ5NVVHZG9IWVE5?=
 =?utf-8?B?ckdTZWJJYTlJR2VFU2I3dkI1T21naEk3QXlWYTdWbzRhOHdyVU53MWt3Z0Ez?=
 =?utf-8?B?Rk8wdGEyZ1Z0Y01pR1Z1VUNvbXJrK2x1TGV3U0theGpzQXJRbTNSQmo2V2Ni?=
 =?utf-8?B?S0xoVkRNcHc4MG5oZGZQMjBHdlhQUmJzY3VsT2RTTWtnY212d2ZDZklWUnht?=
 =?utf-8?B?WjAyb3YvSUJSWk1BL3AyeVY1Z3RId0dHenUrYnd5cC84d1hIaTNCRDNCY0xt?=
 =?utf-8?B?TUc2ZUUxVEI4TXNkNlJLeE5EdUIyVmNqZnlmSmhUUDQrWDVhM0ZKQUdyMDJC?=
 =?utf-8?B?S2V1NG53blhoVVVwdUFUQldjUmQwcDFSbG0vaEYxemtBVlRDQzRsZG9kcDNa?=
 =?utf-8?B?bEorSUZsUXduT2FpWG1ta21IWVJIMC9Rb1ViVWJNSUJSRldrdWhqQ3ZKRytK?=
 =?utf-8?B?UzdHVERPSHgvYlFxTUoxMmFGbXBWREJCL3o0WThEdE12KzF1eHJkbGd0UWxl?=
 =?utf-8?B?NC9YM0lkK1dDVW5RbjlsbTJ3dWtyZ01VcDBpNkJyUWJNWnRoUWNIOHRKSWEr?=
 =?utf-8?B?aUFCbVFkMTVHc21iWWs1UnpON2h2THI1bFJtV2g2QSt1ODJkMVYvS3NzMDQv?=
 =?utf-8?B?R2tiUmJyQ2JqRnlleGRkUUhyOS9tOEtFdDIvYnlham9mWnVZKzA3aGhjNmFH?=
 =?utf-8?B?WkxWSE56MWJHV1pTS2Fyc3ZDcmt1alo4UlZEbmw4ZmpMSTB3RG9DMzBydUh1?=
 =?utf-8?B?b2c3cDlVZHQ3TWRMQi9OdHdLTkxneTA5bjNsdXd0L1JEQWdRNGZsMEtBdnVM?=
 =?utf-8?B?Z3VwNzdzaU91bUtNMEZJYkYvUnFGWHYxNmdsKzRLemdUNS9MMUR5RGR2ZFVa?=
 =?utf-8?B?MlpveUNTN2VSWVNETHJtMG1oTVEzYzQ4NUNoUjI2SlJ1WUVqS3FVWmZFY0Q1?=
 =?utf-8?B?NWF6eHFPVHgrbHgyRzhJYmN6VHpGeVhWcFZxdzdjc1h5TFh5RUl3M2xLclg4?=
 =?utf-8?B?dW9yT0RkRzVMV1Y4cTB5VE9MZmpIVzAybndSRXEyZzlVeXA1K0wvL1ZKb3p1?=
 =?utf-8?B?UFVuYlNVTU1NbTRRUGpaQ2YrQ3RBQUJ1NTBpaHUxNDFFNHV3TVFpcW84cUdh?=
 =?utf-8?B?UG5NWGZ1SGFkbkFxdWlsU3NQR1VsQWEwb0ZQd0Y3L2w5NWw2b25vU1I1MEpl?=
 =?utf-8?B?ak9WV3JsTmtST2FNdFJDM09vVGZwY3JsVFJKYU13bXZrUGpLeWlENXRDM1RY?=
 =?utf-8?B?NjYvMEYwb1FjUmdLSHMySmg3U2QwMnlOY1oxK3dTaFlWMUJlNUhLTU1sR1o2?=
 =?utf-8?B?endXMjVuaGVkVGEvK05uUFV2S3U1RjQrUk1oMmcyMHZmdG1zNmFQa3cxQk9Y?=
 =?utf-8?B?aUNjQVFPVjVoTTNoRE9lL2tmeDVNVytKZ2tveW1YM0NSNzRUVGkzSE1Jb0tr?=
 =?utf-8?B?bVVVSUJDUi9NSHlBYm4wTUMwNCt4ZE4xSzJPTitwYzVqNkZKMTBjUUVrK1pa?=
 =?utf-8?B?Rjk4c1JFZDd2Zkk1akQzZU9PQ1RjanFKempvZ25PK1hTUGd0YXc4ZlhONEJV?=
 =?utf-8?B?endmbGt6KzBVVjVoU1RXWmh3ekUyL0FsWG03dlMzdGIrR3oybE5lcUxiOEFB?=
 =?utf-8?B?U2lUTUlmOC9SZ2gwZUF4ZFVPa1lBVW5HMkVEYjZKZEUwMEM5UEs1UG92M1hN?=
 =?utf-8?Q?XR6U6anlu5QBtO3CzUXO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVRvYlNWb2ZYd2JrVzFlcjlHZktmd3N2UnpLdWV6Z0xjajQ4b3dKZWdjSzV6?=
 =?utf-8?B?OElDbE5RMHBuV2ErQnhoekd2Yzh5d2o3Zk9jOVp0eFVPbFBrcXh6MTJrNTJl?=
 =?utf-8?B?Ris2S3pkVXgybzc1c3lTcHI3ak9FZ3FWZjdySkVsNTVDMzVWeUgrQjJ5TDJx?=
 =?utf-8?B?SmxpUXdxdkVOZUxwRk5LL3lLSjBGQXJPdjBFSmhoUVkwRFlwMFZLOU43d2tQ?=
 =?utf-8?B?VUIxWjFvTXYrcmFiQjVSdmpMVzFxWGp0UVN4OFR5bXlFbE1hVVIxdFZHdm43?=
 =?utf-8?B?TUxBOTFseFJnOGpJTW01dGZwbHozalNOblp2V1pkOHViUjJOeENiWnRGbE1E?=
 =?utf-8?B?VjhlT0RUWHEyYWRzSUNTd0ZtUnNSdGZuandxUm4wWGw2cTc4TitnTlBYMzFJ?=
 =?utf-8?B?ZWYybDllcjk3SkI4TWdpeEk1ZTQ4ZW4vT2NxUURYbnYybzRsTzIvR0hCWHpo?=
 =?utf-8?B?U1FlZzZhQ0JpVnpaQkJMVU11eDFEazVzc0xsWWNNTmw3cytzNTdPTXV1aEh5?=
 =?utf-8?B?OEg1SitWVkRoZ2VldnFuT1dPeVJLdDAwc2hvUmt0MjA4TGJ4MWg3b2hGSzJR?=
 =?utf-8?B?YmRtOTJNZFl3bzZlVHlsdkFFOWxBUlBicGlzeTRPSlk2bzBMUGRkRjltNExH?=
 =?utf-8?B?V1FleFJVNkhHT3JvV2dKVEw4ajYwcHZMU3dvQnplbXBRdUJpQW1LZWZGQWRU?=
 =?utf-8?B?SXNYK2VKK2VpMS9vblJzdWV4QmEwOWk1SHFvN2JoZVhsaFd5bjVoK1RiVFpn?=
 =?utf-8?B?NlBaUlN5aGM4VklmSEdpeEFDR1JZTlYxYXd1bWJCMTJkV3orZnpGME1jcUhn?=
 =?utf-8?B?Y241NVZPVWU1ZUREUzdHUVFKQmx5cDBEcVlpUGZ4U2pCQnBuaGRBYm9IeFo2?=
 =?utf-8?B?SXRsSWQ0MFhjWmdCNVVJS0QvbWhJSEdLY0pyamlPSUdsVkc1dmxSUkRwWnBo?=
 =?utf-8?B?ODhDK1JJcWJFRlV2eWo2VDhCeEh3WUtMMGdZZUZVTUFqTEM1SDNqcHBzdU5i?=
 =?utf-8?B?Z1UyN21TQTVKMTRuV0s5SEtEamg1ODRTSXVUeHVHQzkxbk1OSlhNanVRa0d1?=
 =?utf-8?B?dUNib3RudWtteFJkUnpzUFFPdTlxVDhOLy9GeEdnZG8wRENaRFZtL3VMWVhQ?=
 =?utf-8?B?a2h2MnVBTXZGM282UytNSEVPZ0pOYUQ2MXc2RHJTNWQ4azFGejFQYksweW96?=
 =?utf-8?B?bFRvTFV1U2dQVHV4elBERXBCeVpTbVp6QkdsYXZHN2FmMXR5VkQ2ZDN1cllM?=
 =?utf-8?B?by9aejJlWWRRNVlmeUp3a1JPOTUxMTFaOW9qcy9OM0JEY1Q1dGRFQlYxNHk2?=
 =?utf-8?B?dVRuNHpiMFVvTDhOLzlFWHd4bkVVNkZwVlhCaTkrVG1EZlNKd2Rsc1BwdFBB?=
 =?utf-8?B?cVdrTEpSaXFoZGxHTkUxQjVkbUJhdFptMytpZWIxeVJkKzAxRjZ1VkFiYTVO?=
 =?utf-8?B?NUx0ZkptdnExSmgydGFscCt3NW1QcGp3RVFJUXVyZURUNWpBS3lnYXhDUnNs?=
 =?utf-8?B?bk9sTlJrQktab09kdzhPVmtHMGpGKzBtcXg5MXcxRzRxRE45N2RPSDlBWmZu?=
 =?utf-8?B?Y2dWY1hDTGN3cjZsanZPUXRpZUhIQ2lSQ21jc0hrSi9Cd3NwaThiMldhZ2dJ?=
 =?utf-8?B?N1pxdXR3VGYwL1BDSEN2YUFNdHdhbVJTaW5pb0p6WnNjVzVIZStrRm5oTGsz?=
 =?utf-8?B?MitNVXBsdThYS0tvWDBua0lsOE9XcWVSenlXQXVzdUFEczM1TjlMajZZQWtY?=
 =?utf-8?B?Q2FBZFh3RDhqYjRVeXAzemhveTZTZWljcnJHQUNoQ0pWaHdIZm5hd2lNK3pM?=
 =?utf-8?B?Ni9NM2dXNTdjS0VIeG5YWDlWSy94Umx1MHR4akFsYWMyTzdXcE9YRTdQZ1Yy?=
 =?utf-8?B?Ylo4bitIeDYvY0dHN2gxcUZxNDNoTlAwYVI0STVoMzRWbkpxc1dJYWZDSDEy?=
 =?utf-8?B?ejZpekN1bVRBeUZiV2EzRmJOUzJzUXppQmk0TnNDUGNTT04vc3ZTVkdyNUQ5?=
 =?utf-8?B?R3BPazJmRlBEVEtvdGg3aGV6bERNalowbDZtVVJGZTlvVFI3T29IQmsxNnJR?=
 =?utf-8?B?eDdnN2xYaGRQZCt2UGM4OUVUMUdzYUIrVkRjMVU3UW9Qa0drMnFUY3JsQWJu?=
 =?utf-8?B?SzNTNUc3RzI1bWJLamlVSGZ5WldwTU1nMDFDakdWb091K1NxdGd5UDU0aHJH?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da149e0-d457-472f-da44-08dcf1f12771
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:55:23.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOm9etzu//t66S76guJLzz8WXU4nqS01xJ0Sfga2RNGLurWSldrCFgHpa/htpuikT6WXPB39m8OhuVhXtJmevg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5519

We have a new major release for the Xenomai 3 series:

https://source.denx.de/Xenomai/xenomai/-/archive/v3.3/xenomai-v3.3.tar.bz2

There were a lot of changes in this release, making this one much larger 
than v3.2. However, a share of those were related to - still valuable - 
cleanups and even code removals. Feature-wise, this release specifically 
comes with the completion of the Y2038 enabling and support for the 
latest kernels. But there are many smaller improvements as well. And, 
last but surely not least, a lot of work went into further improving our 
test coverage which is highly appreciated and should help on the long 
run maintaining this series.

Here some summary of the changes, without warranty that I didn't miss 
something important:

751 files changed, 25417 insertions(+), 33371 deletions(-)
- complete Y2038 support
- kernel support up to 6.11, officially tested up 6.6
- minimal kernel version is now 5.10, I-pipe support was removed
- ARM compat support (32-bit userland over 64-bit kernels)
- drop PowerPC architecture support and related drivers
- rtnet: update fec driver
- rtnet: introduce rt_igc driver
- can: add support for Bosch C_CAN controller
- can: add minimal support to ethtool API
- fix lock-ups of cobalt_monitor_wait over signals
- fix rare crashes on task deletion
- restore rt_task_unblock() effect on RT_MUTEX of Xenomai 2
- drop rtdm_printk wrapper
- integrate KernelShark and libtraceevent plugins
- countless improvements of the testsuite
- improvements of prepare-kernel.sh script

Thanks a lot to all the contributors!

Jan Kiszka <jan.kiszka@siemens.com> (150)
Florian Bezdeka <florian.bezdeka@siemens.com> (147)
Richard Weinberger <richard@nod.at> (42)
Aaron Marcher <aaron@sigma-star.at> (12)
Clara Kowalsky <clara.kowalsky@siemens.com> (11)
Hongzhan Chen <hongzhan.chen@intel.com> (10)
Dario Binacchi <dariobin@libero.it> (9)
Simon Graber <simon.graber@sigma-star.at> (6)
David Oberhollenzer <david.oberhollenzer@sigma-star.at> (4)
Tobias Schaffner <tobias.schaffner@siemens.com> (4)
Fabian Scheler <Fabian.Scheler@siemens.com> (3)
Gunter Grau <gunter.grau@philips.com> (3)
Mauro Salvini <mau.salvi@tin.it> (3)
Philippe Gerum <rpm@xenomai.org> (2)
Dario Binacchi <dario.binacchi@amarulasolutions.com> (1)
Jean-Baptiste Trédez <jean-baptiste.tredez@ba-healthcare.com> (1)
Julien Blanc <julien.blanc@sprinte.eu> (1)
Konstantin Smola <ksmola51@gmail.com> (1)
Martin Elshuber <martin.elshuber@theobroma-systems.com> (1)
Norbert Lange <nolange79@gmail.com> (1)
Zqiang <qiang1.zhang@intel.com> (1)

-- 
Siemens AG, Technology
Linux Expert Center

