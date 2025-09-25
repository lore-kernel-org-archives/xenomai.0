Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938815B135
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804039; cv=fail; b=GZcblzE1MNjBYsDvmz37F0BMM5A5wDcEZgWSuuQpMRNB1IsyziBTFLXlPqtkc8x1DW8kbcz2K52Cgxd07lYTJgenkWk2FFDEp5yLtbToan+NOZ1ikCfZmezw1qLesMussCNM99nfpW7ixcvQI8u0Bpd9KVnA+pd8+GhTmm0r/SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804039; c=relaxed/simple;
	bh=DgWvBv89QcnrsBBfYssqzl6FNksAOFlMKwwEKusGAQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kamt4LI28KJNZlqK53uSHLtKjqmtnvWpVsZe2w5F//FQCO38BNk1bH5s/vz3N9lra8g3h2j+OIpxSel+1WNKgKR9EhexGgT1LBkSKkP59nf7Yeg3/ppo2DkiGYI/dAvVJPshD2FPBG9R6XmuUwpCfuG4Du2iW4K9h++4COHDCg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fFx9M8Os; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fFx9M8Os"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id C945343539
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 12:40:35 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id BDB35D808CC;
	Thu, 25 Sep 2025 12:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arDXtwqpMPBvvvgmDZHic98ZLMJAcCJQZPnh5HA6PVeCWnEwadp5W+vQu77/oNL3KOysKfR3fINrA4pGEZGwePTvyk9VBhZywmA3VqiD0bYOzg6kuq1FO3FQcOzdNiULqP6tx4E2S4Q/lxL7IInFou2jMSkRF9WiecstoH0VxaJTFQKYqEmuCMuCyFt+A3kYBg2fKur7lYG8e9r1TST2qQ91aAm4ZXenqJAOgMDpqoMK4bZizIaLQ5CB8Ch14e0ClplOoGmAfqbxH9Ehg+n6Pi0wffqWRxT5OAfFn8TT5q836sGD92aJWTlSl2eyjhEDh6N+TanY6+6Q1oFsp+6rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z8yTIKun7aF0vqFYcm3qg2HkVNf/38fqULD4D/R3ps=;
 b=M+SC+jv3+2YsOTucgdiHwNtBC+ZMahLim5LpYneIH5mkZj011hs39FwP8eRhjIp9H4v4CSJyVQCch9+AHv9XDUwAzrcYr263FNJlTrUVGNHHismlMdnMYETM/g5yLh7+u9fpZOJYWDvCoB7FQwQcDofTbWQxJgqizz6/O1JVq/9X8e04VkLEzEdQk1u9NpUvqFndQoi8nS9ATQrWwtXMX8m7Vf1/mAh1uQ7J7N9TjIee45ZbnVyNwaHcmhtiv5kWQ5abhNhncCjKkv1RvyunjA7UlYuuHpdsFSOepmoXYKjUZNnHvRVjnnUQ4cXE1ZkhSrZkDPc9l1b8Rd3foR+hYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z8yTIKun7aF0vqFYcm3qg2HkVNf/38fqULD4D/R3ps=;
 b=fFx9M8OskLQKT0GpIaNn48OjQ7DQhfd9oB0nSidWk3/VBPTU9mNA+H5jTv87/Vk/UbTM/mJDRc4dvwRCb44IlyhOU2Lpx5ShrMVf2ryVySF1xonFD4bfikgsOKlfzs49FfunQiALAMZDra86ct/5gWqNNko6Ic+98kq92glZ9Ki+wb1YeX6J4nyvR9rCQyJxi1gWQnWH3jCwmBzU9vV+xWj7tLBjkfkhNfgtrN+nUgRVWTjiCShsZHcaG/O7+J2mApUwQ1puETcIbNxoDfld7DBNKK2hdqcALbCI8x4WFq7ylAx5RzaO2BYomOfpafaSTajZGVTtyrFHAiQTIy8CdA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 12:40:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:40:27 +0000
