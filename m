Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415CE1FCC56
	for <xenomai@lists.linux.dev>; Mon, 21 Oct 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539687; cv=fail; b=sj6XdXjHisjQLFgjKjNTtVYiLioddvv4NF/Mm26PaxttgHLERigG6fLxm05dkDgHaAwXjfHnjxayyJHst5kAivs/m+TmJqD9i91LbDNe1aZG9ymYq4QmYHlGzoNr+z5fEWVQX9lB6pBvuOyx2xAvF21gBhYAVIh7oEruZwQX8u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539687; c=relaxed/simple;
	bh=rtBsHSaQNW23ebcGHue6fDjV9lxe4RbTOK/aACYici0=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=t2ymXjcqU2xKDjlZRuM9idmLB1CZZqJW5pHpQ3OP2ThRuW2pPbeCrcg03+PhzHyGiYwLfFSLENggnBOB/dkh3jdKLoCSd8TY78O2LM6+5X7Orh32/pz+zJAP+IxVC25zoQOP5R+0MRxF/UNn/HF44udIGUURFFEjwbPdZNSBLcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ATuDDaPP; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ATuDDaPP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3r9B8upYLoyeRWQDzV0ziPZqD1c7Cnd1IvD7iMYIV1lM14Kj6QTPygo7l+Le7Qln/pKYkZNCegRYNT1QCT03QtO9AYqvHvrksB4CrWwhhze/As93NH8bEMFexqAOJq3K2G1MYA00KB0CGGD0naQEYTPExXT950uZl68kQYEq+2RNtNiHxg1/+2ThOqSkefTaTe2aDdB2jPUJcq3go+SNyTZoE9RdyrHZiUCbfPkVYv88VrbBxG3OOJ2fZISvnqN64qS9GdveJJ0atPwXckkOo+Ah3dtRuotE1cz+2lHdTOwGWFH20RcJ/4/ZuKEe57HuPGL+JZ9QZ1Bk9Ke4QAiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIdo2egq/ONx84za3vRHHlVSpgdVnBHMwE1bijfrJic=;
 b=OlUVIBG1OQ9AesJ7KwQ7So+uvdYAZe5n8fIyk9dbT8/CD89b7ki04mktSKfnS3w7JSq80Kv10Xn+NCE6PMxp6OgtJM3XSqE8KPQc0xuu4/IKmBbnOID2+XeaMhls2Ek/QX7+vNDzk4/LuqbqLsaSt3bWjg26LpOBYdZYWGmf2cda+n2pGpklW+XgzEEsD095Y2ZfHc+ZW7d0QTf/VYnMgbpabyGyNvc6XDhS8Ro6Gi6qx31c9oRaIja1L94neAfm3CEwL48Aecz0znLwPZcsF4a4kHMXrER8Uy7a6qhYNtHaown1DP0zuMXJVPjAJ0PASSsTCLXmXH+ZrfS3xDqTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIdo2egq/ONx84za3vRHHlVSpgdVnBHMwE1bijfrJic=;
 b=ATuDDaPP8uPR78+WJmtnH5XGxnFQVz7oRNPD6OmVqyemUN1k/OJB90bdvdT7Ts79KQZVPtH4joNmAVJZYX4q9L12XbG5pxMNS8b8Onvt1eoCUkoAkqUQn/rLAIZQRTr33sPb4l0AcPZWCMoOyKpuwiC2ZjtQbgrO72q8cPR+GIPGXTATvDb/JDHhlmujU034rPtr43KqFGTf1oLp+6yyeD5C4yn/M4PoPtEpv88bYTvUBBV49DfHhuntSYLyZWhIVP8P2fgmGCLs01rNUsVOWYdY5nQV/4tWW+cVjlgaVuuXgydWGoDg1AjzHXv4mq1QTJ2ehzybT73fW2F4Rmdq6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB8019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Mon, 21 Oct
 2024 19:41:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 19:41:22 +0000
