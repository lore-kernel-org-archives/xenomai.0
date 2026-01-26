Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE563314C3
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437701; cv=fail; b=aZzQyxjXaD5QmnibRerKJaVDx8OZM/FGp4trGbKNnI7+56k11KMTdBABoC17UXKdtnB/YIrlbIKYCDsTVXOmeN6nmKFQbwyaqocegRy9JeTJIciNRLLGzfc0oEEHNhxe2Cq52bzc1wvuCDVVn2MbYvDY7aqQk5AFjtgwAUpzEVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437701; c=relaxed/simple;
	bh=OCmFBL7zh+a9BzDTVdJ021ZYPaw29gQqkQsWptk0Ey8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V54HJcaHPt8Z7xW9knLdjsmXVkH7cKcFKS0SBVaDRD0plN1jPsqRCkQ8Cy6/JZXDW5xD/4KDG/Fm6oUX/Ilgo2BvdiH/r6y2epgoTwgvY/y6mdMocOzJW5I71c3SeDBHOl39oMHGIvfSg1O7zcLalLxi/QWoXI6M7ytFPFYKSo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FLx3oDQZ; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FLx3oDQZ"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 80C7F43BEE
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 14:28:17 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B78D9560073
	for <xenomai@xenomai.org>; Mon, 26 Jan 2026 15:28:16 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=FLx3oDQZ;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c202::7 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWNvoJ9tc4AunyO0gXxD7IPFArdZkoALG/E5PxORtDLdKpFONHMLdJaYp0FXghn2h3k6EV+2TsKuki2vL5gmqePPaXBRp/SvzpR//k4livYJvZylgKQZRMKr6tly1Gx9riBhoLopabpiZg3S5VQ26bX+MJaB0DUOKzeuRXFDtBNQM+VLf6PoQcGmohyewcU3DLQ1/5bKBRp6mh3HoKgWOZDUHoNDKYJuR+vO2IPV03lOrRyz60XDRSeyOTdQ6z+kh24lmbm8zMGnxuD3pBilUz+MacrTu1G+BzBzU7/luBJnDhUoqDdG1NvIF8STvAnTEPJvGtEhaO+Sy77z8KS3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBp8lq48pAQK9CJy8KZAkPrVUqQWG6KmfW5MqFwj4sc=;
 b=jwpA2J3gzdZec2lTbv/p9Rm7zl78rad8fuqToPDWgZohV9c2zjS3Xxb72aiQmIW9justA8hMY03pEwv+iO+SjcmRX0igE7QGBVl9256J9lZY/8yQ0mclRTSvHoItvOYMjruyHR3M+cgQPqxzTPETP/mK3XPUjub/9Xu//jS6CjSVxin7WLpl4y46gud9cez3KppFfZ8JCuoJlgk8MECvyBLzedY2zq/uL57eIWZb4jLxcuwiXukgL5qaee/2/rU8Vp0gOwQBOBX6ANOwR7ixUegAeK0eiHUCSF3P02CH6B9jdnl0wktuphlyvJveSdV44pc1vP0Qvm2LlXemttO9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBp8lq48pAQK9CJy8KZAkPrVUqQWG6KmfW5MqFwj4sc=;
 b=FLx3oDQZSwE981pqcBusEoc46JrOsZD+kQCjDAJ31X6K+vVMe3xHBoScmxz/YUGXUpxv6PQDhc4PIL6JHft/2UsBDDL5zQA6LIqf1a1KCjKu5M/D+N5h8u2E4uuGBpmnMOQZleXfqDreOVidIIubZ3E+zvdPh5PvrXDSZ1ZaqTJ5o1daX9uGeG4cViyhNoLQF2BNmPYqC2J/e8axZsHNK9X5EobLuAke9Keu56ZseOff06qYWe12u/8cw5MiJ9ZDXPCJYTtymsJy2cSLM8mlvb5jY7xr+kSXk4DqaDEa5bgJLukqLbFWCVMqyeq1WXT8RCgVP7+VSyauW36q6vceXg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 14:28:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:28:12 +0000
