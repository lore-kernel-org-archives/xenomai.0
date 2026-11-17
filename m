Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794940378;
	b=zoWqoRzJ0HI7uxHgK97wPisNt7eiKnzHoVk4aEc5IlOIM6oV8EGOz9oyWr77tcbmUBgP
	 7cGhwsuBIPkREJxTMlxsyOKzdwG92NciUTZGfLNNeFeQMDsVEoyXFDVHcBc2Nnm7wP6l5
	 iPVxrpBy8DxCIB46NWZpQChQBtnpVPZDk6I11F34e4OlZA72suaZPkWTWhS1yfNM2C40c
	 NGsEW7m8R3bZE5Ty3I3G1CCBOi7SPCLPGaT1c4kEVIDQ+50xi/iwh09qQ5TADtuazoBnl
	 NfexKNju0k/97LJFtkOfhwqcIVN/RwxHiCrvEX552hteydeyst0Qg8NVIjjnDPuqt/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940378;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eYo85VzQ28bQokV0/ZarC+cHCYhPDzmp4y1N6qU8ubE=;
	b=ROnJZi+BhtGvXiSQOG/nqwY5suTGlV2ljF6cMZ1hLdx3SLcsA6hO1i8C+eGk7AyD1dZa
	 ZW/JK2T15mdR6TiOSoDQN1WQjrjJn7W01GjFmkm4aKQZJvh06hyO5GVcauBLuCvpJr2SN
	 mvo8mH5ur4GPmixbqpwt4EqfcJEq01FB8U7PVbSar/OmenquqqdxfOhrQ+e4q0F8UHnHv
	 2JrB4nU0oz4xBwQX7Wma57d4efInNsA6dXctZiWvZ5y4HQZ2nddz0Ao3PL5JvRYfCupv+
	 iSqHKx+Gz0pv7iYJTez+GAO4rH/8GWc1R40M3wtrXDMAzU2pOPRLwMLk8OjTB1PO0Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Uqn1Tsko;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.30
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827E606A893
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 18:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B827E606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Uqn1Tsko
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yx7TU8oHcc+ogXPJDY7eBGKPrah1UX7gTrxG5bSQUtbhIVwyMsCf9Aiq/EvGucOOYM1jqnQ9EIZJhIN8Mgfb/d1gNSbfrYrUws/hTd2X9iK/c54Lc+zF4U8uFHRtBmyvzQ/osiQHogf1Wei01fYbGHmsAt85MGXBP4acrVg6oLWClQbLlfRurGuujTUVFrHhMqDqDDPk0CaWz9TbcQLsLJuglZQ3eFkC1+cDt56op+AU/J2hp6qcWn8bx3O4Ar6bEOPb2TA81gFeelU+JzwAFLtyb9cGdeILuPJwlPtoJ1pMEHsOb1LxA1eVHlMrxqvQS+W7TGz6iXzlI8a/sWAwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYo85VzQ28bQokV0/ZarC+cHCYhPDzmp4y1N6qU8ubE=;
 b=FWERtUF+63ZrwqLKVexVmzmPNz0qJni7Bxef0nDOFP8wvEZ2l64WnkoPHaOO7ZHFr1jrXFDU71WrIJ9YL6ktzJxpcqaqy2rlntnVeXF9RXLC7Nob30GvhtXf5bSKzXRr6LqiAAZA6l3TJfNa2eu7Drrxjo/Nn3sPTRXXBRTL2/31PLT/jQkLYR9x0n0GfQ+o9wJLj4AoSZgcZW1CHhN5CZkXiFitiwcIdfSnSRW5iNLMl2hPJZJ8dgAxRsnk9Xjh6I7O9S11snor1TSEdhQzmXEvkxTeCFfdoIvjEwRp0FuxL6jDXEB4R8VcCdrlZYnBqscSJQyzqXXnM5KPoEmW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYo85VzQ28bQokV0/ZarC+cHCYhPDzmp4y1N6qU8ubE=;
 b=Uqn1TskoLvSYOuBaPQ0VaWOQVhKTCKCsuzJWJAAd4QmUehW7AlaeWFI3ke6OYZ70kbIHqXj9SLCuR3xi5qWTTxf/zEFuPQ5+7ig7PhQz5O+laQ4iai/e2upIvSVjPHFUJbUqRJ++3V6E4yb+p2Z55yP8LJD6NptgnkrybfvYxFFEcQZ6oRI3nnnZy8XXViIXBeh06fqZz3pVMIuIgaoEPO4o6atUSWF7UGpdZGYorczA5uS79V4ST6l9avE7FUq2Ebixauz12Vk1io0f226bvoCvDOrW54OUPIQ4GvFH33zdVANhWmoSnoNxy4pOc3GYxvIDxPHiH14tkUQ3N/igRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB6848.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5f7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 18:32:54 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 18:32:54 +0000
