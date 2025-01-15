Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3A41C79
	for <xenomai@lists.linux.dev>; Wed, 15 Jan 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950205; cv=fail; b=BZ4ImNPbk78flu74A1VF/NQT78nfG1JxC3argbVoJiTNatIkuOP5rcTGrlUyu5XqCBGsOmsQwbormsVjLdTmlyDr88ha0XkzA+IIk3sNLELnxnRmIQpY7DCW55Rov2aVVU5ZADkdgimB5VuL0K+GMa3mF+/Te89JdaLCTPbC/a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950205; c=relaxed/simple;
	bh=zikh0uv5dd6USTgZf+4jaG8oWdbu9hXdAn4Lq1A+n/Y=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=emSHRKTO1AsxrTFv5y/Fk6GklOvcC3wS9fZSp0xj7vT/poqU1IGGxuZNAsVHzHxfr3o/7KfD0B5MjWCprVpLVY5SnFz4+7k81O6AhUg4Swe0qp/hekfRt6K/EHEOeeQbNCcvxU9IEFktODPigBvkRIdbIlHkbmFOr2YZc6MJKNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=f+oHtniL; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="f+oHtniL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSLqNPeciejUdl2js7L476TD9qPV2cV2mBYrWhmuDgGPObOzD6XIjneYQ5xH7rVagRH9VLx/zi05U1wNsTipTc8ZxEuZshFlnah+JUG3prZDjXna0Fj/+30phWI0FYfMr5Dy04KjBE5CHonwzQGvTWKVv2V7XxzyaggxHYvGIRcLje3+xfZonN8DD1XpJMmb5O52TKR4N1HLqvPq7oYxmF92YGOIwWrGSUeWKM0qxQ0ga71L8eXsn/4loz03OKVES3Coi3xUC6GTjfHSa6BccPlHyc2aEgf6Uzy/XNyIqq3hR9f39TD3XJa7SKfGspeCFrisph6aszjUkfkviXzYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQfOf+P4OAlNWsW4G19qZd6Y680kulprLaiORDQsBAQ=;
 b=ytrRtyiWQWrXTq4bB67UQY2k4zd//rwAysFjNMqwgfbJry72e1cRRQ3tY/VI2xjeP6lEjRfMVhB7AA1r4UFDmLHwn7AHcD+yDUupVhxFdyBjrsTGx0K5wPwzwjNS0n9yrdl/I6DTNBk+YTXxUQMK3fN4jxuakltIMfC+KFphNjTokj/T4jo2aMD6U38y6XlVNtX/eNbv3BXPdsBPdF9ZWuHmCCswDVqWhETijkmBkHyjXTKV2zxenSAYvsn9So4fYJJ0wiBniQsO0qq2efRwMIfgHe/GbUpjoaltZuE+axrGZKbCJ0E4IHaZ2p1wfX399gvWE8Mc65SwE0h7GvkQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQfOf+P4OAlNWsW4G19qZd6Y680kulprLaiORDQsBAQ=;
 b=f+oHtniLKzRWyfgcuPZaras+PmZW8Y1DP/C5gXGMuc58mkHAXsna0BcQIM7Ih4jHTVJ7F/yS8A5feO/jhRkW93izLRHSVCLD5K8l7hD2T9xS/IBNDrU2LWYxAFaS26j9wPdowxiEW3+I68Uvl03UeIxy0hhLHlW57UQT+sAGuBrUZb/jY4cmYF7ZuJJ5tT7XyNvV47b02dR6h0HtTzTU2cRb6Ts9L2IKN3cAlfUK4Z3bH1ARi/PdRIj8NrW4Z9sOtSxSrLDJSox3mSWHd0jdWtFvO09b3QYIvJVX9v4xlsXnbZGRelIbEj5hNufwPybsMIaypA0u0xaxK9AMydEM+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.11; Wed, 15 Jan
 2025 14:10:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 14:10:00 +0000