Message-ID: <14c804eb-cf79-46c5-a269-874c17a98668@siemens.com>
Date: Mon, 21 Oct 2024 21:41:21 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [ANNOUNCE] Xenomai 3.0.15 released
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6e53ee-0468-4317-324e-08dcf20857ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0FZQWdpcVFZbVJ2TS9JdnczVDRQNFl1VU5GMDRxc1hjdyt1MEpkeEpVVEtl?=
 =?utf-8?B?UGtObHBZM3IvRDBvL1hhS01VVThvVEJUK3hJWHVBVE53ZDVHMTM2KzZpL1dB?=
 =?utf-8?B?dVh5ZVkxaDFucTAyUzNEYkVBOUgyMlVQaVd0SjFaaDRNcXNtMVROSmRsOVF5?=
 =?utf-8?B?c0FqdjExcWlrRTZDQ2ZCVzNWMWkzdDFXeGpETE1zUTRMbkxFaFg2bVhxS3Er?=
 =?utf-8?B?Nm15RldLZDUrZ0xlZHdhVDBtTjVvWUQ0NnBkbVhHblZadkVHWFg2OXU1L2M1?=
 =?utf-8?B?ekVEL2dWd0pTcVFielRUUERMRzJYZ1dqb0lmRDFFblluVXRUMFlGRTZpdmxP?=
 =?utf-8?B?TTVEb2tFNDZDSGYzbTMza0tMekg3NERYcm8wc0JOZFNkRWlvRDBsOXIrektq?=
 =?utf-8?B?M2ozcWZjaFp3VUQrSDlVZ1VBZm1EV1U2c1gzUDJST2xjTUM5NmtYNU8waUo4?=
 =?utf-8?B?cTBmWGZxaVJLVFFLdng3Q2haMUtia1BxdWI2V1RoV2ZtRlQ4Q3VGd1h3NWJQ?=
 =?utf-8?B?UzdNWUY1UFd0bWlQWFdOSUI0eGY3UWJhNHpDZkJhVXFySStVWTNDMkVpdVNT?=
 =?utf-8?B?OEtFcEhRV0k2S2s3dXJTdTNHWWRwTjJzL25zZUJ1empvVk1LeE1iN3JIQUE1?=
 =?utf-8?B?aFFPZG9hd3VQbzdpYWhBVzhVdCtxanpVQ25Ob1pzQ2FxaEJDbnpoOEdPUXBP?=
 =?utf-8?B?U29YTGYrZ0d1R0NicTNMSmV1M21kUlBnMjJjRkt4NjFOcjg1L2JmSGpENHF3?=
 =?utf-8?B?SlR4RzEyUzcyNlhoVTNIRTRvSWJUV2pxbXVhMkVXSkt3T2J6MVpMQWN6TjRu?=
 =?utf-8?B?aDIyQS9SeEN5TFoydUxSRXJweFhtZGJaa0JIaXFVcCsyOEFIUDVPcFUya3V4?=
 =?utf-8?B?alloN0FFaWVVY0RBQUx6S0Y5bVZ0azd6K0kwbW1FSFIwMzVCdW84S1lsL2pP?=
 =?utf-8?B?azlERE14RlloWDIyMlk1NjZDQVlpVHBWb1RENG8raHcxemp3c1kzYlM0NDZw?=
 =?utf-8?B?NVB1R0hjMDk5eitzdWd5UGx1SS9ZYkV0bnprOTMwOGkvRDVWZWRTRzlmWExh?=
 =?utf-8?B?WVM3a2RUcHpYdFpaU3YzQ1h6RjFRdWtIcm11MW0rUUNqT29mT2Rnd1JuTlQ3?=
 =?utf-8?B?QzY1WjZmTFBHelhrNENCb1llaDZMOE1WYWtEWnVVR1BSSFJDTVNrbnNKSjNz?=
 =?utf-8?B?N0VaUlRNbk5LeitiaWI2MnhBalQ5VXA5T0dOTWtHeXA0MnIrVFlDUEpCS2g5?=
 =?utf-8?B?V1ZYcUhrVDdZSks4bjB0TEE1bTlzRGJ0VE41SVhmY3ZJRnZxTzJ4Z2RaZnlk?=
 =?utf-8?B?cWpNUWw0TitDNGQzck9hWGZvMmtna25pVVdKSEVZM2ZFZ2wrNEpBNE51ekxs?=
 =?utf-8?B?QkcwUHpyK2RuUy9NTWtocS9WN0MyT3p3LzV2WngrVWJ0clBUWmZWS1N2KzBG?=
 =?utf-8?B?ZDNEZ2E0aDZsck80c3NGTkJQL1Nlb05jQVhoS0lxcTh6THViY1VQM2NvZm16?=
 =?utf-8?B?NzZHVUJRWXVyVEJsbDJBZzZ1dGZPY2MrQ1czajk4UnZ1RmJ5OGFHSmpGNVg1?=
 =?utf-8?B?UWM4Sm54Yzk3K25sM04veVJxcHpuMWpxN1RQRDRrM2hpYklLVnRsdGFKNEZn?=
 =?utf-8?B?Z0VZWituS1NTM2w2ZjluZkx0K05FUUoxcUcrRkxMTW5OZWJlUVZEeTV1RW9T?=
 =?utf-8?Q?DrLkI02Bi9zytjhOEBam?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVp0NHZJaVJsQkhKRmdacGJtMkdVNzZpVUFaWG1LaEFWZU55MDI4cWttV2t0?=
 =?utf-8?B?dDBNWVVJYlE5eWhsZVo4anBHRVp6bC9xc2lTY25vZFczQ3cwTzVFTW40Qm5j?=
 =?utf-8?B?MXZTdHQzSGx0akJpdjk3RCtVajlWMVNpaGJjQm9DVlJRZzEwSS9rb3QwRHJL?=
 =?utf-8?B?bGlXdXNNaGdIVm5KK0w5alpYZEJpNUtCdDJQZ1h1S0N3d2tvdGpTYTVYZUF3?=
 =?utf-8?B?d3pnOGx1a0ptNFhNVGthQkRCRE54UDJUNWRPTmZMNUxiQ3R2czErL1FMNnY5?=
 =?utf-8?B?QUxGc09JYVZpQ2h5bllaSjd0UnZra2d6b3U1NE8rV2JOMzRjTSt2NEVWRDdj?=
 =?utf-8?B?NVZxRlB2cXpmYkY4bEZHT3ZrMHpQNTgxVTFpb2dCTTk4RmxHNlpnVjd2ODNm?=
 =?utf-8?B?VSttY3h2YnU1ejhab3NpRFVNZFR4bmRJb1lRYnlYV0d0eGk3Z3hNWnJRMUpK?=
 =?utf-8?B?U0pCQU5DbFBTcUFvKzFkeU1RdUdMNVR4dHIrMmFWeXFwN2kwYnAycnppWVlH?=
 =?utf-8?B?QUpCTTA0TmJJd2NSbWh2Nnc0aTR2bzNwbmhBdTJmS3hMTm15T2RyRlc5ZkVG?=
 =?utf-8?B?ekowMklENGVZVmh4aUxHUzdvalR2bDFLNTJWMUFEZVdWUlNIQ0R5Y3pmK1VQ?=
 =?utf-8?B?dDJIMGs3b1pjUUtZZmVmWjh4TVNvVGJnSHhWZnJXRDkvS2pqNUd2R281dFNB?=
 =?utf-8?B?SDh6WU04WCtZYkY0ZzVXN2dxdERaaFFkaVpiS0ZBRFV4QklzdmZzRm1Gbk9p?=
 =?utf-8?B?RU9xUm1FZXlaSlpNZVdkQWZhUHRYbDBGdlpRWHVuZE1TaVVuOWxMMzdsdTRQ?=
 =?utf-8?B?aU5GU1FrVTJxZm5wdk14OVB0eVo4a1lLeGxNSVdNS3h1RlYwSmRqbi9hYURt?=
 =?utf-8?B?UUdRVk9vZVZrSWZzTkVFcFVEaGJIYzZtd0VJWSsrL2I3dTlsRGZidFNsd2FC?=
 =?utf-8?B?ZU8ybkpoUW1VcXkrTGUyQ2NiSm5mSEptakUrYWRSa1ZLMy9yVXpyMHcyaFp2?=
 =?utf-8?B?bE5UZE53cVJwc1JRcTB1a3dMS3ZmaUFzU3VvYUpaQ2tKQ3oyR0t6aFRPNGJV?=
 =?utf-8?B?UjlWaDBBOFM2MjJCdkpva0d0YXVHbXZLcXplS2NxWVc5Mlp3aHdMdkxUcExB?=
 =?utf-8?B?NVhnb2creXVWMG55UFM0UXZGL08wUFE2MVlINVpua1RwcVNnSUNJNHNneUZ6?=
 =?utf-8?B?M3h1dHpYNERIeWl0TmN0SDh4RXdUVCtydzJ4Q1RVeUVoSnBpQ1dhYk9GMmFk?=
 =?utf-8?B?Q2ExNzdNbGFoeUEwbHgxcDYvSEZqQmc3dXhqdmxMY3kraDB4Ymp5bWIzQlhx?=
 =?utf-8?B?OG5HV1FabEhqeU5GNDJyUUtVZmZ6L3JEcmdydnNaVjBaQkFwUWp3bURWK2h2?=
 =?utf-8?B?dnNyUWU2SEM1QjZUb2VuOTRYSmxIRHlzUVNHRk54bURMNGdYZHJmY2lMaXJD?=
 =?utf-8?B?WEZNcnF6Sk1jeFg5MHFxUXoxemtjQzFwRjR1N2JXdUJtWkZKWnFnS0o0OXBZ?=
 =?utf-8?B?ZlIyTHNUVzhJNFNsWjR5V3dkQ0RRczQ3bzhwL2VpZFE4UmdVNGpNUVlid0Jn?=
 =?utf-8?B?THQzVkFVUzU3OExIdEtzWm1hVTlyNTRUQ0ZnbUhJUzNFeXU2MnRkM1BmbE5J?=
 =?utf-8?B?eFROWUhRMU5JTG4zNENpQXhEK0p2ZFVSS3YrVTMrN1M5L2dtZmVjaGV4TCs3?=
 =?utf-8?B?R2lFNFNQcVhmdVhYdkI5MTZOZ3hDYTZYaDMxb1FtUk1SekJQVW1mNEFaUFE4?=
 =?utf-8?B?ODkvUVhFK05pTGxjcGlDN1UydExJVmRpcnNYK1lxaXRDRDJnOFpFamI1OTRJ?=
 =?utf-8?B?VDcveHlaUGk3am1qcndMbkx0RzFxdnFGK1JQUFdQT3J0ekc2ME4xZ2pCR2xH?=
 =?utf-8?B?b0NoMnQwQ1FHK3FmZ0RVeXpIZ0p4aGtMTVMzRldsTGlaUW9GdFhxRUh6dkFo?=
 =?utf-8?B?eDJDQlpaUk5IdHBzVWVVTTAzR2xBR1dVdmNPYkJUd3MzZDVWRTgvVG42eUtu?=
 =?utf-8?B?NHplR0xMSmdjbjUxYW15NVdPVk5takdhdGhJS0IrVjdaVTVpcGpIS1ZQakpM?=
 =?utf-8?B?RWNWZC9mSXpoYWY5U1VEY1p5Q2prdjVXRnEwWHkrMDgxTHJDYmJUSnZxVnpr?=
 =?utf-8?B?WXd4eFVTSEU5SDBCc21OVFFGc3JNTVRzR2NhUC9PNWpqeTNhNnJtSHA3ZmZK?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6e53ee-0468-4317-324e-08dcf20857ba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:41:22.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEAs5M8/lmcdKHsa87c7pih1/CnQ1DlQztn0s4ZaNaNJB92SJdM+oMGE9heqUbLZJv7cyCqcLVMa/K5ZDjsoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8019

And the 3.0 series should benefit from the cobalt_monitor_wait fix as 
well.

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.0.15/xenomai-v3.0.15.tar.bz2

Changes since 3.0.14:

Jan Kiszka (3):
      analogy: Avoid warnings when CONFIG_XENO_DRIVERS_ANALOGY_DEBUG is off
      lib/cobalt/internal: Fix lock-ups of cobalt_monitor_wait over signals
      config: Bump version number

Richard Weinberger (1):
      cobalt/drvlib: Prefault io memory again

Simon Graber (2):
      doc: Fix typos
      doc: Fix grammar

Jan

-- 
Siemens AG, Technology
Linux Expert Center

