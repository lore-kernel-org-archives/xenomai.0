Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE01F37CE
	for <xenomai@lists.linux.dev>; Thu, 20 Feb 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051374; cv=fail; b=PP0sz+GlrqhT2ZbcQeWaGVOfzU1DNWutx7ODJKpE8YnE7IDKbaqZE+DVbRzU2UlHot+XcRLy9Gvgl4CJIYcXsx0x0uNdqim8MGwzaCPEcS/EHRcilQqPXJ6976BNrEJxgmwtoj1lClM/SrTQx4Ayz4nboEjZMEz9UxTOCIIkC4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051374; c=relaxed/simple;
	bh=PkGOUSSNyu5YRAMAyGIf4Bvz5SCtUakmIow2Z8HFfa8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LQkIzuj+1q9M6d/OVzXGJRub1nlKozqjFtTIUYPZHg7l6e10PxXmKt5PUtQ3/z4HgfLpEGrLzZsYvtvKv0QZZGFOs3t3OoxNb8AC2l/ajg6ePdYab7WAR9a5786WC6GWqqmmLfpgh19tYiI+ltKR65HnnR68rYWXyXXxS6u34sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QdmRo7I/; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QdmRo7I/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvFAKelQSTfWCqXBwpEzxBnLXSImh76rG/2OHvvmeiq5PW6Cwe+29O4fE5izKf4ckghJbnZR6vBXdOKcq+D7huz3UQDbDaJYCI/gNhqLcA+kjXVcuMGg8HWcqQHixEd7VHYoTpr+5/Wk4bZAAyHEtdfK+kS/CVKyKYPK1kPbiUbiyvDhKENkwZsXAB9wRnQfiMfb345/0pATLFzDapwikw3WnqaAXMJq5jh0gHh4nXTqhBI4nb96o7+xVvbQTlikfESqji7+NHbAJwuUbpmkob47Zhx18f8z5IhQJdirYuULLYk0t3EciEQAHb6zWEqPTCVTqFyeKuXJt52rs4DXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np5l7QAHPq5aRCazypwImc6CS6qtQQVdEh3eGCpDCgo=;
 b=zFCUhYxQY6R9yGyZtFiufV+mKbnD3PZoMya1lneE8sVqyiPzM02I1X+f2gNpqLhltTDQ67+8/0tTVn8QGrG7OpKCuh7xAI7AFhRWSXTIHjJW+WTpM8pmy+tlY12HpBNS5DDmIiCo/DAhGOD1AYOgvKiZU4ql+QIsZIDfVW9Fhej2DEdkyLVeZZKVxLfuyyLGabDA7Uz4Zi+xQhjK4mdQ5E3qOO75B1VF6B00U8dqknoR4SFtuRTqvINmS5jYnjC6DQaNCHI2BarsMVQczHT1qMvqqHVSQH9b2uIeF+bx0yBKMhv9NmZKTTbto1sWzVw+6wgEG8gHvkXTn51BLXxz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np5l7QAHPq5aRCazypwImc6CS6qtQQVdEh3eGCpDCgo=;
 b=QdmRo7I/fCHTfab1sURFK3qfWdYajDAgeyK4b5qF5P7MPIFQnZkw3nd6WEBzkyij5OOMg/1tw9Pj9nRGGrgURlZQeYjPLSQU730pDGtq3yvdo76Q/3KhK1Pa2CBR6r0Fh3ytt1i3aKeua/17p5B1+RD32rAQqWocU2f1zKJDuBx24XOfwdDVPGi6sNLNV4N79BPG2T1rwFa6qgj9Gx9wsiMP+Jj5Lbp0pupR+W5i5P5QmwGSwLjqVv9X2/f0CksKaYO7Wi03/K7EUcrDd9stdoWbIh7fnH0ngFF+PrAKGkQidqQGGELFm0zV9lE/PkR+deQ9Soy/C+DlEKl30eYqIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6944.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 11:36:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 11:36:09 +0000
