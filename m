Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A722CBE5
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877354; cv=fail; b=kX4122TflQBfqx7YVA7UIxROfrd3MF7DZpQHdQt4sI3Iin90NF+WS0ztu4gbzuKcLKQZjYh6RgEu+jsDcpFyMsDrsaMiJMQqGfrO9dbFtcUPckg1mMSvYy/RAeAv5XAVzZq0FEhgHLlXmoLGQgzh/oTjU7ZKhtfoDWDm/hKnVQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877354; c=relaxed/simple;
	bh=+pHGqdrrFiECT4P5k+FY4pitZnqgmsgOL5QokGz97YQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ccDivp4eAGiFBkTPbtTvPV2oSNhcbYCOMeFeYJH3yciNkq/MGNV9hywq+XCfjYCEjmMC+8c8xFm2Pn2AYAHv+6fRpESMj2oQwXMfUniq/K05DIH9WexwoU3fb8ILnTa22QCFrjtPzbJJ8smorAlukpwURaPFPREPrwFItmee7nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VOvDvn9x; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VOvDvn9x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiEP7vBa7aq94f4++amLwR/SKhT9ms8O0f7rUKgboOyPmYOO8MGJNDyM3bAQfTqmZb3EECYb6J97iejn2QlwQKbDZ91aaF9/9UB5LGIZvqyu3VK+lJbgHTpOw/bg25MRrVtTg/Da5zoTc5VWnNbtvZRjHqOXVRpkVqChjc6qPp8ueEgI1fnwqQxqo7xbIfBBrxOiAI61VJpWTLLdox6VPUpmheE+dwQvkw9elI+82xIxp/RYHCOPTZDX5IlmPGGIgcqHGUqZFYvs6jDs1Wa6p8xl1+0tfLsjWJtFiHirYcgUrs0ao8VH1viTgYJTUC+47LNXIK0b0DXTCTPIeSZqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pCqJ42/hykKPKnovEtPAGqevL/RI1CghCXdyhheV+k=;
 b=JavtgsUSb1ceC6oGRJVcg0F8ihc3NcxJtUpIGsfMvjIZPaCcolXeDKVawmiw+bHCfGJHRY8KeY1Oc+8I2NExlq+xg46XAEdvPekU5FhfeExa6siWY2IZEswzlAnPe/YiBEKJpseenxXK2c0tiJ+1pROivNK9DRTPyItgpJjKkbt2ChKtXkU5qyEUTf3dUtQqEizFfAFJ7DhFipbTeY30hqRelvmJUbuPnrvd9tU7hV9eTZVyBvSwDymMc//KhFkPTvcdXPUOW2q/puuBNTTS2KS5y+e2pcVuNUPqrN/LyWfgcsAXvskhWhYNq0bhsHBdPPOVzssEY87dT3RfrTaSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pCqJ42/hykKPKnovEtPAGqevL/RI1CghCXdyhheV+k=;
 b=VOvDvn9xV90GAXL5qvYNRv0k//WMzCfNMtTicOiTEx7HtqjBDUMaPAH5dllC32gQONzFwdsPi4WKEI96YcNwCSHOTDamPRE3naf+Svw0lZX38lf47NEOPHp1OxCdHuL7JX+tNrSAcaXQ067USNZawlAlpM7QQVg9Wt2H4PrjtgkMxqNGg0fL+QWJQYKW6ujjVOYg3uVW+8y8o+OU5rPcy5uGqqYUu5QAozeCbX35CWfWkPFJX4jQs27JATo8SQmqVQ/BzRmtadoQ53X/8QokDVZAyahi+TKKaqjrGDQDqcm12Wu6MrsApLkejvXe8aMkGUdEwAVlCilVb6R49mQ8eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:68::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 08:09:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 08:09:09 +0000
