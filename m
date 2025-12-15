Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863724A066
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814972; cv=fail; b=bcjt9wyRc8gzD75+hhrnSfAuIXuRA2XQkrInt6OD7dawPL5utpDRM66ZbzmTGOuCCDnCHz1v8wl5g03EAm51BGwxGp30DocOEbnUfasr9LiH/6XVvmk/Pht+ZPOyPee3kBMl+ek55pozZcQ0bGoGdGTaNhF8YwkY0s8Gxzjel8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814972; c=relaxed/simple;
	bh=2wnFfgkBwpOtCG+n4z8dwGznnzF4TdK0LI6qS7caC5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RG+kpxRGYyZRmq6dwbZZbmJKISEdKBNEMk0/4YmFLfZSk2egoVaR7x/0zaptQYExAxBGbgt5lEmGZ2Wh6Hs/I9LzsqFRo1L7B2RLMaguOgSK7L7ESsuhI7XbLQw3xnM/fCluGkmikZvFHqGTl/9C4qimbKe0j3DlElOa3kjaD74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yD4x0iQg; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yD4x0iQg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA0CCpBKzUlH98Obppp1sXCOcI7+W8RmZWa6SFeCaXUwnuYw2laSBboD+5tYF9K7l+U6TC0kYu53365oaDTy6PQAU+HH9OMczYQ19QkIWanURC7fxjCY+JO0EtefECpDSwPx8WyiUAjG2V+ng59xaR57jSbeaviBja5T9X2XEivZcIKarAXCCSN/LVzkxXMQ6ikBYiI2ceLNnQLhkNG+AxVGYvrd/AAQvwY9YC57CQ3Mq0xggEJWqASE3/XxakBx1+r+W2r9DiR3mKHuStvRA03+1drHo/IXUA4jgZPCJ8FUHwYVUtldFeRwZxbGXZN8DK4v7vMZrxQGewpF1yQqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+yPoMuPTUrcig1Pl0NGzVN7VV4OXJcIGGgr6qfRpOI=;
 b=kXpEFS9WxfF4mbRmpRx6l1MogA1S2lm5e0X+w3yc8jmmNC7ibjnWx/evty5UL3HvjlmPbJS14TE2qYwQN6WBFNneE+ZuJH72GC7U4sQyyY+DFvYNEwRLKQECydcL0N4QxeGOGdeByn+wsR4AiqMrBUz+nLH4pzhJrBsvR/0xRflzMUgywoXbTTxLyXOiP7lBzgTo4UqcEnggVFKijXNoRZ6dWcsonPII1KPGtgAAuCvLcpTByDE0O8hzthEvq5xF3f9DHlCOck8ZN3sMHbM+gmodByFSBLdnTd4eKjnmfQWCnUJsHXKvf/2ctiZTRuf5fy5ZZbPEMynP3VJ8ObtL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+yPoMuPTUrcig1Pl0NGzVN7VV4OXJcIGGgr6qfRpOI=;
 b=yD4x0iQgMp9Cpr5vXQohisNKJdzQCtUq/y7zCF89IJE2X3lPBgarOiIlRgZxaNDVClHcdL1NrSDDIpy24mxzl5SJyH+oustPIT7RIJB5NHK71c0jeihc9qf3uhhpr+PETlc0GJS+Ci6gWplGNlfqCunJ1QRoej2bQKItTChhFi90PacZ5uCzcoQdtbCNHj3/8bYv9YJrzlh5dE3HHy2u76bZEi5x3/Kz40s+QhHMvl/KS1wnfRzFnr5Euu/d9fNqaoQL3x9X7Y/aX6uu7T46BLw5sQKcvP86O27GPJKWu4/5QmSrLuXsEPv40L2NgR/hQ+kqvVCx1pxhc0Mm3z7N+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:09:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:09:25 +0000
