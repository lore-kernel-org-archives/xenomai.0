Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37118A6A9
	for <xenomai@lists.linux.dev>; Tue,  3 Sep 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380376; cv=fail; b=ZO78sZq0KYtxPm+a/UKgHqnQWTwA3KRPRafk9Y3Pc4wjCCffGhSSZx02UB/aKbgLQnNyArlc9/UuDVUSSox3Ayfavy4jZ0k6xcJfF2HdNwWlIVSiBTwX/cudMzkxAdeT6WLR38KoME/rk4OiMEaxRfH9ph9oEdeTY0JoxG/g2to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380376; c=relaxed/simple;
	bh=O1cqPWmkHxjZEgKZYFdcezHLny1AsfODQaDqJ4HwNhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kvpf70WCrS326Z/FnJjb8SwnoCyZ9MER8wjA/wKIpC24l0M7URR97PT43V8vJUVGtc0iWtnaPVuN0jmwhf+QOwl9NwuDgJXxr1tInJDCTj9GZyw5/RsJi/1DUwUbTOz8LayMaAGdk8YLAq6dzxY2omKpt5ZP2tJkCBiTjVwRsYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aokwl7ko; arc=fail smtp.client-ip=40.107.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aokwl7ko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuuP0uQvFOXh4VkpmQVPM61USsbQwvoud84buoOuH15308A5vni/va1QLW7wmx1BEmnmsWhurCkSOvAR10j2sic1ZW98nk7N5xISc5kvomAM0C1AU7mtZlJsi/xULtiXbsqJcmjesFkSyF55EZnjj6CXOnSGthIfCphUwoZsC+KQ3cMFq1TD5aO5ExVR9kFB34G++S7QlVD4B4JMxHXLvMEV0F/7sXGEeXfcRXUbcq+TweK1Q6LWOXMEIikAzVNjLOqCMjfMk2dYipXKCplhmPUZamuR8RylIfKm089JFdvhjM5x6y3+PLP8y/Zruj/eovHTSeCb5LD6qKhk52eYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzV8+42bpAeNYzYxmCF3vd9KlG0m8gMiXC7pxRXYtOo=;
 b=tOGgn5PBzrYX75vIwFbV9Hh6iXI0kHrl+rTUmhop/TIj61jmPpRULLnl/bMuHeuOBZGqcC0csv5f1rXuQAgb54tBtwkhKVx4uZLEkSAmiIDCWe35rluYsByxOlkvYslVY5eFPOklhWp7YWQtafDx88PVkoJrQnkzquHe5wAYMELHH6MiOI8DMsCHL+fWiIAqnPWyM5feo3QLcpe24rCKdiFCGohyzQBCNbsk8QfTABKzbkm9pFzCGRffD9W0nnPdnP8Kym20ouygq310jhO0usWkmI5JSBt6yFyg+tqC4oOK3Jl4fOmPD3HJGzQbufgymKhZlDGd9COBsqZb9RXkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzV8+42bpAeNYzYxmCF3vd9KlG0m8gMiXC7pxRXYtOo=;
 b=aokwl7kopxXo4d5RcThIztnlNKJQUf+XtDcYK5rLeTvqBQ1JSlxWoduJQJRfVdiEvCYsEgZnhW9K/yu3s+uSd6XdH/gdU/kJwo0Ig2rhAvH0TNN+0vWlVswcs7YifmWe3hX4fxxD6ZwylRxRlO4is9/69OafDZ+VicloZ0gFM2K9g0hTKl5Q5JprOHuO+P0Y9WCaUkrDIPSNoNwacOL28hpUoYQx2CNxUg/mT/wIT8LNeKD8QI39z+vux/mK2mfRgTNnpi6mV/t2OFozm62Urhbe6zJIJ1z4kivFmu1MT4FMDT/fQRsRDCiHhERJDQqxnvfGLSrnVv031HauQSPN3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5586.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 16:19:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:19:29 +0000
