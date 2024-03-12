Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B23236
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229477; cv=fail; b=h8bwvzCFopMLy6WIsw+d9t/vfzmgDtnSwCb/vA+wE+ZSazqqzOSa50nm4It3ArxKq2DrQe78ADHaFlCpO/Ah87T+wt53nQ+VSE5f/CDug27KInq3nUFWawdDJiTiauOAfQpVlaguJjKV4TZafW1T2KDTy8QuehtuhPMvqhVN2VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229477; c=relaxed/simple;
	bh=oQ3pIL/tOogDp1YvvLsf3mv9l5/fsZb641C8das+c/c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mmognPUkTavqXAHBp8FCxJKE0rWTUvy7eKFL1ini9TrhsiMWcYRzrNnwJAdvqAHEuvTV2mwiYs1zWoP87uBJMemAIu/J9u4PlSlfSM6O7eE42uMyhb8zOVpJSnVU8gBG4SUPqvFSGr9fkgQ18uRBEhm1cNH4QvTdgU0Pe9xlwiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Clc4Cf9/; arc=fail smtp.client-ip=40.107.7.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Clc4Cf9/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VktQjXl+FG2ZJa9FTI2QENoPoBUyFq5Zzb9MSyoNEPYYcsZJIJytlqM0GORGIPu4L3josZHG1Al5bjoz2StJil8w6CVMXHryLjCF1f/StY17qgsSCwWXrqzUyn7QEWzMsKTidKQoIw73h1+jt6+dsuFvQDUaz6ANAeVNnKiBk7Yan9FnAxe6Ps+Fe9dYgjCr4XHnh4+Xq6tzedpiDWCTSDIE0NDq/dUbaFTAcrrj7mA0SB5B3nY50SgJh/9Syx04L9Y17YJCqCXdNxpUHEPZ1LFcGHHey4SDCgluCHU/jGkiDHdsezBSYcXvWNt/9BMaOiCma6RuiPnTmellrwITkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAuSafwCwISMTeIznD8zoZ6VPm6BaifGB5sm6Q6oKdA=;
 b=IBKKMrZaYKdAi0jgyD9/LDiTeiWelqFsQDnXhIUJYr9Ku3Blpt6ukIsm7gGZihSk1zeYlD13A7Lzkmxv5Zq7vItBsf8R2uBz5uKi1FZfdKX2J8ZIBf3vrZQLzW1mNPrGkRBI4JRr9qYyldNFWmYGgx1mX/aaa+sZKVCJG+yRGCyxiMH3EyKLE380T4Kk8oJXNeGtKq4feCE0PvdHwWgYfnm5r9bTVa1Oxhrn3Y0mWQOcFxcIhtDj782ePdX7WtzcgotoYTgWUwKoBLfS9gxVkX/Dbs91kenB3/vjI9EtGB6hIQCGGl18B1YdA8lvyKpzww5HkPEbAfa0v15kLZjK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAuSafwCwISMTeIznD8zoZ6VPm6BaifGB5sm6Q6oKdA=;
 b=Clc4Cf9/4lJotgrNG4Un0j1OQaxPQ0WR9PYpKmF3Nw1jp7AkV9bp0P6iqBufccGygOcg5g/gshkLH3K5NGe4Ekf8Fvz6oe/uf/7Cc+lcoYp+M2gGZexbsCFumdq2zeLreTgZBlk3+cezLytrhVqm8lfu7RNLtyS6cRkKXiFR7kSldsVBw6cT+FB78SeTVhUPe6cM/YOmvG4PGhPv0dPiiJWqBdmQciXwdDkhrSR+Pm+EU7wrQseUUA2amPmQgD8AP+Lsb3TbLD5KltcMi03M4V9yblU9nYbEd+j6PpcomEUctYcUU2Cs2VnnD6Zwm+ZznwafWQocYVU1NSXHYUcZIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:678::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 07:44:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 07:44:31 +0000
Message-ID: <28da2b72-87a3-4b3e-b59a-9bba18b290cc@siemens.com>
Date: Tue, 12 Mar 2024 08:44:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite: smokey - new testcase
 pi_nesting_contend_multicore
