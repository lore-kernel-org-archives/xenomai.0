Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E641DF271
	for <xenomai@lists.linux.dev>; Mon,  1 Sep 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734723; cv=fail; b=FV5iarellja94sxDJl4HtM6V7dS8p1XP59ibiAKYQkRkQ5le/S8a3X9Ker346Tr63TZ1Mg1OX9Bt7GrYam2aEBPPKLd/wBgJdS0a4aKUZUQ3T2ld2rON6gBkAHOLVAbRudCnaZubLLLl8QdWn4qiMw9JV1+0GvCd5O6Fgumt710=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734723; c=relaxed/simple;
	bh=VxFpYdvVU2cIiSc1o6Ywu9G/9fy0s+6TKIP0nJHEhQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e0XmQaoXbv5GUJiL3Yw6bTwberz+7SUWVnSVrSFVEQgRPiuF2vOmZn92YMyKEQR27IZ0EHl6V/WMp+p/7QA9FfuP3vDFfpFsGKFLcakWabPoaYN42vOLp+ZFkTMyYiulXM5JvnHi8zTROUlooUOqtzHjIQiJTrlRt6nbaG/L5/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KWtDnm0g; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KWtDnm0g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJJ5qwB/StuC8ijP84drFjXPSJjhxks3IZtHW57s+3aY/Ag/Sg/9qGBhkrq52QskgCmoFLtD5pm+Wjpzi4e2+7ZMYxxTZ40bBuhKgdp6bfwnyyQSFFjAvcMKfgn9DLzz742hkTkPLPhFw1oENhAoWM8sG2iFMwxXvQrP90hMP6TpigYM5uN4pzQaBs/+KwiSNabTQpne0BkzDAAQC2+IzO0HIuc2ZAA0naccGh8nwjdlK8tZ5g8Z4uh3S2Q5HSuBJ02eL4WygD2koHBqTUuG9z3eVJPmz+chTENdQP6y0tFscrRTBpS5JgK5erS6OWZtPH+obEOcgJZGxGtyF3nnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TRw+hO8DDyG+ogYwGmNbVWy5PP4xqa2zFuzXElHGvw=;
 b=BbKdH19MUk0gDJ5VVgfocur/3b9HWIu6UucQMUqtPBxRJKgu9w8fycymy/+15e4P0x7Iewfujf1H2KOBONBEvNkSX66jqF6PW05NgiAp61S3xcRS8IiBxYTlfaNq/O6/1mrln0Y1RWV+3w6H5lrbfyk2hl7H3J5m7Ee/pzhGfPynTqIehjKEkB2513RamDkrS+1J1b9mcCvH+T5YiRQvGyUcV2LvevosZZEfj2D90wsI3KNJoO+xeGyfSK/G/GYxqFyHAUboVHy7pSC3GwyTKinrs/UgmkGn7z2zGSqDvE6FIP5ET56VW0NKIutokba7Ofr54W4c8uPlXuyTG1jt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TRw+hO8DDyG+ogYwGmNbVWy5PP4xqa2zFuzXElHGvw=;
 b=KWtDnm0gcARS242SKniOnE5z38L8VFN/5fDZ7UaT9EfR9BQQmCvuH/iDv5/KquLoL6WPZH6xuNYz2oTYWYPo3ZJvQzbACGw0HzrmD5aJObOYRdFjNTIesqBGK+9VpOCInJAtHWb1ML3hKpylQHnfNPA/LKmVK3X6LzS3rxk1IttNA4VtDWL3J13mXXnN+7E06FDHaNA02ikm4Fk0QX4rl4u8AyA/wMUtvE3ko4vmvWKbVNKAUYYWVXIla9Vf2z0JmK3WGKhp7eftS7otKFVOMJjZIKhpMgCqj3KbojMty/ZuwNuu4zd3bMLQkMd8PD98Xjb7BHdVjeb9PpY9Xw4RKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 13:51:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 13:51:54 +0000
