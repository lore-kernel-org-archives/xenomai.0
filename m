Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7920E023
	for <xenomai@lists.linux.dev>; Wed, 25 Jun 2025 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839382; cv=fail; b=cFR0nfC3/O98nZKVjXjvfUNPJRcvCOkzyJ+NLgL7E8blozquweKK5KjGXHv2GfJrSMQbDkD5cUVcjcnrwpR9G0ssXYgqmI8gI622tLHGL0KQYCsSjAtde9Zkk6bxX5iooG1U/D0vNbEzVLJ2VR5vJSNjfXm4sZpOVPzDaP1oRsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839382; c=relaxed/simple;
	bh=zEtTCQ89rdGG9qbc2/1PcimHp2DyjctXLvwnqqaMlFM=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=ZyYibTq080Iu70VvyrhCQoaxk69i8HU6JTKYtOp9ZjULRIFzLy2H1lNNIJL+eE8JNW9sstn4pLRVUqvKzL66sxVrXyabM2opq2nTrMZelaWJDE+8r/zXFpk4fjsWUbu62gvtEgBnGZbB/PwnBgjjFVDQd4K8aoiWx6o9EEZEMeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EiWDyMyx; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EiWDyMyx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYie8s7wCfnJ5Fl3nZvyXMe2T3dPNRGOBy8AV6i4liMzpdfRVevmlC3q0GZXoZalD1wMtB2z3aY5lGVwnlVwE9LLAQuAJ19vgH1S3OoYGg1nCOMMPKrg80yamidt6Zz+tFdptC3SgrQm8up9f7iWpd1VYiNxnQ2sSngjeHhJoE6DEACPgziahHyS/FwNaNEy5vTQhwx4wWnL6KOqrDg0/f62ZZBBiR9UbqyZgsMMXM+wx2BlQtLHCrIfD/eShr5JlfDvGiJJirSrUSzlRziifhC78qtxwuumy+QKkIDC1G4NQcQ+uBYQCA8AAaK/ABW6Qq6LYfpvTBRzPdGn02LTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU+GndfLONNW+XQeV6FouBxGEm+nqyMhC1JP+k3UEW0=;
 b=Kr4L23u7tCboH/KPTnmBByi+yTfmvyn8nuCHeGqnsQNQsKkM4OGuEGCVGL/aTRmw+aWxGVmCsGps3Rs6XU4dXy0CnIvFI1e06yw4/sGXWIslBNSCSby8xL4EmnfKXzJak2SpwAAcuAJk9ydLj69qeges0uax1u5/QEqF9mcMUTIutpo6kQFtbeU/8B6IZXXyPMSh8Pe20KnQS3tvpSMGAyYCYL/NrTkpSPiZB098A5gg9fpDhO/40adthoR8QbzFXyyobnd7H3z2Jcr24IgJOf3JMRH3Qfu0/Jo8rvs96jf6nlczlam9vSzlu35VB01V6YctIrr1ZMkbwHUC9CO0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU+GndfLONNW+XQeV6FouBxGEm+nqyMhC1JP+k3UEW0=;
 b=EiWDyMyxFJaqyCUE6h9tCsGdM11zB3OfYOP53ZDCPhht2aOpb+JAyDEIZcSh4uxriQTX8cm7tme0NxY7pP9B4GgKnKT5yz+tsQLdf5IyVeKffFluYIRGtERU9bN2248klrBoBniDvhY80V/i15C7FXpz5aSiK6UqnmlWby4jYJS7ehF8hMajMHYArNjCgs7EH632zGQYKZnwl4SjZyXIyFgFdzgLZmhLLnew3eMPp/8ICwO3nsJiG5BpFJPJZ78vl0RjzKwo/3xp5SPXC7JaARiyCigHAv1WfY7zms18vtE+CcTxM+F3uvFf47+lmTk2DjsQ70YfGy3CbbqiQbSLcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 08:16:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 08:16:15 +0000
