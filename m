Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416633A9627
	for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962313; cv=fail; b=Pyc3x6veU/qG4l01YkElG617f00Ob0PtOZSn/VTDBlC6vofFO8+kYvXWNBV7GEqjhq26cPS6/4aloUDDj+0nvd0aiekVcrsB9GIKK18PCiVNfJFA+ylWsTu5QmURe+nehytL/9MXLrhRpCcYhS496/ph5853NIjQ0XoIErcsg/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962313; c=relaxed/simple;
	bh=HxTOREk86YRQoNoTMgAFYRbVEXzwh79Y6JJdcioDcUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U/aItcchoC0zbRqdYHCaIbIGpD3cjNUL1Iu7soV34nlhpsBl1Tp12CcxzkA0q6sKzNK3uFKQTha1QqAZsnzuPLDL3MQhImKk7u4IlBx1Wa+6PiqyFpKUTZveb/OfKuDtCMlDl3PQK/AmY8ttpK0cN7zMrICkMCfex9ZjonOiok0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GsfJW1iF; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GsfJW1iF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHRIMKHqnWJO1QvtqmCIy1W+PZmbWiRsPV5Ssgk6xfV+9qWF3W7ALmiITf2GQV3vqy2MButXBph7iV8GTlqHTTyODtlTMKyXL8ScYO0RtN9cQCA8XaIpQ+3XA1FkLpNaJbZZFNKYSMJI6oNZGAvwMoMuUsDnbFFmdx65g6j3JLyfjmALOhO4QIpN3BACKnCd73vtRkwW4Cdpe/H+w6CgxEailvg791d9A9gUB6goa/MomFe2Iu/mpKhgtrfX7LPgS/Y5g7IANiYLF2TNjmdpOT9By50OWLwl3qywIPU2RZtmA/wCSAVQu7okGUWkA/kDPdOxsT6R1pt8/QozEKni1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFUgcNhdQyue4MmenyVGjpQ69RSNq8wh9VvqwzAChRY=;
 b=mGnu7+4+Fl2J+AK0lcehNZ6Q/PYlUbMrSvjn5M4DrtBfwy74/HEF6yRb74K9MIbsLxHHdf+O+x0EjkWhAtRo536uU09IXwnF0AOOsQoXjIedBqFoLivOtyBFOArOVB6ns9WfpI2yldedeSwwpcWTxyDih88QT6FppWQExJRXLD8I9pLLuUkgoJmWgEUdJgIc2tokLWypNweogGov+xnpwKRzTedeOgCpkGkierHGS5kvOQ3Y0iRoGgvcNSpuwn3uFzFFo4AEPB5pBH4CjXpqryi8oSoDXookhjWLIaJWNbFXIwYMKOp593D6idds5hs186CPwIzL5gJ5OZl+2Iht6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFUgcNhdQyue4MmenyVGjpQ69RSNq8wh9VvqwzAChRY=;
 b=GsfJW1iF9CzciyFBYOe8NRwn8Dbo3iKQkp7qYS+IZoPaEwLtkJRpUV2krZesMe4ijUc9yX1PvSsHi/EN6EcWmxSy2aHbPnntfSTf0JK+DmAnZeVIGoZpNazgzBNFeqvBr18GFyJGDW0OpMVrP/LR56h911ZmrUg1BHlQF6OWK3QXQlqv3VOErsTWQt+dZx8S6+OLAHMgLyBHxcUhOUf8ixn6MuuDc1c9lT4NLIXMFeyCWsCwMUuikza8xe8uq+nGq2g7VTiJsjnNdEvHmkcvtTP4sm+QvVjsRFhqlIrcG0Uw9jFqnHRESDImuTz42fdiTuc1M83605/exmPfGreGyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:25:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 10:25:05 +0000
