Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795376783;
	b=1eBchT6szCi//ItW51+++FupaeufGYYAyBGG1kUSM4KtGvLddp0G5jPO4xTEyz9AyCH3
	 u4EwZNrSKZQujQIT1rL0bEwccEP+ZjjJLwCQw/vwvVErQ8cciXI651E6uBExDdRHKFtJE
	 EUp4sOGADMRn1lMKjktQDgIY/Q0h5J4C8iX0mxF87l6yqmkI0jJ22Min8ZOJLlgwpp9/1
	 MK+hbvpM+5/e1yXG1Ie2fehZ7iJwpSEltk3AxVyjiPC6wZQfdH8ghJqxj2tq8Pvceo/Ov
	 /NTxv+qYNbxtZCKKB12c1DMaZkOguS0wU8pDeHugZezoBJvsavCsuyMl+/7p/qKgUCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376783;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4OV1ZuEEyY+eVTc3euKRTMmf5OMh2kHUlAaJcA6+Xmg=;
	b=WoPyuImBpnUuxFoKuF69sy7jmoBXBPXIWyIOpNst77r9bGzCiW6ujavqTYrj7ibUy/W0
	 dmBsXq7CmGpkNCB1+ftlfD7S9x9LcdZd4bfkA5Pqg071cpP3IcjUufHOLxg2NOkPCee3m
	 lil4AZd6rO1fLxQMKZFW8TD33bhKq+F4uxyXh1McB0RU8GIOvcLPjy9803M+QfsQe0N5j
	 Manhm8fHhrO3A0Qlf1uGO8lZrLIslnNtHTkGDhmum0rHSIl7EFrfI+iYZpZ/Csg6kbHxp
	 GGhhPLtE2az/LO0I132lSfdXxLEAgcdM+pHLstvJCIZzPBToOOdwtJfZyPRs+3aLfJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=wQqagSFz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.59
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66B606A31E
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 19:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A66B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=wQqagSFz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDQQvpuovRqZOZzLMcJ3XMEyg4RpHVFWLaP1W4+e0aTd9v7AtB/O4d4oRJMdiRIY3vwSXmtA1OJB204lwvaMiINxQJhQi++FnZffmgcOFh2p0FLfNCG3mjEeIKpfEarna59zeBMM0XWBS2egSM5+ja2E5h3vOCwvsQpyTh3emmAT8jvPouMk9ZP85HcKKsZETQJKmXsry3yTCPZtpcQPdha4dUkmT9/zm6inVAZShonL5N8pC5um4nq5XVhg0H/A6ZhpWILV71SL/8v90pzsjBqXGT685DFSPQMZcC7xM2DB7TbC+w2NuTe3+8/Lz0dHzA2Y6cyF7kN6fb/mEQDkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OV1ZuEEyY+eVTc3euKRTMmf5OMh2kHUlAaJcA6+Xmg=;
 b=nJEB+gJIl7990Owv6eqRnbo6ImjXtamRPGVeps7S78hv50SNgCx8HVifsQD0qTmNtVnlZ5prAbiV+Iv2dBNpw8DVCSF+0yQ7p8mUN2Kpe5SIfJwUi+7ntteL/h0Izt3dwwvVV3LTsigQ9qYan7dRk7EpnI6Sv+MjG3SBdZC1pCCT+7gpWfeVYiXWWbXFO1URNLBxX0KgsXF77dlqeGyE9gfG9B19Ogvg3L2YFx4KUWLKb+LdY8cBIy4RjTfIsRPN1B1f7NXNDonf5JhMJCqmqeKeAxh4nK4HiZp4CQ6z3p4zUoptsrbBHqNOASB4+JD3/INPdensEYJ7MbTtRuSvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OV1ZuEEyY+eVTc3euKRTMmf5OMh2kHUlAaJcA6+Xmg=;
 b=wQqagSFzRz8aDZlp4qTZiDfj0H7KzS8AKpPYMt7QyBlN0G8uvG0cIDPslrt1t97DAqfkbjShlFWd2zIxYNBSBlBUBwJ44i7vajTAhiL4bUAtQWb0jY4zWnumbL3mltPommjy40jWzTgABHaJDA3gGodX6EyUHUAuKatlIj8ZLQkYLTcMwRhN2cRgw10/jS05N5qIz9J5tHpUVHgkh8FXBUeszuwhlxJEErKj23fBT8IvCqJ2LL2NQnIAgoLIamjrT3McE7bNU/OpWOFxFCSwkmuyFt7FexjpkvPbW34RM+UTJczsqFZJU5LUfxm8bVQVKkSOlitEgfJXOz8rWLfxIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB6715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Sun, 22 Nov
 2026 19:46:18 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sun, 22 Nov 2026
 19:46:17 +0000