Message-ID: <bc5c15c2-3423-4d6e-b296-63797ef7ff31@siemens.com>
Date: Mon, 1 Sep 2025 15:51:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/pipe: Fix invalid wait context in
 xnpipe_wakeup_proc()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dfec5b-1033-4f57-e419-08dde95eb5dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXE3V1pZUUEzVzFYalRyZEhHejZuTXpTR3Jjd3hDTDJ2a1BrUGd5UTd1VUZY?=
 =?utf-8?B?Nk8vRzlWRFBML2N6dmRTbWZzOHdnQnZpNnVKR1poY1dyd25nclNkaVNyYWU2?=
 =?utf-8?B?Z1BKNVExMlljajdHYjBhaVc5RVZZSjB2SzJVa0tIVHVpVVZIZklzWVNXaE1h?=
 =?utf-8?B?K0tkR1NucjJHT0N4MklNUDdub0ZuUlBOQVV0QUdqN2ZpOWQ2Zm9LT2p2anBw?=
 =?utf-8?B?SmlCWGRBZVdLSlpmNDBxRHJtQ2xhb3ZzUWlmZVQ5aGY2Y3h0WU9BYnRibjM0?=
 =?utf-8?B?SEtyRlRaUllXS0RRQ0trbUVtUWxzSmNKajVMKzNzMXB1NjkwTU00SzZsdHZB?=
 =?utf-8?B?Z1VDMUc2N1Vyb1EvaEUwMWtqbTZ3dEFxMzR6N0Q4WC8rSG5HYlhETVlyVnB6?=
 =?utf-8?B?ZHZ4WlNPZUtoOENNMENUbTdxOXVyQVRsQ0VVUjlYNS9OaUg3QjRpOG8zcW4r?=
 =?utf-8?B?cVppY3Q0cTNvZmZoNGlxbW9lTTU1Wk5IK2JmejVxSkNuZmFGMHJqNTJKT1hP?=
 =?utf-8?B?NVg0S2t0b25yb0VwMnQrczRTSTY0bkM2dXhYamJxenVZdC9oOVlFSWRSRkhK?=
 =?utf-8?B?K3ZxOXJOTXVUQUpQUEFzTUg1aFcxZ3NnVFlxMTAyMjlqU1lDNmRGT096cmN5?=
 =?utf-8?B?MkZvK24vMXIxQXQ5S3Npa0JHQm92SlRiYk05UzdlaGM5ZzFpN0JESFZpdCts?=
 =?utf-8?B?TXFQUllNQ1ovSzY5YStkdVVFL2I5RGFkckhUajF6M1F5b3NTUU9aTFRadWZ3?=
 =?utf-8?B?K20yalAzTHRwd1dmUWh3emVqTjJnVHFrZ2RFZjZBaVR5emFmcmZtODRDdGI5?=
 =?utf-8?B?K3paZlovZVRheUR5ZVlVSHl4RFlvemZ5cGhGb2xwbXFHUlQ3bS9pcERkd1FJ?=
 =?utf-8?B?QXVMMWRydXdiWVZMSEVORnoraURhZ2VEOWxVclRyTmlnR1Z3V005SXFJQS82?=
 =?utf-8?B?QmxsdU5yb3V1bUJ4WkFhQmlpNVdCdlREcnZ1UGdNbG5kRU5scXBmVDRFZnN0?=
 =?utf-8?B?NHVLSXhHSm84OFc2K210Q0tXQStNWFVnRmMvV2VoU3dteHNNbkc1YXkwWnpu?=
 =?utf-8?B?RUZkbzRjbmNwbDVmTUhPU2hRbEtRam1NOGI5by9IOFhGcFpXckdFZ0k2Vk9m?=
 =?utf-8?B?VVAxU1hOK3VSMXFNbnVxTGVEN3VyV2xxWVd6TzFZano1TWJ5TVJOQzUzZkNz?=
 =?utf-8?B?OGlqb2N0UktKclQ0UjVwM1o3VkdZaG13eWJsUUpnTGRweHc1c2paeHpidWpr?=
 =?utf-8?B?dlMvTVZ2ZHQ4Q3FTLzZ5NU5icWp0K1lYeG1lcjMzMHFPc1BVd3N2dUV6Y200?=
 =?utf-8?B?S2dUZldoaWFKSWxGQ3VscDJvTGVqeWlFZ3dTZnZ3dDNZUldvTlJoN09jai9o?=
 =?utf-8?B?T2gzMzRSQnhLUk02RWw5Sjk5YlJVaG5MTWhuUFJMNldOMFBkNlIrdHljMEli?=
 =?utf-8?B?UHNYVkRranVOUkRuemhGMms0Sk9aVnZORXplM0dYTjN1QjZTQjlFVG1zTy83?=
 =?utf-8?B?cDkzNlVRWTdVOUE0QWpRVTdndEYwVHd5S2oxbkNENnRSVy9uVHZxZWdKS0FQ?=
 =?utf-8?B?eHRHdDVWMDZOZTFjY095NzgySmkyRXNnaUdLdDdtcTFRYkpUNjZic09GbVZE?=
 =?utf-8?B?TVpOS1JYMmFaWXFKYXZrVmxYTHNuaFBzTTU2aXcxL1JYb1lQdHRTUllXYWNI?=
 =?utf-8?B?a2VIcjVvSW5JbWtycEpEK1B6Q1JzQy9PRFdPK2o1RVNSYTF0bXBkNnpZTndu?=
 =?utf-8?B?MHFYeEd4WHE0UlgzWVgvWEhjbmwrV0hqTHVRdlNvSmx5SHJmdHVCYWE1Nnlr?=
 =?utf-8?Q?ZPVfwEyFy6l5HxTT39yQc3ktHuIhDt4Ek1bjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU9oNlhNSSt4QnUrUk8xN1gzVDZpVGI5QU0rZXQ4cjdWSUYzY25KNm5yamVn?=
 =?utf-8?B?SFFxMmNxY1pRK1cvZStCRllFZmtKU0owWFM0ODMzTWg4OU1KVnJ4dzZYOE8y?=
 =?utf-8?B?bGEreW1BeXZ3aVZqVWI1RDV3aFcrdTZicXlyWEVwQmNaajJzQ1FVVVQrWWIv?=
 =?utf-8?B?bUdjeDA0TzBlRHZWd243TDhXOVR4OVhMSzdrR09QR1F0Uld1V0FxOTFOSEZy?=
 =?utf-8?B?QVlVejZkRHU5ZWN1UWZmdUdIcDA3cjRObXhpY2t0aHJ5UDBMclM4TTNEcWJq?=
 =?utf-8?B?RnJibDhQekpFN3VlbnI2c0Y1OVNxN1RMWXZqV0RhdXR3UUh2YVhkOWFwOEMw?=
 =?utf-8?B?YU42d0NOU0ZDTnU3emlsYzM4OG9zSGM2TzZ1dTRJeXpocDhtOHFSK3U3cUow?=
 =?utf-8?B?dVNZRlNWV280M2VCN3AyNDRuWVZnTmhPVFhOVzFXeWtTbkdYVnZydHZPeG8x?=
 =?utf-8?B?NnhtVnBaVkoreXNtS3ZaV3R3eTJvYkNvSEZ3V0loM28ydVM1a1FLemJuNVM1?=
 =?utf-8?B?enlJcXNvdlpGdVN2cVJZWVBuSGRsR1p0ZTF6Q3NiRWwvdlhXWDd0TlBIOTJq?=
 =?utf-8?B?eHdvN25pc3J5UGdwd0xFZEFzMnpRaVRERnhwOHVkdFpDSlErNjhuSzdlSktX?=
 =?utf-8?B?RkJxUjNqck5PVE5MdVNLb0FKQ3RPdlpMTlhGbFhRV3NXWVFCU2xwMmJ4cThM?=
 =?utf-8?B?b0tFUnZBaERmME03T2hGS3ZGd1h1ZnQ1WTE5c0c3OWxWR1g3L1ZMaERhQUNu?=
 =?utf-8?B?TGVoZ05OOE02NG1lUUV0WWNEbEJVS1RUWnVPKzV2UU1wSUYzWGpSVmJMeFBX?=
 =?utf-8?B?UXRWWTdZM0pQa3ZpbUhWQXJLN2x3LzVyQWI3QjdjT1VRbjkyTnZLNmZmM1JW?=
 =?utf-8?B?V29kM2ZHWjhqc0ZUSXlSYkhUNGJqZW9KRDlKQ0ExbStaK0hkODdZdzl6elBz?=
 =?utf-8?B?U1prVFhWNy9hZU9OdmV4QVBGUVRJNnh5RnlIeUpTS2QvN0xCSXdYSEpaaG9h?=
 =?utf-8?B?UUtUUnpGUWR5dTJ6Q2U0Z2YwcUFmanYwQ3BWMlZsRWtqd2tYTlcvTjF1b2pw?=
 =?utf-8?B?ZHBVVzdKU2JhOHJMdU9kS0tYbjFzSVAzQVZwUnViTXVTemxRRnZUVzBxemNU?=
 =?utf-8?B?UDI4MlFBbXhtdyt5VlVrYjg0dWlRTWl4MHJuT3htZjVkbEkzUGhQQmVFMDdN?=
 =?utf-8?B?RGV0N0NQR1JNeTNhZXNwTFd0ZXNEVGtJNG1Qb0t6RDFZZFZTVmoxa0NTdEVk?=
 =?utf-8?B?a041L0h6UHh0azFVMm0wcFQzNWNzZU5OUVN1WmxORlppYnoyclUxSjVaK0xU?=
 =?utf-8?B?U0F1RUFBR2U5NXRZekVMR1E1WWJkd3dEYkpDZkNpWjBaT21HSnFvcHhlMHNt?=
 =?utf-8?B?S2R6MDJZaFF5cUdQajlRVnNRdjZIakNBbEdqYlF1dVNiQWRQbk50T05DYzdP?=
 =?utf-8?B?aE8xaUZwMzY3dG55QVZMVE5mTFR1c1NvMjVLSzlJUENqd2JWTWVsL1B2Qnln?=
 =?utf-8?B?YzAxT2VyUDhSM1dGRURueVJhdW5YY09aRmFDTzRCaUpvNkxYelhWblNVaW96?=
 =?utf-8?B?TGF3Zzg5TG1EL0pVeENyUnlUSUtHaXRHdUYwNVNidDRaSmlRY29VQWhjVFdw?=
 =?utf-8?B?YUVMd1licGg4ZUNrM0o5MUNFOUw3RlBnVWsrM0ppZWdhWktMZXN3L015MGRv?=
 =?utf-8?B?aFh3TnNZeGtFQUdyeExpVUtzSHV2ZG1mdFVUMXZJdkl1MU5WdVFOM0FDOWpF?=
 =?utf-8?B?WldxK214ZGtMRGNUcWlFQXJ5TDZWdUJqd2ZlY3ltWVVrcDU2U3M4aXlXekoy?=
 =?utf-8?B?bUZFT01vVGhyUHY3S1owa1BxeEhZdmNkV0I4TkZRSGpGRHREeGJhVU1oUGIz?=
 =?utf-8?B?Z3FnY0MxUWM5ZWdHNGRRYzU4UWZMZjhYU0hRMkVPTW9BV3MxU2o3bG5HL1Qz?=
 =?utf-8?B?WnR3Mm52OXg1YS9MdjR6Nzh4aTg1UXlWNVNRRXI1NTI4cElTdGlnTjd1RUph?=
 =?utf-8?B?dlY5LzJPbW1EQ3JrUVB1WStWUGxxZnhTeHBtR284dXViRi95QVpORkNJek5K?=
 =?utf-8?B?MzBJaFR6MSs0Tkw4RlVSVFluWStMaElFMEVsVFh3M1UyTHFZdUt0MlVIYmNG?=
 =?utf-8?B?cHM5eG9DVGpydkhTTUozS1hUTXpVbkZJVDA2TVFCR1llSWxSd09lWUNZc21O?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dfec5b-1033-4f57-e419-08dde95eb5dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:51:54.9277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qly0K4P3bgmg8zjn3yO6z59S0a/96hyMIKxYH38AyfWPQmLMEsK0Efvo5Ob41FJDs+B2+KuAXhy9QvZCcYOWeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8158