Message-ID: <b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com>
Date: Mon, 17 Aug 2026 12:25:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
To: Gerte Hoogewerf <ghoogewerf@lmi3d.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
 <87v799kt2q.fsf@xenomai.org>
 <CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b852a3-e8c6-47a3-d8da-08defc49cddf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|55112099003|56012099006|3023799007|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	sO1CGFHcOcIDoRsH1YGOJPbbra/0liwEMma2a64FaJ/GxgCFlQtukP7mq7hRznHFLAcU8Aebkz2aT7twapZCWZatKhDPxCCcY0/495yzjt7gIkamO+cukFy0VO4z7U4jn/kNPxBpJjIM1ocdXirA+/ZBLMJCT+62pzz/bTqDcEkf7/jI9Jsg9LIFYqu/E9QTW0WpYz74z4gThjxG8V6S3qBz5BPIspZtJDUh4h1Bhlp4yVoFUEY2ZZk9b7j84MvnjvagLvlOrnGCVwTTFM7rjLKGrYmyhKuB4Exwx+X/atmJfPjjaThEqSYK+6GTCnZyMd5l70gDUhuw8MfoVGdAjGZ1mpWR+l1nh0j+0Xiw5dG9Zm8v6a9g9AkYX1N6cF61Pdx9TySSQ3Q9p4KZLhFdf31DjORj+2ZU7Cp/WKGYkawNzx67VrsSpn9+HHhKsJFSPlpRnuoH/wMbPv1a/DpJ5Wwh8u2TmwOcEz0vS29H8dIF2YDBLeNxBnvTsYgs9/gM0eNfKqCfgBk6wn5AaSwaVqmY34/I4qOY0TtEczduDqqjYiSMDFymBBdNkfqql3i0s7wxPF/T0YuH27GvKkqSLCHs6ZNK56iB5GHalHQ8LwqYVkm4lwgcsm0lOWXeDO8gFDIzCyBjsC7AZYsl2/61s4AAa1SbSS2kYtaXmLlrNMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(55112099003)(56012099006)(3023799007)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFF1c1pSa2FyUUlrakdqbGEvNlNCMDF5bHhHdFErSWtWUEsreW03Q2tzaXlM?=
 =?utf-8?B?YkVnOFV0QVlGcm50OWdhV0xxcDkvbUNTS1hKeDRyMXBQc2NFVlpNZ0d3NGZT?=
 =?utf-8?B?alN1TVRYeU9wT2pWc2d3M1ZEbEFHRzcyVGRYN2t6aXdMNk5oaThyQ2ZXNjV2?=
 =?utf-8?B?K2pCQWtiRGpUaXBtYzZ1SHpRUVNadW1JU3ZkZmRzUEgxR3VRcEFzVkYwS0lU?=
 =?utf-8?B?YUhwb2hIMEcrcTNEM2MwMU9rVHIwcWk4b2kxeHFicnRZc1JpSjluY2lHNXov?=
 =?utf-8?B?eWZEM0xsV3dGclF4Q2d4c3VJcnZNS2YyQyt3TXp1UXFqNGVGZENCcEExQ0Zn?=
 =?utf-8?B?OEx5ZUl0WkVuakp0QzJHVGkrRTR3LzR3aXZReWFBSWRxRzB1S0RsRk5BbkQv?=
 =?utf-8?B?U0pJYkpjWFVoWGJUbnhkQkNXaVVGdzlTS0VQbHJpR2dXSElPdThvM0NKWStj?=
 =?utf-8?B?RkZKVlZkbWZMdG4yVlZFZ0M5N0pFckZOT1Nza005aGtLcmZ1T1ZqcG1BQmlH?=
 =?utf-8?B?b1JtZXZQbzduak1mYWxVMzlWN2IxUGQ4YTZvWTIxMzhGZFZwWE1mdnJ2NDlm?=
 =?utf-8?B?OThHcndkZTkwRmJoRXp1RG9uZVZOcmp6aXR2T2VnYmMzb0NLVGFxbTB0YXJ3?=
 =?utf-8?B?T0dSQkpCRkloNElLVkp3bUNENnV2L1FTZHU0OHpYdWpaMitXR2VuQjVQSSsx?=
 =?utf-8?B?WGJ3cVY5Wjg5VFRabzNlYlRBdWgwRWRsRG5FVVhzMjVoZEdqaytBV1RoMlBF?=
 =?utf-8?B?NW9yUlVBU0lYM3dFS01URzdMTWVGSXJkR3Rwa3o2YjIzZXV6TUh4M2RPVHUr?=
 =?utf-8?B?YTFaRTZZRjdiZG1hMTFoa240cUVGaTdUL0NMZmczZEQ5K1ZnWnFzK3Jza3lJ?=
 =?utf-8?B?QnVOZ1BSVHR0YzNhWkFXQUtscVBOK1FGWWQwS2RSNklkSTJZdE1OQVBhYnZP?=
 =?utf-8?B?M3BFYld1Q2s1MGR1K3lYWXI1RGthVFhwNlUyMk9DdXZ0aTBPcEdwSzc0NlVU?=
 =?utf-8?B?NEVHR2RNa3NMRVhuRHRETU5pKzZ5R3diSW55SnpxeXQ3ZmdGYjQ3QW5MaXhk?=
 =?utf-8?B?ODNNOXowSTRVNW1takRsUkx6eGdiK2VpS1lpV3JEWDRFb1k2R2w2RG5CUEgy?=
 =?utf-8?B?Z0wvdW5BMzc5TWlXcGxmaUUyYU1PVnVNMnpJMlNJQWxQNDBDbG96RmVOM0Fw?=
 =?utf-8?B?VXlZSlVQNXJSSmFmYXRaZkd3LzFYSXppWFQ3aXBVV0pRS2pua2NTMGVLc2J6?=
 =?utf-8?B?aFRweFhIMWlxbUd6QVcyT3BkVmdUNEtzUXA5eW84K2d6RmpjajFDcUpWVWRj?=
 =?utf-8?B?VCtvRmQ0VTkwaHljTTNMZzRUYlhxRlhrcTJqRG5YSW5XcFQrVjZiNGRxUnlR?=
 =?utf-8?B?SnFjNFdOYkNVSVAwV0trUGNxRjlXdllETEhSaGVudWI3UFZlMDY4Y29kQ2pm?=
 =?utf-8?B?dHFVaUVkdUltdW5odHJDUWNiZGYzRG5aay9vZHU3cWVlZE9BSkIwOHBkbElz?=
 =?utf-8?B?eFNmSHRrOURKck56eWV1czNIVmVzc3FPY1RvMHMrcDRUeDZZVTVSWi9SbUNC?=
 =?utf-8?B?bTl0VUo3K3dtWkJENkZmeWwzeWpZcXJkOUhNYjVGcHU2WGtQaU1VN1hkbzNk?=
 =?utf-8?B?NDlxSmpHS2wzZTlvWjlOQ205bkVQNnBqOGsxR0xiV2tJbytMWVdKV21EeHFr?=
 =?utf-8?B?czRLR2hTZ2hSUGF2Ri8yOUlDcTh0TzJvMXRDcXhScjhUbCs4ajBmYjRDNkVt?=
 =?utf-8?B?SmZadnF1ODdQdUp1UEd1OTBEVjNDNW5QQnh6L2c2VFdpTFpMTVU4eklzRWY2?=
 =?utf-8?B?NGJwM0I3eXpSMURGblJtRlVod0l4eW1QTzE1NkgybmFJL0VPR3JhUkkrVldQ?=
 =?utf-8?B?TTZXeXQyTUk3SlU5OWZzaFEvS2k3WlNVaG9DVm1wd2hpMnk4d0xtK2R4Ympw?=
 =?utf-8?B?SlBaOUwvelBEdU1NMUhDNmdyck12amZWS2NqZXhtMElnblpuMGJmeGRzSTBY?=
 =?utf-8?B?ck51VjhtaDJ1ZldiSktOYm9GWUt2a3MwZnhqbStObzZBbWJZSFlkU1AwaE5D?=
 =?utf-8?B?ZG9CK1JKdU1YR0pNZGxMd1kwVkZRSFpWd0tjNHhkTlRVckwvd2pFYmxBdlpF?=
 =?utf-8?B?RmZneUlsOFZCdmFtOVBWRUVFVmMvWnZ2THhyTGpuNmNpeTJNS3I1QjN0UE9k?=
 =?utf-8?B?Ry83cU1WdDY1NHlicUp3SkNHODVNT0FaSVpkc2J3RUJ4amdEOFJFWU5SVUlr?=
 =?utf-8?B?bHpNTTViQTZ6RFJoZTY3WWg5VU04VVcrNnVNMGtUZlVWUHd0U3JteVlnTi9G?=
 =?utf-8?B?aThKNVBOdzJRdUt4V29WQTh5K2tpSFJQRnhrTjgyVkcxZkE2cXFhdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b852a3-e8c6-47a3-d8da-08defc49cddf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 10:25:05.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggxSCtvvayUYOXVm7H+wsrrUIGpRNT3rc5VamJmw6XDlWAzXUSCt8QlkEK73UTBdJGw47fIAvl/FzDX9VSCKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7600

