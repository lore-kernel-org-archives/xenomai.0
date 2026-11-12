Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794485106;
	b=LHadjczQ04+39uJu8/qu+Gx4qbHjRpEStPOUv9DKCR/8eOsGHo+oV1mfBkCyZGIRYT/b
	 NfXeUnn4GoQMLOTzHB0iFEXlAzJs4CSLnuUF2WTn9MFIZ85O2tVnkwq85fUqsydtE0C27
	 AxQV57Q6kYjUKWMQmfv8WtC69gAVYS7cyCkPD+Bw6mFqwgvjAIqViXwx3zR4h49HOMeKg
	 DxjCpiuMit48/MiG4KmyP5I08qzFzgMFJ75Di6t/jZJQl+qPHXClZTm8cv686WvToheW9
	 1uDfVocYbacOfygqp2xnVDT331ZwFMghTWBjU0AZ25f8qVUwJbzanEjU4LzowtJHJjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485106;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-Cause:
	 X-GND-State:X-GND-Score;
	bh=LHggKoc608vrLjN3V+dAK6KhlYYQCTAqrIOVILZvH3k=;
	b=gixNcUDdJYgRXVuVklPZIyDgqDXP1d1m7HNLM8ogvzdle2K46eUvuHlfVpUNaWU6lXlm
	 /Lly2MqcFQ56ypmcNSEuo8tc7F8H5O9RtHyUFBbcGjHp0xHXwnBdJlH6gs1ympQA+gJMD
	 U9QNRvmrJJ5buMp1u9mMD9ZO5AlXJtL7oNLyIsIKrfAXCkgShnJlsmW8AsKNyeCgVzb+g
	 kculWVClllHMj7N6JuKEiI3CNhL4fykueEukMJOVV4BBizUr4Vjfb7FyHaOCs/sPMerlb
	 XXBEkMeF2uxEfVmtPpUgmSaYm7TonscNXDzXQg0vcMMK++felpt0K5JvydkoQErPvqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ri9TLAHS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A4606A321
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 12:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF4A4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ri9TLAHS
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 25ED33EF55
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 12:05:03 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C2E1D5601DF;
	Thu, 12 Nov 2026 12:05:02 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=ri9TLAHS;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c207::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teRw94uhz3Di95qz4iEamchzYenCLFfuH9/KaibXXYwe7eZs65PzqWZmp0FWVyqGHXud6bAmIZhbbu2uQl7JINnxliqL7iC9SiQq/yRoshUCDFZhwdOMUm7FFo0MmQ7X/tCo41phdm2+8jfz6+L5Uaphq18qZGeueQIzj5oS1IqJ4NsI/yrivzA4VHDj2bJLuThHLDUEw23RjD3hUMiC+hONKv77jReaDioFLpmBaV14ZRSoI4gcCDU+XnDocP4fLgy8+gY0UKBO2la/HI2nn7kI6MVM1iUNHws6A/nd0PzVkkkwpN4WJbxDcNHMDUXaA3HBtN2cY5fFuWeEOciQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHggKoc608vrLjN3V+dAK6KhlYYQCTAqrIOVILZvH3k=;
 b=jkZtYxTeH2jE3iMHR/gDlp8VlZf0XWhe4uT0PaQ9kbP4I7XJWfuLeeln4e6PwKvoNUBqzuMFVS3VqN0kpgs3k4MdOxeudTN0m4IIMt17OxgqJeNdO68ZimVxy5p5Rg3KqmT5vR6E/fiIyRhwjGluRnKU2iMdWT8ZA5Iso5bo5B7i/POQ8AqdgqbbWYzbfibDugB58GL6ygaUlnAVOy/5GSePkaYFHDF5qdSdzWMaqYh10JjZau/yQy0tZjC775Vl7uR+tvE4sDh8zH5MeK/f8DQiw0pZbXwBbwZXxPnhCUXCtLUkooJsJmk9xzsdxDyaNwOst132izymVFWc9wEZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHggKoc608vrLjN3V+dAK6KhlYYQCTAqrIOVILZvH3k=;
 b=ri9TLAHS23bLv7oVCrHwArGAvFTybX64z8heH4hJ3GZzdXv3uLh5wJtJkVNHh8ajF2Akl2rj6Fy3bM5KRU2KSv6wUdVNgr3HwJTGGhhEf9MYoh9EF4WNSDOo3bP1KNmLV8D8cg6NAqZlZLkHCAlMTEmFPRycQAWMjqEMVv60mbiE6SSpVXQ02K2FkKD8kL/9Db13F1oqXt5pfxaBg5PqVAJWzbbn9ddNOCP5Mbsar4qus9P/V8Ot/5oZ+jo3B/JCh8bzf3rTe1Xwb+N7iOp4TEWe7/1kcvL6JZPTYcx8b9v+hN4E6dOTX8Yrzm9Zy7O1p8fnxznz6jt6twC+QDsSJQ==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AMBPR10MB213527.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Thu, 12 Nov
 2026 12:05:00 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 12:05:00 +0000
