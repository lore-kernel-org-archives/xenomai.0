Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F5283FE5
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577951; cv=fail; b=Usy+/PgnC58KiEBBJx7BQ4t2xttcZupzUXH4I6/Rg86By5MBHL62ayCeVu14K7ZT9GOY2SiJlZuHgtUVqRNmVqijtD9rt68q+vfObdh4DyQPUqHP1vt9DoqXebTwjcsy8CxRL6aDVyCaE/rz01ePktVP0XGwyXBxyOeXj6jkrj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577951; c=relaxed/simple;
	bh=665wgSh5Dyk6SZ4jVbRHYo4f10M4it1conhsM2NYBTI=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XGQIcVwst4BXZII9ow68bLi5l+yYvarYU/dRtceiRMkHhEzVM1vlpuVz1kxl3SzWK3zvAICpyqCZTXaOz5D/g8tjyzFyi59bbcoaMPInAsLJE6K+LXEAXPPPp5eSyH6Tta+KB8ExdQoZ4GTIH11TznzQUihuQ3I1BRIb9LOlfOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oz6yREd8; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oz6yREd8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkqsd50PLRpWaQiBDjlhbKd35rCYIBTEm5K65bNsMDoEjyD00ffd0FIVHjGO+AjRprncmHu53XxbsVP9FQsdkEnfN3TkdayYi50eRsH4utq6gyle+PzuIxB7deHpTkdgtlIA/DZwYtC8b6OUxDL4s23szzhNZUYEaGj9TfOBbPY+5S7m9eX9fOZoORIiXD31yaB0rSAjzrOdTJF8La66Z0K+8rlZEU2ubcdUHVEvuH3pKvgRid0yfPNdMLLxIAFLXWN26Yie0vX41Js1Bn+b85N6sP9bdN+sLH/lQTTghuZXYb+CwveUh0NNYl+nBuDY8MVv6sHjcSyspMpqDxJYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky4lQtqMnNdXiXHwv4b4/HW1EvaxZm+xhZkO3v9tAkE=;
 b=Px3std0y5f5MPmuzGrDYbUmSWxrzcQOA7hwBoD8rmDe1YwW1jXV1flMH7RaZ8uGwOiurP0k4Pdp1wC5LPF6y0ZWelXLzrjoFaEVE5iKGw5EkLfpc1I9W+38MH8iYumAmhIcviigWqbNK1FSwylFUwfOSkPsKYr0V4UzuA3p5+cWWCmm8pNqdWVLHxu66/PJtIKU/7+h9EhJsyZfWf/oeua4739BPghnV/NsYxtuZOB1vGNSSbl2TI1xjm3W9kZEi+slmtWcBtWVb6626v3lLDY/t8F3qUbsTGWDTUk9i+pZNnsDeDYZEAuULcON5w0pnF2d078gSBA/FMGLvRr3Ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky4lQtqMnNdXiXHwv4b4/HW1EvaxZm+xhZkO3v9tAkE=;
 b=oz6yREd8bVi6R7J+5Z+V6HahopdDIqu+CFN5IdnJ4N02FIVrm6NhU5ScV3QbCnD/bsRgP+D6VDF2s/qqvUksrlZ8ApSQDMBg8q1P3cGxTdJyYRgYTM8LF5qaz8drPllaj/x+JHlGMrqtJOiMfcjrxg2u1ijKswWY9q7zjiM7osp2N3oRuO1tZW3hgkJJkdGmaegF9i9+Nr+s93ihplQ+O7+FDI25Tnt9pkSTm9LzDWpck7Z8TBQSBlAO+n7wNtYy4GhWMNKVMq5IEJ+gWX1ByfkfJzqFrrfv/G3g2z0vhfjak9EF2lSrbiMAfK/wjrM+mNb0G/FQ+3H8hSorm9qbdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:504::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 15:12:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 15:12:26 +0000