On 29.08.25 17:59, Florian Bezdeka wrote:
> Recent Dovetail versions complained about an invalid wait context in
> xnpipe_wakeup_proc(). It turned out that this warning is correct as this
> function is called from the inband IRQ context (while syncing the IRQ
> log) with hard IRQs enabled and inband stage stalled.
> 
> The call graph looks like that:
> xnpipe_wakeup_proc()
>     wake_up_interruptible()
>         __wake_up_common_lock()
> 	    spin_lock_irqsave() <-- might sleep on PREEMPT_RT
> 

So, the warning is issued independent of PREEMPT_RT being enabled but
the bug would be limited to that configuration, right?

Since when is the kernel complaining? It is wrong since PREEMPT_RT is
available, officially 6.12 then. Then this should go into 3.3-stable as
well - noted.

> As confirmed by Philippe in the discussion linked below, we have to
> migrate the wakeup code from using a synthetic IRQ to irq_work to address
> that issue.
> 

Hmm, can't we use something that is a thread when needed and an IRQ
otherwise?

> The log splat report:
> [  151.574032]
> [  151.574039] =============================
> [  151.574043] [ BUG: Invalid wait context ]
> [  151.574046] 6.15.0 #1 Not tainted
> [  151.574048] -----------------------------
> [  151.574048] swapper/0/0 is trying to lock:
> [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+0x21/0x60
> [  151.574063] other info that might help us debug this:
> [  151.574064] context-{2:2}
> [  151.574065] no locks held by swapper/0/0.
> [  151.574066] stack backtrace:
> [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 PREEMPT(full)
> [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> [  151.574079] IRQ stage: Linux
> [  151.574083] Call Trace:
> [  151.574086]  <IRQ>
> [  151.574088]  dump_stack_lvl+0x79/0xe0
> [  151.574095]  __lock_acquire+0x942/0xbf0
> [  151.574104]  lock_acquire+0xe2/0x2f0
> [  151.574107]  ? __wake_up+0x21/0x60
> [  151.574111]  ? find_held_lock+0x2b/0x80
> [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
> [  151.574120]  ? __wake_up+0x21/0x60
> [  151.574122]  __wake_up+0x21/0x60
> [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
> [  151.574132]  handle_synthetic_irq+0xc2/0x250
> [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
> [  151.574141]  </IRQ>
> [  151.574142]  <TASK>
> [  151.574144]  sync_current_irq_stage+0xaa/0x110
> [  151.574147]  inband_irq_enable+0x42/0x60
> [  151.574151]  cpuidle_idle_call+0x17d/0x200
> [  151.574155]  do_idle+0x89/0xd0
> [  151.574158]  cpu_startup_entry+0x29/0x30
> [  151.574160]  rest_init+0xf0/0x190
> [  151.574164]  start_kernel+0x632/0x700
> [  151.574179]  x86_64_start_reservations+0x18/0x30
> [  151.574185]  x86_64_start_kernel+0x78/0x80
> [  151.574188]  common_startup_64+0x13e/0x148
> [  151.574198]  </TASK>
> 
> Link: https://lore.kernel.org/xenomai/87349may4v.fsf@xenomai.org/T/#t
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Philippe Gerum <rpm@xenomai.org>
> ---
>  kernel/cobalt/pipe.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
> index 7519f3165..5ab561384 100644
> --- a/kernel/cobalt/pipe.c
> +++ b/kernel/cobalt/pipe.c
> @@ -48,7 +48,7 @@ static LIST_HEAD(xnpipe_sleepq);
>  
>  static LIST_HEAD(xnpipe_asyncq);
>  
> -static int xnpipe_wakeup_virq;
> +static struct irq_work xnpipe_wakeup_work;
>  
>  static struct class *xnpipe_class;
>  
> @@ -147,7 +147,7 @@ static inline void xnpipe_dequeue_all(struct xnpipe_state *state, int mask)
>  	__sigpending;							\
>  })
>  
> -static irqreturn_t xnpipe_wakeup_proc(int sirq, void *dev_id)
> +static void xnpipe_wakeup_proc(struct irq_work *work)
>  {
>  	struct xnpipe_state *state;
>  	unsigned long rbits;
> @@ -221,13 +221,11 @@ check_async:
>  	}
>  out:
>  	xnlock_put_irqrestore(&nklock, s);
> -
> -	return IRQ_HANDLED;
>  }
>  
>  static inline void xnpipe_schedule_request(void) /* hw IRQs off */
>  {
> -	pipeline_post_sirq(xnpipe_wakeup_virq);
> +	irq_work_queue(&xnpipe_wakeup_work);
>  }
>  
>  static inline ssize_t xnpipe_flush_bufq(void (*fn)(void *buf, void *xstate),
> @@ -1149,6 +1147,8 @@ int xnpipe_mount(void)
>  		state->nroutq = 0;
>  	}
>  
> +	init_irq_work(&xnpipe_wakeup_work, xnpipe_wakeup_proc);
> +
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
>  	xnpipe_class = class_create("rtpipe");
>  #else
> @@ -1180,13 +1180,6 @@ int xnpipe_mount(void)
>  		return -EBUSY;
>  	}
>  
> -	xnpipe_wakeup_virq = pipeline_create_inband_sirq(xnpipe_wakeup_proc);
> -	if (xnpipe_wakeup_virq < 0) {
> -		printk(XENO_ERR
> -		       "unable to reserve synthetic IRQ for message pipes\n");
> -		return xnpipe_wakeup_virq;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -1194,8 +1187,6 @@ void xnpipe_umount(void)
>  {
>  	int i;
>  
> -	pipeline_delete_inband_sirq(xnpipe_wakeup_virq);
> -
>  	unregister_chrdev(XNPIPE_DEV_MAJOR, "rtpipe");
>  
>  	for (i = 0; i < XNPIPE_NDEVS; i++)
> 
I was briefly checking if we have more inband sirq issues, but the other
two users, registry and xnselect, lock different and unaffected.

But I'm still wondering if we need both irq_work and inband_sirq. And
how to shorten the number of steps to the actually required minimum. No
real conclusion yet, but thoughts on how to either obsolete one in favor
of the other or how to avoid that we take another thread wakeup when not
needed are welcome.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
