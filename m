Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794483152;
	b=nDBjYXtWXpQyyvssFKeoXYi+fOs4xSn8cTZw/qK5qyyP/cwQelekBj91/9rR5lzndAdx
	 4Sc/6ITpgShwSDAJ4ZXJaXbrJst7g2i1p9vQa8aagfaVnKCHFg/1tFh/U5nooaLCcbvi3
	 HTfz5Dpw7Ep4S+l3aaOnT0vSI7qMEkyXOHJNZd/Qk35Vq8/G56flZlzMLO8GW6qCGC5SC
	 f7wTA63C3T1jEcKXS4vFGh7YayBDMPZH+tvZV6NaBKaP+hsXdV3UcZm8ZM2pkKikNPma5
	 Z8yEh5tcR25vBF1DmVOjZQ9gMb6aZb+awbA1eyoZdHgc8fuZJd0CbGvnHN/S0xJi0YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483152;
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
	bh=vkdI/Pm475z/H2DVMBfTZdiI6OpWoMusyXkGoHMefT8=;
	b=0Tp7u2WNFVnAYUO9X6/2zL9j07LcbYBfxVJ0BvkE07bKEPFhquaTw3itOc5O/HHfo41q
	 Xy/WK/PiiQ7DtZtacegljAxREWWWvKnXfAcKFHtZ+iWg8FNsKjxRZ0shbp1Z3v6umWHKM
	 iQ1weAHlDozrtzlZ4lViX2JNpugFokBuyWsRerePh8fIf10+EMbXJaQnj+h6dqkprgqGu
	 sCKlGS+S3WCDKFWBGFMRNZuwiG6qvybUnrb0Hqfn1sg0Bq/wgQ/a/iRDbaEHNQuSjasQ/
	 IjUUr7vEBJSfy/rBK95d+jM0wEF5ZPoJBBw7BZr5kV9Tq4YdUjSH/mOPqBpoieAwCAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Og6SW9eY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.50
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F75606A330
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F75606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Og6SW9eY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEL536imM1yuWLUhGWNeiaEVKMFRxLsB4QdHRIjnrQCW1qMTAMuHJyN3ACyvN6t1DNSN9OAVO3KkY4JfP9UiT4HHrBCg0ny4nOFor2MrACO0P8oB7U+anCMOkKAAtWPQM+zQc6LdONL9CeuRg/AoQWduDjaWpMSHwb/8lwz3fR3R31byGgiIrxXAHi+33zRXQpxgLRo9Wqm1HrqZ/4A0Qqu/UE0b5Qhw3oheD5P7tNstIVoyjGZ4xKnXe7kguQadXbrDZfBDo3vJH4Qekbo6Wlx9JW8Am9QHm6Nj4D7J41qe2WfhlmUeOnyflSU3pJkVwqJOUgk6BTipZcG4kglY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkdI/Pm475z/H2DVMBfTZdiI6OpWoMusyXkGoHMefT8=;
 b=FRQmON6LJAh7nxd5+rJUR+h9o91WecIncJxvx7MxjWGClw4wM9an6cL4echP3gaY31juEsBxNIFmeumpGscVOu6oMn+3s18SocYFFb44vFfD/mOcPuSSrwfW1rbiggPdm2cnzuCbFtNn4zwgsPOvJ3gSHyqJqA24YLZEQM/tP9PrPMVpLj+yIj7Irz6LIWK5YR5bsy/4bsICbbnM8R1p94dMFWNN7pP/kgO+umi0eF34+NF4TPr7B37rkZiSrLgw1YhDIqp4xg5AWM0GItCPbqWh9uSrQcrjTNqqu7VWO3LiIL1auI2/8xN4ECzoouB8XVo+y99D0tHHv4Alrb0cGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkdI/Pm475z/H2DVMBfTZdiI6OpWoMusyXkGoHMefT8=;
 b=Og6SW9eYYVgccgPYYOO7E/jAyr86mLM072WH99xWPAjI/OTO1f18abuSOtG2MNwQIrdtLZBmRj4ZJ/gu4W8oG7XrMOqyI7TAaeqJRKcCflHnIcT1ieIQNdVT+/uBc6cFg13saBKHy1dONgZxPrfwCViewqnPIvbCnxz8QPi4Y2kyvOExuj942PpsOUSCY6/ma32HExn/PGCbl2/oucFJ/+Hn1bpMQ5R0e0zRQrxxwMk7Tm6fDzIB1mx7IfbWPjBOoKxNFjzkcd9dTpfEghVi0NCGKK55SacSrwZyYdfk8P1tCswM5TZI9oOlfOrlZ+IbZjfyGGmdvILF+Pj8b8C1eA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAWPR10MB466209.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:4de::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 11:32:28 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 11:32:26 +0000
