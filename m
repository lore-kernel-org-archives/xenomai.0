Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401CA6E611
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889091; cv=fail; b=qbIx6PhVFpNMdy8VTcjnwRQFOkuRIpLtTXaCAU7B670OZFkEZAMc51zjUtetFrEi0Y7+tNc8IwQz8K+sdx+jQghEpWkXym3M0IvG/qvv2R0RyFYcQl5OaGlyPMWeonRg7oyy3kHZR/JtadyeI9Kpg/yLrquGJ5pb5Nd+c7GfsJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889091; c=relaxed/simple;
	bh=WIcv0o+qZ3S4+VYVr/Ggmiw3nzm10q4+m+o4KKx+szI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDmcT/+1O7w2ptXZD8tMH8iSOuVeZKd3jtrcfXTuDZ7JKDE32Jm41aaW91LQfxC/S4Yje3Y7q4NvW4BnwSoZhtFaJ9lx9YN59ZNEJhT92mzWs60pS5PtBx+LFq9aed2YJUTCUjjBu999hxCBT4kBCbP7NXIbgUSv6fWTtJrqXqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dL6MCrMm; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dL6MCrMm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmV2MiV7++Fhztklk08y8GyI8lCr3IihgPg01GP8Xk2/VHVzBfXxWtKEedNfFx4AzUOvycdD2ZqbQ5T5nX46zYClvn21hn3yaH713G5/Z8o+3fe46K6CEIXPM+bf6Txt+x9DwiwewbB+9XzmWJ27SCHQuoEdQpnalLzUr4Tpc4rTmJlDxB2oZnq6UAoXy13k+t67REHi28I/ov4di+nywPwG5cKb77VngFh7n8n2q7JR1kiE4uSCu2B2FyWf2tI8r0jD9ccmHlw88ZBxM0RRdhLSPqHlF/5ewogq3c3Rfj1E2w+YzHPARiRRGS5DxgAhfDmq4mc5aq+zhIPxbGaNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=414yTEj93Hu16C8+DjU7Rn1OP2AnJwlKJaBupL+vaqE=;
 b=LgjIQ1P8LQLs8nSoAKhBiE0VYTF4zaxdds/A2rz8aKE2suCxeAwLpUDRq3hSjBu3+rvkomq3q7LVgsFDxUW54bzW5aPcihzgmDIZBEGpRwrVFPgk0iycMQQOntWcMB7RXrz1oApISwBkA0WDqwptvd//mhPfdEYctDJ7ubeCiyMx9dJMkaH7XMy0sSw7u13bUvcEb7LRvWpSPRLq/zP/FWoezXTiR9JhKGLNR+rFFygUpw9h9a5BRlEw9RtCELaBbq+0vmN1aM1V4KXbxchDL8/qPop7kDREK+BxwbzGRQCEBu6wdUic7rr85oTxeK9UEZ6dscHTuPnZyr8UHrXWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=414yTEj93Hu16C8+DjU7Rn1OP2AnJwlKJaBupL+vaqE=;
 b=dL6MCrMmJGjdjYlhHAGdqddd1NEhxAM3ip9TNqmNnE90wTN0xUL8q968JoFRhl/yL49rrqWAygYWiECg9837IbW7DXwu7KyLpVC5PtD/YdXn1KwvxS6ghsYn49kSBvp1m+5wUGPB4w7to+xV6mNYcYYj0RkxbQK/wIS1ZjpaK5AU2C6WHkFXx2ZQYdsHosjHgpF6NADvra8i0ZvXurPrifW0XNLANhxtz1NlA9r0EF/Rz9D7/5T3vco7JN9zgIAX5oltIsj9FsYrLOjSfVOJzxW3QKZTyrMhHCDMF2wFMY7/Zut32cZIvKlhBJhwI1ri/ici41AtO07ixBY+z683aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6435.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:38:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:38:05 +0000
Message-ID: <fc1d19dc-49a5-4b66-91af-38889c8f32b4@siemens.com>
Date: Tue, 28 May 2024 11:38:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] xnthread_set_periodic: Improve period adjusting
 support
From: Jan Kiszka <jan.kiszka@siemens.com>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
 <20240528070432.6669-2-david.oberhollenzer@sigma-star.at>
 <b22f524c-f1b3-4981-bb67-6f936b14e507@siemens.com>
