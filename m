Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA831F8BD6
	for <xenomai@lists.linux.dev>; Thu, 14 Aug 2025 05:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148398; cv=fail; b=diFMwEvjPN3SuPMIjR1TldVz+FTHeWlZJ0aVcYfkHzZDUoOnsp9PL80olt9OdP8xE80lQMWalxxR06rFKl14RYVt6P00XOy7zP1hJO1YE/x+noCcmsEFpgl8th09j90J4KEWd+taqtX5+bg1E51LxOT7+S/RVmuaOKkAP4CTpHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148398; c=relaxed/simple;
	bh=mttV7aY0hJHCQAjDYXBsujFdHQCQCxMxo3HRb9NUnVg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LuMq7VU03vSVKY8/vSg/HK7pDy3kHDepBFGNLL+Mt/HEx3MBKLXGz86AbH1hPJR68Ox950cMSacWPlRj9ViOiaoPI+9XCRZOB9JgUP5d6vJuCLzB7yOlvI8a5q6EPAuLJQvKbBhStWaZ0RDi1/a5S8kM2CV+1LN6gXqLOzj6YIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YkDxkJ0h; arc=fail smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YkDxkJ0h"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id C6F814363A
	for <xenomai@lists.linux.dev>; Thu, 14 Aug 2025 05:13:12 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3422A740034
	for <xenomai@xenomai.org>; Thu, 14 Aug 2025 05:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDsZmO8trOAlq5zDKetf3baZyhKh5MG/GbFLzcskTonDVjvNDBd5+yebJI45TU90cUMK78p44FXkOotDlr/zKicCce5ohf7GAWxtD7cCwGHS74HGHBlKw6eAKl4udvbjFn83MF3AnQHOfGwtgmpSyYG4RG0RK9/4QT113K3tnVp7Rqd0Z7va7iVGXohkjbkhR44+hw7FGHdYU55/C+kWHU95tMraiftH4YtzpGKbDrkKfysSoOiy+tDuhU2KgraE9YKMqZgDQgZA1aZWtYMg33IJBD2n8O5s7EE1NEoGzfsKHetu3O3JkA+uT+fLNu3Bw8b77js0W/bn2Nv0QMawVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgPSst4aCNVZzmy8fkKo2s5vU603MsaJw2IGCtvyv4g=;
 b=xN8M1ybtc5OhZbjEkkcmVDKCUFl7wqxkrCJPMjTKfIdcWaIQxvAmRwwi3uK2K7NcuAdSU2SndHsv4YAGZ4Ppn32ONzlrOJeKiMrEp/HdM0oX36Qm66cxcmBaitiPC5932FBtUpkMbG/MBkmuaUSKfl2sTVQUgU2cE/ESD9BlAHlyyl1vdIz6lpJpNlgmvLesgaIy3UqrDmdH0jrLvoy8NbyA2bl+Ut+M9ptFbTr5ORImsBfdBIZlboDuDPR4KbZ0+TcjG0GFZYMky36T9Wr5zpSp3e272ev+LpuqSiVPY1YIWjJPzJlVj2uBvlRXswk/12Y7eiVbZIWtLwzCJGLtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgPSst4aCNVZzmy8fkKo2s5vU603MsaJw2IGCtvyv4g=;
 b=YkDxkJ0hnexZjUGdx+Uxga6OOKZKS1w9s/zQXdLoq3VmVYUxsqdr9le7Cj5d3oT7EZ8jHrTwdFqX6H2wajCPxPyXmRtggkNkBvUnwYDIp1OlGbNGWBrU/fFHbkgVgnYBSQgBYTWWrL6uV2PpYSmGezich/zFo0XIflczDT+46+TYzeySGH2y2ZKJLHD2lAqvWS+KiETkZA2iKeT8S4XloerZqYhtm43KK0VPsbxXmsQsGVndCs7Z1Bl45klNbpgjSOvns015Dztnx0+C8EvHVdVo1FJ3gWhEru5Qdd4cKKnZW5TTSwS/syKfEvjP8Og2cZ8HiNb2fPzov/GUHfVzOA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 05:13:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 05:13:11 +0000
