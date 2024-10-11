Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51663405FB
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658653; cv=fail; b=jWcSQ85OeXP6D4VbOOmR0A2Ah9IOpj+pW7GtPQHYCMjuNIpGkpJpP8QU2ZyJ0pMPBKYbvJs9Luvl/EwH8GUvLnXg0ywXwes7h2XkZysi81puZhb44lfuEbschHdA+DhzkSav8cwasJ2xndpWx2BtWundGZXC2Q0u5DBdJWWlDG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658653; c=relaxed/simple;
	bh=x5YCEdl5sgNGAt02meg+lqHmcCY3/pT7sIzjQV5VWEc=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=iBMYGVXKvJ32XC8WFdSLgEpZTC0AD+QWIch4ttm3fCyUQp55BaU6BaEfvnqrXvxDlSDZBMK0ocP9Rey9mYyCbul+SoKJvQm5uBdrYyO0GQOFPxCVJFrYLXlS8afRH123rduJr2mhQ1opDWkil6HrDIxaOyEtvPdAeCPDYd7307U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AdEwigWJ; arc=fail smtp.client-ip=40.107.104.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AdEwigWJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdwYCT2K/rxcLtgIH0rlYaHwsKemwZC9wV019I+ejez3VbbVZnHDQPvnbs9e5hx8hb9FB4dEjUitGGnD4MimyYw/BU2lrUF/JTajdvu9DJdlfKf0Fggpuzgo1MwUUiLnW+Vah1H+HhamUsw56o5QwCTl7/mA1sHfYw53a4TAQt66R2dNltKN/w7SyfsbKJmr3b22jLcJNsafeksQnAXQrEgkXnLbGofxv4/f1XEznM/dDQBeoU8xWv7H0oRBF1mlnAJqUOw50Y3BeQOwwCLey0mZXinnBpVOaVjODZOhxNqrvQPgmKTqPD5hJyPorJ5QcjZ6EbOwptbaSdmfkPSVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3SHzYhqw8t6QFf8yFXIySXXcgHOyahlVu2uDj9URr8=;
 b=nf2VZqG138BEskHXcbpYg3Ij3qHYQ9tfbkApc6dahZ7A/6VzuWgRcob/uZ1QBa5ZM7b78S8/q6CNWqKOqNXA0gyzr+F9gpePvyZXLhXQIFdlyrLIw4EgT6k3B2yMRXPQ8HCXdbzGYi1JlPqVBi2kLjwU9BTUDJDznODYbvtRe1gOLUOU2sGIo6S3Asr2geFJHHbR0ZuROnrfTPI45S7u2Sq5hOwZw0mr4taJhRAWsdexgsF2QmK29Lky3QVFW6zPZfVA2VkMTjIaVlPaLsqXa6Q1GCTTrTXxzQYiKpjeCuWIjPTDuplo2JwwR2NyrmdN7fT63/2q74YtiVxdSY6ong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3SHzYhqw8t6QFf8yFXIySXXcgHOyahlVu2uDj9URr8=;
 b=AdEwigWJezpjE9U+lm7te53acfqxDQPffC75uDboIq/BhVOkZEFrkS7N+byImt7n6uC0R/Ti7yC7BGW9j5tlZpEJ5SOP3Dv8SGtfpVaj/G9WhFFHxqWTnVh8IZBmUF+gB3B9ol8gszSa4gZyEtq7644GnvPav+RafKLd2tgGjISVb0ziCQnccTSrR4SUQFhcAYbqhHXnbjSD00wmr2XVeopu6mshLWSKNu9Z5tgHkmyFXi4gVSdw7LQ6nTubz4OE24p5Q9Vb0OCe+Nhn8pGs1rvRS84LLRECyV/UhN6V7sgjyAsch+emRsci/SVC/ZJSwwb4x0z6rLLwoy8znnTB3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Fri, 11 Oct
 2024 14:57:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 14:57:28 +0000
Message-ID: <d1064925-b480-458f-b88d-a2f932d34db2@siemens.com>
Date: Fri, 11 Oct 2024 16:57:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] lib/cobalt/internal: Fix lock-ups of cobalt_monitor_wait over
 signals