Message-ID: <aa2bb45b-5639-42d5-ab8d-d3a12302532c@siemens.com>
Date: Tue, 3 Sep 2024 18:19:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dovetail: Account for invalid syscall number
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <24868b62-2aa9-4f06-a20a-c1c0dc2ba164@siemens.com>
 <87h6ax9kwa.fsf@xenomai.org>
 <d80fde5d-b6b5-4c72-ad9e-ce20f2538a38@siemens.com>
 <87zfoo90q0.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87zfoo90q0.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 702a46d9-2754-401e-1634-08dccc343017
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVg5aFNoN2M2MjNSSlkzdXF6d0RRc1ArVDliSi9JbWppS09DSGpuRlZvNi9a?=
 =?utf-8?B?bFBWN2M1eGpqdWZmQXg4Q3dULy80NVY3a2VWYTVKREMzT1Y2ZWRjRmJ5eHJO?=
 =?utf-8?B?RWRLSHlscklJc0tLVG45VjNReFFQTnU5eklNUU8yUzRsSTlCcit6WXhkbWFC?=
 =?utf-8?B?cmh0aTRYSFdXODRjQ2dvRGhhbXczUFp6YitybHpRK1BJNTF5MmhRWVlBK0NN?=
 =?utf-8?B?eFpiUmNzQ2tCd3FqWkxLYVVBUG5sOCtuWmpwaWlUQndVNTFFR21TZFZKd052?=
 =?utf-8?B?aFVJNjhZR21aNDVpbFdZamNQeVFEMVEyMEQvZXJyQi91UHFTZjFoNUVIY1FD?=
 =?utf-8?B?a3krWVdWc05JTmxsT3VOUUNzcW4zZUtqZjJESitTMWpHVDQ5TFpZNlY1OWJo?=
 =?utf-8?B?cTlveWFndC91NXN5a0l0N0cxWCtORFFsdThSYVlrNDdnc0NqWWFleXFTc0kx?=
 =?utf-8?B?SXFCY0ZrTnNuSEwxdEQ4Q3YwOGQ2eDlWTG03WUxtSXJiY0lCMklWejJ4dUhG?=
 =?utf-8?B?Q3BQZzRHWE05WFdBNXNoZXo3VUV5NnZaS0E0WnREN3pidzBHK1VPTUI2UVdu?=
 =?utf-8?B?VTJYTTRCTFRwYk1jU2dXbW9TMkZXQUtUb1NKRHU0TWZHenJnREpWSUc1TThQ?=
 =?utf-8?B?eGpOYVp3UzQrNE1vM09IbERFd1J2blZFcTBTZDh3Si9mS29jMDBSd2d3S0sr?=
 =?utf-8?B?d0Zza3JhaWVWL0dqSXFRVnJ4K2RMSUNpOVJoODhNRmVpSTRtMjYzM29UZVZ3?=
 =?utf-8?B?MnE5Nmk3cFY0eC9rSEc0WmQ2aUx5ZEhQamhvb215MXNIUVU4RkZWVzdJOWhL?=
 =?utf-8?B?MVlSc1A2WEhEQ0N4V3YzaUt2VkYvZHkxUnZ6QjZmbzJhRjFkbTg2ckdDVVQy?=
 =?utf-8?B?eTJPak9kenhPMnZzYjZ4VmZiZkEvcGVnUHpQamtHOStQOFBURDFPUEZmaW9F?=
 =?utf-8?B?NXN2bUk4enJEc3RTcmpPaGtpQmdZSzBaMmNtUXN6VlN2SjdhTkJXUjJzcHhr?=
 =?utf-8?B?SnA4TTF2OWU0ejA1bG5LeXRhOElpYjdiblowYm8yZVBTTlJtZ3VKWk13OEMy?=
 =?utf-8?B?elZyTXlpMVlZQk9xa3dZTUxsU2YrNk9manR4M1lPZjZzMFhUZnQ5aEJkVllF?=
 =?utf-8?B?SVJkT3R0czByaHFrY0FaNDNnUklEejlnMDI2SHE5ZzR1OGhYWldmZ0dFSzdp?=
 =?utf-8?B?eXY4M0xjN3AyQ2dXbXEvSGZTaEF1aVpKdE0xVEVnQzFhQ25tYlFOaUVaeEc2?=
 =?utf-8?B?VDNEVDUrdVRZTG0rM2RtYjVXYlJVeHVXUzJydTE4OGhuUWZHRWdnbHdwL1JV?=
 =?utf-8?B?SjFRQzc3aVFYOVJjeXA5SFFQbmM0ZEJ5YlhFNnhoQy8vbk5ZV1NEL1VrOUxv?=
 =?utf-8?B?SHRnL2lyc1FQY3VLbGdEK1JKZWxJNEdrQ1FTZU9BZTVON2FPWlpydTN4UFBs?=
 =?utf-8?B?YkxURkZSSC84SE9uc09KQUM5eDdKV2hOTDdMWFRVU2VmeWx6QTc1NDZDekp4?=
 =?utf-8?B?c1Z4em9sUmFzY1U5Q2t0Uys0bXBFRTMrR0V3dkxNWjRNT1dnRGNXNTloa1NV?=
 =?utf-8?B?RDZpd0ZRNUd3akE3VUVoekR2MW1ET1FZdkNRcU0ydi9oVktuQnF4ejVCSGpD?=
 =?utf-8?B?dGdhd0lpZ0ZML2dud3kweU9QY2dUeHgvU0UxWHl1Z0VBOHJiUmdERG54eWFp?=
 =?utf-8?B?MmFSUEhmSE9zY0hxdXBLdW9KenJRQTdVemxpek92SlFSeDhnZ3BPdVoxcUpN?=
 =?utf-8?B?UFI5Z0lrV21IRHJ0YWJEZHFjc1hPdGloSzUzem41NUNXMFB2cXVtaENST0p0?=
 =?utf-8?B?SzdiSytBZ2NDSzhkbG91UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzVLWjduUm9DZ0lEdHkraTRESDQxWEhoOUt2L1FobE8xNWVWalprNXkvZ1VK?=
 =?utf-8?B?aWtSTFhRRDVrcFY3VkVCM0xDYTVBdURseTIybFZOYXlaelR1OFFFNVYrUVU5?=
 =?utf-8?B?N25FZERBQm5oMG95bXNGRllNNm9ROFJNK1FxWThoMEl6OVVyV1lKZGtTd3p4?=
 =?utf-8?B?WWVDZ0MrL3Y4a2dpNVRzRWxDSm5rSzVKcHNVZWRURStJUnhFbXhsSjJJemNO?=
 =?utf-8?B?NURMNG9Tc2QvWkl2c0tPT1UzV3ZoeVBrallnb2NaNFNiOHRRUitHTFVIWHow?=
 =?utf-8?B?ZmFMTUIxbE94OXNwM0VrL3EzNkZScXdmc3BjaTFrM213Szl6L0pGWlNvc2pV?=
 =?utf-8?B?Z0FxeDJsdmVhbjNmUGx0U0JMbHEreEN6blpEeUR5WlBOVktlVVhkaUNWNXV2?=
 =?utf-8?B?SXl5MXN2bVJVSkltN2ptWFZ1SVlnd0RERU1Ub3hnQlF5ZDMxaHp4ZnlMZHpy?=
 =?utf-8?B?Y2QzL2lRWXhLY0NRL1BYMGMwYmt2WjZYQzJTWXcvQjJmZitZU3J2a2JNMzBp?=
 =?utf-8?B?TU04VDVSTENUazV2ZHJINGViOTdBQzNXc1Y3bEhJT21tMkxhRzJ4akZwTExW?=
 =?utf-8?B?dzFFTzdnMDJ3VmY0STRQR0J1RUE2eVNsc214UEw1WnUyRU1odWJXaEFuZUt4?=
 =?utf-8?B?a0J2NXR1UEE3a3BTVmdiWWdPaHVDYUFWUU5MK2IxTk0wcFRPNS9oV3Fab2Ez?=
 =?utf-8?B?MWhVNGxDcTBzRHI0MWdHNWNtRTlIbEM2MXVnR0tSdExxN0tHM0tiQTBVcUd5?=
 =?utf-8?B?SklVNjN3cXY4L1dyU1kzVGlrNlpMMlIzOG5jNVZjNzhLZ1FMSUEreDAwZnhJ?=
 =?utf-8?B?MmxsRlNWM3ZpZXJTOVg1ZUp0a2JPVjZjbGZ2OW9pOW9BSW12azdrTXM4cS9r?=
 =?utf-8?B?QnU2SzIralRQQ251Y3JNTnBzRkp0RHZGSWhNcHprWHdZUVpWd2hFOWQ0UzRw?=
 =?utf-8?B?a0l4aXF2aVp0QTk3ME5hT3UvYnBQUWhvcGhsZlBUNlhQQWNFUUJNZU50MkVs?=
 =?utf-8?B?cVBLNVdiL0V3ZDlZeFIzWnlhL2JiSUEwWVVhL050L1RWNEJ1RzRZT1VhMGNZ?=
 =?utf-8?B?YlpLQTBBdi81U0htMW0yZ0JmT0JoVTBhSjQzRU9ZTU5yT1N3QlNBZE1acER6?=
 =?utf-8?B?TTUrMmlLck1rQnpHa2ZBUW82TnkwVWRFa2grZjhIU2M5RjRpbmVrdzdMeEda?=
 =?utf-8?B?T0RPVGlCVnZWay9TSnVZbnBsVnlTcW9hV3N6UG8rVWpENEk0dmZGU0ZIUkVu?=
 =?utf-8?B?S3pBWkxobWROZlpJUVFyYllidjV4UElJVmdVUE0ybXI5a0dUNVAxWUZXRjIw?=
 =?utf-8?B?cGJxNGxjb2JQT0hWRDJtM3JtTXBZRGxmYmhPNEJWSGRMOWpsdTBoWS9hdTIr?=
 =?utf-8?B?bVNFSkxQbnMrZWtWR3R1OXVqTlBWVXJXbnpBbE5Zb3NZZzRJSXZqWHJPS1Ju?=
 =?utf-8?B?VklsSmlXbkJ6QU1tcVZ3YkRMWlZmSERMRWNYbGJOcEUrcjFENyttc3BlNG4x?=
 =?utf-8?B?VDdtc2doZy9iaGJCdFovTGRWcFVwOXNTZHdBdkpkbGI4Q0RwU1ZGUmt5cVdS?=
 =?utf-8?B?RkFsMHNHaUY3UW1aTkdIYlhmQktsbFRKNUhsQjB6aGxkU0FUVVpWVGRIYmNW?=
 =?utf-8?B?azlvNGgvNy9HS1dJTGJyL05lQU1wOEE3SlBJZDlUV0d6QjhxdjV5MFo3L21r?=
 =?utf-8?B?Z0d6U2tOZlhyZDgxcTk1Q3ViVzlIWlJacm15bnM4RTlHeDdOVnUrM2lTbWZP?=
 =?utf-8?B?Q3ZZYlpENC9vQlZUNHBhdmxBQ0J2RHpkU2JiRGJtd004WkFMZDdXVXdBYVJ4?=
 =?utf-8?B?TWpyZ0U2MHBIUUVjcHRXM29TM2h4akxZNWdHUjkrcGhxMnNBdC9DM1VGeDh0?=
 =?utf-8?B?d2lnMDduRjUrZzY3NzBSTEovTHNuSk02amY4ZElYdHBIYitXUkhUbXBFSm4r?=
 =?utf-8?B?TitZRFVqTUY5d2svZWt6Q1IzSVk4TDU4YkdOSi9hb2RnY2Jrd2xmN2R2a3NX?=
 =?utf-8?B?U1BYSkxkWFcvTzZVdlhpMk44SjFaWkRSNjlnREJ1QU9XTmFsNzRHSk5WRHEx?=
 =?utf-8?B?N3FYNkZVRDNZMkNvVVQvc0Fjc05NMmhtZFEzR0xhQUJhcmt3MXdzK2ljaVBJ?=
 =?utf-8?B?S0RDaEJFSXVmalM3MVFDZjZ3TzBodUZETFRHMUJUcXdoSHFxZjQ3anlLNFkw?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702a46d9-2754-401e-1634-08dccc343017
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:19:29.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlkWbFaIKQU+2m3SXhfj8mEjpbyI8E0KrDEY68EYtuXuGLfvSmCuysbyNf+waJdsZXOMoFsaOej03CxCrsjPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5586