Message-ID: <054819a8-626b-4ced-8388-5d61933db17f@siemens.com>
Date: Mon, 15 Dec 2025 17:09:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] y2038: lib/cobalt: select: Fix timeout writeback of
 the compat time64_t case
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
 <20251204-flo-fix-select-syscall-v1-2-7f9c545a63ce@siemens.com>
 <771a9041-5c1b-4ede-b44e-37a0712ad5a5@siemens.com>
 <de9afb9abf9358ef89f961f95c4bd6e8c19695d7.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <de9afb9abf9358ef89f961f95c4bd6e8c19695d7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b4e147-2a7d-4e6b-e615-08de3bf45148
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTFmTkJqaS9wSSs3ZVZLTWsvcVR5MHl6NVZjaDA1cmFIdUNLZFkralM4YllI?=
 =?utf-8?B?dWNMOGhsQmRHT1U3NWRia0IzUGhHNFMzS0kzQmtSWVNBT2s2b3RKK2xkSGgw?=
 =?utf-8?B?cXd2SFlwaEIvdE96RjdsbnVzZlYwTUFRQ2JYVmZzelhVVkNTOEdRY3hzZDFJ?=
 =?utf-8?B?WVhBdEI2OXExVVZZZUFGU3R4OWZ4cjZCakxUaXJ2MGJaOUFTY1dFdHJSQXIr?=
 =?utf-8?B?b2hyUjJJZS92d0xsQ1NqM1hybS9pVWRIVFFCRUNnS0dnWEFIczluWHZQMXly?=
 =?utf-8?B?aFkwTjc5NlN4bDZLS2dXNkgvSGR2SzVtQzNmWUw5UFJPMUJaczZ3TyttQlQr?=
 =?utf-8?B?dEo3cWIrWFUxQlRkL2FCdmxIYlN2M1F2TVFaeVhKZjVGVmNTdkhiMlJ6czcw?=
 =?utf-8?B?a3h5RjV5VnpKMFNGQUFSell1SFR0Q01xRnp4N3FHKzl0dzFVdDhEUVUvZTJT?=
 =?utf-8?B?MHF5c2hYUTBxcE1wSW5xUXdLNFVNbUVHb204RmljbW9wWkVEVE1GZURnWW01?=
 =?utf-8?B?UE52dVR4QTZ5R2hqSUlJVlllOFp1YVZwckxoTXNTaTBTWGdkZmZKSzBrOUQ0?=
 =?utf-8?B?RzQvRWU0cEkwcGMvTzRWaEFpYURvYmI2eXpzQ2hVeXhubklLdGdmakc1MFNG?=
 =?utf-8?B?d0d3MExxSm9CQVczUTJlNkppOE1qTVR6K0RQOHV5NkJzUk1vemlSV25FTVFp?=
 =?utf-8?B?N2EzWnNleGNLZHRUMGg0K2oyVk5ramxqMzEzN2IycGsydTM0dlNYY1JWNXBN?=
 =?utf-8?B?Y2luTXNIY1o5eC83NlkrVENqanNWTThoditLamQ0NHk5Q1hjMjhyeXN2UkZQ?=
 =?utf-8?B?MTB5TE53b05UZFEzellSdmJqZFNtZVpnNEwrTkFuMWhQWWZDdzdlNU56cy83?=
 =?utf-8?B?dVhHTHZKaXgrNXlvendYaGJyUnc4S05TeHg0bXBQaXZSTFI4cmFnYWlScFNW?=
 =?utf-8?B?UHMwNWUvejk2QzUxeFluU1BGbStDeTFXTXdyN0h1MFYvZTJyMDhwMmZzMlp3?=
 =?utf-8?B?K1lqZDMvdnB6MXU0cTZ4MzlhaVc5cGc3dnowN3FhNTg4Vklianl0V0Z1K0Jv?=
 =?utf-8?B?NDFWYWJtMUtWLzRYaFc5eENCdWk1cWhvbklCaXpvOFQ0Ly9sVEkvc3JkU2Vu?=
 =?utf-8?B?aVFVWXU1QUM3dXVvSm80Rmh5YytneFBYWHFnb0pLWnEvTkVIYTI2VlFLaFF4?=
 =?utf-8?B?NDZpQklyZDZDd1AxTk9CWFcyU0pNUDAzWlg0eFdMWW1zNkFnSVNIck1vWGgx?=
 =?utf-8?B?VDc5Z1BFampMS1kybDJTS2JVYTBMUEZNQ1p3b3FLV005UjhvZ0REa0lKdCtO?=
 =?utf-8?B?cFJpVSs0cllyMGxtcEFOUDBZcUdHTTF5aldJWEFYSU0yellRTHkwb3QvQ1A5?=
 =?utf-8?B?M1hVY3hKNTM4dlRzWjhFUERRWGpnMk13SmR6MFpvYi8vUWxJM3h4MzZCS2NJ?=
 =?utf-8?B?TUYrRnpkcDJPV2NtVFRmTHNKakFwaW0yOXFiQXJXU0RKL3BZbXRtV0JiTFdD?=
 =?utf-8?B?OUhnU2I3cVpicFplbytrL3RRWCtUMENNRVBsN0RLcWEraVYwT3J4ejBIc2s0?=
 =?utf-8?B?V0txR3R4VEtLTjRPM094Vm1yQ2VVUE80cmFXeGxLT3hOUkNBanBPWkNZTlVH?=
 =?utf-8?B?ZFBGTnVrQW8rUVgxZlpjNmpzcGY5NThHWUZ3cGlOTTBIbXo5Y1RrQkNJSmw0?=
 =?utf-8?B?Mm1mOWZ2bXNhcU9yMlRBSUJUMlF3R2prc0ZMaG1td0NVU3dUMHlkVHZBTnBK?=
 =?utf-8?B?amp2UjhXQ1pSTlFFY3lHWlRnSGFEWmRYdUw1aEUyZkNNb2JsdHFEV01XM3BI?=
 =?utf-8?B?UFBvVUwySGlBVUVwRmxUUWdaSEtjak14dlRkU0dDNC8wV096azNJVFNwT0pP?=
 =?utf-8?B?ZmZiVFVybVR1VkF4NndldXNQQlhib0kyeVY3TjlLV0R1ZUFhR1Yxa3AxMEMy?=
 =?utf-8?Q?qknR6DFXgFv6GKW2spbU0UUT2kKTVt5v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDYxa01YektaZkYwSXRYaC9Qc0tCOXQxMExaQVJaUFlBanJiVVhrY0lPM2F0?=
 =?utf-8?B?OW4yaXVISTNGOVY5ZTNHVFZjZ3d0UnE3TkJ0WEJKakZyakh3SFE1YWV4QmUx?=
 =?utf-8?B?OEowWXFkUnNHejlsczRqN3BNbW9vSmFzOG9yZjdIMHlZTFRpT0Jpc2prcm1a?=
 =?utf-8?B?UlUyTGM0RGFaMFlDcCtXL2MvZjFuSDFNanpYbTNadUhOUHVKaE05L3loMnRF?=
 =?utf-8?B?bTRHZDhmSVVpdGdyTkpIZ0tPN1c1RXIyUUQ0ZERxQVA2Tm43UCtzTDBzRmt0?=
 =?utf-8?B?T1U2aWt0L0dnYmlZeEhWek0rNXdDSU02RUkzK2dZNEJ5VFpnQk9FQVRVVlFn?=
 =?utf-8?B?WHVwVlhrcm5Za1hrTSs3SmdNSTlvd2gwVWJrUXNZTjZjMW4wL2FOeHN1ZmN3?=
 =?utf-8?B?OTZ0QXBmeDlFZDBWTHV1YjR6QittdkxYS0N3L3hSZ29JeElBdzV4Nys1ZzU3?=
 =?utf-8?B?Sm1UTXVSU0I1V1Q1dVZsZnU1Rjh5WWJVWVo1dnJKbndDZ2FXVWhmeGVwY2Yx?=
 =?utf-8?B?QUtmUDQwUFZYUnV3VDlubG8xZFBGV1g0bjN4U1RwNE5jTGdQc2tBZWdvcWd3?=
 =?utf-8?B?eE5pUlM2OFVQb0w1Q3U0RWJ3WnNrc2FIWDlweXNwS0NlSGNqUHhmWVpJREM1?=
 =?utf-8?B?NlpaVmZZZFoya2UwYzZDaDZLZitldHQyL2xBbW5obXl4SEMwYmt6ang5Wlk3?=
 =?utf-8?B?QlNzOXZsdllPMVhkRXplNVc0NU1KVnVKT0Y5ZDFDZ2J2ZkFKRWs4U1VWSDBD?=
 =?utf-8?B?MzF6dDBvQk5qYmMvc3JjRUNmOXRhWjBFQnVja2s5Wk5TajhCNUhoRWFXNGNz?=
 =?utf-8?B?MHRSRG8xbmJqM0Zlai81WTdiRTRlTHpKV1lBelBHaWdUaHVFVWY2ZEhFTWRz?=
 =?utf-8?B?b2xUUDZiajk5Vk0wblR6QjBqMGJMVlBLMW8vbTAvZmNKYk1PaDFISEc1NThE?=
 =?utf-8?B?YTdaelN0bE9wd0J3Znc5SmlqR00yZkhZbjBPeHduTVpVWmRDOE1sb09LalZX?=
 =?utf-8?B?Tm5kY1lCUmF3K3cyci92QmJ3UlVORkpkS2hTa2lJQ0tic1lFNmxCVU5tWlJx?=
 =?utf-8?B?SmFoUnZYSmU1Qy9JOTRDRGFVd1lacjdBRk1UVDFSZVdla25ieTFIUjJJSFZQ?=
 =?utf-8?B?RkdjZUgrcmdrd1REbWZDL0JSYVIrdXJXaXZjZUlpdlVIR3p6WmNJWVY5UEo1?=
 =?utf-8?B?V3hTalYwTEJ1SnlmejU1bUhSbzUwQnZoMUVneFh6T0tqVXUvQStJV2dCTWxV?=
 =?utf-8?B?SFZySkkvNEx2a2wzMWwwbHZiclJYUzN2MWc4QXN2czZJMUdVK0NwdUlMbWpW?=
 =?utf-8?B?MlloRWJtMmNRaksrVlNHOExXZTNMZDRyZldqSCtNSHU5Z0VBRS9Ndk1qSnYx?=
 =?utf-8?B?WS9BYkZNQ0pMNHkwTFZKS0JWVHlydkxjY01UanJYc3ViV3d1aDBvMHc1VFRM?=
 =?utf-8?B?NnRyYUxLdTVqbzRLNlVHbUJqVjhqZGZ5RjlNVENheUNqekdGZlBsL1l3NUwz?=
 =?utf-8?B?Wm1wOXcyNnIva1pLN1phSktpeDU2REVZUFFwVmJVZmo3TzZDQjZrdmczS3ZV?=
 =?utf-8?B?RnBqd1NkYktVUDF2ZktpazRBYWhlTjdYWWs2bWROS3ZxaXBMSko1RmNWdEw2?=
 =?utf-8?B?cUpOblB6UGZ2L2JNdFVMQVllMFBpWmVkWVZsbEd3ZHNxbWJ4TWdVL0J6UWl5?=
 =?utf-8?B?RFZKSzJuOHU4UUFnbzFxOU5MUlJYSE1YM0J3MUNYZ2duQWZuQWhEMHZvaUNI?=
 =?utf-8?B?TFFxOVI1NXFZOWdBT2IvWjFKaDJJbGF2YlY4SGlZQWMvM3NOZW9WWFZvNmtt?=
 =?utf-8?B?bUtZK2hDeWZlSXJGRkNRUUlLcDl6c1pnMXVkc2hXRFJKeE5XczVYRWZhaEJS?=
 =?utf-8?B?Vnd2Uk1ZeEc5WHhyeVhYeEtjWldNN240bUo0MmI2QXZGc3ZvVnBZNTMrRW9D?=
 =?utf-8?B?WXhsV01sRjJLVWRnZkJZN0htclZVbXpYVVF1UmJ0SE5xYUx1c1F6OURmQk1x?=
 =?utf-8?B?d05MUC9hMlEreFZVTjhEY0xEQWQ3NHNWMVdhcVNSajdGWUpBZkZ2Q3IxVkRa?=
 =?utf-8?B?QXVDYmRoR2w4TnEwWklHdWQ0dVRRMHlIR2NwVE5hekoxbXFtVmtTWmtMU1Mv?=
 =?utf-8?B?Qzg4OWZHVEdaa2RlRUliQ2xUWk4zVy9tOVVKN0JXTUpLWVVXVUxwbFhZd0w3?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b4e147-2a7d-4e6b-e615-08de3bf45148
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:09:25.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edzP7/seg1bsDZ1ipi14AwDTlWcVFhSRp8F4DrkiYXCtk5GafihshyOce8xGB+07pYFB7rzSRLRbcmGCmr8c4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5876