Message-ID: <5a9556df-ea96-4ae9-bb16-49c9f2bd6905@siemens.com>
Date: Mon, 27 Oct 2025 16:12:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.16, 6.12][PATCH] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
 <b69ae66d952499212dbb2ef98e3c74c7ebcd0933.camel@siemens.com>
 <e8ea8a70-2d12-4ed8-b54c-ef8673bbf999@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e8ea8a70-2d12-4ed8-b54c-ef8673bbf999@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 377f5239-9be8-4f6b-eeb0-08de156b3d41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWJXUGNvaWQzdWRZWkx2TXBUQmdsWURzQWJZZVVRcDdUUjVtZVRNVEt4bHND?=
 =?utf-8?B?SDd3L3J0QVNuM2pRY0F0Y1EwYW1mU1JpN29KYmJDbkwyTk4xbEdaRWJYMXFr?=
 =?utf-8?B?UDNzemVzS3liU01haEtBRjNNODVEaC9vZG5oR3pZV0VWN0NRb1pHL3VTcDZn?=
 =?utf-8?B?YXZYL09HZ3hibVRDb0wrS2poa0FsWUp5MGdEaEpkSVFUUkZxb0ZaUktzSzJ3?=
 =?utf-8?B?STIyM3lFbC81R0ZDbStGQm5uMEhLS3FnM2lXelpoR2tQdlV2Y3MrYWVmL3ZU?=
 =?utf-8?B?dk1iaXlWa1c2R25Qckc1SjVXU0haWWh3VEVCaGpFZERaNWIxSnlicTJvc3o4?=
 =?utf-8?B?QjllWVNyU1BCcmR0RnZIVTU2ci93VFF6QWJjSjkrNUIzZDVKSCthY3hPOXlV?=
 =?utf-8?B?bml0cGZzRWRFc1NuQUx1YWZSMWRIZFVrRW56YVdXNG53czVYc2s1d3EwZDRo?=
 =?utf-8?B?K1JxMkJKM1dZLzNNUmhwMnZnYkJCYVZQRTFRZ291Nkk5UG55RkNWbWFTaVcv?=
 =?utf-8?B?VjBFQTIvN2xtZFg1ZEdTVjR5YVdPa0xaTXJlWG1FYi9PMWxjK3FkREw4UHY4?=
 =?utf-8?B?VDhiZjlqdVlXWlA5OW13ZlpQMDFNUWJwbGFFclgxUnlETE5NRitrREZ3dFBi?=
 =?utf-8?B?blpRMVluRDU2alhCT3QvOFgvSlh1M2twMTJTZHViY3orZ09xdWJjM1pXMGdv?=
 =?utf-8?B?RUprWklLaW42T2hHaWtWOUZQY3RNeDljUEV6Ry9KVkJmbkJEeUY0Ums1S3lI?=
 =?utf-8?B?VHBpbzI1MHdWK3lLSmllVStIVDR2UWlHbmdXcHlhdldJeXBIMFpEcDhxblAz?=
 =?utf-8?B?OUtvbjNtWSsyYUEvOXpGUlFsZlJWL1pHUnBLdG5KeDVXMU9wdGdNZkxUSmlZ?=
 =?utf-8?B?VWt3ZUxtU3JQZkJRWEU2TnZJbklObkYyV21iU3FTVjdDNHFydkhvekhWbTJE?=
 =?utf-8?B?UTR1WWFKUzhTZ29zcHdSRU8rTTFONTRBTHBXK1pKYWFGaTh5SFZDSGt1dldQ?=
 =?utf-8?B?cGEyWkRxcHVWcU5tU0o4WTJ3MTVZb3dwN1BDb3pld3c0SFRmOUYxdWluRXZE?=
 =?utf-8?B?d09Wb0FBS2JDSEdWbjdEOUUrdk9qSHVtZFplNGhQbGNydGNlaWZYZkVtL0V3?=
 =?utf-8?B?bnVnaHhVMkVwc3Fnd2dSTnQyemZjT0RIMlIyS1NNVjZaRHg4a2RnL0J1ZlhC?=
 =?utf-8?B?SlNNZHR6NHFzdlZQdC9WR1huNXVDeTFHMnkyVnZKQWsyVUFkbzMwTTVZQ0NT?=
 =?utf-8?B?eVNDMmJNK21FRHc0bEN0WStGSnB1QkZuNUJlUmZ1QWdESW5XRVVCQmF1VWFy?=
 =?utf-8?B?b3BLOTh3VWVJUktkdEUyZ002N1h0ZjB3TDE3cVZhQU5LMi9iR3owZmJzZjBC?=
 =?utf-8?B?R0hUTjRNYjJ4ckc2Wm8wVHN6dDdnUXVvTVFDcDNHT2YrSmh5NEJyTkljSFlm?=
 =?utf-8?B?TnNLeWxBaVZncTVVT3Zna2tWMzRwL2NjR2Qwa1UzRm5NanFCeXllUmlhRmZV?=
 =?utf-8?B?SUNBNTB3c3VjZzFUWGdvcjd6ME1CUk9JVkJUM3pCZE5PbExiT0NOQW1vUmd5?=
 =?utf-8?B?RlBUUVk5WDhWVWhLOFQxbU8yLzJxTnF0S2p5eXVUNFJ0bDJNLzIvZ1hhRzNO?=
 =?utf-8?B?YTJNSjcwcXdYUjBMU0VxTXdlTmFzem1EWm00TUt5KzB4cHlkcEo2S0JvYzVE?=
 =?utf-8?B?VWFQaTI4M1h4TkQ4SkVndWJUQ3hUMVNCVDY0U0pkZExmRG54ak1KRExjR3By?=
 =?utf-8?B?Z09QMFdBVFFtZHFCTDdJa2c5VkdCYUYvd0x1ZEk2d2lGa3NraHFrMjBwL0pQ?=
 =?utf-8?B?S3lCNHhQeS91OUlVaUZ3ZjJINFBxMzFHZ2s1WnlrdFpOblAwOUNyVG5xM0pt?=
 =?utf-8?B?K2NuSlQvVUFmTEVJUkUyL3RrZ2hpdURHVmNBRThwaTJ0WlFpcnpVbHozeTBC?=
 =?utf-8?Q?Eg9V9rFPpQ11jFBTLepA+4a9Iou3Gdrv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW80U2F4Ny9ranZBU2FVNmpOT2ZlZWNDdVFkQU5GWS9CTDVvZzViZm5zUzVG?=
 =?utf-8?B?SGdJMDJwTFB0bXFzREZNeUxVY3dnQ2dhV0VLWm8xOHNmZ2FRM0w2eWROWWd0?=
 =?utf-8?B?bmNxLzFSQ1hYMFAzNEJWT2ZYRHF0aWVqcjlDTDRjdVY3TTh4NXI4NFB4Ymxh?=
 =?utf-8?B?V0dET1l6eURZRjZ0bjRYR1pRTGwvc3kzb2FINS9BbEN4Ym5oeVdNanYvS3pZ?=
 =?utf-8?B?KzhzbXBCVmlTbTQySG1YbnhNUVZjSjUreis1WDNpNU9JY3IwZk9WY3BmZ1lm?=
 =?utf-8?B?Y21GUzJGdzFIcVdNUlNFRG1MTXpxa3JPaVBXdHZoYlVTSVlSeGpIUStSS0dP?=
 =?utf-8?B?SDdOUkYzMDZUTmU4Y1FFVm4zazFBRy81QmcxdVkwaFNWWXdzUHNxUkR1WVVh?=
 =?utf-8?B?ZzdvWGg3bUJLZERqWklQQ0QvcHlZNlVBZFFrSkNXRUNPaVZSZDBpcW90MW15?=
 =?utf-8?B?blAvOENPd2pMZW5RaFBrUzRTaWlpRzhkL1dFR2JaT1JQeVRZUDFZRVRYWEJr?=
 =?utf-8?B?b0gzcDgwckt1a1g0T01DTFBubDlvTEVOa0oyakJZU3hTR01zNUx3SzU2MGo2?=
 =?utf-8?B?M3NiTVhnOERNekNaa1ZJZzQrdkVONXJ0NFhIU3MxMGFYYTEveTI0RGk1VEJR?=
 =?utf-8?B?TGY3UVgrUGRlRzVhL2sxSFovR3RXbi9nWnd2RmEySXNMNHpQYXE1UkNiaXZs?=
 =?utf-8?B?dURHeHE1QS83ck4vU0Vuc2RNd1BJTHRJeTdYNzlXbitEalBPZk1QcE9haWNs?=
 =?utf-8?B?aFVEOTVubU9iYjVNdkh4WUh5VFUvYWIxRDRIdEErWFdRMmFWZHZQdjF6MjJM?=
 =?utf-8?B?STh1VkhJM2hsMTMyQ09ickhHVG1tb2RiejlxRThuU09MVGlQck05VnJJR0hm?=
 =?utf-8?B?Zm9IMHJGR2c1cEFMbk9iZzdXTXA1djJyd0xqVkdFM0hLcG52K3VNbDM3RXhJ?=
 =?utf-8?B?amhWTnYyeVVuSU0xQWtnTTR3R2dGeVkvK25iMERxRGh0WktpbkhybjdSQVp2?=
 =?utf-8?B?YWRpUmtpY25zK3JFTzFSSDNONy8yWkp3M2pqMWFsUXc5MFdBb3FMWUZOQUtO?=
 =?utf-8?B?aWplUzU3bzJMdy9va21uYk1VUXVESGZZb0J6ZjgyUU9kZlFLNlcrQmFHZWxN?=
 =?utf-8?B?U25TclFteEF3TFNzcnVJcGtqclhwaG42cnhrVHcxbHBWUE1XeS9ZWEJadmpC?=
 =?utf-8?B?OGxKM1pOK3RSTVRzR0VWWWxoRlIrOTNldXNiTVlzdDFFRENNbFlQM1daMG9K?=
 =?utf-8?B?WkFVTEJqaEppaFVaTVZJVTlPdHNBM2RaL0VHcithZHN3eGxIcjZ3QTdPSHdr?=
 =?utf-8?B?cUN0cElaOVFtLytZS2RRc3FKSVJwR282T2FKUzJYVFFPeElDNlh0NlowSTNS?=
 =?utf-8?B?cThLRXNjOEYzcXBrU2ROM3h4NUd0amg2WjEwQlVvMFpObjhDeG1CbXpxbC9S?=
 =?utf-8?B?Y0ZvSGFzSVZla2U1YVdaRkt3SVlWVTAxNUI0cGJOQU9sejBNaTFWd29QaGl3?=
 =?utf-8?B?dUdLSEJkVGZJRnliU0pZK2VIS1VwTldoWlhLdXlNU1crSnlucWh6dzE2VVJI?=
 =?utf-8?B?UDZZWGhjNTRtdWpqdlVXSUl6MVMvdmRFUS9adWJ6dzRjeC9NMHNRNEtHbXp3?=
 =?utf-8?B?UjU4K1pWSUhKQ0ErZTY3Tkh3bFEyZ05DNzNBT0lmRHJTbmV0TTE0dWt0MFNu?=
 =?utf-8?B?QllZd0VINmVuTkRqZWxudGJsV01kcVBaYUszVUdtU3NOZkZXUUVuUjVsaTN4?=
 =?utf-8?B?cTArRDhuTUF0UE1wTUc3cmhQV2o4MXdWVC9rWDBuOFVsL2NzTWk1QmMzOGZ5?=
 =?utf-8?B?UTFIeTZhcklYdHNTYlpRRlh4bW5QY20xQitHQUxMY3Z1MFdLT0lPZFZHQTdH?=
 =?utf-8?B?R3lRenFwMFRxKzE2MzZGZ1dNK0JZWFlZT2o1R0RMcldCS3pBVEgwUnNab3d2?=
 =?utf-8?B?SE9DRlc0d2MwNEFPMU02c29IZXhJdUpiVEZWblczUXR4eEZDUlh4enNkOGRK?=
 =?utf-8?B?MUYzZzk5VGlMYzNxbFBuckNEUWplamNlK3dtUFdiTW5sN2g0dkxITGd1dWxj?=
 =?utf-8?B?UlBCZlgrU3VLUFZSSVJlZFg3U0tkcHNMNFRGUDVUQlFZT2QzNVhDS3ErNkwy?=
 =?utf-8?B?U29WYUFQM2dndXNVL0FQQXR4Q1lMTlY5NHpVQUpwUElKK05nWENTVlBJbGJL?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377f5239-9be8-4f6b-eeb0-08de156b3d41
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:12:26.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v23YBrp4Fjfzfy4yaxgWoI6FH6N08E+cLZZ08DLFo2yBj7ujDaC9sGsXLOvgt3fng8V9GM6NOUsmNiltvPPzIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6329