Message-ID: <29de15c3-4d96-4194-9cbf-c362e9e83698@siemens.com>
Date: Mon, 26 Jan 2026 15:28:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Allow changing CPU affinity of RT kernel tasks
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org
Cc: upstream+xenomai@sigma-star.at
References: <20260126125701.21000-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260126125701.21000-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3582:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f615ef3-c252-4232-2322-08de5ce72266
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejNFaFhRNkttNVdLK0tiZU5icUJXTndSRm5US1FiU1BqcE9XL2liamJBcU15?=
 =?utf-8?B?TEVablV1RHVLSVRRa0tnTTRzeTR2TXhSeTZJUmJpaXpjVmJqbG1BQzVTUVps?=
 =?utf-8?B?K016MUd5TzlwY0dxOFlPWU5MaGdQS0VSRXpmTEYvSXhrbFFmZW5GV1UwZGRy?=
 =?utf-8?B?OG1nZDR4Sk1TZE1ucEM3L1o0QTJkcnA4aUhmZXROcnlJSkN5THZFT2hMOHBJ?=
 =?utf-8?B?UWdzWGtzajRZZzIrd3c5RDNEY0ZuTXZmWUdCSkFlaUYrdmNsM2QxRlNtTjA1?=
 =?utf-8?B?WVZXbnIybXJpODZsdnp4Y1hLZ3IyNXdKdUxwQ3Npd05qakl5T2N3QW1xdVdY?=
 =?utf-8?B?QjhIMlhXcU9ua094cGJUaTJwMkZFRlhPdzN4cDVvUlpNTHJrTllqQ2ZTWElh?=
 =?utf-8?B?ZmNka2ZlMmdyZTdtb2V2VHd6NkNxZHNtT0hyTUJFYUZSbEdveTNJVkxWNnhx?=
 =?utf-8?B?TFNZc2VMVkJPODVGQXBnVjllclZybE5tS0N0cUlXWGI3bmp0SFVBRFBWeHFu?=
 =?utf-8?B?djhZZnRpUzFybDlrbGp3YmwyWGJwMGJmSnlINEUyT1VncmsreEdGZnQ1enFj?=
 =?utf-8?B?dDk1MFBFcG0rUjRPVkNzNytiUU1yc1ptZWxlL2E1eWJEWG1UdmRISXJlV3Jr?=
 =?utf-8?B?TzBBSnhGUUhtWVdCNE15enhQR0JYT0Z2UEs4Tk0xQmdwYi96U1N4bHFYYWZK?=
 =?utf-8?B?c013MXpad3J0bFFrdkhXVnhYU1ZhR1BSakpXM0lPczZjalJXVE53V01kM2Iv?=
 =?utf-8?B?SUgyM2wvbGtvajlYNWhLaUthRXRxZjF6aEtHQ3ZmVWR6aTdTZVNyZS8zUzM4?=
 =?utf-8?B?djJDallsYURqS2hSd21vclFFWENMVjdPcHZNUlk4LzlwcFZBMGRCQWhhVFhs?=
 =?utf-8?B?RElBV3JRNG1MVk02TldqcDdqakx3S1BvcjJKbFZZNW5XZGxTb1BJbDdzbXNO?=
 =?utf-8?B?Tnk5U2pLbVAzUWhLUFdhd3pVNEFkUGpoVzUxN0VWai9JaXZFREtPK3BtbEFv?=
 =?utf-8?B?MjRZTEZYTnhQTXh4QTAyRnRIbTBGR3o3bFFSYlNmTUtvdDJVWUZHeWs4am5I?=
 =?utf-8?B?dTRRRFBwZlFRc0czeTdHb29XU2E5MGEzblE4WHBhN3Naa1Q1aHE5UkZhVTFr?=
 =?utf-8?B?aURBeFVxSElxazJNdGVjOWpTUU9ITFBuLytsbnZoOVd4UGt6TXlGSnN3SkFW?=
 =?utf-8?B?aDNnRE1oNjNJTXd5YmlWYVdQM2xYWVhOa1FqYWIwSVFvOXdFQnFOUTN0dkov?=
 =?utf-8?B?ZTdPclNRYTVZeHQzSlV0TmRPV2ptcm43MzQwTC9KZGtHaURhN1NRM2tvNDFz?=
 =?utf-8?B?WHN5QVJyS0QzajN1ZmVpTnRiYUZBVHNOT2trRzNYRWl2MGltTXlMa2p2b1Qr?=
 =?utf-8?B?TytTVVlMV2xnaUNJWmxPM3hDQm4rRkNJQitCNDh5T3NtSGprRzlHcXJmYkV3?=
 =?utf-8?B?RnRmTXJFNEl5ZEhndGlNSlRJcHVZSFEyU0haYjRrU244b0lOdTd6ZFdFemxJ?=
 =?utf-8?B?T3M2cUwxb0piUDZqb3pWRXRHVGUyV1cremtBYXE1OVlCOU9zR1oxdkhlczdS?=
 =?utf-8?B?Q1R3UG82b0xaRElPUGRRcVZCWUtsQUkyV0M4QVNXcHN5QmQ2SUpMbWFEV29B?=
 =?utf-8?B?em9ucUZtcDg0cC9MSjRSYnBnN256N1FqS3FkT3ppWEY0bFVCV3NINSs2U0tR?=
 =?utf-8?B?UjBIWThDUDZOekU5YW9iNFAybW5jSVk5enlha2x2Y01tcER3TzhlNFZhRDdq?=
 =?utf-8?B?ZGw4OGYyUU5zWEdRaW1CSVpmQ2hzTldrdy93c1ZUaFhzdkVuTCtDSDM1YnVN?=
 =?utf-8?B?N09qNnB5U2RRSXVXeFc3bGZ1OVlGeXZMdVVJL1RKNm1VdWluQVJGMzMyV2VB?=
 =?utf-8?B?dTF3azRNU1U0aUxwNkJvVTg3SDNVWUFHSDdLSVVZYUVMTCtPVHZzVXlLUVVC?=
 =?utf-8?B?TzdTcVlVYnppNmZsU3JVd1d2SHVha01nWGQ1Mi9pL1R3eXIxbjBLZGR6VS9J?=
 =?utf-8?B?TVZvVDZJRk4xR2N3WEt6Q29FRjBDSnV2amJaUmprdWNsK1pwWmlod2J0UGpa?=
 =?utf-8?B?VzR0aXVoYXdLby9NdHhMaFN5eG8zMTJOV0pYUExuWjNEVUtqbUx5OTlZWVUy?=
 =?utf-8?Q?TJH0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRVU3VIbk4yNUV4MXIrU2JJWjJjbzlqZjYzSkpaVWhtbXlOMWVPaFNUdzMy?=
 =?utf-8?B?V3ZIZ1BEb01ZTE5uS3p4R1d3WW8zWmtxRzN0dnJ0Sm5TVm5SNkdST3NzeTZC?=
 =?utf-8?B?L3AwMGRia2lkSloyblE3OFZKdFNmd3pZcm5GOWUzTTJUSmNPWldNY0psUVNr?=
 =?utf-8?B?eWh0MDlmbkJwWjVWa2hLbGdTa1J0NVN4ZlpuMG5mVVdyWXNYTUJDTTYwZG9s?=
 =?utf-8?B?T3J6eGxXeDBuMnVhZ0VPSW01RzNjZWMwTy84WGhTMFM3NDM0a0VqSGc0ZTVX?=
 =?utf-8?B?SlphTjNESkhxY3FuTzRDWm51MzVHdG8wMDdPbjZiOWw2UitOQWJvZ0grMkUr?=
 =?utf-8?B?NkZNUzU1c1h2TlNmMXdldTB2QlJ4K1N4ek1obFlXM2VDNFdwYm1mUldrd0E1?=
 =?utf-8?B?dUY1bTRBQ0U0dmhmUFlCWkJZTjdDbktIUXJZdVUrT1llSW5VMHlNN1ByeFUz?=
 =?utf-8?B?MU4zNVZnaVlVb2RkSzNlQzdzQ3lSczVneHd0VmVNY2xObHVFeFhDK0VCQXZl?=
 =?utf-8?B?RWQ0N2xWU1ZXTnpLMDV3Z2gzalZNRmt5UTI1bS83R1ZpSHRLY0xJbjR6Zzl0?=
 =?utf-8?B?RTRwQmNyYk5CNHhMY3lnRHNnZlBLZFJwSkRZNXN4YWhMa1F1dnhDN1djYjZp?=
 =?utf-8?B?d1F3bTg2RUpadUxZb3Q4VFVTaUxrMkJUVWh3MWVLTGFRZk1NSkNJbEQxQ0NN?=
 =?utf-8?B?cFRaRjRDMWtVQkY0ZUpDWnBCVndHSi9GTkI1eDJkbkZPQ01OdGMxYmJSNGNa?=
 =?utf-8?B?bVF0eGMydW1wOE9WZy9OaTZUajNSZUZ6YXlaSlNTa0ticDlUeWEzdXlyNXM5?=
 =?utf-8?B?dS9TSnVNZi9nNW91OVVZVkdydUhLLyt1WjhVZ0hERzJBa3RBMWh5NUlxYm0z?=
 =?utf-8?B?U01YTTc5ZVJJMjhhWXY3YmtvZnY1UHUrOHZVbHV5ZTlFeU93RFNtVHhXc2VB?=
 =?utf-8?B?U2UrczBKdHl4VzNaZ2ZzKzhGQnJOOEhTSXJpaGNvUTBnY1NxYnRXeGFoZkxq?=
 =?utf-8?B?S0QvQ0pmcDJhSWt6bWRqWU03OWJNQndTcnNEK0ZMWU9JUDcvczUzWDFFdTZS?=
 =?utf-8?B?YklLK1I5RlNHMVZwdHhhQW02Y2hZTHNUUVp2U3czUmtQaktUYnRweDBGNXdt?=
 =?utf-8?B?dS9pUWhpSU5xNUYxWVlEcXl4SXRhOUhIRXV6cU5PVWNQbWp2RGtIOFVxVDF6?=
 =?utf-8?B?MzB5Y3Q2dDVkSHhpM01yZnJXeEo0RGN0cUdJVDVYNGpQWC85YzFOdW1RRWZ5?=
 =?utf-8?B?THRzZXZ2QXY0ZkY3QlhlaVZieC9LWnFiUXQ4eUZDU1BpMDNFRUYrVGtSbGdE?=
 =?utf-8?B?OUpPWE90MlZwN1lkNGp1WVdsdlNOTkRTQ1RtRGtJbG1MMk5aN1JzQ0s1WEI0?=
 =?utf-8?B?NWhkS3loTk84SDNwbDc0NmkvU1R1M3RuRGU3aUpHMzgreTgvcHhIeTl3dUlE?=
 =?utf-8?B?d0F3OGxvTEZxSlFvVEVzR0UxMEZXVkRWVHd5ZWFnM3NQTklCUmI4UVRnS0lP?=
 =?utf-8?B?LzVJdUo4U1o0R2dRK1BQbWdkc2w2a3kxR2NscStMa1I1UGlCL1FFYTdtY3Z0?=
 =?utf-8?B?YlVRaytYR3BDQnluU21vOVZHd1ZqUE1CQjdqM1REWTN4ekVuS0QwdmtyVCtO?=
 =?utf-8?B?SkcrcWR1eWtmSWoyV3hqMFBrcHoxa2k0dkZkcEhtRHlCOTJ6WWZaQnducnBs?=
 =?utf-8?B?Nmw5ZEM3c1Zjem1ZTTRWRVBGNWpLRXRhdVdobFZURnNESHI0ZXlrMS8zZ1d2?=
 =?utf-8?B?OVY4UmU3MEI0SDhqTngxRC9EZXVJQmIxS3IxTVJCZ2pxQ0pTa2RJR0F4VDBN?=
 =?utf-8?B?MG15S0tONE9xR0hTbEQvVHJsV3lZZW1wQWhWa010cFlHYmcrME5icFR5OWEv?=
 =?utf-8?B?cG9nMkFPS3UwT3MybjNjTzcwTXBNQXcrajBQSmNoQlBZUVY3SHZ6NXhjU0dL?=
 =?utf-8?B?bzA5cy9oL3dKbUZxNG81K2dDaFhZRVRwMHI0SnJSMkdZcXVnTU9kWWs1TktK?=
 =?utf-8?B?Vk10Q1c5L1hubG9GM1BsT2pLc2Q5SHVhRXpweFQvYTNKZUJZdzQ5TmhuZjVE?=
 =?utf-8?B?SEtXeUd0REFLaEh1eUZNeE5GYWFkNUxiSVlUVGhpWGlyVmY5ODg3NHFlY0pQ?=
 =?utf-8?B?dWhCT0c4eXFGQ3AvRVRvNmUwTVlrUTZRd0Y3aFVCaHRKNGt3ajVVWHhrZmJP?=
 =?utf-8?B?eG53QXRmZGptZHNteFVQaWFGZTVIakJxZVBGU2oyR1hEeXZYWDlRaytvTWUv?=
 =?utf-8?B?dVdHeWVSSjNHRVQ3Z1kxRFp3RHc0UVkvdVFXdVhIdDRWZk5oQkg1V1ZnZ25z?=
 =?utf-8?B?NWdiSFFBZHNJd0NvaDFoRmV6TEhZR3pKRUUzbGEycXdOd3prcXNmQ1VTL21w?=
 =?utf-8?Q?5UUMqFCutQ3RQ548=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f615ef3-c252-4232-2322-08de5ce72266
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 14:28:12.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpumExLSVUWdAB8UUM0h1YfsRlw0HU5qG1MptfrsNlkIK7RgcMXss4sspkQc7U9JMeGekmAJGreN0JD63llhAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3582
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvvehfhfgjtgfgggesthejredttddvjeenucfhrhhomheplfgrnhcumfhishiikhgruceojhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeekudevfeekgfehgedtkeettdevtdeuuddvgffhtedtjefgkeduueehkeetuefgfeenucfkphepvddujedrjedtrddujeekrddvudefpddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhqihgupeektdevjefhgeefuefggfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh
X-GND-State: clean

