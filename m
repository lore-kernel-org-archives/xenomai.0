Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F02820A7
	for <xenomai@lists.linux.dev>; Mon, 16 Jun 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101200; cv=fail; b=Aj/iqE0n62YP96PyciYyDL2zlH3hLGYBpH3x+jZMzQW6+kQ0mgg3M74b7fXVWWuHeh+9aQKjisJ4p8bejEl6Yr8hg+tFRDkPmkwSIEXgLD31fdqsARr3YuW8pWL5Id4TMsdZ1XyTzkx5PCKKZbufKyOvOeQZ6lAIXdKZuiFMWLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101200; c=relaxed/simple;
	bh=f87g5XGKpDiNIg4A29HJEN/RtcDNEnJ4UbtFk1YK2Wc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ovsrDo2HZAIWOzzUsHHjcyfeBMt47wJOf40aSAr8SX2fybmvN5fmZk0nv7I7tjVNQF14G5GVrteynxQAMRx762y/CD8hfHYsvQSu7v+c4qVWUaSwgb8q/nmefqV15kE8GKiN1dPxR9jEi1f3HzXSwlLJw2Z+Ifk6SQha5LvyO7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vo9dD6c9; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vo9dD6c9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGLk8oTwc3VvqTqdV561i8Dpc1zFUIxv+YTYX8xUsd8MYmpBz5S1PxKSHMayI7oDoiNMYcfcubVNx5onZBvGb51NRp1F2ZHXqw52r+sYa43pMq3ND2henr3RWl+9su9nuIcYWmdWPKVlMMUqtB0WCeUCETtoPK6G/HPn35LdY+TnUVFSweLaRD9I0TLaSXxnTMcnQJ7Umdw07FtkGjERnGgxYUf0QGtZHkQM12YMBbip0qif6iRi6vHJGJ2C68B2sjhUD2XhKQRK3T7EyKrb4BtdBHnskr0nhcUe2lTDdv4yAddQsYJ9qi5sWq/eDfKRIuMHmhRFtXKNvk1ftUfZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lFdQJcRoaXkIieNCrfzlxCCf6XlTXlGL76tAM1tLwU=;
 b=JRpiMetBflIHt8poP2wDoRYiWcQ6O2eclw9NPNWjXte9q7Nxx5XOZcSFgxMx4jsmbdSSp6uLs76mOSqM+iPBViL+KIgdDAkgGRRfmVfDEISe5dncad6GBjOF0TpJl3xg1k6nRSg7l581y7Nj2NuvcbS/NJYL3vfevmBUR+uwrzOPlUAd26WzLve8vKVMhJp1KEXm7Hsgh8biEDMGrJTPpg68SR8377mMxgGbsGbLTaszA0a1QdfcwjBYAEt/m/eIWsMMNRZ5XAW3Edle/WciMhP1yrjAshPXxytx5NwbOKVy7zmGrepzeDILd8NSVdC4WQDLTwD3pvcE1BNQpROwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lFdQJcRoaXkIieNCrfzlxCCf6XlTXlGL76tAM1tLwU=;
 b=vo9dD6c9pd9/kj8I9qTyCeWDKVWIWTMPy43P6pmKvAvPlJlxTuaVND/fq8V4U0YFttcrJQC/ODHSzjHrdQq5mOD2sIHS4lndfr6cphhttP4+EqjHm7Gle+TXwKHMwnseHNg184QzbKKtLJjdsrS3s3pWJwGbWV3UCMZ4IegUY1ZndkpWOUdoSKS/ZSZRLxLfKDJ1CQVXb8yxM28/cx5wxznqvSHvE6M/gEpECevQySbLtQlD9fPOGjZSl4wUayYVByCZ/3QLCF34ZEwCltNLPKeI+HUY34WExT9fo9+BslfmqaovVKXb4f0wokIftbzT1ww7ChDc+dP1iQdHbNCXFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 19:13:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 19:13:15 +0000
