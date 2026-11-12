Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490156;
	b=5XL5Jwd3aStAoFDNRDULgOXqszFFL4r9I3a1ruRfjx/yOd/BZKjn9S6R93XnRLQTAuCv
	 msi9r1Cpo+9W3A7Kk+aCEJcNiK+aikOSo18UYtyAlXm0M8xDm3Rv+LvQ/XbroWW7dZT63
	 0FN8hzZGZ0R4Xt+nL5Qih473dNi6lmHvUzcG4SPywHDvdfWxARG3ARkAud4dbjmBu7+E9
	 YaSoVSpKXcW/6qMVLITQ/5etcNRLXwDbgR/qP6R6hxVMt5Je1BS0b+laHuLu80c2rZ9Pe
	 J8WuQe/tdbgT2G67gNICB6kxObZG+xjS1dWMqMGITBHJuxnfqZ6UCZZsYpq0FniB+dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490156;
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
	bh=vNGW79TiRE5VrrH6evoW0gkgzp5B+RDvr9f6NV40Bq4=;
	b=iDY5H5kKPYFBVMKhykruzvTmRkYeRIFKW3S/TzaLE3wJNCoTEeABebfrYddhyDeNqfZF
	 Y6kb0H+0RlugZ31j8fn1m9dUJH2IoGXDKGd+TiWHlQbtiwkIwEWakmbLZKxID7RSaaBna
	 c4kCJDRXopMXO9Qeb5oqUL0ta3brwFmdEikFU8NPt/5WwKXq4mnXfvvLE2fQvWdDs+gwS
	 dSFhEhdsjbJ0CTa/jPqbJ3p8lKENo6KVz7CoMHmoh0E60se30HP2O4PfBIQNLrFFbEjI6
	 Wl485yPqI/8SkT8sinR4zT0/vu/hXERosHYHe87EeRyvTrNusLaYKSU/OQ1mLXth7RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=InkrB2R2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88F606A32E
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 13:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C88F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=InkrB2R2
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id C6C1C3F3EB
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 13:29:07 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 67ADC27E01EC;
	Thu, 12 Nov 2026 13:29:07 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=InkrB2R2;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c202::7 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpZKqCPb/IjxHGNDvBqBYo3EK5LwfoEg5xHqmA6nbl+z81pShvltFSsQIKxqf85iA+hcFu7pSx9CcM2q49FMLMn8F7b2+Ep6l8g8ifTKEPyIUEtqCq3tlHFiFbHlbXZvw1cl6/kIdkyZbbqjJEbDeeJDimWGEcof2420A7TIcNclIC8UR8ipossZcJwjykBBLEX3EJcaybED36Lma5dCFheHa/KAx8pfTMzzyFIht64AlbA5mneW004p8/Zr/7xt9Y40mpICDNIc5BH8/R5legJUntl1gHO6rYRLlF+x2r0hX9cQiJM7pq+YsGnMawQwOyv52VnCsGo+K5+q6w4oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNGW79TiRE5VrrH6evoW0gkgzp5B+RDvr9f6NV40Bq4=;
 b=K1WtjtIh0kD+uePRmLzMQx13qbRm+sVwbRUw5Bz11YBIIMPHrJWx8VgFOWAKoPfXmRJ51TA5KNm1Tw2klGwUiijjea6Pdem5HhuUfqsQ77n6/+MWliVcDwNkFxbWm3OfnfH2tkR2Hhafz49gVmBGKplqIxenkUNIp/+xhWiN8T6IF8ZmAXj4cf/t1nXiXhEMSrqnYo7Z7XjKniNbWZV3K9RUP2clHfgS9eqv2Yw+OQEPnCxtOXKV9fgqEw/qMww+wqyVo/RE1R9ZZ/gaOLyoOr5m5T6Ii1J6UcDOVdq6O1oGtlHCFiH06YvLJcnYibPzspmGES82amwSqNN5yZeiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNGW79TiRE5VrrH6evoW0gkgzp5B+RDvr9f6NV40Bq4=;
 b=InkrB2R2pMF7fel4yYEErMJ3AHM3BgHsK3xe7wMBVJ0Vxflfd8esr+gY15ecFllUTl0XtMk3rVPfxF1w2KticBF99VCTwhd4kgU2h2KEdg+WNICuc0AidXlmY562nRbCgDc/4jBLOoLE84fxkF5TkJBx2Km+5Qg8jsqoRUPskpIcxHn9eqdduf6ehxxmBmFBJ4/ev18bm8Xqb080r8dpuG9iHyZv6vyDX9XHrqQkCFJDLMpa1odVI3v8tZvHEsynNyufGqjIow+3tFLK1oLz2WROthfqzgT5UlUHSl+EtwMlj654dChsOvxrshRYhYVhPwjtE/ECw1zp+M0lovabmA==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB8500.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:231::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 13:29:03 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 13:29:03 +0000
