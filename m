Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2072609E1
	for <xenomai@lists.linux.dev>; Tue, 27 May 2025 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345711; cv=fail; b=orV8tt0jzUnSRBERoCprrRJ5l9vkUjB+QRzZmsetiKeoLH9iyP+P3dAs8vFE0nluXleDI/8NaQcq9WuurV1DLixjs6ynE36bGxPeFkaiG+6+/n50L56yQgci1Ut656uOiK+zLP6YrCJme2Ap7rqXoCRVeAIaaii7rs+9PKNcqnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345711; c=relaxed/simple;
	bh=VbALb4T6wMEEGwdtpzV+ZJ4iJAm+yShAy8XdicUSaD4=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=jWq8paubt65hvDwpgCn7cjB97KQPj2sKk+9m2/NwnhB77xzlYM5fw3CoZBVYQCtyzfpHDeOqTl0fcaxbcctd69VHWYZmwOz/BSsqRpWRpYnyT3N7fIKLqiiKt8gbPvT6RRmZsex/F95BezLLL3cR3jevyg3u6CPkZ6Bzexkr/Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wLm25VCk; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wLm25VCk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shQAou0LuivO2PoAPaYrZKXxOTsKeCMDshg/4jBv3NfVFm9/vdD1J5m0yyRuNKYp7MSTJ5hjZT8jh9jGmDA8n9p3ENZiUh97wcBZjnGyHxaUn8EA9HLOHZzQaUCdmSIxFil+Y0lHDLbp+gpjTrywT4x2vywncBMc4+mFD4fchvQtEAaluphRLBHBifhbZhpvaKan14gy05wHMC4eQZVkcenXNCmn3S5W48cqyWMJ6upHmN9UkBh1NTfKmDb6svePm781FK4ENMnaUSyJDo/A0J2Cr3E8s6vBrOHTMEWSQjG5KhIoyVsTyFkhoJ/iyRXhGXXNyEhhRkfl45b91IzlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jhjGcmtBHF/+qRfbfaLKcbYcjTndl0J7X93uTC3mDk=;
 b=U0kCUpabZv30nc92xv2lau8TRQDHxBKPxLHn9W8m4fM6/hRSWg58/yMC4iT5XLm3xvslV54wWqbQ5NFTWCO4n+jxWHdlm9gYWLaby6jF0KyDyJA6kVl3ET1rZvPsyPVWZ2+tRYPu9WwN8muI5sr/8k3V65khN6KmahG3nLKpfQaUOeMQveyjnt0762WL0qJLbtBrDkNSjSWFsWIxxpdj9Xl24Yl7t+A3rLU/xE461Sh9M+ABiKBHFf88YpPDw8EXnhQFeuIBMkTEdCX18iNQI3+j8a/dZWdgPt7Pm6TkvshdxU8pEZvfA/iRZwvqLD87IKNFmU5/hHbnaz58G/gKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jhjGcmtBHF/+qRfbfaLKcbYcjTndl0J7X93uTC3mDk=;
 b=wLm25VCktbXsnpvO0F1amv75/84Res0n2fNPeL0FFUYByIpXYPaI5CEbxXP86DPWJ5rm2TXHHg+yXl5Dj1HGEoc5XEG02gYYRQxrxkg4k6JAVNXDsHHfnnVwMTM70ba6825br6W4rOW72yzKDhBj0/spUb+Bryh3rXUA4uQDBRBzRAJ03bB/8vKNBi1H2l78dGpw/VzLRfkvIs8kYenHrE/UZbLuvJI42G0uNHTJ3gC3UbXvCaQtNnMZiyM7YDxsXhq7NJAYwTXobLQn1IkhqDZXnjFrqmtjQczfR7zQ6aP98veC042AcxPw1sIrH2WtTyxOe+njKE/Livg4MizCnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 11:35:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 11:35:05 +0000
