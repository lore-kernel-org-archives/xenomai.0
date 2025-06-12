Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD82F4328
	for <xenomai@lists.linux.dev>; Thu, 12 Jun 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746406; cv=fail; b=hwLJsIf3m51PaclJYj+FNBLqClzuLLgVigBXxEuQ2JapBGfgPDaWwJj++SADVncDWaxAamnSP6r6WAQ3vIPnC2AR+eA0vIIA2MdNamHldRgaK2T0hRhgALmtx/OxQoUECkXCN37ZL5Gy11UFy38YPvZEn24uRDE7jJXFi/qxPyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746406; c=relaxed/simple;
	bh=ORiNrMW5Ksfm8oLHfymSp+o1QnqrRzDiOEn8C2Acy8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOC7+MxvDplGjqmhYFhSoUo1io6zy6kMSoZE1AaErJA9c3z+DPbeQPrVBJYe6dCeSsPSab80HjIFIRWM6XO3OQzjI7Nk0QjSuEOsuFVXarEF7eIF1h4bvci5AVy1uFMj3LriiKQ8R93q3shgm7Z6A0X2g7GtICoG+0eZYGOR15Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OOFnUcc0; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OOFnUcc0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCAXXhPY3qO3lV68/oZQSjQ6qLfOiOKyfxGaNLo+pz8VPW7twgpRCMJZahL6p0AlgJNhQ1IAgbBtHUgCD/hKjuLKWQ7g3Wq3Az0aYDeK0zKg9uDq4G5fxES8DVeY5zhp3824SqR7Xvf3rvWq4qPPtiCBcYRQc/yMVIfIIYGikdrW35bKCHYzOa2bCgbqtmQm2ccEcpQ35lb8k1H7o2/aeFTAk4uzZIF4168OFc9jCBcp1TVzxtSvzNNFoC8V8Q4pWPSZJ3WHSPxedo6SHzGl18LcnP/lm30uioFMLwN0fGRxoXG+L6gftfNf6XfRtaZ0ZOI0ar4RtZjlMP805oiBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxSa9ULI1qXklLSVcaqZX3delUcEbxp6H9xDUSTAto0=;
 b=njCIwh0lLEmh90IDaZPBKdVQtnfPTLVSdnNZBnb7dhCzWwaPrXjlhixdvg7UfFpbbU2mCGPiNZMDtj99lLbWnV0l1S1lxI2bmtzTJID79UnpGFjABjuuqm/FxluFBlWTKMMSIn+PEvkawgYUEse8RUVvv8CHq0neHwpGqr0yeGxLeZx9U9xDIrEPHctRZSAB1mCsTSj5OJm7PWy8hBEw6CxRytUF/g5XC7ii+cxZWfK0NisPHD7UtalyWJqYO6qp0oVJyn5n8l6LeWPli2TsKKmp6QmWDj+r0bPS96flPSNgvEWHuQQvsZWpkEoqjuhERy3q6IQg1lk6Qc9CHszvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxSa9ULI1qXklLSVcaqZX3delUcEbxp6H9xDUSTAto0=;
 b=OOFnUcc0Xf2fEQ1iKPaE5sdRo4g3v9IB/VTiKEz+WDojfTDjDJneSYnhBDzMgQkAXmSQlkUhMB2KSTxblsvrBtFukOAGX4PVZy1c9TmjJ9/0zxXpskXdHNgPyjzJtGdx1/tpj0tPQ4fUgr/jWTN9mNUCxauzErziRo4bI+xn1YUuEA8RtF1fg5FSTicRLfBjEx+S8/3g/+ZWExw32/BW0QhIG9SsP5YBNjogaYkBc/HKV4MVkXWZcfjPoidOuG5uFD02KrnO3p1zSzG2ng4I3ImTluHS/jdqmItKdX5sItjjYyjM7rDmZm7PR4NVqMeSDSrfJHZBSOQpHpZSzXEY/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3204.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 16:40:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:40:01 +0000