On 17.08.26 12:11, Gerte Hoogewerf wrote:
> Hi Philippe,
> 
> Thanks for the reply.
> 
> I built and ran the kernel with said options.  It's probably not
> conclusive, since the tests passed.  With these options, the kernel
> booted all the way into userland (because CONFIG_EVL=n).
> 
> See output below.
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.18.29-01153-g1e9f8ec43dcd
> (ghoogewerf@NLKRLTF0FQR04) (arm-none-linux-gnueabihf-gcc (LMI3D G++
> 11.4.1-p1) 11.4.1 20240321, GNU ld (LMI3D G++ 11.4.1-p1) 2.40) #4 SMP
> PREEMPT EVL Mon Aug 17 11:49:17 CEST 2026
> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] OF: fdt: Machine model: Xilinx Zynq
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] cma: Reserved 750 MiB at 0x11000000
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x000000003fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003fffffff]
> [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory
> node in the DT
> [    0.000000] percpu: Embedded 12 pages/cpu s19468 r8192 d21492 u49152
> [    0.000000] Kernel command line: console=ttyPS0,115200 cma=750M
> l2x0_write_through=1
> [    0.000000] Unknown kernel command line parameters
> "l2x0_write_through=1", will be passed to user space.
> [    0.000000] printk: log buffer data + meta data: 16384 + 51200 = 67584 bytes
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5,
> 131072 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536
> bytes, linear)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 262144
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 100 jiffies.
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] slcr mapped to (ptrval)
> [    0.000000] L2C: platform provided aux values match the hardware,
> so have no effect.  Please remove them.
> [    0.000000] L2C-310 erratum 769419 enabled
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> [    0.000000] L2C-310 D prefetch enabled, offset 9 lines
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x56760001
> [    0.000000] IRQ pipeline enabled
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] zynq_clock_init: clkc starts at (ptrval)
> [    0.000000] Zynq clock init
> [    0.000000] ps_clk frequency not specified, using 33 MHz.
> [    0.000001] sched_clock: 64 bits at 500MHz, resolution 2ns, wraps
> every 4398046511103ns
> [    0.000018] clocksource: arm_global_timer: freq: 499999995 Hz,
> mask: 0xffffffffffffffff max_cycles: 0xe6a171a037, max_idle_ns:
> 881590485102 ns
> [    0.000043] Switching to timer-based delay loop, resolution 2ns
> [    0.000325] Console: colour dummy device 80x30
> [    0.000351] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 999.99 BogoMIPS (lpj=499999)
> [    0.000361] CPU: Testing write buffer coherency: ok
> [    0.000390] CPU0: Spectre v2: using BPIALL workaround
> [    0.000395] pid_max: default: 32768 minimum: 301
> [    0.000541] Mount-cache hash table entries: 1024 (order: 0, 4096
> bytes, linear)
> [    0.000552] Mountpoint-cache hash table entries: 1024 (order: 0,
> 4096 bytes, linear)
> [    0.001231] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.001262] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [    0.002306] Setting up static identity map for 0x100000 - 0x10003c
> [    0.002473] rcu: Hierarchical SRCU implementation.
> [    0.002478] rcu:     Max phase no-delay instances is 400.
> [    0.002999] smp: Bringing up secondary CPUs ...
> [    0.003680] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.003731] CPU1: Spectre v2: using BPIALL workaround
> [    0.003844] smp: Brought up 1 node, 2 CPUs
> [    0.003854] SMP: Total of 2 processors activated (1999.99 BogoMIPS).
> [    0.003862] CPU: All CPU(s) started in SVC mode.
> [    0.004053] Memory: 256456K/1048576K available (6144K kernel code,
> 224K rwdata, 1456K rodata, 1024K init, 84K bss, 20992K reserved,
> 770048K cma-reserved)
> [    0.004557] devtmpfs: initialized
> [    0.008386] VFP support v0.3: implementor 41 architecture 3 part 30
> variant 9 rev 4
> [    0.008531] clocksource: jiffies: freq: 0 Hz, mask: 0xffffffff
> max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.008552] posixtimers hash table entries: 1024 (order: 1, 8192
> bytes, linear)
> [    0.008608] futex hash table entries: 512 (32768 bytes on 1 NUMA
> nodes, total 32 KiB, linear).
> [    0.019015] pinctrl core: initialized pinctrl subsystem
> [    0.019919] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.021704] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.022681] thermal_sys: Registered thermal governor 'step_wise'
> [    0.024823] /axi/etb@f8801000: Fixed dependency cycle(s) with /replicator
> [    0.024940] /axi/tpiu@f8803000: Fixed dependency cycle(s) with /replicator
> [    0.024967] /axi/funnel@f8804000: Fixed dependency cycle(s) with
> /axi/ptm@f889d000
> [    0.024987] /axi/funnel@f8804000: Fixed dependency cycle(s) with
> /axi/ptm@f889c000
> [    0.025008] /axi/funnel@f8804000: Fixed dependency cycle(s) with /replicator
> [    0.025047] /axi/ptm@f889c000: Fixed dependency cycle(s) with
> /axi/funnel@f8804000
> [    0.025079] /axi/ptm@f889d000: Fixed dependency cycle(s) with
> /axi/funnel@f8804000
> [    0.027727] /replicator: Fixed dependency cycle(s) with /axi/etb@f8801000
> [    0.027820] /axi/etb@f8801000: Fixed dependency cycle(s) with /replicator
> [    0.028053] /replicator: Fixed dependency cycle(s) with /axi/tpiu@f8803000
> [    0.028162] /axi/tpiu@f8803000: Fixed dependency cycle(s) with /replicator
> [    0.028391] /replicator: Fixed dependency cycle(s) with /axi/funnel@f8804000
> [    0.028797] /axi/funnel@f8804000: Fixed dependency cycle(s) with
> /axi/ptm@f889d000
> [    0.028822] /axi/funnel@f8804000: Fixed dependency cycle(s) with
> /axi/ptm@f889c000
> [    0.028842] /axi/funnel@f8804000: Fixed dependency cycle(s) with /replicator
> [    0.029084] /axi/funnel@f8804000: Fixed dependency cycle(s) with
> /axi/ptm@f889c000
> [    0.029196] /axi/ptm@f889c000: Fixed dependency cycle(s) with
> /axi/funnel@f8804000
> [    0.029422] /axi/funnel@f8804000: Fixed dependency cycle(s) with
> /axi/ptm@f889d000
> [    0.029509] /axi/ptm@f889d000: Fixed dependency cycle(s) with
> /axi/funnel@f8804000
> [    0.030334] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
> watchpoint registers.
> [    0.030345] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.030980] e0001000.serial: ttyPS0 at MMIO 0xe0001000 (irq = 27,
> base_baud = 6249999) is a xuartps
> [    0.031040] printk: legacy console [ttyPS0] enabled
> [    0.656472] pps_core: LinuxPPS API ver. 1 registered
> [    0.661475] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    0.670642] PTP clock support registered
> [    0.674730] FPGA manager framework
> [    0.678947] vgaarb: loaded
> [    0.681809] clocksource: Switched to clocksource arm_global_timer
> [    0.696109] NET: Registered PF_INET protocol family
> [    0.701211] IP idents hash table entries: 4096 (order: 3, 32768
> bytes, linear)
> [    0.709073] tcp_listen_portaddr_hash hash table entries: 512
> (order: 0, 4096 bytes, linear)
> [    0.717504] Table-perturb hash table entries: 65536 (order: 6,
> 262144 bytes, linear)
> [    0.725305] TCP established hash table entries: 2048 (order: 1,
> 8192 bytes, linear)
> [    0.733001] TCP bind hash table entries: 2048 (order: 3, 32768 bytes, linear)
> [    0.740209] TCP: Hash tables configured (established 2048 bind 2048)
> [    0.746644] UDP hash table entries: 256 (order: 2, 14336 bytes, linear)
> [    0.753308] UDP-Lite hash table entries: 256 (order: 2, 14336 bytes, linear)
> [    0.760525] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.766234] PCI: CLS 0 bytes, default 64
> [    0.770437] Trying to unpack rootfs image as initramfs...
> [    0.773208] workingset: timestamp_bits=30 max_order=18 bucket_order=0
> [    0.782489] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.790608] Key type cifs.idmap registered
> [    0.794984] io scheduler mq-deadline registered
> [    0.799550] io scheduler kyber registered
> [    0.804360] zynq-pinctrl 700.pinctrl: zynq pinctrl initialized
> [    0.815734] dma-pl330 f8003000.dma-controller: Loaded driver for
> PL330 DMAC-241330
> [    0.823414] dma-pl330 f8003000.dma-controller:
> DBUFF-128x8bytes Num_Chans-8 Num_Peri-4 Num_Events-16
> [    0.823926] Freeing initrd memory: 868K
> [    0.844386] brd: module loaded
> [    0.852204] loop: module loaded
> [    1.875058] hwmon hwmon0: temp1_input not attached to any thermal zone
> [    1.891204] macb e000b000.ethernet eth0: Cadence GEM rev 0x00020118
> at 0xe000b000 irq 38 (88:20:12:f4:c1:e5)
> [    1.901632] i2c_dev: i2c /dev entries driver
> [    1.906095] cdns-i2c e0004000.i2c: can't get pinctrl, bus recovery
> not supported
> [    1.913947] cdns-i2c e0004000.i2c: 400 kHz mmio e0004000 irq 39
> [    1.920565] clocksource: ttc_clocksource: freq: 81380 Hz, mask:
> 0xffff max_cycles: 0xffff, max_idle_ns: 358356783 ns
> [    1.931176] timer #0 at (ptrval), irq=40
> [    1.935478] armv7-pmu f8891000.pmu: hw perfevents: no
> interrupt-affinity property, guessing.
> [    1.944210] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
> 7 (8000003f) counters available
> [    1.954162] NET: Registered PF_INET6 protocol family
> [    1.960216] Segment Routing with IPv6
> [    1.963951] In-situ OAM (IOAM) with IPv6
> [    1.967951] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    1.974456] NET: Registered PF_PACKET protocol family
> [    1.979561] Key type dns_resolver registered
> [    1.983957] Registering SWP/SWPB emulation handler
> [    1.995551] Starting IRQ pipeline tests...
> [    1.995564] IRQ pipeline: high-priority torture stage added.
> [    2.005421] irq_pipeline-torture: CPU1 initiates stop_machine()
> [    2.011360] irq_pipeline-torture: CPU0 responds to stop_machine()
> [    2.011375] irq_pipeline-torture: CPU1 calls function on remote(s)
> [    2.023753] irq_pipeline-torture: CPU0 handles remote function call
> [    2.023879] CPU1: proxy tick device registered (499.99MHz)
> [    2.030068] CPU0: proxy tick device registered (499.99MHz)
> [    2.041026] irq_pipeline-torture: CPU1: irq_work handled
> [    2.046338] irq_pipeline-torture: CPU1: in-band->in-band irq_work
> trigger works
> [    2.053645] irq_pipeline-torture: CPU1: stage escalation request works
> [    2.053651] irq_pipeline-torture: CPU1: irq_work handled
> [    2.065475] irq_pipeline-torture: CPU1: oob->in-band irq_work trigger works
> [    3.121838] CPU1: proxy tick device unregistered
> [    3.121841] CPU0: proxy tick device unregistered
> [    3.131124] IRQ pipeline: torture stage removed.
> [    3.135746] IRQ pipeline tests OK.
> [    3.143513] clk: Disabling unused clocks
> [    3.152057] Freeing unused kernel image (initmem) memory: 1024K
> [    3.158189] Run /init as init process
> 
> ---
> 
> /bin/sh: can't access tty; job control turned off
> / # uname -a
> Linux (none) 6.18.29-01153-g1e9f8ec43dcd #4 SMP PREEMPT EVL Mon Aug 17
> 11:49:17 CEST 2026 armv7l armv7l armv7l GNU/Linux
> / # zcat /proc/config.gz 2>/dev/null | grep -E "^#? ?CONFIG_(DEBUG_IRQ_PIPELINE|
> IRQ_PIPELINE_TORTURE_TEST|DEBUG_DOVETAIL|EVL|SMP)(=| is not set)"
> CONFIG_SMP=y
> # CONFIG_EVL is not set
> CONFIG_DEBUG_IRQ_PIPELINE=y
> CONFIG_IRQ_PIPELINE_TORTURE_TEST=y
> CONFIG_DEBUG_DOVETAIL=y
> / #
> 
> ---
> 
> On Mon, Aug 17, 2026 at 11:13 AM Philippe Gerum <rpm@xenomai.org> wrote:
>> Regarding the issue you are observing, it suspect this is
>> Dovetail-related. If so, xenomai 3.3 which is using Dovetail won't boot
>> on the Zynq either.
> 
> I can actually confirm that.  We had been curious to try running the
> Xenomai 3 stack on Dovetail by itself, and made the same observation:
> it hangs during boot, and disabling CONFIG_SMP works around it.
> 
> I hope that helps.  Is there anything else you'd want me to try?
> Regards,
> 

From what you described, it is most likely that some SoC-specific
adjustments are wrong or got lost on the transition from i-pipe to
dovetail. Already looked for Zynq-specific bits in the last 5.4-ipipe patch?

We never had any Zynq board enabled for the Xenomai lava lab, and all
the eval boards we had here got dumped while moving 2 years ago. But if
someone is willing to set up a lava working with a Zynq board, we can
include in future testing at least. Still, it would also need someone to
look into regressions, just like now...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
