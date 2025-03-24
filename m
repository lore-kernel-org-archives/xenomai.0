Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6F2AE72
	for <xenomai@lists.linux.dev>; Mon, 24 Mar 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833395; cv=fail; b=oOKMQ2TPxRH+UIjrL9XZGvpJdEGxuPFFQj9rE0criBG6MAnLjhPbu/4xHbs+zMSFjxfVPIwTlJU1+T2WieoGa3yNJvNSUAzVZlfRYSWgqQzrcjo8o1Klj6ryQIm2Ay19lDOSIcB8/9HaXnFXVdL/N2sWC7YBNh5Rq5O+h/HktdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833395; c=relaxed/simple;
	bh=kAtBEd9hrD/0y/e6Ze6GElWCr2CqYSlk+skWkxEm3zE=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=DSmYr1ubAGJjBPMhiUJhZTwW99r6fMSgcohBSSyzZGlC41NAMuKLAGTsrAWTKv+/geeRQuDNUe3QXM3DdV68liqA9nQGYmGhpYqwxk8TuxTR9tFh5HsZUxRwl8agGAqdBsISEEjA5W+dv0V5hMDhui1ucNA/w/eNmpSrJp9qywo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KTt3Pqlk; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KTt3Pqlk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCvh7aImPdI7OEisLuIDe/qnb1nYNYVlhoxZ+so64p63lXg1nMJzgN7VpLU9pk7FPfyFhZZggfFha+VhqCOKQSNBsXE04/+sG91IJix3jtYpF0ZSew0cwV/Mm0SiWoSwX9qXjiZxeIDnGH4YuTLoUGytjSy5YFiKw9trC2rNrKxYQHG2HRa2Ifzpk1SWW1wd881dNBL3ox/sA3HwVy6qMHYRrZmRFygaL1WUoAOAeyAEbIQy+9o0R2o8pa1hlCdkGhKXpVFZbhMmSzRr37wH216tDCPXY96y54Z3TBbWVu7rwaApXFmiZFFGvs9CgB6stx3jJS+Y2/CS/KYCY6PXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipwt31pPE0LBhl8Vv6ccYl0vSLW/7nyLQeAxyWAvsPU=;
 b=o6w7Ql873ugAods2Oq29Lcbu9EtRE9FG/9MbMTGB8yzy7rut6vhuOjol3zdPOtn9sK4wgeEipWLIAiIdXygHJ9Yd+CaShWafo4VzosHZPdMaPDs1DFuvrxWms+hNBex2GtbLJBZSfutgTUB100Hefxu4okD021nfDuv+GBBMyrav/HKHhprtF5Fvh/wJi88GPBP1lePZMFVUzUvf/7hL3Mbsj2anDbBNTx7nzEzsmQTp2S+BY6UFqK14V1/lokM3pCaVEyJDGW4BMDkWrePiFdvyqd0L5CYZLCAsNiRYNVfjZxs/gl8W9Dvb+TvXE/G08iM8JMKFyYbXKlLVg7crzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipwt31pPE0LBhl8Vv6ccYl0vSLW/7nyLQeAxyWAvsPU=;
 b=KTt3PqlkgIB3axRTs0ppna11qy0DTxn5rtvRDe9kzc5LJEHsj1gNIvGR60n/9UE/ixC/yEUo/oe3wD0V9SD172yd4jX+S1oUlPTKCu6c36NN7+AjzJvhKqC88UGar8QBblqUgDmCtZeh20eeefMBrBxQJIyDKxEQRhrBlsQl+sOfVF0izrox4Sy5HluGmawqUAyXBzLuujZS11949ruUe3fegFu7cTVYz3KmkuBVnOtTI3RXKqH7mDoe+apdQC0gNSMGFMiayvImgvDx1eWO8MusaHgQRH9L2SF86B+z+/GJfcsK6ou9a8bir6051BPOW5JjkPmqiaUNBuewCZPjQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6194.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:23:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:23:10 +0000
