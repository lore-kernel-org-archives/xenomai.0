Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3B205ABA
	for <xenomai@lists.linux.dev>; Mon,  7 Apr 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042163; cv=fail; b=r+E8eijwKpIHgoNXzTW0Ya5sdhl05lOavLnCyU0Nw9NQh07S4oyQWdX478Uq/N2KLgt7knKdgfeSbhLApfCHvCl11oBChhdzvEo+vXTAdfP0JUrSTQSO31ADqKILSH2B7pXxabqaR6MMVMZP1aR7fbIs15s3XIND+V578xsaz1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042163; c=relaxed/simple;
	bh=div8ky/Kyhn54ZZ4S3WsYwEj0g/F8Dks+YBvs0xrwnw=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=SSH3SYo+D8sOCzAPeBvwGnzCAmeAim7qtGsQt8BZVx9ePwAJxAtZX/UqF5OCo+UUWGz8q5L2D7euvF0Bu3IvElZb/3BJten8OwjUtpAfY3zdnu8ifYkRH96MtpB6zbGriiRVyXpv+R8MPA/7lqse26CXVx52e5UyqwxScRbiQ5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dac0F+eH; arc=fail smtp.client-ip=40.107.247.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dac0F+eH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjNUk+d1rbzaFv9qBF2qMvb/QcWRfjInUR7NLpHaUGktZyRJHSzOpb49KVPD+GH1RBGZPgIZnB5oPoHFYFzYGVqR1x6hJoHbkcjiWjeZPXrVNQoj0oIjqVSHGVdOcmwegqkox0blsLZ5g1ukDBpFaaP48/nxJgaZySH/in1NrDzNyuC1hxyJvUmjjGNz0Av5BTeDFNDLm0BWi1eKiklcX0PNlztA4zOEyoG++fzEpYjdl5sKb7kym8h1VTBxvBXfEcEj5wp4Yfl2tRqgAOFHVdOdc1KSsF6/OHg+SzFhsO6ianWlPkiPj4eIZy0uAnXDkpjuk3noLxa1VDLykFX+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSWUgDEGXNxFanY526527Y6CdI9oWOxwrmuk+L/LOZM=;
 b=ah2xuK4qZeIpHa/NmCfwfq0J4xgZcRSsc53ZJBPl/NgmUtrnVgAI16hBQ0K2XvvMpXGBbBfyvRCn91O6Cl4JZc1yOnNAS+/uB3GrHh5bUXihKSmDyjUEykq9P1hOuiSPf374DN8dAthvBd9/ecruyjop7kIeQfymPfPSiI9Hv48csCaR1OYPS+7a7RjarGgFOdMbRUMK52bVIg7owimB/pUhQS4VkSvMSrTWMgPSBnLGI0fgSDKa0Vy26FOaAC4e1/+DOcZK3Qo4jazZhhImvRjUBRtWGaW1cTTbZ9CcBlFTSdAElxjZFVDBFS/wGSdy03iJ80iay20HKfuvpGUweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSWUgDEGXNxFanY526527Y6CdI9oWOxwrmuk+L/LOZM=;
 b=dac0F+eHBja0tYwSkLKUBjhuYCumbx/xW3lmF1AZL4urm2CTNqnwTNnKzEhUkH7tt6WAhPa3/VutUZpNOyt0fCtNdtFF2EGW359vBWP1zjok8GDZApBCRbOEHtn8T8sfBT1ytPMdHviHGh5T+ksOc6b59hosykAPknTxhMuZRnjNxwkbdwLd2bvvj8dgGk4lAFWxy40Gj4rdfXZWxd99IrdZwyR22eicZnfDRRWSTUKl1dB6dl1kyluaqybSWJV6X8Xd/N89XsHAS8Qva4tMNw9k05rOCr+aV/GdCZAECey/ch5LiOyLB7N0YgaqUTjVcZlpCxJIzIdeWsDaztXfag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6612.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 16:09:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 16:09:16 +0000
