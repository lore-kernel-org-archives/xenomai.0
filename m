Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D61E764D
	for <xenomai@lists.linux.dev>; Wed,  2 Oct 2024 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866499; cv=fail; b=Uemt53W0tWICpmdMwzUFjCHvo/XnxFDIRN9mCgSCawGqszaAwFyIH8k60LnYhJWHZGqQ1ANhiQKqGi3DNhgRuARLFNLLkAubQ6V8xsRRNhs16qlS7apX0+7yh7XVY0Zq+GrO++sF6iOZK81KRDPWmqglRGQZVD45gCu7c7QTCg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866499; c=relaxed/simple;
	bh=5RlpZRIypVITj+fYpPqC7cDWJFyCAQHHSwwWJFVq8Hk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sEm58WnM/jO+ff/FxLZjL6yt9sPvRuBL+Ije4lsHkU3lrXqf0CIMRIfipGDQ9HWEyWYw+M3jaV1jMaawZp1ijxnKwDp+noc/NW0u6AY+g5q1O8XZgNWsh5fzq+NzotsyiEa4CqB0uHHr/RmntsK4qyLes83vPc1Jg6MTugACh6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ga3VaXGz; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ga3VaXGz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5hruknnEw8yIJqTXmLNMYSYfBmfOox31bUI7ckplZxzrPdE7Kdn9YvfA9NKe3cCe+qzTQ2WVM24NLdp1ZD4uJ3alSFw/qQegQzhWQS2mvrhSQ+gZ5tVStjVQ5kNsuvlD6TsY86yQkomPxEhOxzwi6NbKRkZUYUxPHuTuHcbFxcp7yEuyNTLVprAOmkYPG0CBB5HTwcfJp+wvHRd5MQa0wmuCq6TgJxIWwBa8Q4PWmzNYRHskkNDoDYbHZKiTdW3ZzqojrZVQIQICrJLJaPVOY0C1908Yio/W2flXi7y26vx75cEkaGwpcCehfj1YEiIJjVM08ll0GUXASo/PFEapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk4uX6eQMPlblF0VLuCgDuVq7Dhh/h4TVFPZiLwxle8=;
 b=S4LHMcv3Wx3/ZIClxAtAY4YqKq9Lq3lWrzE0E8TP6gimXmDWCuKx0lpfLPMcuUNhCan9GXIwtnRq0CYkTQFsT/AnyaePWjfQwLXc1LU0R2lcIjZo4MiGDYlAsNT8E7DqCBO9CB06uI/+184R771C4s3J7FzhMAFsU4bxAz0+vjk5hOo40z7BedP/3GvxMb8IAt/g6J2LXfcGlGBweGtl9tDsHyLkSYDlpe5CSfJzQq9plr53Vn77q6yxRQh/ukZ7q7xPCSBIrDZZRkmyNemonZMyelYzzKS2ij5+ftppIbzT17DujJfD+Z4845zo+nix0cnocu2Ge1f040oL8Y28cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk4uX6eQMPlblF0VLuCgDuVq7Dhh/h4TVFPZiLwxle8=;
 b=Ga3VaXGz+E3qyR6hOBtnjOAMy4O6X8Irsj+uzcATlm09M3lHD5BcjNvsFBMBsNfu+JGDBhOK5HLGgIYuuiALSGm2b2Xr/JVPJUowNGXZUFpn2gzK3xFiD82m0tyYs4Hm2/dJwlheH6R58hWCjALy/FRSuVMElqM/fhB2YlRy5Ymtj1+KEx5TvfmNtEpcsYxrJ5DOzA6KPMycr+Z3uM34d5mIFaT6OhsncSNf5zXVkRRATT7CRlVfANaMnunMZgori2dnKn+aPiXYS3RkUivWgSwPl9lPVlBKPNNK9X/9bRP+3GuQCmdj6Oi2TT1Wsh7Ke62bEnh1EVW9QKnUT86ezg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 10:54:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 10:54:52 +0000
