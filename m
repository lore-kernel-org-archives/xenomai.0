Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA21F707F
	for <xenomai@lists.linux.dev>; Mon, 21 Oct 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539673; cv=fail; b=JquEiNfoAfQkhPrGquKPJiPMq5/CV13He1i4OX91m3KblhbQKMTdbVHJberhvhlm5kXHCTo7aUGutsrmMdoIfBJ1Yqx9WZkVvSMS6UGXpq1aR62pmvz23jzxMTblX41Wnx7Jd8tZU0Y4jtunY4Dk3DkPnNn7zjs6Ec2fLh8JNgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539673; c=relaxed/simple;
	bh=ikiakN8hVYxFjun3Wl0mfnCwIw+hjwdK0WsBzRWnY78=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=ZcAsZ5dt8GJrGnHY21jy8WDXq1NG3oo4MLq+7gY8/itW/mq8bJt4bDrGssPYxYbyE2GQg2Ke6Jdh2sQgCnQs+ftJxioPN9Fwn17aKL/fuMcG3EIlviXxxvKXKi6+WLeUirQ7Xu4qIFbVO2jtzN94I3dBH+m27aTxO3PlUL2y3e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZjRt8pYY; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZjRt8pYY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxx0fiNxsnXLazuwaz4TlhlfDguAnpHfJsbdh0qXjgdV5X3ER+jBiegX6JBbPF/9xwFkBN0J1Ht8QjsOdSymkLbiOE8i4HmFHf9W5QwxEq2HxO2aj4WCkLxG9mzQUnee1a1rtBPuHXKd0I/hOjPRfzCUJhjKoeU6ILv59L2FOIAWtdPLwXvro1wQLzMneVBVUovBPri7CH7ht2syX3+K5SwXxFkRh3kbA5tHZ+AshO6vu89aNJjANaewgs7uOtmTjsbhoQQ56aeUQ7sug2VgQ71NJDWY9ZvfD6B43rqjfq0AJF4IelktbIU3/2T5m0oMoa/G850CjbuN9WhNGt1QmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgzFJsNN/zErj+kuAYsoHslkksAK6QoGxy6Afocvmwc=;
 b=Qzk7F1U0GR3wG0WKQ59dMnuG8vyKfP862CckOC2jsm0XQt+scA27k5dnWMw/JQxhI7J3NEk/y3pBXYpk2+xfxYwfALSDr11jd4irunw0vNv3EcTOesC9Sad2Rt9tFmBfL/9UBw7HHGkhfL1uN2VUYofySd/2HIowSgl4CT2tCa1bV5tTMgoEPdEub95KXV+GsJOaKPAQrVyRQoATl4sH9FrQX7wCg6aCndn8wrWcPU9z7WXZOmLtFr2akEJbF+RcklNqOCq+doilRfmCEsuC3u0PuMKI2noGYz/7gvupy0D7tvOAn0JJXDb1F+Y+2v6X9Quujop9AJTJGxM+pUHDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgzFJsNN/zErj+kuAYsoHslkksAK6QoGxy6Afocvmwc=;
 b=ZjRt8pYYXmxZ1wH8E2rAfbKya14QtE0ncvFCPimXw6Tplg2sHKYH6uyXq7C4IaMiaJdE0G8BMqJ/iYrjb6ep73o9WPYQZlO//JDWuK8p/vK6ExyXIKmwJTRFJObBnNcIffDLlqwkRWprXEBaOrHUtvARlEYYH9vRDVgcpGM2Eo7B3IlaLqPHpuStI9gukQr/Qc/b1iWLKma6mPuCYG6eBTsuAQ2NfEJnX1U4RP2zPj5i6BQf3kpGEAfPADqHQkzUYKfAtkhdiZ8txs2fp+4R7HIkU2xt+ZvD8Qy9MIYaiwl7njAesg/P2z0LdP4Cg4spbRxDPJG96xZah3DaBFvoCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB8019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Mon, 21 Oct
 2024 19:41:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 19:41:09 +0000
