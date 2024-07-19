Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DEA13A276
	for <xenomai@lists.linux.dev>; Fri, 19 Jul 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409738; cv=fail; b=g/fegLpiYlQBg6Jc4uOyq2lFoVsiKZVW3qP+mNNoBA/Fb4dUoqqVriekrmockBJxob81zbDQyTyAuN9ieWkAqh8BqQgclOW+cbhf89vRYr0yJFIgzu2WwVddDalJOHs8S5pqAaof4QO1dgwXbsC0s3VDrTqVRjC35idD8p9ll/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409738; c=relaxed/simple;
	bh=I/eftAFnuIMst//LQqY/uEz2zLSRlSJAasHrUfbjhB0=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=gUBxwcGI31akR5ySItH1tBTpAi6DZmdXDeMduhr/Ihy43OOXgvMRGc3pJlaRLteo3Uftgp3PJ6pBLoHNDRvB8IGYpP2W09NVo+P31wTH+/nyjxcmv9fIypYppcDG7mJlcPj/pFrnES6nw0XiggI8S3Ynzr1taoiT7f/f1roEgUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IQ4ino2s; arc=fail smtp.client-ip=40.107.241.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IQ4ino2s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3cI8N1PM0S5L6TxClCxqHtRfjigJBCGFVOzOQiT7uvSPyL7PotiVLXxhVZGJqVVaR1iRpAnl39ZCqD8Yzi/KQAiY10rjsg0iLOfmB3kiHBY3V8QKeCIzGqkzqMpOkx94tIbCn8cyTPF0UaDJl9jKAqpEQzbTogt+dG1y3VRZzl9nNz6P8GkPND4lpKVrELdb0L1jCMgUhDVaR2KAJO7StxUfGRUHgXIO9k+37/ks0+SA/sPyVksu98IJ8IddH+4UMSDg9+hDdfpVn5ILOe9gywgcMfcWvomdfYegSwkcjp/ecSB6rATzVogg7WvybdDaAfc8D+bwU6LsV3sbKjAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuTKSsihdBvjp/1UoXcdP2+UxC4Z0LLo9PQrvNloMGc=;
 b=vV6F2XLnjjvjXG0YQfDYe7usTxtxBJuu90sU2e6AD2LIzsxZLNVQawXCXfWHXWK1ntEfnLYEzRV9Ub+VA0c2rXwUQ8Hag6w0ifsjljX2nTK85kXlYF/xWQQCSdyMm1AinMCwmxTI/tZzx/T2PhPG6LiKU0+uj5kS6jBrgcgbRKyhXtM+OqP58hK4os8p2OfIDQPImNEaIpdkaXA5C1/2FfkNR4mvbBO3F42irIrmS+4hcVXi/76aX94XMSurCQ8Ng2NJ3x+Pm6kHHneVivyWmIbOSrvnxZdJDWVESvsDg0g1jrkMVII7Edyhe2z5/kB8PxI1a5L/NaZdRl9V+s32Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuTKSsihdBvjp/1UoXcdP2+UxC4Z0LLo9PQrvNloMGc=;
 b=IQ4ino2sJK1r5MeiWTmeI87ipWUwFQSvryRWQR97EaLg5LvTXdp7FtqVaEscd15s7wDHk8B5JC9H4VO8gqUGYu2MiXe+UkVCIKPs92XSVM9ZDZQz5e2k3OnAuBEkkPT12mv8ZSNhykglg6x6vXy5uvRgPEiKWcjXy6Za+DuIwjh1Z+20XyvztkS0d8TPb9VP/MGWJ7A4ET5RXydgh5s09P+3Jp3j4sXp+bqvJUxRbhQytHcGx/+ZMLEL2BORhTD08v8690AoSGqQNLFb+dUlW1zBIN6O9Rq+NJO23MzQDhhulnBGqadAH1VXTR+X/Jb2I0OUBK0QUyq/Cgk6Y6LvZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 17:22:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 17:22:11 +0000
