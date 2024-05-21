Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324112FF7B
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303505; cv=fail; b=qiwaZHYh97/UjR9P9Cff7qI/MSUceWstQ2bAQBT5YhWtuUz9KQKKa0toD+0P2FaIJpH/ABTrMilKp0iSk/+RpGMeEAIC32vmoLFEU2LZ9+Q5h4qHDgLVMYoMF4LybhKoUvi2tbqPn7ZbzoDy4pTTuoAF1C9yCjDs5xr16A2IhDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303505; c=relaxed/simple;
	bh=oD2gpccU+3CqNt0Otou9PIaQjxnb9jh/nFwCsARBDM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g2yojvViLmK6JcwdXTf62PaW1oL7yIMaP7q+EbGli4LJGsfZ+TzZ84fZEjae4NGalCFTG9GHuouP2SNBir3b2npad32jZCOTeg0lXsxb7g3cMim4Dv048XLPkaNwFV+4/PfoEBzDzjiu+yYH2O54OR9mm4ZN784dFqHOs6rYumg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TZ+u33pZ; arc=fail smtp.client-ip=40.107.247.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TZ+u33pZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbcg0hHfXJH2tGNBHAe/8quIYylnCaHCKv4dYK++xG6IDLlq3HiN8Foom2zPI/XgMylsrOgiCq2LJu92pwLGc9W/W/iyA15f4EpwVP15bKBfSrGSDIrDU57XfSNA0+Ay93ytSzquOGKbtcVL+9M4wIm5pkuUxE+UWzw0Buezb7RePKUWIi9V43sdyY1wa4D7+mMvHKf/EwxhTwYP6OUVYZUjmV7P005uxps3kvtxHn2pWPvVV/Nzf2NRzgMpB94xGMyT74pRUzNJacuLm7POVf0qf1eX1o/EbObfZVE/cOjdYGx+cr2nYg0q6087l/K+mK0N4rqPYKN0AHo/DxnGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuLkIIWTSmA8W+cNgZPifHqEN2mJASDNtSbORd/8YSY=;
 b=hDPM6cnlIL7aFc7YTLmaNuGl1aULJgh0/coato0qgMjuwYnF38dXvUDMOXSgVAYYKnBrV4Zom7YW0206ogxdVofdmSPK/x4I6ZpKMySF1SAHfLN8gCQN2Blrhn40cEFBuVo3R9/aYWWN4eN203uEKZ5Ton/hRKOLiINDmYDyaE8Xs2+CFTRBI8pHs1jpS6fkK1rn6enxOVj8TPPyzxESL3rQ7e1jSw0Lw+P0xJGLX3Pe96Y13H73Kkhxu7GdYDulLS1AuMB6bgwkDMkxGcTzaltJgXxfKBKMgh9sudpnQ+AfCzNkXFFtQCJDNRZRlWjTsP0otPKXWUvoh35zCS3VLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuLkIIWTSmA8W+cNgZPifHqEN2mJASDNtSbORd/8YSY=;
 b=TZ+u33pZ15/s8GA/yhrGX4ydc1kbJtA07+bZ1wUIA5rXLsXdAySiNdsy+Jw9Lmz7w3UOzp3ea/Id2ewn5eLAnqSYhhei8QmDK1Wz8wsNGNM4pX5xYNBzQo2f6EbTLZxu7+gFyD/iB4VM92MB5p9N1soxCmTOUcj4f1/sEuw2LrWbNrVeJ2YbrQNvboatt/T8GkHpP9ltdPvAzE2rLZRaXuuT8lXf7wUQClRs0lvqyQeebKkjI9N2JQZRUf4/3uMkJvZ3a9tYBWhnHvhW1srIxIwrefBNFtverfat/dUKtl6uUL0R7ytiQTaz3emvbglz0mydHBGDgz4E7RCtIwLOng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7567.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 14:58:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 14:58:19 +0000