Message-ID: <e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
Date: Thu, 25 Sep 2025 14:40:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
References: <cover.1758264904.git.jan.kiszka@siemens.com>
 <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
 <87bjn1m28m.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87bjn1m28m.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0051.namprd18.prod.outlook.com
 (2603:10b6:610:55::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 47188923-eb56-4aec-f3c1-08ddfc30b442
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzNpVEhST1MrNGtYWTk5NHc3SnRzbzVWd0FYM2dseGdYTUpGTENUcGpFZWtn?=
 =?utf-8?B?OUVQN3dYVUR0RDNINzc5bzRna0tBQUdBV0ZRM3VibmhLWUV6T0YyeC9OUitQ?=
 =?utf-8?B?cFYwSGEvbU9WZjRqeEhBN0tDamk5VWVZUDAzQ0RtR01EeU9SdDJQdnVjcG92?=
 =?utf-8?B?UjFmbkRnbkpZM0hmTCtBeEh2YkoxMVY1OXBId2tNeG56MFNEQy9aNE9OVWpx?=
 =?utf-8?B?ZUFQYlpaOG9zTmYwM2N4K0VHZndiT1VOdkp0WUpWQzFmVFdDa0RPZGlaRm9N?=
 =?utf-8?B?cHR0QWEwZytLdjFGa21KZlp4R1ZNejNvNEdoM0w5VjBSSWhjL2pMRStnTE16?=
 =?utf-8?B?dXlqY01ORDUzcTZRbW1jeVVWRlVHMDNtRmtoSTFVY0ovSVFncldBdzF0WjhC?=
 =?utf-8?B?WU9zMVdnNHNXZGRUTjI1VzIrTEpmUEVMcy96Yk4wK2ZzWjVHaFhKWmZGSnNT?=
 =?utf-8?B?bzFPaDFiek1QaEJDQVRoU2M1dVowTEZMQ2dmN0ZTdEpmZVBETnVUVUdWZC9a?=
 =?utf-8?B?UEFQTDQvN1VYNjhoci9POHhaNG9uQUxKU216WVBpc1Z6cGkxNEhOUFVPbzVW?=
 =?utf-8?B?eGhtVmVadWRsWFpob25vd2tGVVJrYXFUd2Jua0I4QXVCd2Fqb2tQUWY5K285?=
 =?utf-8?B?ajBTaDNzRlZXRmZMaWxZMlRJWk1hbzRidXNMbmRZUkhsRVUyVWdnc3p6ZnRi?=
 =?utf-8?B?OVB2c2l4SHFwVU5KNVZ5K2xoNk5ETk9ER0hNeUVaMHJ2RnpocWVOaWJCUXA0?=
 =?utf-8?B?cWNtdXVmZWN0djI2c3pQNFI1TTRiQmRZK09vSG5XWG4vcUljYkx0WTBGNW5i?=
 =?utf-8?B?aDRCRjY4bmxzd1Z3aktKS1lHWnlFOTI2WE9CQXRTYUJPYnhhNDZtd2VuTWh0?=
 =?utf-8?B?WWROOWFxS2VjdTRtbFllWG9weGNRZHFuZ3lPVy9qUGtNcGprT1NjMjVCTTlt?=
 =?utf-8?B?MU1zY3dUN3psQmlSd0taK09RN2h6UW9ZeFQ1b2hxZEdQcVRVd0tWM1Zndkw1?=
 =?utf-8?B?ZVdZRmtXeWw5YWd6VjhOTndOYnRnTDEvNDEwZStyODQ1bWY2NHRJRGFqQlRG?=
 =?utf-8?B?d010dnBIQzFXUDdmc1FpdjhIYndpSXZJTEFWVTRDT0pPS3dFK3JuYzdxRXVC?=
 =?utf-8?B?azFwc1RkQ2hPK1FSNGlOVnZjOG92WkMrMUZMOEtSSGZMVzhhSUlHRmxLci9M?=
 =?utf-8?B?SkhoL3UzeHNLUGE3dS8vdkN2MHZIRUpTY2VmR3ZWL2JXdER1NXJvUHdNdkZ1?=
 =?utf-8?B?WW1jVGJNTUsySWYzOC9hT1BRbGxORFRwMWhTY3MyVlNVTkJSSWZyQW1KcU9i?=
 =?utf-8?B?NmFRY01HRWtBVjkyT1Zic3lDdW4reEFXbjNXcmhSbXRwbXdBNzV6NE9OQzAv?=
 =?utf-8?B?dU5raE9yRVpYUS9CSkdYdUdRNjZ5MzNTUi91VW5hcWJ5NmFKcDIvUnNhS1hm?=
 =?utf-8?B?SjEzSkhGWXhYN1Y0d0E1MEh4NzdIWnB6T0IwdGhGQWJIZ1BUSTYzRENMc1NN?=
 =?utf-8?B?KzB5TTAwYmJjcU1WL00vN2N5N05GbHdQTmxEYk02b2VlblNxWHRJMTBjRElu?=
 =?utf-8?B?SlBXV2FoZjczTlNlenh2S3F3OWFZd1pVSU5wU1BBOFIwdTRmZW53a3pJTlFT?=
 =?utf-8?B?eXdpZUp1QURDRUJtRHJKNjZpYkNQWGdINmdrRitSekhyTG5FNVdtUi85eTdt?=
 =?utf-8?B?YmRBd053akhkSGVPTHpXajlBUjV6SkNINWZIaXRYbE41d0VvZk1PcjZjdTQ1?=
 =?utf-8?B?ZERqVUtGSHlxVSsrOHE0WTF1anFQMEpsTnZkT0dFdkVQcG9IdGpFeUxYTUdy?=
 =?utf-8?B?WDRaQmVtRFBWTnoxNUFYSk5ZMVdsd2FZUXdRR0UwdXczTVg4UitEaXR4VTIw?=
 =?utf-8?B?VDFGdDcyZkEzMTVqS09acUJDQkwzbExEdFc4TCtjM0xDK3hhSFEvdmJ3M1Rr?=
 =?utf-8?Q?IQh7VINF6Jg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRsSU85SnladG16TGVMSWRwWEhhZTZ6eGoyV0xXczZLYnVBUTQ2THVIaUUy?=
 =?utf-8?B?MTVNK1JyQTg2czRmTWpJRk9SMTUrWkdSMTZ0MkNLNXN5WjV6bEx5NUlwWEdF?=
 =?utf-8?B?NWo5STdIOU1YcUU0Tis3a2dZT3VFRC9NQlREcXVoVERrK1FOVGhiKzZUZzNX?=
 =?utf-8?B?MHBMOFJtWTVpSkVDckpXaGxrZXUydkVFRmRaSWoweldTbVNROXFKbnAxMHJQ?=
 =?utf-8?B?SDIzMGRNUG5WNUJ3M2d2M2FiSHlZTGxORWg4eTZIRk0wSHo2eTNjWURnZm1O?=
 =?utf-8?B?M3JUZlR4Snh5TFlEV2I0ektJeGhGMnlzMlQwTDNWVnBGZGxldkE0d1ZzVnpC?=
 =?utf-8?B?azNTWTFkaUJJZHo3Yi9iN2t2cGorWEIyTG9ucXVaaWJJMWNVT1ZZWkdPeUlB?=
 =?utf-8?B?NklKREQ2UlE4RC9BRmFiU29ES1BIbkdNSndzbEhiZUNXNmNEeUp5SS9EQnRx?=
 =?utf-8?B?TE5nTVl6Z3QyMzN1S1JKOStxa0hEYlliMWo4aDVXYnZONzU2ajh1YlZjYVFk?=
 =?utf-8?B?Mm9PbmFxTGhwNUtXSUUwcG1pVmt1RXBvMnFxeXphbVFPenNZMDR5ZFNMNzZt?=
 =?utf-8?B?MjBjekx6YVBLd21PTHFKZFJkdU1XWmZsQ1pIWjRwWEJsSjJmaU51WGRlK1V0?=
 =?utf-8?B?OVR0c04xWEtWQnFNeWxscEl3QzhjcEF5aWJlL3d0azJVQ1h6K2R1NER5cWRy?=
 =?utf-8?B?MVdZWk9uVG9TVUkzUWV3WUJNWlFoL09yU25kaTJ0NitoUFEyYVROMEdvTENR?=
 =?utf-8?B?L1lMU0w3RXFpNEhZVGVUN3k2Y1ZNMmdRZGtRR0xTMDVOVXY4KzcycDE0bTdL?=
 =?utf-8?B?YTdBTUVPS1NlYTBYbjhOcXBGcDlBM0RieGN1UXJ5cFROWG11SzVBTEt2SFZp?=
 =?utf-8?B?VFUvaFJrY3cxb21Gb0xWWmtNZm5GSFlJaElHOE0rai9hZHJqTk1uYVY1VC9y?=
 =?utf-8?B?YzFQUUN3V0RvUTE5V3EvVTd1dFdnNGlSVVdKSTFtRkpQeUlHQzBvZDZNZjRk?=
 =?utf-8?B?cFJDZG5QeWkrMjlaaGIyVUxJSGVMaTZxRWF4d2tEam85cndLOVl0QXdERXVx?=
 =?utf-8?B?NFBCZXIxNmZGenpLWFFuOVphdStaOExiZ1dWYVJCWU9aS2cvSE5QU0ZOSkEy?=
 =?utf-8?B?Q0M3Q25uc29oZW5YUHZlK2VSa3NxNzMzeGd6WEVxbEpma2RKZVdmWjNGUS90?=
 =?utf-8?B?R3F0QUhSVWpzUVkrMzgwZlZvOFduMk42NDJCaUtMTFhxVC9zd1N0SzhIcFFm?=
 =?utf-8?B?QWZuLzI5c1dzbW50SlB3MnFVQTBGYUNrRStkQnFhK1p1NXZaOERicEMvNkJQ?=
 =?utf-8?B?NHFWS2Q4NkNxQi9kQk01cmR5NnBTZlJ3YWwrTThxTTFxWE5qZUkyelJBeE9h?=
 =?utf-8?B?VkNmYmdmOUIrbmFZZEFRSUkxdkhMRWZqQ0t2UFZJYWhmRDlhV1ltMk9RK1dh?=
 =?utf-8?B?MysrTVBPVEc5TkpzS3FRenJsbUx6VWdMTzMxMUtPQU9WaXV5Zm1lQm1kTFdG?=
 =?utf-8?B?eitDOW43dURuRENma1pKYXR5SG95M0NLZExJVEoxd2czTWxSdlJJbERINkh1?=
 =?utf-8?B?VWlxMEc5ZUNzSGkzSFZKWUFjY2VSbXMxcE1MUlhpZU9zV1B0WFdLQWFsbExm?=
 =?utf-8?B?S0lXZS9jb2RNempPeG5PZG0wSUJIZ0pnVThQVFI3YXJpa2tvMFF2MElnMVVE?=
 =?utf-8?B?U1ExSC9UbGZPNnJzWWd1WGVKRmNETW1EcmYrQm9XMHhFTmRSanZTUVl1b0xT?=
 =?utf-8?B?U2RkaUN3VFIybWhCL1NIRWRLRmdYUDNSY2g3VEtQY1FxMXJWQzNyNXpzbDRX?=
 =?utf-8?B?MnhoZWthZk02dVFHQml4OWRHL3VBYnNWZSs5M0tHZUQ3Q2FybHhRdzRvblk3?=
 =?utf-8?B?dnlSZnNBT3g0RTNGbXRpZFBBTisvRkxNRENZWU1pRzcyWkdMVlZ1WFl3d0dz?=
 =?utf-8?B?K3dMWUtseEEyZ2FCMGYvcWowaDdsaGNkMHZGbWRBd3hPeHlBSE5CQ0YxRFV0?=
 =?utf-8?B?dENuN016c3hUcUVSSWFhc25MQUpWUFM1bFZxMzdaak1PLzlXZUhNWTFacm4y?=
 =?utf-8?B?SnJzLzVCMDRqakl5bVBrazcydUpnM1VrVkxPVkgvVmJaWlQ5cXh3dWxlQ1JM?=
 =?utf-8?B?NUk4SVJEVEVvS3BlYzhkblRQWlVTbXZxWWlqWFdTUEFLQ2pCVEFCcTBZMXJ4?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47188923-eb56-4aec-f3c1-08ddfc30b442
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:40:27.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LggjaUGNZaW/taiL3AreszR3CkNWz8/9RpEXj25U4jIgt/baOa6EbRk+2mp5yQ4ZI0kQJafdA/UkuXHlx6Jt5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5331
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=fFx9M8Os;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c200::3) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffgfuffvvehfhfgjtgfgggesthejredttddvjeenucfhrhhomheplfgrnhcumfhishiikhgruceojhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeekudevfeekgfehgedtkeettdevtdeuuddvgffhtedtjefgkeduueehkeetuefgfeenucfkphepvddujedrjedtrddujeekrddvudegpddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudegpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 23.09.25 20:51, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Not all callers of this function do that themselves.
>>
> 
> Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp()
> would not benefit from doing that themselves precisely, to create an
> atomic section around their internal state change _and_ the fpsimd flush
> op?

Is kvm on arm64 officially enabled for oob (-preemption), or are we
patching blindly here? If no one was looking at kvm yet, then you might
be right. If it was reviewed already, then this here is just cleaning up.

Jan

> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/kernel/fpsimd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 83b8492984982..ba804fcdfdb3f 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -1951,10 +1951,10 @@ void fpsimd_save_and_flush_cpu_state(void)
>>  	if (!system_supports_fpsimd())
>>  		return;
>>  	WARN_ON(!hard_irqs_disabled() && preemptible());
>> -	__get_cpu_fpsimd_context();
>> +	get_cpu_fpsimd_context();
>>  	__fpsimd_save();
>>  	fpsimd_flush_cpu_state();
>> -	__put_cpu_fpsimd_context();
>> +	put_cpu_fpsimd_context();
>>  }
>>  
>>  #ifdef CONFIG_KERNEL_MODE_NEON
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
