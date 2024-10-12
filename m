Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8910940
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728712293; cv=fail; b=c4F+B3VaJAs3G6Fhc09Lcm6lkuEE6VbMIOsM+HHLZYjf858BiEaiRvCVIN8RKeqIiTUp19NAkRmc93SiqOzR4i98qYLB2e3OHddy4aUZcl2iag2g38PUWxEUzbmq3+rHJRWLFwBhh9DVZW+WuWhVuBklg97GMa3pHYkF65M/km4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728712293; c=relaxed/simple;
	bh=oF25wNBZEo49opgq/x4TIsODd5F/cI75qKLD5ww4CvY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qkAK5oeWAjjg8JX7ojJ3srgt8M1Yo5vGgbRPW7Qp9MxRqTVHIl9OAP1IDyZBrVBSGSXZBt4D+vmVBKV+WJIcBGTu4BKtLdOqs6iSj/KrBD0W9kGn7UnB6AAPn0yjD1JrmSojyHxDCqNiPPQt71PBa+Sib6U1BU6+YIs2cKB/PHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lsEqu/Cg; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lsEqu/Cg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVDcPjfQwg7OJCNeEgTHqpdchSvXeS+RWSL0O3uV25zsg4m/igTPVVH7dpBdB3qgBCl3ifTGl0inqhL84p1lTliqbsURs0Dn3pcpsX7q0DVFDHJEYybKfBtU1G1ioYEnMdwm5LrjyTI9PeMRcPyoDuPKhpoZ3H2XFAHXjpOsTgOxOwAAtKrkdtj9cbiIxP+/GvdQLlrUPBafTS8la23/2Wy1JwxbUdT+O2cxLAX6VnvHAlkWNsgv0H7rwSgQ9DtByq3QHXex5Q5pDEunM1LabacDqayvQd6nT1HMROou2aTTHIp0qzvRpBFE1oPl+a7jMPTwsGe6/E1EkQiBQbt+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LBIsPNM3BW+K4bd0GH8lYMGSoeOj20XXodX3DTAejE=;
 b=iOxxVxnaGpMGQxfXUDMDBtSaiMx23NnyGq8oKpYzPcvuupZR8Ax9tFXxyE4EJoOJn6HPrsFaKNUOjIgn1GHk581O1hGHh2xSUZE4D7alGaysnWKI0NvnPoHZ+0sHnWu8lmO+GZVLXgBD3k1HVZWaiAolkoMt5cJ5LdrYZZ35lgTFxcnqbQOQ4zN6Vc7e+xIk3uvXa/6pxsHKxO5bRsuEdo3T+y5QCIzJSBKbsY4gxw2I+nIq7JsQYyhckVjXUB+kxDD4DetRPMYXeswgBxBEYR7AtwxznscdB5oMKO+ZasO1GqDvMkJ5SMxW/i9q7FHhWkU/4XcUmTbsr4qc1DBypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LBIsPNM3BW+K4bd0GH8lYMGSoeOj20XXodX3DTAejE=;
 b=lsEqu/CgdCeH1LNOp0/NvnXP3kJziebh17OB+Gilh/0gVUzXPRWfsEJhPTv041DrwzRx2Cf22l4mGIRUs5hvO0f0PqpDp0VFmGFxtC9+Sz5ScINWOMIE04LSAQW5Jh6Silfgm9tfX8t9TOpW1AdOhAyhPR1I7ZlrkU9fPLK7HdprkpN7b3Je92zcoX+Wyn8pj2VxtL/kRk0zqjJrJhDHzOL57T+ksAU2GutyP2XIhYCReZBJ0TsTOjzIRWVXcnTK0BNRg6+eRqJ3RO875Wo8h4yhx59EXby3cESvjbQAw/Rl1MI7PQT3DRJO+gg5nB7I8bleMSorNoQ12kpIVvLOcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17; Sat, 12 Oct
 2024 05:51:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Sat, 12 Oct 2024
 05:51:26 +0000
