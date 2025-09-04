Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE7270578
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000025; cv=fail; b=I5nH4alnnjsbzeCpll1TVK5fZUUecnup5bqOBqAA7Q+TEAgNFmmK3mbTCKDcO3ExP0n6X1QC9PSblErn4eDR2de97FeaU4RWt6j9f3PVvZ+q+jA/NGElLXyDNC42GJOu/tMQuSOIq5820xEVgZ28LoitLz+Z1UOWnxyJcjEydmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000025; c=relaxed/simple;
	bh=iTNCr1pEi8DzG1CFHX5Y3FMdEXJLohjXA9V+gu5bsSs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TG96AzalQm5RemiTu2ia5XBOZwdT5yFboRrentPTNFNsoj6eWVaopSR8ExYKzQOexpFUNRk+YsZTgtUD7uCTpr24ZkD60x8bVXtU8ZURkU0D8Aq4OEozuUz0eTE+R/m09nKnKNOrmpdti6K++6IYQW6tGa0H9kfJiP9q3fjNdNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HOBAq+jY; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HOBAq+jY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJegMQZKbkoUfmOC4Iq3ygPa/DQOrvBHrM0p8f2TrASZo/UX+LFOTdIBmEA2IFasxco9xnxXcOB/GaRwF20cq9P4PRxCaT14N+KXq/vzsrIhxE6FEfmOO9Z8KmLQH7myKMB+0HdQzYVkKHJbWonf4oo6GQ5PWMXdhKLFRlI2Jpb5fAMZQAXj/q35ciIXzqzrgKFvOi7ANjAokLNw/904PmS1LsQZG1AtxWRu2hoGF9fv77L7rEud2tCQrHDIGU5t1a/c4W4JcsE+wYDYonOamIJQm6rhcNmzXHGY+DurXBRVc4mQUWIsVTtgmGv7RP5HMlnU6s/OuUETFvWxMKyKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1lOeyUuRH6rENnfHua1yOTIESjQwK0LXidOYtwef2s=;
 b=kn9+pD2BYV/nocJFxBF3jlxbeM8jtAWQjmEBdj5M9kpEFYZxoYs+Yhm+0lKaAoJ6PV4aEW3bKcoJUu0HuWukI3BLbcxxvuHRB5FnhLhd+8Gh/QtMSs2eKicSzrRB8grKvAFzyB4xBQy8rkSkMP3oeeb503xGqkn2rzLsBW1a3y/AzQQDrao1qN2S2ZmU3fXZdZBc14tLw2CAUCUuylmmTucv7QAAYU6hcZ5E6YXJ0O9jr8U1xdswDF87hlyr9wPQflXum0SGJtZTMMOdFat3+plXvxCqbxbI4g/7T2vejYi/rSc1cToHByuMV/uhBaj6HnnkwU8Z8Gyug2f5HrmOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1lOeyUuRH6rENnfHua1yOTIESjQwK0LXidOYtwef2s=;
 b=HOBAq+jY00qwLsrhWHGxl+a4wBTmeR4yfk2fBoSL3oSKSSawx1wZpXS+F5jIFuatIrzdJ8/yaviQmtBgm5DH2aSGAgOaJYwA8y7xdNUwtf5XRYVAGsDQd2J/jxWHrhgiJdOSlTmDRGV1zcGkb7eESyk25OuFy6ltAagCVzF2BO0q3NxQ2FKBAGCMOkQ+Aecf4p649z6xsL7pWGAR/vyhwpQR1aUQ1ucUYunneIk8e1dpDYMafcHl/w8PPlpQrg5+iV8zrNtWbSLUqmrdUnW/nwI7eYTNJnZfTP53mD87lv4hVHbHy7fhGMMSEBZdq2srvzp/ClJ1y/b1sbhMzWPjFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3846.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:33:38 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 15:33:36 +0000