Message-ID: <a125733d-8b6a-4bae-8b82-48d909bf12e3@siemens.com>
Date: Fri, 19 Jul 2024 19:22:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.3-rc2 available
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbd9a26-66f8-485e-b37b-08dca817532d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkE5NzV2NWJLU2Z6V3JJNzByTXUxR2wwcm9VWVlqN0p1Nm1ZNWJWQ2xUUFBa?=
 =?utf-8?B?UmlhNFNUMmwrSmJvcCtlTEl3Zmh2WlRuSFF1VEpzdDRnTjFWR2k5cHdvN3Nk?=
 =?utf-8?B?ZlhUMXdQSWFWTnZIODdGVERhSTJUcE8wUTJHNnpYMEtDbFlLS29BbTcxN3hP?=
 =?utf-8?B?VEdDRWhnWEs1enR1ZXc0Ykx4cGlZdzBFdkVxNkZPMG9QMkRYREo2Y1dMS05U?=
 =?utf-8?B?eHYwZEovQTMxNTNhYjRFcEtEREtJaHRiaW9qZmZ1VnRtMW5EM1J0d2Zod1Iv?=
 =?utf-8?B?eklqd2VBV0pQYTYxMlhHbzl4STd2MDJKV3MrQXYxOWNta0pyZU5maEh3UWFh?=
 =?utf-8?B?RFp1T3BnUmJGOFFnZnR3V1pLanN3aHJpejZ6RWJkS0s3VXlLRWtMamt4MjI3?=
 =?utf-8?B?UkZXeUwweW4zbFZvcXhlMTBVQU9Mbm1QYkdKM0lYdTAwcXRlTmEvNERORkJS?=
 =?utf-8?B?R2NiOWFGWkN5ZFFTVEZXN005NytsL2RMdWNZUlc4OVdUd0FDemo3NWt6NlQ5?=
 =?utf-8?B?ZDFTZEcyT1o5YVYxNTdkTSt6QXY2OXJaRGUzcVdGNkVpNWFEdFpiNjBzM1R2?=
 =?utf-8?B?OEFOYXZIZ1gzd1lrZmRkejNXMktmTmF1SjF6UTJiZDBVOWhrcXMzWXFsY2Zu?=
 =?utf-8?B?VlVNdFBpOVRxY2hGMzVHSThDUDJBUlA0b0NCN0k0UkhhMG0wd0tDd1lPbjcx?=
 =?utf-8?B?V3FUTXhxVWNFL1dkSCtLWHFRbVp0L2R2QW4yRm5aQTFpR1N2OUJOSzFOZzRi?=
 =?utf-8?B?alVWeURVZU5rQm5KSDkyUXZranV1NE9qaEp4ZS81R09CemkxMUZjbjNBamNo?=
 =?utf-8?B?RUlvdkYxK3kwamdxUGdBUFhBWGQyN3E4QS9SaGpKV3FOVjdhUFQ3aFRvbWtO?=
 =?utf-8?B?SENtN1Z0STZkSDl0R3dkR3d2cXdQREpESERMMEJDaTNpTlhLdkM4TjZVeTY2?=
 =?utf-8?B?MWx3dHI4NW9GUGx0TFV1OVIwS1FUb1ZUNGlKZ0ZFVEtEaGlJY04wYi9PQWp2?=
 =?utf-8?B?Z2FmQTNSVldmR00wWWJ3TWl6akRxYS93N1VPTWJocnBJVXQ3L0FTU2c3QmpB?=
 =?utf-8?B?SDNNY01lYkc0RzVZQ1owQndTNGRja3JrUmZtZjVWQWxGV3o2NUt2bGZHbCtU?=
 =?utf-8?B?eHdLcGN3TjlZbGhCK3BXdUxlbWNlNGViNmMrWVk0WUs5azEyc0x2b1FvTWlC?=
 =?utf-8?B?enp2VGt0d2Roa0VMbHU4S0JGLzRxdjljZE9jdVhvK3Q3ZGhPMTA5SXpsSGlw?=
 =?utf-8?B?U1RjM1pzRXg4dGswY0pURlFNa0Voam9XaXNOdmh1YmpVTlBqaWVDYUZ4WWRk?=
 =?utf-8?B?YzJoVDBTcExHRTBDUkE2bytBQ3JSa1VuWXNlL1hIaktjWE1kWG9IVkh3WXZu?=
 =?utf-8?B?RXJaSFVxcWMyVE5XZHE4MWdiMncwbzlzVUtQd2tVME81WUZHUWlzRGdUb2d5?=
 =?utf-8?B?UEdpYWRwdVdkVEtXRWlpRm43blpoRXdXN3R3eVVvN21rQzRUMDNZQ004RWJo?=
 =?utf-8?B?Nm5Xck5CRU1IY3hiRmlNRWNzb3dvVXRRSjZOUnduY3Q2Y3pybHMvbnBCT045?=
 =?utf-8?B?aTRQN2hIUjR2VnVBSCsrVlJOWmNRNXl2NDUycUVuL0NhSjZ0ZFBOOWErd25H?=
 =?utf-8?B?ektDVWhGVDQ4ZDhtbHhNN1BVK2VYQTM3L044ck1oY055SXk0WlkvaGVoYWdj?=
 =?utf-8?B?aVd1RU1SSzUxamo1REliWGhMNGdBRlFJaU9UL0hqTUExcXRqbW90QlEvKzlS?=
 =?utf-8?Q?JuEycZimrj8xF4k2i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1preDZUYi9yZ0NYOGs4QmZQWnRHblAyYmFBaExSeG12dERwMnlEZ1dsOEFX?=
 =?utf-8?B?WGp2N2pUV1VZNHlpQVNJV093dlhGRklFZE1RNVhIVUx1clZYcFFtQW5pS1Fz?=
 =?utf-8?B?VnFIV25EdEU2QUdoMm1sc2lrcDRFdnIvaHRPMjZkSFZhRFhGVFAyanVlSk15?=
 =?utf-8?B?cHF5S1NET1AvMUtZRkZTQkdDNld5MWJvWW9tN0ROMnBBVml3N3Z6UDZzZ0pR?=
 =?utf-8?B?Q3dQaU9TdkhJbG0wakRaeml1MkRCNFNDNnF1cUxKbWdhKzNYbXlVbFdOM2x4?=
 =?utf-8?B?UzBsM3BnaUtLdHBwaGVXRGNHQmg0YUNXZmdBTFlZZ2RMTDhpZTRabG54aTgr?=
 =?utf-8?B?V3RCWlRiUUZVeGM0aDQzTU8vVi81MjEvZWZFTXIzOUw2RjVGaTdXNm15MnVX?=
 =?utf-8?B?UVNrZUtsWVZvdmd4cGJ6WUNHVVA0TmpaQyswZXZja0V4Z25OMTVFa21hZkNM?=
 =?utf-8?B?YWFNU2Izek5ubzM5b1FBMTlBMG9oTzE4ZDR6K1VUcDczejdOSmZZc1dveFJ3?=
 =?utf-8?B?R1NIWTZ1bHJzQitrWnJBWEk1aTFYKzMzQjRCYU84SkJ5UEhpQUwvVlAvbStZ?=
 =?utf-8?B?eU5MaHpoQ1RBNmpUVG5JWldOMkhZcXIwcXM3N1l5SHQ5QzZLVys5bzJlUThQ?=
 =?utf-8?B?N0pYRGo5QXRuMVl0d3FzQWtQOURjcmV0UnVWZWxEU3Fib0ZzSWgwWm9mVHFr?=
 =?utf-8?B?eUE5YXk4MkdGSFR4djdadnhvUFAzWXQ5K0Y0ZlJ2UC9idXVGZU0zMEFiUUt6?=
 =?utf-8?B?VTBmWUtwSm56Vng3Tm1DRW1rKzZiblUxVUh5T3VLTUlqS1E0MlJtYzBXRXRl?=
 =?utf-8?B?cGR3NVVDMFY2bmRwYnJvVU40YlZOVWRvSUJXcUlpRk0vOExqZjRXUG5QcGpu?=
 =?utf-8?B?SEZpSnBYbTlMWFpaNWo3UkwxUUNDRFVvVFlYUGRsTDJaU1FqNGpaZDlWNVNL?=
 =?utf-8?B?WlNES3I3WU5CRUZ0UFVkL3QxbFpjS0Z6SHpHVGJnYWNXM2NNRHlBbFAvdWRG?=
 =?utf-8?B?N3JFQTd4UkpSRGRZOVE1eFNXbk1LWHNVZDI0RGZFdGx5azdkLzRiR2ZWOExS?=
 =?utf-8?B?RkR1SFFoNHRrRVB1cDU2QzZmbkZxUFg4cWp1RVZieDl4VGZVNHU1MFNRODJP?=
 =?utf-8?B?WWw4Rk0xTjFYMWJhMVVHc2JlZnJIZ0s5L1Y4anNvc2JreWNGbi9CUXpPbHNE?=
 =?utf-8?B?bjczMjB5VkUzZTBUTllhektFZzFQdmxQUGoxZGVZU3ROdmFQY2ZPektueDN2?=
 =?utf-8?B?OXpBZzVwTVNGK1hOcWhSRWY2UVV3aE1UYWtUZy9FU2U5c1lBN3dicGhtV2JO?=
 =?utf-8?B?Wm42WXNGS2QrNmk1dFZhRmU0dWt0M2RHc1NrNlFtOG5LSGw3elRjWGY2MFVK?=
 =?utf-8?B?TWxHMDd0Q3dsWC81dVM1VCtuQ0NVMnV4ZVI5TWRhcjNkSW5lN05ISnVhN3Fy?=
 =?utf-8?B?UEFKbHB4ZVlIUW5taGFxbjd5ZG1TZlljKy91dEpJamF3dnZPMlpwNG1XU0ow?=
 =?utf-8?B?UnptenRSaUNNSjdHUmEzYStXN3Z2TjRVaEFGNWlyaHVubUYvRzQ5QXFmVTdD?=
 =?utf-8?B?emprb3VYZUNZclJDQXM1eXRjT3VXS1VTaFY2NEJudjdKeFZrMGdNOU1Vd25o?=
 =?utf-8?B?SUNpTDRsVFNPTVlzY2xLVFkwT3AyUXRxME50QWI4WkJhazlSZGwrRU9kaGNR?=
 =?utf-8?B?dVdDRDRBZjVZalRTaHZqblA3SkZ0UFhGSHR2MEFCUExIUHFYQ3hQTXR3K2RK?=
 =?utf-8?B?M0ZhVGp3Z0JJT1MyTWk1N0VVM3FyN0d0YTdId3oxV010ZXdSa1RNS2Y4Ujhl?=
 =?utf-8?B?b3Y5bDFmRHRpemY4SVMzekRhdW1QZTYrQkpzcTUvaUQ5WFZtRk50Y3U2dEJz?=
 =?utf-8?B?d1B5ZzJUSU5QMGQ5RVJESE94aklVQ0oxa3RFcEtDMDhZNmR4eVR6ZlFic2Rj?=
 =?utf-8?B?M3NsbnB4RExYMytXRHA0MUszTDZnNS9OS0JRTWlJd1dlRmhhVXZQejc1MFl6?=
 =?utf-8?B?bGlKRUhnd0hFbklSUE9mc1FOWUxBN0V5MUVyVkcwdm9ZdjhqNm55aGdud1I2?=
 =?utf-8?B?OHJXeGUzbDRLWjFvZGhmOTVLOUpIV2tyOUo0MUdNSlZWb0g2d1hEbDU4Unho?=
 =?utf-8?B?bjhLRGswdnJlK3h5L2MxQjQrQVFWTS9GK0ovNEc0ampMY2dzbzRTbzVXM2t0?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbd9a26-66f8-485e-b37b-08dca817532d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 17:22:11.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRANWShBUE3cEWigclwhnPtPvuh1uCbk8p6NwSc60ZHB9DTw1+3uaDULnS0MhwA6o2DyMAIOc7P6UNdgGzrVGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5319

Hi all,

there has been a larger set of changes after rc1, so I decided to add an 
rc2 on top.

https://source.denx.de/Xenomai/xenomai/-/archive/v3.3-rc2/xenomai-v3.3-rc2.tar.bz2
https://gitlab.denx.de/Xenomai/xenomai/commits/v3.3-rc2

This primarily brings support for kernel up 6.10 and fixes / cleans up 
printk, also by removing the rtdm_printk wrapper. Please continue to 
test and report back!

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center
