Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CFB126F0A
	for <xenomai@lists.linux.dev>; Mon, 26 Aug 2024 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653917; cv=fail; b=cswp4Ub/lEAagd8jrbrHiyn9Gqa01FmYy4zxztAqxEWHOSRarkudZhEPr78CwvTQdLlFpbSgKlHsMnen+GFzsGKzKvsR4TRmv4p+doWA4o1pNiLYpcZOo3paewp03pUlNMf/Ps6YOQCYltgJXIEMGpLgQXe2KaacxhnwwK0prZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653917; c=relaxed/simple;
	bh=pn2gR/KQr9Ja6l7H5E+O7yn+55JYJOIgcxIYcbHhQTM=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=jIAHFSrBh/fmI1anNQtKq7Cubhuu/BYReVpjgbud2idOG08c1ZqGI48Jvq0e+7NnYzhAfcXAqH7PapGskLIl/llaegu2EMaHf4Yll/eCvkxxxno3Mh+KmlKMzxFVKBaiw0hyNcRKOr8So+XzUCJimqI4oFL6iksbdu5tRu66Z/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dcTNH05k; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dcTNH05k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6gfj1pTc/80AedhZmvmgY/XRNRhFxe6ow7d6Up5t8cYbzz5GXtJXDxlsfF6MIy1rEGSsI6ExeRl09vg20Kq2ZRf5HHO+M4Dv6KfFsK26PUMwISzJEoBeAErmX6v04T1vhLRdrj0qQJxea5Q3HnYq4J7qjRpKUmki3+JQXfHX6LfpritIvTP9R65wt224qKAwLuO+ArbDjvI1N+pWwVlqH1JJFRVrTPbImTEwbr5dvvVdw+1H2T14kFptTJN1sheFLHhMw79Uk3wQELeGfmQr2TpvEAQEwQkGGzs/gOrOYkj/pQ/8VXu9pwpxzxImyzGDQlQIX/a4SuFFGXkRejmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlrBzN628NogfQ7UYTTbBUBoewi7/beA8xO6+ucDrQI=;
 b=Tdo2n2LwuNrIF1UWzNDkdbgawzwBm2QJ0bC3L1Jf3BEmv7ibWl2/TZHHaySHOP7uCh4mJYLjr96i6F8KDUVVne35u8CCQFW/NA5b+YBHisFW7cv9jJnS7C55IrdVCQFrmIPGaaiCBRwDdS8TNOHlDGyLp0gre4rkWO7UDPNLBokwSEk+Q+slHVQuY5D21l8j/M2phf6aMLo/TokR/Gn9E5FzQzuVGzQiNsOeWcGil7L2jBUSa5ReejbtA/PGywmx9bzs2hnaCHLvEIef7FuqhCw6zg3mWzrwNvm7uAR0AH8jgkdMGouKeMeZvnUSKNS2etO0IJKx7YogjSJP49XGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlrBzN628NogfQ7UYTTbBUBoewi7/beA8xO6+ucDrQI=;
 b=dcTNH05kdrVvtYVV0La42LWakErQePi2nu47HVHl6wF7gpxC6Kys7mCRR81kpOXmuyJgJo1o7YoLthOvvFiIcz2GOYCOFQMd2nc1z+skwFbUAJv4YNzn51TGlpW2ZVw5G1ISFkSy9o0BxiocbPI+gzfLpffXWQCPPClo0irCyw9vLoar4fRc+1/9Hu/4i2utfZ8TGCZ7U3ZK+oIxrWBlORS8TMjQghImDUsEx9kImUc4F8MQLzgNVe3ylIPX8dm9n0gMjIGs1+GB8tU57/5+5TcNkw9UMBBO3Yh6R+pCiHJmZAr7aeA7x12JKnDxXCZUxRPXfF+hYcGLWNX5WOffpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:31:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:31:50 +0000