Message-ID: <fd270dfd-f46d-4f1e-96de-41738a973c23@siemens.com>
Date: Wed, 2 Oct 2024 12:54:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 6.11 0/2] RISC-V: IRQ pipelining core
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20241002104007.991278-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241002104007.991278-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bd3e53-b230-4da9-9c7a-08dce2d0a4b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUozbmJicHRtNklzVkhZYnhXd0pLVTVHNkN3bVh0T0JTdmlMcFErVUo0bHBJ?=
 =?utf-8?B?RXlRUlVQNlBVbVEyOURmUW5mRUlzdkVuYVFxVmpGbXRpbDVyOHNPS1NDOFdU?=
 =?utf-8?B?eU80WUdLNkw5a2hMcTF6QnhrTkJFZU1kY3EwTjVoY1ljYlBWV3ZzTnorSnZs?=
 =?utf-8?B?NUU1OXgrdVVkQ3FyM0hGQytPWVZxMWFoWWlacm05NWgwSWVSZlBCVE1GVDdh?=
 =?utf-8?B?RHovaVpuTkhscTV4dmV1bjcvU2dTaXRWRHFWRGF6TEVlRE9pOWZKVmVVNkdq?=
 =?utf-8?B?SklNUWkzTXF0THc3TEtHbUJCYlpDb1cxeEs0YUw3TzM0UmVqampsc0tLOFRr?=
 =?utf-8?B?MEpwd0tDL3NKc0Y1bE5iTlpoaXV5cHBIVWtwOG9senZpK3BjMjZ3R2QycTd0?=
 =?utf-8?B?SEVQbzJ5dDA3VTdTUFh0ZEdIMVZjWS9OL0kxQ3BOUFFuTzBXMEpMWGFXVmdQ?=
 =?utf-8?B?RjljYXBscDl4cFQ5b25abmJzVE1GM3NsY3JlSWFFdnNuSzhJR1FxbnBSLzlH?=
 =?utf-8?B?ZDFYbDNCOEpqVFNRM213amRCaGgwRjNkZzFtMlJ0U05nZWVtZDIvaTNQVHpN?=
 =?utf-8?B?M3ZlSWt5a3F4YWxwSkc0Znk0SlUxR1ZGYVlTQ3I1NDNUbDdxRm9TOXROb3dT?=
 =?utf-8?B?RlVDRVdiMGJ0NnZwejY3WnRsMzl2dnNpQTMxcDRFcTFHQWdvZVFkbWNITWVq?=
 =?utf-8?B?MVgvZTIyRGZhd3g1TGRVSUxNN2NlbGxjWXU4cWdCNnhRL1lta2Y2K01HZitK?=
 =?utf-8?B?TGZKVGMwYTBjUXlFbWFrTzZRSTVIK0N3N3JLd2xiaUFlcUk4RGk0TkV1U1Bi?=
 =?utf-8?B?aUlVVklxblI5QzNGc0wwOHNrcStTR3BZUnBDSlh1NE11Zm9zeUJSblc3V1pW?=
 =?utf-8?B?TENjL0ViZDV2VzZxUldhK1AvOGNidGwrSEY2bEZDYlVGSHdWbmRtY0lFcWxI?=
 =?utf-8?B?VDhpUXV4NVlsZnBqdW13TXpZOERTNlI4bWtLYTZiVVdXODJlY3paSThCVWh0?=
 =?utf-8?B?WlFYNitSOSsyRjA4bnRZaUxPOVV3dGYyQUFDNWUxeVRrUGN6eENEdlFqKzBV?=
 =?utf-8?B?RlBlVFdpZVdzNHNTbFZTZHkrMHRGemdhK2Q1WjAzc3U1aE13VHFhWkNiT3c0?=
 =?utf-8?B?WGpuY1h5ZWZqOHpKdmlNOVF2U1UwZlA1RzEyazdJTzl5THlrczlVUjFBNmNV?=
 =?utf-8?B?QWR1WHJrRElicURQdU9QblArbDJaV005dEVTN0tSK2RPRC96K3VxdktmUzIv?=
 =?utf-8?B?OUNCa1FSdk9hanZWRHU4TThUcStUZXBZK0xPMkF0YXJHWGozaXFtUUdwYllC?=
 =?utf-8?B?NFVBdHBCWTduVUhzcVZjWGlTWENyM1NXbUZXS1ZTV3liSlFGOHB6Rkk4MjJS?=
 =?utf-8?B?NzBmRlVCYVFhSUZkM3RUdWVNeVlWb0NSeU5sOVFWTUU0aU8rQ1haT2tnenR6?=
 =?utf-8?B?bXlTRXU4d2MzeXJFcXo4bzFoTHZjMEo2TkhGTVpLY1hCQ0Y3Wkl0b3lxYUVk?=
 =?utf-8?B?WWJDNlNkR2xSdWwzSDlRaXhrSDNWdXAvVFZyQnFIUjR3NlpqMzloRncyMzJ2?=
 =?utf-8?B?aEQxZ1c3eGFobnhldFVFMkNqdzhRZmFIM29vOGxYbWs1TlFjWmdTZ2Y2emRn?=
 =?utf-8?B?Yk5wNFFQOHN6bFpjYXRzQmc0VE0rNThIU1Q1NUpPWkQ5M3FtVnIyb0NUaGJQ?=
 =?utf-8?B?bjRYL2k5MFVUZUtkNldiTjM1cndobWY2YjRCNHpoanAvY3JrQnIxdEV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnliZUVzdUg0Z0ZmbGk2RjRmeGVGbFcwOURxNlRMTmxwdklnMVpJN0hxODJV?=
 =?utf-8?B?bFdnWGMybjFlTXJsVFg3bFBNUUFlT3RZbCtqRytyTldmK0FKclh3VWZWbmJI?=
 =?utf-8?B?WDBlcUJFOGJxaDRvcy9jMktCWXRkZDk5Wk12Vm5XaFlybFdIN1pwR05wb2J3?=
 =?utf-8?B?RDBKOWdlU3FrNkVNaHVILzh0aEk0cy9iKzZyb2J1NjB1cndpckNWQWsyaFlN?=
 =?utf-8?B?ajd4VmJ3Rnd2TUZ5cE9yK0drZlVEUGxUaWxTdlk3MjBzR0VUYzRVSWFUcFFa?=
 =?utf-8?B?Mk1DOUlDRnZocnI5WFBpbnZHcjRKeFRzQlNvb2RveVFSdkF0QlBQRzFBQWcx?=
 =?utf-8?B?amMvci9LMnluUW5Cc1lHeTRqRkF6MGFQb29pWEJ0QzFta1hROUc4QkNqcTJT?=
 =?utf-8?B?NENYQ1lwNFJrYWU0djgwTlhvakxkWDdHSzdlOTVVaG5GRDExRWhTQ1JtWmdy?=
 =?utf-8?B?RDNZL3VDVVpGeSt3SndNSEFuY0lFUW8wQUJrWWRkNUk4OGlSclpYek4wUmpO?=
 =?utf-8?B?N2tCeXpLVFU3TUpRQmxSMU5MV0ZjYjJHNUpUM3o2WWlqR2MxTzU3ZjBOdmtT?=
 =?utf-8?B?aitrcVhrdWVKY25FYldMcmFvRmw5bjQwSGNtTGRjbHlLYzZxZENpSHMyQTZm?=
 =?utf-8?B?VWUwd2J2cE5vSWFLbGIvVENGUisyNktEc3FwN295NGFUaVBtL2pVdEJkYUhY?=
 =?utf-8?B?cFpxLzRyZ0J2N3hpbkNNYXJWSDdBd3locWg2b0VZYW9TRW5yOXExa09YOXJI?=
 =?utf-8?B?UVRlL3FsK0FIQkx2YUNkOFFqRU56enZxT0l3dWJWejBYczR6cStnNHh5eUFj?=
 =?utf-8?B?cnFLazRacFVVYThXYlRMTUNvZGRjUnVxcVd3dlFPa3lGNFpsM3hsUlBRd2xW?=
 =?utf-8?B?TytGUDF4U1Vqc3FLUW9taHV2b0xDUUtMREk3VXJ1ckJ6RCt1bWx4OGd6VlBP?=
 =?utf-8?B?TWFPdjVqNEk0NlBtZTM3aithSE9rU09kR3hSMXVadjBBWFJ6cUJCVGQrZ3FD?=
 =?utf-8?B?MEF3VUtYbXdXekhOWE5Bc0h0RkNNYnFMWU9vcFNGZjFJbTFwT1oyV05GSVBo?=
 =?utf-8?B?YzFsMGlkTzBnTzFIMlJ6QTNSdkdHdzdjK3dVNnVPTG5aOWMxQVRoVVlrcHBl?=
 =?utf-8?B?UE55VkY1TzAzSjZLS2tMUXcvNTYyZFJrQTJIQis2QjZZSTFKcEpmY2lqWnNL?=
 =?utf-8?B?cWlPOWwwUWFpbzRkQi9scWc1SjNrNkpOQ045SzRQMFVpbWFVcmRCc3JWNHkr?=
 =?utf-8?B?cFl5eEN1czFKaGlpUytidU11VTJhbGl3aUtiL2o2WThMb2VXdU1nT2ZnTTRh?=
 =?utf-8?B?SE5MdTgxcmgyQThGaXdVQzJ5cDM0VlVieUNRV0J6NWZsbGV3TGdBWlpSVEt3?=
 =?utf-8?B?RmVvTXVyS3BhRUlyNytVVVZrc0MvN0s1NFNqWWZQTWZwQnlHUDNMUW1NMFV0?=
 =?utf-8?B?UlNwUjRvbjNnOFh5N0grYnlwVU1vc1ZObWNEdENMSFNoVjJaYzBmbDlwMTFX?=
 =?utf-8?B?TEJsMXB2RUlCcmNZVW1qTitwemZNcXp4SGxWMUt6OWtVSUtod3JhdlNucmNh?=
 =?utf-8?B?aHFZVGY5NFJqMkpUR0w0NjU5Q3lFUCtxa1dsbGltclprc1UyWnMzMUpFU1ha?=
 =?utf-8?B?bSs4KzVlbm5XKzZWYmx3UFV6ZmZLQTAxcTR1VHRNVUJDY2o3Zm1VaDR1SC8w?=
 =?utf-8?B?UHVBb1R6aTZmbkIwbWRhYm14ZDlhNGNoZ1k2SDJiOWhua1E4T3cwS1VCSll0?=
 =?utf-8?B?ZzNxalpMUk1RcGhxS1VuNStEakN3dlFmMFF0eWpPTmJuY3JZd3A1RjRIcVdN?=
 =?utf-8?B?T1FZd0Ewak5pQzFtaTNETlhvNERnTlBVTVF2ZEQvd21WTUV3ejhnYkd2K210?=
 =?utf-8?B?Y3NYTmtFWlhFUXFIWUsvdXZFUjYvb0cvdDZucVhYWXVWV3NBS0FNOVdNR2FD?=
 =?utf-8?B?YlltUnNyNit5R3VsZWNsV3hncW40TDh3U0h1NGp6cmtETm1qT3dMOWFLSGh5?=
 =?utf-8?B?UmZlSmJmaVdXb2dNZFh6eEJLcm5yL0xmN2xsREVqR25EMktoTm1MWmVKWDZr?=
 =?utf-8?B?enRMRmdmc1JaQWpnMnBpbWpQR1daYnJzbE1JV01XZlVpUFk1SG9ZaXRaMDE0?=
 =?utf-8?B?NTRkNjZrRHNjKy9QdGlNQ3Urd21JUG9xSFo2WTdOc0lkbGlpMGp3U25lbHpM?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bd3e53-b230-4da9-9c7a-08dce2d0a4b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:54:52.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esdk1Sp0NP6xARpfBknwa7A+NrRKbblf1YvuOxAygL6QyFPBpkbRq8Mcm7qkGxn1L4SKZfmneI/julSaVEKidw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6823

