Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC4234973
	for <xenomai@lists.linux.dev>; Mon, 14 Jul 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485054; cv=fail; b=mSL4FddEAgvGPuLg1B9572QmQkINNRpt9wiAizo969j6I9sQJgFGaRMxY97jbk5854ZWhwYK2TF0j80jqDlGzIo//wVswp7kGrYjKDwIgkmgZx7i4NyHUnxb3nTXFTYHwNLn/eBDA1zECrUkVUuqV5OHy8yR61bwlplT4UU41HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485054; c=relaxed/simple;
	bh=Z3EJyQZawM2vGomihGDDP0Af9FSmQcE1gsDXbhHeHys=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rU1lhbbI1RM4PSseilRjV2s+Ja6nt99QjZenWbsvK+tF4SQ3w70VntVNo9FNZR2gh+akVK8FXb7rmKOCmbXes7J3CANezMgZQp6JSZtXyu/y6k7KmIiJNmKw9SIHQenBt+P3FEP5B2p9iE0WA0Jo+H5mzIvbH0suvsjiB4BpoXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=F4tDPh/Y; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="F4tDPh/Y"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id DE3BB43537
	for <xenomai@lists.linux.dev>; Mon, 14 Jul 2025 09:24:02 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4F92A7803D2
	for <xenomai@xenomai.org>; Mon, 14 Jul 2025 09:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0XAkGeQYOXkKAQj0WqwAE+NFwOrsy4DP6t0kBw+/b2bqq1Gr/fM7BYllMyWWUgyR6kYplHb0poFBAiPLOUCvSuszKR8Ga9aDR7r+OBxd8+R7WGnQ2b10dgvKeUcFB2MzzXO8btV6wSnTLintq9QV2x5cuuOiR5U5XdfMPUhtSsvIzZXVyWQd0BgMa1YVfqE2Sj1b8++tXWfuII/mxPt+d/TYtpsiPU0xF1+mDNdafxYHS8dzL6C+Syo4y1hn4ocgHi70wH6U6kzAYYbTaVqtjLT2vQ6u5MIp7b3pz9w88p/yF/NZwlk2zl2sZK60Mh+Z+D9ssXk2CbGW9VlBFzf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVELzBN4zWpVwr3HnOZUiXBuh0cXzn7aZX2ZTxbQ4bo=;
 b=WB/UBGljWmP1lpY48/cxBsoOBmvgr9MBNfe9dmMRJTMXA0Xd/FnBE8B6bxZMRaDJjGGwYNj5pKt/chcjcKQcrTI6LalSeUUsLczQ48Vhi3LCPH/ZPWgcixnY0yKlBrHf7DEh/35HVEeaTGM5ehCPohWPJQ/pAyXUhIxgtkQ3RPA9WO8eW3Kkv3LnwhbMJjHGJwBfg8cu4sheLBUfGIsYG11S5mksPZXVeyZCBtG5MycOvWzMvEtINrFGcZ2rUjM1DF4zM39/SdgqvTwRG3cbU14cJ2w6Cp/g95QulguKATG2J0lmPJHExbVXlXO6U+Bp1el1NQTKEfAMiPYbh4mb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVELzBN4zWpVwr3HnOZUiXBuh0cXzn7aZX2ZTxbQ4bo=;
 b=F4tDPh/YZhifRlgGhc2121rK1dHhBu9lEqEoZ+hdjKf4AKP4KjZWmbqObKRC7H4G/Iqrt0tGpMtM4vIMhixPAv3yzJWiq4iXH+UrIYip17oyiuLtSPd08qe9roy2jMnGWCT6b4uXFMuapcnkkJgbEGZ+YOGJfNlG6YSPMCHi+6rVHwYDBI1zaYQKgXnqIxkGe1hG1gmFRFo+esmJd1wHbDZBxI3GSVdWCWVLheJ+ikjfoZEiqMQj+SuYXlQWBJdSW/tteD9YAq2JjQAWmvYmrGP3Pfp/ZtrlUIeqd/eQt8Uod3ZbElB0t+fgwZhz1tExzEWY8cQL5LCbLDonvyMJZg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 09:24:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:24:01 +0000