Message-ID: <24868b62-2aa9-4f06-a20a-c1c0dc2ba164@siemens.com>
Date: Mon, 26 Aug 2024 08:31:49 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] dovetail: Account for invalid syscall number
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3842:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2da556-9e86-49b1-2886-08dcc598c4b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXVPK3o0aWVuYkdJSDlUdnRVWWpPaGR0ZWdLZTFWSHVVckR0dWJoT2RTczRs?=
 =?utf-8?B?aWpJelF1VnQ2Ty8wOVp3YUtLRjZQYVlhS1J0UWhDREJNc29wT0RoZ2g0M2pa?=
 =?utf-8?B?a252ZmtuUjFJNjdDOGg0WmlKQ0RDTlhNUEFOZkhrQlNVRmF5MGM4QVJXVHRE?=
 =?utf-8?B?K08wcU94UDg1dzAyZEpMbmJWV1hHM3QwYy9vSDBrN2VUZXdzNTh1VFFEcDRr?=
 =?utf-8?B?ZndIL0pjUnA1d0N5U3RIUWF6ZEJQUDFlbUdQUWsyTFhaNlpjVWU3WG9leHV6?=
 =?utf-8?B?UVBQN0ZsR3BsbHlHclNibUlNSC9jTTNkMlFqU1NUcXQvUG4xOW1zbGRjUzZ1?=
 =?utf-8?B?d1VrTVdSYUQrZGhNMG43eVBMN1JzK2V1cnUzTzQ3SnU3dURrbWdqTmoyQTBm?=
 =?utf-8?B?WVBFd2hmd291VDBHdldkSkl0TmloeitsemZEdmlRQnp1WENwM3hDclpmTFVH?=
 =?utf-8?B?SG5jTzBNMVNzQkNBd2hFNFAzWFlRUGEzOFZ2S1pFVVEvMDdESUMvbXdBOThn?=
 =?utf-8?B?TXQ4eU5DeVVqTzVIc2hIUzZKWkxvZTdmbmd3NnhRVXl6SU40ZW1SWXc3cXdn?=
 =?utf-8?B?VDlkQk5UUGlRMkJZMDV6S1NEeUM1bkpyRG9rUjd1dUd1RjBuMWtvWHFSMmht?=
 =?utf-8?B?RHg2bDYvUWEzOWpaZm1NdW5oeWtFU0hsVnYrUFZQTkM1UEpvZXlpQzc3UWty?=
 =?utf-8?B?OWFReUpqTmdvTkFRY2xGRmhQV2JTdVdhZDlnNWU4ZDltQ2UvSmRoUFdMUERw?=
 =?utf-8?B?aC83cE1CdXVGUHU1RUNsd2hFeUxlbUtrUWhpN1JGViswTUpjVGdHaEwxeFcr?=
 =?utf-8?B?dnFpWnhiVmRFQkx1bkZtSGZUL0tLKzBpSEgwLzhFL01GVjU4dkZZVHMzeGly?=
 =?utf-8?B?VllGZVJLRkd3MkN1ZXMxV05BTW9GLzkrdS9lQlphY1pHSkNRK2pqYjIveXh2?=
 =?utf-8?B?emo4WlJ0czRma0VncHZ1dGlFZE84RWlBZXV5ME9qcDUvNzMwUmxHUzl3QmdE?=
 =?utf-8?B?Q2NxTDJOVmNBa2dRQWIyWHVxc3FadGxpTkhOWk4wNTMrOUc3aFpTU1RRcHZW?=
 =?utf-8?B?QTNHZXl4cWxZVFZsQU1FZUxac2ZZVVpBS05SNGVjdEUzUE9lUmxOK0RXOThG?=
 =?utf-8?B?cGJ4aHcva214V1RZNGU5QktHenBkd3I3WTRHT0NZcEFOaGcwVWxUU1RmLy9G?=
 =?utf-8?B?Q01UV0JZa0MzajVGOE1YSzJwUG1kaDVlSWJsaGNQT0lTc0hJR29UM3JKTnFB?=
 =?utf-8?B?aWI1c3NTZm11bGxUZjJVSXQ0SVpldGJhZjdGenZtb2I3VWFmVDNJcHV5WmNj?=
 =?utf-8?B?dWx5am9uNnZoaW5XVTFabmMxUFpEREMxaW0rQlRNcmRkZUlSeVVudTFYN0cw?=
 =?utf-8?B?aGxwcDNidVVlTmhLSk5BM1M4Nk5EZ3BYMEp4RTNrMGtTMlUyWGVLT2FHaGMz?=
 =?utf-8?B?dkszeStRa3FCNWxuMlRQTEMrdW51YUk3Q2ZOQ0hhc0F2NFNmeG1UYUorRUgw?=
 =?utf-8?B?c0pxczZldkRicHF3ZUFBUWdzWEZWN0lWRlJWN2NkTTAya3BPaitNZ0VjWnhp?=
 =?utf-8?B?ZUZRVTAyM1k1eUpHMzYvZ1I2VzBiOFFWbnhMK2xxNmlYZHQ5RERYNi9ZNlox?=
 =?utf-8?B?a3JQcFZ0SW1lNHhURDljdEt6d05MUm1mbUVQRFhRZjRCK1BaRzZPdUUzTi9V?=
 =?utf-8?B?UmpYRUJ4RDIwTk95UFFkemxnZlZ1Z3g1enhUQi9NMWFmWkYzN3kwZnl5TlUw?=
 =?utf-8?B?dE5DY2JHajZYZXlvakRxdkIwbTF1WnBjM2ZyTi80TWJUUlNoc3grRmZUd2pn?=
 =?utf-8?B?cXlrbXlwbWJycEJRcTVOZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFZIUnB3ZUNiVHpkS2hlc2U1MGFhR0Nxa2tjdTlWY1BtTGc5djAwRitsOFp5?=
 =?utf-8?B?UC9xSE9ON1hORi9PTmZhZ1cvTFNmc08wY0hhZ0V6N2JTU0NqY3loL3N3ei9C?=
 =?utf-8?B?cmo2TWZXY25ySDNpTVRCODhleTUvdE50Q1VvRVo5QTJJRWo0bHF3NG9YVHU0?=
 =?utf-8?B?cmgwclZYdEFPR0FTN0tFRDNhUzA4VjNzYzZoUUwzVHZZR3IwMGZDRVA3UG5m?=
 =?utf-8?B?dDliMUFRSXFjZEx0dmNmQmZ1ZTZrUkVpdlJBUFVvV1NVTlcwZWN4L293TzJq?=
 =?utf-8?B?NmtQYVRxVi9sdU0ybXlZQTdiaXgxYWZUbldLMUxUTFZSWG9oWnBnVGtBb0Nk?=
 =?utf-8?B?REZPcE1zQXhHMC9rcXVZcktpSnJHbkszbFcyWGpNUmRnc3A0ZVFQVWc3eEVl?=
 =?utf-8?B?eWovdHdDZExCRU1zdWdMZU91bWhhdSt5V2wyUkhyejgzU2RmYjlrM296bG9l?=
 =?utf-8?B?RFMvOHpWRnI4ZmRza3V4OXNkUUF6NkJ3YXNXMXQzYTdqcTNPalUwSXZ3dW85?=
 =?utf-8?B?aXpVTHlUSFgrYVFQQWJyODREVFgyT2lpNlFiT1FVUUxRaXVveWtyNytWUjVL?=
 =?utf-8?B?OXd1dGZjYnhjK01XbWthRkdKWnRtcGtzeTkvbFFYZGNWUkpSODd3WFVFTC9u?=
 =?utf-8?B?V0l1eW5jVVZEbHJXSXdFd1JSOTg3V1k0cFJvS285MmJKZFVJSTI2NGFHampa?=
 =?utf-8?B?Y3JDcHpEeFFCeXZtM2VLcEVMVzQvMll6NTEzUjdFNE1IYlpjL216em0rbXdh?=
 =?utf-8?B?Y2RmcHg0Yng5d0xQSk5NbnZyZU1UakZrNDdlbEZFMEErVDQvSVgrZVdOVGRK?=
 =?utf-8?B?aEFiWU9TSHZDemRsdVhQcGoxMUR0Zkd3THp1dG5JL2Z1QWI4dzZuV1U4ZGNl?=
 =?utf-8?B?WE91RjJhRHlFUWVTZkgrM2loejZCeFpXUWJrdE1XYStPRGtneWx1SWhlWTRv?=
 =?utf-8?B?UUMrSmZlZGNxRWNFYTloY0phRmZMVHBqb3E4V2I5V0tjd01XNWVvMmNRd0Zn?=
 =?utf-8?B?NWNtcGtVb3ZCL3kyOUNIbTF4TEJHQ0oxajAwS3REN1JGTWlwdmNsc00zQnBG?=
 =?utf-8?B?MGQ5VzRWS0pWMDFrKy9wa0dsRC9PTmFuWEpxaG82dzkyT0tCejdVTUFRelNi?=
 =?utf-8?B?YnBMMzRBMnd1Y25RZjZPdGl5M09aU3JMR1VQL0NxVndBb0w3b1RIeE02TGpv?=
 =?utf-8?B?dGZSRDNkNDBoeGxyeEt1TkUwRWEyWTdYRnJxdUFQOEpQeFVqWXNOZTNjSTJX?=
 =?utf-8?B?WmpQNWpLWGFuL005cmh4RnZnT25yeVRldHBhUXNFVUpzQmRIaDUveGRwUVh2?=
 =?utf-8?B?OTJpY05vZmlsVUsvUHMzbno1b21IWFd1a2p5dUlyeVN0YUdxV24zaHF0Um1u?=
 =?utf-8?B?VWE4QU8zb05jQnRwZW9XNXhuQW5hS3lGM1NPNWIzd1RBbU12dUMwdHVrOUVT?=
 =?utf-8?B?ajNKWWdjMlhxZWl0TWFkR2ViWmgyS1lkM0FtQnUvd1Q2aXg3bmRUaEtrcGRS?=
 =?utf-8?B?RkR2dEpZNzRvcTM2SFdDQUx2T29lcnU5ekFSTnhZME11enROU0xYSVZYcXVo?=
 =?utf-8?B?ajh3eU9GMDZEb1F2QWtsZTNvMFVSZ1ZmdkdTSlpkMkVkMEQ3WVkrbWdIazQx?=
 =?utf-8?B?VVZxWDR6VzFGcFBXWlFITnVyWXlPM05OT05sOVpJZ0RLOVY3b09GdDJldUpt?=
 =?utf-8?B?THNLRzNYVVA2ZHhBK09lNzQ1VHBTNU0wUkRzU1FuN2Y2VU03MHFHYUJPNDdH?=
 =?utf-8?B?RHBhSU9UMHNzaFhoK2VQbVU2dmYxN2FueW9DOFY4WkVUN3N0dG1pb255VlBs?=
 =?utf-8?B?RHNaSTBTQkNXcnF6bHBXdTE3VGNUR0FHWThRMzQyU1VzaXZXUlNGK1BYYk14?=
 =?utf-8?B?NlhmR1hVVmVud0ZpV3pXUWZVbkE3djcwTmJHbjVKaGN0RE13WXlKQllJS3B1?=
 =?utf-8?B?d2FyUFhvY2FvclVuV01WS3Z3SlVlVTJoZTFRQnNFOGgxOExjZ0hyQUNveCtV?=
 =?utf-8?B?RCtUYkpxdWo1Z1pvUzg4Wm5ENnFkUG84MHcwYnlQNGNPN1grUjl0dnpmTDI0?=
 =?utf-8?B?SnBxR2NLYTJZeE9PR3dZV256bytTUmFNWW9scGF0a2hxM2JGN2UwZ2JVTHpk?=
 =?utf-8?Q?vjoYzssGuLhuysPdk3u5vcwen?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2da556-9e86-49b1-2886-08dcc598c4b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:31:50.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MY23D2uAfA2JxPxWs4Uhi7i648IlFqHY6NMzeRUWUZMdxD1KhxKOAv4zrAoDDagUhFiV3hRIjW8o3bn+BA7taw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3842

From: Jan Kiszka <jan.kiszka@siemens.com>

At least on x86, the kernel may have decided to invalidate the syscall
number while processing it. Avoid that we process this -1 as legacy
syscall.

This was a long-pending issue in the whole dovetail series, now revealed
by running auditd on one of the test systems. Syscall auditing was
eventually catching an unbalanced tracing, caused by a premature syscall
exit due to this bug.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/dovetail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 08c649d6e9d9..bcd49183f8eb 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -119,7 +119,7 @@ static bool __in_oob_syscall(struct task_struct *tsk,
 	 * a PR_OOB_SYSCALL command (new/current call form).
 	 */
 	if (IS_ENABLED(CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE)) {
-		if (nr & __OOB_SYSCALL_BIT)
+		if (nr != -1 && nr & __OOB_SYSCALL_BIT)
 			return true;
 	}
 
-- 
2.43.0
