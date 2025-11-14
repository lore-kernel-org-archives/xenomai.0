Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F91A9F90
	for <xenomai@lists.linux.dev>; Fri, 14 Nov 2025 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103336; cv=fail; b=IzXWRzAIGPOVDnT/NS4s3S2dB1D5DdomQgtgliiNu1hsKWG67L80GH+LH+BHU5jQsZh4KIY9Rb7H5daF3OaM0PZYswhbDIECFXRxCGQx8WZjTff7R65YVrlwWEXgRhitNtCkuXaB74j8klkVzbt1ep5St2M009Tc+NrQp2jRX+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103336; c=relaxed/simple;
	bh=1A+mW5KKG3r5dveFnB4MHzwSeUPKYhxRg+NiycUA6gM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MY0IOYjCRwplRxQ1dMHdQHu366k85+NmjHwMxmmPVITKPnizYnSYd8DGZSYWM2jqcpSEAS5VuYw3qGSk0Q5Bcp3ojBoksSolFPf3cLQM0Mkgyzq1WKlLri7dL2h2D7iN9FM6551NzD4jX5P96zBHPRLE5BxEfBtrhPhFIdySThk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GFc/8MQA; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GFc/8MQA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4HfVlyLbNCkJOd5oJa8hcwPKvm9yr3ypS5sCmGkrfakBmp3HtusyeWFHbxSMZ+xUDwvXl0EeAvipdS/M/0HMXr1XoYlpqRrIAz08ZzMqRLBIYtL/37kzdE36djpGG1CWavnt2eGVbsgyvqkk4CEj6HyYJErVFXbJ3RxSSUvZ1XO6eSwWFLT7Uf08Dwi8xYuQwAZH+g+5hZ+7Xp6xDFQ6MZsbjyxRDA+9MNhV/DOzeoJu5lScOHop4ZSY0Fca3Xl9nDOaxsyTQHJbJANfngWEXcdWhY9ronZq2+Cpmw32RZO+A8CdY68H/563zsiQptRb6Rx4t/tCq6+A5EZysuwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hqaOijr3RK1ToT/p2X/KZ5Ns0sQWwLvBv99BKNWLo0=;
 b=GCtwfsWSPCwykOIz7IKs3Nky4RWrnIv/Upo4+ugcr0ehALQimSoGiejBnoXCQrqkkmVR0CVQu8tZiZnYHtlPN6liKjtoWXhQms+DfuQQQZ+FI8cf5cvR8Bm4x890adjgoDLeqxHD3Wr1wb6zJbktxgGXnDak7kew8LAmGqLbSUP5SP8/Z3egktD/D0sLVRg+3OEGkba5k36D7N/+kRPqgns9m2bwBj3RwQajk1dsGcQNoBUjfx4QEE1l2GU57jEEyJ2FB/uuCzdYJWv12YmlZ+mQY6oQBZDr6bv+zzcqkjCGA21h00GuYMHWrHHPiyJNufBliY+9M7XWydhnzAPTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hqaOijr3RK1ToT/p2X/KZ5Ns0sQWwLvBv99BKNWLo0=;
 b=GFc/8MQA6bNRBkHXtVuyW7fvCASKQVn5PzQWbwbsQlaw0Xfg345PDBHoqvW5cGjSn6yPHugvZ0x4RwTPN1c6DzxR1h3hh0nJWK83ygOSljSwJaebEQxxvnK8UOB5jKFy8jdskJvurUu0wZseMVUPMNXVHw7vUwJeI4ed4xv4WLX7sl9nPB20UHt2sHx8sS0CbvXiLm066pMGNspKuEjvfvlTUfWqdoxyCBIBoOPFcPsD06BDXz3+dpeHhDNWvBaJ6A6OgKgqkUhihMVdOY3uE9GFjCTe/ENra68W7ZxT2ANxXYmXUGTdfrjSLoPJ3AGR4fpZI/u/RYPAoYeC0YpJPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:55:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:55:30 +0000