Message-ID: <e6cbf1cd-dbf7-44f9-8956-95d010fff9a0@siemens.com>
Date: Thu, 12 Nov 2026 12:32:25 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] x86: dovetail: Drop bogus local_irq_disable_full
 from __bad_area_nosemaphore
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:785::10)
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAWPR10MB466209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d829b1d-3d19-48cc-5b23-08df40b0a094
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021135927099003|261021123027099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jo7yRiixpwR7s0IFOQRDxYOvrQVQpf+pUNPyofnREwXrO8OY5CFyExm0HdZu8AgGDU+wsk/StrZi793s0EMEgq31TT1vPpToP/z0WuYA12GUqQykb5MZswUnCJLtgi1ZYnJ3qwbGZI8fXpH94y99GcwoA3LbmZn79qKTBQggOTEzB79OId6GlhxGHkw2YDwBdQBC+aLPoOHZsjhy4GASg4GWiy76fAgM1NxYPtTCJJvyBpLuw4XIpmARG6HzEE058a/ZhwcH5MIUdXvhsjcOy/70nAGkqUg1hudmJ6NNcfkLxO6ybZ3qCjgl/bP11mTu04XTTs9ObLuBr84L+7/8oCi1jlYk/EQIonSxaHzoRd95anx7X8LB785qrWhRTbqqRAv9bUDrTFAkZKqkVZaSn0d/HTj8HACjgxbWyZElTN26+qMOy05KiqO1o5hQoca8kBTrDwfnuAoSp5GvphVDVohORD5wPIqxoW7wEEtG7aBnbfqz2VAfXziO4ymwmeT/E9xs4cczyDXtXCT4wvlR+6QGuJLHRPsTfeohPJOGNxwdcaRviNOkECWoqDMBb/czwwn5FFikR66xWVvoQaY26qfxMf1WBnQT/jU1XZa4RxsKwc7mE2FmVcGgDAYVcJcG01+HsJgcjv1axhlJFe5rPRU1gl23Vvc60WNQCpSMSYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021135927099003)(261021123027099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGhCQUhFclVoSHo5c3htT1lzVXM0Q2loRytjNCtOdzJMQ1hjcnRXZEREWlI2?=
 =?utf-8?B?UlNvbTd5WG9RdnBPRFBYSE8rS1REQjF1MVcvTHVDR0YyNS85RUNORVRTZzZT?=
 =?utf-8?B?Z2RDYVNLaVZlaTFsNW5hUWI3OVE5U0NBUDBNeTZIODFJRVlLZGNRQmdyaHls?=
 =?utf-8?B?RHEranpKdFJNU3pjTWR2SWgyb0tHbiszUTJqUlNkdlE0Ymp0NlltQ05QTHVU?=
 =?utf-8?B?Q3hncmZ4aTZjZFFUeVFXbnF6SWg5dS9aVmk0ZUpOTHZ2Z04zODJVdjdZR2pU?=
 =?utf-8?B?ME8wTkpMR256ang2dnVxclMwR3VpYVZxdy9pa1BzeTJtQllDUk1qZXVXdDlp?=
 =?utf-8?B?ZVVVdVZTMDErWE05R3JOKzRLMTZzbVdsc2FlZWxyYWVWVERUQ0x4cStQNXRl?=
 =?utf-8?B?cGxmeDlDRjNDd2dwSFMyYk0vK0xCMTdqUGE5bHBWSGNEdk9pampoSGo4djl1?=
 =?utf-8?B?Ymh3ejlrN2JTeW0xVWhacDdISnhKR1pYTHlrd3U0VnFsQW55dG1BZHVrcktq?=
 =?utf-8?B?SVJuY0gyRVZQbm1vNGR5Zm1TTGFyRURvQ0NHSjJkK2pkOXRjZHBuQW81UHdV?=
 =?utf-8?B?VE9QM1ZEMUVDUFlIazhrdWx2UXVxNmlXVjJRZnl3RnFIZytpM2dnTlBPSVVa?=
 =?utf-8?B?OGVqdnYyTmVMcnU0aHhsZnpZZ3dpSjhUT2VTTkFVcnZxZkNISXc5c1JIN21K?=
 =?utf-8?B?dWVLd1l0c2dOZVVVR0VzclhCVzhGUURyOVpZRHZjajBjdFhXS2k2QnBuaytB?=
 =?utf-8?B?TGtXVC9pd1BoaXVGRFlCRUZ4dlNyc1hoVEo1MkE2b0xkZFIzUWZ6TXZIQmdk?=
 =?utf-8?B?ZzJ6MXY4RkhPcU5hc0lGcWFoVjMvb2VwQlVvK3BLRnNyWjBJUGdZSmlZa0JU?=
 =?utf-8?B?NkJjNnNoZnBRM0xCdk40S2lELzZzN2JaN1ZZaE5vazd4VDVLT1J3SXVoRTVT?=
 =?utf-8?B?cHpTaGJqUmlldS9LRklFRFdmNWF3enkwRlFwZUZhaFQ1bmdndVp1NXdUK0Ny?=
 =?utf-8?B?VHhzTldPNWN3T0lGYVF0ZEtUaktyNUZjc3lMbDdrUlZMYVZia2pFWWRIUkpG?=
 =?utf-8?B?WHpUNDhFVkZlK2NXNW9mSExlT3BEYzFjNkpYOCtvbUltMWJHS1d1OEJBaUZG?=
 =?utf-8?B?eFJ4dWdLUnBwTE1YdWpVY2hhaXVFcnRNUUNYeDNHWjZ6QlMxNUUzdkpyRjQy?=
 =?utf-8?B?a3duMU5MSFU3TGlZeDB3MVRmOVhyMFFjTkR3WDE1T1IvYmgyZUNzRUhYZXFD?=
 =?utf-8?B?UXExNElycjNEeFhmUVdiUnJldG1rNWVJZ3hTOURLZWRDSkVsMnBEcDdUSkZN?=
 =?utf-8?B?L3RlRjN1Tnc3cHJYNDFLTjZGSUFHdmJwcTl1cyt3bENlYnk3b1l2eWdkU1lH?=
 =?utf-8?B?SFZGSzV2N2pwVWVKSVVJTys1dFpWNTdIQ05IN0dBRTU1L0g0amgxa0c0UU54?=
 =?utf-8?B?SmxiMThURmFYMG5OV1ZYeElIcWlFb1pGL2toYXVYeWZEVDRKdUlxMmJWVktr?=
 =?utf-8?B?R2g1T3JTQWQrbEthRzBGYlEySzM4VTd6Rm13ZHExcjJGbnZselhlZFJJdC9Z?=
 =?utf-8?B?NCtZOSt5eFplVTlMR1JqeTcyUnNoYWlkN29NcXUyZFlOL0JQdFRQRGl0azNt?=
 =?utf-8?B?ZUFXTDJZMlJFYkFUTVpIaCtFU1J4Sm1PTUh4MDZjcFYyaGFJQTIwOWRMcjQz?=
 =?utf-8?B?WFNCYUNBTzVCbVRrV1BDZVdoWm5tNjZubFVTWVlYVjVJenJDdEdUT1lXY2tG?=
 =?utf-8?B?Uk1sWTg1Y25sZU1Qb1pXVGV6bHpLQy9hcFpjZEhwb1JUVEJ1RnM0MHcyYmor?=
 =?utf-8?B?bkdBdnVZd2o0ZEc4Tm96cnVTNGxUUzY1MWRjbkU2N2xZVWIzSkw0dGFuUG8z?=
 =?utf-8?B?d2tNOWFQMUt6MXpIWG9DUGE1WDIxdmkyRVNkNVJhenlqQkd6NmhZMFNOYVhj?=
 =?utf-8?B?N1UwazlsZGQ1aERsN2wzYlR3LzBmTmx2czNJUDRIN0EvS3JDQmRIdC9mRG5X?=
 =?utf-8?B?MzlGeU5OM21tUkkrRnduNEJDT2xaaEptYU1Rb0lQaTcrMEF1QkQ4VGUwQ0s4?=
 =?utf-8?B?OTJDRmdkNjhWbDg1VkdSR1AybzRLTFZEcVFXNFVMaGNpdnhFdlloeVRZRkYx?=
 =?utf-8?B?RTFFT3F3WnpYbnh2MlBuL2IvMDluSElwR3ZUODluU3l2UEZiYUxuQUNNWFFD?=
 =?utf-8?B?dVhFMzRDeWo1TDY2Uzk0dzd2R09GVkk4V0Q2cFVibUdCSmRmRmxuR25KYk1r?=
 =?utf-8?B?MzA0anhXM1djYXlNM0tHZCtaSUM0NFFWb0JKeFhUODd3YU45SkpySUdldmhj?=
 =?utf-8?B?OHBqeEpkMzVLdGlTb08yUjl4Q0x6M3hybGpwMXRLeW1qVjNqNGMxQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d829b1d-3d19-48cc-5b23-08df40b0a094
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:32:26.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qtu9XEgk06PqpKZbinUKvh0Wx+ici+E30eESOeO5U0ckjIkczCZf0Te6pEjSGnpwt1p9bBuWhORnXkBMIoOTCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB466209

From: Jan Kiszka <jan.kiszka@siemens.com>

There is no technical reason to disable IRQs here again, neither when
the IRQ pipeline is enable nor when it is off, which this change also
causes. We are never passing this point from OOB because of the
!running_inband check and jump earlier in function. The inband case is
identical to the !IRQ_PIPELINE case, and that one does not need any
additional IRQ disabling as well (upstream code path).

The addition was most likely a mismerged during the forward-port from
6.18 to 6.19. Remove it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e41ed2092730c..e9a08a5d26e60 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -886,8 +886,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		force_sig_pkuerr((void __user *)address, pkey);
 	else
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
-
-	local_irq_disable_full();
 out:
 	oob_trap_unwind(X86_TRAP_PF, regs);
 }
-- 
2.47.3