Message-ID: <4d109a85-a207-416e-b80c-6de913f6262f@siemens.com>
Date: Tue, 27 May 2025 13:35:04 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] drivers: Switch from del_timer_sync to timer_delete_sync
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: f15fadfe-2bb6-4791-911f-08dd9d1286bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amo5dVdMMGNRb0FaRXpuMkExRURvUFdoUncwaERoZU1wSGM3TEZCclRJK2s0?=
 =?utf-8?B?WDZJMG05TGpwZVZidU1WV1MvS3RQMlNIYWF5dUt2QzJTVEE4SjV4Z1hlZTI3?=
 =?utf-8?B?bUtYZWFMbDJuOUtXY2t4cEN5bjM2K1U4Ky81aE5scEJxZWEzaFo3dVRkd2Q1?=
 =?utf-8?B?K1E3bFlLRWMzTkxzMGJUMG5vZGhqMGpmRzVFaDRxb1VYVkJWdDlXR1JqdGho?=
 =?utf-8?B?Yi9MZXJHdllyWjNYNXgwMDJUSnBWdi9kUWF3bFNLaUxZb1BuQVZjaXVjaU1q?=
 =?utf-8?B?TVBZQ2w0WnNaRlpSV3pweEZreHMzdnBnN1loNEpPQ0hrTGJGTk5HeEhvcTlI?=
 =?utf-8?B?eVpwMkkrSWo5UGprcjBOVEtxQVZhTUw2UWUvR3lZSkpUR2ZPcDcyQ1lUQ1h4?=
 =?utf-8?B?Y3EyM1ZPOHZLTWdsZENVdnpjMGxhWGVGVGZDNjF6V3dSK3AvcDlndGxUeVFy?=
 =?utf-8?B?NlFONGYxVzVqa2VRa1F3N01MbWNFTjZuTmRyYVM3dVUzWFFTSTFXcEh2dzFk?=
 =?utf-8?B?V3l2QzJlTDNSZ3ZpMklEZUVyQ0Y0NHVUeFZ1bjd5c3V2Z1pCYUdER1BnR0ZG?=
 =?utf-8?B?ZGoxUGNuRlY4ZHMrMGVtemQrM2c2QmZEWjBvYjJYNDBZcjRhMTRxcnFPeEZX?=
 =?utf-8?B?VWdWZjQ3SGdlaWJJRWRJRk5ueHJIczZzWjM5TGNpSXVlc0FVUXpBSnhYZ2tq?=
 =?utf-8?B?Vy9ZckR2ekRSMDJJMFpEME9KZ2FtMmtJbFJPSTRUTVE1NGNDVTFiSjZnaTBv?=
 =?utf-8?B?OFpka0wwR214MHBzMDFMVXd2U3R0dnk5MjBMYUNmajFLem5PZTRkV2xQUllG?=
 =?utf-8?B?TGM0WnNVdXBlUEF6aUJOSkxOaUZieFYyWVJrc2VmL1hDd0xqQ0RQK2pVS3Bt?=
 =?utf-8?B?aHVjY3IvMlAvbGE4UmFxSVExRDJ5cGYwQS9tZTFMNWgzSDI2UU9mYTJUT3Qr?=
 =?utf-8?B?ZENjaXBoSVJKRDdhZ3NEVFEyYjhUMFFrbGdvQ1BnTUdCK2ZDbWZ6eWlXY1g4?=
 =?utf-8?B?eEQzUml3NUMwN3QvSXZMUnBEdXdEK1B1TUdXK3RxcU1QZWwwc3hjNDZpVnZL?=
 =?utf-8?B?L2IwSExacjNQc0hYODR4RTMxc201c21Fcmk3MkZzOXkwZmJSYm5EUUp3KzBC?=
 =?utf-8?B?dmlycW5oY3IxSVM1UWJPdlVQam85REE5NWNEUHk0U2xmUStqVklleDB1Mko0?=
 =?utf-8?B?MGtCS3Jzd1FsQThiSHBUWDB2cGhLTXZQdFNVMm1QWHZET0VmQng3L2tnVjI0?=
 =?utf-8?B?bDk0MlFpQkVkdFBnS1NVaU5hc1ppOUdGTVRrY1dEZFE5MlF1RU9IcEttenE0?=
 =?utf-8?B?Vk11V1FJZlNpU2xsRis3U3NKT2h3SGh1RmUrcnZkem9RY2UzcEFZYnd5UXRq?=
 =?utf-8?B?S21qLzlNL3c0d3lrNzVJRFJyOG1vWEoxYWFGNWtob3YySVN3RWNvRlBjbXZB?=
 =?utf-8?B?L3FNa0JzcEQreU9aSzJDWmxWdC9zWkIrVExLVUk1dXgxd3pWd2hSdzE3RnM1?=
 =?utf-8?B?c2xpbjUrSlVPOGZGMlU2SThwMzBEaEh3d012SWlJOEQ0WnoxbXAvZCtob0Fz?=
 =?utf-8?B?OHozc3ZRa1hmZVpBelBHclhkQm1uMTJodlBtSGdBS1A3T0lKdGVhbkhTQlM1?=
 =?utf-8?B?NS9RUnpobEV3MllweVA0dTVDWU1FMG42VXRBYm9JNU9YVlNmVll1Z1dSVmMr?=
 =?utf-8?B?Nm1rS2QreWFxSEdVU2ZHT213RGNGOWwwazkzdWo3aHdtUHJyKzA5MmpwUXpl?=
 =?utf-8?B?MU9HVzFJSmUyUlRScVZPZDBUT21WcXBtcysvb1Z1YlRlSERLcEIxK25Uck95?=
 =?utf-8?B?QnVGd0ljTUxhcktqV09sWTNxcWJGeDJCUE1BcTRaQWZ6TmRXMWJWM0FvRlox?=
 =?utf-8?B?NEpCbzF0UERmWG1hSWF1bVVHNE9HMEYzMGx4QkZpYTVNVTVNNy8wV0l0NVM4?=
 =?utf-8?Q?WaDiAM5sIRc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjJtNXo3YkJicG4zelpoa2VsSC8rMVBXaUttOWxPeVg1VUMycjFoK0JhbWxp?=
 =?utf-8?B?QUtDS1BCR1U4bHliTk5ZUS9rQzNua09zMVN2aWlTYnVqOVhrU1loMXBOR3Yv?=
 =?utf-8?B?NytZS1QwTW45TXpVNllobm94MmpkZkFsd3hveXI2U0NqUnVDM2JqMmlINFBY?=
 =?utf-8?B?NXQ1ZGR2SE1iM0dsLzZSc0hRS0J0UDZBK2owOEYxSXVTaVdZV3hyWUxoc29J?=
 =?utf-8?B?N1JsUDZrQ1hLUk5rYUE2NVlNbTJKNGE2eDMrMU45V3ppRUZmOUZkb0k3L3cx?=
 =?utf-8?B?bm9RK0JDRGNSbFRmclAzb0trNWVCLzY1aHJIL2xxY2ZPQi84d1lvVVl4WTFy?=
 =?utf-8?B?QmRscGpaakJzQ0JmRFJvaGhrUWJKS3hNdHJMaUpQR3h1K1ZINXFBNkI4T0ZM?=
 =?utf-8?B?ckMreHNOZmxhaGtodHAvQjlLU05hT1VLNmN0NENkS2JFQ0tpYVhMeFBsWXcy?=
 =?utf-8?B?UlY0emswOXhRZDZqaGtvVFZVbDVBN2Vla3NYVVJOd0drM0wwakk2cTZDeDZw?=
 =?utf-8?B?TnlHb1lPS2cyKzJLTWFiUDlhc0FaMnNRSWRzY1Rsd2hhTWRUZmtFOTRRZ1Zn?=
 =?utf-8?B?OEw4aG0xeGpsTXE1TDQvTjNiZFVzb1Z0SjdjUFZhNGRZbnhYRnY0N0pDRlFE?=
 =?utf-8?B?L1UzNHloOHRWM1YySXV6ODllYnMrUlJuZ2tHMmNMczd1SXRIWEFyWDl3Vnhx?=
 =?utf-8?B?MTMzMkthZDd4aHpCWldiRWFDTmRUSGQzNHg5NnV2Y1RrZ21oRDJyWUMvWGNR?=
 =?utf-8?B?NVNHYThxT3c0ZlQ4OXhDcGNPTmxKam9uYkJrTDNqdFlta1VNSGNXSmZIaEpW?=
 =?utf-8?B?cnMyYmc3S01SdjFLNGF1Qzh1U0Q4MVJiYkczK050Y1NPelZsTDFrbmx2VS9Q?=
 =?utf-8?B?dkNSWlhVR0pvKzlVK2NEWVZxNEQ3YlUxTU1hOGtBcmpiQkhTSWZsWE4zSWRp?=
 =?utf-8?B?RXNSMzdFWWRTbnJVdldISG5GREFqVjM4RFk2L3lxVmk2RUlib1lKanhERXcw?=
 =?utf-8?B?Sk9RTzByTlUwNWlIZkIrUW51MG9XczFoT1lFOG16TnZRaEwwUmRnMWxBRFZ4?=
 =?utf-8?B?TUJ5cldhbVN0Tk9zaWk0cHR5L252bG9uWG9mVDNFUjFNb1NqbEtFRDZnbTRC?=
 =?utf-8?B?OWFyVlI5Z1Vxa01xS0M4djRKVHZXVGMwMnVJVDBMRlpHS3kyUmNnYWtLZkpi?=
 =?utf-8?B?Yll6d3NabXVvbHN1ZnJyazZKQk10SU92eFRJSEVPUnN4Q2hUUGV2K3EzTGRl?=
 =?utf-8?B?TlVtK21vdEdZelRLSWNGeitvbmNDSFpsR0JOYk5xQkh6V1JmTXowUnZzZ3NZ?=
 =?utf-8?B?R1lIZnFmY29lSzBYZTN5UEdoanVXNFA4dGhHRTlvZG9vdzI3TTg2V2ZlQ2xE?=
 =?utf-8?B?TFMxdkNzZjFLVDFMUWNVYTg2bVNmOWs0Y1pvMlFubE9IYU9mWHBjWVQxdEJv?=
 =?utf-8?B?eU9BYXFhdENDOGptZW5QMUJDcVByZmZDaFkrUHBFVjRsNkR0bDZFdUsxYlRD?=
 =?utf-8?B?eTRQMmN3RXhiQ2JXT3hjeS9uWnlVRVM0d1RLb2U5b09lbnlzL2U5aHd3cHN3?=
 =?utf-8?B?WGdTaW9ybDRSQ3Z0a3FYUGZMZmd0QjN0V2cxbXFVMUtieVFXZ21Kd3NKSXBE?=
 =?utf-8?B?eWpFUlcrVGlQWXRJZXBsT3RJNUJ6T0luTlVQVXhXN2VJUDEwSzJ6Z3BGVDR4?=
 =?utf-8?B?cFVwakovR0F0WW9uelF1WURJc3ZtN2pSeFNsTTZuOXF3NjVCb2h1dVVFa1N5?=
 =?utf-8?B?WHZkaVo4aVJMck81NGV3ZG94SHhnMWU3c0FneGRMT1FySGhLRlpjUHdoVm9z?=
 =?utf-8?B?aTJ2OHo1UmR3ay83R01WRzc2ZWV3d3RnYmZaUzZ6K1ZCWGZJbDhUWlJ6QWV2?=
 =?utf-8?B?Umk3amRZV0ZRZDFMVitBWTR2cWlUSVhLb0NIUFdacXF6T0g3WWRzZkVNQmtx?=
 =?utf-8?B?ZnByUGVPUjltcWdGbng2NHE2WnIzYkUyNHNpZEtMckVYeEdNV1MrMzdCcEdI?=
 =?utf-8?B?b0FvZUY4RVI2eHE1eTdULzcvZUc5N0YrODdTWmRWN24rYlpBMlMxckt0ZkZa?=
 =?utf-8?B?bVZtN3dsei91Njc1T3FtOTNSTW5JNFI0TWxSSkgvd3NBT1lTOWxzSlp3L1J4?=
 =?utf-8?B?bS9mcUErZlFFZ2FKUGl6d1A3akduZ2U3MjJ6SWRleG5lR1g0L3B0b0dhQ0lF?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15fadfe-2bb6-4791-911f-08dd9d1286bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 11:35:05.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiGlcNr4/4ohAmW2cUMvmS/1Cot5Efgawby9PtBLpXS94hUhVWzNQ1rcJyPv99AVSlqF8i0hGvcH7MfO9rlqyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9027