Content-Language: en-US
Cc: Mauro Salvini <mau.salvi@yahoo.com>, Philippe Gerum <rpm@xenomai.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbdaeec-e9b5-4f48-1d0c-08dcea05067b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akhXVEpvWlI2QW5wUnF1UUo2ZitWRkRhRVloNDRQUm5GREpycE5VdDBTd2NK?=
 =?utf-8?B?TjhrSGtwQ0g5WVYxQThWTFNYYWZGK04ya0F5bU5PUHZ6OXZIN2dvOUM3czJM?=
 =?utf-8?B?Q2NUMGQ4K2JQYlIwSTJJYUY0M2dlWm5pUzlwbk42OUcvdElsZUl5U2h1VFdG?=
 =?utf-8?B?aVpMNzFUQXZLM3VWTjZaUUprRUROVHhrMGZBb0RQSTFyUmRkdWs2TExWdmIw?=
 =?utf-8?B?RDVpVkpKWWFqQnFkTlluUmpqYzY1R1JtTjd2YW1QMkJ6MU8yTlQrN0JXUDV5?=
 =?utf-8?B?NDF5Z0o1d0RLSlpzYTQ2YklDeWw4cDhabXREalVTZzNUY3pBWGdaRG1TZVZt?=
 =?utf-8?B?L1A5dC9EUGtRL0RTZkxnVDdUdnphZVhtMDdJd1o3ak9yL25FQ3lwQ0Jia1JN?=
 =?utf-8?B?aFVDa3YxMjloMVRMREF4c3ZUTmFaRjN4WDh1SjQveFdsSmFFWDZrTlQrYnAr?=
 =?utf-8?B?ZXJpbHFKbkVJQ29zVW1oZnNORlZJZkNDSEVKTzh5ZlBYUW1PRXNGWWxZSmlD?=
 =?utf-8?B?aVRUV0FhUHlHdHZ1eHFEcDJJdmZFTUQ2U3dTdmZzTGpibnl4bnA0TCsxSGZt?=
 =?utf-8?B?eWFybW1RSzliMEp6THlKc1JockQ4R1REVEZTanhZMm00RDNnbnBHS3RMdHEw?=
 =?utf-8?B?amUwUFpTa2dIMjgvd09BQVB1UHR5czIwNGNFMkdjdytZb1NQOW5QWWVCODc1?=
 =?utf-8?B?MWFSNmgzWVZWUDJjbHR4ZE91ZG9XWUZ5d0wwNHNjVHh4NzFrd2VqakErdWNR?=
 =?utf-8?B?RTRCcXhQUHdTSVRxczB3b0xWY2pGQktLcGgrdkVVcnk5OEdscUR5b0N0TVpL?=
 =?utf-8?B?NVNjSEJlUHJsbzFpZi9yMEFaRFh3bHJuaXVhRjNMMUxwdEV5Nm5sZ205d3NR?=
 =?utf-8?B?b1JVb0FzQm1UdDREV3dNQkxSRjZwSjBoaGE5dnVKdnhRajlleVJoelUwdmVQ?=
 =?utf-8?B?emR0TFNhbU9mcmNrKzFKN2p2YWJZZ0VXc2dWWmdOOWRwSEloUkxhdkhhbDRv?=
 =?utf-8?B?dG9nNVUwRzVPNnU2eUhNby9ac2txZUhJTnZmZDlPa2dWRjBUd1o5WVhVWmpY?=
 =?utf-8?B?aUt6OVdhMG5UOWp4dG1RZTJLQXo1RnFKVTFjOG5GbVRxVlBkTzdtUmZGTTFT?=
 =?utf-8?B?RHdxOWhLWFJIQTlLOGxZelBoZHNrK3hLZUs0VmtXZVNkZlJOazlVc2VWT1NP?=
 =?utf-8?B?VnVESnV6TWgyY0FPNzRhUmp5cnd5QlMyK2ZNSVdpNmp0TzVNKzlWZG1xek9N?=
 =?utf-8?B?aGg1Rkc1YmR4MG9ZNFFDUVVCV2FUTE0vcjlWcjV2NUhTOFpUazYxTUlLcXU4?=
 =?utf-8?B?NlFITXNMUE15SnE5ay9QdDhGL0U0TmtyVFdYeWl0d0w3NHZTYm8rcGxRWkhN?=
 =?utf-8?B?WlNIZzRnWFJmUmhWTVoxN2puRVJReGp1aUhzQlpqOVpuK09GeEgvN3RmckZi?=
 =?utf-8?B?SjE3VDVRUEE4WFhFSFFFcXF3UDdsNGREN1cyMGtydWJCZndtZnFYcFNIcE5U?=
 =?utf-8?B?cHhwN3ZFYXcrTGtUbDN0UytCNFlGNG4yWHUyb0RmSDhYSWtLNzFkOEFKVE1X?=
 =?utf-8?B?QjhnOG8vWlQrN3NBWGtGZk95bFY5Wm9QcjhhdnRYUlcyUExYSWdTcFZzQ21S?=
 =?utf-8?B?b2hxZlFCMVYyTHZSYXFzZHl2c2lFa0VZcVc3RVluNTNaa0JaNndEY1R3K0g2?=
 =?utf-8?B?WjYweWd1U1BCTk82SFdHanZEcDVUTWZrMWMzN2g4VWpEVysrY0RVcmlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3IrWEllaTdvZXU3VzBnNURaUEpoSmxpR3Z6ZjJScy92Z2ZobU1YTU5lMzQv?=
 =?utf-8?B?OFFYNjVxRk8xMHc5aWJNbW04UWJLYmdlTFp4WTBUWVEyUWJQeXZZTzg0Mkdr?=
 =?utf-8?B?dzhLZ2tRUDVRdnJKUzY0WlREbEIxRHZlQUdlRTE4cEJmSUtwK1ZnMjFCSUN2?=
 =?utf-8?B?YXpKcGU1dUFyaTh4VStWWGFCL1ZUVUd2QXpVWEx5QkRIUWQyNFFwdURaMkFV?=
 =?utf-8?B?eHVIV0hkYVByUkFYZ05hbCtpWUVBNWVOc3VvL3VWREpWdldkMk5ITmE0c0da?=
 =?utf-8?B?NUJuejdTQW1uelFjQW9lZnNiNEFDUzVGb2REbE1YK2ZnV0c3S2RkNjNsUXI0?=
 =?utf-8?B?clRvKy9ZSkVlUzJ3MlNoS0NOVHN5dHprS2IzYXMxV0Y0cm9uYUJDVk45TTB2?=
 =?utf-8?B?cXZ1MmtNM3Q5S0xibnNTcll4MEJlUEVmNVAwOEYxQnI3MDNyUEhGTEplcnpD?=
 =?utf-8?B?Z1VlclVQVzdISitZZkxMT3RiUS9DT1lYVHhHNEVOYzBXK1EyNW5UaVQxOWQ2?=
 =?utf-8?B?NVErcVBNK3VxekdKMS9vVS9BYThrNnVOV0JVUEFQQkJjTStXKysxWm50cjJV?=
 =?utf-8?B?elpBMDh6OVpQQjlpQjVMTEl1eFBmRk92N2pXK2hIU2VvU3B6VFVKYVE2KzdQ?=
 =?utf-8?B?bVhHV0FUTXFJbU9PSXlYUlQxS3JkMWtQY2xUYTAyVE1GTjQ3QkUyY2ZSVS8z?=
 =?utf-8?B?SHJrY1ExbUtWUkxrN055eEFOdmdkQkl4UFg4Wk9ud2VGV1ljSldkUkpSU3Ru?=
 =?utf-8?B?WGp0dnNXd0hwWWIyNG1yRUFkWHNrV2pDcVN0MzltSndmZnFOeVFiaFRobHhS?=
 =?utf-8?B?MUdHMDhCY0tFQ2wvTTY3T04vRVc1a2VJRUZ6YnQrZTJXZGxKdnFzZTdlMjdZ?=
 =?utf-8?B?U04yZ1J4SFBUR1djWjNwL3o1UWJabTdvSEF6MnlYRWVEL0tOeW1EZ0wxZkIy?=
 =?utf-8?B?RTlGcFNOaWNJUkhLcmgzeVU0R2RpaG5PSzlKLzhtRDY5U3JPVy9OSWp3bFR0?=
 =?utf-8?B?MGlIbXRBVzFHdnpWUG1zc0N3eTlrVEJDcTFkemlRMlFERjQwdm53WGw0RnlJ?=
 =?utf-8?B?d3lKMnlVQmhmZTBkZnZDdUFLVkxJdW0xTi90cXVIQ2dMYnRxZVcwbklWNHZZ?=
 =?utf-8?B?SkMxeGhOK1lwQnJROHhoaEdqZ2pkSDhDejhiSGpLZks4ajZubHQxSXE2VlFs?=
 =?utf-8?B?YkV5Wk1td1N6OW10clk3MGdYOGFHeVVTQXM1YXlpMzZBc0Jyam91SEg3dUpi?=
 =?utf-8?B?UWNKd0lJN3VGQUJIalhqN3U3bVBTNDRSa3FiWWZ5VnlhY3lFM21kM3JIdmRt?=
 =?utf-8?B?QUpVZDFLQ3h6bTJZQmdPMFFudjB0eUxKc0FsK2pSR0NNMTVkTkNoK04vQ1pJ?=
 =?utf-8?B?RWh1ZG9Mc2Irays2Qm9Zc0ttOWRTMjYyZzgxOHlub2R6N3VWcG83a1A3dGNK?=
 =?utf-8?B?eS9ocWZzMTA0MGJPZlJUUmMyOXE1Znl5L0dITU8xZ3lOcUhWdVVEVmV6dnMv?=
 =?utf-8?B?MXU3bmx5UTQxMnByRThZZ2pQaS85RDAzRFc4dWYyWVRoSy9ZV25nRFRiVENG?=
 =?utf-8?B?SDlnaTFQQ3lWTmFNeHBSZWg5VGw2SlUzQlQrcmxITSs0ZkZ0eXJvdi9FRUxS?=
 =?utf-8?B?Y2diaCt2c29lZDJwQURzL0Vzb3pmbkEvK3JFV05RVlgwd0Vjek4rRHBXNk5S?=
 =?utf-8?B?TFJXa1hyRkhSN0s3WWFXV2FFUG1ZQ2o4WlpYaVhnSUQxdENnSlNGTVdZSGNN?=
 =?utf-8?B?eUg3NGlnWVN3bWh0VDIzcmZneGNEamFmR1U5RC9jOUd2K0dXVGNDRWIxc3lR?=
 =?utf-8?B?V1I0R1dDMW9XZ05UdWJxZ01nKzR4cEFGRmYrLzd4cXVnWTRtSXFtaUZ1SDg2?=
 =?utf-8?B?WEtVK1IwTXpKZW1jQXRtZzRUNzRoc0tySHA4UlJtMjZHcEFKQzdGQzg5MmFm?=
 =?utf-8?B?R0xFbEpwenNQSytoYUk4aG9mcGc1cXdtdVRvVVJydHdOcm9qN244OWdkcDN6?=
 =?utf-8?B?Skhia2ViK1BFYVArWHp4Lys3NmZmcHRPQzJreG9yaHkzYkxLYlJJQ0JlY05w?=
 =?utf-8?B?eldqR0d3a3Z5dXIyZFZxQ1JKZkpwV2dwdWFPZUZscHZOVExRMUFLak9VUHpz?=
 =?utf-8?Q?wFy0yhY57rJAwG9OQasKTnmF0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbdaeec-e9b5-4f48-1d0c-08dcea05067b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:57:28.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +W6insKRpCZExxh+PHMMFYzUoGFvPc+GSNWPuNcsf+BDCSSl/Qi+diKlnxCPPJGN4AJHy/VJ8THz+xnKJT7FgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3267