Message-ID: <07a52824-3514-41ef-9011-69d344ff4611@siemens.com>
Date: Thu, 4 Sep 2025 17:33:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Retry LAVA boot action up to three
 times
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: quirin.gylstorff@siemens.com
References: <20250904100307.1096684-1-tobias.schaffner@siemens.com>
 <def91a5f-1642-4374-8498-9863468f115c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <def91a5f-1642-4374-8498-9863468f115c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3846:EE_
X-MS-Office365-Filtering-Correlation-Id: 28619abc-0a54-43df-3899-08ddebc86a0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXVSRHFVdlNxa05KYXRNaE9kRG1xdnFDNCtVdGdTbnhBVmlWdnJOUlBsWCt6?=
 =?utf-8?B?NExwUkxPeGJ4TmNJWFI1b1QrTDlBQmNNSEhVL2JVSDhwVnI4MzlKQWY4NDAw?=
 =?utf-8?B?TVlIazl2QXV1RkxLMXZlM1dIQW5lckRDNVh2cVFkR1BFNExaakRwa1RBQXVh?=
 =?utf-8?B?cEpIM0Y0aEJ0KzR5WTQwUnQ2TkNCWURLM1JWZ1VEU0dEMllXVlRKL3V4RjZy?=
 =?utf-8?B?SHdoZ3o3Vm1QVkVFSDRNOG1FNTV6ZWxQb2dQSU53ZnVkenJkMzk4Zm5zV2V4?=
 =?utf-8?B?Z3dNemhGYnhEVkFEd2lkcHVXRG9GM053UzJSSklPMlphdTd1dUpKTjlGSllk?=
 =?utf-8?B?SjlodFNrcDZIWjUvWHJVdHlLa2NEVy9XSWhYY2pxcDczMDViQjA1eFZmZlp5?=
 =?utf-8?B?MDhYMDVxOUZKaXQrbWozRTlVbzZNa3FERGJFREdRNm9KZzdmQUY4MlBZUmNI?=
 =?utf-8?B?bU95ZzRMNkhtRjhrMFdTc2lxNnNiODg1bXQ3WWtoaTBvRHJ6MlMyb1psdFUv?=
 =?utf-8?B?UUNsV2RsMVNuRVJzSEZRbGZXbnpUd0poNEcwRUU1RzhWN25UZDQ0YnlYSnl4?=
 =?utf-8?B?U1owVkxnUlNkdG5FU0FoL1F1cUg5U2ovakdoeU9nMytMU3hXTGYxdmhFRmhP?=
 =?utf-8?B?ckFrczVVNHBGelhySnJxbitXTG5LNVR4bTFCUnFlVG9hNEJyU3NQYnBLbVdY?=
 =?utf-8?B?ZGRnbnlHSWU3bTFQYU84RTU1dml4WVV2Qm5KTDJnVVlFTnNsK1JwL0ZuMUZJ?=
 =?utf-8?B?RTdiNnNORi9lazhtbWQxUHJ5bG5FU0ZvNEpNWWNQMGIvT0RTNG1waVlicUFp?=
 =?utf-8?B?emsra2Q1RlZaalY5YjJFbGxUK0tvUjZEN2JDaWFHOFFZOXkvMnpIVVVoUGdh?=
 =?utf-8?B?UzRNVW0yNExLOUJIaFkza2MwTzBKSmpuQXFEM0ZxSFJBRHEvQ2kwOHRXSFpj?=
 =?utf-8?B?UDJUai9FQ3VFaXFqRWVIcFNSem1tZWl1Y1poREs1bk5MbDlJbTdvdVB3NVV5?=
 =?utf-8?B?RWJOM1lsNDNWRlBTRno4N2Q0WmxlMWhoMUVXWWNaQlZJZjVnZERGTHBBUjcx?=
 =?utf-8?B?ZzEwVkJtMkhNaWlrNVJtdCtJTDcrRWJNOWNNUGx1TXJrQmFpVkZTL0hpZkd0?=
 =?utf-8?B?SktnVUZFNjRsVVN2OUd5QlI5VVIvOXlmZlhidEVIMXdad0h0dHRDdkhTaXZm?=
 =?utf-8?B?OWVhTkp1dC9TbFNoV2pTczFORFRWTXM1djYxbWNqU0FmZFk2c0dGK2lYUmJp?=
 =?utf-8?B?TE5GZmdrNEpNc28rN1VjNkkrckYxYVNRVFY4U0N0K2ludWRTYUJiWnU2bm9y?=
 =?utf-8?B?d0lkUkhVbnBlOStDN1huMEVKbWd5N25hSEF5ZCtOSFFzL3lHQXhGdTZ1aVFi?=
 =?utf-8?B?UkJpeGJkNWdrMXNoeFdQYzJnUEhaYk9KbUNwV1RlSnlxMFFJSG9WUkpqY3gy?=
 =?utf-8?B?NlZiUDVFTmNoQloycEJtdThGaTB0ZFRDV09SZDFWOVhMK1E1L1JvUnQrbWJE?=
 =?utf-8?B?R0hZTllqWitIclR2U0taaWErWldxUGgvdXdhTDRpWDdQdTR4K3h6bHJFcWdN?=
 =?utf-8?B?aFVMU2RGeXlwRC94a3FRQ2ZHRm1NbW1vVzF4QkRiWmJRK2RnT29QZXpnbFRs?=
 =?utf-8?B?UUF3b2s3N2tqZi9vUkxRRy9CUGEwajBwUDc5OFkzeXNyM0xMK1BBUUsrd3Bp?=
 =?utf-8?B?bHhzMEwySnR3aUloOXZKQ3lVSXlzUVllQ21ubm5Id2ZLSEJNNE14dytoazdJ?=
 =?utf-8?B?cGlFb3dXM3NmREtpalltd3hIQW9Kd1QxS1JpSVNLWHNDbll3bVl3ZXgyMXZt?=
 =?utf-8?B?MVI3ZTNUVHRUOXhUZi8zbWI1c0x3eEpxbkRlWnhtNXk3SVRkZ1lrMCtaWTlu?=
 =?utf-8?B?K1p2UlpnalRWWlZ6WEtWbStaYVRmUHFMTkRwRndEenFzZGMvaEM2ZEU1OUE4?=
 =?utf-8?Q?Fq0exbp3Ymc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3BNSGpOZUorQTRHYTBiTHgwd3Z4U3lWcFVuaFN5OGhqejMrRzFRSzNUS1oy?=
 =?utf-8?B?b0p0T3MyUGU0UVlpWCtzbE13YnZCbE9PTU8rVDBlY2dQdHRlWFN4SmpwMjNl?=
 =?utf-8?B?K1N5VUtpQnFQaFkybS9UZkNGR1RINGxaOTRiV3hEM0RQOXhQbzY4STlmdGpS?=
 =?utf-8?B?eGZTKzdyejYzaUREUldpWHRYZkRwcXBnZWhqd1crb212UEdGalhGM1ZwOVNZ?=
 =?utf-8?B?K0ZDY1ZteS9YM2hHc1hRWXh3UDFkNjFjR0t4WDRvd0lrMThEQTNDc3Z3MDk5?=
 =?utf-8?B?YmhHZ0N1bTJQUklNVEpRcVU0RVFvWTVFYUpxbnlRQzNNSmFTb2pZMkRrdlBV?=
 =?utf-8?B?RWp5ZG1mck9oOEFOeVh0TytuZE9NRFl3eTFjMkZsb0UwTVBWY0VGZ2Y1bTYx?=
 =?utf-8?B?Ykt5SnhVZmM3bjFZQit5RVNwdC81Z1ByYmw5UHY1SVJTQXJab1Rzbk01ODBk?=
 =?utf-8?B?ZVFqbVBRYjVUV2lVSThPTWVETXFMVVVIM0IrdzFUNTV4MXhDYnJkaiszbTNk?=
 =?utf-8?B?bW04Q2taWjk2bGlrV01XMXExR0xHL0JlbEc3aU12V3k2SnpiL2JiTHdlQ1Jh?=
 =?utf-8?B?VldjYlRFNUlRM1FTdmJSOEhTWG1sVWxMaCtZaWI1RU10NTA4aVkxQlNNZFZ2?=
 =?utf-8?B?Rzk5YVJWMFFrNmMxcmhkazJsRUR3WGZpeFBhaSt6dENiWHhnb2NUeVFSVUdl?=
 =?utf-8?B?Nmw2NnBSK20xVXQrU3FBSE1nRExzK2x2NUpuY1g5ejhTMFFHa3hKZms2ci9i?=
 =?utf-8?B?VUx5ZkR4SDdhb2Jtb3RwcEZBbmdVYktvc1hCQzNZR3daQm5kYjVjN0xJM1V0?=
 =?utf-8?B?ekVIOXhCOEs2OGZWRnVUMjRpazNSUFdBV1QvYXRRU3FrbE5rZ2drQitwNU4w?=
 =?utf-8?B?dWY5d3FybEkyVWxGRTd2V3ZYVFhHRVBLTEZ0bGFUZFdoWWk5ajU5c2tNYm44?=
 =?utf-8?B?dkhOdThDVjRTbksrbnpscWlkc0VndTgrc053QWE3d0RKWGVPWmJubmh2dzB2?=
 =?utf-8?B?NXE2bUlvL255KzcvdDROU1RYUWthd1NTMWZ0L2RlNjU3cFduOU9XNmdOMnhp?=
 =?utf-8?B?VElWZG1WQkQwWGNvVDhIZEt6WTJNN3hUU3BaUjFROHQ1cnkzUmliOXR4aUNa?=
 =?utf-8?B?UkZhTUxOV09vRHVaNE5PMHltKzhEV3cwNm1Qb1dIaWViaFZGYlpIekRNaVM0?=
 =?utf-8?B?V29Ma1VjY05oLzVadDhsS1pBUWl6cUgrUmV1RVJGUUIwaGgxL1VxR2pIUHdq?=
 =?utf-8?B?QTZ6VUZ6NmFETFV3Q21ZY3VXUVZPSlRMYmhDbjk2UTNOOXhCTTM3d20rZ3hK?=
 =?utf-8?B?b0hLT2hVY2o0SmJ4WDVheHFidm5iWEFLeU4wdHhCdWlpclRyanRYTHc2UFMx?=
 =?utf-8?B?WEFwM0dHaXczc1JnVXg1RDZKV2lndElsQ2VMSWpHdHF5L25aNlZ2Rm1EcnNZ?=
 =?utf-8?B?M0dOQTFBUXdNYytaUmhVZHpzT0U4QUJpbkkzekRXbUEzNEFOU3dwZmN2cGNG?=
 =?utf-8?B?WkJFcU5nQzkya1FIYUYxTjZlS2NsY2VqSXV4VnRkOEF5djk1bXFuZmozanA0?=
 =?utf-8?B?RjRVc1VzREpuUTcwaGxRanN6a2Yxb09DREhLaFBKVStoVk5sTndmcjQzai9Y?=
 =?utf-8?B?WFRmWWprdlpUM1VGYVZZWFlCdklibXNESUJhaEViZGhKWDYxbEdxbkpOaDhH?=
 =?utf-8?B?YktTMlpJelBKUmhHdFU2TW0wK0Q4ZlBxbFJtaVhHM1M3YWd5Z1ViMGNDUUc2?=
 =?utf-8?B?SFF1VkJPVXNScFU0SkhhdXQ4dkJ6WXo1cUxrcnBKNGxIcms4eEV6TGVmaTlD?=
 =?utf-8?B?UVd4Z0hHVnY1ZjVWaVlTZzA5RWhFdkFIa0I1VWlMZThlSEVsUzB6KzFKQWd1?=
 =?utf-8?B?TlRDckZHVGRmNUowNWR5cUhJS0h4Q29Qbm9vaVovLzFrSFFmb0U0cTVvWmtx?=
 =?utf-8?B?T1NxdHYweTJESERBRC8vcWhlVlUwRi9MbDY5RUtQY0JFZHRDaHdOSzB1REFX?=
 =?utf-8?B?OThLRXU1bVprQ1FBWlNOZVhkdUdiTVRHV1ZmK2thN2ZqeTBBTzVFalpKbDNi?=
 =?utf-8?B?Sk0rc0kyT2RFdXJKMTRGYWNTMmNVWFNjMFhHV3g4K08zcFNXNC9ySVdiNkRE?=
 =?utf-8?B?QU9YcW1RQnJJNU81aE1YU1E2UERoYjFjN0RRUXJXVlRxcXZaMWh1OUUxenVj?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28619abc-0a54-43df-3899-08ddebc86a0b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:33:36.4227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeFky/7bsIF0PuBzW687WNT6ulAOKX77dbJsIT52c21/FrBpJDAgpiQgVWaoSQDkJxjp2V6cKk8EcRQ/ALzmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3846