Message-ID: <61a1021c-d7db-4909-b1c5-1f64f2ea34e1@siemens.com>
Date: Sat, 12 Oct 2024 07:51:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: f81601 can support
To: "liuyang@sinsegye.com.cn" <liuyang@sinsegye.com.cn>,
 xenomai <xenomai@lists.linux.dev>
References: <202410121225410113725@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <202410121225410113725@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b90e2d-bc09-4e73-23c7-08dcea81e93f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkJtVlRQaFlNdDNvQjVzRnFyZmxkQWs0alZzRmtjQ0xrMjFabU5ZaDhVUkxO?=
 =?utf-8?B?T3pFaW5US0FTWnhhVWxSWmQ5Qm1Yb3ZlQ0lOancyd3VuT24wcWxnV0psd0Fs?=
 =?utf-8?B?NHcwNWhkcmVpcDlRbXdMODREZkJkK2o2TUxMVXhNeDFuSnNDbHFpdVZyOEFV?=
 =?utf-8?B?T0xreGJ3cGt6RitQOVNXMXp6UU9lMHg1L2liWGhFUmNJRWFScTRRSlZiTG80?=
 =?utf-8?B?amlSTmdFSkNUV2Z2SEpBbFg5LzAxR3Q2bDhpQTg3WG1adXB5eEV1a1JGbTd6?=
 =?utf-8?B?RkQzbXpXN3B5eUJWSjd5YUViaWpTWjlKT3FMSXV0SjhXd0pLUzlwYkVITE1n?=
 =?utf-8?B?ekJLMVFuV1hCT05sVGU3Ym5LM2M5YWJHNTZMNVRQcVpvdVpaR3JMT1RFZTVz?=
 =?utf-8?B?Y3BYa0x1OHRmTmY0NGl6Q1g5cld2MUN2UVgvREt3Qno4NFo5NjQyNHFGZUpL?=
 =?utf-8?B?U2NyN3B2VlFMa21uMHZOaDNmOC9weEp5c3N0TU5YdTd2WTdSNUZuZ0w4UHdJ?=
 =?utf-8?B?OVRXMGVtYUtDMEMyQjRjQ0syWm82RlNEMFIrZ0RLM05QTm02Zy95bFRKZjls?=
 =?utf-8?B?T1BDeTVuQWxSZjRDSjA5WUt6Y29EUEc4M2t3QjNTVGRUdXNlSnZrWVNhS0tC?=
 =?utf-8?B?b1l0bFRxVHlhcDIrVlltYlpHK0REcXhnSW0wUUNveGpoUU5iZDg2YkRXN1A4?=
 =?utf-8?B?RmRIdGNxeHh0anUzNGZLWVNvWllqWEE3UjdLY2pEWG5SQTM0dm9IeDFGVkt5?=
 =?utf-8?B?d0RNODlYT3AydzUwNXpRRVQ0NXdxOU13UDcwb2hkREQ5MzVSZEdBQ3hWUWlX?=
 =?utf-8?B?bUdzdFNwb0RYRjFxMzNhM2hFOW5DRVF0VmtXellGd0NEN2V4bTY2SmFWNG1O?=
 =?utf-8?B?SHhwSFFMcTFWc1lmZENKSXZadHVjK0FOZDN4ekJZNlFVMXdPMlNtY3lOWllh?=
 =?utf-8?B?OWFQNGtMblE1aU5SWW44Q1RWb251bkYxU1c2NFlENjRiZ0Y1bitnbWExMHdt?=
 =?utf-8?B?ZStoWStXZUpLOHB2OHpVNzBmQVNZK0V6Uk4rZ2dSRGc4YmlIaHAycDFCb1Y2?=
 =?utf-8?B?QjVQY1VtT0RHTldTcUVNR0hsdWRiaUQ4Tkdla3A5ZmhJd2RTbzFXTTk0SlNw?=
 =?utf-8?B?bTJoQjFLZTl5SWNDT2lOSytJVFdKU3dvYVd2YjhKZFViamFtMHBzQ0Nnd1Nh?=
 =?utf-8?B?bUFoQ0xlUGhvOHEyVlRwYVdFa2pnRFN5RTlzbTk3UUpXZ1ZUWlBtd2Z3allz?=
 =?utf-8?B?UVBkVkpXdWlPeGdONFhrbjZvbXg5Q1dNSnhVYmRKZGx5dVorWjl0K2JIQXZx?=
 =?utf-8?B?cUJyKzRHSVpSMkorSk9zNGh5SzFkeDNWNG1BZGkybm1waW9kcGRsaHlZcndT?=
 =?utf-8?B?TytuZmJKSGVINzQ0QWJ3Vyt2VUE3L281dDV0dWQ3WkVvblNWczN0RzRRQVJB?=
 =?utf-8?B?bCtxeTFEcjF2UTBJMjlEWnVLREpVOGVhMmswc1lpaXJpdEl6OXJYNy93TG83?=
 =?utf-8?B?ZnRPWndkSWdpQlc2Zm1DT1YrOGpiNHdWczdISWhIZXVaZkZaNHVGRmVZbXV5?=
 =?utf-8?B?c1Y4NlZuazFCREloK01TaWRUK2xQd0QrcWNIb1BPOC8rakdURGpZSzViQWhh?=
 =?utf-8?B?ZlNQUTd4UUtJRlU5dURaWjl0aGcxZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3o3UkhkZGVNancxSkFjYlF3TFNZd3dJeks4Tng3OHdHZFc1L2QwQ3Y3R0Jl?=
 =?utf-8?B?OEp6N1VnbGcra0FEck1TZmlTOEM1QlF2SkUrcVBoMzQ1VzYvZ2xjY2pBMi9Q?=
 =?utf-8?B?cE8vWHZGdWFHU25vWTcxOGowOW1vK0pRMU1QMlRDZlNrcWVTMHZ5Z3ZDWk5u?=
 =?utf-8?B?TWsvNVlIbHhJWXpJOTFWdWpjRHNYUHVSOTVTL1ordC9WTG1tblErL2JhSmtE?=
 =?utf-8?B?bGtDVTRuQkdGSGU1bHpINU9pUXZtd1l5cjkzRGlBb2xwZmFINGM0Q28weHZw?=
 =?utf-8?B?QytFVjlKaWt0SVFpdnVxVWEvbEE2azZ0NUNSVGg1N083aVBvejA5bXI1ckxt?=
 =?utf-8?B?WndXR0ZvS2pxcU8yaWhkam45bSs5NkxmQmlXQnFJU2IrQVY2eU5BbVdHT3l0?=
 =?utf-8?B?ZVErdXBQYTJ5RkFmS0JDS3BZRmR0RlNJWlBzZGUweENqWUF1dFRkSTFoNkJh?=
 =?utf-8?B?VmhSWWVxVVBnR3BwVjRZL2NkZEhjdVRFWjdUNmd0Ui9NOEkwblF2ZUNISTVz?=
 =?utf-8?B?VGhpVktTWVZNcTcwT3dJd1V4cVhhREM5MjlBbWRCN1RnSks5SHNOVTZRM3oz?=
 =?utf-8?B?eFlrSy84SG5TTXlBbjAvUTg5ZzFObVNWV09FUGZuYWtObGNtelZIMnNOYWRk?=
 =?utf-8?B?SjdvVWo4dFhwZ21TcER5MHJGeDRBNWhodEhod25CNFBXdXBtaVRWRlNBSGtp?=
 =?utf-8?B?SDA1andURXFnMVlNelozc3ZlQldPRTIwb3ExZWhjRTBMZW1BbC80SkN3aVls?=
 =?utf-8?B?RGpSa0pkbnphM0xmeHFBK2NrN0FvMGl4bG1JSlB1OWs0UndPWDhiWVJVWmdx?=
 =?utf-8?B?MWppZHdaM2hnaHFkMlEwekxWSERZMHlnNTBCZHAyMGs2SExVMW1UVW5tU3Vr?=
 =?utf-8?B?d3hybjFjQjhWbDQ5UmZBOHFFbTBKM2lITmhZNndQdlhERUNPWStGYzg3R3Ji?=
 =?utf-8?B?d0ZDTXJrdjR6R2xDbWxIQXFzb0lpZnZodWU4aWtBSGNtVDA4eUE1bkxSRmhx?=
 =?utf-8?B?LytMUktwbWpQeFJsMkpiVXRwelgvMUM1UmExZ1lzL1E2SkVwellDK3Z0dVkv?=
 =?utf-8?B?TVFuUitvaFdLNkJtbEhuUStqVCtIRjdEYWpGM1lRRUd4a3ZjZ3RxWUswV0Ix?=
 =?utf-8?B?c01oRjNNT2RZSk5LWkVwbWx4d0JRcnlxYmFyMUl0c2FqMGtmRHh6QTlYUHpv?=
 =?utf-8?B?N3MzK2gxWkNWOEhFVUI3UU15bFRRN2JIdy8xcW5IeWlRNUJIN0JQMWxoVWpI?=
 =?utf-8?B?SmNBcWxKR3RQRmF2cm53SDYyMnNFWGkvV09iZEc5a0NnTHQydUFoYlRYQjZy?=
 =?utf-8?B?emtVcVlkU1ErR1RhNm9yRGNueFMzZEhlVGZsOGNVTjdob2d6RXdEUmVOUUtI?=
 =?utf-8?B?eXFQZkw3dWhMcVdSV2RqQjBId3NpcXVBZUdoVU5IZnZ4OVJLdkhaS3prREll?=
 =?utf-8?B?VzFwVld1L1YrWjZtZFdua0dUZk1WWXRFeGJGRit3T3h2Qml2RjlGY1l4OUxB?=
 =?utf-8?B?VFd4UER6L1cveVgwcnUySE5oL0t0THZ0UjBrLy9FQ0hFc2FJV3E1bTlIUm5V?=
 =?utf-8?B?V3lkemJiSFI1U2JBb3Npa3N6M3NHT0dEZWZGZnpJNWc5SWxiQUk1Wmh3VGw1?=
 =?utf-8?B?WkVtZ3RYUEZEbzZoVG13YlpKb2doUzVUTjhOUngxa1Z6b2dlVVdQcVlycjFV?=
 =?utf-8?B?eS92V2VJM0hhRkhTZk9IMU1rWkNiV0dXaldCOFVKRUNpbVFKUy9GdlBoWnZX?=
 =?utf-8?B?ampYR0dac1d6RGdRdXc2M2srNnJVVjA3M3V6S3pzTkI2bzlqT3dVZ0twUXJq?=
 =?utf-8?B?b2RScU51d1FXZFRWWHVLNzBvVHh1NUV2cEJMNlhvMVVXTlNUdjhnZzZrcFR6?=
 =?utf-8?B?RTdtdVlTdjRpOVp4cjk2ZXJVMDFGaGRidW9VM3hzbSs2alUxUlp2S3B6bG82?=
 =?utf-8?B?bitrdm4wNUdDOXdHREJ6ajd3TkdSaXZLOVdUK2ZtWTRLaUhoT1pSNFJmUzhF?=
 =?utf-8?B?UDZEREFTanNlOXRpTXdpNTBnZFJDZHRLYmlaVUpiTzQ3ODNTUVdjUUNucFRM?=
 =?utf-8?B?cmsvZ0xqckQyamhwRm1admtOZUV5VjYydkYzV0hjZTcvbXlxL0kxci9nRmc5?=
 =?utf-8?Q?/riym9Tbux8kqgCVMADVHI65g?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b90e2d-bc09-4e73-23c7-08dcea81e93f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 05:51:26.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCl3J+9EzBsuDJkEUjWZNwfgLOIfQHwYmgbWbwmBXt/wl8pCSIS/9gXA9nfI2INL5TX5WfBczNbjk+lsxeQUSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7166