Message-ID: <551fda23-ea8c-4f6e-893c-2268158c7118@siemens.com>
Date: Thu, 12 Jun 2025 18:39:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 6.1-cip] igb: add missing header for oob
 extensions
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
 <847f6d81-cf28-4155-b969-aeebb76e03c8@siemens.com>
 <87qzzpuh8p.fsf@xenomai.org>
 <edede9ec-0b4a-40b1-8a7e-0784db1d9a43@siemens.com>
 <87frg4vrv4.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87frg4vrv4.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3204:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ed0804-bd01-4e4b-956f-08dda9cfc6e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW94ekFQK1duMjdqV2hGRTUzTVBvY2xxcTBKSWVvcnRtNXZuN3VsN1NWK3c5?=
 =?utf-8?B?NlJZNFdTTkpVNVJFUjlnWWQyS0x2clFTOUVHRzNWb1ZTZ3VNRkxTbURTZHY1?=
 =?utf-8?B?OUdPbUF1dGs0eWpyZnZURll4MGgyM0VjV3RXWGg5M0p0TlVobzNWVFZPQkJM?=
 =?utf-8?B?SUlkZ0ZRR3Njb0pQeHUzSHVBS2RCSjdGY3NTQ1hXSHlDTzQ4RUp4N3YwTFd6?=
 =?utf-8?B?cGpuTE1WbGU3bVdoZEZjZENrN2w5WU5MN1ZtcC9oSVp0NkxWYlZXUFU2ekY1?=
 =?utf-8?B?QVdDdEJuekdlMUQzcnljMnlMYzFobTgxbkkwTkFMQU84b1crbzZMOHpBalVp?=
 =?utf-8?B?MGkzblJvVCsxUmZPZ24wV3hjUk1qYXRST3hjWDY2cVdMNHBoMWlzYWVmaEd5?=
 =?utf-8?B?cnJ6cVg5L3JhVEVJNG9MMHE5MkI5cVBNcmVHWS9QNjZPbytEdDZVeVhtUHBB?=
 =?utf-8?B?NnBIMjNDalhmaVZyNzNRT3cvSnBnQ3JqR2ovc20rekp3SmZIaWFrSlo5aXJH?=
 =?utf-8?B?d2NxVlppbjJrS1czRmFZNmF2OWNZVk1raFI2UnQ5bzdHbTdqSTNabFJCdnYz?=
 =?utf-8?B?UGtLNTVURENyTDVwU04xOHpNMW1mOG1BY1R6eHE5bmUrY1NKQ1E2TDJXMG0w?=
 =?utf-8?B?VW16U2hqR1Rnbm5IN3JhWHg3UjVZaDhwb0V5SmxHVktnRWIvR296a1ErLy9u?=
 =?utf-8?B?dk1CcEsvaWNlRjM2bnYrUjl1VGQ2NHI0SDQ3LytLNTRGT1JkMFlPT2NsblVT?=
 =?utf-8?B?ZXNXL1Nyd3dZK3J3SndGM0JMdzV4bk1pMjFvRGdOczltSFR6ODNtSkgyYUF1?=
 =?utf-8?B?WitaTmYvWHl1Zk1TRGpDekJIelNsbVhzaC9DUXhsVFZOU0RIUWdHZm5QVjhM?=
 =?utf-8?B?ZCtHV0pJZzZPaW1KeG43Uk5udXRvam1zbWE0cllWNkR1dWpVZ1loc2VwaTM2?=
 =?utf-8?B?UDgrRk5NSkpRU055N09Ca01iU3lMNkNKSWZaNXBuT29wYm03a1V6cGlXdmNu?=
 =?utf-8?B?S0pPTHBTQUIyU1Jod1lsREZTTXpvVjBJaG9YOFN3YkE4RHBKMWF0Q0VxcWov?=
 =?utf-8?B?QXdDNGIwVGRCUVlGaGdXenNGWE14Z282RGwvVGlaaDVoeGlRVU5MTnBGOTIw?=
 =?utf-8?B?L0VvVHJ5M21UbWVoTE92RlBzN1lrbkFNWVB3NkhoMUNPMHRwMWZVQnhoNkJ6?=
 =?utf-8?B?UXpNanh3RElJdlZRL2ZFK25IcnA2dDkrS0J1Z0t6ckR0c0o5akdyc3pLNS8x?=
 =?utf-8?B?TzVLM0JYb09oM1V0SG9UUjJvY3VIVllaK0hTQzVkMlNsa2t4VldkWENqb3Uz?=
 =?utf-8?B?R0syWWRGQXcvUWJSdDg4aElkb1JERFhpKzUrdkxXQkZCVW5sclhnVVAyanhz?=
 =?utf-8?B?cXVMdFJJVFg1RTNUNEpZZkxOcnZ3Slh2ZWdHRS9MMjdBeDd3VkI4UituSE90?=
 =?utf-8?B?ZXNWTktkR2c0RWVXNTJlVXEreGxISytDK0h3MURnYm4wdTBXQ2hEcXFkb1VY?=
 =?utf-8?B?WkphQ2QxRGo5MTBRVklqZG56QWdHM3RzeWdIZUVxQXpnR0ZKUXNZbktLNFNn?=
 =?utf-8?B?enVwcEY1enVveVZJV1N0elgyU0JsUW5sU0psUWpPVnNYZmlLL0RPdEdMTzhy?=
 =?utf-8?B?R0FyRVZpMGpaeW5MMHdmc1duSjRpcjg1Nm1OUThyeUhHTDJGSzdONnE1Nk81?=
 =?utf-8?B?WENpMnlINUlNb1FHUis5RjY0NXJBY3lNVVpRWVlDNUZQTUx3RWNDT3MvNGpw?=
 =?utf-8?B?SzFSMnE4ejhzYTN0VHBYaC9SUGVBdi9tVzdOM2xhWDZydWZkVUJ6VkU2dEF4?=
 =?utf-8?Q?dARZXWBbmh+sYETSbBVp3VjPw4rfZaSAOYRL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUhOY2VadEkwRkZmMElRaDVrYjBXZDVEWnE1bThNRExpVWx5S2RqN3FhVllL?=
 =?utf-8?B?MnJSbXIxalFlR2hwS3JPK3hnY2VFNE9qRUJubDdIYUUzMmNNWE00QWhzRm8x?=
 =?utf-8?B?RzVhMVZVOXNYY3NiRTBqMFNJdFNQcXJBcm9zK2lIa0dyeTQ5L1FYZExCREdY?=
 =?utf-8?B?VVFjVHpqMTc1RDhxckVCUVR1ZUxuZDJaeDlOR0RiZzFPc2QzdFcya2ZqYUdv?=
 =?utf-8?B?d25iMDkzeEI5NjhhTkdaZ0lVMDZNQW9PWDkzZnM2V29wLzl1QmFsUmdURmV6?=
 =?utf-8?B?ZGhkT013QWVUOFREZmdPeGRIc0lCSUlJVVkzQXJaY1BMTUorSG1YN0kxNDU2?=
 =?utf-8?B?OUkwVmh4bFdCTUEvOExkcnh0bzFlS1pVWGdUYnFmMWR0MDgvV2ljNHJodHY5?=
 =?utf-8?B?NTVjL3piQkIrZEF4VWJsU3JQQ1QyaEl6N3pWbGh0QkRRcjhaV1dSbGc2bnF2?=
 =?utf-8?B?cDMvbFdHSlJEQUdpZU5NVEVTeVNMZ2RxWnJra0FTY3VMNm9BKzR2bGpWQTQ3?=
 =?utf-8?B?b0I1OVRCeXZ2NDMvQWJDQjhRUGdzN3lCaUs5ZU9zTUtMTEFmRjBJVWVON001?=
 =?utf-8?B?VzE2RnRMNndETzQ4MVBJUitzUXZ2d3g1SjNqWkQzUnp1ZlRDdVcvNWtvRkdu?=
 =?utf-8?B?RTNBNmRyQkVyMDJuZWZ3TE4rWlpmem53OEY3N0R5Sm5NQXdaM0lxVWtOZkF2?=
 =?utf-8?B?aXpwZTRvZzJvOGpYcE1WMDI0Q2h3OWs5bWt5bmF1ZXJJRlVLem8zK0NqdDhY?=
 =?utf-8?B?bXBPZGFFeG5IZm5yU1MyU0FtTmFBVlk0RjNxWTZrY0xLZ2owT3ZaRW5zN1FP?=
 =?utf-8?B?bkhFZndLdE44R0IrK2ZjRmxScHFRa25TakdTOGJCbGk1TjV0Mk1TdXJkcHRk?=
 =?utf-8?B?a1NyakhpeHlJRVd1cHdqVEZMc0NkdEtnZFlpaVkwQ2pWTzdhNHdCVW05b1Fp?=
 =?utf-8?B?ZCtRTVJYYkwrN3pjMllXQnVEa3hIelhtUGVtYXNmMThpcHczbHI2TEVaVlFi?=
 =?utf-8?B?dGlhOUVoUE5KS2JqS2RKemNzd2N3TmdrWG9PcUxIdkRKelRDYzBUbmM4TDUx?=
 =?utf-8?B?Wi80Nk9WbFJiZk4zYi94VC9mRkMzM3E5ZFBLZVV2ZEZVMGlLRFQ3QmFiQ1VN?=
 =?utf-8?B?d3JVTVA5UE1HSXhYQTNldUxjTTBkMUZMcFJjR2d2MlRjemlKNkxqSFg5MHNa?=
 =?utf-8?B?b1VCaGM2R2Nyc2Y4STcxUEhkMVlSQXIvbXFDdC82VytwOWdLWklZaDdPUGFL?=
 =?utf-8?B?Z0pMY1pHQzB4dGFPemFlZlA1Y05KdTc2U1hFZUl4MS9YVmQrNHVkQ0ZhODlQ?=
 =?utf-8?B?cWZsYmtVMlBhVnJESVljdm1TS0JGaW1jd1Vrdk5MaTdNVURvbGE0cithTUJs?=
 =?utf-8?B?RmU2cUdTUm9FUmdON0hhOW9vZUFxYkpMUng1bFBvaWNwZWM1SzJJRzJ2bEk1?=
 =?utf-8?B?d3pTRUNaR0FqMHdib3htTkEzQkpEVS9EbVFOMSswYWpYSEF6bW1ZWU1xVW5l?=
 =?utf-8?B?Q2hiQTdGVitseHpKdGRGMUFaSS9zT21mN2gya0g5SVNUNjRmRkJlUHhwR1RO?=
 =?utf-8?B?Zkhhek9kNUtab0NYVTk0cnB6TXZTYWg0WEw4eXhveEJ6emtPR3E3UklRRGwz?=
 =?utf-8?B?T0FTUTlCcmJhcmlPY2d0T3R2djl4ejlUdVQ5MzMvdnpyU3pRQzBNOEF6aU9P?=
 =?utf-8?B?SU5maUVsWHJhZHJlcVR6dkJ5VnJwenE4UEQ0ZkdkOWJBcEhhUDZnbmxhWEFq?=
 =?utf-8?B?Tk1PV2dOOVFPVDNSN3UxblBvQURCeXdSeFRxMVl0elpaOStObE9kRkFwYUZh?=
 =?utf-8?B?TlJkK1RXdTJjYUlKVGRFVVNTTFljNHN5SXQ5and6cm5QWVZsVTUxWnhZVkNY?=
 =?utf-8?B?SC9ST2xRTTVvK0RmQUFZeUtVb2xBL2EweEdWZ3dPcXBuYVhjUTRnRC94UlMz?=
 =?utf-8?B?WFV0M01ieDgwekxJYlI2a1NQVU5kZTlzd1ppVnN6QmVwcnBLME9ub0NzU3NB?=
 =?utf-8?B?T01NWW05blhlSjU4V0tyRjk1djFQNC9ZY2RLQjd2cWpDVEZnU3pKRENaVVBz?=
 =?utf-8?B?MU53VDBXbmxXU3Z5dlVQdkZldUVWMWswN0twWWFWYVpadVJ6enp5dkpFV2JL?=
 =?utf-8?B?eHVHRTh1cE9XbEFpMVMxK3lBNlJ4MTlwS3hpWTFPV3k3YnZ3S2dsWCtEenhs?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ed0804-bd01-4e4b-956f-08dda9cfc6e7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:40:01.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgKVN1vV+JxwdBV0ys3dUJLM01bukpxVqpuRXOFbmlw4KoEvBCK0fE8OsF8ymVbQFgU4b0vUXzN7wNO7/Rmq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3204