Message-ID: <f26169a5-7ed0-49c4-bdcf-c4d973d68039@siemens.com>
Date: Mon, 21 Oct 2024 21:41:09 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [ANNOUNCE] Xenomai 3.1.5 released
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 782ee23e-8ed7-433e-af2f-08dcf2084fde
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjFBbys0cWRsTncwTWxBV1pEU09VTXlqcFJVWFlkZDRjRi9ERzdQREpUN0ZF?=
 =?utf-8?B?cnNMZkxBK0pubkpCbWQ1NkNvOW9wV0FQSDRmUnJRVnZySE5qbVE2dDFla2ho?=
 =?utf-8?B?Rm9ZbjZsU2lXSmNDZU5kL21ydHBNVTJrbEZKdFN3OVZhMVc2Tlo5L0JhREtH?=
 =?utf-8?B?eldOODhYa2FUbWU5dDF0QTBvcnBDRjI2MGFpdmdpSGhyVUh0QW9hR0hqSlFQ?=
 =?utf-8?B?OG44U2dCQjgrVENvQjRyd0xlaTBZbk5GS1p5MkJ2bWZFQXg5WFpFRytwWXd1?=
 =?utf-8?B?cjJKd00yVHE3WjA5eERTNE9pcnlTYVVCY3V0QzNET29EY2Z4eVE4ZXV4clFC?=
 =?utf-8?B?R3pMc2ZjUGtXTXpudm83cnBTK3FnSWZzelpQaVZidWRyNUlXYlJBM1laL0Jj?=
 =?utf-8?B?bHhsMmg5aVVXU003YzlLZUtoM1dKYndEbnRFZlB4UTY0UTdhMGt6N0wzaklu?=
 =?utf-8?B?SktxalRJUkpKRzdrTlBIYWM3cTAzbWxUNGp1MVd5RFZSeFFEVWxycS9TdjFX?=
 =?utf-8?B?VDNQLzMyY0g4ZVJDbExHVmcyeUE5Q2N0cExkMGdyd1hPK1JVN3dpL0tZQ2VS?=
 =?utf-8?B?TjdsTnJTZFVsWDFCS3dodkh5ejNLb1pCeTlaMGxnUm5BV2M0VlhXVE56Zy8y?=
 =?utf-8?B?dkNnMXBBNHluY0tDZ1JQL3oxMXA1S3pPRVNYOWY5WTNTQkVQWGFaZGtHYXlT?=
 =?utf-8?B?UEdwanZtOHBKQTJ2UWJaWHRwc2ZJU01yblNESTBGcS9WWkJIMEYxMVYyUkZL?=
 =?utf-8?B?bUlJZWFOUVczc2ljcDdmUU1ENmx5U1NPbm1hT0lvaThhUmRNUUFwNGlFdHB6?=
 =?utf-8?B?blUwdm1QMlM2d0hMUmRFQTZPMWMvS3VLU1l1WnlIVi9RWSs5aS9IamZFWG52?=
 =?utf-8?B?aklsNmtYU1JUWkJJcHc5SWJSaUw2T1FtQkNXWlNEWGdXbTdIMnRxeG5ZYll6?=
 =?utf-8?B?ZXBXOUhhdWJ2dFJwZUdzQ3dUNWZjbEV1YUthdHRnZXF2ai9QOUpkdy9jdVVm?=
 =?utf-8?B?ZGxwTS9HNHRPVjdqMzd0U0Nhc3k1WU1CU2kxcnpUdVNIM29TVjBURitSSDBJ?=
 =?utf-8?B?aGpGM3g1aDVtT3JFcHJVc3JFbjFRelVCaFJhV29ISldBWkU3bS9KdGRtOFFp?=
 =?utf-8?B?b0NmSzYvNzJOaFRvRXZOVktDV1VBdUExWHFHb0FPSkV2V1ExWXkycHdKVEl4?=
 =?utf-8?B?TW9NTytTdjJGQjE2K0VWcWtPR0Jwdyt4bFNrb2FIOHRIa3hzZzBOTms3SWhE?=
 =?utf-8?B?N2txbUU0Uk5nd2QxQm4zeFFlemtJLzI3VkVoWjRZS3RnbWcvUzJweExTMjJJ?=
 =?utf-8?B?MXVPVUgrd0c2dnFhUCt4a1p0VjNuOWN5NWdDSG9zRWxzN2M0ZlNDVHU5MjJS?=
 =?utf-8?B?KzlQdGhpenc5NDZkTFNKbXQxRjFkRTA2dzR5bngvZDJ4dGlrRE5BN2EyRlVu?=
 =?utf-8?B?VnBlQXcrbldycFg4bEdlaTZja0pRV3pUVEFQbkR3RllFcHFhamtRR0llZkho?=
 =?utf-8?B?VXdxOUQ4RitGdExaekRWVXIxd0Rsd1RhQmhKS21hNGY0M1o1NUZJL1l6T1pH?=
 =?utf-8?B?N1RJcDNHM2FvUFdsUnROMjU4UjN6U0FKUk9yUFdVZy9Bb2hHckV6QU95S2hj?=
 =?utf-8?B?VlBid1kvZkhWaHU4OW1WOWlha2c3ZGV5R1JjUkJnRUd3NUIvd2MrVmh5YjhU?=
 =?utf-8?Q?K2S4FTpxUjpAb+lvO0wF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDhac2QvZW15RHdEbmgvTGROZ3FwaUVUaExIQWkwOXpoTTJLR0JMZUd2M3h3?=
 =?utf-8?B?eFI0TDlidUZQUEVCa0dGeEovcU9rKzZtQllnTHR2cTg3RkZ4V2MwRUo4WVZx?=
 =?utf-8?B?RUwxVGkxVHNoQzl1SlBiZGxVbW4zOWptVGoySTQ4OUxJV1h0Syt4dEp2TzFj?=
 =?utf-8?B?aEd6VVIyK045OHpxdy9FRyt2MlRKdTVxSEZUK2tYdzZUVTF2QXh5RmE2Sjly?=
 =?utf-8?B?a0wvQURmWEVqb1lTSmZoME8xbnVxNURIc0h1Vk5VWEtaNGdNakhZWWs3eUpN?=
 =?utf-8?B?RGExL29OUlpXN01SeFI3R05hOFJsVWNjaW5uKy94RzNlVThkY3RURWZGdGVk?=
 =?utf-8?B?YWdjWTcwcDE3UnNPQUxVOFlrMUpKdlFNR1UyWHZFMFFvUzRnTk8xSDhJVTYv?=
 =?utf-8?B?a3l4VzlvYVJqMDl4YVdnLzU4aTNRNXdpZjlHSWNEbXB5WmZ6amo4REk4b1Vt?=
 =?utf-8?B?bWJHUEdVMHBsSGZjQjMyTzFPMTdWVWRBVGNyd1o0Z2tseDh5SW5mWHZUS1cw?=
 =?utf-8?B?UE1jYzIzRGNabm1aYVJxdmljdmdwYmJzUTN4SzM1SUpEREtQdmZKdWVyZFpv?=
 =?utf-8?B?dU0rbGJYamxFRmU0NUZMdzF3QWpoZ2l6N1JkR2RGbisybUZ6T1JMYzhBRnNV?=
 =?utf-8?B?ZWNlMS83dXA4SzM5a1V5TURSaWxIVWpsQzVMeXBvTEtWQlJ1OUJIcVRhZUNI?=
 =?utf-8?B?c21KYVJxa25CdURaZ1FxbTBuSkM5M0xReGRPdWRKUXdaSzJuZFRvL3FrTXZq?=
 =?utf-8?B?bmZBalBnV1lWTitQd1luU2llSGpKZVQvYk5iaUdFdW1DdVExVFhzVUcwcXVH?=
 =?utf-8?B?bEFIRmVQajdaWWE3TmtwWk5Id0lKakxiNzhuTHA5THRnSEpsZWV5WFZNbFA2?=
 =?utf-8?B?ZjNyL2FWWkZUVXZHODJFTUNKVUFnelJKNlczQkpoYkwwdVV3ajY1R3hPc2xD?=
 =?utf-8?B?MnZxZVROSjh3a1hSR3QrNTlKRmZIWExJWFRKSmhSTCtuUVk0eXJqMFFJSTV2?=
 =?utf-8?B?aVdlUi82b3VQSHN2NzhRbXpqRituNGJ6VUJOSHgyRU53ZVo5RnMveW5BM3l4?=
 =?utf-8?B?bDgyMmltZFZxOVIwWXo4eUpSR0lHcklWNDNzN3hSME5sdXVtMGRUd0JiTitx?=
 =?utf-8?B?UVhMR3FPYnNUWG13Q2xiNlRobmtBUnpFTlJEUmZjWmJHL0k0UTYrVVIrUjA4?=
 =?utf-8?B?aWpvNnJQYjAvbzlxYVRCejM2UW5vRG02RzB4S2xUUzMrVzRTTHFaOFowYWs3?=
 =?utf-8?B?aEp6YjZsNmxGMzNJUmx2OFd6U01veGtCT2xRUDAwSzJYY2RQalNiVHNKbmw5?=
 =?utf-8?B?QllkcjFOcE5sZ0xDd0N5NWJFZXk0YUdwNWVFN2dDMTE1UFZXZGphR0crWTh0?=
 =?utf-8?B?amJOZ2FDc3g0SDFNcnlvcnFvMFdQRHdYVU50eThzVFBvQndyckhtMys1Mllx?=
 =?utf-8?B?SmQ3RDdoNHFSUllGR0RWbmVmRW1EaiswSlpPVlpQSm9CWGNXajlhK3JUcG10?=
 =?utf-8?B?SXVnRHBkNlhJK3laWE5Qb3NXazA3bDBEcWgzZDhGaTlKZXdTMjlZQ1NSMjBY?=
 =?utf-8?B?OEFEWGEybjAybU1FZnN2dEFIR01vSExxOXdKWHI3MUVwS2dhUFZobnlqSWhp?=
 =?utf-8?B?aE9saGg1VkJnWU9KcHZkQjFpL1JNRFcrWHpkVlVjTUxJbmdFb2tzaHVrc3BZ?=
 =?utf-8?B?TXJPaFJhaDRiVEFJMElUdEp0dkZnTFhvWURQakFWZk1BeCtGb2x1NkZWdVhF?=
 =?utf-8?B?ZXBzQmdVbXd3QkJVUGlsTmFYYlkwRzFudzJ1czZNWmNITDI0eGRwT1pFY1M4?=
 =?utf-8?B?dkd2Yy9JNGUwcm9rai9RbFJ2bDJrdUJLNUFsSC94d1JSK3ZHSk01dE91M3ZW?=
 =?utf-8?B?REFyTjQ4UTFjZ25nNytPYUh0amUxS2lXMm93WlJLb2ROWk5PeHpod0Q3NTlN?=
 =?utf-8?B?cGZ3MnJqQ0NFWUFTM0ZacVdDcXdEUjYrOWZ5RS9PVXBUR2xRM0hnanA3UEln?=
 =?utf-8?B?QUNoeC9zZWZ5akxtT0kwUlNWZU12bDVUUkU3b3l6OU55N0NYdGx2RHF5UmNv?=
 =?utf-8?B?bzZXdlRyNkc4dUN3aWh0RmV6SStocnFYdVQydGorRnIvNDdxWTdhN3dENTJn?=
 =?utf-8?B?OXcyaXZDcGdYQ1hid25FOTNJb3VEM01URE1ncjc1cWt1cW5WcFV6aU9DU0l1?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782ee23e-8ed7-433e-af2f-08dcf2084fde
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:41:09.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srV/8tmIBnuzLBk1AJJMMQZ6cv0SZBLPjixLlUsf3I/velBO/kLtEH9R4aK7rhtqxT+WrDwWo+n92DmL2HGFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8019

Few fixes also for the 3.1 series.

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.1.5/xenomai-v3.1.5.tar.bz2

Changes since 3.1.4:

Fabian Scheler (1):
      testsuite/smokey/gdb: Fix race-condition

Jan Kiszka (4):
      copperplate: Address compiler warning in pvheapobj_validate
      analogy: Avoid warnings when CONFIG_XENO_DRIVERS_ANALOGY_DEBUG is off
      lib/cobalt/internal: Fix lock-ups of cobalt_monitor_wait over signals
      config: Bump version number

Richard Weinberger (1):
      cobalt/drvlib: Prefault io memory again

Simon Graber (2):
      doc: Fix typos
      doc: Fix grammar

Jan

-- 
Siemens AG, Technology
Linux Expert Center