Hi Liu Yang,

On 12.10.24 06:25, liuyang@sinsegye.com.cn wrote:
> Hi xenomai:
>     I add the f81601 can driver, the path as follow.
> 

Thanks for the patch, but please have a look at
https://source.denx.de/Xenomai/xenomai/-/blob/master/CONTRIBUTING.md. We
are specifically missing the Developer's Certificate of Origin
signature. Futhermore, please enable the new driver also in
.gitlab-ci.yml so that it is regularly built, also with recent kernels.
I also spot some code style issues - try the kernel's
scripts/checkpatch.pl, Xenomai is using the same style.

Thanks,
Jan

> diff --git a/kernel/drivers/can/sja1000/Kconfig b/kernel/drivers/can/sja1000/Kconfig
> index 9fab4a475..043f7aac1 100644
> --- a/kernel/drivers/can/sja1000/Kconfig
> +++ b/kernel/drivers/can/sja1000/Kconfig
> @@ -98,3 +98,14 @@ config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
>         to disable parallel port support in the kernel (CONFIG_PARPORT) for
>         proper operation. The interface type (sp or epp), I/O port and
>         interrupt number should be defined via module parameters.
> +
> +config XENO_DRIVERS_CAN_SJA1000_F81601
> +    depends on XENO_DRIVERS_CAN_SJA1000 && PCI
> +    tristate "Fintek F81601 PCIE to 2 CAN Controller"
> +    help
> +      This driver adds support for Fintek F81601 PCIE to 2 CAN
> +      Controller. It had internal 24MHz clock source, but it can
> +      be changed by manufacturer. Use modinfo to get usage for
> +      parameters. Visit http://www.fintek.com.tw to get more
> +      information.
> +
> diff --git a/kernel/drivers/can/sja1000/Makefile b/kernel/drivers/can/sja1000/Makefile
> index ff6715513..2d344c37b 100644
> --- a/kernel/drivers/can/sja1000/Makefile
> +++ b/kernel/drivers/can/sja1000/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += xeno_can_ems_pci.o
>  obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI) += xeno_can_esd_pci.o
>  obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) += xeno_can_isa.o
>  obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM) += xeno_can_mem.o
> +obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_F81601) += xeno_can_f81601.o
> 
>  xeno_can_sja1000-y := rtcan_sja1000.o
>  xeno_can_sja1000-$(CONFIG_FS_PROCFS) += rtcan_sja1000_proc.o
> @@ -22,3 +23,4 @@ xeno_can_ems_pci-y := rtcan_ems_pci.o
>  xeno_can_esd_pci-y := rtcan_esd_pci.o
>  xeno_can_isa-y := rtcan_isa.o
>  xeno_can_mem-y := rtcan_mem.o
> +xeno_can_f81601-y := rtcan_f81601_pci.o
> diff --git a/kernel/drivers/can/sja1000/rtcan_f81601_pci.c b/kernel/drivers/can/sja1000/rtcan_f81601_pci.c
> new file mode 100644
> index 000000000..c49312917
> --- /dev/null
> +++ b/kernel/drivers/can/sja1000/rtcan_f81601_pci.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Fintek F81601 PCIE to 2 CAN controller driver
> + *
> + * Copyright (C) 2019 Peter Hong <peter_hong@fintek.com.tw>
> + * Copyright (C) 2024 Liu Yang <liuyang@sinsegye.com.cn>
> + * Copyright (C) 2024 Linux Foundation
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +
> +#include <rtdm/driver.h>
> +
> +/* CAN device profile */
> +#include <rtdm/can.h>
> +#include <rtcan_dev.h>
> +#include <rtcan_raw.h>
> +#include <rtcan_internal.h>
> +#include <rtcan_sja1000.h>
> +#include <rtcan_sja1000_regs.h>
> +
> +static char *f81601_pci_board_name = "F81601-PCI";
> +#define RTCAN_DRV_NAME "rt_sja1000_f81601_pci"
> +#define RTCAN_DEV_NAME "rtcan%d"
> +
> +#define F81601_PCI_MAX_CHAN            1
> +
> +#define F81601_DECODE_REG              0x209
> +#define F81601_IO_MODE                 BIT(7)
> +#define F81601_MEM_MODE                        BIT(6)
> +#define F81601_CFG_MODE                        BIT(5)
> +#define F81601_CAN2_INTERNAL_CLK       BIT(3)
> +#define F81601_CAN1_INTERNAL_CLK       BIT(2)
> +#define F81601_CAN2_EN                 BIT(1)
> +#define F81601_CAN1_EN                 BIT(0)
> +
> +#define F81601_TRAP_REG                        0x20a
> +#define F81601_CAN2_HAS_EN             BIT(4)
> +
> +struct f81601_pci_card {
> +       void __iomem *addr;
> +       struct pci_dev *dev;
> +    struct rtcan_device *rtcan_dev[F81601_PCI_MAX_CHAN];
> +};
> +
> +static const struct pci_device_id f81601_pci_tbl[] = {
> +       { PCI_DEVICE(0x1c29, 0x1703) },
> +       { /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(pci, f81601_pci_tbl);
> +
> +static bool internal_clk = true;
> +module_param(internal_clk, bool, 0444);
> +MODULE_PARM_DESC(internal_clk, "Use internal clock, default true (24MHz)");
> +
> +static unsigned int external_clk;
> +module_param(external_clk, uint, 0444);
> +MODULE_PARM_DESC(external_clk, "External clock when internal_clk disabled");
> +
> +static u8 f81601_pci_read_reg(struct rtcan_device *dev, int port)
> +{
> +       return readb((void* __iomem)dev->base_addr + port);
> +}
> +
> +static void f81601_pci_write_reg(struct rtcan_device *dev, int port,
> +                                u8 val)
> +{
> +    writeb(val, (void* __iomem)dev->base_addr + port);
> +       readb((void* __iomem)dev->base_addr);
> +}
> +
> +static void f81601_pci_remove(struct pci_dev *pdev)
> +{
> +       struct f81601_pci_card *card = pci_get_drvdata(pdev);
> +       struct rtcan_device *dev;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(card->rtcan_dev); i++) {
> +               dev = card->rtcan_dev[i];
> +               if (!dev)
> +                       continue;
> +
> +               dev_info(&pdev->dev, "%s: Removing %s\n", __func__, dev->name);
> +
> +        rtcan_sja1000_unregister(dev);
> +               if (card->addr)
> +                       pci_iounmap(pdev, card->addr);
> +               rtcan_dev_free(dev);
> +       }
> +
> +    kfree(card);
> +}
> +
> +/* Probe F81601 based device for the SJA1000 chips and register each
> + * available CAN channel to SJA1000 Socket-CAN subsystem.
> + */
> +static int f81601_pci_probe(struct pci_dev *pdev,
> +                           const struct pci_device_id *ent)
> +{
> +       struct rtcan_sja1000 *chip;
> +       struct f81601_pci_card *card;
> +    struct rtcan_device *dev;
> +
> +       int err, i, count;
> +       u8 tmp;
> +
> +    if (!rtdm_available())
> +               return -ENODEV;
> +
> +       /* Enabling PCI device */
> +       if (pci_enable_device(pdev) < 0) {
> +               dev_err(&pdev->dev, "Enabling PCI device failed\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Allocating card structures to hold addresses, ... */
> +       card = kzalloc(sizeof(*card), GFP_KERNEL);
> +       if (card == NULL) {
> +               pci_disable_device(pdev);
> +               return -ENOMEM;
> +       }
> +
> +       card->dev = pdev;
> +
> +       pci_set_drvdata(pdev, card);
> +
> +       tmp = F81601_IO_MODE | F81601_MEM_MODE | F81601_CFG_MODE |
> +               F81601_CAN2_EN | F81601_CAN1_EN;
> +
> +       if (internal_clk) {
> +               tmp |= F81601_CAN2_INTERNAL_CLK | F81601_CAN1_INTERNAL_CLK;
> +
> +               dev_info(&pdev->dev,
> +                        "F81601 running with internal clock: 24Mhz\n");
> +       } else {
> +               dev_info(&pdev->dev,
> +                        "F81601 running with external clock: %dMhz\n",
> +                        external_clk / 1000000);
> +       }
> +
> +       pci_write_config_byte(pdev, F81601_DECODE_REG, tmp);
> +
> +       card->addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +
> +       if (!card->addr) {
> +               err = -ENOMEM;
> +               dev_err(&pdev->dev, "%s: Failed to remap BAR\n", __func__);
> +               goto failure_cleanup;
> +       }
> +
> +       /* read CAN2_HW_EN strap pin to detect how many CANBUS do we have */
> +       count = ARRAY_SIZE(card->rtcan_dev);
> +       pci_read_config_byte(pdev, F81601_TRAP_REG, &tmp);
> +       if (!(tmp & F81601_CAN2_HAS_EN))
> +               count = 1;
> +
> +       for (i = 0; i < count; i++) {
> +        dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000), 0);
> +               if (!dev) {
> +                       err = -ENOMEM;
> +                       goto failure_cleanup;
> +               }
> +
> +        /* set rtcan_device struct */
> +        dev->base_addr  = (unsigned long)card->addr + 0x80 * i;
> +        dev->board_name = f81601_pci_board_name;
> +        strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
> +
> +        if (internal_clk)
> +        {
> +            dev->can_sys_clock = 24000000 / 2;
> +        }
> +               else
> +        {
> +            dev->can_sys_clock = external_clk / 2;
> +        }
> +
> +        /* get rtcan_sja1000 struct */
> +        card->rtcan_dev[i] = dev;
> +        chip = card->rtcan_dev[i]->priv;
> +
> +        /* set rtcan_sja1000 struct */
> +        chip->irq_flags = RTDM_IRQTYPE_SHARED;
> +        chip->irq_num   = pdev->irq;
> +        chip->read_reg  = f81601_pci_read_reg;
> +        chip->write_reg = f81601_pci_write_reg;
> +        chip->ocr = SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL | SJA_OCR_MODE_NORMAL;
> +        /* Clock divider register */
> +        chip->cdr = SJA_CDR_CBP;
> +
> +               /* Register SJA1000 device */
> +               err = rtcan_sja1000_register(dev);
> +               if (err) {
> +                       dev_err(&pdev->dev,
> +                               "%s: Registering device failed: %x\n", __func__,
> +                               err);
> +                       goto failure_cleanup;
> +               }
> +
> +        dev_info(&pdev->dev, "Channel #%d at 0x%p, irq %d "
> +                                "registered as %s\n", i + 1,
> +                                (void* __iomem)dev->base_addr, chip->irq_num,
> +                                dev->name);
> +       }
> +
> +    /* force into reset mode */
> +    chip->write_reg(dev, SJA_MOD, SJA_MOD_RM);
> +
> +       return 0;
> +
> + failure_cleanup:
> +       dev_err(&pdev->dev, "%s: failed: %d. Cleaning Up.\n", __func__, err);
> +       f81601_pci_remove(pdev);
> +
> +       return err;
> +}
> +
> +static struct pci_driver f81601_pci_driver = {
> +       .name = RTCAN_DRV_NAME,
> +       .id_table = f81601_pci_tbl,
> +       .probe = f81601_pci_probe,
> +       .remove = f81601_pci_remove,
> +};
> +
> +MODULE_DESCRIPTION("Fintek F81601 PCIE to 2 CANBUS adaptor driver");
> +MODULE_AUTHOR("Liu Yang <liuyang@sinsegye.com.cn>");
> +MODULE_LICENSE("GPL v2");
> +
> +module_pci_driver(f81601_pci_driver);
> 
> 
> 
> 
> 
> --------------
> 
> 
> 
> liuyang@sinsegye.com.cn
> 
> 


-- 
Siemens AG, Technology
Linux Expert Center
