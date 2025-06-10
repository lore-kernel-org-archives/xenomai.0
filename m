Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61B29C34E
	for <xenomai@lists.linux.dev>; Tue, 10 Jun 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564595; cv=fail; b=E6wyv8iZjUjhaahhLc46ZAD2COvMriSNCujjsCOUMC0Gc51qJzApTEBWcATcedrVWO25PsLEfR/F8pCxZEmE1iwGM6MGjgUawlRsMrUUvdLsx885Lbtss1ARn7uKM5p8oG/kvevRzFDKjFXqlYG4RVB60Q+B6c9lhWjchoCdosI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564595; c=relaxed/simple;
	bh=jIIdLyPhZzEnFt5Eq46daa6fdbefSdU2OykK7E0lgFk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=THeDiI4AqKqUERkLqo9ovsgJb51a8Ge7sBkNZDp3leHfXvqVm63SqS6Omtc1PyZHfTJ2HAz4Z9ttplOuj3eISCfOJZReWAtvmMVRvJHqwF2AEx7BmOrYqLznRjw3daOu8KyJeqq0sckPdOMUwdBsN0dn1wwNiaD2/RVmw1WoJZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UaFc6WKu; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UaFc6WKu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7Q/l2iaQdjL0Z8BuhqNzttR5T6P83ys/IF+p7XnE1SRz8PtAAYRGaisOZdZPJbM552eCYlITAzvVFksWmJoMND1JMrWQPilzTVMTlxBLubO8USeJasR1AQ3fm2A0eu/DI6iy27pmN5vbORmksSThES/6qSavw+6IPrHTiRyaWkoOKU9OhKxWMj7YzXojruD6gcGlOIsvkRW7jmEmnBzy/mNP9iOh3BPXIUMYrO4OWTAJ+IzRjisuaQtCqPNe+p+uO3QKO6qkNuWlQvn8NAcwB/Kac50bTf8YB+GI/yn+X34H7vgwne2Ps/1AXYVV/JIf+2nBPZiroq5Kq+Pot8mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wdavIr/7MiGEA1rWb7L7kTpATXMR8sDDp/Nz7B5yhI=;
 b=wfup5avPPlBw9oR4TL2vhIoEKVcNqu+fedhY4/05ouul5WCaOwK0p7surrDk4YHubr+9LtsdjiuheK9GmOyJLPFdZGT5iLwtlI5aXivZ84Uc38ONgsXmEx8lAWBWp7kqikCA96VzkK2ZDv706rOHlfoE564bqgsDR5HysX+fkZbMU+W0di1jUilaNhCzTnk9Dm75NYvp6ZaQ6IfXulYbJJFO8atvGPJOe43srlv6qvntJ34UXWY0CNq3pnhlB+gYDnVhZ7pEMPiT4+TyzeRGVHkW/y6JSLbP7DHDdAMlbQo7CmZsshIz7wNOwlU0WmT8CE2J1Yct33T6toT2sLmPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wdavIr/7MiGEA1rWb7L7kTpATXMR8sDDp/Nz7B5yhI=;
 b=UaFc6WKus4sxgjEiSNNfU3oN2v9JzrpubkslKFxebNx3bnwHcm47uNzAF+n/j9rcXyB58HteQky9IXp2iFiDYd2VfB23GWuOF6GJJhr/EE6xuTriQ24ALm0VpGqrJ8sre9GxIh92J8cSrBxTF47TZyKL7LyDpGKHA75j40W8DdQwuyC3LGBPRplTcLxEnD96kRz8umhS4vAMCHlhz7/p/UGJyWqY1kcfNfl8jnCVTcbfb9As3L21uO+bHhgpPwl1JPBJlLtW6Rf5UvrUQNYJNmwULCEDPb5ylQ9+V5UGV5O94UAO8nGg0InHnM1hcrdAiORz09Yhxw/rGpl5RsgWcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:264::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 14:09:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:09:51 +0000