On 26.01.26 13:57, Richard Weinberger wrote:
> Currently, calling sched_affinity() on an RT kernel task has no effect
> on the Xenomai side, even though the shadow task reflects the desired
> affinity. This discrepancy causes confusion because the failure is not
> immediately visible.
> A cryptic WARN_ON() triggers only when CONFIG_XENO_OPT_DEBUG_COBALT is
> enabled.
> 
> This change addresses the issue by implementing an approach similar to
> that used for userspace tasks: forcing a relaxation and hardening cycle
> to apply the new affinity upon receiving SIGSHADOW.
> 
> A new helper, rtdm_task_test_sigshadow(), checks whether SIGSHADOW is
> pending for the shadow task. If so, the signal is consumed, and a
> relax/harden cycle is performed. This works because signal_pending()
> only checks a flag and does not cause a domain switch. The new helper
> is integrated into rtdm_task_should_stop(), so existing RT tasks utilize
> it automatically.
> 
> RFC Discussion: Sending SIGSHADOW to a kernel task causes blocking
> functions to return -EINTR. Currently, almost all RT kernel tasks treat
> non-zero returns from functions like rtdm_event_wait() as fatal errors
> and terminate. With this change, blocking functions that return -EINTR
> require restarting (continuing the thread loop).
> 
> An alternative approach would be implementing restart logic in the rtdm_*
> wrapper functions. If XNBREAK is set and it is a kernel task, the wrapper
> could run rtdm_task_test_sigshadow() and restart the call internally
> instead of returning -EINTR.