Content-Language: en-US
To: Fabian Scheler <Fabian.Scheler@siemens.com>, xenomai@lists.linux.dev
References: <20240312072341.27967-1-Fabian.Scheler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240312072341.27967-1-Fabian.Scheler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ed4cbd-c22d-406c-7d90-08dc4268412b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jlymw/VHO8CL0kOV2XMNi5s+Ys3S8zVlUqZ73jgLFVGA53d3Id0cqEacn30DqRNlf8MNQGL5g4Ie1wHEAuHgZ+1f9YCAVBh1eFwwl/+UHgW5ZVURuYgzWXNNgpFSX2wQ8OrTQyKl1N5zn15ncw+HhPLq3aHVARPhJWs25j/m9jLZ3jI9LVZP18V5R8DRC7iiQtnhf6EwcpSIkdIIrnz4QqY3RVZiKad2po42Cas1hq/GHs/AOF+y/ncwHPakGztdpVkyUWdIK1cNOrKs/GeWVahUkdSDAAPsc0Q0PnvN8jtdNgtXydLtL9zOxp7Z7k+JSSqKnb6Z1AWGQxHvEEMNkBvFwrHcSp5yZOkToC9RDKoRl0oWhtcj9AlvWgnvQp5uuGEcGVWD3r1JoVk2Ec2pSjT4yjVbVELDotYBVXXHCDz+5Xn2RzSVYSiyVuxukUJLwAt1/y4Xl0BNQHwNggjTbX0Z2vp0dArwJkyWB3CKEjndvOAtUIYLSKl7gtDz1gmp+1OYgErLQitJW9Bx/zOk5V9eVMDpA1pzuFmbX+Gp7A9Ecg+K/yPnN5SdLV4UZ51ffIKyMaR63Iy5mAWkH9Z7yH4Dmk3NLRT5mCFvdpKmCAppCZVAS5M5Se9a6QUItYNiLaQ2Tty/opZY2ad+36oXsy7f+qlKspLsD1MKupRXBNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmRTNFM5L2xDLzFVRWZhRHRkNTh4RWNBblRZK0FPRmpvUzhqOEtjaDYvcWUz?=
 =?utf-8?B?U2FwUlZxdVRYZjBXRmFPNE9EVm9hbW1EbTJBcWh0VzM3ZS8zM3hrYWxzc3JP?=
 =?utf-8?B?ZWVTZlcwRUlBdVZXU21lZGdyTllEdTJsOFhrUnFBdm1MSXh6N2o0OTNqSkpo?=
 =?utf-8?B?dkFjc1hUOWVBaXNPcGJZeXoxY3UvZzRHYStVbnN6YURHbk9pQ1hKSlVpZ3BY?=
 =?utf-8?B?b0xRVjQ1WHYxRzFrUzkyNEpVQ0ROS0FUZHEzQmQ0ei9lK21rby9MLzRQbk5i?=
 =?utf-8?B?N1VWL21PelUybUI0M0hGb3BJZ0pmcFUycThLemh5VENidUo1YXRuQjBsRk5a?=
 =?utf-8?B?K3dvbzhVMC9HN1g1QzA1RGYzZVpQRVU5bWp4OEZYaktuQ0d3WDM4T0c1MFFn?=
 =?utf-8?B?K2srTStaREtlbDZjQ2VLdVVsNUxscDFFcWpYSlh1S3hlUHBTdFV2OTlCUGQy?=
 =?utf-8?B?REJ1NVlFcFhOYTBRQUhrQTJ5bjZrZTQ5NTlSUlBvWkZnY3N3TUFiUUFKdVZx?=
 =?utf-8?B?VUcxNHlCVEpJc21iZ3F0OWpYSnVFWkY3SUJJTGpWN1dCSVdJbCsrcDlwbkNS?=
 =?utf-8?B?cGM4NGRCTUV4Z00vcGlXWmRTQndqVmc2ajcrSk8wT1FVa3VHbUFRaGZ1ekJo?=
 =?utf-8?B?b0FJbm1CLy9Eb3J1YkVLOHFSTnhGZndsb2xvdTV3dlN2c3RrZVYvYUpUSFNr?=
 =?utf-8?B?VWlPNFkzTHFsUkRyQklxbThhUjR3Uk1jTUsyL2pUaUhxUDNzY2M3WEJoTUVM?=
 =?utf-8?B?aENLcGpmNlByVkNteVlWM1gvbGlrUUhkTGRVc1FROXVFelJsR2tKb0tYaVEv?=
 =?utf-8?B?dUVBSUhJUFhCeEwxMDR3azU0ZzlQM1FIMEx4VVFxSitPTU16WjduTU9LYU9P?=
 =?utf-8?B?M2VJRVpPdFFCSGtTSVB1UHJHUXZiNDZEV0pqb3B6eTJZZjlJMVBzZE1WWm1R?=
 =?utf-8?B?dDRTR3lnMlgrQWRqL2IyVzAyS29yY2VyN0tsVG8zTkFvMHFPd2tKYkJUc2hW?=
 =?utf-8?B?ci8rUlM3dmpPZzhYdWF6d0ZSUE9pN2FnUXJ5NmoyK1RieGE1NERvcjFtMWVx?=
 =?utf-8?B?dm8wak5VMlNNMXpaYStGNStmWkorUW12UU5TQ3JGb1QwQjRpMWk2TmhRMmRJ?=
 =?utf-8?B?MDY0T09SNWRmK3hnNkx3dTd3TG9DWWI0bGVHelljK3ZZTUs4ZnhtSEpHdW5L?=
 =?utf-8?B?VTBUVFhna2pJbEFpNmJaZG93elVadHMxQ2lCdlBzZnloc0hNYjMrV1pEb2NS?=
 =?utf-8?B?eHBpbFUyeFoya0RVTzZuSTlwNXJ3OFY4SThxbXhPaE5BMjhJRlgwRzcyVm11?=
 =?utf-8?B?ZE52RTNwVjhkWjZ3SUk4WlRBcWNZR016L3FoRUxpRUR3OWlzSGRRbWRCaHI3?=
 =?utf-8?B?NDRoazY4M1pkV296Y1VBNzJkMWRqa3VyeHFaVFJCZHpqOTJUUzFZWHFCZDBP?=
 =?utf-8?B?cGtFMnJ3QXFMbUtUOTlDRFdhQ0N3RVVmdXRCWE1ta1dOU2UxQnRpb1JFcm4x?=
 =?utf-8?B?cjhTODQ5Yms0UjZXbGp0VTloTXZLRmc0NTdCenRKb0laRE5nOFNTZkNJUWpx?=
 =?utf-8?B?Zkp6Q1ZIUVJXR2NId3NsN0sxQXlhRU5TdlRiZnphWkl2NVhIMmtpbnlZcUZ5?=
 =?utf-8?B?aUp0VTU2ZDFVbFlWTzVpdWRsNm1iS0kwU0JmVzFXWXBQcjhQQmI0U2NlT3c3?=
 =?utf-8?B?c3AvVDJOTjhBOEFzWGQ3a2hmYzFSMlMrOHRnaVl1UCtZQ0dUTm84WVJaY2t0?=
 =?utf-8?B?QmI4enFidFhOajVQVkcyWGdFZ2hnZFVlZGRycUtJU24zRCtidVdMOGNJcUYz?=
 =?utf-8?B?aG42RTVSTmRLM1VMRDMvSTBjYnIzeXlEcGdRV2FhNlcrU2MrV3RoTzM1RC9T?=
 =?utf-8?B?K21NY2ZOaVBBQXh2VVZoS3pMS01aRWlMUnQ5bkN2ZkszZDNVZTBBcTd4VENM?=
 =?utf-8?B?ZGhvdHE0R0RZOHAwVHFDYmZ5V1VaNHNDSVlzeUZ5SnpGUEE4MU5rZEtjdEln?=
 =?utf-8?B?NzBiSWtRbGU2dEhpQ093TStKdUdlRXlmVHBrWWMrYXlFMUZsU3YwVkVRNDQv?=
 =?utf-8?B?ZlBGMGlNMUUvTTZFOEE4cGtPWHNMV3NSNU5HU1k3anZPNjhTNUNsUTdnZFUr?=
 =?utf-8?B?bjUweXVyQnFlUnIvQnQ3VXFaaUpCZEZWWTdFSUNqVGdWd3RnNzJmMjNuNSs1?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ed4cbd-c22d-406c-7d90-08dc4268412b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 07:44:31.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTVcFKKtJLFD/mVw3GCA09U2e6x8wRzHC+D4ELNLSL3kT8etzLYKodhUrYTpa2yr7gSIwhOwNAiZY4qRptccDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8148

On 12.03.24 08:23, Fabian Scheler wrote:
> The testcase adds checks the correct handling of priority boosts in a nested
> priroity-inheritance scenario and distributes the high-priority threads involved

priority

> in this testcase to different cores if possible. In contrast to
> protect_nesting_protect and protect_nesting_pi only priority-inheritance is
> involved here.
> 
> The testcase implements that check as follows:
> - A low priority thread locks two mutexes initialized as pi-mutexes.
> - Two priority threads (prio high and very high) block on these mutexes, thus
>   the priority of the low priority thread is boosted.
> - A medium priority thread is started on the same core as the low priority
>   thread that must no interrupt the low priority thread as this one is running

must not

>   on a boosted priority.
> - The low priority thread unlocks the mutexes one by one, the medium priority
>   thread must not run until all mutexes are unlocked and the low priority thread
>   falls back to its original priority.
> - The correct execution of the medium priority thread is checked by the low
>   priority thread by checking a flag that is set by the medium priority thread.
> 

(Not yet having read the code)
How does core distribution come into play here?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