Message-ID: <5e6f721c-e933-4ac0-b1b8-824f5601316b@siemens.com>
Date: Wed, 15 Jan 2025 15:09:59 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] README: Update links according to our new homepage structure
Content-Language: en-US
Cc: luis@eichitek.com
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3277:EE_
X-MS-Office365-Filtering-Correlation-Id: cfad2121-f6c0-4765-5598-08dd356e4c80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENzTXk1Y3FkdlpFeVBDaEFEV3g4UWN5cDhZZXZwamswNGRaekJVMVBVaENs?=
 =?utf-8?B?Z0g0Y2xYQ2ZrSUoxU0lxcjJ0R2VqSHlnV3pSMDhqL09xZUc0b01MSThaeDB6?=
 =?utf-8?B?b0pacnVZYjk4dkgvNlFzKzdhRFN0a3hFSys4cHFJaWt6UmlZOVkxdG5adGM5?=
 =?utf-8?B?aE8wNVRxZEpwRDdHWlFid1EzejZKODVrNVdRdEZJQXhxVGVidko4ai9JMW96?=
 =?utf-8?B?S0M3NExWVkQzVUxqOUI3K01oRkhyOTkvdGk4bnhzOEFuNW1ROWNnUzIrUTRT?=
 =?utf-8?B?emh6RHdRWUIvYWVUT1RINXl4TzREQzJEcFNVNm96Y2VuWGRjZDB0MVZqbjM1?=
 =?utf-8?B?VUxTNzRsMmRqdXd3cVNSQThvQWJIK2JSNmhyWm0yMUZOOHBVM3dvRnFsTEJp?=
 =?utf-8?B?Q2ZYMWtJYlNrNXg2NGtFbjZnVlVVUEEwYk1rVE54bDU1QnBKb0k2bnVLTXhj?=
 =?utf-8?B?RGV4M3pkVHRFOFM3Z0ZGY3lQQ1NQR2R2WWl3RVpRVCtQdWd6K2lTKy9DR2Nr?=
 =?utf-8?B?cnVPT0NYL091SWpRbC9xZDlETktueEhuREVmVkNUU2FpdVVwcE1WaDk2Z0Nu?=
 =?utf-8?B?N3BqK2d4ZXY1VlBHQi9nT2k4S0Y0SDFJOXVSWkVsbXpnZUVveXR2cUJYS2VO?=
 =?utf-8?B?ZXlmOW9vcG1TcUd4VVp1dnZ0cVFMY3JJaEEySk9QbDlJelJMbWRMOUlQazBH?=
 =?utf-8?B?Z2lDN29pZzVlZkZhaGlCUkZBa3A3N3FDTTE3bDJtME5RUEhBakZ1UTB0cmNM?=
 =?utf-8?B?Z0tpZGh4V0RlMXVWQUoyaHJBWnlSd0lyOG5rbUNwdzl3WDIwVnpzVjFMbUV3?=
 =?utf-8?B?RUtvYWtvUDFRT0FDNGVlUGJjZjl0MGhJRWExTTlvR3RacG9MNTFrWTlSVnJt?=
 =?utf-8?B?N2RONCtYWFdRek9wRHFEL05vRGxYTERPUjZGTm9hU293LythQkZyNUVIQyts?=
 =?utf-8?B?TWx5Y01RVEttU1hBMngzNjlCZXhXZC9IaHUySlk3VFN6bFA3cHU5MWhpMWNR?=
 =?utf-8?B?Mm5GRXc1Yzg1R2tqeWt0Q3ZnM0pxUWNZcnVBaGRUbU13blNBUXduMDlmNUJD?=
 =?utf-8?B?NVBNaGMyRmZLMzQwY3VQSTgvTlFuc3RhSXZjd3MvSmUrdUZ2ZFVWUFllSE5u?=
 =?utf-8?B?ajR2aUQzVUhzVko1OThLSFZpNVBJMm5scm5PZHdPbUtreWdUbFdGUFpLdUJE?=
 =?utf-8?B?UHNTTUhCZlNwalBzVC9XZnBMS1JGZmNSODZyOGZMRStnYit6SlBUSHVaRmV0?=
 =?utf-8?B?blJOWUFpYjNIaTdqazdJY1cyZGxSN2hjeDNYQVZseDVRRDFzU3NGa0JuZkgr?=
 =?utf-8?B?LzZxdHVwMWNtYkE4M2Y4OS8rS1doeDZSV1V5OHFydlBvRW9PN3MrQVNGTE1K?=
 =?utf-8?B?UFR0U0VkekhHRnZ2SXI2a0ZWeVBPZHFWeTQzanFRbExHWm1NTG91NXptRmgy?=
 =?utf-8?B?UEU0Zks0cVhobEo5M2VuNHZRZmRvMU92M00zMmt4SmJueEE0QjdDcTJyWDdH?=
 =?utf-8?B?Uk1RT0dQV2dRR0ttTUVzNHRoRDdZaVJqTTFIUDVPcllyZWlYOWRadFNtcklJ?=
 =?utf-8?B?VE9TWmQzL2dxY3NoV1ZUT3Q3Q2hQTElKTy9WV2tZYlc0RktzRk5jWHdsNElo?=
 =?utf-8?B?SVQvMHg2MEZ5MGluUnNsOVQ0QUwwTzJ4NkhIcUM0elMyZXh6UWZmZUJEQWxC?=
 =?utf-8?B?cllGT2krRVlNQ1l5d3UrYjlheUNibmx5WW0rQjU2MXZRNjV1UldqaUxxRC9C?=
 =?utf-8?B?eU1GMEpVdkxQWnBJL3FjRkUyaTJ3bk1vREF1UXFGck5oL05YbG1DaThKdVVn?=
 =?utf-8?B?MWtzL1FQK1gvNTZIUW5XZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmxSSTAxTlEvNEcwaDFEczdtYXpsUHRQcWdYbEVxWnpJR1NneDNTQ2dEeHI4?=
 =?utf-8?B?eHdHS3ZNNXBUQUFoZTh4SXpxMkY0VWZPZkhVenp3aSt3VWxndXl0ekJWV21O?=
 =?utf-8?B?RWRCQzVTQnFrckJMTGIwWDJyMnhNNk1IWnY0TVI2aTVqMmtqTk9INlQ0dXpY?=
 =?utf-8?B?cWJaM1N4bUdJSEg3VVZtdXVxOWZ1L0w3Q0JLMnN5RTUxSWtSZVowelp5TnlX?=
 =?utf-8?B?WCsreW9xM2p4NTRhczZ1d3NMdkdBRGU2N2VVN1pGSWpmaUFncEk5VHJxeldu?=
 =?utf-8?B?dk5LQlJOTDg1NVJzdnVBSURHRklGdjc2TUsza1p3SHl2akp3UFN0TWtDWlh3?=
 =?utf-8?B?cVJPTmx6Wm0wK1I3SXd0bmh4RnNhd1hmTzl4LzFOenAwMGJCMm90OTlXY2Ra?=
 =?utf-8?B?Qm5VdHROZVQ3Qis1Qkl1bUpDVWtDbnhGck8rbnJvV1ZtUjhnNWRnYk91Ymdo?=
 =?utf-8?B?UGpKNXF0d3daVmV4MVdneHFrZFBTL3M0SDk0TUxNbUYyN0hYdk5kL2VJMFI3?=
 =?utf-8?B?dFJvTWUwWTliaHNlQW1ub2FNc1NzckVjZXFudTB6b2hLWHMvekhYRzU4UlRk?=
 =?utf-8?B?YkQwV1FneDU4YWJxVU8vcjBHVU1rb3VvMHZ4R1dEZmdIRm5xeStmKzlBaXlx?=
 =?utf-8?B?QVlYWU1sbGE2dkRVb0xvUHZwRmxGY1RWcXFwei9IckY4V1V4eHVUWTVzTiti?=
 =?utf-8?B?NVFxL1BpRFZNNTNncXIvdXVnTWNVME5PSFg4UUpEOVMxK0hROUdncHA1RVpu?=
 =?utf-8?B?VUZaVlFMY1duZkl4dzBXVmJoSFhvcWhJd3JpOVNHVStBSVArNkJVZWlVdVZH?=
 =?utf-8?B?cVVQa2RKcG9xY2ZsNmxMNGU5SDk1cklyMlZJWk1oSjBrZjV5L2JZSUNjYkFX?=
 =?utf-8?B?b0M0dW9HM1hONXJkSWVCbkd6YUtEaTQvdEFkV0tOQ1phY2lGQ09jUVhZaUNq?=
 =?utf-8?B?WE5hRTVRWFNFYmhRZzNqOE93UkJyM3hFaDZMbGF2d1J5UGt6N0VhRmxzVW5T?=
 =?utf-8?B?SURyZW1lUFk1Q3lXK015aFQ2dXgydDh6UEFZSDdtbzhhMkJrSlZGVlZZTkdK?=
 =?utf-8?B?bktVSzZ1YTFnbnd5dWMvdTFRQURaYjhkMzZpSG5WZCttcHFVTjRCd2JlZ3BN?=
 =?utf-8?B?UkpaVWlrWmU1WWc3TGxOSC90ZmFMcEdIb1VvN056ZjI3aXFBQjFOanczdlkz?=
 =?utf-8?B?OWcrOHlYYUdTV09nZi9yZGpXNWljc1RhYVlVWFZ2OVVqaGM3S0l3MEJOa3lF?=
 =?utf-8?B?UVU4UVlzdG5EcFNIVk5MZnluMXRFUHZwVmFldUpIcG9rR0RNa2JycTBBNHJx?=
 =?utf-8?B?TzB2aDBjZTRCU2RTNWVkSm1jL3VudzhwWTFHdW9xL05kb0NCZElZUTY3cjU5?=
 =?utf-8?B?TzR1KzhnUEFoanVIRG1sNGlyK1kyME5abUcxZ1EvNS83ejNjaDErQmxLOHQ0?=
 =?utf-8?B?S2FLTzl1YUczWGNWRlBMbGtpU25yV1dHN2o4RG1QVi9Ia0pWODR2bXFTc0dv?=
 =?utf-8?B?bzloZFExSmgwTWJZVy9YcjgvUDhzcXFsNGZMLzNxejh5dkh3S2lYSldPSnp1?=
 =?utf-8?B?c3VMWWZYRDlMYm1tQ2tIWTZGelNrd3ltMWNseXBnTzlEbVBrcjU0eWorNXdI?=
 =?utf-8?B?cG9vYWJSTmR2QmdWeGU0akdHSWFZOVdYNGdVaG1NZFlObmppR0Z2NE44OTdx?=
 =?utf-8?B?WVJSSXovRkRMQjl3aXFJWnpOa2FES1hOUVQyY09VSVRkUHp5VDdkbzAvblR0?=
 =?utf-8?B?dVhCbVRYZ1NRcWp3dVBSZGd1cG1qNG5wcHNaUUc1eE13VXdUSmVlQWtHQVdr?=
 =?utf-8?B?bmVUVnBIaXJHL21VUUxwcEx1RW45YkZMMmlvM2ptS0FmVjlFN2Ivb2szTmx2?=
 =?utf-8?B?U0J0TmxlUDdiU3JRSTJpMm1sU2RoTDh5VkFMMWNsTTl1L3MxSGhaczRFN2xk?=
 =?utf-8?B?S1RjWGc5THpCcVBVZE5YNGtiMlF5dVh4Sno3WGtaeGUyTUlZR0NDbit6dGN4?=
 =?utf-8?B?TWwyQ1dKQXNEWTVqZVpwdktaMXpqOE5zRlZsT1pIcHI2QUU5Qi9MZHhvanFq?=
 =?utf-8?B?ZUVPYVhEejVoMHMxdW5Ic25SVVhjTDFMdEFQN2t6Z1FJWEJsanVKbmlNUlhF?=
 =?utf-8?B?eDRWOFI3VkZHNlV6a2dUNG1xcGRUWWM1OHY1TTJxT29ORDZFRThVY2lJSFNm?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfad2121-f6c0-4765-5598-08dd356e4c80
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:10:00.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yR6yr5gIVDSUyq1KNVkXbFlHWnb0aigWwWRsz08G4PwtqsG+6MfFkUkexXOPt0CQCCIBNOOPjF5Han0MitJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3277

