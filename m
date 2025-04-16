Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7124A041
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805879; cv=fail; b=tJXuCpq6kWRzsBn6RHMF8KBPBR1dIvFD+xLE34vZf+MNv5vwCP1qtBpY4tzLFEvrWbjQGzaK7jmHSVFAKQjHyYTASLSFQ9SVCDqiSSc1xp+qkYjqLhgYnGp3u5sjYC2elpMyfjaWOQFYJ65jrw66yO9GwDpXR9rwEDV4Xns7Snw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805879; c=relaxed/simple;
	bh=ODQhm+adzDC9IqRKLeiS1xlWOf5seGc4icnJ+3smEOg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=WqS9Emf6EMY0/14UpKcuVXcpTfCo8Cvhu0XuG1BA2ACYFQqPAkjEdC1/rnBlwJb0pKPP2Ov/ITftUHbjqOyjZu9Db4z6vHHL5s8Wez9CxWYIxzwkQHUI5xrO0iJQgR2sBFuMnALflgI232zuvi8xvHb4g8giIb1PIFILIO8YA4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WQXSJpw+; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WQXSJpw+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi2D1akR/ZfA3AdAkghiU3+M9Gg+8wQo5EHu7tKSGsgksGXyY8rjmo8AZB36glQnAZx27WNiY0euF2hS6SXaEJlSws6Yi7EIJQMAVErNg1EeV+r/7LwjvE6R4fF15riQezc+zd6RruGPtvLrSpGERwwLlKwdsk03Dnmi3gYqz1v2C3tKVVIDqH7xL40QVGDu0dSnugOa9/X9odGqCFY3jLB3ivao1S6oaRM2DBhUhDpTczpZ2RJUtA0T1jlC5fYl4++D96YiIPteN9xLRpkgDZDgh4u2RgXx9EroKbhLegPCg5FADPpBL5G09hqyUJWq0PkIBR7dL4z8jLno/srMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4wdU0ishB91mjPPCjFtlqjKHvZvyUD+50OY08dCizs=;
 b=ZZAqOmwZqEGJW5UhylaE4N+Nws7AQbYfLM3jASzfq2oPL25O2T5H254e8+SbZpBk5sdHeZCn3uzu47iG2azTyjqWk6DinAud8BwAef9zZCDS3UpMLTHHAtzoW4EQJhmMIl4tOuSVrpi8o7J9sGbItnXn0r5PmXwuWKNiEgasTewu05NvrjJeHTmgCXLHBMJsjMCN9RAE+y/atQmYbvUm/kaS+RDbgRTKLRbEKUOzSAVku3ZWb9lYFTYYZNNMlXLez/BVM4+5Am3a/zq/jBb7KBpxKywY01LzKuD+jj5nGsCTahiz7cvMuYgzMpULUDGvtlSqZR0LcRLuin9S2BS93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4wdU0ishB91mjPPCjFtlqjKHvZvyUD+50OY08dCizs=;
 b=WQXSJpw+bC22SIhKGHq/fKt7WcJVYvU5I87o9gys6FVQbXLTkMUSIU3w9suhA98wvB7JApYtEGbk+BoIzgg8yKMPoR/as2n8uq7R2cJo/vFhtXjmCts1hS2SeDK25bmbE+RwvZEwEhQqVzoFYn4bWzUmQblY+NSZulgnMq8p802X/HSILd/S5QMX01izIR9eAXe/SIDihPHwFFhGxwOsXA+qzXnt7vQFNjgJG9DsRJ+Vn9H/JGfGLE+U2iwRtd69drkOHvKeeoHPG4VOncb1e/NE2GLE1LF2qw5hOAAmm+DGOCG8w5fN5oBq/g4tTNqdYeeeCM6PQk1A+dk42MvDQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8402.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 12:17:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 12:17:52 +0000