On 02.10.24 12:40, Tobias Schaffner wrote:
> Hi all,
> 
> This introduces IRQ pipelining for RISC-V into Dovetail. The patches
> are on top of v6.11-dovetail-rebase. Feel free to ask for other targets
> if needed.
> 
> I thought about splitting the patch up into smaller parts, but decided
> to stick to the structure of the analogous patches of the other
> architectures. Maybe this will make the rebasing process easier.
> 
> Testing was done in QEMU with IRQ pipeline torture tests, both with and
> without SMP enabled.
> 
> Looking forward to your feedback.
> 

Cool stuff!

Already checked what is now still missing to get EVL itself running?

Jan

> Tobias Schaffner (2):
>   clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
>   RISCV:  irq_pipeline: add IRQ pipeline core
> 
>  arch/riscv/Kconfig                         |   1 +
>  arch/riscv/include/asm/irq_pipeline.h      | 143 +++++++++++++++++++++
>  arch/riscv/include/asm/irqflags.h          |  35 +++--
>  arch/riscv/include/asm/mmu_context.h       |   5 +
>  arch/riscv/include/asm/syscall.h           |   6 +
>  arch/riscv/include/asm/thread_info.h       |  17 ++-
>  arch/riscv/kernel/Makefile                 |   1 +
>  arch/riscv/kernel/irq_pipeline.c           |  26 ++++
>  arch/riscv/kernel/smp.c                    |  93 +++++++++++++-
>  arch/riscv/kernel/smpboot.c                |   2 +-
>  arch/riscv/kernel/traps.c                  |  88 ++++++++++++-
>  arch/riscv/mm/fault.c                      |  83 ++++++++++--
>  drivers/clocksource/timer-riscv.c          |  11 +-
>  drivers/irqchip/irq-riscv-aplic-direct.c   |   3 +-
>  drivers/irqchip/irq-riscv-aplic-msi.c      |   3 +-
>  drivers/irqchip/irq-riscv-imsic-platform.c |   3 +-
>  drivers/irqchip/irq-riscv-intc.c           |   2 +
>  drivers/irqchip/irq-sifive-plic.c          |   3 +-
>  18 files changed, 478 insertions(+), 47 deletions(-)
>  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
>  create mode 100644 arch/riscv/kernel/irq_pipeline.c
> 

-- 
Siemens AG, Technology
Linux Expert Center