Message-ID: <c3b7ca5c-cc7f-442c-be5d-9b9e80b0f94e@siemens.com>
Date: Thu, 12 Nov 2026 14:29:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <87cxsa2vej.fsf@xenomai.org>
 <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
 <383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
 <339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
 <6033b5fe-60d8-4032-ab43-58048673c71e@siemens.com>
 <b4f20066cfe191c9aa22e4da524d56838da5df3c.camel@siemens.com>
 <ab4bf2bd-f38c-451b-9b76-d4ed3bbbf535@siemens.com>
 <874idm2okc.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <874idm2okc.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0047.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2c151d-f723-46a7-54c0-08df40c0eb59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|5023799004|11063799006|4143699003|56012099006|261022115727099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1hILe6GgDHnobIKNzbcmfj1GTUJIimk32isQ3ERpt1FizHNRfa18mFWkEMKyiESvuSsk/BQfOnE+QEeELIIMbTKkVWcJZo5rR9UGTTC4sH4jy+PNx/7TYSsuwzhgRZNRU21ls5VVCRanj+Lws3tf/SR9IVuVo+eGjwXb0BSAbUMff1vcaGeR0Ppjvu3lIf2dp7uyakdAApclfyeAn2I4+y88+pkZtgSFI7Yi3K9u677LOX3Lk/6odnYT3COK8KgMJjdu35khHAg2NOXAlkWgA3HCoWmBqrKiRi209RKt7zw0V+H9fBj5t6v599xisnYEXqs0SmhlLVa+44LDHR+UlnNbuhhw7pcidZScUhhbRelzZe+wCAFbcjaaF1331ZsH24QLxRmZ8Pb2cqZyHsQQ4KKpR9mfGqJV39pXlb+sHbDo6Sne8Y3HwqIF606lAEDyCKDA0CQ5J+75efGInFiQnu14Cn/EEKXbJRpJsalMZrsYrraGe3xpRIrVwXxNEVRqtvHk7gq+7T336KZgJvUZvk0FeMbE2zgAcrOOf+jDZkLonSk+ld8Hv2pGB0aBwwCMcjCkvg5NgPyaL7vRy/hjZqiKm2r1S9gX3wCf5lUxWeyOO4tgxdbqydZPS45HqnJXyCJKfisUvYqPSoW8vn2nhaAcCD2g26rpCAPrUhARqhU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022115727099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2VianlaaDZaQUwvNW5pZGpIdHBkVnBIM3NteC9rQ2J1Y3dOTGJrMlN6WURp?=
 =?utf-8?B?MjJFQW53Q3ZiOENLbW9lRDhqUHFnTDdKSkdnNHppa0RNYUlRNmhRUTJjamZ4?=
 =?utf-8?B?bWZXUi9aRTRVL294ZUovZHAveUpFMk1OQ1BpUmhTd1VDTktkc2lUaEw1ZnRI?=
 =?utf-8?B?Vm9TbDhYT1ljVFdXUGkyYWdoOVE4Y0pGNFl6UDF0V0R2Q2lVclF1VzRvWFVZ?=
 =?utf-8?B?TnF1TjRpUkQ2VjBUR29NeGxQZlJTVVJHanl4amJiZmQrUG5TbjQ5bFhXODlZ?=
 =?utf-8?B?Mlo0T3B6MHlHY0F2RVB2Q3BNUlJib1EzN3ppOTN5YmxuRzNEK2JOc05GWHV5?=
 =?utf-8?B?WUJ0QTBIUDNWQ2lObzZhTzVMY2l4dFp4THVUaHMzQncrd0lSSXEvOVUwQkhv?=
 =?utf-8?B?TStPcmM0OGR6ZFA2NVhpS2d2ZEpPQWxoZ0RnN1VKOExVOVVuNlZiZlFyb1Vu?=
 =?utf-8?B?SHM2dnpLdVNVMXVEcHlPNHZ1cVZnTWtzOFZUUHNMV1lNYS9LSU9NRTJYMkN1?=
 =?utf-8?B?dlRKcVA4a1dOSnY5bSsxdVNhSWp0M3Q3YVpuTlprV2dXejk1QTdMbUNlSExZ?=
 =?utf-8?B?YVZKTnFtQTV4WkhwbUxlaG4xMEhYTmVzUnBkVmJLSUNiQW0vQW9rNDJTZXBq?=
 =?utf-8?B?ZExncmxoc2U4dlNGQ2dZVHU1MUkrSVhJc2pjdWpIYllGVTNMbkNLd212Rkxs?=
 =?utf-8?B?NWJLWVAreW5NaWhDdm1LWkVxRG4yL3hlaWplR1RUVThnWG1TeVpHSEVUWGty?=
 =?utf-8?B?QmRZZ3luQmdHekV3bi9qOE5Xb0txUW03UU41K21YOXhVVG1BWHBHb09iY2tu?=
 =?utf-8?B?RnY1VnU2RW1BTVVzTWh0c2o5dTFqYXZyR1c2WVA0MVU1enFyVVFCU1RLNy9u?=
 =?utf-8?B?MFBDWE14QzM0VHVkV3dZSTdmQzVpUDVQdUQ1ZGpDTU14M3RaNmI1SmZBamNw?=
 =?utf-8?B?QlFHN1NBa3Uya3NJcFpqZlBlL2JjVlVSTG5RU0JweGViK04wWUg3ejJKY1dH?=
 =?utf-8?B?eTNkVVdsRUp3TjRianVuTDFHQ1VRWHR2b1BNV0FIc2wvT0F3WW1uODVqNEVv?=
 =?utf-8?B?UTE2VGp6NUZQNnc4aTlkdWRiU2daeG1IUC9sZHFFQUV5WnhZVEozZFJ4VWxp?=
 =?utf-8?B?NFRNK0oyc0k1a3JxTzEzMmJpZUEzbFd3RThTbkZTQ1lRd3daMWwvNittaWJ3?=
 =?utf-8?B?citSUlF4RWRxYk1ONWxHS051U0VtcCs3VGE2ci9rMWFQNFFDdDZWZWtKNGFS?=
 =?utf-8?B?ZEMyMlA1NVc4djNPL1d4a3FleWF0Ui92bFQ5ZGNuTUxhUmRUaC9Gb1hGaDk2?=
 =?utf-8?B?VXJsSEFldkpiOHBmOFB2TCtzcGRCOHQ5SGxRKzFpZjVNSHJENVZDMkRIc1ZE?=
 =?utf-8?B?anZrb0U5UkF4MVpaN3JTbVNNMUttWFQxYWR5RUdYeTQyWml1U1ZUbVRrZVBK?=
 =?utf-8?B?VTd2Yllydk9RMGpPZVZ3N2hJNWJ6UExoVnNVbytTNTdiRHhSbStRTW82ZXAv?=
 =?utf-8?B?R243YzdldHJnYnZvU0E4REpHSVJmVURqZTI5SExSSG9rQ09HVmpnSlBRQ1J5?=
 =?utf-8?B?QmJuaFdjUm9iTUs5aWN0SzVieTZMWWlGYU9OVzM1MjhPS2w2NHNvd0tFMU1L?=
 =?utf-8?B?a0ZhQm9BbkRzL08yWXdDUVBZUmxySTM1WG9KR3E5cDVaczk3RDFrd25neCtm?=
 =?utf-8?B?bVJBUEQxMGN1SWtCK0REK25JRWthQnI1U1pieGN6enJUUVN1bDBXVjVTR2gx?=
 =?utf-8?B?UkZFVEwrdEpidVdxTlkxL2JRcG9hQXNpck5PM2lKWXpZTmxOYU16YmhXU2FY?=
 =?utf-8?B?NFUxMjl3SkhGdmhOUFZlYkFhVjhIS1A3Z1JLQjdVL0lnUWJVNDRkemNUOXhQ?=
 =?utf-8?B?K1VZK2RwQ3NUMUU1YVF5MGd4THRRdnZ0K2Q2V2VKMHFDQXRGUHNUUVZQbFE4?=
 =?utf-8?B?QVNFL000TENPdlV1bWpLa2VSM3hsdFJXeDRwSmEzMFIySkJWb0JKclJTSUpK?=
 =?utf-8?B?bjM0eWR1MTJoWUpmb0FzOExJQWNMVS9jaGM0SG9wbW5WcXpmUFAzbmQyTGdN?=
 =?utf-8?B?bjU2VXUxRmRINkF2NGRHcmdETTJzZVM0MFlwcHk0UDdDRVVzYnNlMkRFY01U?=
 =?utf-8?B?Nk44am10aDdhZXRrOUM1TlQzdEFvUFVGQVVhZHNqcHM4STVZZG51bm0vQncz?=
 =?utf-8?B?ZzdJVU5yeHpGellZRjg4MERFdkp4dGRta1RVNXQrQWlibUcwK01tMU92WHA0?=
 =?utf-8?B?cFJQZzVvZXpoenNQMnc4L1VkZEdjTFJWNm1CVTJTNUtCci9mcTF5Z0xpVVgx?=
 =?utf-8?B?WHdhT3pWVTNyc2psZW9XcVhsVXFQU21CUE5RRkgvRFJpcDJZZTNZUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c151d-f723-46a7-54c0-08df40c0eb59
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:29:03.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIQmyrh8J40JJRbVwHcH3BKvS12xxEGKtsv5d45nM3sp0JX+JMETsdxLPBhQTKnGJ/5LTRUPHzHP4AYWlwjb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8500
X-GND-Cause: dmFkZTFzazFrcb+NHzy2xCbcni9+CIPQWB7F0NE0KRjR0eFtced+Z6z6khtrOrH5nwRHtawV4Es5jDoYy1bfl6LrMxvM4dKDBCwqDG5iZgQu88Gm5jmZVv8HPg9aHsj7dV8CmnIB8aA9uyHS9jvFEfeMkE8RBoKbkboUTh1hrLb3XmgmkeFLmgpqPvbxEgCkU7qB38CZkQekK47cbkKvt/oRwwhd+FRW3dcKaq20SNV2Z0wKklc+wRn+G1SlwWAhsHjb4qpU31SfOEQC5jWIQZzpszU5+6Moce3K06knTX+SLM/QgMyUmQFeLVb2P1aSED/GydlR/UdE22L1dDeTNxL91IgzbNzxe6zM8lTYbE7Rzczo0BsgL32PjZUWU+9P+QF/P5gXzyEX0BGSGO0rc9CcTp44dDndJjTeoNVAHcE3lbPjOdi4FwXHWhlCRSumoX1f1gzRPNtJWkcYqlW3PzmDQySQ2eL6OXl1AHgM1jJFZUeEJ/CAtLTKfCL24gB+NDWk6Sby1FhcbZAHcjCqsv3+q2fTsHfikn/yG5VoX9SMzlcCVE2On+DdXEtTZiY6atLLx5KE11r9vAStmQXOI3SYdIrSp3LYjiloTwBufy9jK40NG6y9Nc1UK+5TWidxzx2jBcQdE7hRyHhUgzYvseXV7SRyhBozq4UwJzpetL5myJ+Kkw
X-GND-State: clean
X-GND-Score: -100

