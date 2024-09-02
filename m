Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40D061FEB
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274266; cv=fail; b=q5H+KJ6jWvLj6W3PB91awfnWKM/UelYOrwi/JdzBcWveQ/SrdEIw6W2iv/tzYTq0sT/ITlcz4oNrLMk4KknlY6E9vC7vFZth3R/yq/+wOW5QHcc/K3+C8W2CF5g3iVCmdpka7UepQobRA+sG8DBT9t6Nha6WRKrWtiymZ103gNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274266; c=relaxed/simple;
	bh=6siqHZ1NB5jARu5sLucT/RjuHYKKJ9RFiuupVq+tghc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JjPAPGF58iuv4q8TqY+CtuSo8p9jQTQbHpygGkF2r1+iseFQtb9kn1T4tc/Pa9nPM6UEx9vEDka96u55FxN1rzETixmOFrgupzUfFvrLNXq2dWX2TLqfy/u3ApJYIYei1O/ym+nRs6E1XBJA/0BkyK5+nL0+TTiCGxpcyeYI//I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ils9OS1l; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ils9OS1l"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 00AC380002
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 10:51:01 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::62f])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 33EDFAC1215
	for <xenomai@xenomai.org>; Mon,  2 Sep 2024 10:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnJ2ffqbtMQvGVpcz4cMl7VM3xc7/P9oNv3Z8Y9SbJaGRZYel5kubj2dreWzNxeTMeryR9GcZIOThSS1ojIuIxI0Ip+eiB/V/H5ED+5mbSV+H2wYtiGCF8qMRM0ILCErm0gK8pJ6DnHi/tesTG9oIJe3IuWI0tgM9Sl4NRQFGGeSq62fWs5X4aYxCw/EM3mfa7egu2bNZRqPSVSP+OKFSbzRvSjvvS+LYF598kkUfHl35lWnuBfVuT3JXlf6zqGOJURjYRniZt5Nj3pftLiMXgcoWhm09nRgEDeKo5DGuiQB42tt9o+TEsgCBA1oOH6bWdhbNmh1zKEEwrdcUlaJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGhweTKay0iZbbTeI5a4Edsc+7SX8Qk8suq0BTu6WXc=;
 b=J/FlzeC+BuVCbD02DkjBVfaBn/Kz4iLdAVv9cTTVGTsVctmV2mR+OwDdXT39S7LWEQfnjwXx95YX8euK7L1PW9fGVbZ93LK6glDZ0pmssl6TVXd+EuH27uMc9xOsTq5HkvxPo/apEoNrLyWWEo3XHNE3NzUvpYVr6/Ne3WI2xEWvJhDingyNBOa1YyZuZpU6KuggozGPWZIDTBjpZV0+8HmfRAGeF1BJiQSLhWs//mFFDRZKv3PY16gvqBGuXVyTaCvMqvtySv+NKzMSoPNutkb78nXFl5skR9nsITXcvU0+/ufpI/l5Ad0wsHfgK6O0hw7l2lYAhiRqN8G3o6TwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGhweTKay0iZbbTeI5a4Edsc+7SX8Qk8suq0BTu6WXc=;
 b=Ils9OS1l8YMc5ZSwRp0LxQDAFXc/RcWFy632al0F9KvgLVAJACmpxfI2sOeAJRE4qdWpg8e32tj+vI022WlpdwfQQz5qBEJjBeNv2JBaW6tYwcQViFeJqfmCcDRLdkp+OQ/QZOfzxGAtzNK5lxNTwvYcTUuy3aFS7FLBuKfUtEHRR1hJRaM4Vtli+S3PVRTH7cEPCNo/rjdQs1mSYIEufEUrrWE3SSJHIZCNcyfnWQYJWVTSB6dHnvs2cXPjXfGO+y8kEG34bppUHzXSDUXY1a4cT097wETZSylDPpuwcCg6SUCB88NpQgRb7PNoMR0WNtTr5o4H+oX6yVnSdwqR/w==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3665.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 2 Sep
 2024 10:50:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:50:57 +0000
