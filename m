Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21021222565
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682566; cv=fail; b=iHB+u44onhtp9CR4MIvnwTc3KzuCjbhsKFuW6+Xsc6jSvQn80eNDBOZ0hSs/WJgCzwKh5wgYQaLLj0+XzaUIVrnR2FJIV6aH/BfDREBMXnZA34aWYbhrIvSHZNjOpgJtZFYMBwaUNc7unuN+p0UhRFLqsrkBzg7v7ngXHMjMnMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682566; c=relaxed/simple;
	bh=uKsPprcXjanmhooj+YPsLGgMzsynabRjziVm2hdEo0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aHUZJa0HQVWhBqiR7m9EzFj5YSjXeIpiDvSmL7QwpdG3jMIJmuggwJSkH/W7WYFytX7P8UkipPVzfbOSdCc3Ek46l2ZT0em5tQSBTWOIb3nIZKXXglvmQ3zAqrmbX2yBBSHHyxFH4lUr2BMaAayhjVIZRFRH5KW8bkUuHlCF5MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SKawJ1SZ; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SKawJ1SZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAgpsnqAk0asGXTA/7LKBVzNZkI9XcZi5MlvrasuMfmcP1tbjtbhAXTNIfmWTN473jsYKKx6UBbw/kx4Xa6b2lGcD3OJyzfcOn4CTQOQIbVZc6G1DI+GX/IEa9TCDjJyE4XMpKfiRg8UkDQ8ts3jgx7T64hp+WlbLripIysS1dz/sYFCr7Q73YKz9V3kmUSWhTasEJhxqT4MGk9WZbwknRozUD7iHWc1cuS7gnxeQTzRUUsJtz5VgBC5BbAQPuiN+4wxwBPSJjCw/DHMjIQZLafvS3FuUbIRjOuvJXgSU7arX01FaMS/DCsu7wZzCMjxDjvBSbm7y2yHZlXaJkhPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXJmx/Pk5tZmak69SENYHbCE/Rio/8itOQ7QftH7ixM=;
 b=K5O4ZFjOZIkDmOCu1HRp+cQNlbfkKJ6vrzgULi1uLv3ZRD9zAL2qWNYGuTjRTK+J3BV0uRo31KTQXYO11yttyP+EuDiKpiXWVCPxAnnGoAwSXzNJWnLB2g3Xx89eJdS3lXPelfxQ+Prxicd60LTjuoBIHzmYN9rl8GQXXlhoGkCD0U4dtXdvI/9rIxRNpz9DjSx9gL/oHAYR8vFu2q/19odDhn3hngv/iZj2Cr3nWR65AIuVd31sEnJkBcQ/UAfAXQ+sNstMKiLwADhR70YrGvlj1EEwVgg82Nm+tjlOGHjV6qnEIfFqQ8pif1NQM0zvLq5ys/R4X8nVlGxGohlNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXJmx/Pk5tZmak69SENYHbCE/Rio/8itOQ7QftH7ixM=;
 b=SKawJ1SZPAzZ8A02r2uRN/MzVtO0ErN+Y8zbIimtwVqIo9ISiM7K7Ntzq1WyGP3Gz+kCd0nsc9/b6YD4bDk8iwJITMTQe/VzA8lyzRRjnsD7zrUjgSo9ECx+dXp3WiujT9EeLa3K/X7CJPhTDxkH5pHYBRKCsH/DRkg71Yytp0Ud7Jl4oMtnWRcJWChy5m3STZDM+O8PlgnyrULENNPp2RMq9sSlA9uPMAo7VZCdWVV0HI/ZR6H9Gbu+aHTMKzkQh7NeMBaoZrbu/ekRwpDQ3XlcPCsGbxGlw2lnDgCK7H6NDf8c2I/nNw8SYyVnlboZzK7qC4XC0VuT1P1ydUuAXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 10:29:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:29:20 +0000
Message-ID: <1310f7ea-9326-4200-b92f-17a828975328@siemens.com>
Date: Thu, 29 Jan 2026 11:29:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
To: Richard Weinberger <richard@sigma-star.at>,
 Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at