Message-ID: <42645f8a-126f-42dc-bae5-c23230041fe8@siemens.com>
Date: Tue, 17 Nov 2026 19:32:53 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] irq_pipeline: tick: keep IRQ_TICK set on shutdown
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f0caf1-144f-4b99-54a2-08df44d931cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|261009221227099003|261009223027099003|261009221727099003|261009220027099003|261009223327099003|55112099003|56012099006|261102130727099003|11063799006|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	60iHAYSe/clWyGDcSJtChlzqLFXTp0aEOC4mmOZPWMk3uX+1ZzOaKvuy63INgHVuIhsgmcGjSyrXCXKhF4vAhATAHV9VqWt87yjvo2y899xGb8Qa6/nzUICRpxmeAKObpJyE3ukXOT1+7X5c4D3OVFACDIlGUYtHyd8+sIYfinZo3CFVG+Y9WgkGS5M5TiHz7cfVogPE7C7YdrwQGP07UHEKeSOOGvJIHzViZjnTk20MyRFC423sr0NZeHlwI30s6QXANvHV5TX2AdLJ0/1gBlMQDHAc8dLwKH2XYsb0+zA1n+1IyHdc5FkodN5FJutvDyyENYDzhCwwUiL2Rewvz9Hba/hiyIoXFc/7UqJl32+q1/Kd9Vc9zdSAwsVylWT63bGEvKMcH73ulTTPlOqCZ5rvCv/mfnc1/l95INy3rvWpkyt3QBwIc8tvIHxsGLRNQU4Ih1aUDeZh/w8dF34i7zNEkEIrppDTFTfS9J6GJI0YlS0wRkyZqjQIlSa2XgnJulz+mffAOOUJ+2RXEB4wBSUmLWPgPKI7cEyJSaYMAYutQB08RFl+JZ1NqMeEmLJWEL+NML/kJ5H/+gvz9D+4dVOJN3Z1EVsExGbfnWfbVsa8Vz6m6VZlqqCRkufXbYSp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009223327099003)(55112099003)(56012099006)(261102130727099003)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXdjU1RrNHc2TDlqRGtSa2F2Zy92NEcvWUtEQ2lIb2Z2bTJ3OFpBVTdUTExH?=
 =?utf-8?B?WjJ6azVUSkRhY0g1Z1hURWEvRy8wYzUwU0ljVEd0RkJ0RGFGQWE3c0hJMnZQ?=
 =?utf-8?B?bzNnS1ptY24zYUwyeHA0ZlpFOGJ0MUE0bUVna1ZaUDRZdm0rY3RpUXZmQUtG?=
 =?utf-8?B?QUQyenJ0Ylk2d2RUM241WGZHTE1UZXlLNnNtR2Mwb1FEekVNRkRTRmxTcGxU?=
 =?utf-8?B?bEQ5NHF5MHZpR0tzU0pxVUZNbWlGamUyRGp1YzRKbVEyZWl0cDN6ZTRjSmo1?=
 =?utf-8?B?Nlk2SEJXMWVvM0hPcFFaVmM5Z3V3ekJoVDBhZkU1WDIrTGtlVG4vZm42SEkw?=
 =?utf-8?B?R0VOOFpidzNVay9wNjhBZk5qTWF5N3lVZHBrRzBBT3Z1UndGZEJJbFJkL1pK?=
 =?utf-8?B?SGtYTHRtQlRJdmxsYXBpNXZqOE91a2pEZjZIME9VRXEvUVlBUFk3OEVMQ1F3?=
 =?utf-8?B?bnh0eXcrSDNURXpLNGJ6ZDdPSFhYTGo1QnRJMFBlaVlTWWUxKzI2cUJMWUJu?=
 =?utf-8?B?Mjg3TmFCc3NWZ0lOMU9pTC8zUWVIakhleXZ4Z2FkRjBZTllyUDV5SWNES25H?=
 =?utf-8?B?OEc5RlpOdyswQ0hveEFiM3NFNmZIL2JaTXF4Z0puVHpHb0dHci9DdXJ0TFB4?=
 =?utf-8?B?VEx1RWY4RHAya2U5NDIxaUtGVm9sQndMbjR2WXNpaUo3eXNXZEhkNkFTRUp6?=
 =?utf-8?B?REtObDFacDFJN29mWmJ3ZVBma0xyRFF5YmVOVTR3d1YwL2lWYkZBUXE3Q3Zv?=
 =?utf-8?B?Ly9Ub01Pd1V2elNqYmZYeUhkdGorMzBLczQ4OTU0cnNUaHpNZ3FtMFZsTEM2?=
 =?utf-8?B?dWF5U0NQUHFFcGVRUktPUGpndGJDc3VVaVhwbVV6enRYNWFEalpoZ1NHelVa?=
 =?utf-8?B?djJGVWJIbzAzY2xRZVAvemRkSDJrZkV4NWROU1JNR0xLSXZIUEo2NVl3Yk5o?=
 =?utf-8?B?WmtMTlFaOFRqamUwV1pESVVjRGlxR1NnODRZcEFVZ243dTNFdkR5KzB5N0hm?=
 =?utf-8?B?d0t2Wk1jaE1GYzZJdmdSWWFJV1Jvc0RnUkZPWW5MM1NuZUNwZ1JxbEZOSWdK?=
 =?utf-8?B?Z1JlcUNYUzc5enNZMWZwYVJROXBlbGU5MVo1V2xnTEh5UkNyazNkUE12dkdQ?=
 =?utf-8?B?RWNNSGJtbTc5dVFTNEYyMURtRGhTbVUrVW1LamI4MTB2K1hQN281TlNwVVdD?=
 =?utf-8?B?a2VkTnpsMDYzMExhOWhrYXNWZk9OSmN6T1pQVTZWb0ptQ3VQUWp6cFZtSTBx?=
 =?utf-8?B?SU1nZFFVeG96azhYN1M1Kzc2K0RDOFdKLzNPdTEwcllGOWdZUmd0c0Jxekxo?=
 =?utf-8?B?R3RPVGNpRjBzZlFRUEN5U1lNT0pUTnE2YkxZVlVCbng5cHRQOWpIZVdRQmtj?=
 =?utf-8?B?WjgwWCsyUHhnR3lwSVJmcU9aZGNZemZsOHEvaGkwUC9kUHdXbDdSeTg1ZGJj?=
 =?utf-8?B?ME9VNGozdVBuRVpieHRNNmdHMFZjcEpWZWo2bk9kN1FHSUlaY2Z6dnA5TnBk?=
 =?utf-8?B?a2pWV29IeTRibFdPL1lTYVVJaGVFejBCSzU4a1l5ZW1tdll1OTlHY2tlUlhs?=
 =?utf-8?B?YkVxRklIM1NyUzNieHFYM2NsazAwd0hXeEpYeS9tcUNGRkw0MDVsYlg5alJT?=
 =?utf-8?B?WkY1cWExOHBOQ0pPMGV0T29tU0lYb2ladFd4SjFhSHZsNHpsQ1YzY09zRDdR?=
 =?utf-8?B?RzJHa1VPMFU0MTMrYVQ1ZTE5anEvUnhXcGhLZHYvamlnb04wZTFQWXVGeWc0?=
 =?utf-8?B?TitEdW01ZitZTFhDTFVwWTJkbkRIOUhnMnZ2L0FPZXBpc01aanlNa29BL1lk?=
 =?utf-8?B?Zkt1MUFxMFY0ZUNEelI3RUFWeWIxRWpkem1DaGVEN2l1Q0RISDhyS3c0RGIx?=
 =?utf-8?B?MkxXSURISHNvVW9SajF1Zk5LaWJReWdERHVLVnZZeWpBeURKd3FXSGl4Q1ds?=
 =?utf-8?B?dFk1WFpVY090ajJCTzhoUE5hQVc0Qy9QZXNqeDRaUlk1QktHaVF2aXdDTTNJ?=
 =?utf-8?B?SjVqcnJCeXZ2S2tETVpMNWY3MS9FNldxYmJIM3BjaWtzaFYvcTNTeEV0L3JM?=
 =?utf-8?B?T1Z4TVZPNVppbGcvRzhreHBGdEQ3R1czQy9hMFo3TTlldDlBL0l6NGJlSWRo?=
 =?utf-8?B?Smtnb3NuN0NYVFg2RVRWZTk5RjcvdjU5NEcrTVhzbmlYN29EeE9WcmNxR1k1?=
 =?utf-8?B?cmlsdW5kSEVRWGRkNVJ3S1A3WUZpeUFaWW9zNHlqZWtiMHVLMWUzUXF4QXdY?=
 =?utf-8?B?Si9HbDZDZCt1U0tnbGhzL2R5RFhYUHNIa1ZTVVRjcmNoNUZXbWtPUW4zbEtE?=
 =?utf-8?B?dTJRMHR4aWR0RUo5cEJkTzAvWlkvQXAvcTFFRVFXVnptRWlHSTFhQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f0caf1-144f-4b99-54a2-08df44d931cb
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:32:54.4571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwDLFZZm1NwQ+xsdVHrIo6ZgPcpySoz6AjhGFhgIjq3gdxOwohsmzfIqPiyP9BGtcOCeXV71FwDj30okbs3nUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6848

