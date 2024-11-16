Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89094161
	for <xenomai@lists.linux.dev>; Sat, 16 Nov 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731763624; cv=fail; b=NcpLEMCW39We+TGe09FPv7zvaFbhkUYrzaXAQvxls1DGqg8Vv9xnJfzPRg1aKLgaFmnMzx8UQVngKD9oLChNhgLtA/1sN1NjOXzkzVafj5sWe5fChwuedPSxmlL8b/JyW9lXf5Vv2fXTXPIaLINa2MyARMbEg7KCkfWIjMAEKw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731763624; c=relaxed/simple;
	bh=sDmrjuCHLgymgPtjoL87htv9O44APMMuIt1jrO05O1w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhlBW69c16WzsGXz5zfYp342iTEHxROXPIbOTnesQ4N/XtkbZkd4SHd4C05fSL/WfFidyu88By6rqxvWvQqyxVOd7MIQ3MiSDK/u9Ij3fXEaqercghXR2V4DplMLRt4JZkVMPeiHZe9ZydLXY0rYoiUOhQ7QVT6x7KjZhQIVFY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=W7RZy2mL; arc=fail smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="W7RZy2mL"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 4F3E8100003
	for <xenomai@lists.linux.dev>; Sat, 16 Nov 2024 13:26:56 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f403:260c::62c])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 49C50AC1577
	for <xenomai@xenomai.org>; Sat, 16 Nov 2024 13:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pla9mqjSIun9TRt6zU8W0be83VV3SrIEVdM62x7L9LExK4xYwqbzdhk5hBBOWXbpOUkpNOdwHV5vrvgK0YXb/aV4FcmHgX84nQGPU6VeYtPApVrCq8UVvzwlHQscBa+rQSK0aIh+ny5Vjm+cQHM1vATUZRsO7b3QgrzwvnP6a1NvPuDVL8SeT+3bzO3N5omoA4o1HfZDgzCm6+gTA14mTZeet4cqi2FeTu9aPdhSrKsUzUYY/Z37LJiBr8lgAKr/3L2h61Vrjv3gy4RGSnh8CGEnLE02gz2yIec6cVZHU970G2c437tlN7K8+izviygLtsyya0ElCyc89dk366TXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GGh6WTW1diyW6kLiOP6r0yGPXNlccsO5w2F0yzsc0A=;
 b=pXV5aHK9PBj3ItLy4Du8iTC0j0h4rLeLehP2lc9IwSS05poM3sxrB9JBP1ajKICMGTph5EbP6tB/WNI+6Ku0TPrWvZgogxPP9OPQ/gfPLrsb0ekl7jigNWK/oX45ZNuVwP1XU6VG3wDER9m+vEjUOHEE+SVz7uyMoLnhRSaGOrNBWkXrrIdXbELILcOhsbJUcpYqBrwvOXne0nquRQvp167dYRJLu6vAs/qRnEr3ZONWcnwttz3CEamJlKxIUNN8LV4/7yf6oEfdlTIl1ROXp/dEKrHEm0t6ptUiobyrxvvwKz89KfhMXBZ72QYnhNn35j0OjwR6ghcXMlJddGARGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GGh6WTW1diyW6kLiOP6r0yGPXNlccsO5w2F0yzsc0A=;
 b=W7RZy2mLPb4wLoHniMPhvmxvKBFJW5/aXR+aBJpyamJuH7KtfQDHB80WGFKFXcdxfRQIPNh8J2fQEPDMvO7RNcl2FztN4egIB/w9o8X7jJnOliofO0lLqMbTHosDqpNgdIW0HM6rY+7tiqZAdABUwdnoBWdWboTKksbLbyd3s5ICUl5KHlbkAB3yY68XgTGK7cAnYLK21PDVDIi2Poaq5nQnCoHJTyobHrhK/tLA67zebjGcQxK9lnYdHHwx92PrirA1v+FZu3Zstr+7rampf7fR/5Mb4/dWZgUMwg8AjUhXctw8zKQx0a7NW+lhrSbN/u0p8Sw3ykB7qRkVfkHkpw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Sat, 16 Nov
 2024 13:26:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Sat, 16 Nov 2024
 13:26:53 +0000