Message-ID: <212199c4-8566-4f9f-a2c2-2eaba99a6d1c@siemens.com>
Date: Mon, 2 Sep 2024 12:50:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: xenomai-images for Xilinx SoC (ZCU102, Ultrascale+)
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>
References: <CAFc1U0vFRz4E11z7v+kL=_E8NsNJvAsXvc3qmHBSzpnKzNfpug@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0vFRz4E11z7v+kL=_E8NsNJvAsXvc3qmHBSzpnKzNfpug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3665:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ae4543-ef2c-4172-0055-08dccb3d2018
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWlJbTBwSzBlaTZuOWNFSmpNNzFDekN1d095Vi9vczR6bHlGNDA0N3dPSDYx?=
 =?utf-8?B?cU1QYXVYbnRPemdMUFduYkptZ0YweHBhNzNSbXBzckpTd1BrMTZSRE5KOUxl?=
 =?utf-8?B?UGtDM05ZKzJuSHJadjJCQTQzM3c1eWVFMXhVL1ZCdC9nTkJjV2JLM2IrQVVI?=
 =?utf-8?B?VGZwZjNubW1CSGRPS3F5N3lPQjFRN25nV2lKVW1vOHVQYkZrOG1wOEprSzZB?=
 =?utf-8?B?MGJIVkxKVWZHWmRibC9jcWVvblBJSEhxeXZYUHdiVjd1VHNIZ0Z6dHlVZm56?=
 =?utf-8?B?Uk5FT3BaQXNCeXRmcDVlTU5sbGR5OC9McXNHcWQvNmdGV3cydUVsUzd3Z2Ny?=
 =?utf-8?B?Kzl4K1ZFR1ovdXlaSXg4SFN6bExVZC9xWG5objIzMjNJTlpIY2d6c3hsbWNL?=
 =?utf-8?B?alFuYWtVai9oTGY1dGY3b1pocnpqckZ5RGUvTHBnc054Vk5Nckk2Ykh4Rm5p?=
 =?utf-8?B?cTJycjhnbXF6bWMzUGQyK1MwaitRb1ByK0VCR3BLZ0ZDRm9GR0pVdVdVaEF6?=
 =?utf-8?B?dHBoOTl6ZjZBT0VGVWk5S1hMZ1BDUlhsSExKWnl5eEZkVUtIY3lqRit4SXdz?=
 =?utf-8?B?ZTNXWW1LL0luQzJodmpJWVVOMUorK21hdnBxaE5GM2lhV3RWeUI0WFpDZlpl?=
 =?utf-8?B?ODdxd3JmT3k0TGxhVUtyN0tMNW1vUk92cmR5a3hNVjRRaXZ3WGNKK1pjUjFa?=
 =?utf-8?B?UDJkbkdadjVvZlpLQVl3eXJ6cmdXL05EUThCdWN6VGtmd0YrQkx0V3RXamlI?=
 =?utf-8?B?WW13YW9WbExiWXhyNXAxR25vYnFOczFQa2pjclZWMWV6UDJ3TExZZURKR2pQ?=
 =?utf-8?B?QXJVZERuQkkyM2Nna1hpOGw1RkxLNXdpWmk1djcxSzdBRTZ1cVcrU0t2SU8z?=
 =?utf-8?B?Z3hLVUdnYU9qckFHNTFWRDJ5NVJjY2pjNkIzeHhGTHNlUytLeXJJYnZOcXRM?=
 =?utf-8?B?UHcyM01qTlFsZjI1TitxVEVIa1NSdmxTdktPbW4zTERYSXhHRXlZc2NGelh5?=
 =?utf-8?B?WEFFSlhQaEtodENSOGxXd1dXN1JrNWdYcVEzOXJvTHJLVVdvUnFyRXM2d1o4?=
 =?utf-8?B?Ujl2czl5eWtXZlQzRmZmS0sxN0YxdUVWR3dFbUlxNWNzQlg3OUxNMVIrQW5t?=
 =?utf-8?B?cGFpaDZaN2VkdHlHdm0zK3RIK29qbUpDZHdvb000UTJkN21JUHo0N3M2V0tw?=
 =?utf-8?B?OFZzaUhoOTB6aHRTbG1OQytRZFA3eXppWVR3KzdRVjhKODdhdjVjS1VKQVFW?=
 =?utf-8?B?Vi9hTURXdG1XVTNFQk1velAycW1aVFd5MjRlY0xwQTFvcDZYc0VUMGJWTEJi?=
 =?utf-8?B?OUY3ckpKWmdqNzUwWXdHUkNpNkdIOE5FOUVOakVPK3JubTNtaVZGRzlSWnkw?=
 =?utf-8?B?QkdacWI2ZFFjdEJpMC9aZ1kwNGdYY3l2OHNWLzVPaFZ1QlNmOFpqTXdMSGZj?=
 =?utf-8?B?WjVBdHRqTFo2aGw5dm5ySjNMQzFta3ZhSktTNVhRVnhYNUh0SG85ZGkvR0RF?=
 =?utf-8?B?VHI3M0RvZnV4dmN3dHVnUjFyS2F4Z2dhUUlYeVhYMytFVEl0WXltc0dKNmJa?=
 =?utf-8?B?UExxa0VBcFNaT3dNNGxXWjJPY1VmeXdnRHhJUDZRNFNkcm1IY21iZEt2NTRF?=
 =?utf-8?B?eFFxZWhwNFFyMFl6SlhxTFFRMjhpT011MzY3c25sb2VVNUxLK3p6MkFBTS9Q?=
 =?utf-8?B?WHN3MDNVdDc2NEhWbW5TaW5VNTVOK255UGtlbThnQmZ2aitwSUVPU3VxZko4?=
 =?utf-8?B?aW94YzFuZmRmay9xaE9vZk9DTFFjUkVaRk1KMUhLMlc4ZFdXLzl5dDFwY04r?=
 =?utf-8?B?bFVZZWNQV3djMmNmN0tNdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnN5WjhiNDJhZ1R0OHhwelBOZ0VGamxYb0dkNnlGUzBCUXBwNmpTRkVld1F4?=
 =?utf-8?B?WkZJdy9oVGtTTXdPZzUrRGxmMHVHcEQvdFQ2dm1CcjhHZm5NTXRtcUlBZ2N1?=
 =?utf-8?B?dmpkakhCV20vamNLamFYQnU2N05LUk1kcGJCbURTNmZwbTgrV2wzRS9HTWxR?=
 =?utf-8?B?R05oay9XdkdCd0g0Ymh2eC84cUU1K2NGbVRvaXFZb2kxckxBMFNlTnlueDZ2?=
 =?utf-8?B?QUVpekhIZDFDcUc1RC9MdHo4cnJUR2dscmdveFVtS3JEYjk4Q0hkV1MyVXFU?=
 =?utf-8?B?TlB0cy85bURSaVc0WHI4dTdrRjhvWHJYZlZZeCtxU3RSS01ZMFczKy9NUFBR?=
 =?utf-8?B?b2VIdmhYQXRLSytWVWRtYVQrRXRtQ2lFMWIrL2RGVWd1VmNLSHNkczhYZzBk?=
 =?utf-8?B?VUJ4a0tlNk5JdGRlaHJaTTltY040QzBwN2dJWHgxWXY0dWdyMkpFQXlEK1Ex?=
 =?utf-8?B?c3BTUlY4VEVxR2tHMEZpTmJqOENCZ2hraXhkY1NhdVFmQ2MvcjNhY1pHaXly?=
 =?utf-8?B?SWg0UGpiSVlTQlh3WmtFODU5K2VoL0JuYnZmamU2d09VTjhPMTFnaTBSaGNm?=
 =?utf-8?B?b2EvK21OSGJtZ2NmcWhpMmVBMUZyZ2VmT3RXalJ0QWxtUlkzZG5DRXA0TWRH?=
 =?utf-8?B?RzlNV09tSmQ5a0Q5NmhMc2pzTFdObDFKY1BMUWptalZ3Z0lEb3p4RjYyK0hC?=
 =?utf-8?B?Zk9EY280MkRFem1RL0EvWDgyRll2OGM5UHpQMjVPdEpGcGRzQVo3cVEyY1Bl?=
 =?utf-8?B?YURUZ2NUR1pnZWNhd3BCVjMzcmZXd2piOHZ6QXhQNUcrNFNKVjNGdFF3azVN?=
 =?utf-8?B?S2Rabm5zUXVRTXhMMzVTakwwN1ViOWhCOUozUGp0eWhrQTJVK2lrajVPRlUw?=
 =?utf-8?B?TjR0V3JBZ0ZXZjE5NDRlV0xDaldYY0hOckQ3SmR2eEhZa0NCUE1mODBZWmJ4?=
 =?utf-8?B?aDBtSDRqTnJ6d09RWjYvSlZkZnMzM1BZYXRMRGpSa0VCeUJMQlJXUVNhUFBE?=
 =?utf-8?B?aHR1S2JnYXFOYWdBUHlIR1puWkw1SGFMTWU4UDg5TDh6MFZyWHQxWjdnZTFG?=
 =?utf-8?B?Wkt5ampMcnJTSnY2bEZXdm5YNVgrUGlvWmJSTGw2QTM2dERmN21zVkZqMUJX?=
 =?utf-8?B?dEsxRWp1bHFabG1FNDF5VXpvVzd6MTVxaWN2NzY0ekNoQnRPL05yVUZDYzVQ?=
 =?utf-8?B?WkZFdzhZMlM5VlZkaTgvYzBtUXlCM3hDTEk4d24rWXhCNnNoUFhBVjJuUmZj?=
 =?utf-8?B?R2xoa2V4ZGdwaXlmeXB6YVVPWjliVzFqK1g5WlhNblMxdWNWWXI1ZERqd243?=
 =?utf-8?B?eTJ0TjdCU2NscmR6S25nTGVpY1k0am1nMDdFTUp1LzgzU1kyMElBaXlISmFk?=
 =?utf-8?B?NFlaZFdjc3VLc1o4LzFYZkRFcnVDaXlkS2ZQQlQySS9JN2dLYkgrNGl6TkR2?=
 =?utf-8?B?Z1hBNlJWTWpMVVFTMnVMKzdzbE0ralBYREhvVlluZVhQcndDcVo4WFdmWTNk?=
 =?utf-8?B?VmNXOU05cHQreTdkNzMxWE8rLzRtNjBYSFh2U3EzRG1MRDVuWmdRSUJ5Ylh3?=
 =?utf-8?B?cnN3MnAxN0E2eVpMeS9lVFdjNFFabDBudy9tYTRTT3VwN1BDaFNuVG56YU45?=
 =?utf-8?B?WTN4dytySVFUS0hReitkUUtLRUcyWDQ3bnZXSkRiL3FBYytNSDUwZHJsUi95?=
 =?utf-8?B?SGlnbGJqWDhpUWQ1a294VGxBUmRCbE5FdzdBZENRMWJIMWVIbENQUEpXL3FK?=
 =?utf-8?B?V1hOUE1tVFVRNGNWN2h6bFluOUxiL1ZTdTd2OHk2U3ZzSEZZcDIrZTBsNU1G?=
 =?utf-8?B?bGs5Z0sxUGY3TnRRMEl6aWthRmxVNUJKMEk1NXEyczlMTTBoNis1ZjBqYkxh?=
 =?utf-8?B?Q2RPb3Yyb1hweFZ2ZDhlN0Y3U3ZtYkdUeXVuMllqQkRBNEFWZkw1SlVadnVu?=
 =?utf-8?B?RFBBQ2psSnVXeDhwbStNR0VLbjlQMjEvYmtYaUdWMTZ1NVVjYjJid3N2ZVZE?=
 =?utf-8?B?YkVXRS91NmhlV1dpK0JieEw3ZnRKK0ZMSzVqeVFxY3p6dnlPeDNneHRYWjhk?=
 =?utf-8?B?TVFnTXNlME5vZDcrbHlzekRDYTB4a0syWkhjMVk5OGJqSU9Zc1BUMXRtNllt?=
 =?utf-8?Q?Ker58VrDh1P5FjQpmKl1MurHV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ae4543-ef2c-4172-0055-08dccb3d2018
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:50:57.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh3ITkF3OS694LACb/wLk8VU8TbtRQo4skM6HLFj2+IvfY2WBtmxOM2AWRntEEipJKIQFjdjgukupBkSr1AGHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3665
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Ils9OS1l;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2613::62f) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 02.09.24 12:31, Pierre FICHEUX wrote:
> Hi,
> 
> I would like to use xenomai-images as a demonstrator for a ZCU102 board.
> 
> I didn't see any support for it but I think it could be possible to
> add it. Is there any documentation available ?

Not aware of specialties for this SoC. Give it a try, but start with
recent mainline.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

