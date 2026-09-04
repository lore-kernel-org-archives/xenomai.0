Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18D44682F
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525972; cv=fail; b=q547KV9Vh078snQxHlDkIoQMk5FE9EN81AgZbJgAFovQREubAZucOipWDHSBk9wbjdgkMThVbnNKcAnltuMy40w+xBoknFQstb3rcLaKnmcJy9KIy1eONbSXkLRJmhox1HI4/3LfAbIZ7Uz7ga3i6NTWlamd0i255rxVxDQYMlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525972; c=relaxed/simple;
	bh=u+Ai00KfFaJ3s6B4FNfX4MWkGHWUe0gzorPPSZy60yc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RoZzdYWZ8mxOloit2rwYJbV9TUPFIsx/GA7sFmuGk4KNrMXHS8xQoGJ1ZoFfU+nZuxeNfMVuM5g2I+PX3n0Jw8Zby5JM2I+YBKGk5iaH75KiyRi+BOT1fafo0O8Oq1dQ41kPoj0TLJNvUBQhSPxhjALw4RTeSR9ioVGRilmL1Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U6TPYunV; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U6TPYunV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTHWMvqRRDN/R01N4CK9xROepWaZdb0JexwvALEbXS4oEgfKE6qoWfxhnwHvhazakTj1dwWzVUl2bCvE/OVv+/YNQqZsXT10scEVcZq00zLk7IROkXeEByvvSQBqEO7jhGgg9mI+rePdA6s8sInPDzH8DGxTIdOCwJrI18ScCWzH6nOUo77ou5kq3EU2421/XviaxClJN8CvOlUPPFX2v1GiD75UkOMBySxBiFPkeXPw2M0iH4BXFW+PWHmPajhMYdaGnkr0CEBaYnh9fUP9n0USIiGj8QqZzebu+HbfuB2jqr+WoMHrbqxPEYWmupq93lnrX1MMWQloThWaC93eSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSF+G/d2rwqLBb6EC9GRF1MdEnWNc8mp96hFFuqT0Bc=;
 b=I+yd3im10zDBjetFzosN4MblfEi6ua3LAQg3DXqdv1q6uatVRIA48V/4PxoOg7NsC4iCmDC+X0sp4CBAb5IpgMRXdTx3ni+bJVSK0m/YcZ3ohUTf83Xfv3siR/lkF/14Eflour3OcXDL7x/QGyl6nwZAE9DRusdak82VFDhsPtx/ioQtwjDZYLc4w3i+eV3esFBW2+2nD0zWCqt/MCmOVjEPOH6tl2FUQVVj28oybB44q/tfQ8YFc+AeaR0GZ03J2Nyo9w56T/Q0tKIUQSaHXncpAaqFQnGhCgn0y0Y47fqayuDCrSOUc/hNwqYTr2vg51AZX4kkAJDyXqsy7InjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSF+G/d2rwqLBb6EC9GRF1MdEnWNc8mp96hFFuqT0Bc=;
 b=U6TPYunVMvFptazkih7IZ39sbcoX/MaBuDFo1Vj+/l2kNUG8pCk+LxQh3XMOGuJz58Lummn2Ixx4OSPKiWC5/jHH+kv70HHYA4C+MbMpi2QFWatxrkyC8NruubJjNSfsbQtcZDXd1tAKMBrStpR2P6Z3NQ1bJp10K1TBxkALvcv3MQ0ApsgzRjLH6hSRpqACIIUklqTlwVhLPUqz5pcy3RG+2LzRXzPdeHI8+qq67weBjYNKtnJfy5RLQ8ZnyqczJf3g5E5hbASnwM4ZiZayt6e0QchfO6k3lAnLxu5PgpoAUeTBoNpO8QU8Wk26WWlhCQRhPkPSMRRWeBQdnDYl8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB6124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:98::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:46:06 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Fri, 4 Sep 2026
 12:46:04 +0000