Message-ID: <0f7091b9-5c6f-4c44-8919-8e8c7e21913e@siemens.com>
Date: Tue, 10 Jun 2025 16:09:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Controlling cpu for interrupts
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
References: <1461577086.484867.1749468459969.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1461577086.484867.1749468459969.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: c91209bb-a4b3-423f-cc44-08dda828772e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUl2VnFSaFdFaXlPVXJDQUo0S2JWcEYvZFdocHNDbVBFaVRUbXBxTW5Vdm9o?=
 =?utf-8?B?WjJaZURFNU4zY2hMYldYYm42SkRtMzgxRk02aitsckcyejVjL1RJUHNaRURh?=
 =?utf-8?B?R3BEZ1VWTk5SWjhTaVlvRXg1MGFGa0pSYlJ5TzkzQ3pTMnAyRHd5ck5iSDg3?=
 =?utf-8?B?b0IwZi8xZGtUclY3S3NQbUN3eCtpaEFTdmZSK25GcEtheXpVd2JUbm1FaDgv?=
 =?utf-8?B?SjFqVk5xeVM5MWwwa0RrSkM2ZDBrMDNyZDg1bmRmZkd6TWFaWHFVbmhlalp0?=
 =?utf-8?B?Q3N6L3VUWG5tK2twZUtBUzJkWHZJSDIxamo5dWt6L0JTcDZ2L2o1OVZNVzVH?=
 =?utf-8?B?TEFJNXJlRDRqdkdmMC9YeHM2TWt0c0w2OC9hYVpKRVpzN2Q5dGdLQk9sMVh5?=
 =?utf-8?B?cVZOSC9TRVRLVVR0amJBYnJxUFg2aURsN015bldCckl5eVdGU0xBQnNMYjlG?=
 =?utf-8?B?SVd2aUo3QWU0U1g0R1A5N29BYzBJMDI4Y0VTK3dJdkRiMWhVdmtDN2lYUUts?=
 =?utf-8?B?U1VQTVJPeWY3MDFmcS80d1hGclBhaVRQSHB4TjdvZG5xZTM2T2xUaEt4V2xH?=
 =?utf-8?B?TjF0dGZOcHZNQ3NWZnVNa0RSNFZSUXRVU3U1RUtMSEZKRnlTV0Q3dTBYRmRR?=
 =?utf-8?B?U05CdGh6bDVIbXZ0aU13RmdpWkE4NWZMSWZCdnMwdW5xWTJ1Mk51clJXalp5?=
 =?utf-8?B?N2RkdHVwMEZ3NlhNMjcrcVpDN3dRTmwwbU1yN2tDUGxIeTFXaG9KUHhCa2dF?=
 =?utf-8?B?a1JlOFVSeXBVOXQvaXRYS2huYjNuMHhiUTlsSTI3M0M5QkFuY1Bld2xHWElx?=
 =?utf-8?B?bDlwdVRJTlNKdVAyV3cxN0JSamJNVnh6N0dSK1BnSjBibHNrcWljRVp5R1pD?=
 =?utf-8?B?WlBwclRaeUlkd1FncFNoSGZ6NlI0cG1zdE5XMDkwWkI5M2ZRV2Y4RnRvb0FJ?=
 =?utf-8?B?cFZYdmkzSXAydHFqVmxTYWhRUXEvRWxLQnIxbG94TnIvZmR6OWUwTHYxTFFu?=
 =?utf-8?B?dHZKaG04VjBYU0c3TUlUM3JEc3EwN3cvREJxQ2xjaXhrWXdkNVB5MG5yYW1p?=
 =?utf-8?B?K2taNHk5bk9yV3pvc2cva3JQdnB4UFFoSGZZL3JYYmJrdzVZMnlVUEF6N1dT?=
 =?utf-8?B?NTJlbnNPY2ZIMjlxMlllRGhqYURiZXhDL3dVYUl0Sis4OXJ1aUlKZDJucWpp?=
 =?utf-8?B?Rm1hL2RrWkF3VGZMTWxEVWR5Rm1YL0M5YTN4SDNobkFYblBUcDF6N2d2N2Vz?=
 =?utf-8?B?UmVzZlZvMkM3elNwcUoyYm9PZjJNNjZLMCtJcFg2QWhtcUdKQzJqdGkwUkh5?=
 =?utf-8?B?ZEhEUjBxaXNyOWVpZ0xEZkZ5aHJsbEdLMFUwUUV6UjBkWERmdEtPdjBDZ1BP?=
 =?utf-8?B?N0dNbFYzcG42Tnp1ZjJLRmJBdk9FajUxZVNvRnVBUnBIOHB1eTVUOUhZRUE2?=
 =?utf-8?B?RjNYVmtDRHdjU2l3R0ptbnkvMXFpbWRNUWhBVzJwdTJMaEZhVVhjcGVsQy80?=
 =?utf-8?B?NG9KTWpaZVF4b0QwcktyRXNJck5VTXU3VVFrZVJkRmJsaWswYlcybCtBdmlm?=
 =?utf-8?B?TFgyNkd4YUNISGpvSStoSHpsNFhtd25XT3RkaHF4OWd0azJuS1pPNmFuV1Bz?=
 =?utf-8?B?M3RWNHJlQnU1WC9zNVNJbXVoSExnbWdJY1N2Vk9lSWlLa2RTTWZqb3AvOStz?=
 =?utf-8?B?WndJU3ZPSHRiMGQ0ZzdOVUdIaWFmeDRwSlh0UkQ4enB6ZGdYR1A1anVoR1dX?=
 =?utf-8?B?dEdZbW9sTURNbXZKU3Rvck1iMXF5SEhZR1JOKy9yZXJqTEdCMERRV0RVSjl6?=
 =?utf-8?B?ZjdBaU1pOWE3LzM1MHZZUVBLeTBkVFFuQjNVNndtTjEycGVEV0dSdWd3TWNX?=
 =?utf-8?B?TFpSR1I2V1N6Z2hMQS95bTErNmJSQ3BKcUdOVHpNd3gxL2phdjBrVS9WdHVV?=
 =?utf-8?Q?OYLYR/2en2w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnRxRWZkZmJZOXNpQlRKNmg1bWxHenRvbmJoZDBWUFlEdVhENVpsejgyblcv?=
 =?utf-8?B?bEFhQzRxdnZTb3NaUkFJdkVsNHorWE94VDlRdk5KbHFNQVZHcFB1UkpSSzRB?=
 =?utf-8?B?a2ZRZmNiWlJ1SmxGRnRBcXZ3S2VSdjRLNU5SWFZJV2lLejNTSWsrci9LdnZr?=
 =?utf-8?B?SGJCU1RXVzJzTm9RSS9QNmFOaFJGMHdaaTZMOVdmdzNtczAvYzVBKy8rbDFq?=
 =?utf-8?B?dDhMN1RId1hXNFM2Zkxma1BybXhZVllPV1MxaFJMLzB6OGJISFBPS2xDWDda?=
 =?utf-8?B?VzBmelBlZmg5cmRyT2RWT0xwVyszcHNTbWk3UGVRTUhsUXQza1o0NENsTzZu?=
 =?utf-8?B?YXJzTW83eEwvVDNmZkJ3YUk0YXlHdkRXdDJBL1RINUNqbkRreEFPY3NWeGRr?=
 =?utf-8?B?YnpVZzJnT0xFajV3TGJWSEhuL2doUjVKN2YzaVVsT2VHbjVSQjMveEZaZVY5?=
 =?utf-8?B?UEUvSWFybkIxT0Y5TFhUelhtaW1tcVNMaExiWmQycXFEU0pMbkYyUjdZQzJw?=
 =?utf-8?B?ZkJIRmdsSlRUb0NyVE1VUCtRZHk2VWJweDZ4Y0xQTEprZ3p1QlJhR0hqRWJh?=
 =?utf-8?B?bGppeTZpZmxoNUNDUnFON0pxZTBVcUNJVHhaNGZqY01vd2IyMmdCSjJaYjlz?=
 =?utf-8?B?dFZPUjZSbHVKS21WZC9nWFJmRXdOdVJjZXRhU2FKT3hvcC9hWGUraElPaWM2?=
 =?utf-8?B?clRhUHM3M0F3aEJmQ0pXdWR1L1ZRKzdpamVTaSt5STMyZHJ1dXV1TXZ2VkRN?=
 =?utf-8?B?SEU5cGlEc0lydHlLZ3pMazIyNndDOG9JYWEydk1uSGtScHBGeWNaUHlZWGJT?=
 =?utf-8?B?TWpkVW40bzliNnlvM0dJOWJTUGZtYTVPYUtaTk5CbzdyQkkyejlIYWZaODBJ?=
 =?utf-8?B?RFdnZWQ3ZGJKcGZ5R3lTTmY4Y0htSlhYdUVNVHo1cGxVY0IrdE9QS20yUGNx?=
 =?utf-8?B?VjUvZE1PbWhzY3E4WVlDMUpSY3RtcHkzWW5MWk9LQ2JwejN5SkpSS1MrVHE1?=
 =?utf-8?B?WWpRY3dpSHlFYy9XMlR3Tzd4cmQ1cC8raVFrdDlBV1AyaGZlVXFzdG5ua1hR?=
 =?utf-8?B?VlJZZ0tqaEdNaVN1VEI3anYwYlJ4MWFKd291K21wT3hMVXVBb3FKTGZMSE1x?=
 =?utf-8?B?ZWdPNzJFOGZZWDArQi9RaWJzanNtc0swMDZNSGgzQmlOZ1ZuRWx3Z0E0Q2o0?=
 =?utf-8?B?Q3B1Ukw4ZjBFd2JlWGdlODQwY1gvOU1mSjJzWkZlMXFsYVpnSVlzRVZmZytL?=
 =?utf-8?B?QS93TmFhN1FuZUtmYllpT3FWWjNFVk5aYTVwUnNZaHRHUXlUeDFWZXNFT1VJ?=
 =?utf-8?B?MEUvd1RKd1Rza3lBeFZ5ZDZCVFMvNy9ncFhwZVMzc25LSjFWaFg0VlBJNWdR?=
 =?utf-8?B?MlhFUnVaeVYxVnY0TSt6NDRsTENZQ2Fpbmg3N3FZdFdnbzlhYzVaOCttNThK?=
 =?utf-8?B?V1crZDYwbHkxY29YOXIyUTdjajI0WVNCa1k2UkJPZ2pZUlJVbDQ0SCtVNTFo?=
 =?utf-8?B?OXVLQ1VmbWVaTGxsWUZqRTR4akJZb05MVlJla3pUUUdBK3R3bENpV3lQWDJK?=
 =?utf-8?B?UWRSK1VWQ1pFWm1hTVNVVlRVa3V3T294dko0bWI5NW5ZRmgrT0VKbHk1OUZs?=
 =?utf-8?B?QTBGbWJRczJ5b05UK0FQTU1kYllVQWdvZ05ydEg4QnMwL1BhVzl5U3RPbGcy?=
 =?utf-8?B?UWhYSS9yZEJLZHJoY3RhU2VGcENqelZRbHlCMUJabHBtSzUyVm9kYnpIdm1q?=
 =?utf-8?B?SnhjTTBkcHcxQ3B6eEl2L2RFOXZkREovc2JmMUhYYjJ5bWpEanZ1dTdUT0Zl?=
 =?utf-8?B?cE1TdkVRNE5CTlh6ZW9yY2dFaVgzZURjOENJYUlMNmlGVmlncDErVVYyV1h2?=
 =?utf-8?B?bTZ2QXJ4bloyZ3pzN0ZmMkJnOXg0Y25wTXlFZkxXdVRCdHdRMGcycXlURW16?=
 =?utf-8?B?Mk1vVGQxa3N6ZC9sVG9CeTgybzBHb0FUd2hQR0RXdzc4ZERVd0JFRk1NZVMw?=
 =?utf-8?B?VTNUTys5UU1QaXFTbWxtYkNGWWlPMUQrTkJ3MFp3TGZHcWw4aWhTWEJCT2Fn?=
 =?utf-8?B?cmtjek1LQURYUlZaQ2VLWnN6UE55Rmg1SWs0djM3UHNuTzhzaEdCTWJXajJQ?=
 =?utf-8?Q?JTOIMmdTcOW24doO4u0rkqlvJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91209bb-a4b3-423f-cc44-08dda828772e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:09:50.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEWMKKH4CxxbwkOuYVh7k8o1irLfQVSXoYLw95QTBwnODwcgr9z7WottqXBT2sphfnRxf8h//HgN0OGty05hUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5706

On 09.06.25 13:27, Per Oberg wrote:
> Hi 
> 
> I have a setup with
> - Xenomai 3.1 
> - Linux 4.14 ish

Ouch - dead horse (kernel) warning!

> - RT Net e1000e + igb
> - Peak PCAN

Standard Linux driver for CAN, right? This is at least my interpretation
based on the irq names below.

> 
> When I look closely on the rt-threads I can see that the IRQ from the CAN seems to be coming in on certain cores, but now always the same. 
> 
> Here is an example of my ../xenomai/irq file:
> 
>   IRQ         CPU0        CPU1        CPU2        CPU3
>    18:           0           0           0   130419960         pcan pcan pcan pcan pcan pcan
>    19:    88638780           0           0           0         pcan pcan pcan pcan
>   127:        3215           0           0           0         rteth0-TxRx-0
> 
> Thus, for this case it seems like IRQ19 is handled by CPU0 while IRQ18 is handled on CPU3
> 
> What is the heuristics, if any, used for decing this ?

/proc/irq/*/smp_affinity apply here, at least for standard IRQs. If the
mask is containing more than one core, it's up to the IRQ controllers
and CPUs who will take an event first.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