From: Jan Kiszka <jan.kiszka@siemens.com>

IRQ_TICK is set on the interrupt of a pipelined clock event device by
tick_setup_device(), but cleared again by every call to
clockevents_shutdown(). Several paths shut down a tick device and
restart it later without going through tick_setup_device():

- tick_suspend_local() / tick_resume_local(), on suspend to RAM and
  on suspend to idle (tick_freeze/tick_unfreeze).
- tick_broadcast_control(TICK_BROADCAST_ON) while the broadcast
  device runs in periodic mode, undone by tick_setup_periodic() on
  TICK_BROADCAST_OFF.

In addition, per-CPU clock event devices share a single interrupt
descriptor, so shutting down the device on one CPU clears the mark
for all CPUs, including those still receiving ticks over it.

Once the mark is lost, the pipeline entry code stops saving the
interrupted registers for the in-band tick, which then accounts the
CPU time and reports RCU quiescent states based on stale registers.

Restoring the mark from clockevents_tick_resume() would only cover
the suspend paths. Make it sticky instead: once an interrupt has
driven a tick device, keep it marked. If the device stops being used
for ticks, the mark only causes the registers of a more recent
interrupt to be recorded, which is harmless.

As irq_switch_tick(irq, false) is no longer used, rename it to
irq_mark_tick() and clean up related bits.