Content-Language: en-US
In-Reply-To: <b22f524c-f1b3-4981-bb67-6f936b14e507@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9d7c73-5f3d-4c77-bbf8-08dc7ef9e025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUcwMTVqaTlqODdFT0t1TlZYdEdibFBUcFlSTE5jeU9ZTG4wNGUzaWozellT?=
 =?utf-8?B?dnQzdFNrUGZsNFh1N01yV2s1WG91bklwMUh1ai8rdUhVbmxDVkJud0tIK2Z4?=
 =?utf-8?B?Z1Q0MlNYUjJzU0NnTEl4SnpaYUJpbTFQSW1CcGxoUnVyUWVCQWZNVndPTVJP?=
 =?utf-8?B?N2pVYU1HT2NWWU5kaXZCam1xbGxKdHNaQldMQ0R2cGZCOENSbEVRdEJlazJs?=
 =?utf-8?B?WjRsTlJDVTJQTXRyeWc3VVlVU0E2anQwaXFYTWhCUDRiMUhhTUpPaEo1alJa?=
 =?utf-8?B?ZHgyL29Mak5VVTJSMW5zMzdjYWJMQmpuejFKb0NUT2k3ek0rVURHcDA4Z0RY?=
 =?utf-8?B?dWZKV25KakxXQ3dLakJleFYrZXk2bmloRnFJZ0FmbGFrbFBVTmQ5MEtpQ1dU?=
 =?utf-8?B?ekNtVWRVRTkwN3lPZzRtRHRNU3BremJCK3ZSeGlBdktURXBsdlFGdHNvdndm?=
 =?utf-8?B?NVVHUUc5V2hqUmw5TmZuTHpEbnhZZnhBY2I4Z21VQ3FLTFhUbDdWeVMxK1ZU?=
 =?utf-8?B?ejU2U0FJbTRxYkdZL0w5ZTdqaVozbEJnQ0RpdWhCOVZXdUtYK1JEZFIwZE05?=
 =?utf-8?B?UmVnVFQ2enNpbW9pRkZBMHhxQ0Y2QzJwVGNiS0pUWGhpMGJQVFpJaTd1UU03?=
 =?utf-8?B?U2tpZHkySnJMNWIxZTdGY3Z3enhPcUxIVlBSYjVMOWFBcjl6WDAwQXN1bTk3?=
 =?utf-8?B?cVlWaDdLeCt2eVBweHZVekltY0pjem9EU0E2RVh4b1AvdVd3V2taWHpldlhy?=
 =?utf-8?B?cmdhK3B3a0M1ZEFZQ3RBSDFXUEpWSk9rQ05aNi9TVUs3ZlcrOW5DMldkVUlq?=
 =?utf-8?B?NGJvQTltRDU3MGllSHRFU1lBcHhaVUNGcHN0U0hrbFptbWJyT0ZMcHZnZ011?=
 =?utf-8?B?YjRmUWFLYytkWHpwZ1cvNWswdnNlY1U2bUJZVHM4MllacmZEeW9rdzdSdHR1?=
 =?utf-8?B?YlpBV2Jydmx1SWQ3TnhEV1NqVnNVeXlMUVB4ODZmOEE3aDkrM2lCUXJNdlAz?=
 =?utf-8?B?cWFIcGJJcjBFdkU4bHBTQ2hqU1U2V1FPci9SOEc3WUtMSWtUZXlkcEVqUVdG?=
 =?utf-8?B?K00vS3AwLzJjUW5KaFlmUGY2N2o4QUZPMUR4ZWRTaU81azgzNHFRQTBXd0pH?=
 =?utf-8?B?b0lJZzhtcnp6MmJUQnJJVkdIdEcxSTZTTHJPK09nQ1JnVUN0bC9nWDRuVFIv?=
 =?utf-8?B?NUNrVXhPWVlQc1F5eE1yYjFBQmxoQzdVZzJERGVIVkNIRHJXMXJtd0h3K1NW?=
 =?utf-8?B?VTVpL3ZLaTJ4dnM4Rzg5aWpOdkRobEpCekh6YkZIOVhsRloxcnlUMU9JMjBz?=
 =?utf-8?B?TVhZcThhR2l2YTlSSFpiSWNjd1I3UVo5WWNjVWRESzBNYmVRVWVRUTduV1Yz?=
 =?utf-8?B?RFZFSGUySUhCWWFicU85aEdVbEFWVjhJZlZHR1dxMDFNNGRhYjhGY09WOGRF?=
 =?utf-8?B?U201OTRQV29ZUk50WVM3N01VMXR1cGdKTTdpTXdlTkpVTGNLR2tyQkxWdHVs?=
 =?utf-8?B?UXFMWEdFeGRwMmdDazJCMEJqdGU3bEw5OWJhTlRsWXJrS1dxaFZuZElzcGIw?=
 =?utf-8?B?dnNxWFU5NHkySndwMXhQWHk5VVpZcjdZTUNQZGsxVm4rM210U3hUcndybDB5?=
 =?utf-8?B?V1E5dWlaNlpDVzEyWjNOc3grclFza2diTUZnSlcxa1MxcTI3aCtwMFplZHVM?=
 =?utf-8?B?NVIzSnNlcnFHem5JV3JIYWRzSmowdm5naTRwY2FvWnMwU2VSWmo5NmNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVZ3RjQzWVlpenJIRlE4a0x2bTVHelI1cHUvTm5TdjhiSkljYVdIR3ZBMHVn?=
 =?utf-8?B?VVZTQVVsWllLRWFuOHZmakFma2l6WGRDRlY5MzQxYTUzVDlLSGFWRWo4bGhw?=
 =?utf-8?B?dkdGZDJ5clpwNlMzSTNuU2VQTXd5cmJrUUxQcGxPUURlZmNpRG5mRFliM2hM?=
 =?utf-8?B?akhiY2l6VDh5RThqWWpqRFhFL1o1ck44U0Nud24zV21kRW1ZWmJlWFRJY2tw?=
 =?utf-8?B?WDgzcWJYSWhOWFJYS0RmbFg5eUwxVDhOMlVidkdYQVQ2cWExU0Z4Y05qVFVK?=
 =?utf-8?B?MTI2VWM4ZFdLTWtKaWM0a0FQTUtEWDdJa05MSU1uOFU1S0RKbG40OUV0My91?=
 =?utf-8?B?YUx1SjlzdlE3TEx3UFZiMDlCbWdKMndQUUE2dU5KM2pJR0VlYmU5Qm1VaCtJ?=
 =?utf-8?B?d2R6NGNmWWJFeHZxRnFsWno4L1BBYkRMUU41bGZub0ZTOTlrZ0FyTDZKbVVw?=
 =?utf-8?B?SjRKNFVDWXR6ekc0bGxZQjBDSFlsdUFaN0pGNTFLN0pUa2N2Zy9LQlhRcUdI?=
 =?utf-8?B?dld1VUJLdVlyRjNDcUxiamllMWIxWTZHYmRyVFRrOXZzZVRPbmU5UWtkcVlR?=
 =?utf-8?B?ejhqUHFSTGFtbzlBbEhLaEN3VzdjYWhGZ1J6ekIvQU82T3hnNTlNWk4zdHpz?=
 =?utf-8?B?K2xzaEN0Ni9CamoxYWpGSVBhVVFWUFM1aUxYVm9VeExWVFUyNmQ4cDc2V01U?=
 =?utf-8?B?WEtpZGdqa0V6Wk5rZ3JRTUF2UmtkQ1B4M0ZXUjlqN2JBQ200NW1XRHVZWDE2?=
 =?utf-8?B?bmNRVDJhZGp6b2xsVHN6L3hzSWNoamFWQ2dVcTdVVFR0cXZoZjlLY09kd2Ru?=
 =?utf-8?B?QkdHNHF3THBSOVY0V0lybFY1Z1JvajBCRW1YUW13MnEzcFRsYVlUVUg2b0U1?=
 =?utf-8?B?ZXdEZUVzbktldFg2SnFMbWZVbGN1OStqTldHMElmK1RlRXYwN0MrbDRwVnEw?=
 =?utf-8?B?c3I4ZldhdXU5QjVJS2l0WThlWHhzaHEzNHZiY09PVjVHUncrRzRoaC9ocGFZ?=
 =?utf-8?B?enZSQTZ4RWIzNGMwcTdyZm1GdTZEdlpJZGRjQ0hMYUFMNlJ3NEwzU1RLU0th?=
 =?utf-8?B?VXI3a00yL3NDbkJ0ZWRlN25DcitGUjN6OWVmNEI5ZFJWVlZPWjFsVXc4QWZr?=
 =?utf-8?B?Q2czaXhqSC9kcVA5ZS9ScEIzRXpBWmNlOVRVeGl2NjNsT3pYbGViUDN4RFJG?=
 =?utf-8?B?RDdRclVqa1lIOW9TZGgzNmFzbWVwSEFYeWdCeER4NVVxZnk3Vll4VVoyRzFy?=
 =?utf-8?B?WGNtQnFzOFZuY2JhY3BFdlI1TFBnQTl6N0taNG93eDVyL2tZYWU1YTRWNUEv?=
 =?utf-8?B?MFVqekdyeXFHeXlxY1pZbjF4SW1kbk9nUEJMcExWbXJobXo5MVFMdnBlSjE4?=
 =?utf-8?B?Mm10RkE4cUd5YW5IcmVDVnVkdVhRK1FRZFZMWGlyTTMrcnMzR3lRK1JNL1Nx?=
 =?utf-8?B?K28vRTFkZkljVURxdkxyNTJwTWxkS2ViNTZBR1JyTGI4eGR4OWRPNzF6a0R1?=
 =?utf-8?B?WTZLTEJoUFNLRUxna3p4d0s1SzJBYkJGWGtDWTdKRXY3V01nRHhKaHNjQThh?=
 =?utf-8?B?VWRRejZHcGxMNWtqOERoZi9yZzYvTCtLeEZObXN5a1laS1ZPclRnTjc3RWpI?=
 =?utf-8?B?aTBPbUJNVWQvRThWQTVSY0hZMnQzUHFIVzBNdlo1RjdCekZyYXM1aWpJNmZN?=
 =?utf-8?B?TDkxMU5uMVh4TDBXZ0drb1dxMk45eVpxU0VJRVJjR1J4NjRGN2piVTVkSWJP?=
 =?utf-8?B?RWZYcjZOZkJEWGpUb1k5bHgwQXRPMmxtb0tyazhaYXN0ZStJb2hUZzFac3lu?=
 =?utf-8?B?d1BhbjRpa2dQSFptTnpFbDZqY1dZNFRrTXpvc1FoSWdPMEREdHBYN0NSUkI0?=
 =?utf-8?B?V3FmT1JadlRQejBVSXFWNEluM0xEKzlwVjBuSHAvNXRzc1FsSTVsYjRJWmdE?=
 =?utf-8?B?THZ6VldZUmtPOS9ydWoyOWYvS0ZQMCs2Q2pKYXZvR3p4amJobVpRb2Q1N2VS?=
 =?utf-8?B?RmFDRlBEeURtZzZFYmZ0ZXFMWlUyTkNORXdoeFVKQXp4TTdmeFppWlF3OEJU?=
 =?utf-8?B?S1pwUW5nUXJFQzJ2aUJXYU1iTGRVT3hZS0MzSEhFeE1EZnk4RmtGRXdxazA3?=
 =?utf-8?B?SnJBMGFRS2VnZmk4R3BnSURlaTZPS0RBc0JLQnlQOGJzdkIrUnB3WDJ5cGll?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9d7c73-5f3d-4c77-bbf8-08dc7ef9e025
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:38:05.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ID4K2xykaw5AQ4GBdnLW61ALorTDmEFhHLDgh7p4Hy9ccCyLhszYV1gPvBXtDrb6Uw6KJO7Gv9AXWfqvkZWJaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6435