Message-ID: <f76f5f55-a793-4fb4-9870-770adad60c2c@siemens.com>
Date: Thu, 17 Apr 2025 10:09:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: select() sets -EBADF
To: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPGcVn1BF0sdG0YHAZHDuQe=68DpBK-bXSSbApP2TV7Q1A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPGcVn1BF0sdG0YHAZHDuQe=68DpBK-bXSSbApP2TV7Q1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: f015f0c2-3423-4981-e8ea-08dd7d87214f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWQyYVgrVjZqODFKanpBWEdCeXYxWVp3UVdlTHljS0duMElXL3Z4UTZaV1VV?=
 =?utf-8?B?ZytPUHBxa0tMcmZJYmZHRTFwdU9pMDJhdFNBTkpzYnZaQ25HVm9tY0l6MUll?=
 =?utf-8?B?MC9OcXdKNm8zS3k5a3RBL0JKeElXZm5ZcjRtdEdnYjRZZHk4NURRT28xSzZR?=
 =?utf-8?B?WlJVREpDNzVJdFdEODZpbStkekFGVk9ZNjRtaC9LVkozT3pmQTNSTWxxdFJP?=
 =?utf-8?B?UG1IbFJQZmVrTkk4VVIxRE4xRmZlR3A1V052c2tsWFFxODZ3N0hTT2Ezc1JF?=
 =?utf-8?B?RFl5ajZ2K0ZiTkdEbmtBbGNxSkNSZlJiQXVYTzc0V1AvMmlxRTZkc3hyLzFh?=
 =?utf-8?B?alMxQXF3WW54T0JjNnpnb3dPZVZRQkVreG5RZTJRRTVrMXFoOUZwSTZRaHE5?=
 =?utf-8?B?Y1NzZUZoQVRTb2tGWkEvYmRLZVZxOHNOUUxHTlIxU09CL3JWdGkrU1F3YWdy?=
 =?utf-8?B?UVZUYWdMcEhVNUo3SW1obE8yOUtaVmlRU1NRaXFPazgxZytSdzdNM2N2UnJy?=
 =?utf-8?B?YkNid3QwVkZzcU5Ic1B1cTYrUE5wWXVWNjhRTXpJV3RnOGRNMnVrbEk4a1VF?=
 =?utf-8?B?WndaWnloajJPTkFDTjZDb3NiQTdEajN3YW9aUHJldGdhOTV6NTNlTlVPdDJS?=
 =?utf-8?B?RVluTnkzUGlRMlczUUVwVjh3N1QyZGNPVXYrTG5PVlBCQU9uNHl3RERVdzI1?=
 =?utf-8?B?MHNDbXVyTXI2dEdwZjJkOENhMDR1RnhKdnpGVTVVcDJGYmZqbHJVV25mMFIy?=
 =?utf-8?B?czFhT0RtekJqUWdFb3l6aVM3TERkNGg3OUtHYkRUQ0hOT01IWUp3TkttUXll?=
 =?utf-8?B?OGVvS0YwZll4THBNekhEZXhKeUtzVmRuaDNkSTBxS2FpR2tlblg3d2kyL2lH?=
 =?utf-8?B?OElUeklxcmhLVDkwOUlKUTZ4MldGcXp0VVdmdXNiaS9RQTZXNFBKbnhwdm5a?=
 =?utf-8?B?TnBoSzFSN2NZT3Q4Tzk4bnhidTlhWHlGSVpYTHhYT0RDamk0YUJmZ3VVblc2?=
 =?utf-8?B?QTlieTNhNDViYXhIT2tHMkxQYUUyTis5TkR0R2dVWWFUeWRWMVRlQUVKWElH?=
 =?utf-8?B?QW56OU1pUlF6S2txK25aMEhEUkJOQStlRC9hMUdvK3BKY3VkcEhDdUYrU2dV?=
 =?utf-8?B?czRnbzZuMngxaC90UVh4YzVTMG12Y3lIS2V3ZVBCd01BTzRBQVp5NlpkeS9q?=
 =?utf-8?B?dHBLeU1RYTVWNGgzS3NDNlIwaytJVkNmOXRLSWFOVkl0QVNYSFVSbS90aHc3?=
 =?utf-8?B?TTNwQW1aT1J1V01VbHBzdTQxTjVuU3R2bmV6em1QZ3k1TnBqR0lRRWZ1ZTJl?=
 =?utf-8?B?OHFBd2VQTnE1VytJVEZ5MGVvajFmQmVCcUdxUW9iTDBwNUkwaHJKNXJET3hz?=
 =?utf-8?B?aUNuSnh2MGUrTE9FVnhyRnpwNFhjSFcwQkUxNmpVRUpHR3RXUERzdnpRZk42?=
 =?utf-8?B?ZDdJT2JPR0s2VG5jaE05UFk2UGFhaml1eFo5dkYxODIrajdOMjNEVXo4R0Ex?=
 =?utf-8?B?RTVVYUN6QzJsN0MxTnNzcXFZekM2dnlaUEdHanFSa0JXeC90UDhkWGVJenFR?=
 =?utf-8?B?clRDc0NCN3krMkxESlhKYkVhdmhqRUxpdHJCa3IxTEFMc0x5MnVzVDVDVEd6?=
 =?utf-8?B?M3dmUjJqQUJCc1FYUHRYM2JqdVc1WWxmNWhwa1hROStZUmpUZUpNdUM1VzRw?=
 =?utf-8?B?Y3FNdS9DR3loc0V5ZXc4OU5EUnUxa0pMaHZBVmNCVUhXTjIvSmNMMlNya3dD?=
 =?utf-8?B?eml4UksyS0IzcFBpK2tBNHBaWWI1Q01BbUd1YVNaMU1aeUxSRTlQZStHTjc1?=
 =?utf-8?B?ZFpqTUJjd0d0aE1VVlI1T3RrWllUNzZFYjJpSmVwOFdwVklLcm1aaDJYWnZY?=
 =?utf-8?B?Rks4Q0hGd0M2RkdmM1ZYVjZTNHBsNmg3UUlNTU1acS9tdGZHMyt0Z1BwYldi?=
 =?utf-8?Q?PKCsUG535mA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzUxaUs0VG8vNmVYdjJPRi9tWm5VZHlmV09CajFkVUxVQkMrUE5XOUdGU3NN?=
 =?utf-8?B?dW5OL2FLY3hvOWtHVXhSQTU2REhFcFdJVVJYNmdMTEhVOXZodWdEckdJOWhk?=
 =?utf-8?B?V3hEZTBldW9HdThqSmVFMVdNejZ5Q1RheG55Z0pVcllSMDJ1WCtXc3dHUWxv?=
 =?utf-8?B?K0hKOEpVejVBRXlUeDN2UXoyajNTVGVGUGV2K1ltaElBRkFZck92bUtZTHAv?=
 =?utf-8?B?VFJINmNKaE84VExSSkR4UzdRaGFScVBmeWIzODJtSmFHaVYwb2ZhYVVjUjZo?=
 =?utf-8?B?SW90Wk9MZlA2amFtTitEYzBJT29ETDZXOXlYOGdKbVdoWVFLK1AvVWhwSlQw?=
 =?utf-8?B?MCtpNmZlWVFEVlhnYk1PNTNBbEZ6KzJPUFQzV2g5c2xrQ0ZVeW00c0ttSFNq?=
 =?utf-8?B?T0Q1VzZoNnIyNVRtL1J6dnBqSk5rK3BYaFdrbU1FTmhidUNZbkhYczdLVUxv?=
 =?utf-8?B?bnY0SkpRUlVGRkIrUHZoamRrdTZZbHVSQ1lyMVg3ZmR4dGhjL2gyem5uazZj?=
 =?utf-8?B?MFc2bDVxT2VtV1c5QUlSb2lwTEhBYzIrMXJoeWlTdzBKOUN1L3UvdGV3ZEEr?=
 =?utf-8?B?UEJNU0VYcldVK2ZKb0hhRGZjdkMxZExXdTBkU1NQZk1SYldFWW1PNnE3Wmwz?=
 =?utf-8?B?dzNlaXZNdmlpemQ5c3JkTE1xc3JjOGhxOXVqN3BVZUJmUG9pYm9oZnMzWTRV?=
 =?utf-8?B?MTE0L1hMSjF3MjU2eVAwOWdONUIxaDVUamQ5d0xMZU1TY0RGNzV0TVd6dk1U?=
 =?utf-8?B?THMvQ2xXUlpoaWpsbkd6QTM3cm9Ib3lVekxVWXFWRXQ1TEVsaXQxQ2RvK0pW?=
 =?utf-8?B?UmU2S045SlNHaCtZZXhnS3BkWXNLT0Nwck44RWwvSndUZTBJNDIrSjBUMmJn?=
 =?utf-8?B?aHFCNjdYYWhXSWZxUFNkeFJ5RmtPWUZIR3QyUXIwYm53TWdvdStPN2Q5T0tF?=
 =?utf-8?B?TGdQREZua1lpbFA1Q01vNndCeGFTZzRJSGJlcjV1UGZqMHBQcGQzRzQyK3ZH?=
 =?utf-8?B?ZGVvc3dWMXNYVmtsWUIyb2xaWUhabVlUOWJlcy9jZFJNNWlETVhJdi9JR0lV?=
 =?utf-8?B?cDNTNnB6N1grRWV0Z1cyc0lLT3FsWjQ4R2lZQmRIUWhBN0xqL3dFU0hwMHNS?=
 =?utf-8?B?MkFRNkZ6MkJraytUdWMvQkJlY0s5RTdRTTYwdklVaWR5dTRXdXdPUDVZWk9N?=
 =?utf-8?B?WFYybXAvZFVpSDVpMEQzNHZ1ZVpKNlVsb2NIalY2WHdMU01kZkV6UFdQdk9n?=
 =?utf-8?B?eFlyZythaVlxSldzcHozUTV3ajc0U2d2dHdWWlVjcXBiVXVSSFdvUnVVUmlI?=
 =?utf-8?B?N1JPK1ZmZkhNeHJUV3o0OWRFbzJCWThOMkoyL28xMlpmMTF6OHFBSWd1d084?=
 =?utf-8?B?WE1SUmMxRU9vclY1bWdYdC9sWDhrNm54dUdDZElabDFoLzVDRWxsQVBFSlV6?=
 =?utf-8?B?c1RPZHRhS0pINmNrcXRPbDBBbVc2Nkt3bVlmRllVZ0RIT0RkZUpIUXBQcGds?=
 =?utf-8?B?cWhCZ0g3WFlEcURxVXNpMzNiaUNxbXdQTVJBSlFBK1E5NGFTRCtaYkoxcjhq?=
 =?utf-8?B?bUwyUmY2bEZaeCtUcHkwVVZHNDBKL3lVVytJZDhQdHk0aVNPcVBwc3RZdk1U?=
 =?utf-8?B?TXJmQmNuSnhKZjRUWU5uNGxyMlZwZWhqR2pZNzR6MGVDajVOV0o3WW5yUldU?=
 =?utf-8?B?QW5uUGVBZ1JHc1k0cG9JMDJHamcwODQraVlKVmdURmZuZWxDRnM3bUErcFBR?=
 =?utf-8?B?OUdFakYzUGdSYlBaR0hoa3BJTkh5UFQvVGNTWnN5NGtic0c3L2V5T3VxdUgv?=
 =?utf-8?B?QXdDMWV0MS9NRDZMT1RLRDFtaDVaNnV4c3hWU0VpQ21TajEvN2x4M2FVS1Y2?=
 =?utf-8?B?dENJakFoNElqR0d5KzkyOThLd1FhM1ZLdVRnWGtTRGJMTHg5NUJYQXFLK2c4?=
 =?utf-8?B?aTFTS3YzUTJJYUUrQkxmZUk3WjBYMUFaYVMzV0NlVlpMcjEzTmlJdlJ3N0ho?=
 =?utf-8?B?OXBGT2NpSVBrWWJlTlF3ZjFOaUZ2c2NmZU4vOEJ4cUZ0WGdGWjNjNG5KN1RL?=
 =?utf-8?B?RU1pRlRBWkpGNFBaZkI0cG1OWktJUHpMTFdaRHREazdrVHppV2FGTzh3Y2Zh?=
 =?utf-8?B?TVNaNFAybFdGNGJEcThuemVyY3pGK0ZaRW8vU05lT2VLZlRTY21MMDh0K3Fr?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f015f0c2-3423-4981-e8ea-08dd7d87214f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:09:09.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyWJQhJb3Ds4QEEjW1hs1GQ0MWhrmimhNZnhBRMDbYXtvMATITceyGvrx69ew+hKodbV2k4p4NIHGeaOHt5Y9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5885

