Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17193B9DA4
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137859; cv=fail; b=HbmGH353CVRgtglJ4f2R62MqNUwkrDFt4zkMN8ucEcho9o2GWO0q1qVkGXdD0IHnIhbGjIqMdiwDodrjrPVXGqMZ1lXhfEoLWKleXZlua4zStd3YSej1gXUlCzZiHhZzF9ffe5yHdqoq+6VBMc6IYHY1BA8riw6OroScWlM83bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137859; c=relaxed/simple;
	bh=OE/DNRiaolxiZLa0UfnpK+s7ViHVV8IrC1/yVGtVFWg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gze11sNXyKkJ/PjLms6QtsqemyuDxQp49mrKtCbLjFxUf7xfBMVRykp7jnQ8hwBuf2HhnhP8WjxvXwtfPOUazCv+vlU2yHFd21SnTioxQxU+188hCC283h1Ot1K2EdqHv8td3yZgi0xAm6v97A5/bzdPkPiCnROzEnh98RQfi2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=T+K4zoj2; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="T+K4zoj2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHjTZ74NVOvEsjUW1YHt8Es2l6Ifwuo7CJk04ayBwUjVntEi137ttdiCppcaCdoNoG2AVhuqStLlkXUKYcuP7yyJH7KBZr0LB+541Dj4Kx5oHEu56r6x1H/Sx3/mbN0gNqayTZDrVdU/KHB4oHB1KD96tc6T/ZL5BfTJKv2PquHkeYEMEYE2br7j/migQpeFgIVbxbQs+d6ekLF2L3I/C9hX0BhmKE1db2WpRqusD7wKrfmqZ9OnqgEqKrK2rvwP+liCMuTlNOrDr7lRroWnXM/pftbh+BBsOvdyxxwTSd3syXkm7H5FpIresYO3dKEVWbuxbBeEYZbORXDSBMvvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYeo7PQDC83K6TXQq38FTsajSOFqpUyKUO9KU2PWw6I=;
 b=bgQeo6DeFrDdwoszydrI915x8o+YfG7tmlOXgXzuPNQR6+PCvLVoOOXe4gQNvFcvm5VgkJHWrs+rJbscbfwo2mYeGghLl/KUYb862tSY2k7qXiXKa45/d9TWCOBte2/Rq2sqDiefHtvOm9xadDqMFvx040WV2GVCMyk8FzABk51uTgvPcUr1ky8+WuxmO5dVkGXmz5e3trdtiOA2aG0GJvg15MR1SGsEt4/79Ku93+TuLIEE38TWDJJe3xvqejOtlq2ipnmfkDX5DSjyBxhr14+FdqXpHl7IiunVgEVWAKu9+m04htPuMQI1FXWyMKGzivwWO82WJ/Ok86haIaunHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYeo7PQDC83K6TXQq38FTsajSOFqpUyKUO9KU2PWw6I=;
 b=T+K4zoj2e8QIa61JnMRXBqst6akuMgTpUfAUVYBXkPeH7SoxjgiMk04WoxL6XI6WJBKAqFQ11+NUspG53bkGJN0Tl9+X1dHBErU5guipIBXIqP+fJ5yKgYwZMQlikKR1wiRXJ4CXXCQ01dsn9Ty4opvPRI9rM3zwm6S77DNxfiR2Lc8ly/f2Wfmsj1qtQvMjSSZc+ug49VYgqj9MFCA75s5RivPSamrNZ2saxwxnf9UVqnBHWryAlu7VEWIF2Jw3UIjOSPwpdND7M6cmt40zsAGj47eir5DlhI1tMI45eNuo1YfBmarAZJQ0c/L5kXNDhFe9LZjgNY51kyDKG3iPmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 14:17:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 14:17:30 +0000
Message-ID: <cda3f311-155b-408e-828e-e90c21c857ad@siemens.com>
Date: Mon, 22 Jun 2026 16:17:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: After upgrading from Debian 11 to Debian 12, the latency became
 worse