From: Jan Kiszka <jan.kiszka@siemens.com>

This is a very long pending issue, actually since day #1 of this code.
We were checking the wrong return code for interruptions by Linux
signals. Rather than using the opret code that the cobalt_monitor_wait
syscalls set when the xnsynch_sleep_on was interrupted, we checked the
syscall return code that might have been set to -EINTR as well in case
prepare_for_signal found a pending signal while returning to userspace.
However, in that case the monitor was still entered, and our attempt to
enter it again from userspace caused a deadlock.

This was first reported in [1] over alchemy's rt_buffer_read, but it
could affect many more direct or indirect users of cobalt_monitor_wait
& Co.

[1] https://lore.kernel.org/xenomai/9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com/

Reported-by: Mauro Salvini <mau.salvi@yahoo.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

It took a few hours to understand and fix, but 11 months to finally 
reproduce locally. Anyway, the bug was 13 years old, so... :)

Mauro, in the end it was just a main thread handling a signal (not even 
terminating) over timing-out rt_buffer_read. As the race window was 
small in the kernel, I added there an udelay once I thought I understood 
it, and it triggered on any setup withing a minute or less.

 lib/cobalt/internal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index d721e7ec69..dd3da08558 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -269,7 +269,7 @@ int cobalt_monitor_wait(cobalt_monitor_t *mon, int event,
 	 * we need to redo. In the meantime, any pending linux signal
 	 * has been processed.
 	 */
-	if (ret == -EINTR)
+	if (opret == -EINTR)
 		ret = cobalt_monitor_enter(mon);
 
 	return ret ?: opret;
-- 
2.43.0