Assisted-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is now one option to address the issue brought forward in
https://lore.kernel.org/xenomai/9b439d13-7d33-419d-9d4a-2b224bf5db7d@siemens.com/T/#u.

 include/linux/irq.h       |  4 ++--
 kernel/irq/manage.c       | 11 +++--------
 kernel/irq/settings.h     |  5 -----
 kernel/time/clockevents.c |  3 ---
 kernel/time/tick-common.c |  7 ++++++-
 5 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b9e4f12271ed3..0862d64b7ee4f 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1260,7 +1260,7 @@ static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
 
 #ifdef CONFIG_IRQ_PIPELINE
 int irq_switch_oob(unsigned int irq, bool on);
-void irq_switch_tick(unsigned int irq, bool on);
+void irq_mark_tick(unsigned int irq);
 void irq_clear_deferral(struct irq_desc *desc);
 void irq_clear_forward(struct irq_desc *desc);
 #else
@@ -1269,7 +1269,7 @@ static inline int irq_switch_oob(unsigned int irq, bool on)
 	return 0;
 }
 
-static inline void irq_switch_tick(unsigned int irq, bool on)
+static inline void irq_mark_tick(unsigned int irq)
 {
 }
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index bbd7c0208444f..943541b1c9fff 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -950,16 +950,11 @@ int irq_switch_oob(unsigned int irq, bool on)
 }
 EXPORT_SYMBOL_GPL(irq_switch_oob);
 