From: Jan Kiszka <jan.kiszka@siemens.com>

This was introduced with 6.2, and the old variant is gone with 6.15 now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h      | 4 ++++
 kernel/drivers/net/drivers/e1000e/netdev.c                | 8 ++++----
 .../net/drivers/experimental/e1000/e1000_ethtool.c        | 4 ++--
 kernel/drivers/net/drivers/igb/igb_main.c                 | 8 ++++----
 kernel/drivers/net/drivers/igc/igc_main.c                 | 8 ++++----
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 35f06da4bd..6b488d0f26 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -67,6 +67,10 @@
 #define pde_data(i)	PDE_DATA(i)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,2,0)
+#define timer_delete_sync	del_timer_sync
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6,3,0)
 #define spi_get_chipselect(spi, idx)	((spi)->chip_select)
 #define spi_get_csgpiod(spi, idx)	((spi)->cs_gpiod)
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 04312a54b4..882d731804 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -2501,8 +2501,8 @@ void e1000e_down(struct e1000_adapter *adapter)
 
 	e1000_irq_disable(adapter);
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	rtnetif_carrier_off(netdev);
 
@@ -4198,8 +4198,8 @@ static void e1000_remove(struct pci_dev *pdev)
 	 */
 	if (!down)
 		set_bit(__E1000_DOWN, &adapter->state);
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	rtdm_nrtsig_destroy(&adapter->downshift_sig);
 	rtdm_nrtsig_destroy(&adapter->mod_timer_sig);
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
index a249f1719e..4ead3b5791 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
@@ -1997,7 +1997,7 @@ static int e1000_phys_id(struct net_device *netdev, u32 data)
 		e1000_setup_led(&adapter->hw);
 		mod_timer(&adapter->blink_timer, jiffies);
 		msleep_interruptible(data * 1000);
