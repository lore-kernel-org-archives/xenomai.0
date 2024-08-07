Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3BC14386B
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058661; cv=fail; b=umJygdcRrIY29A5coCnQ9H3tA7wxoFZdMEkKjY3aA0Y3ndHtdbi5H7a1jeBU3IyBIOpClnPcZp9J8+w4C9TanEnLoC7BtzIVqbRrZ0ZOJnFCGloMtTj+vPgSORq5FvQqnXu6dRCi7rjOqxEoWrbSBzyU0t638kN+dCwYmIUvioc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058661; c=relaxed/simple;
	bh=RzCunhU5iftKtJrjXJsix6BkkQEk6Lko1u0KUywJbSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EL/GWE1zzg8VGv81D83Zquuw9Kt2/g2zoF1M5Uh+wkKaRztTM4uv2Z1ZOt9zV1efeBuqP+MJ7Z6YgjhCw/UnEDzMFNV4xxYwPMWgn2K1d5CJS1wy8FcsiAAMIDMbLnBLgZ56sSmU4Pk7udnjp/xHFG23ahyKtjYWfuQi5fZHhuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qKAmCb9c; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qKAmCb9c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBGicFm5DT6zDQFslWFDoCPKoZGMN7sfRa/uPGbbPAk/jvgV+Q72cdmaORs0kwsFCHFOiAvsOP61PbQuOiSRrG1HBS1RWegamMyl4IrGzlxKYggVM0wRFEMXodPvYc0mMDEawNMxy0iXCmAkbGUlkthCycDvanubFzx2i8Vo0NiFdZu1oGBfJCtln+LMtYYN+at0+pHFUk38GgfIOoEBAER5UsBGoHt4x5+aQJmG7EZnCOP5lJERFtND4qdcduxEcfwxlQ57xXWoC0tBIHMlUsSXMeTZ+ak0fc9OSE1PA6nN//j8tO5D3GhtGzZKDvqzGyKRZvQJ83iNQTNKHHmDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fy6x/1CXnOOAjdhA5Ppe27HEK349T8bxKjpMKAI0nM=;
 b=qFzAtqUsUIxlMnK8mLx5MvGwvXypAe7yXvtGujDnkHX6LF3Zky7Y1rLC1bTNMk94yFbUBc/8uBN3Vm4WJZ29kQdYN+Iisg6aDnI/1FC917Pr3zVursr2/RIPkYjsPioJp58rq70okV4qF7yFSbDsj9ivYjCAcR8HrMR2W1K2lu6ZqC7BqLE+d+C0VfeEiqLzG3XVJGOni1fERtQelAMhMefU+AUsWmbmd8tOLvsFiJlIyaYDRHcK30lAKsjTFX3qIeAiLKAZZk7td4m9NK4M3b8HTUb4fKTdj8mJ96aUrflxqM2eojFj0qIDlZTr26ThADMt3HO7zc7o1KfuxHhF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fy6x/1CXnOOAjdhA5Ppe27HEK349T8bxKjpMKAI0nM=;
 b=qKAmCb9c7tqx9XZCKrNz0LZbnmcVIQCgDkwEg1BCBWSBh8DrcUrGByhyU5z8qJxmYvShiJe9QQxb8N2iLciRzg9yehvGoogHlwDSosXhlL7JUse4RBOtJYF0D5Qy7Fle7q14WisEONvks1yDakmZ5OMQFxFG1sinpo4ffkSkGt594hhiKPiw1G/L5AHzZUVshwH8IsP5kmVk/4P9y1DGCjBPYAEzlPgih5VaqcRz9iNe5l+W4SzfVTuq4BviJ79RpCRl3xTn2DKpsRDtL9JtoMWaGNvzY7FafrOjXY3RGhBdKshxjsj5/9qw7Wr3bCYNd+1LWNlMln01Nz9Z5MEFUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8225.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 19:24:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 19:24:14 +0000