Message-ID: <ab4bf2bd-f38c-451b-9b76-d4ed3bbbf535@siemens.com>
Date: Thu, 12 Nov 2026 13:04:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <87cxsa2vej.fsf@xenomai.org>
 <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
 <383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
 <339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
 <6033b5fe-60d8-4032-ab43-58048673c71e@siemens.com>
 <b4f20066cfe191c9aa22e4da524d56838da5df3c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b4f20066cfe191c9aa22e4da524d56838da5df3c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::36) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AMBPR10MB213527:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ee5dc2-fa5c-49a2-a12d-08df40b52d7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|6133799003|55112099003|5023799004|11063799006|56012099006|10067099003|4143699003|261102123227099003|261022115727099003|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	hA2DcYrWkkCWb7cH+0cweP2nNWelOaVTSf/1/2o7chIRjxGh3f5WiKzWEtvLLPHOdtNMoArNdVlLra6RugrALqkPtvoypXx64NF1f8ZIo8jyXPvW3OR4U3//I//4/kyiPKXcmY2QzsaffEPnWD4GAHB6f/0GRrdfoVQnoDEiNmh5trbUV2zE3EWgh+TR1qb8llQb0H9BYIUznj39+l+9aYgcsqoXT9bqeu/asTeTTpnI6Vf3+4Fs/QaERM9oSJkVKgxx5VMkFXKo/NNHljiNkBUKDVZaioA1uACMAngwz+WXUvnBejeEMZrrQbSiVkgI63QptQn6UUYOkUAQpMyjavHtFNwxT0RCMqQHDL1b0UnJdimG5gtqcc3hXEnmF31+vMnC4JbgTnXum75xbCJSqeKkxuA0F64n1ZSbkIEh85TqBuXfnS78mokqbD+0MxItLBEL+3H3EhxMZoA1hu+Ye8adJMA+k1HhGFl3Q7M4ElBS81+K/00fjfitmjzDJ1xYl7XLzTrAtY2Iz4E8MQJ8NyP49Pja2qM3KOt5WBoVG46tUKhpk713erlKZqm//hXYpOtZ1dQdV3IGdPlz7ouePUBQ7UP7eZEvy+HPNZYJvuf1/yZrNTF3kX+31LbC6FNM5S1VNGiggeBHnX0zJ70VyongBu57i+IzXm8/u6ab/HM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(55112099003)(5023799004)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261022115727099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?encvSkVTeDdUYzZOdVFwckd0Y2E0UGFyeW5CcllOOGlNWS83T0pHNWRMa002?=
 =?utf-8?B?aGFFbjNmZ0QySXZNdUdiMFNJa0ZvUi9tdFFtUmJzK0preXpiRDRzc0NQTHdZ?=
 =?utf-8?B?WmZMbkZPYkszMTBaTFpxczVPKytSb1ZQaTNsaU9NRWZNMXhrOXpVeHQ0aUkr?=
 =?utf-8?B?NjJsSlI4R24wbEdhTlBpcnJVV2VGNHRmOHRiNi9HWEtoTlF1eFl5cDJHN3pi?=
 =?utf-8?B?QUlXeUxldzJidHJNN0tWWEI3WEdQRFlSWXlkSWNuUWswTUlMdkhwNzdRTDZa?=
 =?utf-8?B?RVdQbGNHRWpQNEI4WG5TYStmaGZZNGFWSWhOaXZ1VFJIYjhEN2pUeUlCWUM2?=
 =?utf-8?B?ZElnWVZPcXdiY2VKaFl6a3J4T0J4UUlaTDNRMnRvU09lbXAwUDFuZ3hqYys0?=
 =?utf-8?B?ZzNjL284Y2R2ckE3Wmo4NjlBZGtVdzFtM01DckJaY001cFNMMVFGY2hvOFhq?=
 =?utf-8?B?NGxpU3N6NW81cktya3BWT09CWStWclZJMWpRSTJoWTNMQ0RuZFFrSXFHYVE1?=
 =?utf-8?B?MFdNUnN2NWJqVEpINVdsbldZcit2OXN6TFIvQzhEWW5zbWdpMW9JR0ZqTzdU?=
 =?utf-8?B?cFowYmNaTTFHWEVkUGEyMzN2TmpyNHFCeHZkaml5YVE1b2FDMDdUUlh4WExR?=
 =?utf-8?B?ZEZaZldQWXMrZHpseFR5cnA3Q2tLaWdMNTYrYzIwUmZvYXo4cnZyVkFIWVpn?=
 =?utf-8?B?UGhkZEt0SXZzMk5jZHZoVXc3QzhxeVVmWUNyeXNHSTB3SjRtQkVGOXBQbjU5?=
 =?utf-8?B?QU1VRnNPS00zVkVvYVFqSzZKMXQ5cHViYWtheWhWKzFhTGpEUkpRQW5TSWJY?=
 =?utf-8?B?ZEdzQk5tc21rZ0dadlJ3NnlLTDlmRDV5RVVZZFdza3Ftc3ZLV25TaHE2Ylhn?=
 =?utf-8?B?M1hxWThURklWcDVNMXpGeTVaZTlEeCtHcEFvMllZZnFQb3oyd1crVkVjQ3gr?=
 =?utf-8?B?TSs1elExYW5hWGpqcDYzdG5FTWJHMDZ4WnJLUmh5ZERJV3VBNHVZcnJYeHRU?=
 =?utf-8?B?MFh0N25hc2pmYW5TaDNMNXo5cE5yUVFBRGUvOU11WlU1THNKRlV5YURUZWd1?=
 =?utf-8?B?Q0VqUk54TVBMK0N5STg1UjZ1eDF0MFNCRFFYajF0bS84U3pCSnFVLzRmcWc1?=
 =?utf-8?B?Q3hNT29tekM3Q042bkxOVWpzTllaM1A0T0FsaVRyMnFQU01UcEJiSzZlR0pT?=
 =?utf-8?B?RzE3T2FhN3hKRUVFUml6L20yMjVTN05mY2FlY3lZcGppU1ErUjl2UEZrSU1O?=
 =?utf-8?B?Mko0RFlsaEJNdytHenk3OTQ5K1h0TXV1OFRVdlhPL0JKVHd6cHBjM0tuaWxr?=
 =?utf-8?B?ZzRoZFYyQSs5WnkrUTA0ekh4ZG12YXVnN0JidnFpb2w0RlBLb0duc3hBcjdK?=
 =?utf-8?B?bzR0SUhOLzlBNEZ0WS94a1c0ZU5jTmEzQ0FXSk53MExubGExTGk2QjVDcWJs?=
 =?utf-8?B?eHpjbWdrRlRsdFNOdlE5dFRmSzNQRG9adURNdjRUNWwwbW5qMy9xdHArelIx?=
 =?utf-8?B?Z21rWGgwZ05OQ2IxQlB1Yyt5M0huRXVNMFE4bjNuV1p2a21sUFByNFA2cjh0?=
 =?utf-8?B?YjFCcUZmUWh3ZUp5Qi9abmtXMHJMTWxmUExqTDg3T056Ky84Z1RWSUwzTTA4?=
 =?utf-8?B?RWRMYWtWaUgwMkdkeVhBd1U0Y2dPQmxtcEw3cEhpekQ1SkI5TEpVZUMxOHJV?=
 =?utf-8?B?SDh6WDk1WG5uMitjYkozYURaUnhrRitBY2c0YUh0dHhjbjBiODZHRjhtbDgv?=
 =?utf-8?B?QURwMlo4bm1EKzZWUUdBaHM2S3N3MmlRdytJUkpYNXNkU25WU21QUFhiTUhI?=
 =?utf-8?B?YkhYa1BKcnk4NlJLckhla295aitJTEVSWGl3VTQ2NmN2a3oySlFiMEJZSUJ2?=
 =?utf-8?B?L0RUdDcxTDRMUDJucm5QNE1kSWJMbnRuVjJ5cGl5cFF2S2lKZUpkblo0RVIz?=
 =?utf-8?B?NUw1Q3lJdFg2K0hWZzdJT1FpYXFKWWFJWUtkTzhxamRzU1ErNTZOVXJROTRa?=
 =?utf-8?B?WTZMVHY4VEFRMHBCVFpQWDJkeTEwUEk5VGR2VFYybDQzMkxqRUFzdWVzKzVD?=
 =?utf-8?B?QTd3NFRZaTJpc1FjWkF3TTd6NGZnWHVhU0pyVjVhUUJlTFEwZWhFaEtVcnlh?=
 =?utf-8?B?K0Q2cTNiNGVlcTNSK2h2RDl4cksyZkRQVkRGMDlOem9QMWxmWjlMRTByOURm?=
 =?utf-8?B?bk53aHhRaExsb3R2UUthbWJDdENWMk9BaVJPSXNsMm04Qm5oanFTNXhjR2JJ?=
 =?utf-8?B?eGZJQ1R6Q0lYNE9nb2VvU2U5TVdwZWl4aHhZUjgrM0kzU3JEaTEzTnM5Yklm?=
 =?utf-8?B?aVNvcVRWRXJoU1M0Z1ZITTdwNGpPaTVqU2RSVk9Ua29VZ3YzcFE0Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ee5dc2-fa5c-49a2-a12d-08df40b52d7b
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:05:00.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hY3F2iuSzmFMeVb4uc4QEKNshajHUt0B+7eIn7iP9dIayJyPh7HSDGGXIjjjpknCn1EONRdIWFHESQ+v7ZYjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB213527
X-GND-Cause: dmFkZTGvH6aRB2VHfIueR8nSy+MEMloMbKrOwJvw7kSRrzTg+sPitMvmuxgnyXqgUSN8wHfk2717V4AigB7rxpQC/k26FgicIgKdDa19Zv/obmqu5Ts+5ilElcw2E+BjqNDGVjqrHwvEWO93vUhaZE9zDj5215KN2SGq+FhTgWZs6xlut7Ler3JAJDRYAFY0iUrarUSGCJ9MzDnIMr5KZ3u3FiNHfzGNKmhDVCZLVFxRmNdkepsjfaL1uxG5E1Ly9y5zLmeWqsNFmhPdfCyKLqfMbxBHKtDPQLb7iRk6MJkEgIsTejqA+L6ptt8mpYHU7J0cZXo7tQihlk313BwyubxSmVMxG02m9NNoKXF2CowA97GqyfLv6jX2ssdL894UUyCAsXzxD4zz4KPYhf92KJpxePk2OFJcMg+o5ntecDhd41lPGkvdjy+1Ik1jnSqQ9xbaSiclTmrxjyzZQaZyFxPVdUirG0/dEG7ql2fSC26HNrx74PGd7lY9iuse5Og2/8B2tXbMsaTT26fu/dv5Udk04cYOLWXeygNeRMfs64bTNV31C0ovfN8sdflIFGfJT6QC/RCB2PV/Xo59Vf4PcnUzK+JPBsfDbctEk9IYn2G7cW7ka3nFOoapDzGwwofY0GFSpd6M9FHcbA2yknMQFpr/O1DZmbvpYOxxlGLGC0Qg2A+slw
X-GND-State: clean
X-GND-Score: -100