Message-ID: <73e68781-13f4-4272-9179-9a45fe2fd7da@siemens.com>
Date: Tue, 21 May 2024 16:58:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Emit architecture agnostic
 changes
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
References: <20240517133603.17554-1-richard@nod.at>
 <8a950188-ce63-42cf-96e2-ea767fee9c47@siemens.com>
 <969808028.118837.1716031876478.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <969808028.118837.1716031876478.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: f93e3ece-d329-42de-22a4-08dc79a673a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckJoNmt0TzlCSjJkVTFMd0ovQ285b3FSVkxUZ3AreDQzVHI2bzJ6emJRK1Fs?=
 =?utf-8?B?K3M2bE82bUd1T3g2dEVjRGRBZFhoV3hlR2tiRmNtVTl2K3ZPQVNnbCtaR2U1?=
 =?utf-8?B?NWdZV2FGQU1YOVo5TERwM1hyUmpQOE1QbTV4d0VaZzhISWxuT1VJdnJpMXh3?=
 =?utf-8?B?a2FsYmxHbUg5WU9vOWtReURxTTJINFByeFBMdGx5UFgrVjMzUnpDQk5QR1BE?=
 =?utf-8?B?Y2sxUHkwcm5YY0Z1S3RMTURwVXAvZ1AxSHZUa0VWVjVickhMWXR2ajBPZGtT?=
 =?utf-8?B?QTJ3TWRlWldWMTZkTThNWlA4Zk44M1lDZTJLS1BMZjVKeW8zWXN1QVhXWFJq?=
 =?utf-8?B?MzBQaU1LSlpwcEJUSVBqWVF5eFY5c2NrWFBYcmhXZ3phR1JuSVdqN1pkUm90?=
 =?utf-8?B?QWxic1ZhT0J0c2NjeUVGZ3VNZUNFOXZMOFVaeSt0dU5BenptcXRGN2p0RnNv?=
 =?utf-8?B?SFJkSDRFbzBDM0crK0FnM1ljWC9ZbGRrL0xWRXhWTkVpcTFWSy93RWxhZE5y?=
 =?utf-8?B?bHVvVkd0TlVsZ0lod3VBUkhaQnVqNEdxK0xDdTZzb3pGbTJLTm80TVF4WlB3?=
 =?utf-8?B?UWtNWHQwMUF3V2k0NU04aUZRRmlBN285WHhib1hqbFBQOVd0UFZ1by9ubFFU?=
 =?utf-8?B?RjRpM1hDdU5CNGx2SFFNWHcrbVYyd2g2V21kOUlzL2dac1hzQUVFWXF0T0hY?=
 =?utf-8?B?QnMzTzJjUTJldnNiOWFMd2xxbnhJRHRtZjgyUGhtbVUrRW5TK0dPZjRsVW96?=
 =?utf-8?B?L1lCdDNTTkszTEV6ZW9WdzhSY205aXFmY3cvTjZtcjdCakZEeFZYbmFqUnV5?=
 =?utf-8?B?dG5Rb05CdFlYZ2QrVXltNTlFcUpQSjlvTDB2VGJvaFRtZ2hRMnBrdFZSWnYv?=
 =?utf-8?B?YXlWajFsWmljektkcW5LeFNJVnhiODRCeXd4ODhZcFpNd0RYVk9aOFkzZmNW?=
 =?utf-8?B?WVZQUkZvcWs0WGtFV3hycmQ1K1ZDSTZpazltcnV2OURtMTl3ODJ0MFZLdE9s?=
 =?utf-8?B?cGh0SUxYVWtHQnlrN3JMYjl3Nk44RjF5dm9rYllLVHZpY1ZLVVZzNmNDUk1m?=
 =?utf-8?B?TTZKR1VCNnZUanFsWkVNc3B4L3NLZWxPakV6QUpoeTlLaTVySkVhdUhTZ0ha?=
 =?utf-8?B?S2ZMQWM2Y0xiRFhaRVE0anBxeU9KaW9kbVVJQWcwclBMNTFiRU1WVy9LM3U2?=
 =?utf-8?B?UTQwblRQdWxEVW9JY3lnQjI0cjV0QUNuMytMMFB4bVhHaDN4b3pvamI2RjRx?=
 =?utf-8?B?eXI4VWFLVDFuQnZXcWRzMU5PZnAyYjdoSmRPWkVBL3c5ZDB1ZTNmUFJ3ZnJ3?=
 =?utf-8?B?UmxoN3BTU1Zxam1qRkNLc25WOWNOemgrNFJneWZ3OVZ3YndacGd2VXRGWVBM?=
 =?utf-8?B?ckxKa2dmNHlnNGp6RFIyUjVrZnZ2V0JUVU9EbDMwRHRTR204bWFpTlE4aHpN?=
 =?utf-8?B?QTFqTUxDSFBLS1pzd09UZkFLWkdWVGdyczQ1Y1owdlpmaXpqMVEvOUUxNFgz?=
 =?utf-8?B?YXlNQXpaRHR6b2xlczkrMFRCWlVUSWcvUytWMVV5b2phQkJOSjBoTEhySUQ3?=
 =?utf-8?B?UTE5VmR3SnVUNWxIR3J4L2k2eXM1Wm53S3MzME5IK0Y0MCtZUHJYWkR2aWh2?=
 =?utf-8?B?UGJNQXI4YkJHOTZtdFhTYkNRSVhrY0JSeisxTnA1Y1RZL3M5UXlsUWU1ai9G?=
 =?utf-8?B?N05CRmRYMko3K1lGWS9jWWt1Y1BVS291UFpQOGtPeWdMWVhVS1FpL2x3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkdDaVBpVFR2TXNqT0xIVVdEbzRuS3FleERvUnNTR2V4VVRBL0xjL1c5UDlz?=
 =?utf-8?B?ZnR1VURSdmdrb2RqaGdnZGlSZmRGMU1Id2I4WVV4eFZldTdFWndMWGRSZDR3?=
 =?utf-8?B?bU1oRUtyRERVNmJlK1JCSFJpdHFTVzJ2b1pRb3F6ZUJ2bWtRMWlZb2tJeFZz?=
 =?utf-8?B?NEZBT2JBS25WK3NvOE1oN0FDUllvT3lqazY0SUEweUVaZDRENTdDQ3lUV2N4?=
 =?utf-8?B?dWZLTjBpak1FdkEyZ3AxTFZuS0FPNDl5Zm5tSjg1M1BHUWdwazlDR3BwWWlJ?=
 =?utf-8?B?UERzbkM4ZS91UHhObW1RaGlXOEV0QU5QajVhcEdBYmZkMkRTaVV0ekFGVmhI?=
 =?utf-8?B?S3ZnSXAySGFPZU00YnV0YmtlL3BNMGhzMjA4QUVOWTdraVpFaWw4alFSUXNO?=
 =?utf-8?B?bUNjT3JSeGN2WkNtRzFHUkpGUG84aFVqbzR6TEovSEwrRFZvb21YQ1d0empv?=
 =?utf-8?B?SW54bGlBeXhNeWs2NXd4S0pvN2N4SEwrWTAzS21aU2NxcFRFRERwcW10WElw?=
 =?utf-8?B?c3Nya2p1YUwxUXExWFRkd0xhTkRwak1lcjBTM0RXaUQ0OHV2WmR5R3lUZkg2?=
 =?utf-8?B?T2xFZVpaaU01dkJhMjY1bzdmRE4vSEVpMmk2MEY5SFNBYjhDQ1l2VEFjblps?=
 =?utf-8?B?aXdkUHlIZTNndVVDSjRDK3VCSWJZQlZRRlRNWHg0dUx5ZGFtWkN1dmVrZXcv?=
 =?utf-8?B?Rjc0Q2JWdzB4VGpBM1NwTzhWcVRSMUR3VWNvbW5ZZlhoMDRtWnZRTUZncEQ0?=
 =?utf-8?B?NHNsWnpoVnE3R2x2ZkYxVVVycGQza2lJTlNPckdxT3ZXc3pLNnZ1UW1VUGpr?=
 =?utf-8?B?QUFqK0o1TDBLL0ZzcHlRd01neStMdTRkTlhqQ0EwRHRNTnZ1N29jYWNaaDdB?=
 =?utf-8?B?QTVBY0orN1FXL3dYTFRBeTdTZjVaejIrcGdPK3NvR1JjUEIyZC9nUzNGd3Vs?=
 =?utf-8?B?QzdrTFZKaFVvb3l3Rk1sSk5lSVlFbFo5aktJY3dLclBGVDZmZWVPeW92cjhu?=
 =?utf-8?B?TFpOemUyYW83eStYUmVyaCt2Rk9YYTcxMFkwazRIWFlhS2xwK2J4dUtUcTBi?=
 =?utf-8?B?aExOSURBQmJ2cW82amhpakl5UG05K2xXNW9YcmxocEV5MXB5NERtbXpTUHB6?=
 =?utf-8?B?MzdRR3U2Vmk2MzAvV0ZKaVBnMlNaSlY2VnJiS0dXa3drL2xKSUZ6L0x1Smx0?=
 =?utf-8?B?dmc4K2M5V0RTUE15blphY3l5UjdITjNlSzN0WjRySU5FMU5uMGpIVW1HZ0JM?=
 =?utf-8?B?b2p0cERDckNzM05pRlFWSXhUVVpCU2JXMUNZb2RsL2xEM2N5NWduY3R6c1hB?=
 =?utf-8?B?LzA0cTluajRCL2FISit6ak5iSFFHTlRxR2NBSGJBdHBzYm9JMlRpbDJESXdH?=
 =?utf-8?B?VjErVi9WMnRybXhwQnNCWitPUC9jdUVxa2ZzYTN2RmZXYjZxZFM2SU02cnIw?=
 =?utf-8?B?YTNBa2JhTUxWd3BFVGFkenpmejV5UTZXRUhNYWg5SlBQRnZVOGdDdW1WaWtO?=
 =?utf-8?B?RHJkOVYycVUzMkVBUks5VnU2K000RWg4V0s5TjJaN3BtMVh2dm91eHFXaVVC?=
 =?utf-8?B?bnBPQnBsZElHOHdvVWp2Nmpjc1dPUC9EUjFmZ2tWSHl2K0VBT3pSNC9zbmt3?=
 =?utf-8?B?TmhSeUVUZ0Nrdm9id3dybXA0VFQyUzhrSkFMM3M0VGEveEdCU3pjdE5LRm0z?=
 =?utf-8?B?d2FnYU5xV1RpeHdNL1QwRGlSZnJTY3h4dk9pWDViUDVVTFo4VVJ6clpFaExx?=
 =?utf-8?B?bVhhTlVsWlVLZ3crcFBHVGluRmViN0piN24rc2R3czZVSEh5REt1MFpmNnlK?=
 =?utf-8?B?VC9KdWVmTlV2SlQ0NEovNmd0dDZKMHl6WWQ1YjgyeFRwQjNid1A1U2x4aTlY?=
 =?utf-8?B?RW1YMy90Zjh4a2lnRlNQTlY0YmdQSEtEV29ERG1hSlVZOVhzaStub2dNUVE0?=
 =?utf-8?B?Y3N1WXlQMTJEM0J3TE5BaSs2VzNzK0t6NWZmcWFaN0FyRG5JVXhDbTRPc3JT?=
 =?utf-8?B?cjYxVjEySmRFTkxNQTFldkE2YmZQSUJUc1hxNzFkZG8rc0xQOSt6SWI4TCtB?=
 =?utf-8?B?M0p3M0NOMVpoalloL2lwekIwayt4VllWL1VScUtGdVV6Y2ZkQWhBWDk3ZlZE?=
 =?utf-8?Q?+yRoeSCW01ua+U2JmRLkePLd6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93e3ece-d329-42de-22a4-08dc79a673a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 14:58:19.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv+Uol7VmzlRfO12MX/mL1716y/jJ8JApidkNveHhoy9s9qFDJRLZ34+y2ws7NBqYc1BKztwEWRUoon0Ip/dMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7567