On 04.09.25 12:16, Jan Kiszka wrote:
> On 04.09.25 12:03, Tobias Schaffner wrote:
>> Increase test robustness by retrying the LAVA boot action up to three
>> times on failure. Failures are detected via server-side error message
>> matching. This logic will be refined in the designated repository.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>  tests/jobs/xenomai-beagle-bone-black.yml | 1 +
>>  tests/jobs/xenomai-hikey.yml             | 1 +
>>  tests/jobs/xenomai-rpi4.yml              | 1 +
>>  tests/jobs/xenomai-x86-64-efi.yml        | 1 +
>>  4 files changed, 4 insertions(+)
>>
>> diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
>> index 8e47dd6..b7a95bc 100644
>> --- a/tests/jobs/xenomai-beagle-bone-black.yml
>> +++ b/tests/jobs/xenomai-beagle-bone-black.yml
>> @@ -41,6 +41,7 @@ actions:
>>        compression: gz
>>  # BOOT_BLOCK
>>  - boot:
>> +    failure_retry: 3
>>      timeout:
>>        minutes: 5
>>      method: u-boot
>> diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
>> index aaf8949..27beb07 100644
>> --- a/tests/jobs/xenomai-hikey.yml
>> +++ b/tests/jobs/xenomai-hikey.yml
>> @@ -40,6 +40,7 @@ actions:
>>        compression: gz
>>  #  BOOT_BLOCK
>>  - boot:
>> +    failure_retry: 3
>>      timeout:
>>        minutes: 5
>>      method: u-boot
>> diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
>> index 50ff9ee..4074825 100644
>> --- a/tests/jobs/xenomai-rpi4.yml
>> +++ b/tests/jobs/xenomai-rpi4.yml
>> @@ -40,6 +40,7 @@ actions:
>>        compression: gz
>>  #  BOOT_BLOCK
>>  - boot:
>> +    failure_retry: 3
>>      timeout:
>>        minutes: 5
>>      method: u-boot
>> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
>> index 4f1a7d8..0014429 100644
>> --- a/tests/jobs/xenomai-x86-64-efi.yml
>> +++ b/tests/jobs/xenomai-x86-64-efi.yml
>> @@ -41,6 +41,7 @@ actions:
>>        compression: gz
>>  # BOOT_BLOCK
>>  - boot:
>> +    failure_retry: 3
>>      timeout:
>>        minutes: 5
>>      method: ipxe
> 
> Thanks, applied.
> 

I think we were retrying here, but it did not help :(

https://gitlab.com/Xenomai/xenomai-images/-/jobs/11248170239

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