On 12.11.26 13:59, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 12.11.26 12:39, Florian Bezdeka wrote:
>>> On Thu, 2026-11-12 at 12:30 +0100, Jan Kiszka wrote:
>>>> On 12.11.26 12:25, Florian Bezdeka wrote:
>>>>> On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
>>>>>> On 12.11.26 12:05, Florian Bezdeka wrote:
>>>>>>> On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I will share the lengthy test case as well once I'm done with stripping
>>>>>>>>> it down further (if possible). What the tests already demonstrated is
>>>>>>>>> that unpatched kernels crash.
>>>>>>>>>
>>>>>>>>> These patches here are almost completely generated. One of my few
>>>>>>>>> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
>>>>>>>>> of having oob_trap_regs as a nesting detector came from the AI, though.
>>>>>>>>>
>>>>>>>>> As usual, AI is still rather verbose in descriptions and comments. Some
>>>>>>>>> of them I already shortened, but most is still left. We can cut down
>>>>>>>>> further, but I would first of all like to have another review round.
>>>>>>>>>
>>>>>>>>> While doing that, keep in mind that AI tends to ignore issues left and
>>>>>>>>> right when being told to do a specific task. It may have simply missed
>>>>>>>>> further preexisting issues or even created new ones now. Watch out!
>>>>>>>>>
>>>>>>>>
>>>>>>>> It looks like patches 1-3 have landed into v6.18.Y already, which means
>>>>>>>> that you are confident with those changes eventually.
>>>>>>>>
>>>>>>>
>>>>>>> Those patches should not go anywhere until they reached the latest
>>>>>>> development branch. The common "upstream first" rule.
>>>>>>>
>>>>>>> Everything else will add a lot of confusion.
>>>>>>
>>>>>> The v6.18 application was experimental, to validate that the test suite
>>>>>> passes on real hardware when all issues are addressed. Nothing is
>>>>>> official in rebase branches until it is tagged, including those patches.
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>
>>>>> Why not just push out a wip/ prefixed branch? That does not require to
>>>>> temporary update branches looked at by different / more people.
>>>>
>>>> CI is not picking up such branches.
>>>>
>>>
>>> Which is OK. Those branches should be tested only when requested
>>> manually. The "internal" infrastructure has such a feature, while the
>>> public one is missing that.
>>>
>>> Upstreaming was not considered yet as it highly reworked the xenomai-
>>> images project. But maybe it's of interest now.
>>>
>>
>> I'm not using anything internal. If you have a patch for the official
>> one, please submit.
>>
>> But pushing to -rebase is also not a big deal because it is, well,
>> rebasing, not stable.
>>
> 
> The dovetail rebase branches feed the evl trees though, which follow a
> rebasing model for a reason. Although I'm not concerned by the specific
> patches I mentioned earlier which look sane so far (review is still
> ongoing), let's keep in mind that dovetail rebase branches are not the
> right place for unstable work. As Florian pointed out, wip/ should
> preferred for this.

Rebase branches were and are not stable until they are tested. This is
what they exist for. Once testing passed, we tag. This is also how I run
all the stable versions I maintain. In most cased, the tagging goes
straight on top, but I already had to fix up untagged branches in the
past. Or rebase them once more because of further upstream releases.

Now, if you ever tagged evl branches earlier than dovetail branches,
that should be avoided in the future.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