On 16.04.25 20:26, C Smith wrote:
> I am having a problem with select() in a Xenomai RT Task. A valid file
> descriptor is associated with the serial device but select() thinks
> the fd is invalid. A snippet of the code is shown below:
> 
> struct rtser_config Serial::serial_config = {
>     .config_mask = 0xFFFF,
>     .baud_rate = 115200,
>     .parity = RTSER_NO_PARITY,
>     .data_bits = RTSER_8_BITS,
>     .stop_bits = RTSER_1_STOPB,
>     .handshake = RTSER_NO_HAND,
>     .fifo_depth = RTSER_FIFO_DEPTH_8,
>     .reserved = 0,
>     .rx_timeout = 250000,
>     .tx_timeout = RTSER_DEF_TIMEOUT,
>     .event_timeout = RTSER_TIMEOUT_NONE,
>     .timestamp_history = RTSER_RX_TIMESTAMP_HISTORY,
>     .event_mask = RTSER_EVENT_RXPEND,
>     .rs485 = 0 };
> 
> int rtser0_fd = open("/dev/rtdm/rtser0", O_RDONLY);
> ioctl(rtser0_fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
> fd_set read_fds;
> FD_ZERO(&read_fds);
> FD_SET(rtser0_fd, &read_fds);
> struct timeval timeout;
> timeout.tv_sec = 0;
> timeout.tv_usec = 250;
> 
> int ret = select(rtser0_fd + 1, &read_fds, NULL, NULL, &timeout);
> 
> The expectation is that select() will unblock once data is received,
> with no errors. However, select returns -1 and an errno is set to
> -EBADF.
> My app prints the strerr() below:
> [ERROR] 10.746 ms IO Thread Select Error: Bad file descriptor
> 
> To verify that the file descriptor is valid, immediately after the
> select() call, a read() is performed and valid bytes are returned OK.
> Why is select returning -1 and setting errno to -EBADF when my file
> descriptor is valid?

Did you double-check if the cobalt select syscall is actually issued?
Maybe there is some wrapping problem.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