Message-ID: <66709223-4a90-4073-8068-8f5d24118aca@siemens.com>
Date: Sun, 22 Nov 2026 20:46:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] smokey: Add traps test for trap routing of primary
 mode threads
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
References: <31921289-e2ce-4370-bb21-97d66de8e566@siemens.com>
 <37fbdf8e-9116-4b36-840a-612d49fc7f55@siemens.com>
 <e78f2129-6875-4b5e-87c7-088950b69785@siemens.com>
 <4f118759-234c-4ed1-afe2-fbefe849e369@siemens.com>
 <b533b6ad250bf960948765d5829fea34f26b99c3.camel@siemens.com>
 <ba91a81f-a52a-4742-b4f9-4c9c3437ef8c@siemens.com>
 <6c4a73ca6be802d564e770baecd5d90220627d13.camel@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <6c4a73ca6be802d564e770baecd5d90220627d13.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: a104d2b9-34fa-438c-9596-08df48d14650
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10070799003|10067099003|4143699003|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|261021130227099003|261022075727099003|261022105027099003|261022115727099003|261022113327099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|55112099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	R2is+xWn1c745SvOnVVa9cYqZsmKcoHLSsJdvVPaDNsxJb44KkgDOI2qr5Rn2+cOI3sLqYBeXiWU6JKuQ5HK9AEwpFpyeW8Fr2Z2FV1nqMbb5QYToMi9UdZVjsGyPQLGRYan16D42kCjAh6gaWUqwMoRNSPXd0X/uqVQUb7V7X/SbAGDx/gtBLpk6l6HiM/8u9fBhJsE5gk/bH6NEogljrgmIvBG2KoCp22gHgEjT2uXdFbXEUZzdyVMVUj709k2ZO3gIBssSgnYuhVQHzZwqNw7A2QhIs2CSajr+P43YI18abRdsdLYiCutRfsZ+WD1Cc/pF5ODcsK3SL3U5i1wfL1PNuBms0PlJtXySbA7GY4u0epwKYxSyVHWDAvTEad1nvd4S3pItrAH+j2Fr4qSBpREfJsavsiCIetGKhoedCxs/Hc3T1zebq9eV7Bs9B/K//ez6lrYObmBIqLkIZXQ5HOUciMYEEBfYsC8Gm5ihc4AZ7jmhrdjEf90nNueGGfZJNiS3eH5QbDAEcc1mAjlyta95yUUb8KSCoQXbH0Hn8vQoefdfdfWROb1tGN64ujMRPRy/7RS96wcn3rl15skLZYGKpFOD2pJphvCMsyq2G1Y64fPxGPUoEvp2fGXT6saX0yJkG1o6l8i/C8+lM2U7+q8KzZ/ef3E9HJc71T9lgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10070799003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261021130227099003)(261022075727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzB6Nm0yaS9RdW1jZDZBeityc21vUlVKNGhkYVY1bVN3elpGMlNWeVd0dFRH?=
 =?utf-8?B?d3pCSHIxMXhrc1QzREovVmJ3L2h4MnFKN3N5MlpndG1BZFhVdjlYc1VIdUd0?=
 =?utf-8?B?WnM2UVdweDNPN09HK0lpWUt1cG9JRFhhZ0Q4RStIZ1c0Z3FUbE5pNEh3bnJh?=
 =?utf-8?B?aTdDTExuMjkvbUlzSDBzQ3lmZTYrRkQwb3g1L2gyMTFOS1FuSkRucCtpQXc5?=
 =?utf-8?B?K09WV0N4Zk9YUjZNeExRRjRxZWhYQVNIdlMwSTZkOFV2eHR4VTFad2dhQ0pQ?=
 =?utf-8?B?bmZSMXZFelBBRlhtUTBiQTdKbGhLaUZ6THF0b0hFdFh3dFRlSy9rQytDRCt0?=
 =?utf-8?B?eXlETnNRZTI0QXA2Nkg4b250dmJjajZjV25DWklER2djMUt3WWFPWWk2a0k1?=
 =?utf-8?B?bEdPcVRIWXBVY1hMajV5NUNmcUFKOVMzTThPVk1wK2d5b0pnWHBzNnR5S2dD?=
 =?utf-8?B?OW83OCswVjd0cEtyd2NOUkZvd2prQ1R5MUlWUWd2WDhEd3A3Zk9Ea0dFSXE4?=
 =?utf-8?B?Unk4emE1Q0NXMGZZUEFvL21zcFJjVHB2QmxpeFpVQStaaWo1NlB6eDlQYnJh?=
 =?utf-8?B?d29qZUk0Qk1CNWgxQzloaXpvNXk2RGNHRURMN1d5R0duY29LbTY0eUc1UVQy?=
 =?utf-8?B?T0tISVA5Q1NkWHYyZXVNSnVIdWtLS2lkWFVPYmpaYVpLMmw1TWFzYlB5T2lV?=
 =?utf-8?B?bEluMHZjK0FET1hvWFQzZEpMWURjeVFxM2I3S2RndC9HRlpTTStoT3k3VDJm?=
 =?utf-8?B?WTRmbUwvYkRWREhKTGR0YWJDK25YOU55MjJCaWQ4RXNOY05QRGN1ODg4UE1k?=
 =?utf-8?B?WWdzVEEyN1lVaXYzdXRNU3FPU1BZSmgzTDEvbmFSS3hUZ2g4REpMdmxNbFVv?=
 =?utf-8?B?bkxVakllQnI5dis2R056U05qLzdqQU9sOFpuQUtpQktIOFhuZm5QWHJhY1Rm?=
 =?utf-8?B?MVUwcFo4a2d4ek9tLzk4UnJLZlJlU3o5NEQ1Skx5SlcxQytveW5nRUFid25h?=
 =?utf-8?B?ZDRHMnhFRDUxYTNxMHMvTEMvcTdsOFFUSHlRYkJrRUFCVHpuOHFPSHlmM1pR?=
 =?utf-8?B?d3JYY0EyWDJsYUQ1TG5NdEtQRndaYXFTTXd5UUY5NWp6UEZWb2pMd1YweE9h?=
 =?utf-8?B?TG5LcFR2d2FNS3ludGtSM0wya1YyTEZZVW5BNEt1c0xoOUl4Y2JyS3crZE04?=
 =?utf-8?B?dkl2RnNHRjdJZFVVM0hDK0Y5UElrbEI0UHpveGE4eXRWNjRacG5lK0tpKzJp?=
 =?utf-8?B?WkFacVd4czN0UkExMGVpOFZnYlNpbkdza0VsV3QzRjVMd2VIZUovYVIzM3Mz?=
 =?utf-8?B?d3p6VlFqclhobk9SWUUySmtVcVVuWDNDSmhQZUU1SFhvRHdVZllnU0hIdmRh?=
 =?utf-8?B?OExlTGt0R2xkM3RUcE5GOEVpVWpnRUxMS2pnOThtT1pFUlJJazMxeUFGUmhz?=
 =?utf-8?B?NUFNWmZQZVF2aVVWc2pPbjJQSEdGK3FaWmVrNEV1Zm10b1NRdDFMZEtxSUJP?=
 =?utf-8?B?d0xwNHhDS3VRRFltUGNnaEpIS2RSRXZBQkZFT3BNWnZNenJnaW4rT3ZmTlhJ?=
 =?utf-8?B?YU9UdFRLZWpWejk1dWo5QmtISzdDMytrVVNidUJMZ0NNeXN5VjN3UHBteHhj?=
 =?utf-8?B?bTN0c1N3RzBsQ2JIRnJsaURhWnFBek9hM1psem1nTTVKQTY3Ny9VVVZrQ09t?=
 =?utf-8?B?b1F1d1Q0OE1tV3hTNk95V3Ixd1FPUE80YUJXS2RRcWRNWHozY2tkZHNHYThM?=
 =?utf-8?B?NlltOUhITktuaTNxeGM0TFdpTmJkd1QvZW1naDQyNXQ5MjA3MUJYejR3R1g2?=
 =?utf-8?B?aGs3dzhsQ2MyeEhrZVltT25ZcWU2UmRDUGR4c2d1MzJ2K0l3MDJ4aUI2L1Av?=
 =?utf-8?B?L0RQcmM5L1BpanJtWkx5SXl0RzJCTGxWK0tBdHBXUWwxZ09ac0h5cDF5Q096?=
 =?utf-8?B?ZVNvKzJrcFZYWjRsd2Vrd1lBZnV5TmFUV21iR0dGUC9MdG9JMmlyYlpFcWFL?=
 =?utf-8?B?MTRlY0ZRSi9taDE5bmt3cDV6RnZxN1htaThhajlpdDI5dW1QclVadVVzbDJ0?=
 =?utf-8?B?K2ZqNXByMGEwY3VKN3Y0NnJ5bmJoeW0rTWZzRXBvMDk1VnJrcGExYUtDUDly?=
 =?utf-8?B?K2pyeDR2M2ZlSGRWUWU1eHJuODlSWHk4dFd6VTF3WVR6TUQweGFhMjV3NFd0?=
 =?utf-8?B?ZzV1TEdZTWFSanZ3SzczcWd1cThiMXkvYXJLMzJnRVU2VTBRS3VoQjBBRytw?=
 =?utf-8?B?RVFRUTU2UURGR0FvRmkzczRPYzFWMThrNUF3Q2dZRThwS05XV1VjRUNBcjRH?=
 =?utf-8?B?YS9Tenp2azFETVFwMS9xNG4rVUQzeFZpbTl5cjd5SXpGZzBtVXE4MmtjUEY4?=
 =?utf-8?Q?EFc7Y2DHZ55BU82jD4ve8DuqhKuoDWC0OSwfXnudERIDR?=