Message-ID: <8c88172e-b7e9-4835-88a4-39e91b9cefea@siemens.com>
Date: Mon, 24 Mar 2025 17:23:08 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v2] kernel/cobalt/posix: Stop supporting timeout parameter in
 recvmmsg
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef0742d-46b8-4af2-8a5b-08dd6af02ab4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1ZZTzBvcVFIMHMwak9JNnZWZ3Z4bUhyYkpoVVJZV29vcURBNDFGSEtXOThl?=
 =?utf-8?B?VVF2OW1ZWDNJaUdjMXQvMnVLdVZCSnJKZVFDQUw3NGlWdVEzM3Z5NHBubUwz?=
 =?utf-8?B?KzZ4MUNZYzRqa2x2MXNleEEvbjRUQXZwb0NJNzgvdlVpdDdMd2VIVnFkL2lD?=
 =?utf-8?B?T2hGSWl6NHJhMGhLRDVzYktLWThqb0w0cXRYU1N5aWVTMDRVUk85ZGRBM2w5?=
 =?utf-8?B?cmJsVmFZN1ErdW14MGFUVytyUXN6eDFuN0wrNmVYSVVsNTJwSGlkWkdMdkFI?=
 =?utf-8?B?QnVRVjFMRTVubWVEZVlEdlVPdWs5dFVXTjdPeFFlOWpsRnpsc0pWbFNNVW95?=
 =?utf-8?B?TzhHa0Rva0l6bWlBU3prRlRvdVRZWElCQ0JrUXBYRFEveHRJSFNTbDhZL1dR?=
 =?utf-8?B?OFV5aUswaUtCYzdjV2E3elQweHJLdWdURmFrV284QnFjV0s4aVVwU0RETlJ3?=
 =?utf-8?B?WHRCY1ZqNFJ3RmdUV0R3WXQxVkUycE5LTGhaS28vWkMwWWRrb3BzL2VoSmJM?=
 =?utf-8?B?NzI5VWVvbGNMbXhlVWNXYWZQbjJtWTdCMEhzZ051TkphQWVPcGJXQUNyZUZr?=
 =?utf-8?B?WFhndk4yWkJrcVRQSlE2NFM5TGRCL3dBVEkxRkY4ciswbXQyekZrSkptUThM?=
 =?utf-8?B?YXBFbW1scFRnenZnRHNDQlhoMVBRZm5xdFNkNEp1amQ0bS9KdDFIc1F0WVNQ?=
 =?utf-8?B?M1dRaVZ1T2RXNU00QUZDMW5RVGtJcnBrVUN2T0p5V2hqOXB3T2NXUkk2OUcz?=
 =?utf-8?B?a1JRdG5nbXRCNjlBRUxjbVdaTTZ3bkJWVS9tNDd4N3FBcENqQ2M0U09JRURN?=
 =?utf-8?B?VWFCNzdCNnpTRDQ1b2htVVFLelBrUXpSQXdubU1oVEp3RHdKQ1lFN1p4Ylhw?=
 =?utf-8?B?SmJEQmtwMVdTVlM3dHBDQ0pORFExaVBOeGNSMllXcWtvY1NUVmxHUHc0QjNJ?=
 =?utf-8?B?WnBJdTVCSi9CZUtCSjE0T0tURGVUOTF2UTlqREE0djUwbStWMSt1cE1QZG0z?=
 =?utf-8?B?c0QvUXJvSFN2T2psaXNBL2FOcTNVYTdOc2JZYmkyaVdpcGFXeDBRUWZRZzRa?=
 =?utf-8?B?c3RRNUpFTXNvTXdkRUYxNUI0K293ekczRVdLb1RZV1NJUGw3MUNFeFpSU1RB?=
 =?utf-8?B?N2hEdXdvVXNaUVBJY3NBRkVkTG90aUxlOXVTbWZBK0cwSWVvMXd0VitPY1Bn?=
 =?utf-8?B?ckM4MmdBTTI2SFE2Z1hiWHg4WU9GdXR3b0hTR0JSTTY4Ky9FczZ0eDhaYU9U?=
 =?utf-8?B?UVJEcFhaMTEvZ1lDWXQ0SkdpbW9tVEdmOWxEeHdwVWx6VHA1ZXNPNTVUQ3B0?=
 =?utf-8?B?TU1sZU05K2xLTjUwZ0NpUDJ2T0ZMdkFuOXZRV0tBYnNmc1NGZ09wMzN2cG1o?=
 =?utf-8?B?UEVyeUloRFRSRVRIY2JVbnJOckl0K1QvQmJTb0FXNDFrMGJBdG1saC9wTUxM?=
 =?utf-8?B?eHloSE1rREY0WmpkQkw1MEwzYjQ3bkV6anVab0o4NE9TbEsvSW1jN1pwQXl5?=
 =?utf-8?B?c0E0WE85Ky9TamNHZkVreUtwczhSbmxMdmF0KytOV2tLZFpQZzRkRnZ1MlFL?=
 =?utf-8?B?NWRtNnNrclQyNGZYNWlKZ2wySEhpRkJZZEsyZnlqVmdBM3BYdzBzbXNQMjlv?=
 =?utf-8?B?dUFFc1hlT2ZtR1l5QmYwYk9UcXNzSDEwRGxRNDNBcHVQT3BPU1ArbUVIM20y?=
 =?utf-8?B?aVlLWkJtUld3NHpTVTUvdzIrVEdQQ0dZSlhVcVVodnZxSEREb2V3WHVFQVR0?=
 =?utf-8?B?T1ZzK2FzbmRqYkoyZG1zeENIS0hkWHZsUmZubEZHaWVYaUd0YTA1YVNpR3NF?=
 =?utf-8?B?by8va2FSZjlUMW5oY2ttZjJaZ09kZGF5OFBpK3RlVEVNS0hycHlSZUJnb1pF?=
 =?utf-8?Q?l0G+ahoQjD7zt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHJUOHlOdld6dVFTUUFOWVY4VnN4MWZhQ3RrWGM0NzBET1VHejF4cHVlTFpq?=
 =?utf-8?B?UzU2ZjRVSHZCV29zQWdYc3VZVi9vejdDNzlZOGRzcTVDVGpxUG9WSzBvQ1hr?=
 =?utf-8?B?SW1KYkNuYTBCZHRJRmhrcVozYkZ0cndHOFpObUp6a1VaTHphLzN4eXVlWStH?=
 =?utf-8?B?S3FnNlVsWGorUG5iSlFabkV4NHlBVzlUWHl5SUUzMDhhR2VWeXY0OXNreFM1?=
 =?utf-8?B?SXBBTXg3SE5lV0hmOHgrY2M2dDZUQ1VZSkUzYUVJNFc1di9JeksyUXc2VzFU?=
 =?utf-8?B?NGRYclJrSXNHOURIYkJpWnpwM29MYUNNbWJpc1hldmFaQU0xSEhtTzB0ZXdj?=
 =?utf-8?B?K0h2MTQ1NThWMTdhRmNLRlltRFJ6WEViTWtDMFJxZFdaM2E1b2ROV3ZMTmVa?=
 =?utf-8?B?NkkyOVh1MzJ1WlBRQWxLR0I2Z0piSFBJbWxYUjkwWXRrOHFFL2RucXZJZVNB?=
 =?utf-8?B?c0I5NkF3V3RLVTcrU0lrWkJyMDJUaFd5S1pvVU5wM0VrTXJRRWhzTE9NNVVp?=
 =?utf-8?B?SW9ucklNd0V4cGFxYWU4ekJRaG9mdHVSRGYwL21xZUwveUJnbWI5MnllellB?=
 =?utf-8?B?dHZ4R3hBYzFUU1pkaTlvNlNmTGhqRkUrNWY1SHE1S3lBdE9LN3dNZUFLNGNi?=
 =?utf-8?B?Y1BNelRpNlgrZnQ2ZEFIZ2plaEtwMUM2MHZCUlQrL0NWMTRWR0FCMldkRnE5?=
 =?utf-8?B?YW5wVXlTQndrSDRkeFBoVFR1RElacERzN081ZlpCWVVJdnRNOXQzN1NVcklh?=
 =?utf-8?B?VStCMUllNFcrQzRwdnJnRWtiUTdKck0raUpSTi96MzVQVlZaMXdiekZ0YVo2?=
 =?utf-8?B?RDlxT21tMGJkeU1SVjJpclFiVDhHdFl2S2drQkRDV2ZCaURPZExxdUpNNTlv?=
 =?utf-8?B?a0RwWVdkR2NpNWdQSzJQTEgzUGJYUEl0VXZHZE1Wb1FRWVIzYnU1VGoxdDlB?=
 =?utf-8?B?VktJdmxNZC9nUGpqb1RiQVFzckhuRFhEcGFVa0QrZkErN0RadkxnRlZWS2Jl?=
 =?utf-8?B?TVlTV1VwUWF6NFkzZHJ3UjNFT05hOERSTDd4bUE3Sk1hVStnc2RTQXNRK2NJ?=
 =?utf-8?B?RXhNYnVQd0VCUXVYOXp6a1BWRXp3QWR0KzdFOUZTdTlqVjZlOTFJY0oyK0hW?=
 =?utf-8?B?SklOZXJBM1hkU1Qra0VDbmFweFpvN2RhRGpCeGQvTmxtMTluZ0N3RWxYMUZZ?=
 =?utf-8?B?cVJrZmJnT3lUNU0yMHYyZGtmN0g1NEp3a2NZV01kY1dmbm8wakNncHZuNi9V?=
 =?utf-8?B?aUJpZmxCWXdGUHBEa0UvR2dyU1lPU1hTSElQdG8yUHZ5OFRCZDhUOURZUm9a?=
 =?utf-8?B?VmdnTUJyK015aklyV3BqcU1GYmxMY3lRY1dtZndmRWxIQlRsSTRGTW9MRkdV?=
 =?utf-8?B?Rld5VXVKZ21uRkZZNHlMWDdnNTR3aE9BazVsUlpyZkNBN2JVcC9JVlVzVnlD?=
 =?utf-8?B?SzNSU1RpK0Y5aG0vL2ZJSTRCMXlreG5xTmx5VWxFUFRIVWtjZkw0NVVxdTZR?=
 =?utf-8?B?cVdKM2dpcTdvRE01R1V6Y1RFQndjd2R2NUQ1ZWczbmFUQTlYa3hPTTF1ZElh?=
 =?utf-8?B?MnRZMDVmL1g1czg0ZmFoMkxuOGF0QjNrc3RyeVlrMjR3MnYwSVdSK3Zyb2N5?=
 =?utf-8?B?SDBPemV2ejdhMnI3L2pNR09IdGJwZEhZaS9IWndXNHM1NWREVWJhdTNJQWU3?=
 =?utf-8?B?RUVCS2N4S29iMWNoQmNLczlTWFQyYWtPOW5EYjRCdjJtYWh2aXozeHFHYmw5?=
 =?utf-8?B?RUFJQ3VHcHd6c0RwMHlQTDlOaXc2QW5MV3VIdVFRNWpsbWswaUFKV1FyZ0U2?=
 =?utf-8?B?NFQzU3V2VUVtRWlmM0FIZlkxWHUzQnphSDYrR0Y2SUNnQ2RHakRBR2UyVU5u?=
 =?utf-8?B?RzVtb3o0cXBhZVg5Yi9FemFGMlJqUGc1VXZvYlNNYWduUy9aUHVFOS9nU0VV?=
 =?utf-8?B?anppYzlob0VxV3NTTGFLYnJwMkF6QkxZQWVJT0VtT2tLb29iRFkra2xrV0F1?=
 =?utf-8?B?UmNYYUpXN1BJQmdwNmNuY0xDQnMyWUxpMTQ0SGRnQ21VcStONjI1N09hLzBF?=
 =?utf-8?B?ZHNkTml6aDUyM3JXMyttOXRyOWxRaUZUajFlZ3JlTVhZSklMMmc1UGFOZmZY?=
 =?utf-8?Q?6lwI2+UtaZrz1WThqi522mOuM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef0742d-46b8-4af2-8a5b-08dd6af02ab4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:23:09.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghFLHNc1sw8pV5j81BJC5k0b8kcC4+3p1Ng5zkboaI+3rultYhKZvmNB536Z+0v/ISipuUNK4Ul1R+eq/k5SuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6194