Message-ID: <2bfd15c0-5f34-460c-b17c-5663892a4fde@siemens.com>
Date: Thu, 14 Aug 2025 07:13:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry Regarding Secondary and Primary Mode Behavior in Xenomai
To: =?UTF-8?B?7Iug66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Q=?=
 =?UTF-8?B?7Yux7Iqk?= <mincheol1.shin@doosan.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <PU4P216MB13538930233E2B4F3D7F2EB5A935A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PU4P216MB13538930233E2B4F3D7F2EB5A935A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3909:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d4c97a-2987-4246-dd9d-08dddaf14349
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlGdUZLUmt2MktxSXRIeVJqd1NjNVg3cXgveCtmemFWQ1RjZ1V4R3lHK1Nt?=
 =?utf-8?B?UDEwQVpMZjBkTVZCcGF2V3hQRExXRDRUNG8rclJ1ZWxWbmxCYlB5VGRVQTA5?=
 =?utf-8?B?TDI5c21kc01MTnNGSEtkallkSUhSWGp3eDl2cVpWNVFvaUFJcFZOdndhNnpr?=
 =?utf-8?B?NWtGOUdIYWR0RkJtSStNZmZ1NTRHajBHSThWN2dOOEQ5ejA3ZkZMZlErL0ls?=
 =?utf-8?B?a2VhNm93OWI1MmNFSkYwTmZmK0xiZ1Bia21kL1VrdHlRQ04rRmhkZ2ZBYitJ?=
 =?utf-8?B?VjNpbVNTQzVqZVpHYlRWeEwwaUdSQVFiM04va252YWN1djF0QUZYQ2lka0lS?=
 =?utf-8?B?L0FDc3FVWDlMaVBRa21iTEEwallsRzg3MERFYk42b0svWlVhdVFuWldZNm85?=
 =?utf-8?B?Z2M4SUFjRVFTOTdTS2E1RDAvRWxnVGxXMmRNVnRrTTlIOGhnWlBYYXF1SmxG?=
 =?utf-8?B?RFhaTUREOGtVdWtpMUhKSW50aFhqMnlIVjVOUEU2bjU3YUJDamI1b0ZIOHBu?=
 =?utf-8?B?QWk3VG55YVpvemNkYTVmS01rR2xyd0hFaUZteDloOVYwd0NWZHpRTE4xSFdv?=
 =?utf-8?B?cWsrbHZiYUNtTlJ3QWJNUVV0MzgycyttZm9uUTRHNHAwQWtadzhUZVZ2L3ZG?=
 =?utf-8?B?MFI5QkZ2UDVDbmxBSlJnUEF1eU1UWmEvTVVCU3oxTldGN2VjTGRSZ3B0TWtB?=
 =?utf-8?B?NEk2U3Z0ZHhVekpmQUh3a3g3VFVGNWw0RTN4Ylk1SEwySEtLOTExd2Y5a0dv?=
 =?utf-8?B?OWJ3VGhoTkx4bDQvK2k5RURFdEZEQmpBa0RGT0FZZzM3dXBORFA2MzR2UVY3?=
 =?utf-8?B?dkp0MHJrU3dUcEtqS3pPSE1xTE9xQzlkTzlNZ3YzTXVoWXc2ZVNyM0ZUT0RF?=
 =?utf-8?B?eWFPbXh1SzVoUk5WdVhySXEvS29GdFJ4Umx3bGFMdUhhN3VIeGtCbmJhck5E?=
 =?utf-8?B?b2ZGSFNJck40eG1tTTBXMGRaMlQ1U1NHVXBzeVhWdGZCaTNwdlZmSDhzWHBt?=
 =?utf-8?B?ZWtGMndhYUZKWnhQTW1OVWNQOEZONHJlSDA3WmI5TUN2Ym5lWlB3WnNMbS9q?=
 =?utf-8?B?UStXWkdSMGUwTmNHQnlXdVc0Y05CSVRzbk5XMDBadTcyeTJzcnI4c2ZaWkJ1?=
 =?utf-8?B?Um1ERTF1THhRdkFXVWVjSitjSldvUFJWcUdlVmlUSGhmazAxWkFTb1JEaWpi?=
 =?utf-8?B?Tm1DMjg4MWxyVHloTUdzZVNLUmQwMTNzTkhsK1hXc1V4WVZiK04rVG9hclRo?=
 =?utf-8?B?ZHY0dzE0dnRoNFlFSHNsUzFaQ3VaaTd5UGV0UzVUeWVKUmZTU1dEekRRRURk?=
 =?utf-8?B?NXN1QXZ4ZVVuTnBzTkRaNE1DWDlseWt5bnZzcHZPVDV0dU1aek9IV2ZWL3Zq?=
 =?utf-8?B?SGw2TURDcTJVMXpYTWdsVlFYajd5YVFNN0ttZkRUQTFxK1dZNGNiVHN6SlRu?=
 =?utf-8?B?Ty8zYjFmR2RUdGJPT2hWVkpTekx6UnRWaTg4Vjk2b0tDSkZlbjEySHM4RHB3?=
 =?utf-8?B?TXhMUk5ZV2M4Ylh2QWVMbUh5L2VlWnVPNVAwMU0wTlB6NStIaEs2cnJQeWQ0?=
 =?utf-8?B?dUMrU0ZzUUJnV0x4NW1JaFBPN1lJVVU3MGcyRk1zaUMyTVc5aUVOZ0J1SmJa?=
 =?utf-8?B?TjhaWVYreTlIb3M5bXR2eVpqSjF5Zm1NSEF1eENwSkJIM1F6TGp4eVB5L0sz?=
 =?utf-8?B?TXByM3k4alNMeEpPL2dhUFJOOFF4MTRiQ20zdXFZVjZjdDJ1cUFXbHZZUmor?=
 =?utf-8?B?TlBzUlNnc3Rmckk1ZFk5Rkt1YktTeDExaTV6MnBIbk5NbzAxbnhpc0ZZZ1ps?=
 =?utf-8?B?cnozMXhmKzBEOWxZNTBqc0oySEhhZUhyWWZKR3FPNlB3cUhZWW5qR0pkWlRD?=
 =?utf-8?B?R0YrQ1hRZjhsbDhYUnYvY0M4MlBkbXZQanI4cm16K3Vqc3BVRXdsOXlUMHJV?=
 =?utf-8?B?T3paYzdQVHFXRGtDYnMzbVVycWVraUM2WmNZckJ0QWJKaWk5Vm9sOW14MWtz?=
 =?utf-8?B?K003T215U09BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnlpdWFoMFNZZGtmMkN6Nmx0a2VlYmhLbHc1UHA1dmVlSDFzTEJXZEdZM2ll?=
 =?utf-8?B?ZDd1WHdlUDZ3Zkp2K1lFZDlJWU1GODFUbitVR3R6RDlRYk8zSHpYUUVxdjJT?=
 =?utf-8?B?TUhDN2NzWFZ4WEllZ1pTTWZTTjB3VDg4bDZiVUlFWWZ2VDh3Ti8wRG1jODJr?=
 =?utf-8?B?U0hIN3hQdEJRZXpMSFlXVGpFcVovU2VFYW9NQlVRWDRrQ3p1dWlUT1NtL2F6?=
 =?utf-8?B?Q2phNnNsTGhvT0hZakdpWkNRMnlTVU9INXB2bFBFY3FvNFEzTzVWaDFUV1lT?=
 =?utf-8?B?b0RyZVBaU254b1FiQ2xUTm5qRkVyMVBEOWxHQnZwNTU4YmZQcjRoQm93THNa?=
 =?utf-8?B?a1ZDNGtvbURjV2RxVUZkZFp2aXBLcmZBTkJieHdINC9kSTkxRDdGM2s4T1hK?=
 =?utf-8?B?Yk1LVmhnNWgrZThyeWJUYk9OMGVQUndITTJzL01keTA0NlhLV0sxQUx6UUc0?=
 =?utf-8?B?UkxubU5tWlhsdFJQcUtiVXdIK1JIbENmUTdYMHpXaXY0UUYzc2Q2Y3JxVlJx?=
 =?utf-8?B?bmRoQjVpaWtIOW1yRzBBR2p6cUI2NmpLWWwxTnhQSVFFQmZuYWRDcXU3RTA4?=
 =?utf-8?B?R0lPWkIxdGNlVERzTm9Vb3BRaFZnbU5NWDFsbDQ0cjhaUDhyWXpoamlGUEhD?=
 =?utf-8?B?RFpabU9ZODNaaENLaStBVUFPbnNWTXMraXowdGx5QmdiSEFwT3RZUnVXTks5?=
 =?utf-8?B?YzFZanI3azhEeDdJazRuc1M2M21QeEN6VnpDUE9FbXlUdWczTkp6Y0t4NThE?=
 =?utf-8?B?YmdtRFhDbm14azRlVEJnRGVhR3JRdkErbnJDQ3RwU2VGbzFDcGZGcW8zbExm?=
 =?utf-8?B?MlJXVFhROExCQ3MwTUlPMkFKb2VkSzk4Y0ZFSDR3SC9jZUZZUElnNDJoOGVk?=
 =?utf-8?B?VXJjaExzc2lURjltTEN4bTdQR1NQMXEvamRxb3gwVkI3bmx2bU5jTWVzeW4w?=
 =?utf-8?B?WUpFNTNLKytyUkZDZ0RJQXdsZDhUcHJBeEtMQnY4MlIyalJ1QlNHZkFIMEJu?=
 =?utf-8?B?b0x6c3ZlSlk1a0NacDNtWDBlbkN6REFBQ1dqblUzR0ZUc1R2aUx2Kzg2elQ1?=
 =?utf-8?B?eVFBb1pTbURGc3lCRSsyNkQxRllJc0VxaExBZnY2Y2JpcFBnNXAzRVd0TFlG?=
 =?utf-8?B?RHpnY0JBZ1RlSnM3WlhmVURhc0lPWlhyZWUxVWJMWWR2aEZtYjRYUE9MdE9o?=
 =?utf-8?B?RUdnUytndWVmZHBMUFpheTRmeFFNcjV0ZXZibFpZdlBkekNBYWlsZnk5R0ph?=
 =?utf-8?B?ZWRqRnZUbHRCbGRXaXJmdXVLYXR2OUdZaHdIOGtrM21qTGFzR0s3UGRuakhk?=
 =?utf-8?B?dnZOcVd2TExsQUl1cm1qL09nZkJ4RUN5TXRmZDBBYkh1VEZVdDdscTBCSkZa?=
 =?utf-8?B?b212RHM1Q1hwYms3elFpWERBUHdGSEFvMzdFeEYzQVV4VVlYaW0xZXhaeGF6?=
 =?utf-8?B?cXBZNjRzTXQ1U0QyTUswdGdTMS9VN08yZjFzRUg5TEdaNm8yL1Z3TWdGRk5N?=
 =?utf-8?B?UGpGZkNRYnBmejFnaUpzVlVPT2htNjJQaUlYTUJQam81M21kem9yY1BpemNO?=
 =?utf-8?B?YSsxR01QVjBPM01JUEg4c1J3U09IdnhnR2FxZmlCV3MyVnE2ckNvV3hMZ1d6?=
 =?utf-8?B?UVNmdnFPNTZpcUhZQmxRa1EzTlZaTUVhMjhibCtiaEpza05wZkhLWG85Mld4?=
 =?utf-8?B?aEwzcHN1d1JvYk1EcE9BWHpRaUkweG1jcE9FdnlTQUdQM2NpT2NIWnZjdFJm?=
 =?utf-8?B?dnNCLzFIeEVGZ0FtZ0UrOE43K2o3ejNVUEYzaVlqcXpMelplWExSZ2t1clpU?=
 =?utf-8?B?ZXVLTmxOSEM5WVIyS3Frc01ZaEY5MktuU2srUHhHV3VXT0lGcXVuMU4rMlow?=
 =?utf-8?B?SVFxRmhKdUx2WkM2RnlCL2JXODR4djJYcHpKN09SVjlGSi9DZEhIN3RNb1Jr?=
 =?utf-8?B?OWdTaVl5QUxWWG01NGJyUm4yRzdSbkhGdm5NclNUdmdMdXUwd0VwYXJCVVN2?=
 =?utf-8?B?ZlIyUHVzMVVpdExUemdMQi9nS0hweXQ1NjFlUk1qei94dHVvM1ZCM2ZEa2VZ?=
 =?utf-8?B?TEFXT2ZpWWZUVHgzOGllM2dFclhGQ2N6dXhYQlRXc0lDMDdBSHRaaWJOc1k5?=
 =?utf-8?Q?fhTKyDB3+Yqmo2ZGcNc2MFdbl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d4c97a-2987-4246-dd9d-08dddaf14349
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:13:11.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5ay8e/Okb50XroltDv0iJT+RVlKa7MfEN6sKPJ1hkCCFGue29sQ/MPZYt52bZVfPh1J8o9m6H33k97IkYX0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3909
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=YkDxkJ0h;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c200::3) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnheptdekudfhvdelhfefvedvtdetheegfefhgfejjeehhfdugeegfeekgeejvdeiledtnecukfhppedvudejrdejtddrudejkedrvdduuddpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduuddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 14.08.25 04:29, 신민철(Mincheol Shin) 선임 두산로보틱스 wrote:
> Dear Xenomai Team,
> 
> First of all, I would like to express my sincere appreciation for your continued support. Thanks to your helpful responses, I’ve been able to successfully build real-time processes using Xenomai. I truly appreciate your guidance.
> 
> While developing, I’ve encountered a few questions regarding the behavior of Secondary and Primary Modes, and I would be grateful for your insights.
> 
> If a main process transitions into Secondary Mode, do all threads created by that process also automatically switch to Secondary Mode?

Nope, only the thread that triggers the switch via syscall, exception,
receiving a Linux signal or by causing the watchdog to step in is
migrated. Well, except when debugging a process, then we try to switch
all primary threads immediately into stop when one receives the first
stop signal.

> 
> In cases where a process frequently switches to Secondary Mode, is it possible for the process and its threads to lose real-time characteristics, potentially leading to freezing or unexpected delays?
> 

Unplanned migration of thread that may hold some lock or is otherwise
important for the other threads to continue can indeed cause troubles,
well-known priority inversions etc. Xenomai 3 has
CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED to detect such scenarios, Xenomai 4
CONFIG_EVL_DEBUG_WOLI.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