Message-ID: <0bb1b226-2fab-4aa5-b461-dbe7a2dced3c@siemens.com>
Date: Thu, 20 Feb 2025 12:36:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail] arm64: fpsimd: dovetail: Allow preemption of
 in-band fpsimd kernel sections
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: powertree <powertree@163.com>, Philippe Gerum <rpm@xenomai.org>
References: <20250219141759.2455053-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250219141759.2455053-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:610:51::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c8be8b-17d5-404e-3ab9-08dd51a2c505
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OC8yTkU5M1NGeVVWQnN0WEMvVzdDZ25vQjRlc01RRGt0a25wc0hNVEV3STNl?=
 =?utf-8?B?RHR0NUU5TkJtN2dhbGRWRTRxdlBXYStUQWp6a0Jqd1dXc2tpT0RPa2ZhQzBC?=
 =?utf-8?B?eFQwRHEwektPdlZWOFIzWEw3ZFVMNEVsMTBpYkJMRnh4T0pVcWx6aVZXTU9C?=
 =?utf-8?B?VHRkUUpmcWZ6bElDV2NIdWprSDZpMnkvbGFjb1RrajZwSGRITnFQYjZDQ1hJ?=
 =?utf-8?B?a096MTIwY001cU1iYzlxWmNSdlZFUjJIKzZ1UkwrN1J2M1JiMytRV2NyNyt0?=
 =?utf-8?B?V25oT0Z4Z1UyQ0pMemRKUjF2QVdlR20rR1pnck9aTUtUMXRTd1AvNDJPc1Ru?=
 =?utf-8?B?MmU5cE1VejBLQXN2ME9JYjFyMG9JRnRQZkxLYjRqZXlJUENSODd1bUFUYVlL?=
 =?utf-8?B?cUErNTdOTm1VOXhzSkk2emEwaC91eUpQaTlDTHdaU0JxTlRuMlhYK1RnYWI3?=
 =?utf-8?B?NG9QY0JFMVJiYUM3M3VCL3ozYTA3WWpFNEVnNVM4K1phRjYvbUROUVVHL2N1?=
 =?utf-8?B?RDdJMlhGamZtTVdnSUt5RGRqNmcyUnd3UWdudFI1SHJnR1JKRXl2UVhjM29s?=
 =?utf-8?B?NHlKUXBsQzJ5c3p4WEx3TUxtc2xMM3ZNZHVDYVA3cVNLMTNGMWIreitHRHZw?=
 =?utf-8?B?emtmNCtwN2RNVHZKVHlRcHhxcTZSTVdma0NvclRnTGo3L05sMTVYY1R4MEI0?=
 =?utf-8?B?YnpyanR0bU9ONThVbitOcWY0N25GdGJGTUk2WUcyYW5tNVNnWXlJdDZPUDV2?=
 =?utf-8?B?M1MvUm11VUNkZ0RjZDdPZUFXcUNFc0ZkL1pRUGNSSklVbGRXRUhYM3dvQ2cx?=
 =?utf-8?B?NHQwWVhJWFVRTjdkUE9sYmR3TThWZTI2ZGZaeDc2SkpzZzVEU25xbWpuUksr?=
 =?utf-8?B?ci8zYXNRYmhlenk0Y09Vb09tUHhPSXpSQWVrSHhhZUpDcHkvZCtLWFhTV3lP?=
 =?utf-8?B?N2lBeDIvN2xzZEgvRmxiSXNodWNiOHg1blJTVjhxbDZXSEw0N1JWVlVTcXFD?=
 =?utf-8?B?Z1NncTU5K0gvaHBISTNqc09MNkxNUUc0aEhqMnBKWURPNWJBK2syU0xLZVR2?=
 =?utf-8?B?ZzhJQTArRkthQVZUeUJVekgxejNNTjlqdDhQNmwzdGtpcExIMFlyMXFaRGhT?=
 =?utf-8?B?VE1nejZhZjFzS2NCR0Y3cVVqekR1c0I4VDNPNXlBNmdvL2hNL29qWXV4RnRp?=
 =?utf-8?B?cExqSElacGZSQ3N5cFBuVEloekV0c0QxUHdXak9rNGMramIxU1dvTGNBSGVX?=
 =?utf-8?B?L1JLTzM5UHExbXJKZEdvTUE2YW1SdENzUnVSZU1hUnVTRE16NVpxb1NWcHVq?=
 =?utf-8?B?cXY5Si90bzBUWWZQQmJLZTRtY2o2T1ZxdnZuNkF2YnkwU015c0dzaTlWWVky?=
 =?utf-8?B?Q1pDOHRwYXJjb2tlSTRyNWhYUnNqdCt2cGxuOGo4SkpISFVuMmltZ3JDUG1P?=
 =?utf-8?B?d0pHS1QrWDVSaTUyVlZURldtTmhYL1JYRWkwS0ZiT21vNm9WQnc3ZmI3bERa?=
 =?utf-8?B?MnJlbFdnTEMxNnN6N0xXR21zdHJacktKZzhKSGpTSXpsVnVRVFduQ2UwOTUr?=
 =?utf-8?B?N0RBZERnOUM4Vkw0NHZQempsMGxtUEppdkZUbWh5YWFDQ0VsUEI4UGk4ZGYx?=
 =?utf-8?B?M1ZKVjhRMTMzT0dObEdraHJ1Qm1FM1A1Y1FlbjlGcDh3VVlEYWQyNk5PMVh6?=
 =?utf-8?B?WkZEc0VzYUpEdTNhd3pBd3JMbDdXYi81eEVoZXVtUkJXYXF2eisyYjErVk9L?=
 =?utf-8?B?MEJmdkEwaHI4RkNCRkhXaHArdGZjNXNzcDZmdk1sMk9waHQ2ZVNhdk8vcEJs?=
 =?utf-8?B?eXlIVDFvYTdCdHJpQ0hvMzdjUWhRWlJxRlUxSXdXYXg0bmRwY0QyLzdpMTBx?=
 =?utf-8?Q?mT7yX883+XHGc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3Z2bWlLR25CT3FzN2s2L054MjllUXB2TDl6VytNcEFpdVVIWGdTSFdzSE85?=
 =?utf-8?B?THh3dzZxU1p1SzF4UVJtQVZKTHc3eHd3U3hYOW91OFdsVlB5dGEzWmRpelhw?=
 =?utf-8?B?U1d3dnRTblVwZGxjV2xWUjNqZWI3UGtwdTk2ZEVUZkJDdnY0Nm95aU1xZXlT?=
 =?utf-8?B?Rzg0em9ZOUtDcTYzRi9JcmR5WlFZVWFUTmdwUk1wVTFaeDcyS2djWDBHNzJE?=
 =?utf-8?B?ZUg2N3JPMkNXbkVXLzVCTE5vRHZaU1AyVTVXWU1yV2NlZXV0Y280ejcvc1Z0?=
 =?utf-8?B?UGVqQU4xeUd4QTRISWVnMlo3YWcybmE0aXlRSk5aT3Z0QjQyZnlvQ2JVYWVB?=
 =?utf-8?B?S2w5QWloQTZZbkRqbHk1RW10S01ZN21QUzNOQTVrSUlVNHBjMWl5QTFNT3I2?=
 =?utf-8?B?M3dTYTRTaFR6VlZRVS9jRkZsUXI1citwSHlpTkZYeGlYelpEVlpnUVdGUEli?=
 =?utf-8?B?T1FPV08wK3N4STlSMWJzRFYrRS9uOXRLSlRBMjFXUHVrUEJ1QWdtWUp0bGhO?=
 =?utf-8?B?dzNSMjE2VTNRd21rOWtCMFhWa04wNlp3TWlhcDNjUHdSa2dJSGpFZlN2VTVz?=
 =?utf-8?B?YjEwaVh0ODN0Q0NZZi9JaklZNFJvRitiTUw3VVlEM0J1ZVc5NWg5ODRPalRX?=
 =?utf-8?B?c3VJYUI4dk9SNnNkYkxnUzBzcnVXQXNmRnR2b2FWTHRka1JKTGpFcTdHb01R?=
 =?utf-8?B?V3dTamR0TE84Y0RGMlpkK1cwd29lSU1FN1VhRko4MGhRdG1MK09qMDFLNnNR?=
 =?utf-8?B?aXgxRlBKTks0cXB6SDRiVCtqenFGK2YvaXNjS1BLT014SmQ5d0o0TEhCZjI2?=
 =?utf-8?B?WmMvWHF5NjBGZ2U4UUNMbFFpeDZaWnVHYVE5Z1Y4UktFYnoyVVlvdUJQTnN1?=
 =?utf-8?B?SjM2MXFQQnUvNU9VS3pNRG5LVjRydmhRK2J1MzQyZHlIOUxmVDd0T1N0bS9t?=
 =?utf-8?B?cDNZdkUrT1pzSlVwbk0wSktaeTc4eW55VkdSbWJTdEx6QUtVMlFiRE1HRFhF?=
 =?utf-8?B?emVrNDkzZHE1QUlYZElRSkJRS0w2M0hsZ1NhSHJ5ZHdwNTRodGxxVWtneFVB?=
 =?utf-8?B?VnYvK2lBL291TTlsdkZvaFFSV2ZVcXh2K1o4a3B1NnZuUVRVWmxZLzIrTFFX?=
 =?utf-8?B?dUZZSGRWUVl2MnRkL2hoTitRVDlJTTFtSzJBNFNhZk5lK1IwSWw4aU0reUJR?=
 =?utf-8?B?bGF6U3YvNVlsRTk0ckFXLzBXWU10Q1ZCYW1nU2kzdTFMR0piSDVFSXgvZW96?=
 =?utf-8?B?MFowRGRRY3pVWEljc2JtdmZ0K1BJczJ1ZjhNQkdjTGJLRTB6YUkxZHZmVjZi?=
 =?utf-8?B?M3IzT08yWUZLTHljaWdDUXNCUW1laGZib1BpcHpTcmZPWHBzQ0F0UjUzbVA2?=
 =?utf-8?B?Wk85ajRyZUwxWm1vOGgwOXBGL1lIVVdOMytwWnFMR0dFODUvT0I5Q2phSkJS?=
 =?utf-8?B?aklCdTBILytFbGNxd20yUjJsYmw1UTdqMlFrMVBzVWpwdVVWWEJDa2dCcXBa?=
 =?utf-8?B?dTN5NUpYR1B2MEY5NHc5d1J4VmhVUHo4c0xlZzd0SjMrRDlkdUkxZ2VPem92?=
 =?utf-8?B?YjZBT3gwRHlEVFpMdDdvTHd6NTRuSDVRTmlmc0tyaTl6NlFLaTZkTm16Uy9U?=
 =?utf-8?B?MG1HSW53NFBDNjVFRFRxTFg3b0l5VVV6dFlMZHlrSG4yQlBZMnlFdXhkS0Vn?=
 =?utf-8?B?YVd4SjB1SHRKYzBWZU9Wc0tKSXN2cit1YzN0eWFFSHlJMExrZEdBS3JFTUZz?=
 =?utf-8?B?Q0pDM0Jja1dWM1dYc3c4QVRkOVYra2JSbGdBN3lPS0luNGR5czRQQ0ZIUnY4?=
 =?utf-8?B?VHNpSDZHN1NxQ0ZrOHY2ZVRtY2pDeFAxTFBFZzlpTEJRWXh4V1FZdDdxOWh3?=
 =?utf-8?B?dTlTR0RpZDdiayt5dUxXZk5tWElPUVZKcnB2aERCNEJBR2VXaE4xcmFCNG5F?=
 =?utf-8?B?SmlKR1dicHNSNWtQK3ZOZEF6aWE3Y1JYczdjMnF2eEcrZ3o1dFJYLzlncXlr?=
 =?utf-8?B?NisxS0J1NUpPVW1tUTkwdklDQ1BqamtBRkd2SXRCc2hkQ0luZlArcGxHV1Jr?=
 =?utf-8?B?K2R0QUJDNGJMNjlKb3dSZkRSMEhoWUg0RXVXRVpwUzlyV0JsR3RDQjAwVXBQ?=
 =?utf-8?B?ZDdYSi8rUmlJNmJEbzRINExlbmlkazBhZlpjTjF0eldOUG8yUzZXWG5wNXc3?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c8be8b-17d5-404e-3ab9-08dd51a2c505
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:36:09.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m1oPuqw21baMH0O6Ar8kHxXAyeCpl9HwbK465ihbSkhxDRmeZLhf/AnwUww53/BoLGpvC+h2T+UNcHAFMFNpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6944