Message-ID: <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com>
Date: Wed, 7 Aug 2024 21:24:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Thread stuck in IDDP sendto()
To: C Smith <csmithquestions@gmail.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com>
 <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: ee706564-84bc-4c9a-fe21-08dcb71685cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alE0RStJU3NsVExCdFZ0THFYTnJUYzdKYU14TzdOdklzVDV4VkVoVE1HOEJD?=
 =?utf-8?B?VTlEWWZTWTJkOGxYY1Rwcnp1YXl0Z1BUZkFhbTZYTDk0Tjd2MG8vNkg4cHhU?=
 =?utf-8?B?ZTNpRDlvOGRVNGxIeDgxNXI3c21KZ2NyZnpWdGNFK01WZUV3SHlMZHRFMnU4?=
 =?utf-8?B?c0pZT2dMWG9iaVRtUFdjTllQTGxxK2ZFbEFlWjJnOFovVS9wVHFiU2NHUUtV?=
 =?utf-8?B?dVF4bUdMdEl3VnJEbWhLdXNNdDMrZkN2SGlDVFZ6bEtBeFNrQm1xbE9FdTh3?=
 =?utf-8?B?dXpJcCtTdG0wbXVEY2JsS0kwNEJWZUk4aEE4dFFRN2dCT0ZXVE9oLzFVNm5C?=
 =?utf-8?B?MXJ1NXYrOTVndE9ER28xbExrNHI0VUFVekU4SHdZM2hWSjJvS0JJbWduMkVF?=
 =?utf-8?B?ckJ0RzRpcmRadFI2cWdMdVpadGw3ckhKZXplMTArMHNRcnJib01VdG9Yc0Fq?=
 =?utf-8?B?VWNhSjIrQkJJVU5vTVNSZmY3allEMEtrSTdFMHRpTldUY1AzN2h1YkxJS1Yw?=
 =?utf-8?B?djFmME45eVpGYXFEbTRNMDIzV3ZGQkc5UlRvTFVtVVJmSXRGK1d3WTRad3Vm?=
 =?utf-8?B?NEc3MlFsSXVyVzBSL01Td0VMQWRJSlNFa0hYT3FlVkxPd283ZHF6UVJSTE9k?=
 =?utf-8?B?bis0TnZwZzFOTW1nVTZ0Y0dIcWNuY2prSFRZenJVTHUxM1kxVUtWenUrZUMx?=
 =?utf-8?B?UW9jN0pyL3p2dmtxL3RtWXNPNXV6VGloTkxKNS95UThLdTBNbDNIWS9LVmRS?=
 =?utf-8?B?OFQ1a3hONGVib2dDTTJIQVM1ZVRwa2tBT25HZDdaeFNSQ25vUGxNdk40bzk1?=
 =?utf-8?B?WUJZV1VjM1g1allHM2VEVEdxY3RhL0N1ZGMwcVVvMS9CT0d1bVlXQ0N0S0li?=
 =?utf-8?B?eTF6RWFPOGgrVmRNdHhPcHkybWFzelNEMWJWMy9vVUZGQ2hoYndNR1lsbXU3?=
 =?utf-8?B?RWxOUUlTMmxxREx3S1liT0pVNmFjZm1paWFCWFp6d3QvYXkvQlNjVXBUQ0s4?=
 =?utf-8?B?b3Q2cUVDT3NGUU9LMzd1MkdlYTVaNERMRTloV3pEK3ZmTnNaeStXWkV4SWtQ?=
 =?utf-8?B?a3NFYTh2Z1hodHNwRjFVQVJkdWExMXBlbUdHUUp1cEsvNkdTa0tHWFgwL3Y4?=
 =?utf-8?B?Yk1zdkgrUFNCelpIczZHbnpXM1U5UUh6OS9kU2FYUHNSVlN0ZFl1bE04aU5x?=
 =?utf-8?B?TloyRTA2UW4wdGo2OVRWVytGTFk2am1aazZoQ0Nac2c2VzVBbFBGd2VRV1U1?=
 =?utf-8?B?VlI4MHJXMTJZaTdGb0w2b2dPS2hNbElqdk9lYy9pQjVCTmdFdGtHQ1lYU3BI?=
 =?utf-8?B?YUg0NW56cklVMGNhQjVNaXYwVFZXMG8zSTdjQTE2aGIvdlNxdW9CcHlZT0JO?=
 =?utf-8?B?R2hmZVFSRUIxZmRjVjg4RnlOdjV5SzcrOXJWNXY4WldkV3IrZmhLVHphSDhH?=
 =?utf-8?B?RlpWOW5OS3FHS1V3QnMrZHpHMVdUNFdwM3B5aG80K09BeXdyTmViWjJkQkdD?=
 =?utf-8?B?MXJWaGhIZGR6ZW1oM2EweGtoWVF5NlBsOGZPODNhSkhlTUVvaHBDVE1tVXUz?=
 =?utf-8?B?UXo4S0NwT3dvVTBuUXdVTHpaczFFUXlJaUcvcGFTOUt6Ynd6NUNwYjNwRVlG?=
 =?utf-8?B?L29qSEE0V091RmhrVTQwTXVFcStYcWhpQVYrczFKaTA1M1NreCtCNGlmMjho?=
 =?utf-8?B?ZTRnVUNKa2JjK1VGTGh1NGNhMFZya0dFNDZMZnBtZkx6RGxqRHVlL3d5SDVE?=
 =?utf-8?B?QWJoWktjVWdQdXlhY01kK25MZDQrcW96MnJzTFBXbEhzd1FCWmp3SGI5S2R6?=
 =?utf-8?B?U3dGZVJwRkVZRTY1S1pWZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXRpUENjMlJ3NGQraVBRdDFXYXJtczVPOWhvamZHR3VsaUpMSUR6eEsrbmNk?=
 =?utf-8?B?VTFiZTMvamgrb2t3ZEFDL0t2RDc0cW5DSjhTTndRVWpRNjc5ek9KTXBaTm1H?=
 =?utf-8?B?amJ2NjBuRGwwajJiUHBwc3htWXoySkhoTXRCSTA1MElESVFvWVE1OTNZc1Fy?=
 =?utf-8?B?TUdpUmFNRG9UY1NRS3JNY09UdFFxQkFoTGxhcFNxQnBWS0ZrWWoxL3NSTVJN?=
 =?utf-8?B?NW81UlArWU1pdzVVVTRub3NzVXg1WGtIaUZmOE8zSWppQ1Y2SFNKa1N5M083?=
 =?utf-8?B?T2kyM2J6d1BLeFZpazJSMGkvQUtFeXNVb09aT0htYVpwTjdGaDNPbDVNMnVi?=
 =?utf-8?B?VU8wY1o3aUJQTENlMk1DRHFQaGxHaDdvUG9jTmNUNDZ1cHJNVDNZcG9hWmdz?=
 =?utf-8?B?bXFDRGxMNVFCVEhyWmM5c3hlVlNuZ2NHUUtSc21NdWM3ekE0cDZqbmcwWmM3?=
 =?utf-8?B?THlDZnBrbVkwd3I4N0g0ZHdIb0ZPdzBQeGlBVjk4Z09Dc1lmeElFOW80QlUv?=
 =?utf-8?B?cTZjdmQ1QXRHekRzcTdjVVpWOXNDQlhDVEhBRDViVjMvTG1SQW9yVjU4Y05y?=
 =?utf-8?B?dVlWMWRkMFZqN3psZ015eDNQVy9RUzVvc3pXaklOUk9QMm5GcnFha09JanFs?=
 =?utf-8?B?TnRlMExGRnlzUHdpU1dmNGNwSjd2bjJZa0YyRENMbDFGQ3Nhb3ZIV3FQYzB1?=
 =?utf-8?B?Q2wveUtKMURVVkZvL2R0a1lINzloR1Vydk5pTFpjYmM0U2NCcG5nUDl1SEx3?=
 =?utf-8?B?U3dLRWxVVEl6Y1BSQitwYWJlZTJaUFVqYXdSbW12MFVaRVRCSHZmOWlJUG9p?=
 =?utf-8?B?TzFMOGlUemRrZVVKb1EwaXM4cEVTU3BCa0wrNnd1VDMxMnhMcnBianYxaldm?=
 =?utf-8?B?aW5VNDh4QVo2MkpwM3g1Qjk1TjI5TmFaZTRIdFV6Y3MxdmEzcnV4bTk3VGUw?=
 =?utf-8?B?eUkzdmpqeTVITmFXWWk0eWFkQkpZeFV3eWswNVZ5RFg0WDkzZXdta01SbDZX?=
 =?utf-8?B?TFJvL2Y0WXcxanppUWN2b3JlKzNWcmdyZ3FmYm1FcGFFbGpiOTdZTVYxVXNS?=
 =?utf-8?B?Nkh0dkNuMzdYRlYvWHNacHFsRHJmbU9ZWmNMNjdQQm9LWlN4OHRrZnRscHlZ?=
 =?utf-8?B?S1ptUWtnRGRCY2RlNG5WVU5abDNrTGJ3Yzl4R2ZCUUVRa0tMcGdWQzVtOS95?=
 =?utf-8?B?MnFQV0RlcnJLc01DWXc3WDlLME1TVGpKenFyeTA4WEMwZ0JxY3ZpdTFPcWlo?=
 =?utf-8?B?OHRXTlRUOCtvYXVvV3pzcjRmWmxhK0NBTG5pdS9MRkhoMXpBZndsdjZ1MnJH?=
 =?utf-8?B?eFgxQUlQK0FFaVU3MUhGMENsdkliWlMzc3JhcXlsOFZlVHhrd1RFRERmUG5O?=
 =?utf-8?B?SnVQS3l6bGVlaEVDaFZZNHdNTWhHR2RuS1Q2d29rbFB1cWVlRzJBZ2NPKy9o?=
 =?utf-8?B?UjNKYmQ0ZzdKRXZQbEdNWm90UkJVaW5zaW84U2dpRWtxM1NsdEFJbEJLWWo5?=
 =?utf-8?B?ZlAvU1ViWVZSNmw3dktlYzV4ZWZSaitWalE4ekE5T3h3K1k0QXY2djdiOG8x?=
 =?utf-8?B?RmhBblY3R0Q0eWQ1MHYvblBpNnV1dXpOMk1VN0FQdFNSQlVqcjlNZFJCT3ZG?=
 =?utf-8?B?c3hUc3ozMW05NTRXVml4YTZ5RkpwT09CWkQ5UDhZTVNFZksxUnpvYmwxOHFN?=
 =?utf-8?B?d294Qk83UUxuQXV3dytoQ3pTZXcrQzVsTG1VamtBd2I3UGNOam1abWJmQmRn?=
 =?utf-8?B?MmUraCt1Z29ZWW9FK2wzRzRuZWNoSXo4TllVMmdxTnVvSHcrSVMxUUtnbUda?=
 =?utf-8?B?UmMzNWgwRGlHWHYvVkt6YXVvS1djT3U4OGNSWkpDUGNLcHpuUzBwSUNMQ3hi?=
 =?utf-8?B?QmRZZTBHcmIveUdCRm1sM2ExMjZxZUdkY1hxMEhCRWQ0dFNQYktkTVBqemYw?=
 =?utf-8?B?WWlDMm5ueEFONitoWEVRTlRBY3RTeEQ3RnVpcWQxSWxWSjBmdHZaU2ZGRVZt?=
 =?utf-8?B?c211eU9yU0NWNGRTOEZhZTFRVUh6WGUvQVZKYzh6Mm9iRWIyeWNYdkVMM3BT?=
 =?utf-8?B?djgxeVdXSVZrTVlNYzFRbkppMmJjMmdQczhLdktOMG5ReHgyZ1FKUzJSMmFV?=
 =?utf-8?Q?pOasILHtKEc0cWZWDlbxMBb7f?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee706564-84bc-4c9a-fe21-08dcb71685cf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:24:14.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSLNcOGJsxQls2WWUXbZTYcJUIoQa3c4qcKwEWIp2c9k9bkwT7b+w8CI0aNb7P//z8xQUWouziEW+AHyk9I+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8225