Message-ID: <b10f7b2b-33d6-459e-9c40-f67374c1d5ce@siemens.com>
Date: Mon, 14 Jul 2025 11:23:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: rt_queue IPC Error
To: =?UTF-8?B?7Iug66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Q=?=
 =?UTF-8?B?7Yux7Iqk?= <mincheol1.shin@doosan.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <SL2P216MB1358D5259F6E62AB410BD9CBA954A@SL2P216MB1358.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SL2P216MB1358D5259F6E62AB410BD9CBA954A@SL2P216MB1358.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3603:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b2f399-d5d0-4eb7-8e0a-08ddc2b82b4c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUdTSjBBaFRHbG1JMXc4NW4wdFRKem5IaG9WRXdPNmgyc0lhaU9EVnpJOHVw?=
 =?utf-8?B?T1FYU3JTYXluOHlqeHFOMURJK1lmWXlBVk5hMWJZcUNIOFdjc3FOTWFkRnMz?=
 =?utf-8?B?RC9iWEdMdXVMdTJwM3pRclVLV2VaREJ0ZjZpSGV4eEx4ZklBVkx1dE5jTkEr?=
 =?utf-8?B?VVQ2b1JaUDN2dWdCYVF2Y0h3QjJTY2xWN0JlUnRZYkNrSUFvU1cxWVhPMUZp?=
 =?utf-8?B?V0VZcVg2bEMySmgwUEhXRHR0MGlVMGdwcWZ2bk0wNm43R3dIaHl3UFY2QnlN?=
 =?utf-8?B?eGZrbEE3S3V4c2dEY3RMdDl3RDR6VVk4YUhKS0ZpZ2VWWDZWUVV5d2t5aHN2?=
 =?utf-8?B?Mm1HVWh2NGNvdkJ1L2NOZGFoT0FSa0NUcFppODgrTHNSa1J2SXoxdGY4a2tw?=
 =?utf-8?B?R1dGV3FGVXZOZHhVZTJQZWw5OUg0aHRoeGhqaTJNYytaVTE2SHhuSnRhWXBB?=
 =?utf-8?B?S25QdkNWYSs5WWlwS3NIWnlVOFY4dEozNUdUdVkyTHA4RGlleGJZMVR5OG9q?=
 =?utf-8?B?OVpQU2NFQ3lnVW5ucDc3ZGpTZXFWRUlBVFRHT05tdnJHSlZVQkp5YVR6THVB?=
 =?utf-8?B?Z2hIZzFuSFZhcWJFWUhOR0JWSTN3SWdwRlpady9GcVFvcmJMaUVOTmtZKytR?=
 =?utf-8?B?bml1NU9aOUkyOGs0SXE2eFJzaysyVlhiK2Nhc3I3b2VQckNqazd0S2ZWKzE1?=
 =?utf-8?B?Sk1hbnRLM1ZQU1V6eVZ3dzgwL3V5Z1pMVkNKcFgxTVJkVER6UDVQNEQ2Z2dz?=
 =?utf-8?B?bHpqWkJ3eHJnSXVPSjdWVkc3VG9HY2ZubDhpQkJ1Qk8yYXRxYVJ3UW9wUVYr?=
 =?utf-8?B?a2hSemVFTm1wQlBRQVdrTHhhb0NUK0VsYUQ1QmhyUVBRNGdjNHJNNmJ5RXpP?=
 =?utf-8?B?MjB4eXlWSlc4eHFUQjZTRGkzZE1abUUxUmtvanFPdmx3YnZpcDZRU3A5ei80?=
 =?utf-8?B?TUdZR0lqNXFwaVhzTjNETitxWnVET2o1THBUbzdvT0VTb2dpU0d3SUJIY1RW?=
 =?utf-8?B?VmIyMFl3NnhJZkl2U1E4RXBTY3lJb1RINGxqbElIWGRaZ2ZQWUllZkQ2ODhv?=
 =?utf-8?B?ajI5Y2g2aWlURzNVRThJem40QXF6QklTdFh5M0xmQzFrbFAxOUE0ZFd4TlRa?=
 =?utf-8?B?R2NNajdkTzBJQkNDMkV2YjBjYTdpTm43bStRdWhvWGpLOWtud29XNGJ1cEVL?=
 =?utf-8?B?cVMzVEkyK3JoRUNRRTIvUm80aU5SMHIvQTVBcjk5bm9uaTJLTUVvdnk3ckhK?=
 =?utf-8?B?Wk00bU5DdkN0MGQwOTcrV3o0QzZjcXpPeGxBNlZYVGhhTnYxaWxmb3FFMmtn?=
 =?utf-8?B?ejk1SUEybitDR3hEaTB6aGVONWk3OU93R3JaTE9WbnVBNVhVR1AzNXFyU292?=
 =?utf-8?B?b3g3UnVYUVU3eER2c1BXQlpuZEFPQXV1Q29mQzNBVjJEYUs1akFjNjA0SHdr?=
 =?utf-8?B?Y3Y4UjRkRGdWa25nbVRCc1dZQzVjZi9ISkJ2US8yVDdTSnlwVTNrTVZjdzJs?=
 =?utf-8?B?emQwQjVjUXFrVHZ5VU55Q0VZZjBhYmJ3dHVybS8rRWtVMGZnZllFMFZibUdz?=
 =?utf-8?B?bzdQMFloQS9mRXlNM2lId25mSFE4Mk9xT3E2ZkdTMGZMcEI3NEx6THhqOVYz?=
 =?utf-8?B?WDBVcE1TYUJWUmZBRVdoMUZDMDl5bjd3TjArZ0ZBdzVaSXpEb3Y3OGRMcGhm?=
 =?utf-8?B?UXdXSUI3dlJEWjVLWE02ZVVkVTNhOUx0a3NkUkRXQmdnRDJWOUZjbG5UbURX?=
 =?utf-8?B?dHdrSkJEdStGQ0x1Q2FaTWFpRnI4VmJZZUZwTkRsdko4cC9tNTE3NVlXSnBx?=
 =?utf-8?B?RHpSQVU4a09xRFkrdVhMZDcxZThDSXB2MkdtbDJXU05kOXdEVEIrS1hNSDVR?=
 =?utf-8?B?WmJ0Yi9FZWdiMlZWSHBaRmRpdXhrN0o1Ny9xTXRxZnBuRjBXNVZGUm5Bejhu?=
 =?utf-8?Q?T6fBZBwAOD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXRweDZkL2V5dTA2dDRNd0VleW1aYWh6L0JjOVkxV2R3NDlXb1F6T2t6UFh5?=
 =?utf-8?B?b3NRTkdZZ2MrQStQbEE5VEJFU1JRN0hobE9VdW9WM1dObldXZ2NFcjNPdGdz?=
 =?utf-8?B?S3N4a2NtUVJlaE1aelNVOEhWYlgxbklEUlhXckxtVWt3c1pHbVlVYmRJY1Qr?=
 =?utf-8?B?RWgxVEVrRkdUdDFBTmpBOXNRWk82bTJ6NzRmZ04rMFUzeVdoNWZ1QWJlSkVR?=
 =?utf-8?B?SnZrY25VblErNVZaWStxMWl3dzk1cUJQMVh5WkZ2R1dUM2R0b1ZRaEVwVCt0?=
 =?utf-8?B?UWwyaTI4RTNNRU9NZFZBNDh5NWk5NUw2T3dHaHgzN1dkbCs2Y2xmN1hWWTJM?=
 =?utf-8?B?dkNMM3ZKUEh4SEZweW9lU09saGRmbTZ5eGtMbmZ4MXdwdWdHTjQva1NZYm8x?=
 =?utf-8?B?VGx0Q1pDTklOT0xOWVYrRlBUZ0tKa2kvVGJRWFNWNjRINmNEc1VkcnBDZGJO?=
 =?utf-8?B?Q1pTcmljaEJBc1d0Y0s0YmZYZ1NUSU9KNC9RWG1qL3pSZ2xRbU9mZ3J4bW9R?=
 =?utf-8?B?d3ZoZlJ0Z0dEWjMwQmtFMGVUZHovcWc3TWhvdlNOSHN5ZHQzc0ZodGlFQ3Vu?=
 =?utf-8?B?NktVNXBxdTJnT3VESkhHL1MvUlZpMGl6MytsTWpuWlVyazZoZ1RaZ2xwUXpy?=
 =?utf-8?B?NjZ5WTZyZDhRMjQyR3NDNmU3TmllYWprdzdlY2NtcTdpWXlMUlBsZEhxcjZl?=
 =?utf-8?B?c01CYTVvdy9rK2s2bklJOUxTQnlBWGVla3B3c2k3YXN0OGpTOFo4R1F3WFZk?=
 =?utf-8?B?OHdHaUxUMXkyRGkrS2lwZDlLcVNLUHc1TTRkSDVhYlFtUFhBVkZTYzRiWFl4?=
 =?utf-8?B?TUhzWWhYOUhFQ2F2dGlHUG9DZmdOVklIMGlhd2wwTFpaOVFvZHJlZENVeWxQ?=
 =?utf-8?B?WitXWDgrcVNBb3pmbmpxd3dZN2djS2g0MU9ZejRnMGtzb3VJS0g4ejdId2dH?=
 =?utf-8?B?YVlBZnB4MkVIb01yRjUxZUQ4eFZ0MDBoeWxkUjFGMlpYZW1rSE9KT2ZxeU9i?=
 =?utf-8?B?b2FxVzA2QTQ0VGFmV0NJTElWZzJqOWdUcVEwYkpiZnlZak9vd2dWZHFuek1M?=
 =?utf-8?B?TGluamYyRzQyL1Z5c1FpcXdwcVpCbXNjVlF2WHBINjF5NncrbUVkOGVXWnpu?=
 =?utf-8?B?Z2JjaGhNclh3QVRub1haUE5BT2EzZnJmRVJ2NWRwRm95YjhMazVpRGl3MVNI?=
 =?utf-8?B?VzlNTWE4ajFWNTVsOEFvRVJzcDU2TEtVSXphVHNYNjlXWFdSTHBhcGVzS0xY?=
 =?utf-8?B?WS9YUERjNlJMb29iQXRRZkltSUhMTkFrZVZsTlhQcGx5di9tQkUxdmg2QXBK?=
 =?utf-8?B?L2JxeFJHMFhHd2hiVWNBYmxMUUJKYkNIUExlcWdZNWdnUUJFTXFlZ0c5aDdz?=
 =?utf-8?B?TzRidWt2aTVzekNpMXZPMDdLQnNBeWRoUkEvcFE3LzZsY3B6dmxNekYzemRU?=
 =?utf-8?B?TGx1U1V2ZVAyZGdqaFpiV3NKQk1qbTdGd1VkMng0dStodGdNVDRYeDh2dys1?=
 =?utf-8?B?ZllZa295aFlYY0U4REErUXBrNXRRek5WR2Mrelg5VjBYQWZkQ3Z6ZFY0QnhQ?=
 =?utf-8?B?djd2UmFuWUFJd3pQS1lLdWlud0FDQWNSZjRBdHFNZzkwQWhXc1hxeGd2MnNx?=
 =?utf-8?B?QnJySnFYbVprUzVBdUFEeWdkQXVRNUEyalQwaWpydEdBbTBJRUdienBKbDgv?=
 =?utf-8?B?cmhYa2RocnZadGVIdmtLOCsyWHhocldoMWExYzBobW11aVJCZDgyc1VsVzJl?=
 =?utf-8?B?aTFWYTgyQkhuNzNSR1ZDUm9XYnZXMjJKR25mT3pPYnlEVk5MQlcyNU9PRGI3?=
 =?utf-8?B?OFpuTWtSQVZ1TkJEUzMrN1l6enpMcVNvcXl3YmVuZkx3V3U4UVF3WFhremI3?=
 =?utf-8?B?dmZHQVdWV0EwMGNUTWsxalQ0MVhOanc5VU5BRENHUkJsdFhMK0V4YnBYbzRq?=
 =?utf-8?B?K2NzZlJzblJIQXI5cUR3b24vcFlQQldLcFhCNnZCbjllOEZKOU1wU0czZDdF?=
 =?utf-8?B?T2RZbDV0OEc2WFBaYWdKVHBLNk94UGRMWFRSMFRMUnFLd25halJFQW9tTno2?=
 =?utf-8?B?NEd5a25GTUhYeHErS3h4bW5UZDF3OGh6Z0U0WlRjaThZT04xNzBBVmF4R09C?=
 =?utf-8?B?cVpEWERFSFFUYy9Dc09Ya0djMUJPbDRaZndOWW5Da2RjRWpQeFhxWmpGbFNr?=
 =?utf-8?B?SUNxTStjK1kvMHZSQllDdTA2MWt1UHNxZVJySTlvMTMyd1RZbFRlZnp1N1JW?=
 =?utf-8?B?bE5weHgwRzRuMktlUlJpa1BsNk9RPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b2f399-d5d0-4eb7-8e0a-08ddc2b82b4c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:24:01.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCivJXf+/Kiwx2lsTXB5x7R65YziCJRQ+7Lg3pYQ+Uc7oc9IuDhL6QQ+F9LwPFkm3jN7DMLogELwhBnTcIZXzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3603
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b="F4tDPh/Y";
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c201::1) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehudehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffffgfuvfhfhfgjtgfgggesthekredttddvjeenucfhrhhomheplfgrnhcumfhishiikhgruceojhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpedtkeduhfdvlefhfeevvddtteehgeefhffgjeejhefhudeggeefkeegjedvieeltdenucfkphepvddujedrjedtrddujeekrddvudefpddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 14.07.25 09:31, 신민철(Mincheol Shin) 선임 두산로보틱스 wrote:
> Dear Xenomai Project Team,
> 
> Hello, my name is Mincheol Shin from the Doosan Robotics Control Architecture & Framework Team.
> 
> I have been making good progress on my project with the help of your previous answers. However, I am currently facing a new issue that I have not been able to resolve, so I am reaching out for assistance.
> When using rt_queue within a single process?where both the Producer and Consumer are implemented as separate rt_tasks?inter-process communication works as expected. However, when I separate the Producer and Consumer into two different processes, the Consumer fails to bind to the queue, resulting in an error.
> According to the API manual, it is important for both processes to belong to the same Xenomai session. I have checked and confirmed that both programs are using the same Xenomai libraries and are being executed with the same user privileges. Despite this, the problem persists.
> Could you please help me understand why the Consumer is unable to bind to the queue in this multi-process scenario?

Did you use "configure --enable-pshared"?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