On 19.02.25 15:17, Florian Bezdeka wrote:
> Preemption of in-band in-kernel fpsimd sections was not allowed /
> properly implemented in Dovetail up to now.
> 
> That piled up again as some crypto code was optimized for arm64 in
> Linux 6.14. A possible call stack that makes clear that the FPU was
> corrupted follows. The inband stage was using crypto/FPU code inside
> the kernel and got interrupted by OOB.
> 
> 	[  331.703695]  task_fpsimd_load+0xd0/0x214 (P)
> 	[  331.703713]  fpsimd_restore_current_state+0x9c/0xb8
> 	[  331.703732]  fpsimd_restore_current_oob+0x1c/0x2c
> 	[  331.703751]  dovetail_context_switch+0x90/0x180
> 	[  331.703769]  pipeline_switch_to+0x10/0x1c
> 	[  331.703792]  ___xnsched_run+0x1bc/0x29c
> 	[  331.703811]  run_oob_call+0x98/0x17c
> 	[  331.703830]  handle_irq_pipelined_finish+0x1e0/0x1ec
> 	[  331.703848]  handle_irq_pipelined+0x58/0x6c
> 	[  331.703865]  call_on_irq_stack+0x24/0x4c
> 	[  331.703884]  do_interrupt_handler+0x150/0x178
> 	[  331.703902]  el1_interrupt+0x44/0x11c
> 	[  331.703921]  el1h_64_irq_handler+0x18/0x24
> 	[  331.703941]  el1h_64_irq+0x6c/0x70                <- oob
> 	[  331.703957]  crc32c_le_arm64_4way+0x4c/0xc0 (P)   <- inband
> 	[  331.703978]  ext4_block_bitmap_csum_set+0x38/0x60
> 	[  331.704002]  ext4_mb_mark_context+0x1b0/0x398
> 	[  331.704025]  ext4_mb_mark_diskspace_used+0xd8/0x1f8
> 
> To fix that we have to hook into the task switch as we do on x86 and
> invoke the FPU (re)store logic.
> 
> Cc: powertree <powertree@163.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Philippe Gerum <rpm@xenomai.org>
> 