From: Jan Kiszka <jan.kiszka@siemens.com>

It turned out that trying to put a timer-based timeout on top of the
loop that calls recvmsg_rt multiple times is broken in an almost
unfixable way.

First of all, timing out by setting XNTIMEO and resuming the waiter
(=caller of recvmmsg) races with entering and leaving the blocking
state inside the respective driver. When the timer fires while the
thread is not inside xnthread_suspend, the condition is lost, and we may
even enter infinite blocking later on. This was observed in qemu setups
with overloaded hosts, but it could also happen in proper deployment if
the caller of recvmmsg is interrupted before suspending.

Second, the driver has no idea about the outer timeout and will
therefore happily use its own per-socket timeout in addition when set.
That can lead to unexpected results for the caller. Unfortunately, there
is no standard way in RTDM to control the socket timeout, not to speak
of an efficient one.

Finally, it would need an interface change in RTDM to collaborate with
drivers for implementing the out timeout without races and without
interference by the socket timeout. This appears not worth the effort.

Given that the socket timeout can still be used in place of the recvmmsg
timeout, though not with identical semantics, we avoid complex
refactoring in favor of discontinuing the timeout feature. Programs that
continue to pass non-zero timeout values will receive an error from now
on.

As this obsoletes some functional testing of the timeout via recvmmsg64,
adjust it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - kept timeout=0 support
 - kept test suite, using it to test restricted support

 kernel/cobalt/rtdm/fd.c                | 48 ++++----------------------
 testsuite/smokey/y2038/syscall-tests.c | 41 +++-------------------
 2 files changed, 11 insertions(+), 78 deletions(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index d5813a16c2..4ef110bb28 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -641,36 +641,18 @@ out:
 }
 EXPORT_SYMBOL_GPL(rtdm_fd_recvmsg);
 