X-MS-Exchange-AntiSpam-MessageData-1: 3Y7AaSUGginkAGgPIdZSfL3HnUZ5kZjAnNU=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a104d2b9-34fa-438c-9596-08df48d14650
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 19:46:17.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CiMdSJZ48e46h4K2HnT6LlkkbdKtomRGmA0q2llCNkYIOtplC+3YVWyh1q7T5yopR9S0SirZlOui+SNLKheVVSgVDBl3L0yQ70oMEE+pMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6715


On 11/22/26 20:07, Florian Bezdeka wrote:
> On Sun, 2026-11-22 at 19:17 +0100, Tobias Schaffner wrote:
>> On 11/22/26 15:52, Florian Bezdeka wrote:
>>> On Sat, 2026-11-21 at 18:04 +0100, Tobias Schaffner wrote:
>>>> On 11/17/26 18:28, Jan Kiszka wrote:
>>>>> On 17.11.26 10:27, Tobias Schaffner wrote:
>>>>>> On 11/12/26 18:44, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> A thread running in primary mode which takes a synchronous exception must
>>>>>>> be reported to the Cobalt core by the Dovetail layer exactly once per
>>>>>>> trap, before the in-band kernel applies its fixup. Cobalt then relaxes
>>>>>>> the thread, accounts the trap and sends SIGDEBUG_MIGRATE_FAULT when
>>>>>>> asked for. Only the page fault flavor of this was covered so far, by
>>>>>>> the sigdebug test.
>>>>>>>
>>>>>>> Add a test which triggers one specific trap per case from a primary mode
>>>>>>> thread and checks that the expected in-band fixup happened. Most traps
>>>>>>> for x86, arm, and arm64 are covered here. Left out are those that are
>>>>>>> practically irrelevant: AC for unaligned accesses on x86 and VFP
>>>>>>> exceptions
>>>>>>> on ARM. Not yet covered is RISC-V, but it should be easy to add on
>>>>>>> top.
>>>>>>>
>>>>>>> See extensive AI generated explanation at the top of traps.c for more
>>>>>>> details.
>>>>>>>
>>>>>>> This test may become useful for checking future OBB trap reporting by
>>>>>>> extending it only slightly.
>>>>>>>
>>>>>>> Assisted-by: opencode:Fable-5.1/Opus-5.5 Signed-off-by: Jan Kiszka
>>>>>>> <jan.kiszka@siemens.com> ---
>>>>>>>
>>>>>>> I know this is huge. Therefore, it is also something that we likely would
>>>>>>> not have done without LLM support - way too much effort for testing
>>>>>>> corner cases.
>>>>>>>
>>>>>>> I went through it, but not in all details. The tests fail when they
>>>>>>> are expected to on unfixed kernels, they apparently pass on fixed
>>>>>>> one, at least on our CI hardware. "Should be OK"...
>>>>>>>
>>>>>>> BTW, if we merge this, we implicitly document parts of our so far
>>>>>>> unwritten
>>>>>>> AI policy ("yes, we take generated code"). I still need to think
>>>>>>> about which of the templates out there to use best, then I will propose
>>>>>>> one.
>>>>>>
>>>>>> Hi Jan,
>>>>>>
>>>>>> Following your input, I spent some time last week on RISC-V trap
>>>>>> handling in EVL. To verify the proposed patches, I ended up with a
>>>>>> similar trap matrix test generated for EVL.
>>>>>>
>>>>>> With the number of fixes we can now produce with AI support, I think it
>>>>>> is right, and important, to put more time into test infrastructure.
>>>>>> I think it makes sense to pin down in more detail how Dovetail and the
>>>>>> co-kernels built on top are supposed to behave to make sure this is not
>>>>>> changed by AI without us noticing when these tools are trusted more and
>>>>>> more.
>>>>>>
>>>>>> I am asking myself if we want to keep some kind of human readable
>>>>>> source of truth that tells us how this is supposed to work. If we start
>>>>>> generating both sides and both sides are hard to understand (at least
>>>>>> for me, the kernel side still is) I feel like it will be hard to notice
>>>>>> if the tools start to slowly change the design.
>>>>>>
>>>>>
>>>>> Good point. I'm currently fairly impressed how much the models
>>>>> understood about the current dovetail architecture by just reading the
>>>>> kernel patches. Maybe they consumed some documents upfront, but
>>>>> definitely not while answering prompts.
>>>>>
>>>>> That said, we more guardrails, also for models that might be cheaper,
>>>>> more sovereign (local open-weight...), but also less smart could be
>>>>> useful. Question remains how to encode things best to have both side
>>>>> understand the same.
>>>>>
>>>>>> In addition, I feel like most of the tests are Dovetail functionality
>>>>>> tests and not specific to cobalt/EVL. I think we should at least try to
>>>>>> find a way to tackle this with joined forces for cobalt, EVL and what
>>>>>> ever other co-kernel using the infrastructure.
>>>>>
>>>>> Yeah, valid point. Maybe the availability of a POSIX interface for EVL
>>>>> will once allow to write more portable test cases or even share the same
>>>>> code base.
>>>>>
>>>>>>
>>>>>> I think that RV can maybe help here. It would allow us to decouple some
>>>>>> of the checks from the triggering of the test cases. Triggering could be
>>>>>> in the co-kernel projects while most of the verification lives in
>>>>>> Dovetail.
>>>>>>
>>>>>> I created a POC of a more detailed trap monitor paired with a matrix
>>>>>> test that solely triggers the traps from the different contexts in
>>>>>> cobalt here:
>>>>>> https://github.com/TobiasSchaffner/linux/commits/tobsch/trap-monitor-
>>>>>> rfc-proposal-nofixes/
>>>>>>
>>>>>> Asking Opus 5.5 about a comparison to your proposed RFC it tells me:
>>>>>> ```
>>>>>> Not covered:
>>>>>> - SIGDEBUG with SIGDEBUG_MIGRATE_FAULT, exactly once. That's Cobalt's
>>>>>>      notification to the application, and we don't check it.
>>>>>> - The counters in /proc/xenomai/faults: the right trap +1, all others
>>>>>>      unchanged. That's Cobalt's accounting.
>>>>>> - The exact mode-switch count (Cobalt's msw statistics).
>>>>>>
>>>>>> On top of the RFC, it covers (checks no user-space test can see):
>>>>>> - the handler level of the unwind, through the stack frame;
>>>>>> - irqs off on trap exit;
>>>>>> - demotion only from task context;
>>>>>> - no IRQ in NMI context;
>>>>>> - no sched-out during a kprobe;
>>>>>> - the time limit.
>>>>>> - more fault cases: read-null, write-ro, write-retry, exec-nx, bus-eof,
>>>>>> fresh, fork-write, kernel-fault, kernel-fresh, misaligned.
>>>>>> ```
>>>>>>
>>>>>> The output makes sense cause the POC has no cobalt API specific checks
>>>>>> anymore while the monitor adds more kernel internal checks.
>>>>>>
>>>>>> The hole approach Monitor + Triggering matrix is smaller than your test
>>>>>> while the monitor part could be reused. A rendering of the monitor is
>>>>>> attached.
>>>>>>
>>>>>> Maybe you want to consider it or spend some tokens for further analysis
>>>>>> if this can be valuable.
>>>>>>
>>>>>
>>>>> "Smaller" triggers me for sure! Would be worth to see the outcome in
>>>>> code. And we may still consider addressing potential gaps on top in the
>>>>> userland. Key is that the userland test orchestrator and stimulus
>>>>> generator and also read back the result of the RV monitor run.
>>>>>
>>>>> But what might be more challenging: we would have to backport your
>>>>> infrastructure to all kernels we are maintaining. Is that realistic? At
>>>>> least down to 5.10?
>>>>
>>>> Hmm... I did not have this on my radar... The RV subsystem was merged in
>>>> 6.0 and the Hybrid Automata that I build on was introduced in 7.1. I
>>>> think that back porting the whole subsystem as well as all the needed
>>>> tracepoints would be a huge lift.
>>>>
>>>>
>>>
>>> The Linux RV monitor is usable since 7.3, before that it simply had to
>>> much overhead when compiled in, even if not being used. With 7.3 you can
>>> build enable it without any impact unless you start using it.
>>
>> Do you have any source or measurement results that show this? This
>> statement does not fit to what I know about RV and contradicts my
>> measurement results. RV has always been very cheap when running and
>> close to free when it's not.
> 
> Close to free is not acceptable for production systems. Depending on the
> workload you could easily run into problems (pre 7.3).
> 
> My own experiments (especially with the RV monitor), the discussions we
> had at plumbers this year and especially John's talk about the RV at the
> RT user forum in Prague (see
> https://www.youtube.com/watch?v=jO4M5dx52Vw) would be he references you
> are looking for.

1. Nobody is talking about using this in production. RV was proposed as
a testing tool in this project.
2. John is talking about the rtapp RV monitor when talking about
overhead in his talk not about RV in general. Are you mixing these two
up?
3. The improvements that have been merged into RV between 7.2 and 7.3
are not measurable in my setups. Having a more sophisticated HA monitor
in 7.2 enabled adds about 1us of overhead in my tests. That is not
"unusable" from my point of view.

For reference. These are my numbers of last Friday when evaluating
the matrix test and trap monitor on the visionfive2 10 minutes each
measured with latmus in us.
┌───────────────────────────────┬─────────┬──────┬──────┐
│           Scenario            │ Monitor │ avg  │ max  │
├───────────────────────────────┼─────────┼──────┼──────┤
│ baseline                      │ off     │ 0.27 │ 47.8 │
├───────────────────────────────┼─────────┼──────┼──────┤
│ baseline                      │ on      │ 0.85 │ 46.1 │
├───────────────────────────────┼─────────┼──────┼──────┤
│ matrix without kprobes, CPU 2 │ off     │ 5.83 │ 51.9 │
├───────────────────────────────┼─────────┼──────┼──────┤
│ matrix without kprobes, CPU 2 │ on      │ 6.94 │ 51.8 │
├───────────────────────────────┼─────────┼──────┼──────┤
│ full matrix, CPU 3            │ off     │ 0.34 │ 48.1 │
├───────────────────────────────┼─────────┼──────┼──────┤
│ full matrix, CPU 3            │ on      │ 1.04 │ 49.1 │
└───────────────────────────────┴─────────┴──────┴──────┘