Great!

Did you already check how easily it applies to older (but maintained)
dovetail kernels?

Jan

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/include/asm/dovetail.h    | 10 +++++++--
>  arch/arm64/include/asm/fpsimd.h      |  7 +++++-
>  arch/arm64/include/asm/thread_info.h |  1 +
>  arch/arm64/kernel/fpsimd.c           | 33 ++++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dovetail.h b/arch/arm64/include/asm/dovetail.h
> index dc46f131e3eb..8cd359710353 100644
> --- a/arch/arm64/include/asm/dovetail.h
> +++ b/arch/arm64/include/asm/dovetail.h
> @@ -26,11 +26,17 @@ static inline void arch_dovetail_exec_prepare(void)
>  { }
>  
>  static inline void arch_dovetail_switch_prepare(bool leave_inband)
> -{ }
> +{
> +	if (leave_inband)
> +		fpsimd_suspend_inband();
> +}
>  
>  static inline void arch_dovetail_switch_finish(bool enter_inband)
>  {
> -	fpsimd_restore_current_oob();
> +	if (enter_inband)
> +		fpsimd_resume_inband();
> +	else
> +		fpsimd_restore_current_oob();
>  }
>  
>  /*
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 8e12d5be076e..1ba7b75b2277 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -79,10 +79,15 @@ extern void fpsimd_flush_thread(void);
>  extern void fpsimd_signal_preserve_current_state(void);
>  extern void fpsimd_preserve_current_state(void);
>  extern void fpsimd_restore_current_state(void);
> -extern void fpsimd_restore_current_oob(void);
>  extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
>  extern void fpsimd_kvm_prepare(void);
>  
> +#ifdef CONFIG_DOVETAIL
> +extern void fpsimd_restore_current_oob(void);
> +extern void fpsimd_suspend_inband(void);
> +extern void fpsimd_resume_inband(void);
> +#endif
> +
>  struct cpu_fp_state {
>  	struct user_fpsimd_state *st;
>  	void *sve_state;
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 3028a8f294c2..8ee08fd30d8c 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -76,6 +76,7 @@ void arch_setup_new_exec(void);
>  #define TIF_SECCOMP		11	/* syscall secure computing */
>  #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
>  #define TIF_MAYDAY		13	/* Emergency trap pending */
> +#define TIF_KERNEL_FP_PREEMPTED	14	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_FREEZE		19
>  #define TIF_RESTORE_SIGMASK	20
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 96f2f60b4caa..032234593d6e 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -2240,6 +2240,39 @@ void cpu_enable_fpsimd(const struct arm64_cpu_capabilities *__always_unused p)
>  	isb();
>  }
>  
> +#ifdef CONFIG_DOVETAIL
> +
> +/*
> + * Holds the in-kernel fpu state when preempted by a task running on the
> + * out-of-band stage.
> + */
> +static DEFINE_PER_CPU(struct user_fpsimd_state, in_kernel_fpstate);
> +
> +void fpsimd_suspend_inband(void)
> +{
> +	struct user_fpsimd_state *kfpu = this_cpu_ptr(&in_kernel_fpstate);
> +
> +	/*
> +	 * If TIF_KERNEL_FPSTATE is set, we are dealing with the preemption of an
> +	 * inband kernel context currently using the fpu by a thread which resumes
> +	 * on the oob stage.
> +	 */
> +	if (test_thread_flag(TIF_KERNEL_FPSTATE)) {
> +		fpsimd_save_state(kfpu);
> +		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
> +	}
> +}
> +
> +void fpsimd_resume_inband(void)
> +{
> +	struct user_fpsimd_state *kfpu = this_cpu_ptr(&in_kernel_fpstate);
> +
> +	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED))
> +		fpsimd_load_state(kfpu);
> +}
> +
> +#endif
> +
>  /*
>   * FP/SIMD support code initialisation.
>   */


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