Message-ID: <776fa79b-bd7b-4309-95c1-bb659793d63d@siemens.com>
Date: Fri, 4 Sep 2026 14:46:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail + EVL: RISC-V + 7.2
To: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
References: <878q5he1ei.fsf@xenomai.org>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <878q5he1ei.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 805af225-1f24-4dc4-611f-08df0a827b2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|22082099003|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LCoEk3EyfOC/TsuQaj5eVqDtX6jGiazCfZJ4Dr9fxtKq4BQ0kcOmnbVqW3Pl6c2fApoQWJR2sbxvlktlwtN6qMwfRb5bxZFCpbYPJvwiOMivKL/krwo1p9BO5R8oqO1Ln7CsalXfI/ly4TqFRtJskR3DrpxJ+8q1XMG7QWaYMlFW+y7KwIJHLMixDRE7cn6+vdYLS0Hvli2KBu5LJtzkMKhUhlr90Tg3yWq74w5e4+Hyl2k1An0b+5tNnbq447/RMBfSGMMpIlv3RFrbR+CFDmRZQWqa//W2+un8R+x36EQK6fseYnUPAB1ullrk+6A9PRkKNVYycAvPwG6OjKNGyzgh6kSnfKONt7ZsV4ZdaH/Dxy+Od9QiqlbhRwI+KbZI6dQX9u7Vd8G3bfMvCqKK4ItestAfO3enHwJSL9dk41zkzwbDiXRRjyos2Me6LPfgKb202KmqxI1KpkqzoZ94iPS6lG4CpcGvWscf+NWnx3pTPw+dMcdD7K1HzTxjaLJmNTCPXOJUebhwc8erlUc5GS79rPagNUxtck2m5Cb8sqzgo0fJXF4mUkyCWaCcvQSSBsC8Dn2Aun0e7cNuAcShxtFWG5xvxuQ0qpxfGYBaTx6e1oPL2AQZVupFoBhf1fSD4EM85hEqkRIB98GIrr0MPoL5Eg5IZbQAcioFD3zAtWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(22082099003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkN3bFVSS2ZhR1EwQUV1WkNWTlN2dHBIMjc1NlB6dzBPcTZmcnI3N3o2VmtQ?=
 =?utf-8?B?UUszS2pvekk0d1NlY1IvYWYxVGYvckdLWkNzM0QvajM3K0RWN05zMmgzVXps?=
 =?utf-8?B?eHkwdVh5TFgxSHA2UXZzUVkxeGpSVzU1cGFiM216eHErSzdIbnF4UUFWcWs1?=
 =?utf-8?B?MElKU0FFMXhVREdyakdLY2NVZ3pENzc5bnViNnRNZjEyRnFFVFBhRWNidnNw?=
 =?utf-8?B?R3NpdElwampOWE1kczJPK0dET25JcGM4aWIvZTVEbmc2cTJhdzdsZHFoUG1t?=
 =?utf-8?B?TmFEaUdLRU9hZDM2YXp2bzRtKzJENnhrbXBsTUN5OUpQMkFoR2dod2xCYUJs?=
 =?utf-8?B?aTRNY2hCdG1SazFiWWFxMjQ2dDIxdGJKK2dRa2x4ZjZRSWJhQ3JiNTdmZTZ3?=
 =?utf-8?B?eXgzdGdrMlZYeEdOaHlXYzYza21nQUNuQUt5YkhYNGZValF2ejZzcy9yZE9F?=
 =?utf-8?B?K0dtQldCdmtySVB0OVIyWStPRDdwZk8xN3pndWNDMFE5TmZaUmw4eXhQTG9M?=
 =?utf-8?B?MEd6YXFoekZyWVVtZWU4UWRLSHAzeEszNW9GaVVqemkzVzl0cFMvR3ZDblFa?=
 =?utf-8?B?NlJLU2VTaXBpdjJ6TWkwd1lwbm9YYlV4aVN1L2xqWjQxaFRRSVh6cld6VkF0?=
 =?utf-8?B?SU02SXRjWkIxRlh5TFBEN3dWQS9haWhsaFEwdWJCODhYMGxWc1BBZEsydHdi?=
 =?utf-8?B?cnlkaDdsQjZnNWpMcUFiVENaWDdEcWwzNDd3QmQ4eXVkbTJXU3B2bXIvRERS?=
 =?utf-8?B?U2JaamowQ3ZFUWRoa3I4cVJJVTlNbWh6bTk4K1UvSVZiV3VLckIrZDAwcFMv?=
 =?utf-8?B?WVVwKzJGNmZvR2VPOXppS2Z1L2o2V0ZCb1BSVkd1dGpOa2FGUW9Lb0NEVFNx?=
 =?utf-8?B?YlVtZmZQcDJzaTlVYmdPTTRnNzlpMlFrWm5JK2JMd3dXRXVLelhhZzVCVk1Z?=
 =?utf-8?B?TGYvemRick1JRlBLL29NMy9xN0pIMnI3Wk9odlFpVisvOWRhUFM0dXFOdWZl?=
 =?utf-8?B?OUt4MG83QlhaOXBiMm5YUjNqZjgrTUpJQXdyeUJVcDMxWnUzY2VqQzNsWkR6?=
 =?utf-8?B?RkRNM3pCcDlHKzBzZTBQRmZaNzNiNkxTa2ZEUUpzSThKNlV4Zk0wcDBwQ2JK?=
 =?utf-8?B?Ynk1NFJSNkhkK0l4enFIOTJUZTEyUnJUNWNlT1o2U211UmJjaTdoV0hDL0Ri?=
 =?utf-8?B?TUQ5UWJrYWVweFBkNnZUVHVOQy85cjh4U0JCM3M3ZUZjMnRhTFhCU1gxYSts?=
 =?utf-8?B?OHhpZGxKbENvVm9kRnVSVTE5TktlaU82T01IWTVRbUp6Z1Ryb0NJd1paeSt1?=
 =?utf-8?B?eks2cTBUSW1WZENEdE1ZQWZyR3ZsMnFWcDRqNEtZNnV0ZVZ0akpTUlR1OTFY?=
 =?utf-8?B?anQwcXErSzg4MHFXMUtvOVBtWmExd2dBNEF1SGIyTjVsUnBBYklOYjZTalhz?=
 =?utf-8?B?RmFvTlpiL3B5azY4d0VDcHcvYnhiamN0dHdUck1JVXg4RFp1d0szQXNrT1oz?=
 =?utf-8?B?OHFWNjlQSHJVL0hVSUsxN0tCNWkyVVM1YWY4bFJTUy92RkJkTlBha2ZTNHBa?=
 =?utf-8?B?V0NqNnhpYUZjS3N4QlpISWtLT3pYcndVY0lQeEM5QnNwTUNFVjZBczgrNGpM?=
 =?utf-8?B?cFlUTVpwREo2cWhXTi9BZHpKWGJvQVdESVowcmtyOWI4THdSbjk0azVwdFpa?=
 =?utf-8?B?ZlgycGsweTVIMUtsY0VUVUFjdEZpbCtyT0w2bnFRaUdvM0xwVXluL1RxaWhQ?=
 =?utf-8?B?RnFRdEhIRnpoOVRHbzNSellqWVVvZEZmVUNiVThDVVN2OUFuMmE5VW51N3da?=
 =?utf-8?B?UVIzUmR6YnRoelJCbXBPQTVncG9DSHovRWVEZ2FZMmdzakZ4NlF5d1JBZjRo?=
 =?utf-8?B?eFNMRXNXY24vQW80OXlqdVRDa3JnMHdlVFNIQnZaN0lsaVRSV3p0ekg5Y3Ri?=
 =?utf-8?B?d05QZHBmZmZqa1ltTzhETWV6R0hMY01MdHVCbTUzZjd5UDVuN1QrNUEvazBz?=
 =?utf-8?B?NGFmYk5DWm1xNzc4RlYyR05Va3g4WXpQQjBVdDloc2tkUzdRdUFDZ3hVNzEr?=
 =?utf-8?B?NWdVa2VuQXRtZmYzcWlLdWlqcUx6bHluSUFJWVlPS3FaVGg0dkRGRkdGdjBJ?=
 =?utf-8?B?RlZySkkrb05WZTcydWpiK2UyZnpsaXpOSkdqT2NHOXY5MWdibFM0VDZScVJ4?=
 =?utf-8?B?eVdpQUtIbVdjb05JMkQyZkhySGhSMVhtTmVnbTdMK0RlT2RxRUd1SzU3TTg0?=
 =?utf-8?B?MHBwQmE4bGc3NWRtcURRN051bFg5Mm9QbnI3YTVhWWxzcUF6TTR3dmpZVDcw?=
 =?utf-8?B?Z1dGKy9EZW1CN3g1UGRpSm44NEQ4QlVDMTZSdmpCaU1qWUk5Q1JhakNCOWha?=
 =?utf-8?Q?oTkznF+ips0JTmDc9IRyHH5oxuxonfXTixrGfVt4shyLl?=
X-MS-Exchange-AntiSpam-MessageData-1: eKi9wiPCb7uyxLBV9Iq+lJKXj/uwiK250qo=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805af225-1f24-4dc4-611f-08df0a827b2c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:46:04.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //fiT1YAITXObesks8hU1CC219xJzjMELaHHHsmr17GWa2JU4ijwUbrnaO4gIv3a7w5is1i7ZTWH0s1zkpeqhLVTDWlVJCv7DF0U8SK5Klw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6124

On 9/4/26 12:50, Philippe Gerum wrote:
> 
> The (slightly overdue) Dovetail and xenomai4 (aka EVL core)
> implementation targeting the 7.2 kernel is now available from our
> development trees [1][2]. Starting from this release, we support the
> RISC-V architecture, thanks to Tobias's work.

Thanks Philippe!

> Building applications for 7.2 requires libevl r61.
> 
> [1] https://gitlab.com/Xenomai/linux-dovetail/-/tree/v7.2-dovetail-rebase?ref_type=heads
> [2]
> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/v7.2-evl-rebase?ref_type=heads
> 

Will there again be a evl/next/v7.2-evl-rebase branch or is there no 
next branch needed anymore from this release on?

Best,
Tobias