References: <20260127213927.26960-1-richard@nod.at>
 <3506084.tBmWVcJkqe@nailgun>
 <64c4befa-111c-43c4-ba24-5f079e17c4c7@siemens.com>
 <9873549.lNWL4n7ouV@nailgun>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9873549.lNWL4n7ouV@nailgun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d489ba7-6b05-4856-7291-08de5f214349
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2IydlNzcGQreDgrTnJKMkI2TXdMZ3ZYKzRPLzdQbFlsaWtwdzlnd2VYcjlF?=
 =?utf-8?B?dDdSZEpzUTZYdllxVUk0OWJ0ekYvZFZVL0g3aHljMEVMbXpnMkhvSzB3LzRl?=
 =?utf-8?B?NU1OS040U2Rob3Z5cHpMQmZ6dm92cUxWdzNscXBtZGpiWmM3bWJUV0M2T1B4?=
 =?utf-8?B?WGg5SmlxQzRqOXNneFo5cDRkWE9odnF4T3lBS1FacmRMWG4renJkKzVhUEFk?=
 =?utf-8?B?enY2YmtsVTNOay9yUFJxYU96ZVVMMnIyV0tEcXE1bXBXWDN5Nk1mRSs1cjRO?=
 =?utf-8?B?S1VqQzZHZ3M2dFY1UEIzdlAwM0lYYmFnc1Q2RlF0NWsvZ3RPL2VJMXhJMXhj?=
 =?utf-8?B?ZVF2WStIQ1VuVFk2YmYydXY2STd6VW9STlNzZzFrbWs4S3JIM01lVXVvaGxN?=
 =?utf-8?B?TUVENnVhclF2VUpIbHA2ZE44STA2V0VaR0ZJZDdpNWhVMEJMbTdRbERSYTV6?=
 =?utf-8?B?eVowSDgreGxwSTk3OThJR2Z4Q2dVMWhKM3BMLzNhZ3EwYzFtQUErWURXS3ND?=
 =?utf-8?B?cjZLcEUzZFUrSlhyVEVIcnhZeHJ6OXg2TWFablZHdkVUT3g2UDJDMVE1NTFK?=
 =?utf-8?B?RzIxdWg5VXdKdGtJVVNFTmNWbDlvTys1bklBblhrQkpISUNKWWs4bTlwdmVr?=
 =?utf-8?B?ZXZtN2ZBM1NpdmlqUEM5aGVEeUlyQVc1QmdQL3NwNFFuVG0raG1iTXhjRml1?=
 =?utf-8?B?dVFwNmJHNW1HSWY5TlczZGlyWEdWTFAzV0srNXpkbDROK0Z4SnBSL0ZhelZh?=
 =?utf-8?B?dGhMWjRDcnJnZW5BYzQ3VXFJZjZVTnEwWGtwaUtsdldJd2FUR0swU3R2OFZj?=
 =?utf-8?B?dFhFdkpRem9CbDZlbGZOazFORXZXdlZrdXBmc05VMWJZSWliZ3ZtS3RYSG9z?=
 =?utf-8?B?KzcxZ0lUeUdyakdPNzJFT2t0TzhvSS9WZGNnakpTUjNsZzY0SEJwTXdsVmtI?=
 =?utf-8?B?SHBVQlR6bFlxYVBsckZXZ1oyNUV4aGdKeVdoSlR2TmFHb0pPVERNeW1MQzZJ?=
 =?utf-8?B?WFRpb3lMZVZuMWtsZ3VjeGlpOVNrZDIrWnlVU1Jhc2hMQjRMcXFTVWZxQXIz?=
 =?utf-8?B?NkhQc3cwU051RTZTaVRhZDFmckRSSE5GYVB4eVh5OS9kU0RSVjQ0Z1paOVFj?=
 =?utf-8?B?K1RuaU1ObkthTUcxS2hxUm8wNEsyNnRVNEUyb3lWSHR4V3dIbW9YNmlGV09q?=
 =?utf-8?B?N3BhR1ZQU3M0dVAzRjhmYlJuekVuOVJhTmlzZzFvV3RDbHluMXoyT0FJR1BM?=
 =?utf-8?B?VjVveXhvYU5iNVFsSEtRWGVVblpPR2U3R0w4SjFPOEt0MHhwQ2kyclFmS2ZV?=
 =?utf-8?B?eWxSOEpiTFVYdzRsd2xpMjJOZlZVNmRjSWVCdmp6N081RkR3TFh1VkVwUlRo?=
 =?utf-8?B?eUdnV081SVI0cjFhdENtbGw3WUVaR21laXRvaHhTV3l2MUNaeFg4ZTV0NmdK?=
 =?utf-8?B?NzFuMWJxL1Zwb2JlNStXVWNBY0lzWk5Nci9xaXhCUHJNeldmQTR6Ymxja2o2?=
 =?utf-8?B?UEJnOWVnRVJZeGR5eFNsU1VTaFZXMzU3aFVtVmtyaktqSHJaaWZZZ0RVR3Ar?=
 =?utf-8?B?YjFFYzNhb0Z5VEpDRlFHcGZZMDVRZXE1RnRXUFkwNmFsa1pTcHdhWWliQmtL?=
 =?utf-8?B?aitBNHNicVpHUGpHMHZ0VU13VnJYUjl6dHM2a3VTdGZUNHhZdTZ0M09EWmVz?=
 =?utf-8?B?cFAwamFpVWEvaDljaExQVkVpczNPY1RYVzR3bVZlVmhWb1RmNCtmSjVtT25E?=
 =?utf-8?B?SFEvOWVzUW5Tak9RZFoyZ3VHVUdXejFPbjBmVkRVRkVFYUVJTDZ2N1ZOU215?=
 =?utf-8?B?dFpoRFpzOGxaeER2enZYYkdMNkl5RjMvZGs0UzUxTTlVWHZOR3BKbWI1YSt5?=
 =?utf-8?B?Y3M3cmNCVUk1TTBLcFlrSWI0eFFRaGhCWEZ1YWtzUG03U1k4aFd3ekFycTVm?=
 =?utf-8?B?Rmg1T1grWHR2THJEV2hiQ2U3V045Q0lsSkpiV20zZG5LOXM1M1d2NFVRNURV?=
 =?utf-8?B?UW5FTXFBRTBqODZ2TzNlSHhIQ0FkaHdQdHUrcnNZUDBKdGNxa0wvVFdQVFJG?=
 =?utf-8?B?MWNBU0hoSGpMWXNiQ0VwV3cxVS9CUG04M1E0by91NXhJSVZWOVVmZXdRcHJL?=
 =?utf-8?Q?V/zA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWRSTksxOWFtYXEwQUZIazQxRENaVlZGZUN1VUlyQ05XNHd5VEY4UjIvdHVY?=
 =?utf-8?B?c3ZMamZIYWhKTGNXdTBBQ05zS1FTUlJnTUxUUHdDOEZ0MVBlWWJyakVHeWYv?=
 =?utf-8?B?ZmwxTFB4ZTFGUkxFdklVSWp1YjlvWDE0SHlNRGNmT0h5ZVBjVTBGMnJic00y?=
 =?utf-8?B?S0N4U051VzYxWHg1UzNvTUFsOElmdnZPSFJwMmFxSVIrZjljcFFrVzdjOEZU?=
 =?utf-8?B?Z0RSdU9jdEtZZGFUa0UxOE52MTNSalRTM1hSdlA4MDBmcUE1YlFPNG11aEpq?=
 =?utf-8?B?T0tIdXFiNzc2dXZ1bzBqVDF4bncxUkV0MUIyeTFnTEdrWkdMZmV6dDgwS1RW?=
 =?utf-8?B?TG4rSjNUSU04SUpxNkppMWxuTjkzOWhrTXg1UDJMWWZHWW1VdGR3cC9Qb3NH?=
 =?utf-8?B?am9IM0Y4Y0U4VW1oR0FtUFBESmV2SjJOWkNWSitTZjU5UmNBTXpBanpkeHZK?=
 =?utf-8?B?OHhJSklFbkdHMlZxeVZESWQvOTE5cDVSelp6Rmt5SDNhZEF6cXdTRkNSQ2lu?=
 =?utf-8?B?MGdYUHNLaExaYmY1RW9DQU4rcy9ReWY5VXpXVlBTWG9rWVZXZ3Q1Y0JWVjRC?=
 =?utf-8?B?MklDVGhnVGFFNksrb1ZINk9ZNldvQWJaYmVVQmFwZVpaUXh4b1ZQWlVCOTBF?=
 =?utf-8?B?bmV2b0RuTXRoSnlOUCtOeENtNUFYaHlsZC8yYSs1clpGTEp6QnR1bkRPK0dw?=
 =?utf-8?B?Q0VGNm1VUml0MldoYTExVXRKUU5aWGl1cHJ1MnNiN3FNaUpxaUpyVkRNWTZh?=
 =?utf-8?B?OEVrQ202allBYlAyMHFTNytOWXJBQXVFbTgxZHZNeTJqbjVIcmVON0lmU3Ar?=
 =?utf-8?B?V0VWdE1hV01pclVUT2pRbnJvMGhYTmNoNzBmNVRyNTVlb2JzYUllUURSTHBJ?=
 =?utf-8?B?U2U0UDVEK2VWQkgySlBuK1pJV0FMRU96eC9xTzFHVi9vQ3dZaDJpVXFxVDhE?=
 =?utf-8?B?U3VuakRwc3hHTnF6cmxUamxLV0NQWlArUlZNdy9NLzYyMEJJTVBYRTZ6bTlQ?=
 =?utf-8?B?Y251OWYyMXNZNXlTSHhVT1Rza1g1amFtMGliWlp6bVExNEhGL1V3Q3FsVEZ2?=
 =?utf-8?B?OTRjR2NVbFVjdUE0Vjhzam5hZHdLaVoyd1AyYnhpTjRFeWxXV3hTZERXUVA5?=
 =?utf-8?B?SFcrN1hLdkIyNk9yWnI1UDRoeTBwdUU5cHJaV2xDWFl4cE4wQy9CZzlvL2R6?=
 =?utf-8?B?cHNzQnZlUXlWYy9hQ3ZaR1VibHJTc1pZUVpkT2tNdy8reUhiVU9XQWJTaWg5?=
 =?utf-8?B?K2YvaktPdCsvcEI4clFKV0N6cFJ3RWVqQ3J6R3V0UFZ0OEJSY2hLZmlic3BP?=
 =?utf-8?B?VkpNYVNGaWc2Szd4NGhhVENrbWJpcXRFYVh4RTVnRVg0NTk1cVRpQ3BKMURn?=
 =?utf-8?B?WUFEakg5cTNUZDVaT2ZMTklIeTlTZkZZb1M5dklMVCtwSjV2VXlRejJ4U1Vx?=
 =?utf-8?B?WXE3RTdYQ016amV6aTYyZHNvMEhFdS9XNXpTcnNtQTJnVVJNZnh2OFJUUmJZ?=
 =?utf-8?B?WHhoYXRFcWd3SUNnSklOWUFNTURpTVFJSGRPYWIzUjFGS1BidWJnMk0xTlJ0?=
 =?utf-8?B?blVWQWcxcnZqK1pHdWZWbG1aWmF6eS8rTWE1VXIwZS9vd2R2SXkweTNubjdu?=
 =?utf-8?B?SEtSN29jaGhRaGNyeGpreXU0RHJuYzVZSFU4SXBML1A1Q1EzOVFlMmgyUTBT?=
 =?utf-8?B?TWNkc2duN0RZeTdHdWNsem4yeTV4cWZ3RjBoRjF2Q3ZPQ2oyOXN5aHAzOStq?=
 =?utf-8?B?VThpNU5pOVRjYWxSNFZyODlNM1AvdnpPQU1nZXJlNjNTOTFsMjNKazc4Y1py?=
 =?utf-8?B?MXdxVi8xRjdvWFBhUHQyTWJXUUk2cFlLTVZUZExya0Q1a0JKZUdkUngyMjYw?=
 =?utf-8?B?aWladkNGajV6SXpjbGVNTXhZMVhSbFpoNmo1eSswNWV0TDBFVkpTWGN6dUdI?=
 =?utf-8?B?V0Y5MmxITHNMUE9DREQycUs1SFVJdGdzNERiM0ZDSlR2TWM2MDhBVDBFYnh1?=
 =?utf-8?B?MG1ybXErRjcxa2l5d0s2dmw2NGJWT0hGY2djNDlhcVZjRHorOTcrK01LSmtB?=
 =?utf-8?B?QXAySk1IS0VJeldMcEZiV2RiWDZVS3hNZEQ3V1hVQkVhT3ZadGtrOFN6YU5r?=
 =?utf-8?B?MklGcGxGZVlRc0RXSmMrK3k0bnJqdHZDZU1HcnpnbDR4NHhPVm9BTTdWeGlU?=
 =?utf-8?B?dm0yWW1xRzJwZXFHVkFQSE8zclV4QUQweGpvQjFmMkZBYTEweVc3UHlBR2xz?=
 =?utf-8?B?ditjRjVyRkRmTjhCU0FEMGExSXBnUWU1MVFMTEVJVnBMQzNhZXhEU01Zc3Ni?=
 =?utf-8?B?aVY2S095UnExYW83am5udUVteUdJVUNNUFA4Ym5iUFhFd0kwcUNxUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d489ba7-6b05-4856-7291-08de5f214349
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:29:20.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdL73VACb9UhxbUMjR5uJOm38+EbrRvHMF/rIAJNFuIOD9wuBCahledUgautQmcoFUaxVrbDsS9CJC9tPuvTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6603

On 29.01.26 11:09, Richard Weinberger wrote:
> On Donnerstag, 29. Jänner 2026 10:57 Jan Kiszka wrote:
>> On 29.01.26 09:36, Richard Weinberger wrote:
>>> On Donnerstag, 29. Jänner 2026 08:45 'Jan Kiszka' via upstream wrote:
>>>> On 27.01.26 22:39, Richard Weinberger wrote:
>>>>> Ensure that the task structure remains valid until the join operation is complete.
>>>>> Previously, a race condition could cause the structure to be freed before
>>>>> xnthread_join() accessed it, leading to a use-after-free scenario.
>>>>
>>>> Where exactly? xnthread_join performs some checks for the existence of
>>>> the target, and it is locking it (find_get_pid).
>>>
>>> xnthread_host_pid() in xnthread_join() dereferences the task struct via
>>> task_pid_nr().
>>
>> Then then next question would be what is protecting the task struct in
>> case of userspace task. Is this here only papering over a more
>> fundamental issue?
> 
> Hmm, for userspace I'd expect that Linux frees the task struct only after
> the parent fetched the exit code? So, after zombie state.
> 

But Linux has no idea if we are still holding an xnthread struct reference.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
