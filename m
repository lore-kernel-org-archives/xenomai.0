Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383824634F
	for <xenomai@lists.linux.dev>; Wed, 28 May 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418729; cv=fail; b=AlOL2yZHVZ1lyn6x5tiF6qycwgKFOPljiLNQNBbezt7vosWo5gIMaV8xNtI3eP94bZi/W9clpb2vNVMex8X1rtFsLLCNyh+ni/YDyz5g+KY3JD3vmniNXLxczFrk/Uk8D5bFyVCCtbN6y+XtonWSryUSRCKquXHK1BOZtduOe2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418729; c=relaxed/simple;
	bh=oXeoZOgyho8r+Ikkw+wipTT9xUsG8Q/5mTdJrGrg/Pg=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=YXE9Jw0EOk/NSCqOUKjymm4Dp+yZsFfnXN08Ry4H4P4Tof833P00pA9zdfpZs+2+EPvmW+jetu/V/UHo1RTw0g6SurAOZQwVNnh8hfRmFhNJUqwwh8JKiUrf+xS9LcY6MpHZxHCsqx7RThVwc8FK2rD3N5XnXfXajQm4V0GME/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nTeTdiO5; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nTeTdiO5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiXMsPXr7W37JFj+m9KHuWL7oBGokdrFnGo4H7AJi9Zthv+I6ZWiRwJsCY2Xq+lpcJ7h+WOZ4N8SPxbtC2z6tRug8pbXQ6kfvPITJJNpbFpDGq3x3pEMmVSGiw0syLD8C3BJujzBhVvLMira8DtkOvFK4fMJz3prWK4/RNaC612bVVdp9T9z3P3cM3KxNrrH1UYHH2mXb6SCBSD+Fb11BPR8yy0ONyiSpK2uYryDoYV+OQyd1AX3xXWGpGBrA5VNV+no+e7V2i8VND4jwAW0Qe0VhvPeQ/SLL1cNl4MSJKs6Yd/MleIzwML8jZVeyGMYRFnIlC/ebp4gDYWgLRm6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd8YKFteW6qaVnlIriYKOQeOVb5+cbcfDaHmZ0C/D/o=;
 b=WLNar9NA0L6w9aFH0NzdfW9bOUynr6sn5Bnzqf4JgP7DOxxPEYqWehvXq727w2XdIhmt9TBFiulrhhGy8pyhC20IlYhfZMeygnwrjpIpM0btwvfI37jA94Hd8tzHC3Ij5D2P8m5h/X17UTd2jX9dPe6cme4FFSiNOVZC2FgQ2d8eC0ILwuHLUGx5iFPov7b7wFT3V6Wyi/FBNKibfmvli+ZVD9vJ6DD76dQbNITz2j4MtJQqLK4RyyP4PxsfeOc0Twhxzc40H4xSeIZJRyH6AaichMlBwI4e7Ufz88GXS7xKa+A8n++HborSY5O80AEZa58D7+EG997EnMkXSKPG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd8YKFteW6qaVnlIriYKOQeOVb5+cbcfDaHmZ0C/D/o=;
 b=nTeTdiO5YBS7+/dybLo91eKQXPVf9DjDJWGfirWeaxkc9gD02g38PR5LAipf3yIi0PzyBMeEyr7LB1jkOdavjuOTQBeLMGIyuXxdfb9j7owe1C1QJ36qrXVEGlrAtOIBrOjsW1RoJw7O4gX05Tb6V6FfLG+ys2JwoOmj1vYtKAaTZoOfFcpwKIMSXPGnOtghZ6XzkCPIZWabit1cUMsT8H3RVSEthyDRyYdXTyuA5cfRJ9ahRigNd603Nd6CTdDXuBkErQ44Ij4qHgmS6RZLE4xeq5anj/3+KZ6fpmkoJPoTlq8S3trONUjFOgCNu2axeNB0Y1W3Z3hJRQs7zFINig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:52:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:52:03 +0000
