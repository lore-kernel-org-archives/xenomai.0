Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42C249F9
	for <xenomai@lists.linux.dev>; Wed, 17 Sep 2025 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758083392; cv=fail; b=GFIlAHgEBDaqOiS+g42FtTEtyN8lYPGQoig/5u+Bk36Z2m9ZXgQ+1T2ezpSt3SXAxi1ItBwxlUsJbhrojrEXtgk4yNjW5tKGfhh5mVtb2op8SAIXkb+UkfxBKtipywoUOTabFQtTn0ojBlAJ6vP5QqXlzXaR/N+v2ciYbuTQicQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758083392; c=relaxed/simple;
	bh=OjvsNh+W5/qurrtdGofN2/SSFH8al0CWMyvpfTq8WhU=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=WB7iAII37gYD15ObyRsrIx/Apf0/1lXrkYhCm0KFy9/uiByY+ZuQyri67e1Ij4KgV45N/Skw4ZkonX0Xm8r/HikjZ8LeOk6V9wMUDTb0CpFCod2eGA1cEP6ilEg7oTZCuyMvkzyFD3hs7oowE1JcLBX02bGdQs7D87xq+zMg63M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZFFsI/bs; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZFFsI/bs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLlB7/mgq/IavHIlt3kif7RNsi7FRFFkQUrbmmEazzZavXT/q1rJns6rd1DHZ0L95oJwcE8ymjlPBeYhL8bvi1WvbRQX7HoLVw5jGtg9QcXlIJFR2vXxC3sRbJVoFEfjF1xUl7N7c9Fq9As+kPPWXKEaE12fjc9Sc1tqoBkJbWMB60nTq3RXr00sqc1o+BZULejyWnTuhN5x3xZs4WTYLbAiNcNjxcQd9QbF0ebzieiQ5v9hNKyujBC//MgnWuvTkU8lGQ6o7yytRpr7+p23EHPWnsSL5paHppplwElIWcLW36Te8hJvMzG2dxkeNEGJLlSG305lNsiK6D2Rp5G3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1trqldrlm52k311tOjaGdNCx5slf6dwH41IlBpKFC9k=;
 b=iWiYe2wMOjZnyvuUdgdCJ27EnerncFprwQkePky4WyyYYfLoxDHl5VIQmEnfcE1uSSUnd/In1F/Qy5UjjVPFCLIA5nteAb2LCykgYl/SmzpwT8x9OP6CfFF0XKExND+PCyA97dmNk2Pcja2nj925SWSJEK4KX5ciI0PZH6IZidnVuH68b3H6fxMsFnJ3pWRlpxZwINU8LLwjTS8Xst4+TKOjlirr1795XxaC9ELAN/dH/lyr6JR3DQGmIskPYS/codwHNrCdDx511WqlrIHij3+mTBO+n/nK5IEx5hm97IK0mKjVzBa8uCfDmJCEbV/7zQJFor2flow2ORogtB35ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1trqldrlm52k311tOjaGdNCx5slf6dwH41IlBpKFC9k=;
 b=ZFFsI/bsvjkXkiGEeIKqC7am5u0IMQRSibbo1UUdsi30KdrYPT/x2HVrFqJUGqTU1RmgduFMgtddBclyqa30iIBa67eorA55weySf5IsSPaX5Fjp+skox01MBPovfuCKb0eV5AO1AoKGy5H2eq6Ke3OQKAwk2H/enqDFaQdRV7RecxBL9toygh/ND6U3Fm1KwxCJYoj29q1iLMUIdsghWi36fxrRtOyTxEUel1tfe4EzBFap5qP7UW1MQBZV2YRiTFsj10xe3E4faJazTl9G8FQHQWt9FJua9GSsdHmubrp8Y8IW6mLwPHlKvMpfxKUJRjKaCtsN+055E0HayDbIDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:123::10)
 by GV1PR10MB9089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 04:29:47 +0000
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb]) by GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 04:29:47 +0000
Message-ID: <64fe2423-6d03-46d5-be98-ed5a3a059c09@siemens.com>
Date: Wed, 17 Sep 2025 06:29:43 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, September 17, 2025, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:123::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXSPRMB0019:EE_|GV1PR10MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 25492a89-6424-4407-c829-08ddf5a2d53a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2N3dkFQejd1K0xUNzlZR2lFMi81MU1ZNERwVVlzMi9PRFozUW00Z0RSd3h0?=
 =?utf-8?B?a25ybzJ3V21VTmNFV1V5THZHdzk5Y0xOUUYyU1FvUXIzUzA3bUxZaEdubFVw?=
 =?utf-8?B?MWpJc0Y2dFZWdFFDL3h2NEc0TWlhd3hLNVM2VG1yS1ZLMGM5ZVFnVzRSMVZF?=
 =?utf-8?B?VmlpYVkzaEkvdGNBRk56Zy9VN3FhMnB5bysrY3BEcGNkUENONUp1cUZ5WHdj?=
 =?utf-8?B?aWptWVpvYk5MUXVlbWFtNlFEVzBjbnZDRkV0U2JweVBMaG1jQmhZNjNhSkFm?=
 =?utf-8?B?c2I1TllrbjUrM2Fhc1RpVWJSejQrUGQ3MnIvQjZORlZQRnptZVRFT0dNaGcy?=
 =?utf-8?B?ZVIzOHFhQnNhbWJXaUVJRDA3b1ZRVC8wS1liMW0wNE1SVFA4Y1g4RE9UZnJr?=
 =?utf-8?B?K3pZN2VVaEM3RTZldXJQTStBQXRyZ0ZKYjFSTTc5QzdHa3d5NTNIVUc0cThK?=
 =?utf-8?B?dUtGUDhSbHNSNSt5RWhjTGJLSmZMOHkwbHZ3Q2RBb0RLSDZIU1hsaTFSRExt?=
 =?utf-8?B?WHpIcXlVVmdZcVlzTTZYQ1FnNGNqSk1uRUFDbWpKMmhWL3kwUC9udThmQU1q?=
 =?utf-8?B?eHBBQjlhNTI1ZU03NEdHb3lTR0lvb1UxbHZmNi9oTmhzQUZybnNnbDNCekNn?=
 =?utf-8?B?WnRiZVNrYTBQbld4S3dIczhQTTRDT0pJcEJlcHpHUWFOYk9IZ1Zldk9lZjBi?=
 =?utf-8?B?MUROeUg2bVdyNy81QnZiVUFSbmJjdkFUWlRiSkZhZktlM2lucTFIZDNiOGJh?=
 =?utf-8?B?aXZXc2Y0RWhYRDNiOEZTSkRSQ0lDMGcwcU5OaTNkQjJJYzdQVFpCTTRqcmZX?=
 =?utf-8?B?eUQ3MS9LSlJvWFdEbE1rcTVUZTBOUER6VmxJS05DbGhoVmxkSUhKUE54S3Vn?=
 =?utf-8?B?NTVuWXBNTGdTWnZNL2d6MnVTUFcxM29RZFNQcU1xbW82TGs1ZGhBQ3h4TVFF?=
 =?utf-8?B?dUJDckkwWXFuN0J0QityYVp3bDNoYi9rQUxQQS9EMG05T3RUV2tSQTc5TVBz?=
 =?utf-8?B?WkJjdmIxcEo4RG9DemUvbXdxS2w5QXBpV242Z01ZaHBzcHVadWR3ZUwxQ2pK?=
 =?utf-8?B?TGxaeUVUV2F4cGdVbm1oeVFMMDBYemM0UEZxalZNSWpiajNUdmsvZnYvSUdv?=
 =?utf-8?B?ejh2bllpU1hBWWxpSjZwVUdiK0w4SmNzMDBJTlI1VGFwSVNnaWFweFFjOEM0?=
 =?utf-8?B?OVg2bGJhNy9sNEFUR3BESUVxdnd6dkNRYnRRMm5KNHJaVVhiTGxpbGN1RlQ5?=
 =?utf-8?B?b0p3aU5OSFhhaWJTLzVhMi9TNGpzV1p0ajZSQWJBN1pYWWp3Q2RoTGlxY290?=
 =?utf-8?B?R1pONkJiZmNTQ1pzZFpPejMwRUJtWlhNZFIrTkI2Z3ZpSnV2NVdxMDNYSnRm?=
 =?utf-8?B?VFBpMExZSFRzRlNlaUdsNVZkNCtRaGNuT1JKSis1Y2RFYSs5cldLQzZOcGhB?=
 =?utf-8?B?SERCVWRsT29GSTQ1WnBXRmdGNkkyNUtmUm5GT2xjWmJRaUVwQ1BydFdHbHU0?=
 =?utf-8?B?S1h2WDl2eHRRdksvNHZzcFFnV3FOUWtoRGpSV29xVzJzeXNiVVNIRVVya2xT?=
 =?utf-8?B?bDljcDFEZHJjOWxoSFZ3Z3BibVdvUVRBTEdwN08vcE44Vzk5THVtNjFwQTc2?=
 =?utf-8?B?SVlHVVhOdjNtelppWGJDWFRRakk3alpzSjB5bHY3V2ZBOWxXMUR4N3Q5bkZR?=
 =?utf-8?B?ZWw0bXh0VENsYTlic0FvNjMwcTBMVkd3K1pPQ25vY2YrUDA4Y1VuU2pFZnd4?=
 =?utf-8?B?VUVrWjFGdWZ2alAvNitPYUdBM2psTWlJQXEwMjVKYW00REROcC9aY0tYamhq?=
 =?utf-8?B?ZmpBZnNKSkdmeVVrOUZBaXNZWURxZ1VnUUtDV0M0cmFTR1loTTJGbzBrSjhH?=
 =?utf-8?B?MXk5SVdTeVNjQTJRZEJsTExkd2thSlBMMnhCVVpVRXcvWjY3U3htV3pPNWZN?=
 =?utf-8?Q?C8lyCyzd7xE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE83aytzTDFBeHdQUEQ4NC9GWjU3cUk0Rlh4alA4Sld0eW1CNVR0T3JIdzdv?=
 =?utf-8?B?Ti8xZDNWOWlmRWk1NUpFMkhJVzI1dC9icWN6YUdWSWlVOTdVS1ZzTk0zS041?=
 =?utf-8?B?cUl4VDczeDRNKzIwSlZ5QlhNVHYweUhBd2ZNaFlSMWc4L0srYUFsNHBmcVVC?=
 =?utf-8?B?aGc0dytnTEtvdGNHM244SC85dHRTSnZFQXMxZU9kRGo1c01Ha1VqbHdVNlA3?=
 =?utf-8?B?eG1MOU9XQ2M4M1ZsUzRCK2tib0JxaGMzbno4L09FVmdUNjNDTHNpQzVXb3F2?=
 =?utf-8?B?LzBVUS9obWhiYjNHS1krN3NLR04rN3JQQzNHWmZLWVNscFRnanpNc0NROEFm?=
 =?utf-8?B?akZYSTVRNHdrQnI5cjN1d2hoSGNEY3JmRUo3aFFyWmxTblpTY0JrZHpVclgv?=
 =?utf-8?B?RDVoZ1pIMlFLOFpBVnU0MlliT29ZZmM4U256T25XcHpWdnBPTWFsazlDNTEr?=
 =?utf-8?B?OUtVZVlKVE5od3JRTlpIWTRobFV5elVjM0Qrak9OdzBTTnQ2MS80cDNBM1NE?=
 =?utf-8?B?c25WMXhkWFJBeEkyNXFVVFdWVVpGOFJ3UTFwUkY2ckxxd0VmZWgwWm42TVc3?=
 =?utf-8?B?RFpxR0hvSzBzc2hTVVFpTXd6bit2bGIyYlpTOTdkbnh2NEFFSEwxMVNzVFhR?=
 =?utf-8?B?ckpEM05FRW1XeXhGd09GbHdVQ0dCYTVybG9pMUFiTVE5dW10YkVFdVdDTDV1?=
 =?utf-8?B?VG5DTlN4azBkc0IxWmx0aC9uWVp4UllJMHEvYUt0VmttSXlPZ3NHNDhndTdQ?=
 =?utf-8?B?bHJlRGhDRUR2SGZPb2p3RGhJTVhLM1cwbFZKeTVkZytOZjVsejk4WUhaaFlO?=
 =?utf-8?B?Y3pTMUlteHRrL0FZQTBMRUY4Ly8wSS9vMGdNcHlMbTBYRnFiN2FiSisycGo0?=
 =?utf-8?B?WDhqVk5Bb2tST3JzeHpNNkRJR1IvZ3hLSGppTUxVbzJSNVZNcC9McUNzYmJ2?=
 =?utf-8?B?SUJLNXBXNGQ3YWtXTHVjTTBxdHA4bCs1QWp1WVZpcUN1SUFXY1FPL0dZbmQ4?=
 =?utf-8?B?Z21oT3EyY0ZEME52eEwvdXd4b3BtVHE0MXcwL1dZbUZXZGY4NzVIcGM4dDFB?=
 =?utf-8?B?cWJMMEh4ZkJUMHFqVHNLWTZuWm5MenJJSTN1TWNLOUNKeHlMcEIxaGVSWEhE?=
 =?utf-8?B?WmpDTVRGR2dSc2l1TllBdDdCbUw0MHlrdW1hQXljWXhUbzErN3R0dE5WTWxU?=
 =?utf-8?B?S2RaeE5pekc1TFFrRVFHclBOSVRjV0VrTU9rdGVsUlU2dE1nTXpXb3k3STVh?=
 =?utf-8?B?c2Z1d2lNa2RZbGhPWWJpdERBRnUwN0N2bWRGME92c3hJYnF6YXFDbmdFSWI5?=
 =?utf-8?B?M2hpRlVPekU2alFmOVp2cGxzMnlDY25PeE5NOUQzWllPSkhLY09hanhkWk53?=
 =?utf-8?B?eHFpTUM0bS80bmxqZzRkeDB6Qkt4NThONFJtOWR4V1U4b0FINlBQamdTbW42?=
 =?utf-8?B?eFJhYnF5bzlvR3ZleUtwM1VJWlVTMlNyVUJFbk9hUGFldmVoRnZUdXdEYVRt?=
 =?utf-8?B?emd6alp1R0t4aE1DMEpWSk9GMFpxRTAvY2MzUmJXYnV2dEl3UHF6dFFHaW50?=
 =?utf-8?B?bkhyQTZuUzZ2dUFjNFQ4SU54OThFVE45MTI4clFReXZXUjNaU1UzZ05zZVJ4?=
 =?utf-8?B?UlJjREtOKzdldVV4eVZMbCt3SldIbTlIVnhGSEhtZlk1WWNMeVB3M28yRSt4?=
 =?utf-8?B?R2tvQkZKTUsyamlLbVdSUFEySkhwcVA5Z1lwdVV0eXZveUUzS0lvMHVGNmcv?=
 =?utf-8?B?MUR6WVQwWTc4WDlTcmk4aGwxZkJyYVYvSVJnU28vK0t6ZEx1dWlQMko4YW1R?=
 =?utf-8?B?TDRmUndIUSs0M0IvVEprSUJUUDZ0Ym1rQm5ZTGJQT0VuUnVYZDFpY1V3Q0Jr?=
 =?utf-8?B?TklGakJvVm9GVFpsYkJ3cEs5SUNWUmRFSmFuY2dCZHF4QmdXNFNpQTFEaHVv?=
 =?utf-8?B?ODRrcTR3bDZmMU9vSzlMajdrSk80dEd4YVI3N1RpV2toc2l0akVJbk0wdm1K?=
 =?utf-8?B?cVl1UTVXVVluSUhTa2IrNUd6eUxXd3V0N0JXTGdqMzFvbWNMT1RwcytNVVdL?=
 =?utf-8?B?c084MFlQK1RhWFZmKzJIZVZidm5aVGEyY0IzY2loTy94S01lTlZ5ejh3RjJ5?=
 =?utf-8?B?U1NYdnlNdTZ1SGo0b3cxZFFDbVNaNzZxdU9CWHJaOTQxc1hRNlRwWkZFSXl0?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25492a89-6424-4407-c829-08ddf5a2d53a
X-MS-Exchange-CrossTenant-AuthSource: GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 04:29:47.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oOHL99Aj3DjZy0h1d1zxBUnARSoIWadeMVS5XrSaG1pSWCB5h3l9kt3wNjxCNoeRuAcfTD3vzajWDcBEO453g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9089

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions (you may have to wait for 
the organizer to let you in).

Time:
Wednesday, September 17, 2025, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