On 12.06.25 18:37, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 12.06.25 17:11, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 11.06.25 18:20, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>
>>>>> Not yet tested, but this should make our pipeline green again:
>>>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309
>>>>>
>>>>>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>>>> index c0932a3cb220f..26be743f2a6cf 100644
>>>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>>>> @@ -12,6 +12,7 @@
>>>>>  #include <linux/pagemap.h>
>>>>>  #include <linux/netdevice.h>
>>>>>  #include <linux/ipv6.h>
>>>>> +#include <linux/skbuff.h>
>>>>>  #include <linux/slab.h>
>>>>>  #include <net/checksum.h>
>>>>>  #include <net/ip6_checksum.h>
>>>>
>>>> Sorry, this was wrong, at least insufficient:
>>>>
>>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1167536
>>>>
>>>> Seems there is no way around reproducing locally. Will keep you informed.
>>>>
>>>> Jan
>>>
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>> index 26be743f2a6cf..67920a8a66733 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>> @@ -8910,8 +8910,10 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
>>>  	if (unlikely(!skb))
>>>  		return NULL;
>>>  
>>> +#ifdef CONFIG_IGB_OOB
>>>  	if (igb_is_oob_page(rx_ring, rx_buffer->page))
>>>  		skb_mark_for_recycle(skb);
>>> +#endif
>>>  
>>>  	/* update pointers within the skb to store the data */
>>>  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>>
>> Yeah, that looks better - we are not enabling OOB networking in Xenomai 3.
>>
>> Jan
> 
> This is related to the page pool support, not used by the upstream IGB
> driver which manages packet memory somewhat manually. That support has
> gained an oob extension NET_OOB wants, so that we can keep most of the
> original memory management unchanged in drivers which already depend on
> it. IOW, IGB_OOB -> NET_OOB -> PAGE_POOL_OOB -> PAGE_POOL.
> 

Right. And applying your change locally fixed the build issue for
xenomai-images. Please apply, and feel free to drop my wrong "fix" here
as well - I suspect the header is anyway included, via multiple paths.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