On 07.08.24 19:54, C Smith wrote:
> On Wed, Aug 7, 2024 at 10:15 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 07.08.24 18:11, Richard Weinberger wrote:
>>> Hi!
>>>
>>> I see a Xenomai 3.1 (yes, yes...) application hang in an sendto() on a
>>> IDDP socket.
>>> The problem is hard to reproduce and I don't have it on my desk, so I
>>> have only limited
>>> data.
>>> It seems to block on __iddp_alloc_mbuf().
>>> What I know that the reprieving thread is gone.
>>>
>>> For reasons I don't understand yet, the following code does not
>>> terminate with -EIDRM:
>>> ret = rtdm_timedwait_locked(sk->poolwaitq, timeout, &timeout_seq);
>>>
>>> rtdm_waitqueue_unlock(sk->poolwaitq, s);
>>>                                                           if
>>> (unlikely(ret == -EIDRM))
>>>                                                                    ret
>>> = -ECONNRESET;
>>>
>>> Does this ring a bell?
>>>
>>
>> Are you sure rtdm_waitqueue_destroy() was called at that point, ie. the
>> socket was fully closed?
>>
>> Jan
> 
> (I'm involved in this one too)
> 
> The second app (the one which did not stall) is truly killed and thus
> disconnected from the socket of the primary (stalled) RT app, if
> that's what you're asking. How can I verify that
> rtdm_waitqueue_destroy() was called?

It is likely not because the one side is not getting its own socket
closed just because the other is terminated.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