Message-ID: <76ed849b-110b-4ec7-9538-e9f762209c32@siemens.com>
Date: Mon, 16 Jun 2025 21:13:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Testing OOB networking
To: Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0uuOi0bW6P-eAW+i1WUKfp4UpWokdPi77HjVt3GyvonYg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0uuOi0bW6P-eAW+i1WUKfp4UpWokdPi77HjVt3GyvonYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6b1f71-f370-4886-16cf-08ddad09d829
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmowamZ4TWVOR1I0bzAxaDg3ekk2RVJtL0Y0Z1l0T3hKUkJna3QrTUpxY1E1?=
 =?utf-8?B?akVzVWNHN2Z4WEpFWE4vem5ISUhZOGhIVFpTQXl2WXpnQnFuM3R3T2N1WklE?=
 =?utf-8?B?YW1PdG1IV3RpSjUxMUFtSDBxZ1lvaU5SR0M3c2VyTFE4U1puM1hFT1JrdUVv?=
 =?utf-8?B?M1lzN0l0eTM1aEhTUHlUNFNMU3U2VjFlSnlpQW5vbWFYRUx6WU1FTlJveG9R?=
 =?utf-8?B?aFVWdDBwbWNHalQ3dElZakJpSUg3ZzhuUEF5MzMwZjZwR0hlS1BkR2lIQnFO?=
 =?utf-8?B?c2NDWWVXM2loeDRQME8wNGZwdG5XSk9jaW5vTU4xVFc3TGVUeFhiUTBSaWM1?=
 =?utf-8?B?WTNZOWZxTWtrcjJ5NWsreFUyVC84dldjK2xRUTd3NnkxanFJZjV1MkluY1k0?=
 =?utf-8?B?RS9pM1JZbkxaSXhoY1lUa1FvY3U2Qi8zU3d6aGVLYnZNSUhCNlBlM2VqRWZO?=
 =?utf-8?B?U2F4Q0JhWWYyWGFvYXIxV2luMVM0b0I5eGhKejljYThlRVk0d2Vwck1VcGli?=
 =?utf-8?B?cVRub2tpSXNBWkNyZEdWZkF6bXNOakFaZGR3QWxmWmRhMEdab3lZQTFqeXpB?=
 =?utf-8?B?M1F0SzJ0cHR6YzBUb2RpZGtoVVJueUNhbDQ2NnhSUWZraUZTanRncS9abjVx?=
 =?utf-8?B?OEl4dlZsck5hQkx2UUdKaytpeTRVRHZyM2pjQWFtck50NWtlMVRBRkxFTktJ?=
 =?utf-8?B?S2FKR1E4c3JKRlJrOTFGQ2dKb2k5RzF1Tlp0ZEZjbGZ1dEhlcytmMTRwSGNG?=
 =?utf-8?B?SkNmNCtEZVRkMHA0TXZnaG1aeHFwbFlqS3kwREtSeUJGRCtYUHBONTJza01s?=
 =?utf-8?B?QzZIQTR2S1J3dVFHTDYzZ3BLdVhldlZTZXhMOW01NjJKbldTQVczMkh3VjFy?=
 =?utf-8?B?UDlKRTkwZ1pSd2tWTExnaWNVU3I0Z1NqODhjVUJCakI1ZWVlaUdGZ2hIYXpL?=
 =?utf-8?B?RXpsem9uMnd2ZGl0azRQZVpZZVg3WEJkaHNVdFVHQ3Y1all4Z3M4aDh5NU9j?=
 =?utf-8?B?TU0zVlNsZXg3S2xZNVFsV3daUVVObUordmdtTmN4Q2owOHdRS3VHbWpNaWVE?=
 =?utf-8?B?MWtROFo2bWZZa1BQdURLT1ZTbnc2VUNlVCtycWlvbGV2aVNMSUJQRzV1cC95?=
 =?utf-8?B?UjQ3TGpGMkpvN29zdXZvZklVaDhibkM4NmpodDN6OEFzTm44L29iYVN1M25R?=
 =?utf-8?B?U2pINTA5dzloV0h2aU5hRk9Zb1lJaGNTY05IV01IQzRPWDZqWkpDSFNaVVpP?=
 =?utf-8?B?ajRCaTQ2NGR1QWhtTVhUUThzWVdZZW5SU2YrZXFnVjdEM0M5R2ZFd3Y3Rk5S?=
 =?utf-8?B?bENqbXZObEhxYkN6b2ppa3BzcUVsVUVTbnA2SzRrTW5PSWtCNU9WNW9wS3VT?=
 =?utf-8?B?b2dORnpNWC9CSmRsOHdWdjRXNEp0RlF1aVY1aUFaK3FJVUtwVlVRSThqM2sz?=
 =?utf-8?B?U0FSOVJ5Yy9mb3lDZUFtQmpkbmJwUXhSZEwrc0lnU0Rncmh0cjJhVlhoV1R5?=
 =?utf-8?B?dGdUU2svNll5ZXRFL0NBVVFEQzc2Ymd0MDFCd3hxYStHaTk2VUJteUdReEIw?=
 =?utf-8?B?eHdLcVhLR2them5XekdKRGlqQnhKMGVWcFQrVG0zaVQzbEVnWjJNRWFWOGg5?=
 =?utf-8?B?SUloa2lwZzh2b2lDWVNvYlpYOXNGaXp2VUVOM1RkUTlBY2ZRZWYvb0xQMlpw?=
 =?utf-8?B?NXBrNkN4WUVMTXBzVzJUK1NIT21vdm53dGNPK29qam5uck9SM0JtSm5GZlVZ?=
 =?utf-8?B?QjRyQ3FJSUMzY2RQZ1dQemxpb0F0S2RCb3NhU2lrdEw2SVpKRzVMcHFmTFBT?=
 =?utf-8?Q?PkHYelLEA8PbDsO1CSJdx8mxu76qcZtF7gi2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDg2UGpXR0dPclpFNCtuTUZ4dXZKSlpTODR5dG9jRC9lcGt1cVVuT2JGWktt?=
 =?utf-8?B?SGtqcGZPbWNYNUJvSjVNdzN2VEpkKzZrdk1jWTZIRGFoSzNnWmNEZWFuUUR1?=
 =?utf-8?B?czRiVVBwOFRCMUQ1Q2dkU1dZVXdlcXlqRktoUk4rYm1YUDF1VDJ1UFFocTJo?=
 =?utf-8?B?TUdNZXVhb3ZBNUdUZ0lOVU1KKzNpekVrcXc5emdHc2NuS0M4TEhrTzBVZWI0?=
 =?utf-8?B?a0tGcEEyZnFINkxPRU43SDlyYUVySkpHL0o1YWdYb0hHOWxnck9qU01UaUd6?=
 =?utf-8?B?N24vYkRYVmdLRWx3b0tFR2IvV0YxS3Jtc1l3TVdWbk9sZWRsSXBaTkNFaXRK?=
 =?utf-8?B?OEswTFZKY0VWb2UxZW9lTk92TysxeDMyK0NSU3RFNHpicTFadVQvMlZCeHBB?=
 =?utf-8?B?TmlPUjJFWlN2NlNQaHlOVlVtUFRxZWxuSUk0SDUvdU4vSEpmZjllMGptVkF4?=
 =?utf-8?B?dWFNSkhuNDdVb0ZnRWhOSXd2V3FNS1dlOUI1bFBZYXdvSEQwdXFSK0NReGRm?=
 =?utf-8?B?aXNyWHRpUngrZHpjQmhBZ0hmVnFpd1FYNzZkakNZSkl4TEVUazdBd21yWEFM?=
 =?utf-8?B?b0UrNDBhNDRjOVFnVWxRRExwTTZjNmZ0S1BDd3h5ZVExZUJsbDhCUHpuK1Uy?=
 =?utf-8?B?dGlzOFlLRWhVMkpEN0Vmd2JaU3dEUXBJTUhFMHpLdDE3d2YvTytMU3Rzckpl?=
 =?utf-8?B?R0NTU0FIUWxSZG1jQVRjY04rcDNHTXYwWHAwY3o4SGloenltMnRTRityYU1k?=
 =?utf-8?B?bUc2VFQyemNTWUNBK3lXVFdDN2EvQ1JvWU9KYmN2a1RMVzhDM0J4MWo2MFhu?=
 =?utf-8?B?QUtqYUdhU1N0U0RxMEs1d2Z1dXlUUHJCY2lPZ3hIWFFOcTI0YWN0VWxMbHpm?=
 =?utf-8?B?WEJWQ1RIMng1ZFFzc2dENStIYzFZdGRFOVBIN0MvQ1FZRnZ5bGxIeFBoN0V0?=
 =?utf-8?B?REJJRDgzZldmdDZNRy9WL1NsUlBMeFk2dlNjWmJ4TERzNzVKamNzU3lUeUQv?=
 =?utf-8?B?Zk4yemxUZzY0UWFVNWpVMmdoSlFqNmQyOVhQT3Fnb3lnNkJBSnNvVTBIWWVx?=
 =?utf-8?B?Y1ZrdlQvYnBBbmoxdFRTcDZrdFNLYjRFSWQvem5Nby9JcEhobmJJeGFpYUgw?=
 =?utf-8?B?SmZhYzE1WVRIRFM2QTVtQngvQ0dvUVBBLzF5TGIxUSt4ZDRuSDJuL0FWNllO?=
 =?utf-8?B?WUNKU0krMjg3Y3Zua1gvbW5jZlhURS9maTNHSlV2czByTzUwOEpoYlUwYlNF?=
 =?utf-8?B?VHNCZGtTRzVuWlozRGJ6S0dJUDNrM1Z0OSt3d1JwQ2NHQXNxems4bmtoTXdy?=
 =?utf-8?B?Q1F6cmxJdzdvYXZQNnhwQU5qRG9OSFJra2RFTXprRXFpeW16S1Z6S1dNUlhm?=
 =?utf-8?B?SCt3ZkowWmJQa2IvSnMrVlRvL212c29OTGZob1VidkIycWRDc3VzU29md2hQ?=
 =?utf-8?B?UUlod2JBemo0L3gyYVlkUDkwdm83dVJhSHNsOE5CMG1XTFVIcGRYaDA4T0d3?=
 =?utf-8?B?VWJxWlc1V2pFSXo0dXdxdkJyc0tHUU43OHNIMXZCWUpJWldoSWpvRWMrNVhK?=
 =?utf-8?B?T2NhcnVNOWY2Q2VvYlMxMHFlVnJGVTBGYjh5OUdscU8yMXU3dUVUSUxBanBu?=
 =?utf-8?B?UGRRUnB3M096Z0h4R3VyY0ZLVE1tMDRRdXBkZWtTb25DNnpqN2JleDFSZGw3?=
 =?utf-8?B?amsrbUI0UGxZbmdWeFpPa2t1NHVXU0dGLzZodnM4M0diTDlIUnRnV2Fhczhp?=
 =?utf-8?B?eENydFA4NXpnRVVURXVINWxYM2dVUzdaYnZ1Q0VvQXRYYU0wb2txNlJsWWVh?=
 =?utf-8?B?OHBPT0hCc1dnMHZrTnVYRTF5aWhsOFRQMlJkSlBVWFNvN3BIT3hmTUpNNHlD?=
 =?utf-8?B?ZG0yVERVTG1lZ3REZHc5TzF2NVk5bEV4Mmlhd1BjZTNnSmZOQ3BVQUJ3UWdq?=
 =?utf-8?B?ZmROalVISVRYMXhNNG11S3h2QVR0N0d5Y0pVS2VvSSszaFV5TWF2SXBUYm11?=
 =?utf-8?B?V1dEUkRnQVRRU3RXZDN5ci9NcGdXbmJJRWJtamc1Z01rRzc2T216RlYvQnAr?=
 =?utf-8?B?MXNnWDRnd2hZbzZRQWlyM3R5bTd3UzdyN21HZ0ROZlFha3RENDFiVEFtVklp?=
 =?utf-8?B?QkdwQnBRd2FHQ2dwQ1BOT3V6UzhVY21EcTE1Qlhqc3U4V3d3bnpFRUswandN?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6b1f71-f370-4886-16cf-08ddad09d829
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:13:15.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeyAZR788IVU0zqux3Onj+oNVtBH5ruoPQyfS/fjmYeX371YC1gT+rHzQMBJjlij2P50PMa5olLFKH7Od5Q0hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8123

On 16.06.25 16:47, Pierre FICHEUX wrote:
> Hi all,
> 
> We would like to test OOB networking on Xenomai 4. AFAIK it's only
> available for IGB and FEC adapters.
> 
> What is the best way ?
> 
> - Building a Xenomai image with xenomai-images (x86-64 EFI target) ?

When doing that, double-check if we already have all required config
options in the kernel already enabled. If not: patches welcome.

> - Trying to create an image for iMX6 (not supported by xenomai-images) ?

The FEC should not only work on iMX6, but we have no ready-to-use images
for iMX8 either. See https://v4.xenomai.org/ports/ for the boards that
were (very likely) used. Adding some of them to xenomai-images would be
nice, but as we don't have them in our automated lab (and/or in hands),
no work has been done in that direction yet.

That said, I cannot answer which option has, aside of ready-to-test
images, pros or cons.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