Message-ID: <3cf01441-93e6-4004-a9e5-5183eb6740de@siemens.com>
Date: Wed, 25 Jun 2025 10:16:13 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: dovetail: Use appropriate EOI on error interrupts
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0333.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3562:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c27843c-8b5e-4714-6b8c-08ddb3c08da6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VldxS0swUFdURExpWmhGZEJ6OWxaL2NKdU9RWGR2eDZQWjBjZUdjYjNGcCs1?=
 =?utf-8?B?NFk3K3hnUlM2cVhyNUFqQVhUcVhqYzNDMVBOUVdvRW5WSThZS0VhcVJLYU9H?=
 =?utf-8?B?cmlQRDhmVm9Cb2ZEdkRqUUlFUmpZNDdRdlZvZm4ycXhpSWxVWVh1bHQ2WlJt?=
 =?utf-8?B?TkJQTyszckpHeXAvd05Kcmc2d3IyMlF0UDgxUHNKRFY2cHIyL1JuY0ZXRnZr?=
 =?utf-8?B?NnlEeStMS2ZMaEg2OTQxVTJpc1EwZ3hoaVZTL0Iva1Mzc0RjNW5BY0VUemJZ?=
 =?utf-8?B?aDZwM1kwOWQ4RFpyWXMwWnJoOXF6RFBCdnlUMjFRNm81eWc5MGRjdDJLSzJx?=
 =?utf-8?B?U2F3cmVRajkzV09DSXBnM0ZMLzFFMVViTlBPL0NUWHplV002ZFVOVGUvQ25v?=
 =?utf-8?B?cjB4Rmg0TTNhSDk2VlJ6U3I1d3d6Zkt3d05vTkZRWHRIc3EwdldTeVFNdGRi?=
 =?utf-8?B?Yk1CcWhKaXNoSnFlWjgwenQ3c0pBZk1mVXRXN3BqQTVRcjBtQlgxVHFHdGlQ?=
 =?utf-8?B?KzFzWnVrVEdhZ3ZCMGJZOTRnTWkwdkNyelhpU01WZWd1TERwNmJoOS84bUpD?=
 =?utf-8?B?RElzNnVpUGR5QllGR0QwRXQ1ZFZ6cUx1V1lxMlFwOUhCLzJ3alk4bmU2WDdP?=
 =?utf-8?B?T2ppRzNMZWpsbzRrK2E1M3lNOEFZS0VrUVBOTEFsc0trRVRUdEg5VlFRYkhr?=
 =?utf-8?B?bkRzTmlYMFRwWWMvOXRkVFYvR0FxcWUzdm8ycEQ0QmtXY1RJVHhTaGFyQW9i?=
 =?utf-8?B?RDlKcnVKUG00ODN1bHA1UHdCWEhKZkU3WHFuL2ZhMVpnaVZtT3o4dWR1bERP?=
 =?utf-8?B?ak5KOFgwUjB0TUhEaG8yVkdGL2tWY3ZFY1VUR0xWMzRJbUVKcXhlV01XT3V0?=
 =?utf-8?B?ZUtlQkVNUVFBMCtlUmZHUWhFaUdWMWNTNVZta1FRd1dHSmM1Y25CK2ZzamlK?=
 =?utf-8?B?NmpKUHBSQmJaNGNFV0xlWDVPVWthQVJCSXo1V3VkZ0pQMkZYZlhrT1RuQmRW?=
 =?utf-8?B?VWRVeDFzTWxTZVMxNDFpZnBTMERta0xPQVJXYTAwckV4UUxuQS92ZEZzUEIx?=
 =?utf-8?B?c2puM3ZndDFGcE9CdERXQ1lIamE0ZkRHeU8wQ0Z3aGVCUW9zMW95TG5NeEdr?=
 =?utf-8?B?b08wT2Y3eDMzRGpaNG51aitlUVRRcWpiOEVpS0o2QzBsT0I1OUpCcHROV2pL?=
 =?utf-8?B?MnMwRmVtMWEzNlFEem41QjdSeDlOTDNpdGRlRHdDVVNBU3Q5NTl1V2RHMGNx?=
 =?utf-8?B?UlpSWGIyZGdpSTdRZTliZmpoU0c5VEpyNDlVNDNodHE5aUdiUU5waWwzQyta?=
 =?utf-8?B?ZTZ2QVowajRuUmRiWVRudkxUZUxNN0ZpM2s3WWczVlZmRlRpWUJyMW16TVpW?=
 =?utf-8?B?SHppc055Ynoza3d2MkR4SDl2c1MxTnlBT1U4dU5BNjFCajZENDMxR2l4ODNK?=
 =?utf-8?B?TDRHL0lnUWN5M3laSCtiNDZLanE5UHhEZlJqRmlURjVXdk1kSExIekc1a1Ri?=
 =?utf-8?B?NTh5ZUxNRm40YUZIMlY4ZVFJUlYrb1NRT3Jtd0h0Um1mM1p4eW1pZFpjbTd2?=
 =?utf-8?B?QlR3VE5lYitiL2hyUVRobVZKV0ZhbmtJM1NycDBHY2VFOVROcEUyU25CNHFj?=
 =?utf-8?B?OFFZK2pvUEQzQUVtK0VrSjN0NGxnOGJQNGRGQ3hxbitac2xGNHFHT3Y4bFg5?=
 =?utf-8?B?aTAxa09EdGhVazc4a1dxczZGZWdvaXBnQW5CTlBTbVM3NkFPMk00KzUwa2xl?=
 =?utf-8?B?UW0xaVVZbFhmU0xvUUtCZmt0d2F1QXVleU9IVTNtZXJwZHZnUmZLa2tkZ2tN?=
 =?utf-8?B?eWk0alBsL1o4Y1k0dmRlQzVQZWlGekNLT0RwdW92bkE3THBDVGlSNjlGd1VL?=
 =?utf-8?B?SFo0dTJmTzJvdFFNYWVpZWhTQlozY05JWmlSemVpL1kxOWE4SnVwVGhVU3hr?=
 =?utf-8?Q?80rfxxE1YpI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzdUUkxjZzMyanc3Sk03TEdWK3phVE41MGoya3B4ZS90TU5SNnl0SUlmNGNB?=
 =?utf-8?B?Z25QUmYxR0JFZnFIeXJrbVU3SXJySmU2bHFVUXRud3lmNDQxdURmc2ZGTGF2?=
 =?utf-8?B?K0p4d241WUxYWjV2NTBiN2dkQlJkNU1oczgrejYrMkxKaTFJZ3ZhbUJPZzhL?=
 =?utf-8?B?RCtOZ1dBeWNnK2s4QnNXclp2VFFvYzNTTHdvUGlSTm9GN2lWRm00RlltNC9X?=
 =?utf-8?B?VUtSUmtoSjNsbjlIU2dLaFQ2empQc2gxNjBYRXVPT0t1Y3J2VEIwclRUTjJG?=
 =?utf-8?B?WkpPY0NIeUtiUUFNNng3K1pTY1RyUWMyK0FaZFRMaVJBSkduOUJlSm1HRlZv?=
 =?utf-8?B?UmNZZXducUMwQ3c4U0lGcVpYTzd2N056Rys2clZ1YjRBaStFcmUxVVdJY1RH?=
 =?utf-8?B?bjNJblZTU1c1L3pjdkRwdXFraTVVaGU3aWh5bXYvZ1lQNHhXWTdXOVZkYmYv?=
 =?utf-8?B?Q2pqZytxNDJlL2FnTDE2RlF2b2ZXTmRXZWVVODNqVmVKczdLZ1h1UmQwMWJz?=
 =?utf-8?B?UWd0TW1MemlVVG1FeHJkMEJLdk1PZTFSZ05aK2NPM1hrZGV2ekw5WjBWR1N0?=
 =?utf-8?B?T0NaYmd1NGs5TGN6ZE9tTCtPR3l3ZHQxSEJCVXFyREl1MDRwNktSeTFkS3VE?=
 =?utf-8?B?elFLQ3QrRkYrcDhOdStlb0t1WTVPeVBCQVFDRXFhWnNLOHhPbmVzTkxEckNy?=
 =?utf-8?B?WnZzWHNqY2ZsT05QVTlHMW9tclk3SWxoZHhSTTJoMDE2VnRkNmtpSUhwYnJQ?=
 =?utf-8?B?WXd0dDlNMS9ub2V6UGtlUDFUV2VwNFNYVWMweEd3RGR1aXA5cytFV0txNUVJ?=
 =?utf-8?B?UFUvT3gzU1Z4aVpxQTQxWTB0Z1ZPdkVaV1h3aDlhZ2QyNmF3dWhqZEJ5TDZN?=
 =?utf-8?B?NXUxTEpOUXgzRzZaSHVYQTViRlVDbXAzZmFFTTgzMWFzZVVDNEtUK043Sng0?=
 =?utf-8?B?aHphWmIxSlJGa0hQaXJGK1Q1bysyZEVXRHRLZHJsemkrem0xUDFOV0ZuZHBh?=
 =?utf-8?B?N0VGZHpCblF5cXdUT1ZBa3hYTzQrYmkxc0lKNmNtbVVxTUtiU3pDckJHb3Zi?=
 =?utf-8?B?aUlxbUhrMEJVekZRblhwaDQ1QmdGU1BXOVNpUGNERFRsbTJLK0VRUTY5ejJa?=
 =?utf-8?B?cWNSaU45TUk1dHNUdWJaYVhTQmI0U1pJTS83a043RXBWNHdyZUo3MU9veVJa?=
 =?utf-8?B?MWowckUwb25lUFliMUN4a0hNR3ZGOHYrRlVkY3lNTncyOVZWeGVCMmRRWDRI?=
 =?utf-8?B?VlpYUlFWeWY5cEljcmdFVFA4WEtxVm9iOWcyMmxJSmdoMEpvMjlpb2luZCtj?=
 =?utf-8?B?d2UwV1NNdzR1MlFnK2MrZlJ2V3FrTUt4UXQ0aHVTdXJOSERtZjJ5TWpJYVR5?=
 =?utf-8?B?MHpaWFFOMWJRWXZRV2syV0tpZXVBbDk0QVlQaDVINnRwNXRtY3dUTHJ2ektT?=
 =?utf-8?B?RXNEOHNJb2FIdW1kMm5SVS9YWklqNlNsdjh4TFNLN010bXRBMzc3REl4R05E?=
 =?utf-8?B?Q0tPODY1TDRCZU1sa0hUVjY2WEhZNXN1bVJ2TUNkbEhyanJRNGFyMWRDUExi?=
 =?utf-8?B?aFdUU1JRdGtpcXgzQ0ZGb2ZxemxKcGRTdFM0eHJnSDJUM3lpZHpOS0tjYnl4?=
 =?utf-8?B?empwaDJpMkJabzdDYnZHTG9xK0lMS3BOV2c4QmZBaTVUMlYwVldmeHkwV25r?=
 =?utf-8?B?ZHhJUnNYOGVxSUZaZlFnM3JKWk9aOGQzWU8vNEdNQ2wwalE3d1l6OGYwSmdn?=
 =?utf-8?B?Z2Jpait6azVvNVorOUVWOFMwRjJrd0FiWlhTeXlWV1VNMFZLMEZmWXkyUk5h?=
 =?utf-8?B?YkNad0R5dkdCLzFxazJqSS9ZNGFibFdrM0pFYVdKWDJpU3hVS2hrTG0yOVB5?=
 =?utf-8?B?dGl3NjBFZWV4TmtKdjlyckdVMW41REFLaEdnSkVxMm1WU2Z5WDFiTG9BKzRh?=
 =?utf-8?B?YklpV0FqRkxDR3pUYWF6bkRiN21GUGFWNTE0ZVZmZnhyRDBNNWNtbVBuYmlM?=
 =?utf-8?B?dlNuU2QyWHdGZWg0ZmpHejNaNG9RMGllbDY0NkhKS3RvRU9nSjdNN25jY0d5?=
 =?utf-8?B?QkJZWFVDTVVrcXZhM2FLMG9vemt4YnFJU2ZWWnNaZzZDVVYwVDBGUUpnWHNh?=
 =?utf-8?B?QkdJZ3BMUVFEVzVxRmxhQjVyZzVHTjF5QWZUenJVOTZEK3BoUUswSU0rOS9h?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c27843c-8b5e-4714-6b8c-08ddb3c08da6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 08:16:15.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2lUsCJnaCa6COd6QEHudbx6LsS8J+Qnyep2lLgPm4L2G7RHqugpX75vhYgNtehh5wj1CGe3+aRNzO3kA+MRiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3562

From: Jan Kiszka <jan.kiszka@siemens.com>

Just like for the non-pipelined spurious interrupt, we need to invoke
the non-pipelined __apic_eoi while handling error interrupts. Otherwise,
the local APIC will stop receiving further interrupts, and the system
will stall.

Given that it takes very special conditions to actually trigger an error
interrupt, this issue was very likely not relevant for most deployments.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 1cd5f59f7962f..278e28c5290d3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2217,7 +2217,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
 	if (lapic_get_maxlvt() > 3)	/* Due to the Pentium erratum 3AP. */
 		apic_write(APIC_ESR, 0);
 	v = apic_read(APIC_ESR);
-	apic_eoi();
+	__apic_eoi();
 	atomic_inc(&irq_err_count);
 
 	apic_pr_debug("APIC error on CPU%d: %02x", smp_processor_id(), v);
-- 
2.43.0