Message-ID: <e13c08bc-b369-41d6-be0a-dcc75aa2b506@siemens.com>
Date: Mon, 7 Apr 2025 18:09:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] kernel/cobalt: Drop XENO_OPT_SHIRQ config option
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6322ea-9f7d-4e06-aa14-08dd75ee8b89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEVIWGpVN0lxN0VYbzU3a2Q4Z1pOQXVyNHJ5RmxmU1pNVVlCeDhhMnRSVXR1?=
 =?utf-8?B?bkZ4TWNJUmszMm5vZEZUMTV3ZFRwQjAyN0pCL3A1Q3pvM3JZWVpISTNGQVI0?=
 =?utf-8?B?aTdDcXNzVlR6dWl5Q3hVdmVUTVRWejhFSTMvTDZaSWtSTjlLZ3VtN1UvQVRn?=
 =?utf-8?B?cnQ1eitTajVJdzVON1d5RmlWYWQxV1pyK3dhd1dQN1JwemEvOEVaZ3hUODh1?=
 =?utf-8?B?NWVVbHBOUjBGeTdaUXE2SzN0dnI0ZXdpZG1mQW9EN3lqQkk0R0tkdHljbXRm?=
 =?utf-8?B?L3BUbC9EaHFEQ1hHdnZ4S1pETGJqM1pNc0NJRUVuT2VlWGk5OUVKMUNSMVBa?=
 =?utf-8?B?dDU0cytFbjE2Tjhpa1QrY3RMZnN5VHlJYnhvcXpvK2Q5VlZ5VXZKdWNEdUpG?=
 =?utf-8?B?THAyYnlDV2gvQUhHZVZzWEN0eTVsMC9nZHdxeHlwNEZ6a05yeXdJM2xUQ1hy?=
 =?utf-8?B?MmpxUTAyZ2lVVmZQR2QzV0xCcUlwYS9LYkN5eHkwVWlqajlxemdkRkdrQ2Vn?=
 =?utf-8?B?blhZbVR1L0E5cnFEWmJOdm96UGFhT0s2ZmFwSXR2bGwrZVN6NThzQ1p3ZmpZ?=
 =?utf-8?B?QmNiSXJoZGdnOEFNNnM2YlBaaGFFU25Cck5YOXhFT1duSlhLZ0lGSTlnUDJQ?=
 =?utf-8?B?VkM5T0xOSEpEdmRTWmM3aGJ2dFRxUUxsdEU1ZHZjQkhzMEN1Slg3Q2JoQU9U?=
 =?utf-8?B?NGNKRTk1WGtKc1VsVGxXR1lMeWlseklxakcvdW1nTjBvL0F5TSt6T3E5QlZX?=
 =?utf-8?B?N3FseU92dlF2a1BaR1BYYTlScnRnUi8zYWwyNTRRN1lndjkxTE1xVmtOT1R0?=
 =?utf-8?B?RGVmSytMdWJPdng2MEppd09ON1Yvc21VNStucm5CQkhyZGxrR3NSZ2dEdmp6?=
 =?utf-8?B?M2czZTNoRFgxMnZnaXRTWEVCU041Uk1idzNFbkZiNks4VWpnTHh1NlcrdTht?=
 =?utf-8?B?WGJGclNpdG9uQ3NUTU9aeTVwSDl1bTE2cXJHUWJyOE1sMVNNWmJsbEpmZkpz?=
 =?utf-8?B?MWlsZHR3eEJhVGRXSEhhakQybzBRTDNhc3lZd0tBaUY1dnFsN2xBZ20xOFlX?=
 =?utf-8?B?dkRra1ZZMms3UFpISE1yUFZib2YvVnVweStkY0VuaXVqRWhuUUpnajd2Zlg1?=
 =?utf-8?B?UHlPL0oyY1ZUaGhrN2hiVmtOT3FhY1Y2ZXBKWlV0SURoRHNyK0RMNUlRZHdn?=
 =?utf-8?B?NVJCM2l2Vjc3c1owTkhrN1B1Z1U4N2dNM2FSZHBLNTcxeDRoeTNJdUFDRmhI?=
 =?utf-8?B?N0tzRm5IRHc1ODdqS2dyR0lmTDlna2ZQUko4d0RoSUdGbWpLeGtSUkJUMXlo?=
 =?utf-8?B?bU1tZE9WS25kQVFMbzhqS2g3anZkZ0FJQnhIM0MvYjVnL0xOT2NRY1NuTWVV?=
 =?utf-8?B?QWZRT1AyZmpBWkR5WUo0bWJNMkw1YlVDQ3VLNTZQRVFtMm5vUU1rWWNPbEh1?=
 =?utf-8?B?Y2hUalBsOW5NeGlqbyt4bXhiNlMzR0N4a1FicHJHSHE1WHhVWE5OVVFoUEFY?=
 =?utf-8?B?NG9HTVRhSXFybkhDOHR0Vmk2VzdiNFZLZTdQZkVlZnY0dUlobG01NS90TTZj?=
 =?utf-8?B?VEx0U3dKN2JLOGx5SE8vMWJ1SmxXdXdhck1OVnpOZjJ5RGZBbStxRW5LL0xi?=
 =?utf-8?B?dzUzNUxPd2FUUmo2cm5xWVJyanhlYVRJdysvdmkyK3p6Rm1ZdURFNytCUGFL?=
 =?utf-8?B?K1BNSWw4MVpVQWRTcGZVY0Uxak1PMFlvQzF6RzA2OHFGRW15Y3JVdFc5SThj?=
 =?utf-8?B?azE5R3dDUzd3OFV3VFlhTXQzb3ZpK0c4RkYvbFI3MWg0V3J6WDM2bUlkQkgx?=
 =?utf-8?B?bEdvQndQejZLWWJaVU5oT0FEOXViQXNaaFh6bndxbURXSUtxWmtxOHRFQlN3?=
 =?utf-8?Q?TsaIFJ9UgM7DS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGVxSGNtd1R6ZkNER1hSbC9iNlAzcitTMjBQaEIvcEtjRGg2bktFVDhHZnQ1?=
 =?utf-8?B?UGpaNlpQbjZhSUxzUTZMcjF0aGlkRzRvaFpTRzhweDVhaFR5S2tPMXdHWmZU?=
 =?utf-8?B?cW82cndYV1JVZ2Y1N3lDakZBN1ZEQlpUWWNudFEvTzJFVytVZ0RzdUFKdFZU?=
 =?utf-8?B?RUcyOU9sanNJQTFvekpPbzAyc0pMdWViTnVmZnQxQTBWeEhnZVlVMklMd3Fn?=
 =?utf-8?B?TXVHK1d0bm8vN2ZNRHJmV09GaTJBR2RrLzEvR1pjWG1RM1RjNThwd0xTYWNJ?=
 =?utf-8?B?MHI3d0pUeGdSMFhBYXZLS1hvYlJFVmdmdXZDZEd3UTB1SGFtRUpobDdTa21F?=
 =?utf-8?B?QmpFRThFSnBST3lCeUZQNHduRFRTSHlvbkRqV3JxT1Zmd1gvZEhCeUZ6UnhE?=
 =?utf-8?B?aDZQQzgvYUczUXJnZjVJcEwrMHNBc1JkRGZ3Z0NkWmlhai9SQXBhbldVVWhY?=
 =?utf-8?B?U1RlS1c0cWdBZzVud0FSMnY1bS9zekZTSEthVXMwcTk0OU1DT1VUY08zV1pD?=
 =?utf-8?B?WEIzdGFraFNUNTlRYjNsOTRnbUxNNmpxalQvb3BVcUlhbGJlYlF6MW5SelZO?=
 =?utf-8?B?ZHlIblUzMmpGYUM5NnlCa1l3cEw1M0oyWDQvQTYzaHY2bVl4elQ5V3FXZHFK?=
 =?utf-8?B?cWYrN05QTCt6S2RudGdaWWptdHlEcExFSzVUMDdPMTV6ZXRtUjArTnBxZnJ5?=
 =?utf-8?B?YUNXNGlhQW9lcXU0QlQyaHNPRHc1T2h2bVh1a01WN1BwSXZKb3l5bHhYb1BY?=
 =?utf-8?B?bnd2NG9qOTRLcjQ4OFo0bENYNnp0a0JsQ285MUgvcVREdjRVaUE0TnZhRFZj?=
 =?utf-8?B?ako0Y2NYbHArRW12SmtnQStzNWxQOE8wWTlYd3dPR1huYlRDRE5EVXRYOW0x?=
 =?utf-8?B?MTRKL3drdkp4RUJvOUZRRWRCbUtOL2xRamFoeU9BSmcvODhxZHZuZEM1U1h1?=
 =?utf-8?B?MndUdDI1UFByWTg2c0c4R2MvNmh3NlRZRjN2VW50ZU81UkR5TE16NlZSSW9I?=
 =?utf-8?B?ZGVXN1k1d0RZZENVYjl5RGF6V292enlGVWxrVnlvUW5URGRyNStTVGJMZXJi?=
 =?utf-8?B?RDArV3NpNllzNEh6cWNHRDNNTlNHQllPTkxmdkh6blMvN2RyR1JUeHR0UDg1?=
 =?utf-8?B?Q2ZYSzB3b0gyd2hneGVsNitHcU1LL0F0Yk9QTFZlQm9OQ01RZ21Od0kwQnB2?=
 =?utf-8?B?WEw4Qkx4VWxROXVXcE1SRFZZME44TnVNeTVGemdNYUJ1NnJGOC81bEhKNGQw?=
 =?utf-8?B?S3hpa0g3aTh6SXYwR3VwQUZkSHJwaTFMbTlPZkpxcm9HMkdvWGhWVzFIV3hl?=
 =?utf-8?B?aE5FY3JOTERLWk5tUFZpdlRsU3cyUExxbkVOSFBLcEczeUQ2Mm5reXRHWXBr?=
 =?utf-8?B?QWJlY1pWak43ZXA0ZUFOMk1DNWNSdnc2YzdaSTlDZ203QW5adWxGa1NsOGc2?=
 =?utf-8?B?cm5uci82Z2ZuV0FsS1o0ME8vK2dNSjNOYmVPeHZNQjVDbHhVM1RBWHJGdHhq?=
 =?utf-8?B?MDIreENtbG1UdVFPcXUyWDdhSGxTbm5iZ2FPQVBKUS9GT2dXYkVNUW1pYzV2?=
 =?utf-8?B?b0UzSGNrVVI3NzJtQ0tDN1BkTHNZRnFrN2lFK29IMzhnUlRkKzdsQzFaRktZ?=
 =?utf-8?B?MFhQcEcrbWtSQ20wMk5RbDlZaVMwSVRVNy9idGVqa1ByNDhmR2IzNm4rVjNU?=
 =?utf-8?B?MXNRVldHL04rYmNpcGxZOGxLNE4vNitvMTU3ODVxb2VsSmhnTnRFNzdCWWk5?=
 =?utf-8?B?eCs5cjZibGEwMGd1LzlidmJxZUpCSzArbjN1ODA2K0FiNHV4SVlnWWt2MzBm?=
 =?utf-8?B?aUpyN3RzZmdYZnZRZy80dWI1OWVCN0NVOThjKzdDeWUyWW9JQUcvZVNPYTNN?=
 =?utf-8?B?bWhoQ3V5Z1FGL0ZlZFpMelc5aE1NL3NNeThLeXdBVGtMOUpBdTFmcXZRakpO?=
 =?utf-8?B?cFpFWGFoQXcrZ3F0TzdDYmFDb1pNUjZaZkczNEFKWUdmelpsb3VsNTRybzd6?=
 =?utf-8?B?Y0RHcTIrcjZJM3kzMjVzaEZPMlBBajh5MVFRZGd3UDk2TmdaM1hpRmlHaDVL?=
 =?utf-8?B?N0pPVTBXRXJReHltVmdSaGFoZUwxcElTMCt0MzBiMHNucVhRcXVxeDVGZ3RP?=
 =?utf-8?B?YnBITmRLMkczaHcySTh0ZUhoNHpBSnJqZGNQVlV5RjVpZVFROStTNlZJam41?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6322ea-9f7d-4e06-aa14-08dd75ee8b89
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:09:16.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RP7MNG529H8k9DYnFV8tyMKKOmOIKAYdNw4lQrqKjKffLynfTA51U7hCZCm7qdMKeqRlg+HNmtYFbEHnw6Lkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6612

