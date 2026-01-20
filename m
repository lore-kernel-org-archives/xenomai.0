Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7F2F6905
	for <xenomai@lists.linux.dev>; Tue, 20 Jan 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906847; cv=fail; b=CfblAuWuuDIZ3OeBXOO/thTo0gGBevZDDgiDVyjDisP39/k6rtyDjJHBm1oc3jsI6/yIHgg9PBKIzpKawL8JTs043AV0I+4wedgVccCrSJvGGcFFB3EPY9X9g9rYWrdy+OZBGuqmXaFst4evbBBn/1sWUsb7Xpxuw6cCyzoReBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906847; c=relaxed/simple;
	bh=kA4AE/UL7EZaJXOPaMwKyENNRTlBcCRRnbvu35fdUMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ix5SiQsWCsunOud4U4d9GPYJoHFRbjOQAbiQqIoc53169DQOFXEd27MvV2WURpLyO5DvXVJjYDWkWHw0e8mZTmX+DAtyMPQDDrwUuoyLrdGd5H/70MCms7ur/01rsLb6Qhe8elaOVkI5Ofcw/qr0vZe9he21hvX+w5Q938Pey8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LamhOpd3; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LamhOpd3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdzdlOTYWTHn/vm7NfY5KX3fEy4TLwTlB34XfAFyROzUA9pmokH+JQZrvQXPG9MlphZddgC1ha0GOC5NRDKNR1ZIblxAxQ56jjmOkGEBlYKoY8DUjjeYmv7v3aA3WUiQigQ6WTCMA0EKdK0PD0+/X+o3t9CZjYCHYCvhDqLzeHjoifzpr/8I+RSwYaaELQDWTpLxZ2ma0REd5dLUGNBrGtAPoxCpRDTIfQmhp7HHjNtSuxNY3R74weCVbZM31TymHdtPGoj1PlPlspNluIAI+ml7MCb6gaMpOeI9n3OT/B0+Tw4maU2RmoPkfXwdPTGSf4UPWFMaiVhCMAGLVEDe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEBOfYpPw5tqn7SORnrkn3ga9laF4x0twu+1v1Uc37Y=;
 b=HgqBgP4Jj2GYCzoMi/keQSU7l5rdJmdX/AVpR0bXNqPijoK6X9VcBQ1cW3JmEJkp1yD/3mnkZ6KelK/ox3XgK8TaT6bcbZAoS+kfom4LZFPUDSsWjCM13p/l3HASBGJC0+RooFBFl8DyG8eCPzyvmpYxyn0eRWaj5c33KSuRYm3cLM0ZPpxXSjE3OjGKTP/JiMiV0N7QGZXow/1ycQXFeUGfLlLp9oGXBvkwu3a3CcTjGCPAKFgBtiaEGaD9wnrrFNnVFmiTF67aabOarn4/ORxCPOdfa/AMJK/ZnUHYbHL3z0niOzayRuCKVtT9nLmZ6u2SyLHo0yIMAvWFUW2EjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEBOfYpPw5tqn7SORnrkn3ga9laF4x0twu+1v1Uc37Y=;
 b=LamhOpd3JtbaO1iyG4wOocaUC76EXsg/wDMjHseDna0dFZKROWHLCKCFqHQDRU6FUnxnPx259cUxViIwPrnowtdfadyULDtvwTn82iOoteXmgXnSfIlZjbwL2sA7O0br57Z19lkCOgtILwy/z13Daxijh1JXjc60AXDI6Wo7+iEjt/0AyLSCcxhKYKibSynTCEWj1lh2jD2sZOk6ix705BZ3szr/jAogq3sarz+oiYRyU8WhFFs204Ou+e8bI86PvbfjHtgY8gyKSVBq0DZnzcl0bK7k90U5Jr+mx2ty4BwCR/aVYABpMDpy2zBA+Nf5X6uodvClPXqNdW/TrtgHPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9359.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 11:00:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 11:00:41 +0000