On 18.05.24 13:31, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>>>  if XENOMAI
>>> -source "arch/@SRCARCH@/xenomai/Kconfig"
>>> +source "arch/$(SRCARCH)/xenomai/Kconfig"
>>
>> That was likely there for historical reasons. Removing it makes things
>> only simpler.
> 
> You mean removing the whole line or just @SRCARCH@?
>  

No, that was no call for action, just a statement.

>>>  endif
>>>  
>>>  if MIGRATION
>>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>>> index c9aeeb4fa..25f3b4a7c 100755
>>> --- a/scripts/prepare-kernel.sh
>>> +++ b/scripts/prepare-kernel.sh
>>> @@ -249,37 +249,24 @@ if test "x$output_patch" != "x"; then
>>>  
>>>  fi
>>>  
>>> -# Infer the default architecture if unspecified.
>>> -
>>> -if test x$linux_arch = x; then
>>> -   build_arch=`$xenomai_root/config/config.guess`
>>> -   default_linux_arch=`echo $build_arch|cut -f1 -d-`
>>> -fi
>>> -
>>>  while : ; do
>>>     if test x$linux_arch = x; then
>>> -      if test x$usedefault = x; then
>>> -         echo -n "Target architecture [default $default_linux_arch]: "
>>> -         read linux_arch
>>> -      fi
>>> -      if test "x$linux_arch" = x; then
>>> -         linux_arch=$default_linux_arch
>>> -      fi
>>> +      target_linux_archs=(x86 arm arm64)
>>
>> Is there a particular advantage to use a bash array for that, rather
>> than just a plain space-separated list?
> 
> Hmm. In this case not really. Since the architecture names will
> never contain spaces nor special characters.

I'm not sure if we have other bashism in the script (the shellcheck list
is long...) but with this, we would for sure. So I would avoid it here.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