Message-ID: <2d054d43-aef1-4785-820c-66b7741eb696@siemens.com>
Date: Wed, 16 Apr 2025 14:17:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Drop qemu targets for 3.2.x
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b299ef-7fcf-48f6-6353-08dd7ce0b5db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFQ4SU56N2k2U1R6aGkwR0dEaHh2a1ZYTG9SOEJzODFCZGY3Z3FONWpIV2Vi?=
 =?utf-8?B?dk9PaG1YNmk3bWdjck1JSitkMnlrVStaZ3cvTW0yREFkclFEemxnb3o0Q2tL?=
 =?utf-8?B?bU9WSzcvSUFINm1BRnFuUWN5b2NaZ3RUS3AvN0RYdW9mQnd2a0VSQmhVSlBK?=
 =?utf-8?B?T253V2IrWHl3YTBvK2NYWEpGUkxyUkEvNGZEdmcrdSs0WlJsWGd6aFpIVEdZ?=
 =?utf-8?B?NzJ6Q0svRGs0bXQwTmFhdldSeUNRUEFTelZvWGtROUdFMW1wVEZpMzZObHpH?=
 =?utf-8?B?TzE0RkdTa2JKd2dBZ0tvczBubU1IYTNQZS9KQUNxcmRPNmYwWVhrOXk4WC9C?=
 =?utf-8?B?NVF6RUlRL2ZwOUVsQ1VNK3FKT1VpbnFyMXpsbWJaMjRuTUJ2VTBHVmo1N2Fn?=
 =?utf-8?B?L2lNc1Y2Vm92dkVpYStvajkzaWY5MFVUcnpwU2xjVWJjOHd4dDBST1d1Yk1V?=
 =?utf-8?B?L05ENWpleHdxSHN6WTdYMU5oUjJ1T05yekxLWlQzdkpRbzFZTGRoRjRLVHhX?=
 =?utf-8?B?Y1hCWTJGdGduejh4NnVPTkFjUHNEL3JnZUkxZHpSb3hQWjI0SjZ6ZTRqZjRN?=
 =?utf-8?B?ai8yZXdHcnRMdmtVSy9pTFV0bHkyRy9XQkNadlcySDU3VlhuVlN3QzhiaHlT?=
 =?utf-8?B?R0ExNllKakR5TWlUaE1Kb05rVUhGTlE4eGRvZEVuMlE0b0gwOHdMUWkvVTVi?=
 =?utf-8?B?MDJGdlQ3dmpOZGpHbldWR3pFZVRoT3hKYlErSWQ2OVVJNURub25nQmVOVUw5?=
 =?utf-8?B?MDFHVlYvUFhCajh4V0ZHVGVPMTZtYmJ4WGlRVmsrU1J4RlpQdy9MYVBDRWVu?=
 =?utf-8?B?aWN3UkRNNTZPejFOZHAvRzBvMWRvTzUydW1jUVplTVl3cFZUeTVQZ3VXU2M2?=
 =?utf-8?B?bTRodFVhQlRpZjBvZm9BSENMTDRLY1N5Q1duTlg0N05oVEtMangvOSsrRDB1?=
 =?utf-8?B?aDZUOVlhbjk2VGRTK0t2UUc2c2NHaFY3aVA4M29TT2lGeTNPWmNzMDVra3JV?=
 =?utf-8?B?Vlg2enVUSUsxVXV4WEtNakxYVTVVMjR2Q2RKeVdZWjI1REVISDRlL0xrWVRM?=
 =?utf-8?B?eWwrMTJPSXFYZVVESDlTcDJhY3JjMW5VS2ZvSSs3TVlEdE82aXNETjZRN1dO?=
 =?utf-8?B?UkJRbC9uRTh6SXRwY0V0cktZcGh3cEZtRzNFMVBZVW4wc0RBdStINzRmQ2dR?=
 =?utf-8?B?K2tzN2xmQnQ1QXFmT0hVNXgzL016QW5jM1M5bEgyalFTT0ZOVGMrdFJ1bWJh?=
 =?utf-8?B?RnhVRnQxZFZwMGdTU2UwcUJUT1U4M3VQUXJLS000eDcwZ1pwaDNsZ1VCeUZE?=
 =?utf-8?B?Mk5jaVB4NGVUdkhtekNFUUJnYUNuNWVFLzE2OEJBcXRmQ3JRMkJoWGl6V3oy?=
 =?utf-8?B?clAveGJGcW9qZ2tieDlZTWdtMmE1cHRQekd2QXNQS2tXbGtqTnRkdk8wZGtD?=
 =?utf-8?B?ZHlRS2pXaGR2dFc2aWhDb3dUaXlScGlCTm82bXc2VTJhZUVxWWhFa2dtL0No?=
 =?utf-8?B?SGpaK1lVWFZZZHVCVVB1dVlzOVdKc1d4czlJNVdvWDRDV1M4V0llSUwxeDdm?=
 =?utf-8?B?SDNuSmVDUHo0eW9LTTN5aStzMS95bWo2QTFoaDVlNkc5Vk5KYWNsWWgzSG9F?=
 =?utf-8?B?SmtKaGV0ODNZd0NNRVJmRmVBdEtlUmw3cDVmZzZmUCtUWGltTi96UU9DRHNF?=
 =?utf-8?B?R25VdU1XQW1yMVM1NTZHcDVYZC9YMGw4c05xVUwxZnY5ZFR1Y0lGanpWblk3?=
 =?utf-8?B?ZXFoQUF3ak9xTzMzK3RnOWR1aEJwNHhrd2N0UHBUUllBVXZjSUI3dUhoSU9M?=
 =?utf-8?B?QjFwQUdGcndidXVjRHFVKzdDU2V0dTg5SHRjTEttd0JwR2kyalNMRUJFVlhF?=
 =?utf-8?B?bFBJYlZoU0RMbENQUXpYMVp0dUFlc2R4TXZzbHB6WHF0NTl1bm02QXB6M0xz?=
 =?utf-8?Q?NgPwZNpQ7+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVV6eURGQTJrTzJGMHFLU0dLN2l5ME44Zk5wV1czZEJ3UFFSSk8rOCtSTkJQ?=
 =?utf-8?B?L1pYOUN5eGZpWVUxSWd0UkUveFlOSHNWR09vZUF4WFVBNHlyT1hDcWNFNEdi?=
 =?utf-8?B?MEJIUkN6NTV5RXlpdVl1di9QTUJDeGplWXpJRnF1bFJaWHk5bFJIRk95UU5t?=
 =?utf-8?B?dE8wNzRtWFgvZ0FwMEs1cE1LZ1pzVGgweW5YeWJNZExSOFRmQlV1enk3eHQ2?=
 =?utf-8?B?aFk4M0ZWTXB4N3FVSjcxdHNSbFNKYVF1cGNDTnBidHpPUTV2alJ4TTFRRlRD?=
 =?utf-8?B?b29XZW8wREVqdHg5R2pvaGllanR0VTVmTXJ3UmVmbmRVSUM4ZjlFbnNuVHdT?=
 =?utf-8?B?TDBhK1Q5dHJyQktHWTJWTlJRR2lxOW9VVnJZV3FPc09qOFhkcnlqdVZuSENn?=
 =?utf-8?B?ZnlRcytPZWZEcE80M1pTNkhvWXBUWThUWHpVK0UxWnVQZkZPZk9aUHJ1akUv?=
 =?utf-8?B?K1R0MTAyY1ZkMDViNU9JcTFmdkxSWThmZC95eDRXYUdkdDRxTU9yMER3T0VN?=
 =?utf-8?B?bElKajVWU3BJa05aTzhMU2xINWh0M2tBZVBsaldkWjBwbjlUZmZvVVFnNzZQ?=
 =?utf-8?B?L1NQSVBMTEVlRlUyWTVKTlk0cHZCNlkwMmJvbVRZTUZxOHR6U3c2RUxnbGpU?=
 =?utf-8?B?TmpXQ0hyS3ZvSEZJUDZPTktsc1VNNDFSS0JoOUFoREZiakFhd2FXOHJ1RzF1?=
 =?utf-8?B?Q0thZE9pUjFmZTBXeDY1YTlUeU5pVzZwbllyLyt3dWlEYUxyMENMeXFITUNG?=
 =?utf-8?B?U2oyRWllVjYyV0hkSUhienQxUEtydG9qUkwvUDQ0MjY5Q0krdzRqQjhjRVlV?=
 =?utf-8?B?WVRGWWoyQnhuMDJGK0ZGbmpYeW5VYVMyYXN2N1V1cmxJSDluQ1JJY3NVdDh6?=
 =?utf-8?B?QXRPcE1KeTZBdlRhbTlkdkpUMnNFZ2hTcEd3MmxNUUpZeFIyOHAvMFNxUTZ0?=
 =?utf-8?B?MHNESUpsUDhVL0VCR3B4MzQ1YnVHNURsSWZmRGJ4Z3dwT1VHWEhVY0kwQmQx?=
 =?utf-8?B?Y09LbnRSTUhPNGRDUFpCMjhJdWZBcW1RWFZuYWlzMldrcWJKZWJKazBpb2Q5?=
 =?utf-8?B?YlE4Vk5iTU1LdVJYQ29zbjVFVGt5YjFzaTkzQ1R1NFAxUDBuWmdOUHpoWlVz?=
 =?utf-8?B?UEt5V1BkdTQ0aWt5U1RFeHp4bVF0L0xTSDdDZ3lrV3hRTDBzRm0zay9xY3BW?=
 =?utf-8?B?RTU3TXYxbzAvUlBLY3kvWTIxbmkvL3EvNVpKWUl4Vmt2MDVjTWg5SkN1cVlM?=
 =?utf-8?B?UTlzU3VRR0w4RU42RGJDVEJxUkJ1d2tDK2R4SzdQV29NZkU2RGx2WUpBM0Zp?=
 =?utf-8?B?RjdTUy90WStIV2F5MTcyUXFzQS9xOVh2MnhJT1hqWS9pbm1ONHVMMWY2SmZx?=
 =?utf-8?B?eFFJY2FoYkpsTE53aDRpVzVSeVFaRjBXWnRnWEhNZ3drTnY2Wk9yemN4Mi9G?=
 =?utf-8?B?cm9nRjJENXpXUHByM25hTmVCYjErRHpoUjB3dlErVTBoeUp1Rk8wNTQ1Z1hy?=
 =?utf-8?B?YmtEK0ZHOUJYMHluemFxY0g5NElYNzRJeDFlS0V5c0d5YVU3c05seHZrRjdU?=
 =?utf-8?B?bjZHSWRVYVBhNCsvdmlPQm1PL29kL0JmaEJSSWJSMURXTXlDKzg3SmlJS0Ru?=
 =?utf-8?B?dmhYV09KQlNzblJHVnM3OU1qbmZQcDFhQS90d0dlVzF6akF3VkZsNzRGb3BN?=
 =?utf-8?B?UHVxai9FZ1ZDRVRKTWdyd2x1THpoRms0SS9xTlF3RkdsSVpuUFBMNTNRVjV4?=
 =?utf-8?B?Mi90dmdYUW1DY3pQTFlzR24vWmZudkJKN21LRXU5ak9ybExLdExqcHhIeEpI?=
 =?utf-8?B?bG9zUFo1dDBHVjlBNG5IYVBURlNLTXBPSWFaYU96WjlXYkhtY3k4K3pIeDJa?=
 =?utf-8?B?amNreTRaYkwzRk9iVU5NSllZK2x1MUZ2VUNJdDBlaUNyUnVjcXlEMy82dm82?=
 =?utf-8?B?bldFNmtFZkNTK0Q0dDZmQlY2a2pMRXphK1JvcFhVcmNzQzRrekFsZUdES0Fn?=
 =?utf-8?B?SzlpSkVMSnptV2lhNWJrRDR0dG8wNzlwYkxZVmxUQ0U1QU9ORzVXZDladEh3?=
 =?utf-8?B?RjJjdVY4VHJKNUxtbGZpWk0xZkF0a3ArM01FMmN6QWluWERPTWJzR2lUZE1I?=
 =?utf-8?Q?SzSsQ0OTdYyh6q6suAR/rSA0y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b299ef-7fcf-48f6-6353-08dd7ce0b5db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 12:17:52.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSmHVotT9CvoHZprMr9vsU6nreJIyZMGsrTcXOi0QdAa2TyP/48en8ADqAM9kjrBqrybAUoKE3BJzYET8xc5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8402

From: Jan Kiszka <jan.kiszka@siemens.com>

Reduce the build and test efforts for 3.2.x. QEMU coverage is achieved
via next and 3.3.x.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/xenomai_3_2_x.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index cb08948..5b90148 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -21,4 +21,3 @@ include:
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-debug.yml"
   XENOMAI_VERSION: "3.2.x"
-  LATEST_KERNEL_VERSION: "6.1"
-- 
2.43.0