On 03.09.24 18:11, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 03.09.24 10:55, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> At least on x86, the kernel may have decided to invalidate the syscall
>>>> number while processing it. Avoid that we process this -1 as legacy
>>>> syscall.
>>>>
>>>> This was a long-pending issue in the whole dovetail series, now revealed
>>>> by running auditd on one of the test systems. Syscall auditing was
>>>> eventually catching an unbalanced tracing, caused by a premature syscall
>>>> exit due to this bug.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  kernel/dovetail.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
>>>> index 08c649d6e9d9..bcd49183f8eb 100644
>>>> --- a/kernel/dovetail.c
>>>> +++ b/kernel/dovetail.c
>>>> @@ -119,7 +119,7 @@ static bool __in_oob_syscall(struct task_struct *tsk,
>>>>  	 * a PR_OOB_SYSCALL command (new/current call form).
>>>>  	 */
>>>>  	if (IS_ENABLED(CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE)) {
>>>> -		if (nr & __OOB_SYSCALL_BIT)
>>>> +		if (nr != -1 && nr & __OOB_SYSCALL_BIT)
>>>>  			return true;
>>>>  	}
>>>
>>> Merged into v6.1.y-dovetail-rebase, v6.6.y-dovetail-rebase,
>>> v6.10-dovetail-rebase and the upcoming v6.11-dovetail-rebase.
>>>
>>
>> Thanks - but not yet pushed, I suppose.
>>
> 
> No, not yet. Something looks strange with one of my tests. Not sure that
> it's related though, just playing safe.
> 

OK, let us know if we can support somewhere.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