On 15.12.25 11:24, Florian Bezdeka wrote:
> On Mon, 2025-12-15 at 08:02 +0100, Jan Kiszka wrote:
>> On 05.12.25 10:03, Florian Bezdeka wrote:
>>> The kernel might modify the timeout parameter. As we have to convert
>>> from struct timeval (user) to struct timespec (kernel, pselect) the
>>> updated value was hidden from the user.
>>>
>>> Fixes: c2b883446b80 ("y2038: lib/cobalt: Implement necessary wrappers for y2038 support")
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  lib/cobalt/select.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
>>> index 611994d17..4a44b4fc1 100644
>>> --- a/lib/cobalt/select.c
>>> +++ b/lib/cobalt/select.c
>>> @@ -57,6 +57,11 @@ static inline int do_select(int __nfds, fd_set *__restrict __readfds,
>>>  
>>>  	pthread_setcanceltype(oldtype, NULL);
>>>  
>>> +	if (__timeout) {
>>> +		__timeout->tv_sec = to.tv_sec;
>>> +		__timeout->tv_usec = to.tv_nsec / 1000;
>>> +	}
>>> +
>>
>> I think we can skip the above if the branch below is taken - small
>> optimization for the forwarded case.
> 
> Not sure. What should the fallback to std(select) actually see? The
> original user provided timeout? As we have that fallback twice (this is
> the one for the compat but y2038 support enabled case) we should do it
> the same way.
> 
> I'm not expecting cobalt to update / write the timeout while returning
> an error for the same call, so both ways should be OK but maybe
> confusing when comparing the two do_select() implementations.

Yes, the fallback below is for the case that cobalt refused to handle
the call, for whatever reason. Consequently, there has been no waiting,
thus also no modification of the passed timeout value. The code above is
not incorrect, it's just unneeded in that case.

Jan

> 
>>
>>>  	if (err == -EADV || err == -EPERM || err == -ENOSYS)
>>>  		err = __STD(__select64(__nfds, __readfds, __writefds,
>>>  				       __exceptfds, __timeout));
>>>
>>


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