To: mars_liu <mars_liu2023@163.com>, xenomai <xenomai@lists.linux.dev>
References: <7acb182.9d78.19eeeecbe17.Coremail.mars_liu2023@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7acb182.9d78.19eeeecbe17.Coremail.mars_liu2023@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a2a766-203f-4515-8859-08ded068fe83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|11063799006|56012099006|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q/xz6ZPejmw3WbwjoXW05pA3aeT6lEKYPteYf8WLVd1R+xql+gaYPqZZGMpWGGKPYn68H7q58SeiRicC37aNX/s1IHdVNMIww26Sh2LMwvzbS8DD4Q92u073BIIOLGFTL+76ajEpH+sOofGSD8DYYhKIk1NVQVvnCx1e+sXj/gRaP+4qMUQlDycOoz4TlcPDKIM1XVh7aqVmLX/iUOjY0FFV92FU6MWd2mrZJKCa9vmaUJf55s783hc1bV0lir4J2L1z38lntqWjHRQv5B2bLF2+MroZsCG9PXXXUYipViqa/STTEINKibxsn8K2oUPZKjoq/2A/JxAcMBvflCCXJiXsdtA8Ym5WB2KLdveP8WR1w/rBgRsSeiV1rJgsBAMhfEpmaQ5b7rysEScnelR1c0QdMk+Eh0+LvSCiJX2h12ZRACmlsFoAf+4+z+CeZS+iuRtRxPe9IrvZwBY8cXwxslgKp2V/j/jF0afVNfNK5cGo8BLsI2Cslchm+rXyCqF4h5qAlbi8YudG3qkw6iFfFgZ/KruXmLGt6ZxMhlldThzllUAACZxeRNsesGt97m1tHOW/ZEHvab6FcRnC7ay0ELr4Ug6fvtKv8HBgXraQWIynGs4FMuQyG4saKS+cpP2guuTDVwzNjdV2p7dfqdATBud1wSfL3VN3/ex/j2CFiVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(11063799006)(56012099006)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDA2dTlZNUV5RklLTG9XSndUWHFnR3VnRDNSenQ0UnNqZjFib3NEYWZpVjRp?=
 =?utf-8?B?MzNCOVBlNGxlSXhZMDZTdytmVXVmNFIwMlpoZnVBTTNrNXY4cGIxL2grVks1?=
 =?utf-8?B?QWZKVkZ0Y0ZHaTlhZ09wZFc1Q2Q3TExrWWhXTndlVFd1Z3JMWnRKNXRRSGkx?=
 =?utf-8?B?ckIxZytZYWpOcWxPUzJscERwRWMxMk5kYzBZMXNwUVFOMERFeEJoVmNkVnpH?=
 =?utf-8?B?Rk9uTzZ6TmdpbnlmUkFtaWt5bW1FNHVpdHRGSEp1QTRqeU5hTU9ydEFBb3cz?=
 =?utf-8?B?WnRRYUcyUUZmb0hFSjBKaGluRTJDekhFb0xRSXNQWWEvSmRCejBWMm0rdVhN?=
 =?utf-8?B?OEErbm04ajc0cEZBRXJLdWplaWhMUFV6WVdWTFhaZFhaMzRNcU85NnJHZllu?=
 =?utf-8?B?Ti9XbWFLaUU1YjNZMGZzUTdiSHJoTzhSS2EwRExKTG85a2ZiOXNwbGJjQkRB?=
 =?utf-8?B?SGkrbTdTSFQ5QVd6a2NNTHV5dGVBTktXckp6N05kWW5LUHN3VVNMUC9QTXNF?=
 =?utf-8?B?UlUxR2VUeVdJLy9scnpuY0FNbWlKYkVzdndKaUxRd1hMMDFFVzJLYTVpdnpa?=
 =?utf-8?B?M01KNkFXNEhaOUZCbXNoTTFOTURlNlhXdktTeEd5K2VyNzloZDlVVHd6K09H?=
 =?utf-8?B?ano5clNyNTNmVlp3UCtBMkRJUGJkZ1d1SEVVbWhzbDk1RjczT2JiQXdpRFNK?=
 =?utf-8?B?VkRRM2NLNnZxVnRRRmlVRDhkN3lVSHd4VklMRU02eXVibGdXUThLUmlIamQ5?=
 =?utf-8?B?NU9taTY3Rm9RTTZ5RHA4bnE4c096TEQ3bmplMUMwdTFtZVBRR1c4TWlPZjBS?=
 =?utf-8?B?Vmpyb2pYazdDckRHVEY5T1BCbWQyclZZZ3RHNGY4Z054alk0UDNOSisvVFlp?=
 =?utf-8?B?VUhhNXdRZzlURnNtc1BBa3FIQUx2YmZ6eUd4WWZFYWNtNjJpR2pWdmd3SHho?=
 =?utf-8?B?REJjZ2x5UGd2VlJNYkw1U0d1TjZRTEJodFVGc2o1TzJQRTNMSGowckJiWmpI?=
 =?utf-8?B?UzhWZzRkNktxckVETC9KNFljMzBUK3hOd2xTbHhDQWM2UkV6WFJwVmk3dUVn?=
 =?utf-8?B?OGJVSkswL0wzcHUyZXN3QUljY28rMGJlVVVwTDVHUkNWYVpCenJ1dnVmMmJv?=
 =?utf-8?B?UDBzTXozaXNuQ2pUZ3Z5TGM3d2JJZDVUREk3NzJ1T1gxS295aDNYQlRmd0E4?=
 =?utf-8?B?NWVIYjFDT0pNcmpGbk83QkFrcEhxOFhHWjh4SXYxTmxyRnpRWStYSDF2TXZK?=
 =?utf-8?B?bW1FRGhWc3hobmJVQ0JTVXRkWlAyMS9lZzlzb3hDZFBGU2NJUHJvUVV0SVEv?=
 =?utf-8?B?UkpFMzI4ckEyQ2NocDFST2JlazQ2R1ZkQzNwcEc2Z2djQytCdDk2KzdreERQ?=
 =?utf-8?B?M2VwQzM4S25STlVKOTJGclU0YTZkbFF5MHpnZk02T3prR1VXTGgxN0pKYkt2?=
 =?utf-8?B?eCtOUTE1c1ltTXJCbTVIL0hZRG54ZTNOM3BUT012ZWg2MkJSc2wxT0MwMUlE?=
 =?utf-8?B?ZDFJNDYyenUvME0yV3o4V1JhNUw0WWZxeHUxSU9TamxrNmQ2S3BXUE5RZXgw?=
 =?utf-8?B?SEUxWjNzakxYNTV6N3ZQdHUvSVM4QUJtbWJQckQ4MFpaUnY3YSt2aW1jVE03?=
 =?utf-8?B?RlJ0YUhFS1FoN0lrekk2UGxSVUNXcGxXdlZrVlh4NmF2RW5VUkZJNkRWNDNN?=
 =?utf-8?B?R21DaGcrV1ZPbm4ydmp4Mm5leWVXMm8zZFNvZm9sMDRBSUd2TmlNQWE5bk56?=
 =?utf-8?B?MmJpaU0wNEYycS9lZmVMUzJNU2FwQ0Joc0NnNTJtL2czVERLQ05WalM0VFRG?=
 =?utf-8?B?SkZVY3BTODY0dFJiR2hvRWZXWk5hRkpWSjVHL2RLZXl5WHExTWdacWdDKzZv?=
 =?utf-8?B?VE94WWRoRUlXbit2RFBJOTI5bXRpNDhKR1BuYW1hOUtYNmQvcTF0d01KRjla?=
 =?utf-8?B?SVBvWXFUY2dGSUljTmgrQWJoL3lGTWc2NUxYL1ZBcjV0RVc1V2RhMW9EZ0Vp?=
 =?utf-8?B?T3RaR1BtZjBmWEhVcTI2T1lKRE01NHlPYVlPcng1MjVJWm1TdXkzelErenNR?=
 =?utf-8?B?eDZlbnNUZWhoYjcwVnh5SkhpN3FYRW9yeVdiTjUyZTh3YzNQTjROckhMeEVi?=
 =?utf-8?B?TVpTV2NlUU9iYXIrbU1KNzdZc240YTJqcldCREp0MnRRbnhPMDc2ZFZERlFp?=
 =?utf-8?B?ZXMrOFRoaWVHcURWaE9vb1Z3L1c5Qldjc3JNWGQ1cnNMeWplUUp2K3d1RUQw?=
 =?utf-8?B?RG1hamJYVjJjdDlJVFRzWi9UdFFzaGI0L3dDVEgzeXlzaU5nK1FtUm5MSGMy?=
 =?utf-8?B?eUI0MzZsWnYwcUlBd2d4Q2NyaXJXWTRGdXJSV2E4aCtCcTV4QW5yZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a2a766-203f-4515-8859-08ded068fe83
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 14:17:30.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydR+BlnBUeOvWcvNBX20HQKpZpwK30nXayDa/X6dPadqwAxtUE6cmbn+4rXiy29L7g8seudeIEEi8mjtB2fFzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6242

On 22.06.26 12:42, mars_liu wrote:
> 
> 
> Hi xenomai,
> 
> We have a new machine. When we installed Debian 11 (kernel version 5.10.199, Xenomai version 3.2.4), the latency test results were quite good — the maximum latency didn't exceed 40 µs. However, after upgrading to Debian 12 (kernel version 6.1.121-cip34, Xenomai version 3.2.6), the latency got worse, with the maximum exceeding 100 µs.  What caused this change? The new kernel was built using the old kernel configuration. Is it possible to optimize the latency in Debian 12 by tweaking the new kernel configuration?
> 
> New machine: Giga Computing MW53-HPU0；CPU：Intel Xeno w3-2425
> 
> Thanks for any suggestions. I've attached my configuration.
> 

Can you try to systematically eliminate variables that may contribute to
the increase? E.g., use the old kernel with its original configuration
on the new installation or go back to the original Xenomai version.

If the kernel is the cause, checking once more if the effective config
of 6.1 is not missing or adding suspicious things compared to the
effective 5.10 kernel config.

An alternative is obviously turning on tracing and record one of those
events that are longer than expected. At least basic event traces
(cobalt events) should not increase latencies on their own a lot while
giving a general overview what happens.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