Message-ID: <d966a535-015c-4ac0-85b6-a9656199660c@siemens.com>
Date: Sat, 16 Nov 2024 14:26:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Error building xenomai-images
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>
References: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
 <f006bb96-5d85-49a6-92ff-b40ab8030db5@siemens.com>
 <CAFc1U0uu3vBf0qx2bkzRXxQCuL0RFA5od4+AOvP6O6m4T9C44w@mail.gmail.com>
 <329cb61c-c663-4260-b240-55ffe834e71a@siemens.com>
 <CAFc1U0s9109_p_L2OpAxNNQVBbVV=Z-UHyvpQK7oqkF13N83WA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0s9109_p_L2OpAxNNQVBbVV=Z-UHyvpQK7oqkF13N83WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: e496bebf-6a3c-445e-36bb-08dd064255fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRablVnNGxVWWN1dUZiRXdJWWFYWnJuMTV3RFhBNzI1MFV2NnVqUzVtRThs?=
 =?utf-8?B?c2dRU3FHMnBCMVh5TlBBMlFLVEt1YVNUeDJwS01nVmN0TkcxQ1pBY0lvbUxo?=
 =?utf-8?B?SklqZnpWS09uZmRUMVZFWTFITGxFNGRodll0ekxUaHZOdmRNL2FuN0lKTEkw?=
 =?utf-8?B?cTVJU21IOU9DVlIvZ3VtelpGTXNwcHFkdXVYR0R2b293UFU4R3BSeTJ5d0oy?=
 =?utf-8?B?cXNEbU9HcVFua3dZdlVEUnloR0dkRzVwQ1JkaTJKK1F5bUdQbEhYQStIMWtq?=
 =?utf-8?B?T0VybHdvOGpnRURCdmpkWGo0eVhNUGhvWk5xNmFIcXNJeFR5OVdpTFVxbUtE?=
 =?utf-8?B?NFNqS2M2M1BVVWhzU21YOTZlbmNkejBWSXJDSitBWEJDZ2lTay9aeHVXTTlW?=
 =?utf-8?B?SEZkeDZzR2N4eW02bzRuSHFjK0c2UkhJaGhram1vNzJua3hadnBIMXdnaktB?=
 =?utf-8?B?dHdoa2tmckJBdlpjTEVhS3VHUzlTb2N6ZzhDSDRpM3huVitSU3lyazRXaWU2?=
 =?utf-8?B?c2pNanh0c2d2ajZ1S09XV0dNelovNm82NHdmWW1jTTRPUVJIUTFtbDRybEZr?=
 =?utf-8?B?azFqTXd2NnFoT09OMFkwcWVLVFVzcWMweXhPZFFWQ3JaYXZWd0Y1dmkzT1Uz?=
 =?utf-8?B?Y3pMOVFRSkExb0Q2ZDZlSUxQOTNUZ3Z2TGhRYTdseEFhdTF0Q21ITlJEczdH?=
 =?utf-8?B?dTN4Q0E3NjFJeno1WmQ0c05Ca0ZpcndweGtQdmYzUFBpcS9LQUYyTjZ1a0tB?=
 =?utf-8?B?VlU1YytvRnNZR09OUElVQXZRdEtSKzFKbnZ1N0VDOTd1VlJyZS9sV0dZQVBs?=
 =?utf-8?B?UGJPRjhkcHhZTTYzKzFvczgyaGlybWZpeFVrVGlGMGFsL1N1bGhwakg1Mzhx?=
 =?utf-8?B?U3dSQW9GbDhUODd5ZFpQSTFUZjRZcUFiVlZ4cG5ldjFvbUR4SHdLTTN2Z1dB?=
 =?utf-8?B?NEJrNGdHbXZndnhpTXJWTkY3VUdkYmd5U3BVMmwwQms1RGcxcVVLaFBSdmZT?=
 =?utf-8?B?VVY2Y0dLOUM5RVF3QkZ4WjM1ZCsreWNURXVmVDJVTTMxYkN1dVVpOFdUelJl?=
 =?utf-8?B?REhIVHJBU3JCa29uRHJJbGRiVmdXVEhtU21wRDNGRDZLOFVCT2lIemhIM0tF?=
 =?utf-8?B?ZDJsaDFjUCtKbk5SQ0hHQjZ0U2czN2l5OC9vLzc2bUp2MmNNT0VmdmxWbmd5?=
 =?utf-8?B?ZFVUZ21EbHFMSjVIcTRadVUyZXBHOHZTMHVJbDNKaFIzL2ZnLzN3WTdZL0Ns?=
 =?utf-8?B?b0RaSnQ5aXlWVXloaDlBcGZ6M3ZIUkZoQnBteEhRSmVBU0NNcWlCcmhFQXV0?=
 =?utf-8?B?UzNPWkZUZDRFbUNNdGJCSlRRTWxsNk1ZNjVBUEFiTU9TVnZHbUF3M0pEQVJC?=
 =?utf-8?B?M2tNdW5oKzdFN21YKzhUeGpKVExjcUpRTzFrMk5CVTU5QUwxdVY3K0N0Q3NL?=
 =?utf-8?B?K3Y3VzVPa1JNM2s0dmJyVlhoNHp5TUxxckJvWkhtSjV0RnVHMWFmOUs4ZG4y?=
 =?utf-8?B?eTBTdjJXTjBRTGRteXF2VjNHaUF4clBUNGJQRjVHTk10UFYwR2JXc1hQN0E1?=
 =?utf-8?B?WjBQOTZrK1dRek1QRjc0RitkMEt4VWtnZHRDU2xERFltTmw2UnpLWExkS2c5?=
 =?utf-8?B?Si9iZk91L2RJYnk2dFBFbTZ3RHhoNkh2QWRxZzBGVC9IVVIxenVTT2ZQSGM5?=
 =?utf-8?Q?XIi/jfs6VRgIilQR5q0G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJ3UWxyVXpTM3UxN2MrdnFKS1R4M2xZM3FtZzJwU3RNSENnOXNGeEhaRi9i?=
 =?utf-8?B?dUI1Tng2dlRkVktCU3F3eFkzS3JBSHd5VWNkbmtPUlhwajNiNjFIc0xmMjdS?=
 =?utf-8?B?VUFiRnNldE43ZE9EVEg1YVZRTXoveHR2UEJUcFZCSXdTVU94WjFDQmFlcTFN?=
 =?utf-8?B?ek1ORGttc0pqSllCcUM0YjhleHU4L0JXYWlUeEtCTXNXbHhyV0MyZzhzOTRv?=
 =?utf-8?B?Qy9MaTJkdGFDREEvUTZQMThlOXdjeEY0NGJIYWNjR0ZRcUZhUzNBclBNNjI0?=
 =?utf-8?B?QlIzbmliMm9ibThhVW1EZ2d4TE15QndVREhjb2ltWFBEWHZvTUpIZGtxYWtp?=
 =?utf-8?B?Nkg5dXpPWE5JMU1xY1ZEYlFBYnZzaTVyV2tJSHA0eDk1K2JxbWcxVUhZc291?=
 =?utf-8?B?SmlHdjduVnI4TFJqMlhiTFJiMDN2b0x2Y2VON0tOa2pDb3czMFRtUXdxcVQ2?=
 =?utf-8?B?N1pMTC9JUS9VcG13VUlGQkIvRTBSa1lGWFhxeUZ2cmRjcGJ5RVo2UXZzY1NT?=
 =?utf-8?B?NE9Yd1lkejZaVW5qMDZTOHk5a3ByNkQyUUNFZnh2S2pYcmE1Sis0UmViQ2dF?=
 =?utf-8?B?blhXSzFFQXdRY0N6SmtpNDhneHdQQ2hKQnhYMU1tZVhnRVhpTGpPaG5DK1Fu?=
 =?utf-8?B?SG54cVJKcElnaVVrVTdMVklJWll2SjhrSkVPWi9aTHcwSXJ6bHhQTEJydDNt?=
 =?utf-8?B?TDBnWTRWbFBINkJxeUpTTUptUkF2dkRicFhtdi9rQnhhcmpMNDBqNGt0MVYx?=
 =?utf-8?B?THZNM0E1S0xqYS9vR3ZGRnF6M3dSM3dmdUROazJ2Y3R5YWRXeFlVWUxra2tE?=
 =?utf-8?B?ZHdyY1h5RFJqbVJGWFRXU3FGc1JyRlFPSHpvTzNCUHNNZ3pUUytCd1ZiUkw4?=
 =?utf-8?B?b3QrWklFM05NcFhyaWh2TGxYUjhyaHJyTFB4L2NySENpQVNVbkZHSjFhVnUy?=
 =?utf-8?B?SVlQMGZoYktqbTc2akJEWVI5SEVCTFB2RUpnMWR0bFJGajhkRWkvaFAraTJx?=
 =?utf-8?B?cXByaUNTcmZGeThoQ3JmamlJRjROSWNWc3NPSFo1Q21ZUFc3VmpDejhUMjJq?=
 =?utf-8?B?cXBOSjdaZis4ZTNreVh3d2o0ZTc0UGFWa1NJeWhiSFdOVVIvOUxBeDN2OWtC?=
 =?utf-8?B?cldYb01uNm5CeUtiMUtHZ1VlNENYWDUvZ2NXLzI4UmJRUXN6R1MyVml0TklK?=
 =?utf-8?B?ZVJuQ1dxcGFhWC9GbTJ5MU1vLzV0dXNQYi82dEJRb1Nwd3BYcHFaNGxHdDRW?=
 =?utf-8?B?UEZDMnlTZ2R2c2lsMXBSME93dHlDN2hlM0JQTUxvSTNtUVFJSmpXaWxvalgz?=
 =?utf-8?B?ZXNHdmhMSmNpMjRRRlhJVW9kcnYxV0JjanZPN2ducndPd2Z6a1ZCQ3Avd2hD?=
 =?utf-8?B?MjNRZVk2Yk03UWR5MitzWnFhUzJMQlg5dW1SQTFBMHRXOXZHTERGQzZIL3VI?=
 =?utf-8?B?MEgvQURlZlRSNFYxYmp1Q210THdKRi9kWENmbVJ4dm1KYXgxUlBkcU4xWXBr?=
 =?utf-8?B?STFROHVBZUVKMEdDTHN1QUtEQk1McnNhd0ZPSU5yQXNieXdGR3YzY2NHUW1k?=
 =?utf-8?B?YjUrVjgyWFRvdHJaN0hxVDAyS3Z3bmJvcTE4ZHlVb0d1WW1oWEF0OHhjZUE2?=
 =?utf-8?B?OFJEcUh4eDcwdWVYVitybDZ3SUNHNWY2Z2NkRWNYaHZLSG5tUGorV1ZVTXo4?=
 =?utf-8?B?aDh3TXRRZHE4VTROR3BwaWhIbDRld3I1alFtRlYyVWx3SitiV0c1Tlhwd256?=
 =?utf-8?B?Y0Z4UktRaGlhU0dJTDBRa3NYYm9LL2NpYUNJYnlPdlFnS0xLQmFZOHRib1U3?=
 =?utf-8?B?REVEQ0dqK1NLWU5vQ3ZpSE51SWZiZ0M0WWlRNzBKdEVmTUJyMjhLRzgvVWhn?=
 =?utf-8?B?akpxN0puSGJPcE1pWW5ucGVTSXE2QkMrN3B6dlNVNVd0L3lKTHJBWGd2Vzl4?=
 =?utf-8?B?bkZoSVBqV2tGTUpDSUZnazlVeUlmVXRPRFRHbERHYTV2RDFBdk85NTErdTk4?=
 =?utf-8?B?TFc4OEFqSXgwam5LQUhyYU1Qd3dRNmQ5aXRnTzBrK3p0U0hhcFhlK1MwQjA2?=
 =?utf-8?B?WHFUVFJVUGhBNzdKbzI5WkkwUlRPazh2dFVkVEhWSDJubVVmUlhKN0NlN1hk?=
 =?utf-8?Q?gg1oR7ISKlCQrM56ya6NU44V0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e496bebf-6a3c-445e-36bb-08dd064255fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 13:26:53.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UafIGKHEOyoQQMItxpf2V2dZKt9el0OcDB0YFlpIhgywx9iRWn3+ukEWiO0YzUlpbmQvPs5olq8q9iUuewc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5811
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=W7RZy2mL;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:260c::62c) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 15.11.24 21:03, Pierre FICHEUX wrote:
> How can it be possible ??
> 