This is one issue with setting the affinity "from outside",
asynchronously. The other is that it will always imply a migration of
the kernel task, thus a phase of non-RT. If someone forgets about this
and sets the affinity at the wrong time, it can ruin RT workloads.

This tuning gap for RTDM task is rather old. I was already considering
to add an explicit affinity API to RTDM to set this from the driver.
That would allow to set the affinity early, right after task creation
and before the driver signals it is ready. Risk of such an interface is
that people start to hard-code the affinity into the drivers, rather
than making it configurable to userspace.

Jan

> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  include/cobalt/kernel/rtdm/driver.h | 17 +++++++++++++++++
>  kernel/cobalt/thread.c              |  7 +++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> index 604d54b2b..d06e1126c 100644
> --- a/include/cobalt/kernel/rtdm/driver.h
> +++ b/include/cobalt/kernel/rtdm/driver.h
> @@ -34,6 +34,7 @@
>  #include <linux/cdev.h>
>  #include <linux/wait.h>
>  #include <linux/notifier.h>
> +#include <linux/sched/signal.h>
>  #include <pipeline/lock.h>
>  #include <xenomai/version.h>
>  #include <cobalt/kernel/heap.h>
> @@ -1043,8 +1044,24 @@ static inline void rtdm_task_destroy(rtdm_task_t *task)
>  	xnthread_join(task, true);
>  }
>  
> +static inline int __rtdm_task_should_stop(void)
> +{
> +	return xnthread_test_info(xnthread_current(), XNCANCELD);
> +}
> +
> +static inline void rtdm_task_test_sigshadow(void)
> +{
> +	if (signal_pending(current)) {
> +		xnthread_relax(0, 0);
> +		XENO_WARN_ON(COBALT, kernel_dequeue_signal() != SIGSHADOW);
> +		xnthread_harden();
> +	}
> +}
> +
>  static inline int rtdm_task_should_stop(void)
>  {
> +	rtdm_task_test_sigshadow();
> +
>  	return xnthread_test_info(xnthread_current(), XNCANCELD);
>  }
>  
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 607f115a7..e9baf38e1 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -204,6 +204,8 @@ static int kthread_trampoline(void *arg)
>  		return ret;
>  	}
>  
> +	allow_signal(SIGSHADOW);
> +
>  	trace_cobalt_shadow_entry(thread);
>  
>  	thread->entry(thread->cookie);
> @@ -2373,8 +2375,9 @@ void __xnthread_signal(struct xnthread *thread, int sig, int arg)
>  	struct lostage_signal *sigwork;
>  	int slot;
>  
> -	if (XENO_WARN_ON(COBALT, !xnthread_test_state(thread, XNUSER)))
> -		return;
> +	if (!xnthread_test_state(thread, XNUSER))
> +		if (XENO_WARN_ON(COBALT, sig != SIGSHADOW))
> +			return;
>  
>  	slot = get_slot_index_from_sig(sig, arg);
>  	if (WARN_ON_ONCE(slot < 0))

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