On 12.11.26 12:39, Florian Bezdeka wrote:
> On Thu, 2026-11-12 at 12:30 +0100, Jan Kiszka wrote:
>> On 12.11.26 12:25, Florian Bezdeka wrote:
>>> On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
>>>> On 12.11.26 12:05, Florian Bezdeka wrote:
>>>>> On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>
>>>>>>>
>>>>>>> I will share the lengthy test case as well once I'm done with stripping
>>>>>>> it down further (if possible). What the tests already demonstrated is
>>>>>>> that unpatched kernels crash.
>>>>>>>
>>>>>>> These patches here are almost completely generated. One of my few
>>>>>>> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
>>>>>>> of having oob_trap_regs as a nesting detector came from the AI, though.
>>>>>>>
>>>>>>> As usual, AI is still rather verbose in descriptions and comments. Some
>>>>>>> of them I already shortened, but most is still left. We can cut down
>>>>>>> further, but I would first of all like to have another review round.
>>>>>>>
>>>>>>> While doing that, keep in mind that AI tends to ignore issues left and
>>>>>>> right when being told to do a specific task. It may have simply missed
>>>>>>> further preexisting issues or even created new ones now. Watch out!
>>>>>>>
>>>>>>
>>>>>> It looks like patches 1-3 have landed into v6.18.Y already, which means
>>>>>> that you are confident with those changes eventually.
>>>>>>
>>>>>
>>>>> Those patches should not go anywhere until they reached the latest
>>>>> development branch. The common "upstream first" rule.
>>>>>
>>>>> Everything else will add a lot of confusion.
>>>>
>>>> The v6.18 application was experimental, to validate that the test suite
>>>> passes on real hardware when all issues are addressed. Nothing is
>>>> official in rebase branches until it is tagged, including those patches.
>>>>
>>>> Jan
>>>>
>>>
>>> Why not just push out a wip/ prefixed branch? That does not require to
>>> temporary update branches looked at by different / more people.
>>
>> CI is not picking up such branches.
>>
> 
> Which is OK. Those branches should be tested only when requested
> manually. The "internal" infrastructure has such a feature, while the
> public one is missing that.
> 
> Upstreaming was not considered yet as it highly reworked the xenomai-
> images project. But maybe it's of interest now.
> 

I'm not using anything internal. If you have a patch for the official
one, please submit.

But pushing to -rebase is also not a big deal because it is, well,
rebasing, not stable.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