Message-ID: <bc7dc483-7bed-47f8-9d3a-944ede42a2bd@siemens.com>
Date: Tue, 20 Jan 2026 12:00:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: Fix upload to aws for builds with no
 initrd
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20260119102227.1149887-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260119102227.1149887-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d6aefe-082c-4442-16d3-08de58132691
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHptc1lCTjQ4UG5pVUxpY1VhNFBocm05S3RIMEZpVjRsSUU1L0hEcXhiTUx3?=
 =?utf-8?B?alBlV3A0M0hUNkMycExZRWNUTVJ1cjBsRGhva0JLeWlzV0I2NGtWWUU3b3RC?=
 =?utf-8?B?UDZpTFhOZXBGNWIxWHNSclloY3NxdHJ3UGhOWUdZM0l3dTBmTWFkd1hhdGcr?=
 =?utf-8?B?RktrN2lBdGswN2ZjMm5WcGZYNitIWmUvKzc4OHkzeWkvbTZMRVNLYVNVY2xJ?=
 =?utf-8?B?bnArSVZaM0RjZUMrVVZ6WW01Yk9BdXYwdkRUWHA1ZDhIMHBXUU1lakJkYi8w?=
 =?utf-8?B?L2RKaVVhM3dxckpuTWRuMnoxOHppeStEaFNRR0NpS2t4M0F2RWRBVis5RGdG?=
 =?utf-8?B?elNZc3JrWXFXbndxR0VTQlcvOEhFb0tsSzNweDRyeTczaXgzRHkxSXBBY0du?=
 =?utf-8?B?LzNIT3pzTGJ2eG5ELzBZOWVzS0JLR3kvd0lpdjE5VEMvK0VDR3pXb2VDbnZG?=
 =?utf-8?B?WjNXUFZvZFJIMnRtd05mRURQSm1MRlZqYXFLS2w4L3J4eWgzd0hZUG9jQTJV?=
 =?utf-8?B?Um8xaVZwd0hDRktjSFBpcWxXeXFLRVRiTDhKZklVcTNTTlRNVEk4MDd1QXlm?=
 =?utf-8?B?bUM1ZUluaFM0L3JDWnNlVDVvRTMzSkQ1bVRDQkJUMWNQaGVQNnVSV1kvTFpk?=
 =?utf-8?B?SDhrRGltZlkxTUIzNW56VkVvNHljRHROcG9CcW03YXRBdHlkWU9BYitSbzJn?=
 =?utf-8?B?Z1ZMeWoxS3dQdkpXd05GLzZLVVhGM2x4Q0tNeXowdkZEc3J1aFlGejJFTExv?=
 =?utf-8?B?SmNlVlQ1WHhHd0tJWmRyMzBwZXUwSnZpSGVqbkltVktaUW9YR2s4SENoVjVS?=
 =?utf-8?B?ZUNSSHVwK0ZDczZ4b0lXdU92YmpFUXpJWjdZeWxoc2trNEt6ZHJpVzloRVdJ?=
 =?utf-8?B?eHFXNHVMemVOTzk0Z29TWjRueVBlZU5XNnN6anM3Y2RnR1hCdWFFNkkrdCtK?=
 =?utf-8?B?cExCOURsN0lYdm4vL2htRXVuU3dQcUdSQ0RBSmlUa2dDVEFZSVFyUGJLZDUv?=
 =?utf-8?B?Zjd4Q05xcFl1aFRhVVBJb2VSM2p6ejE0SzZPRXc1MnRwMEF1OC9QVW5IN1FJ?=
 =?utf-8?B?Y0k0VHdOS2pSSUs5Y0JSZ0FCMXN0bHg5Nk1pV2g0d05UVFZWYi9sS28zVitR?=
 =?utf-8?B?d1JOQUtnaTZVSnhqejRwUVA3RUovd1NhOXcydFVYMDdmaE03NEZ1ZTZ4b3M2?=
 =?utf-8?B?TDdLejl2WmRnSmMwR1ErTzI4Wk9qSFhpR2NIR3lpaUpQNkdiZW1wRTRWeUhV?=
 =?utf-8?B?YXhnWlBua1JDMVpKNVNDOUFDVXhZTWtZbVNLY044WStCWjh6blhpdm9XaFow?=
 =?utf-8?B?dVdJUWprRUVHTEtROGhoUU5jV01JeVZOQTNrUlozaURyZjF0QXQ0NWpmcklV?=
 =?utf-8?B?RHdxY2ttQmNNb3pmdnJVL3l0ZHhCaE11dXFSS1FTenJPUVp4cFYwdnZBUHNW?=
 =?utf-8?B?c3FpMkFYR2s4TVo2ZkNhYzZYcjU5WjdrYldGWTdyVHFaYzNkR2Z2aXlReWh1?=
 =?utf-8?B?K2Y4MjVIUEk3Yjd6UjRYcGVtY2pUYXl1bDBSUlNjOGhET2g4RUNXTjZ5ckdL?=
 =?utf-8?B?R2ZMT2VFOG5lS1NTc29oMmV0SjI3cHcvMm9iRUR1S3IxbEFqR20xYkZiN3Jt?=
 =?utf-8?B?Qy9PbDhXUldRWEpsa2dxMldrdll2WDVWVmRpRHh6MndmUGhRVnhvQVRlS2ls?=
 =?utf-8?B?VWFEdXNRY0t0Ri85eDZreSsrUlZWZGlQbnlHbUt1Tm01V3haa3pvYU13YzUy?=
 =?utf-8?B?WFU3UWVkWTJyRElXcU9CUlNBdU8xd3IvM0RPempiY1ArWk1Ga3Z6aGk5eDl2?=
 =?utf-8?B?VHFjM3pObmtRdk9pVWRqak5hdWtDUy9uTjNYYzNnYlpnbERlQnNCSWJUT3Nv?=
 =?utf-8?B?UnhIb3puaCsyVXRJL1p2MjZ5MDhudjZRbUZTR3ZPczZDM3YySlMvUk5JalM3?=
 =?utf-8?B?RWZodmxWdHRYSUU1bnlGZ3B6SGcwcTA1Q2Q1WjBCVktXcGxuNzR5VnVDd0FI?=
 =?utf-8?B?WWhTWWRlVVI4MUZYZThnaDlLaHVueXZVWVZYMUxCMTN5RWQ3aXczdkdZWThx?=
 =?utf-8?B?YXJNM2V0aXg3bVVIbE9DOVNqcXhabllMelJIaGJuZ0VuYmMyaXN6d1JuZG15?=
 =?utf-8?Q?kPIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEwzRTJBOUNQVHY3U0x4WExHVEJUdWtMeDJ4NHNSQ0tram5ldUxFN2ZXcnhC?=
 =?utf-8?B?OWQ3NTgwZmh2R3Q2Z0p5bi9BbnhmbXdCMElOM0NieVE1ZUlMUERWWGM2Njhy?=
 =?utf-8?B?dnAzNjRjNVNyaVJwY0FmNFZ3T0Fla3ZUZ0NIQmlXVGwyRU5CT1BSdllGWXFU?=
 =?utf-8?B?Sms1RWZMekhqMWNReWtJMlJlQ05tTWptYWRveE14Z1czT2I3UWNHLzhVRzYw?=
 =?utf-8?B?WXlodHZhQnNQU2NKNFRqRWhab0RNV3BtaFFQdXJHRDduaTk2VDBrRW9Qdkp6?=
 =?utf-8?B?SWNqcGRCajFCaUc2U29kR09HNnlReklOV3pXblMvWHhGQU9kL2VxZi9MaHJX?=
 =?utf-8?B?TXcvUTF3QjU0NDl0cVRGR09pNitaMWNEeWQyaGZ6RGlvZUNqTjFEYkJ0SzI0?=
 =?utf-8?B?ZTVVNTFPL1AzY0NXK01LOHVQSnE1eXNVTS9UUUd4WjB3ZzlXdXFvODdSZ3Bx?=
 =?utf-8?B?K09nd3RXNXdrRXpDNGEwdS95UHJ0Nm56TE1TWHIxRHZPZEIxaU9JV3dPUXkw?=
 =?utf-8?B?aFNwa1orQlRqOVZrWkE4YkMyOGRMQlowKzB3NmJyb3ZZb0lONTlSV0Q1cHpo?=
 =?utf-8?B?dEVWQ3k0L1drc01WT0xvRXc5a1VrdkNUeUdFa3hCNlFUcXBkdHNsV09NSHND?=
 =?utf-8?B?ZFRpL0FYd1RnK2hoQjBMVEJ3TEhHMnVPQzRZaUtjNTJ4VzkrTjUvYXZiRFY4?=
 =?utf-8?B?cGJjUU9mcENFVXRCQUR1RGd4ZVdSbEQ0dSsrd1owZWdQMFN3MkplekhFRERk?=
 =?utf-8?B?SURvVzhtUmlhd2sydDhxb0QxTm95elA0WlFiL0UxMHBpRGpmUjFhT0xHUy9Y?=
 =?utf-8?B?Y0xadk0rTWVvQmJ1M3JpQzNrTllmSWlKcEo2dlhDWFhuM0tGMTZrUTBJVmM2?=
 =?utf-8?B?c0JDZGJhWDRLOWpUMVFPTm1vNDkyQUNoRmJoY1hpeXMvT0ZkSUlIK09EQTR0?=
 =?utf-8?B?Skc5MHN2VDg5eE1xbUROZ3JHRmU1c0U2QlVaeGFOaHBKeUJSNXBld3c3TERm?=
 =?utf-8?B?b2NmRENZMFpFSE1mQm9VcW1xdS9udTZkekFlVmg5MURKZ1lRWmM0RG9hdm5T?=
 =?utf-8?B?RDZVeTNXWVZBcWFENnJUZTYyNWdycG0wbjZWclc2RFRzbVFnT2lZZXNzWWhF?=
 =?utf-8?B?cjBxak94WHpCL0V0SHBsaHlTU1phWXlkUkhLSnJXK1oweEsrajNLTmR1ZEZG?=
 =?utf-8?B?N1lPUmNQYmc0NkdlcE1GLzk4YmZEa280c3JCNEYrbnUyMC9RMWJTUXhpMVd1?=
 =?utf-8?B?Mmd5N0pmZ09sTy9ETUUxdFpoTXEyMmdmZjYrSFhtYXlCQU8wZ01pdFhaYjB0?=
 =?utf-8?B?UFlXRFhKUXV1dVEycG5senJ0RXU3Q1hENzM5WTc4eDh0MEsyQ0gzSk1vZmdh?=
 =?utf-8?B?MWY3Uk1SWGlwVzFrbFhMUmtIN0o0cm84eTRGejByVm5Yd21HN2hPQWI4dHI4?=
 =?utf-8?B?ZzZUNThINEYwZWw4ZGtKZW5nZmpSaU9saTdWODBFejY2b2tBYnJrWnBEbVNv?=
 =?utf-8?B?S2gvNFkzZnBYQmQzQmhuc1UzSVhOeWFjMUpCRk40S2VCRHJoR3Zsb0tFT3lS?=
 =?utf-8?B?MHhNMG8xc0taTFRQVWxnNUU3MTF6YVBwVEFUVFlQaktIajdmU0tzelY5VlZY?=
 =?utf-8?B?Z3NHbHU0WVJ2dVJjVlNqNzB6WVBKSmEzbGw2YVFzazBuZWtCLzJWK2t6aUNJ?=
 =?utf-8?B?cGNEMFNRRk1rbUtsdHlvSlZKN1grVzJsbk5XOTdLL1A3MERsZzV3M1hNWFlN?=
 =?utf-8?B?SHpQd0RlRmduT2QxMGs1cjgwTnlwbnVTcVZjbVpmRm1vQkt5N0lqMWUzbHJH?=
 =?utf-8?B?aWRoeFUwU3U4MGhtTWtXVUxTVko4UHUrY1IvRVNSOWlrcnJzeFlzdXM3MGhi?=
 =?utf-8?B?WVhCM2UxNXh6UWRxdG9kMk9uMjZYM3Z0YXVrbWRxTzRPUnpKWHExYTVxSDdY?=
 =?utf-8?B?ekx0aGFSNmFWbnprcjRDT3JCZVpwdUwvcVVFTEtMdGNKUGYybWdFamYrdWl2?=
 =?utf-8?B?aHdFakpwYjJPT1ZWWXZLOUJUZ0Zsd2gzODRZTlVRVUdXa1ZzZzhObUpXQkc4?=
 =?utf-8?B?R1ZuVkJOc2UzemIrVDNkQjYvNm1vdTQxSHhPUnZNVGh2VXNKbitaTGg4NnJE?=
 =?utf-8?B?Uys1bFkzUmJwdi8ySHp5RkJCZ0kwNWgvU0JrUEtEZDFJSlNIRzRiU2V6L0p0?=
 =?utf-8?B?Z3hCaVIwcnlDN0wwSnRiS0Q2ajgwd1JFTTZrUmpnOEg3aHlRK2JDb0xYaUwx?=
 =?utf-8?B?bWQ0NHFZdVNXb3oyZk8yY2hWOEhxenRMd2ZObGUwREl4WE1rR3cyTlFJMDdx?=
 =?utf-8?B?Nzh1RkhRL0x6bFBjYVhsa0RXSXNXVzhHZ2dGdFpERFFjS3VFMStxVGNlNEdF?=
 =?utf-8?Q?+KRIIB358eq0M9LI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d6aefe-082c-4442-16d3-08de58132691
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:00:41.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV9v2iM8p0ukEgJMQlDKDOouTmRloF3qmTPmTYRqbfFB6OMvulxipNgzhbmgR1esn4aMlDwY+b2MiAakz6s/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9359