Check your fstab or mount units, they will likely encode this policy
(normally for security reasons).

Jan

> Le ven. 15 nov. 2024 à 17:15, Jan Kiszka <jan.kiszka@siemens.com> a écrit :
>>
>> On 15.11.24 15:40, Pierre FICHEUX wrote:
>>> Hi,
>>>
>>> AFAIK I use Docker (and Ubuntu 22.04) .
>>>
>>> docker run -v /home/pierre/Yocto/xenomai-images:/repo:ro -v
>>> /media/pierre/SANDISK_PF/Yocto/xenomai-images:/work:rw -e
>>> KAS_WORK_DIR=/work -v
>>> /media/pierre/SANDISK_PF/Yocto/xenomai-images/build:/build:rw
>>> --workdir=/repo -e KAS_BUILD_DIR=/build -e USER_ID=1000 -e
>>> GROUP_ID=1000 --rm --init -t -i -e TERM=xterm-256color -e
>>> SHELL=/bin/bash --privileged --log-driver=none --user=root
>>> ghcr.io/siemens/kas/kas-isar:4.5 menu
>>>
>>>
>>> The log.do_bootstrap contains the following:
>>>
>>> DEBUG: Executing python function sstate_task_prefunc
>>> DEBUG: Python function sstate_task_prefunc finished
>>> DEBUG: Executing shell function do_bootstrap
>>> W: qemu-debootstrap is deprecated. Please use regular debootstrap directly
>>> I: Running command: debootstrap --verbose --variant=minbase
>>> --include=locales --components=main,contrib,non-free-firmware,non-free
>>> bookworm /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs
>>> http://deb.debian.org/debian
>>> /usr/sbin/debootstrap: 1764: cannot create
>>> /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs/test-dev-null:
>>> Permission denied
>>> E: Cannot install into target
>>> '/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs'
>>> mounted with noexec or nodev
>>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> Your workdir does not allow the build to create device nodes.
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Linux Expert Center
> 
> 
> 

-- 
Siemens AG, Technology
Linux Expert Center