-struct cobalt_recvmmsg_timer {
-	struct xntimer timer;
-	struct xnthread *waiter;
-};
-
-static void recvmmsg_timeout_handler(struct xntimer *timer)
-{
-	struct cobalt_recvmmsg_timer *rq;
-
-	rq = container_of(timer, struct cobalt_recvmmsg_timer, timer);
-	xnthread_set_info(rq->waiter, XNTIMEO);
-	xnthread_resume(rq->waiter, XNDELAY);
-}
-
 int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		       unsigned int flags, void __user *u_timeout,
 		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
 		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg),
 		       int (*get_timespec)(struct timespec64 *ts, const void __user *u_ts))
 {
-	struct cobalt_recvmmsg_timer rq;
-	xntmode_t tmode = XN_RELATIVE;
 	struct timespec64 ts = { 0 };
 	int ret = 0, datagrams = 0;
-	xnticks_t timeout = 0;
 	struct mmsghdr mmsg;
 	struct rtdm_fd *fd;
 	void __user *u_p;
 	ssize_t len;
-	spl_t s;
 
 	fd = rtdm_fd_get(ufd, 0);
 	if (IS_ERR(fd)) {
@@ -687,26 +669,16 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		if (ret)
 			goto fail;
 
-		if (!timespec64_valid(&ts)) {
+		if (ts.tv_sec == 0 && ts.tv_nsec == 0) {
+			flags |= MSG_DONTWAIT;
+		} else {
+			/*
+			 * The timeout parameter is not supported.
+			 * Use recvmsg timeouts instead.
+			 */
 			ret = -EINVAL;
 			goto fail;
 		}
-
-		tmode = XN_ABSOLUTE;
-		timeout = ts2ns(&ts);
-		if (timeout == 0)
-			flags |= MSG_DONTWAIT;
-		else {
-			timeout += xnclock_read_monotonic(&nkclock);
-			rq.waiter = xnthread_current();
-			xntimer_init(&rq.timer, &nkclock,
-				     recvmmsg_timeout_handler,
-				     NULL, XNTIMER_IGRAVITY);
-			xnlock_get_irqsave(&nklock, s);
-			ret = xntimer_start(&rq.timer, timeout,
-					    XN_INFINITE, tmode);
-			xnlock_put_irqrestore(&nklock, s);
-		}
 	}
 
 	if (fd->oflags & O_NONBLOCK)
@@ -733,12 +705,6 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 			flags |= MSG_DONTWAIT;
 	}
 
-	if (timeout) {
-		xnlock_get_irqsave(&nklock, s);
-		xntimer_destroy(&rq.timer);
-		xnlock_put_irqrestore(&nklock, s);
-	}
-
 fail:
 	rtdm_fd_put(fd);
 
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index b614d3ba07..fd81c73bef 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -974,9 +974,8 @@ static int test_sc_cobalt_recvmmsg64(void)
 {
 	int sc_nr = sc_cobalt_recvmmsg64;
 	struct rtipc_port_label plabel;
-	struct xn_timespec64 t1, t2;
+	struct xn_timespec64 t1;
 	struct sockaddr_ipc saddr;
-	struct timespec ts_nat;
 	int ret = 0;
 	long data;
 	int sock;
@@ -1036,9 +1035,9 @@ static int test_sc_cobalt_recvmmsg64(void)
 	}
 
 	/*
-	 * providing an invalid timeout has to deliver EINVAL
+	 * providing a non-zero timeout has to deliver EINVAL
 	 */
-	t1.tv_sec = -1;
+	t1.tv_nsec = 1;
 	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
 	if (!smokey_assert(ret == -EINVAL)) {
 		ret = ret ? ret : -EINVAL;
@@ -1054,41 +1053,9 @@ static int test_sc_cobalt_recvmmsg64(void)
 	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
 	if (!smokey_assert(ret == -EWOULDBLOCK)) {
 		ret = ret ? ret : -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * Providing a valid timeout, waiting for it to time out and check
-	 * that we didn't come back to early.
-	 */
-	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
-	if (ret)
-		goto out;
-
-	t1.tv_sec = 0;
-	t1.tv_nsec = 500000;
-
-	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
-	if (!smokey_assert(ret == -ETIMEDOUT)) {
-		ret = ret ? ret : -EINVAL;
-		goto out;
 	}
 
-	t1.tv_sec = ts_nat.tv_sec;
-	t1.tv_nsec = ts_nat.tv_nsec;
-
-	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
-	if (ret)
-		goto out;
-
-	t2.tv_sec = ts_nat.tv_sec;
-	t2.tv_nsec = ts_nat.tv_nsec;
-
-	if (ts_less(&t2, &t1))
-		smokey_warning("recvmmsg64 returned to early!\n"
-			       "Expected wakeup at: %lld sec %lld nsec\n"
-			       "Back at           : %lld sec %lld nsec\n",
-			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+	ret = 0;
 
 out:
 	close(sock);
-- 
2.43.0