On 19.01.26 11:22, Florian Bezdeka wrote:
> Depending on kernel configuration and cache state it might happen that
> the initrd is not being rebuild. In that case we crashed inside the
> upload script and failed the build / test.
> 
> Checking for the existence of an initrd fixes this problem.
> 
> Suggested-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  scripts/deploy_to_aws.sh | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
> index c555a2c..2e0ee41 100755
> --- a/scripts/deploy_to_aws.sh
> +++ b/scripts/deploy_to_aws.sh
> @@ -3,7 +3,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2019-2021
> +# Copyright (c) Siemens AG, 2019-2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -36,16 +36,22 @@ if [ ! -f "${kernel}" ]; then
>      kernel_suffix="vmlinux"
>  fi
>  
> -#KERNEL
> +# KERNEL
>  aws s3 cp "${kernel}" "${deploy_dir}/${isar_base_name}-${kernel_suffix}"
> +
>  # INITRD
> -aws s3 cp "${images_dir}/${target}/${isar_base_name}-initrd.img" "${deploy_dir}/${isar_base_name}-initrd.img"
> +initrd="${images_dir}/${target}/${isar_base_name}-initrd.img"
> +if [ -f "${initrd}" ]; then
> +    aws s3 cp "${initrd}" "${deploy_dir}/${isar_base_name}-initrd.img"
> +fi
> +
>  # ROOTFS
>  if ! ls "${images_dir}/${target}/${isar_base_name}".*.gz ; then
>      gzip "${images_dir}/${target}/${isar_base_name}.*"
>  fi
>  image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
>  aws s3 cp "${image}" "${deploy_dir}/$(basename "${image}")"
> +
>  # DTB
>  dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
>  if [ -n "${dtb}" ] ; then

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