Message-ID: <f851bc4c-5e90-4b96-9fd2-6b749000b18a@siemens.com>
Date: Wed, 28 May 2025 09:52:02 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v6.1.y-dovetail] arm: dovetail: Reorder fault_entry hook and
 pr_alert
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e47083a-97f8-42f3-44fa-08dd9dbc8902
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WExoclRVWDE0U1JaUDJBMkRJVTdRbUlITGQrNjBWUHhBSmlGajZVdy9VRnVz?=
 =?utf-8?B?bU5GeVhJODdwbExJVVlsaDY2TXJ0aXRYcFhNeCt1MXRYY3hzYzlCeVlTU0ph?=
 =?utf-8?B?MTRraFU1elA3ZlRaTDdFdG80UWxOWFZFNkZDdG9EUElldFFOZGxTazU0VUMy?=
 =?utf-8?B?MlZvNVFFQk5UczZLRGpaOExKYm1vZjVOWmM0TlJVc3N1UGFrKy9FUmpWNEU2?=
 =?utf-8?B?RmF4bnM3NWFjalBoeTRwa3BKRjBIWm9lQWVVMmFIS2RXMzdDUU5MREg1Sys1?=
 =?utf-8?B?ckdiTVRobVFpV0hWd0xkVWxDTW9zLzgvRVhVWVdiNGRhU2Jnazk0NVBkckRT?=
 =?utf-8?B?RnhFRklhSGMrT25OdnhZNnk0c2wzSkFGZGNGMTlKTXUydnlsL00yTnVFODdx?=
 =?utf-8?B?SWJ3Q0d0cVcwbXB4ZTQvQkVRTy8wTmNvUHM5N1c3Sm15MnhVR2EyWmEyWnNK?=
 =?utf-8?B?LzhpVXh0d3lJWVp5QW40SlI5QXpKWkkxc3ljb256VGFmWHBYUmVvRnc5cGYw?=
 =?utf-8?B?d3VUNlAxVHdkWlJsNVBwRlpxWjMweHNEaW9jUzVWODFMRDlRQVIxNU95c1dM?=
 =?utf-8?B?SHpzci8xSXBmVlhtRnRHVlRuSlYrK21MRDN2QVFzY2VUdVlBYTgyS0Z6b2VK?=
 =?utf-8?B?OGRQMFVrSEZFS2JZTko1U3owWSsxeGJlQ01YVzNhZFJ2VjdCaUFnMEJMU1Fp?=
 =?utf-8?B?bm9hSkVnaHA1d01CSE5RWndsUG1UWVlFNENUSFpXS1NYcGJhSThNSjNmNlBY?=
 =?utf-8?B?VHh6TUR4QURJTktBdzNWbk1kM2pJNFFmK1p4ZG96Q1VOREdZL0htS2I5M2lK?=
 =?utf-8?B?c3Q4L2ZORG5iRlhDL1pBOFo1bm9TQlN2eU5tazBzTm95K3dnVjNsT2xGTGlP?=
 =?utf-8?B?RS82U3JSZ3J1ZHBXQUZMSkp4b3dHVWFVTEE5Wmt4SkZEdE9neUJKSUlKOUUw?=
 =?utf-8?B?OGhYMEk1TnBBcjNkTk85cmlJcXpSU3JSQnRpeUlUbDIxbFZhcDhBOGtibnpW?=
 =?utf-8?B?QTNvVENTaFl3c0I3WkpKNG1mL0RQRW9BYzhTRGlLWi93LzZsSWI5ejcvNmVB?=
 =?utf-8?B?bzhPV042UWhNSUVJUTA0dGViVjJWSytHMG4wOVYxeHZGWDUzNWRGYWl0Q1pC?=
 =?utf-8?B?cG1UNUhuNGI2eW8xWE1oeitnLzhJWS9ETEtjZ2ZEYnRueHlOSEFFVDlhYUdL?=
 =?utf-8?B?T2h4K21XbzFibkh2dUlKK3Q4bldKQVNBcDRqbm1YWVhHb0ZmU2Q4dTZ5RmxV?=
 =?utf-8?B?NkVYMnFmUDNFRWlocmQyN3JyejRteWNVY09CWlNnaERjRC8yTEpRRnJEVUx2?=
 =?utf-8?B?d2JlR1RVSUFKUlQxamZpVkxXQzk3WjQrRUZuc3NSbk5FSjcwYlJyTGRRZG8r?=
 =?utf-8?B?TURmQVlweVJ0c2hYS0krWHBvMzNMVDdhUERDeTFGZVUvdENzbWdRQXdnY1lI?=
 =?utf-8?B?cGhaT2pXdSsyL2k5eEx6ZWl5Yy9WWGxDT3J2NEVHbDN4R04wOG4xSHFURGh5?=
 =?utf-8?B?c3Z0ZElhSU5xTE90b253N2lyR2NWT0pKYzNhOW9MSy9rRkF6K3g1TDZGM2Rw?=
 =?utf-8?B?SkFzbnI0VVhob2lrT05pcnlZRldlaDBKbmRyUWR6WWxUUC9RelF6eXdQeGN1?=
 =?utf-8?B?U2lRYVBQTmdpcW53bElLOHU0b09qM1RHblpVNlZ6S3VjcXZWaGo2QzN5eVZa?=
 =?utf-8?B?aHRCUkl3RmhPNVRHNXVyWWo1NUZ0TFhoS0hSa3ZJaXUyUHo2KzNza0dnK1dE?=
 =?utf-8?B?L2ZpcmltWnlLQjRpM1ZWeFdoZS9MR1A5QTVTL0UvaXFZbllDaGxVcUE4NmFm?=
 =?utf-8?B?T3VhZmU1UzlwL1pqakFRdnJBSEl6V0F2c2pibWVFK0o4RGQxdzBIZ1cwaWJ4?=
 =?utf-8?B?ampFbkJUU1M3OGZCcFZGLzNKNXRkVDF2alB6SDgzVUx5TXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnN0azZxQVIwa0NYVzJ1Y0svdFk0Z3pEWlE5V3lNZnIrbHV0d2J5L3psWEVn?=
 =?utf-8?B?SzZBR2pRVm0xalFlWHNYWmNUUjdHNlRUbElrZ0ZWa0lURVlVTXpEZWpxVmd2?=
 =?utf-8?B?azhXL3BrVjFxWUt2eWdhNllRdjBWWDkzYmRSNTRzNGc0clBSS3ZWVksvNWFl?=
 =?utf-8?B?OGJ5ZDFjUW1KMS9LUGNib25MMG1vY3NLZHBVU0w2dnQ1T1Q1SmdVVUM5eXM1?=
 =?utf-8?B?bGV0di91ZUh2K2ZpTkNXeUFwWU1ERHRPU1dPK2U3RlZ0eXRQbU5aSzZwUmxk?=
 =?utf-8?B?V2lqRFFTWEg3azU1V2VLckE4N0hMTnBPQnhlVGlDTkFKV0JHMUdreUJPYXhN?=
 =?utf-8?B?amZHODBJQmIrMVZsT2F1eWJyWnZSWEpybk4yUWM4dGxPOUYxSXlxQ25QQnVj?=
 =?utf-8?B?NVBKTUFXTHFhWE5wQ0pTcDBXWWdWT3pVWWxaTFc2Ym93Nk9OQmFTRDUzd0Na?=
 =?utf-8?B?Znhiem9wc3ZiZXZNZHBNUWtDVTdBRnJUekREQ04zL0ErcUNhY1EyQVRSTGhh?=
 =?utf-8?B?V0tmbUFaSUt5QStuMmdveDVNc0llbko3UFFhOVJJd0xISHpSVEdIaHorNnlq?=
 =?utf-8?B?Uk5aKzd5eTZZQXBXcEk0Z3dpdjRlRkkzUjJmNWNjZXlVbk9OaFlSQkxRYnlu?=
 =?utf-8?B?Ykd3QkVIVU5ZWGhCWmZ2UDlyWUtLMmdEY0Vmc0JrUVJRWDJPQjJmL3dQT3pH?=
 =?utf-8?B?SGNNck9WWWpiMGpNazlhMFFwRThhZjl4RCs0eTI4SFlYd20xSE1nZXRYc1Bw?=
 =?utf-8?B?WkdscEJpcHBJWUZnMExUZDJPWktWdEtCTElHMTgzQjNxaGNZekNMMFJ4dURm?=
 =?utf-8?B?SXR3UU9nZkp4Z3I2YmRqMWNTc2VCQzZCNml0bzlKc0pDWGZSakpLMEtLWU51?=
 =?utf-8?B?NFhZU1ZLRTZlVnRYd3FWYmtURXB5WnBvRjVUQ1MxRXk3elpldjdsYVFGUjBK?=
 =?utf-8?B?UW5palJmeDRoait4K3ZvUXdPTzV1cFBaYU5UNHF2b2w1bE01YkhpLzJoK091?=
 =?utf-8?B?SG5GbFhGcTQ1T0RqUUV4dEFneUQ4aFF5cVFTRkcxQ2ppaEhVUUdoTks5YWFP?=
 =?utf-8?B?QnRrcy9UNW9BYXhxdkdnZXhhbEFNMFNWcDFqU01aREpHMHErdGRyRFB3b2dx?=
 =?utf-8?B?aUxyVkZxTkdjYkRCa29JMlJiSFAwTEhKRUlPbzZTTHdzaWFsSDZlOHVtSGZP?=
 =?utf-8?B?YmZHV3B5S0tDcFlVTDdnMGFVMzlncFF2dlp6UEVkR3k5TEtzeXhmZy9WdmV5?=
 =?utf-8?B?QVRNVUNpOVJBOWdidndDQWdJMFArZEcvbE9oVExyVVhVbTdIendnZFFQVlZC?=
 =?utf-8?B?U09helpBaHVWYy9lQkxxdHdaai9VYUJuRy9pZk40eENSakUvTC85QXZleXZO?=
 =?utf-8?B?UFZiS1B1dEhJS1ZtaDh3d2tpblF4QUNRbHFybTZhaWVPbDdtK0dmS0VBSDhp?=
 =?utf-8?B?VWh6bDl4R25qQnZBTzlDejJkKzVSZWI0SjE5UTFNVDY0cE9aam1HQUlBbTJ0?=
 =?utf-8?B?UDJKR3hDOEtBT3JNMjVSTlhudk1SMG1hTU8wVXdtTjgxMGcwVE9USU43Mmlr?=
 =?utf-8?B?bW9xNGN4Y21yZ3UzalRENG83bmdXOENLc3lsSzRhS3hTdkVaaU81N09xYy9a?=
 =?utf-8?B?NFhaWm4rNHJnUGN2S3lERFJNOVMrSU1uMzZqbGZTWExzQTZIMDVHZFR4VmQ0?=
 =?utf-8?B?bmlXZ2xsY09pQS9OaXZqZ3RvQU9HNU9ndEcvTThUQjlKTGdrR1JJNys3YVdo?=
 =?utf-8?B?bkFQRnZNM0Vjd2E1WGIrWE5GN3ZsTXVJNVlMQ1UreWNpM0I2NWhpNlVuY2ND?=
 =?utf-8?B?VDByZHNWeWc3dzJuQncvdG9PTGNiQjBpMzc4UlhvWGJjbk1NaTlhNkZ0cGNE?=
 =?utf-8?B?bUFqOGwyNXhnNkVPVW1vNlBPVEhtdHJxTXJLL2tpUnFaM3NIMTQ3NWtSWStk?=
 =?utf-8?B?V1UrV1BWQVBFcm1WeVg4TUdEUmIyL1cyVmZFc3krbSt6MWNCRjVLNUlNWDN5?=
 =?utf-8?B?VjV1d2toY0RlWnBOL2x4Qy90RTBtQmFJcVNqVkFYQTJvSlJDY0J3ZHNvOE1t?=
 =?utf-8?B?RXlickNnR0x0SUExTUlpcVlnUmF6Q1l2NHhrb0tDdU5DdW1ERjNxbDFhR2N4?=
 =?utf-8?Q?TrrR1ZU1R1OCaCp2mM7t9lFtE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e47083a-97f8-42f3-44fa-08dd9dbc8902
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:52:03.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI7GQyC74FUnumoBtSqldg3uK5fPEBlA86sbwVxIAhOOg/fJ1RzNLBrnTwaUayBU4AfVaZoTsMr3rh5RuPPvsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8931

From: Jan Kiszka <jan.kiszka@siemens.com>

Merge fallout - align with newer kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/mm/fault.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index a8dd9254fcd5d..7775c5fda3aba 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -652,9 +652,8 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
-	pr_alert("8<--- cut here ---\n");
-
 	irqflags = fault_entry(ARM_TRAP_PABT, regs);
+	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
-- 
2.43.0