-void irq_switch_tick(unsigned int irq, bool on)
+void irq_mark_tick(unsigned int irq)
 {
-	scoped_irqdesc_get_and_lock(irq, 0) {
-		if (on)
-			irq_settings_set_tick(scoped_irqdesc);
-		else
-			irq_settings_clr_tick(scoped_irqdesc);
-	}
+	scoped_irqdesc_get_and_lock(irq, 0)
+		irq_settings_set_tick(scoped_irqdesc);
 }
-EXPORT_SYMBOL_GPL(irq_switch_tick);
 
 #endif /* CONFIG_IRQ_PIPELINE */
 
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 0a57c2080cacd..d1336b82c248f 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -218,11 +218,6 @@ static inline bool irq_settings_is_tick(struct irq_desc *desc)
 	return desc->status_use_accessors & _IRQ_TICK;
 }
 
-static inline void irq_settings_clr_tick(struct irq_desc *desc)
-{
-	desc->status_use_accessors &= ~_IRQ_TICK;
-}
-
 static inline void irq_settings_set_tick(struct irq_desc *desc)
 {
 	desc->status_use_accessors |= _IRQ_TICK;
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 3cf30dead25d1..5138c17fd567d 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp.h>
-#include <linux/irq.h>
 #include <linux/device.h>
 
 #include "tick-internal.h"
@@ -178,8 +177,6 @@ void clockevents_shutdown(struct clock_event_device *dev)
 	clockevents_switch_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 	dev->next_event = KTIME_MAX;
 	dev->next_event_forced = 0;
-	if (dev->features & CLOCK_EVT_FEAT_PIPELINE)
-		irq_switch_tick(dev->irq, false);
 }
 
 /**
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index bfb26d9d687ab..56e3ec9c754b3 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -245,8 +245,13 @@ static void tick_setup_device(struct tick_device *td,
 	if (!cpumask_equal(newdev->cpumask, cpumask))
 		irq_set_affinity(newdev->irq, cpumask);
 
+	/*
+	 * This mark is never cleared: tick devices may be shut down and
+	 * restarted without passing here again (suspend, periodic broadcast),
+	 * and per-CPU devices share a single interrupt descriptor.
+	 */
 	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
-		irq_switch_tick(newdev->irq, true);
+		irq_mark_tick(newdev->irq);
 
 	/*
 	 * When global broadcasting is active, check if the current
-- 
2.47.3