From: Jan Kiszka <jan.kiszka@siemens.com>

With dovetail, this is now always available.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                                    | 1 -
 include/cobalt/kernel/intr.h                      | 4 ----
 kernel/cobalt/Kconfig                             | 8 --------
 kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c | 5 -----
 4 files changed, 18 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ad6f37d1c1..39af030691 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -84,7 +84,6 @@ variables:
     - ./scripts/config -e XENO_OPT_SCHED_TP
     - ./scripts/config -e XENO_OPT_SCHED_SPORADIC
     - ./scripts/config -e XENO_OPT_SCHED_QUOTA
-    - ./scripts/config -e XENO_OPT_SHIRQ
     - ./scripts/config -e XENO_OPT_SCALABLE_SCHED
     - ./scripts/config -e XENO_OPT_DEBUG
     - ./scripts/config -e XENO_OPT_DEBUG_COBALT
diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index 060edc8a57..b52fd5fba7 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -62,10 +62,6 @@ struct xnirqstat {
 };
 
 struct xnintr {
-#ifdef CONFIG_XENO_OPT_SHIRQ
-	/** Next object in the IRQ-sharing chain. */
-	struct xnintr *next;
-#endif
 	/** Number of consequent unhandled interrupts */
 	unsigned int unhandled;
 	/** Interrupt service routine. */
diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index 06566695d7..4b61b2f591 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -135,14 +135,6 @@ config XENO_OPT_STATS
 	  per-thread runtime statistics, which are accessible through
 	  the /proc/xenomai/sched/stat interface.
 
-config XENO_OPT_SHIRQ
-	bool "Shared interrupts"
-	help
-	  Enables support for both level- and edge-triggered shared
-	  interrupts, so that multiple real-time interrupt handlers
-	  are allowed to control dedicated hardware devices which are
-	  configured to share the same interrupt line.
-
 config XENO_OPT_RR_QUANTUM
 	int "Round-robin quantum (us)"
 	default 1000
diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c b/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
index 921182fab1..22fda52845 100644
--- a/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
@@ -242,13 +242,8 @@ MODULE_PARM_DESC(irqtl,
 
 #ifdef PCIEFD_USES_MSI
 
-#ifdef CONFIG_XENO_OPT_SHIRQ
-/* default behaviour: run as mainline driver in INTx mode */
-#define PCIEFD_USEMSI_DEFAULT	0
-#else
 /* default behaviour: run in MSI mode (one IRQ per channel) */
 #define PCIEFD_USEMSI_DEFAULT	1
-#endif
 
 static uint usemsi = PCIEFD_USEMSI_DEFAULT;
 module_param(usemsi, uint, 0644);
-- 
2.43.0