-		del_timer_sync(&adapter->blink_timer);
+		timer_delete_sync(&adapter->blink_timer);
 	} else if (adapter->hw.phy.type == e1000_phy_ife) {
 		if (!adapter->blink_timer.function) {
 			init_timer(&adapter->blink_timer);
@@ -2006,7 +2006,7 @@ static int e1000_phys_id(struct net_device *netdev, u32 data)
 		}
 		mod_timer(&adapter->blink_timer, jiffies);
 		msleep_interruptible(data * 1000);
-		del_timer_sync(&adapter->blink_timer);
+		timer_delete_sync(&adapter->blink_timer);
 		e1000_write_phy_reg(&(adapter->hw), IFE_PHY_SPECIAL_CONTROL_LED, 0);
 	} else {
 		e1000_blink_led(&adapter->hw);
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 4474700bd3..a91f8a1de5 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -1647,8 +1647,8 @@ void igb_down(struct igb_adapter *adapter)
 
 	adapter->flags &= ~IGB_FLAG_NEED_LINK_UPDATE;
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	/* record the stats before reset*/
 	spin_lock(&adapter->stats64_lock);
@@ -2442,8 +2442,8 @@ static void igb_remove(struct pci_dev *pdev)
 	/* The watchdog timer may be rescheduled, so explicitly
 	 * disable watchdog from being rescheduled.
 	 */
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
index 60c59d9914..9c435d364d 100644
--- a/kernel/drivers/net/drivers/igc/igc_main.c
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -2629,8 +2629,8 @@ void igc_down(struct igc_adapter *adapter)
 
 	adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	/* record the stats before reset*/
 	spin_lock(&adapter->stats64_lock);
@@ -3904,8 +3904,8 @@ static void igc_remove(struct pci_dev *pdev)
 
 	pm_runtime_get_noresume(&pdev->dev);
 
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
-- 
2.43.0