From: Jan Kiszka <jan.kiszka@siemens.com>

An overdue fix.

Reported-by: Luis <luis@eichitek.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/README b/README
index d7241a1792..897e90c7e8 100644
--- a/README
+++ b/README
@@ -2,7 +2,7 @@
 Where to start from?
 ====================
 
-http://xenomai.org/start-here/ is the best place to start learning
+https://v3.xenomai.org/overview/ is the best place to start learning
 about Xenomai 3.
 
 Also, make sure to read the per-architecture README files, i.e.:
@@ -24,25 +24,22 @@ Online documentation
 The online version of the documentation is available from our website
 for the current release:
 
-http://xenomai.org/installing-xenomai-3-x/
-http://xenomai.org/building-applications-with-xenomai-3-x/
-http://xenomai.org/running-applications-with-xenomai-3-x/
-http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/
-http://xenomai.org/documentation/xenomai-3/html/xeno3prm/index.html
-http://xenomai.org/troubleshooting-a-dual-kernel-configuration/
-http://xenomai.org/troubleshooting-a-single-kernel-configuration/
+https://v3.xenomai.org/installation/
+https://v3.xenomai.org/application/#x3-building-app
+https://v3.xenomai.org/application/#x3-running-app
+https://v3.xenomai.org/troubleshooting/
+https://doc.xenomai.org/v3/html/xeno3prm/
+https://v3.xenomai.org/legacy/migrating-to-xenomai3/
 
 Building from sources
 =====================
 
 Detailed instructions for building from sources are available at:
-http://xenomai.org/installing-xenomai-3-x/
+https://v3.xenomai.org/installation/
 
 - GIT clone:
 
-  git://git.xenomai.org/xenomai-3.git
-  http://git.xenomai.org/xenomai-3.git
-  http://git.xenomai.org/xenomai-3.git
+  https://source.denx.de/Xenomai/xenomai.git
 
   Once the repository is cloned, make sure to bootstrap the autoconf
   system in the top-level directory by running scripts/bootstrap.  In
@@ -56,7 +53,7 @@ http://xenomai.org/installing-xenomai-3-x/
 
 - Tarballs:
 
-  http://xenomai.org/downloads/xenomai/
+  https://source.denx.de/Xenomai/xenomai/-/tags
 
   Source tarballs are self-contained and ready for building.
 
-- 
2.43.0