Message-ID: <79e2290f-5e86-43c4-9acf-c658a12f7944@siemens.com>
Date: Fri, 14 Nov 2025 07:55:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: DENX is shutting down
To: Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0vT7a_qcGQwfuFUibL+eSv8uktTFNAz+uQB+UO0HkvKrQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0vT7a_qcGQwfuFUibL+eSv8uktTFNAz+uQB+UO0HkvKrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0133.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: f758e384-5d22-4ca7-3fb5-08de234acce3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elFDMXFBcjlKVE1WRkdVWXQ4ejFyV29JbWdDZUE0UG16UHpYNDJQWXFiTzNv?=
 =?utf-8?B?TEdJcWFPZVlBQ05xaUVGN3lxMmZRY1F3ZXJtSnBSNEJSZ09WQTZ3NlFLdjVn?=
 =?utf-8?B?V2JYdUNLRVpjUmxqelMrWFcxckNSalp3UzIzT2pzWC9ROTZCNzljUFJmekZL?=
 =?utf-8?B?eU5QVUVXaG0vaENrUVE1Q1ZOZklpdFY3ODdoWFNodnZCdUQ0S2ZKYnNPTXZq?=
 =?utf-8?B?bVkzL0hWUnl6WkhVRUQ0SEhkazh0YWUzd3UxNEpSMDVHdkhydy8vbndxSzBV?=
 =?utf-8?B?OHFjSWhOVWVSakhHYmFadmJVV3Bab3JZNkNQcjZZbnVJTWVNOURCQXJvdEJF?=
 =?utf-8?B?MFJBL09ZYTc2VVhvbVJOcURLRU9DekJOYkV6SWtGR3NjZHpvOStzTkJ6M1B2?=
 =?utf-8?B?cE9DMUxLSitISWZmWW43a2I1ZEdKZGVJT2Fmb0t4SUJFcHh1QTEzSjYwUzA4?=
 =?utf-8?B?c1JxMTQ4WFFMWFcxUm1QTDdZQnZ5K2pCaU5zNkJreDYzVEVzaFpMYzBqa1NF?=
 =?utf-8?B?RStrSGE2bU9SNXo3bHRyVFgzakdPc1FkNTRBZGdLNlVzVWVPVlhkNTJkK01S?=
 =?utf-8?B?ZGV1aGJRdi9Ea2gwUEN1ZVFUNXVYOEJrR1pJdjFGNkVvTjhsdzNJSVBraE1p?=
 =?utf-8?B?TU84NVNKZzc2RVlLQ1RYQXhveG1sNUFib3lpV2tsSFZiaXhKZUgrMlNQSEM2?=
 =?utf-8?B?U2JuMXBnWW4zbmlucnl0S1Q3YjIzS0xmTDkvSzFJY1grVFFUdWZrYW5IT09h?=
 =?utf-8?B?RURzZkRPUWJtZE4vUUVWYlRhY3NOYkxVaTIxVHNvV0VoQkM1cjlTUlVmSGcx?=
 =?utf-8?B?Y2NiVmR6NE1ucExqMGZUZThiL3lnSHZ6dGtNUm1wL2dMUXJyaEhVY0hsS3Rk?=
 =?utf-8?B?UkF1N0JLVkZiaTU1UVdmLzZMVGtId21sVzEvWC8rL3NtRnpzV1UyazNZUUJw?=
 =?utf-8?B?OGh1WVBOQWNtQVJNSC9TR2FBWTVkRndoZytqRVRmeUg3UXU2Vk9ERG9wY0F0?=
 =?utf-8?B?R1FGcUtnK0V0cms2THF4cTFacTQzWVJxaFE5VSs0UzVsalNhSkdmQUZlWTF1?=
 =?utf-8?B?Mnk4L0NyYU41MTgzT0xnRE5yTGN1UnpwWUx6UnhvSGxuQUJmbnZsbDllQ3pK?=
 =?utf-8?B?N1hpRTVRSndJSXdYWjZxMmt6VlRxbjJnNTA1WnJyUEhia1BBclR4Yy9OWUZY?=
 =?utf-8?B?OGZnNGUwbHR3MWtmZFhiZ2hCRWlVT1FoWWEwTFN6RGRhY0x2aE9BQW5ORnFS?=
 =?utf-8?B?ckU1bDYzOEc5V3kzcHpBUzJ3MlBta3JTUGZtbTE4d1YwVnRMUlpJZlJIalZR?=
 =?utf-8?B?TWlGazUyczM3bkR1VHdibGlUSFJoK0FXeDJyZDRnMGhOeldEeVA3RmJkb0dl?=
 =?utf-8?B?WjdwTHdrMzh1aE93OEZuQlZ2REdaRVdMUEZpUTRDeWFVKy8waW51UzRVSzc0?=
 =?utf-8?B?QkxoUEtVZ0tWQm9WV21jMW9tZGNSU2ExK3BLRDNWYllxTHBRSGRwT2R0Ym9r?=
 =?utf-8?B?QUVMTnJ2TTQvVksvWlE4L2s4MXRveE5GeERRVHMzcFRzbC9ud2VMcEx6TmZj?=
 =?utf-8?B?bkViN1EyY0dWdXgyMU1HTG5QMkRHeXkyUHZUaktjcS9xbHVIL1JreWtnR2dK?=
 =?utf-8?B?UkdnaUtlTkk4WUt5V3FaWXQxVXVqL21NS1M5SVBUSXplVFhOblpkT2FXQ2s4?=
 =?utf-8?B?QkRTVVpnckJFWXJCNWVWL3RPbUZscVZEUGxtOE5SREpGMzdnS2xFcEVJUDI5?=
 =?utf-8?B?MEJtMTlhZUpPSHR2U3JMSVhpUzhpaFppUHRYYlltdWx4UHhOMlJNYnlJWDBB?=
 =?utf-8?B?MWJrZXRibnJZWi9LbTRaanRwUldzanlZVjlCd1FBL21QcGFJdjY2MjAwbDlh?=
 =?utf-8?B?WTZWakNkZHUycXpjS1lOWnpVQ0tCbkEyakwxUXhPTUZDemc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UENhRFhKeW9wTG5RYzFMVHltTFpSVTJoN0t4dG9IZVkvZ1J0QitWemlVNnh5?=
 =?utf-8?B?K2l0ZFBtSHlsOXBHR09aQ0N0cTkwZHVaSG1CVitXanFia04vTmZLNGQrczNs?=
 =?utf-8?B?bjlJMlAxQWh2ay9nZ3VUS2Nqdkl3Zm1YcGhaTkprVzBwemRpKzIzTEZ4bmFO?=
 =?utf-8?B?UzBGOEFheWN6R2hXOHVUQ0FUWHRhM0ZxMEZhTDk5OEFLcG03RDJCVHVlMi9S?=
 =?utf-8?B?dit2QXEwalVQclBlR084ckZTVFNPYml4Tm5hRUJzRS9RZzJNWWFQUE44aGhL?=
 =?utf-8?B?UisxR21rbXB2TFMyWGN6N0NkOGNLZldNeXdZOVBOTVNaNHhTTlF6YU9zRDdX?=
 =?utf-8?B?cmp3RnpUTDlvUDQ2MHJnVTZhMWpMdDhLMmtnVmxwV0VpYlQwblFTcG5WUW9v?=
 =?utf-8?B?V3kvaGlNN215YWMyMkdYWDR0dllPK3JydWJ5S1JzNGUwL3Y0MnlXUHlFNlp1?=
 =?utf-8?B?L1o3Z3Z0b0x2Ym1OdGZ5TkRXeUZqYXNJbjNEZm8ybUFlSW5yY2wrMForK1U2?=
 =?utf-8?B?N3Z5VWZJdjBEQllIZmNYSnNBOHpIY1JDOHAwN1hPcDdrVU9KOHVXL2IrZERB?=
 =?utf-8?B?MnF0UXFYZkQ1QkdRVS95d0gvQUN5OVovVjIwSy9JV1ZNUWhHdDR1ejFiei9C?=
 =?utf-8?B?T2hua2lXWUxyV3pYT2RDZ1BReEc4ZkNJR1J4R3pUMVhtUTAwWGFWcnZ6d1FX?=
 =?utf-8?B?L1ZvcVVZNGIxNGNheHp5RjFFbmJRcDlHMnZrVWRQRFBkalRFVi9zbzRQbU1U?=
 =?utf-8?B?VFY5eGQ2VFVrM2lyVTlxU3hpejVmU1ZOWmZoLzZPMTIrZ3JLRFEva24rdHFU?=
 =?utf-8?B?U0llWFdKNmt4TnJRZTVNdDVLUEtvdExodFZoMEpIdTJqTDI5Z2RIcmxlRU94?=
 =?utf-8?B?K2tod1Z2b2FhdXc5K1ZZdnpXYkgzNjRwRWYzblFITDZOZGVjTEFXNm91WGpO?=
 =?utf-8?B?SjJjMkwxTjlKRE5FZFd2cVhBMHh1YXpTNXdsOC9iVzlRUEROcEZ6SkpPOURD?=
 =?utf-8?B?bHg0TDNSOFR2ZHNDdXFCOEVFSWJKSzh2cFBwaG9IM3Z2YzdZOHRmZ1Rwckdq?=
 =?utf-8?B?d1lhWU1YTWx1VVBnK1J3SmlrTk51NU1sWDlwZlpEWUd0TEc2T1NkNE5yeElY?=
 =?utf-8?B?bFRXREFDczZzRi8rQnJ6Z1lIS0YySzU2Sy9iYzZrV0pPK1EvYjVtYk45R3VW?=
 =?utf-8?B?bmQ0Sk1YRU1lblVMMEpDSjk3RTFoMWtrOGEzeG5TMDBtbTZlUmpQUHpMVWNE?=
 =?utf-8?B?eHBCK054T09xSURHRXFBWENraXNQK1g2c3Z6QzNjV2JpbkRUQWh3K0s3MWpk?=
 =?utf-8?B?OEZxaEN4OFpsb0ZUNjMyZTdkanVBZ1phWVBocTdOOG91UEdycVoxWW8vMmpG?=
 =?utf-8?B?b1lQVkRuSjdUK1YzS3dES0cxcGRwS0ZkcGp4aTM0UEdMOFhyWFE5MjNXYnVS?=
 =?utf-8?B?TXk5eTJwc0JTSnlNbmI4VnB5SXliWkxUK0gvc2czRDNNcmYyTXRRYitxYm56?=
 =?utf-8?B?Q3ZjRnhHbEZjckpJTkNkVHFBcGYyY3hyaDR4UzAvWWZoT3BIc25FR0g5STBF?=
 =?utf-8?B?WUo4YkxQNXdlRUZiQm1SNXBibzFhOVhzbjM2UWExbjRsakpvb0xEejRTTHEw?=
 =?utf-8?B?aTY3Ly9IN3UxQkhUUEhaNTIrOGMxS2Z2N2gxOGZoOXBOUnc3U2hhREpQL3ZH?=
 =?utf-8?B?QmJ3alRMcE9mMmRNMDVyN2puVzAyN21IeVdIRkVLL2M0ZHR4OU4xZGZVSlJz?=
 =?utf-8?B?NGI2YklDUlNndFZiL01OMlltQmZHem9yQjVXMy9XL2wyQnlBa09UWm9ac0xS?=
 =?utf-8?B?c2ZvVE5VOXFiZ1RnZWZ4YlFqRjBqbUZ3T3UxYS9XRFpCRk1TQmllZUdDdXlV?=
 =?utf-8?B?ZytLNmVPaXJ0WnZZbS9YQmVWU1R3RktXUmsveWREcmoxWXZyYVgxUHh2d2M2?=
 =?utf-8?B?c2JtaWM0RTU5bFh0QnhCT0FyeWIrWHltRjVyd3pqRDZRMVRYMkEwbGtWMlpi?=
 =?utf-8?B?eW5VL3BMMmF6TUF0WlA5VWYxT2xNZWtFS0pTV05UZkJoazFxdmtOUkZqaXJY?=
 =?utf-8?B?R1hGempTTDVCNmNJczl2cDZxYzJXYzd2VUZOYXVNQ282QkVjTnJqSXBDWjlC?=
 =?utf-8?Q?TbymnQtOP86grB2x2mz6GfUbo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f758e384-5d22-4ca7-3fb5-08de234acce3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:55:30.7335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkeLytTNEuh/LEotdUJwb3shpnN7Hjn7UpDJpgq9UFhX9HOLGTaDnEpYi6APhiXNiAUiz/TSpHk+nR/ZK8sOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6524

On 14.11.25 07:46, Pierre FICHEUX wrote:
> Hi,
> 
> I think you're aware of this, but just in case:
> 
> https://www.denx.de/
> 
> 

Yes, that's why we are on gitlab.com since August.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