On 28.05.24 11:34, Jan Kiszka wrote:
> On 28.05.24 09:01, David Oberhollenzer wrote:
>> Currently, when a periodic task invokes xnthread_set_periodic() multiple
>> times, the timer is reset each time. Consequently, the period drifts
>> because the elapsed time is not taken into consideration.
>>
>> To improve the situation, this patch alters the behavior when idate
>> is XN_INFINITE, to keep the current timeout value and alter the period
>> only after the current period expires.
>>
>> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
>> ---
>>  kernel/cobalt/thread.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>> index cf3b4dbb0..de97b7e70 100644
>> --- a/kernel/cobalt/thread.c
>> +++ b/kernel/cobalt/thread.c
>> @@ -1273,9 +1273,10 @@ EXPORT_SYMBOL_GPL(xnthread_unblock);
>>   * point, expressed in nanoseconds. The affected thread will be
>>   * delayed by the first call to xnthread_wait_period() until this
>>   * point is reached. If @a idate is equal to XN_INFINITE, the first
>> - * release point is set to @a period nanoseconds after the current
>> - * date. In the latter case, @a timeout_mode is not considered and can
>> - * have any valid value.
>> + * release point is set to the end of the current period, or to
>> + * @a period nanoseconds after the current date, if thread was not
>> + * periodic before. For XN_INFINITE, @a timeout_mode is not considered
>> + * and can have any valid value.
>>   *
>>   * @param timeout_mode The mode of the @a idate parameter. It can
>>   * either be set to XN_ABSOLUTE or XN_REALTIME with @a idate different
>> @@ -1336,9 +1337,14 @@ int xnthread_set_periodic(struct xnthread *thread, xnticks_t idate,
>>  
>>  	xntimer_set_affinity(&thread->ptimer, thread->sched);
>>  
>> -	if (idate == XN_INFINITE)
>> -		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
>> -	else {
>> +	if (idate == XN_INFINITE) {
>> +		xnticks_t start = period;
>> +
>> +		if (xntimer_running_p(&thread->ptimer))
>> +			start = __xntimer_get_timeout(&thread->ptimer);
>> +
>> +		xntimer_start(&thread->ptimer, start, period, XN_RELATIVE);
> 
> Doesn't that mean that we skip over the next tick and fire only after
> that one + the new period?
> 
> | ........|...........|.................|
> last      now         next              actual
> tick                  old tick          next tick
>                       (start)           (start+period)
> 
>> +	} else {
>>  		if (timeout_mode == XN_REALTIME)
>>  			idate -= xnclock_get_offset(xntimer_clock(&thread->ptimer));
>>  		else if (timeout_mode != XN_ABSOLUTE) {
> 
> Jan
> 

And you also need to update the documentation of rtdm_task_set_period, no?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