On 27.10.25 16:10, Jan Kiszka wrote:
> On 19.09.25 08:40, Florian Bezdeka wrote:
>> On Thu, 2025-09-18 at 18:25 +0200, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> fpsimd_save_and_flush_cpu_state() itself does take care of this.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>
>>> ---
>>>
>>> Changes for 6.1 will look different.
>>>
>>>  arch/arm64/kernel/fpsimd.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>> index 1f5fcac32b2d2..21f8785948ca3 100644
>>> --- a/arch/arm64/kernel/fpsimd.c
>>> +++ b/arch/arm64/kernel/fpsimd.c
>>> @@ -2110,13 +2110,9 @@ void __efi_fpsimd_end(void)
>>>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>>  				  unsigned long cmd, void *v)
>>>  {
>>> -	unsigned long flags;
>>> -
>>>  	switch (cmd) {
>>>  	case CPU_PM_ENTER:
>>> -		flags = hard_cond_local_irq_save();
>>>  		fpsimd_save_and_flush_cpu_state();
>>> -		hard_cond_local_irq_restore(flags);
>>>  		break;
>>>  	case CPU_PM_EXIT:
>>>  		break;
>>> -- 
>>> 2.51.0
> 
> Philippe, this cleanup is still pending, applying as-is to
> v6.17.y-dovetail-rebase now.
> 

...and v6.12.y, of course.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
