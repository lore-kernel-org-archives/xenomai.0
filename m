Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE817C7F
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903572; cv=fail; b=XWYUW7Cw3xmAWkUdkkmaqsH8TQtA1i1Lby4Big9ZYPt3hyGt4Y7ICLZF4TbGzqT8J5NvPTJt46zhmhBWqmonrVPT+To3Q/HcgfkcpPrFMNsg+ksOMGh5Gfz+c8WtHw4gv/j30KlcIx9enXb6SIIX/XiOInvqLWaGzBzqvwE3LPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903572; c=relaxed/simple;
	bh=aiYx+68BewI/8DqghbJUQdj36s0w29jkw8Spu7UD4HE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a8Wxc+3JftrihLqf+dm3HgrfWz4dYwRuY0uCIHUwZEUcCEFz65kF8ireYsCAXxDyVAS7UllFj5yq3aWfgP48UGP2+zL+DD47tGGC7UOTiC0NlxLSSzqW3wZISxqz66qhOefw6OwTG4iIoFrQ6Ck1n3rV7o7SIGoKrPyAk2WSTo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fpLmnh5a; arc=fail smtp.client-ip=40.107.7.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fpLmnh5a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4hJIx4R/qch3GrQzRK5884cvW6u3mKzk5yaSBqHVXvBP5JpnEotoBJfM9erKWOoNasf/NvwZ75VhgJtBR0SiXOBQMu5eotvrFw8mp8mDPRcjkGlaxXjY03yb6+LI+3B3DI3Wo2dWntCaVkm7ylUGE0W8RMOtZ8m8+MPoMlgi//sVl6oJ2FpRw86MLAJ/XKrzLkXy6qXAMluNQd3Mc9qFhnVyYYoTjMAaHPtbcPJebPhqvJJk1OX2Rb3jokru12+BgpVFZHSXN1tvj2joTA0yvaMfDUuW1dv6uhc5gMXytm/exdLjH/ICBTc+7HGCL0BNuYcVyBdLHnzqdQF75kQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ61sndMxEHBtSQWqv98R6NOEqBJV6ynQDl6yz6npZY=;
 b=E+Rm88qDotOMq3iUCZCMVe2X7yYKxS7CNCdN85DZNMzlihIzM6byAnQcgiJounMmkDXmgwM+QH7NWUXh50wgeD6ZSe/zVu5OAwflsazIl9JUY2HsxSDGDCgJVmQcpH/VmGFd/vQF02dUA3PQ91feLP3jly7dEd+zcsx1dNesi2jgG+FajvOOJ+2C22/LIs2uVN2WzxW0kUTCVtDjkN4pgpOoI97dBY3YvF75knLZCEtpKSzCpM/zHtdkOkH4E0dJmnHp628ht9KCfjveIXDbgWX0VPQfCII4sS06Fc/Hrt0E96kCFDnXNuLq31sy1HInRnam6I6OCSazbBhHAjvYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ61sndMxEHBtSQWqv98R6NOEqBJV6ynQDl6yz6npZY=;
 b=fpLmnh5ac1mZQvIYvW9X7ZlgbHxE+GCQNecqtuBb/yIyoJaeEup5vy2Kg957h5oqQ3JHQjJ4LOKKwe/zx40WGiaCaTjFG+wZlVBUSvgy9g6hB6eYWQoJRbK/f8VoH3LZHi/fqH+QF0SePhoyaTlFaG4zufg9hEqvKypfyH1CYLUMsJRr8ICer9pXDEsmn7KR831CBjOMqoBPP5/HGU1k3D6zeIJzKbzYYPNEqomItZtVvgjk85rNXy5tZlNqemxxX3ty4pl5E/BKBcYhuvtLPYOreu/qUafGww2bTt1aXotgA3DvcjRBqsfWRti3qfdpX5AcCVsTk35EEeITsvwkDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3861.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 13:39:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 13:39:26 +0000
Message-ID: <e6aecc5a-4acb-4460-aedd-d77e8ecc8723@siemens.com>
Date: Tue, 28 May 2024 15:39:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] xnthread_set_periodic: Improve period adjusting
 support
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
 <20240528070432.6669-2-david.oberhollenzer@sigma-star.at>
 <b22f524c-f1b3-4981-bb67-6f936b14e507@siemens.com>
 <fc1d19dc-49a5-4b66-91af-38889c8f32b4@siemens.com>
 <5472aa3d-6245-4bb8-afbf-ae4d702e7d29@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <5472aa3d-6245-4bb8-afbf-ae4d702e7d29@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:610:4e::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3861:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b833fb-204a-479b-9a56-08dc7f1b97ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVdocFBhcDQvaTBUSlFVNmNLTHdSSFFXemVoNm5WUXNmWHgrd2hKa2pRT1Zp?=
 =?utf-8?B?RDcxYUpPNFQ1Um1zRmYwU0p3QTRtTGdUazl6R21lS3RpRytYc2lIc3lWM2Jl?=
 =?utf-8?B?OThLYWR2b1BHRXlkVHJzK1hNWnFVa2dEcmZoM3NCNVhHeFFzYk1vTFNsZm8y?=
 =?utf-8?B?S1lrTTF3OGxBQ2pFUXlYTjlaaUVDKzlHaGtRb0FrUS9OR01RODZ0NkpkdnZl?=
 =?utf-8?B?a0doQ1p6WlhvQlovQU5FNDNMeXhWSVBBMmNaUFZFMmhDSVI2WGlnMW1Fa2Fa?=
 =?utf-8?B?czR2MnppNCt6MEZTVFF4bElVN3dyVU5HRjc3dmQ1NGtoclNMMEUwUDZnbXdX?=
 =?utf-8?B?RmRrUlBDSW0zS0loejdSVVYzY0RLU3RIdWN3TU1kRjZWY1BuTnRyMFlVSWc4?=
 =?utf-8?B?VXNaTzY4bGVWVmFGYWUvMmlJRk9TeXphVit0TEFVU2hLeVVEcUxSaExGUjFL?=
 =?utf-8?B?YjkwYU9nUVR3NkpYd0ZSYk1KeElBdXJlcFNKLzJZRHY2OG5DZGNwQnpmbndx?=
 =?utf-8?B?c1lGa0dLcnZHWGxMazlTZU8rZWZhZHU1UVZXSE12ZjI2eU5NeTByTmJUZ1F0?=
 =?utf-8?B?WU5IUC9YRXJmbVVtWlk5VkZ4TnY5QVZvMWVBcGl4R0pubnRXaUNlNnYxTjVh?=
 =?utf-8?B?QmpYZXVPLzJGbnZ6WUtBc1BhQ28rTDNTbFFEWlhDMzV0cnBmdy9OZVl1VlVX?=
 =?utf-8?B?VmNKYmRROWphNW5YTDU0ZjlQb1RqUWZrRG1wcUJZcnhYOWFYSmRSSWlwYmVY?=
 =?utf-8?B?VkMxeEptdnRVeVJONXgyQm1VeVUxT3VQTnNLNTU2R1hoQ1hqaHBwaHNCUSs4?=
 =?utf-8?B?TlQvbFB2WTVkdFlHZXIxZ0FhM2xMSTNOem5JM29OaG4yVko5S1dMc3RRSWFw?=
 =?utf-8?B?TU9sbEdIZTRpZG5CalE2ZS9CZ042aXVSeWZEekcvak5wbVdzd2IrUWpEektv?=
 =?utf-8?B?TGpjZzJxa3pEWUFzY3J2Vk94aGpIWWk4RThsVlpEQmdzNW90ZTEwd0thSEFX?=
 =?utf-8?B?aWFyaVE2OUJUblFrRHd5RnRYMkQxQUxMelY1SklLb0VIVTZ1aUZXdnRLZlBx?=
 =?utf-8?B?UkZTazBib1V0YzM0SUJwNFFubmVvZkFkZ3FkMmE0UnpZR1ZOYzc3aURjWU05?=
 =?utf-8?B?OHl6N3N2TmFpcWF4bHdiaXh6ZFFHejBIb08rTmxHWkRqSGNickFHRVBMSEJC?=
 =?utf-8?B?UmtMeWNrakxXdHltSWwrclZ4UkhXam1GajN5WnBKRGFxZW5tckROMmVpajg3?=
 =?utf-8?B?dWpvcktRRzBIRW8yTUJEWEFTVnlzUENwRzl0UE5IWnBJZG9lQWpKSzYyOFpO?=
 =?utf-8?B?eEVYLzdNTzR1V0J0SXBMMWk2OURNR1RaRzBncEtoeWFVNHFjei9VVEM0ekhs?=
 =?utf-8?B?dGpvVUtJQTcwdjlqRDBNYkxIS0hBdDZCNXdsZ2dHcmk3Z0FabmxKVjNSSEtz?=
 =?utf-8?B?Z0FQZUxTcHJqcWhKNEljWGQ3T3JKRTdONkl5TGRrRmUyOThZTEh0WE9BQUo1?=
 =?utf-8?B?STlkckIySHk1aHBZL2VZdkV4emhCcTJ4aFBUMnU1NVg3clloNEg3c3NQbTB5?=
 =?utf-8?B?cWtGTDJsWEU5VklSQlZBWWM5UTFlQ29EQmJWOHpoaS9TQkRIeUhnVlBVd2Fu?=
 =?utf-8?B?T25JZFhqL3lPMTd2OG1JSkdBSnVxMnVqYWFWVVArTXRVZHNRZmNzdlhLdFZC?=
 =?utf-8?B?VVREWWtOOXhNTnZGRWdESEEvczU5NWsvcjB1ZUdZazJVK2N4ay9CZTlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1JxUGtLWXNjQTIxcWVZWmY1cmpFUUhTNU9CM3BWbTI4dUxqbHp6N0ZpMDhL?=
 =?utf-8?B?QkVOd1RwekNEUEt2NWp2UGQ2UUZ4c3NUTGUrSXhYYUZJN2ZzT1pLdFNTV1B2?=
 =?utf-8?B?eDNQR2pjSXpkWHhHQ0dFazAwdDhtbDdkMHF4UGpKeXJGWkNpV1YrTUYwZmIx?=
 =?utf-8?B?cmQzSWxIRTdtMUNRaHRWZjZ4QUtiRXZUUDNmb0RnTWltcW1ZQjVtdWF4cXFu?=
 =?utf-8?B?ZDRhKzZFdUpYSDdHQUFqUXFGejZNT2N5d2JkNkhkQWlRcmdZeEo1VTRmbnZQ?=
 =?utf-8?B?UnhqTHR3TkRuVUkvRVJ5dG0xdk9mVElnQTU5bkpVNHhKTUN5UWNjdERVTE5M?=
 =?utf-8?B?Q0d2ZjhWRHBSN2tjUHFsb050TkNhYUlkWk1JbjllS1ZGNTZiRnZRRytWYW1L?=
 =?utf-8?B?em5rU0piZVVNRHl2N1l6ZkNjTFBrTFFpZ2kyT1JpbDZpUHBiK3pLakxEOE1v?=
 =?utf-8?B?eFp0bGtBSnplaUZQcUFGaklwT0JHcDU1dVhxRDVoRnNLck4wbXhxU1lVZUhK?=
 =?utf-8?B?YWQybGVKSTY1R3pacHFJT0xPOWtKVEZqM1FOR1pvOUpBQzVGNWNiTG1lbyts?=
 =?utf-8?B?Qy9PWmpFWXQ5cHJWajdWNUppZitoVzNtTVgyS0RlN0xCUGNhUHc3WVBBbThZ?=
 =?utf-8?B?b2RPNHVZbVdMZ2x1ZXUwTDFIc2pFMnNSTm5LZXB5ZUV0TUhXUnRJTEpQRkZ4?=
 =?utf-8?B?SzhxUExkSnJVYzl1SkNPVzVUMlU4MEJMbm1UUGk0cTNhMjVUa1pXZm8reTRS?=
 =?utf-8?B?d094QmhBK0NtMWphcitxdEdZeVdYWEY1dDIwWWZRMGQ3MFlBZ3p0MGt5L3Fm?=
 =?utf-8?B?Q3ZMZ3RkSTUwd0tDcWpBdkZhWmRsZm5aYlpURWQvU3RzSy9oSDI5dVdZQ1dI?=
 =?utf-8?B?a3NTZDdiS3NFRkFGZDNURHZDNFlSeDEvb3hvZDljRUlHdWx0a2FwbGppQjNF?=
 =?utf-8?B?amN1b29qRXlJNlB1MkF0MHBmanJsUG9pWXA1T2J3Z0xVR0dHQ1k4d1l5Mm1Q?=
 =?utf-8?B?TlU3T0kvMVNvS2pmV2R3TTlIMk81d2p3R2RpZVN0N1pHTkRYNEFRcnVtWExQ?=
 =?utf-8?B?MFoxdFJkbHdVWmVCSjFOZkUyNEJlOEttR1VzWm92RERNaTc0WW5NZFI1QWQ2?=
 =?utf-8?B?QTkzL3NkWE5QaEtXTUNaaHVIUG90NnM5YVlaak9NS0ZTYjFWa1pWaUJ2eUlO?=
 =?utf-8?B?eTJzM2tZYkNKT0tTNm80RmpoaWtkZ3NpaGQvS1NadDdSbkFSZ0pucngrTW83?=
 =?utf-8?B?VG9hTW15cm5CUWsrTXpRdlRiaHhQZ2o0ZHR6ZW95SjlORVBzR2M0b1MrbHFC?=
 =?utf-8?B?TzcyOU5XeHZTSnZmUWpsd3lkakQxK3M2dUNLRjZJdU9OUUtvelhuU2V0MFVG?=
 =?utf-8?B?T3RzUExrUTFTbUVaVVYvS1VVVlpEZXFwczkzK3pRaHVTbmYxREZuaURuazhW?=
 =?utf-8?B?MS9ZM3JBdU9ZclBMQkx5MEhwemZOdWY0TFBOa2lXSnJLc2NSVlFFMGFrdCtj?=
 =?utf-8?B?U1ZrcUhyVFJPT0ZZQXcyQ3Nmclo5QkRVMldHOExBdVpDRUZXR2UzdHlYMFls?=
 =?utf-8?B?eEJBT1EzdFZQZHFFdWFta3FJUDROZ2hrd1Z5Ti9OdW05aGpjNGF4NVUzQnJm?=
 =?utf-8?B?bHdoQytxb25hZ0VDNFIwaFp5MmJTS0YyMHZzd2tacTliK01iblNqbFNvbVJl?=
 =?utf-8?B?ck5xWllMRC9KWHV0Sm5MMXlWV21IcGM5VTJNL1ZkMVZUb1VWOGhjcHlnc1lR?=
 =?utf-8?B?U2FYS3FJVUZCeGtqaXlXWXpSQ1VqcFBiMVUvb0Q0eHFHWExEcHlmLytsNWFx?=
 =?utf-8?B?RW5wVktMb0JxaVVHRFlnM0dKY0VMTXVqbWVrbTFUaUpOWjhKbkxvWGJVc0t6?=
 =?utf-8?B?QmFWYjZIR1JNU1MrbFRjdGdjelEwNDFmWCtsYXhOQ0tZMFBNa2s2eG1XdEhi?=
 =?utf-8?B?Q1VmNk95Mk01SHpXVEZrRVdoeWNVNzJFMjB4dTBNQzJkaDlYR08wdjFqZFVu?=
 =?utf-8?B?b2k0dVoxSml1SGplenplTlhxb3NpVlZBT2t6c2VVUmxNNkFaQnQyZm0zUkJt?=
 =?utf-8?B?SkFuMmNVUGo4eEFGS2VmOUR6Zk8wVzlPVmxLK2VKdFBESUpjSkJUZGdqY2hO?=
 =?utf-8?B?RUNYSG5ad3NUVTN6M2hRVGNZd2M4VG9ORTBVU1dYUG9TVGh5V0hRZG85Z3gr?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b833fb-204a-479b-9a56-08dc7f1b97ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 13:39:26.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehPtPlu4UMBtt7xpjC1sWJlFn/ivtCq+7l5c6oN6r/TVtDzopgq2Q2I1+Km2heX8WOKc+v8PsFEHPbTSQYLR6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3861

On 28.05.24 13:58, David Oberhollenzer wrote:
> Hi,
> 
> On 5/28/24 11:38, Jan Kiszka wrote:
>> On 28.05.24 11:34, Jan Kiszka wrote:
>>> On 28.05.24 09:01, David Oberhollenzer wrote:
>>>> Currently, when a periodic task invokes xnthread_set_periodic()
>>>> multiple
>>>> times, the timer is reset each time. Consequently, the period drifts
>>>> because the elapsed time is not taken into consideration.
>>>>
>>>> To improve the situation, this patch alters the behavior when idate
>>>> is XN_INFINITE, to keep the current timeout value and alter the period
>>>> only after the current period expires.
>>>>
>>>> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
>>>> ---
>>>>   kernel/cobalt/thread.c | 18 ++++++++++++------
>>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>>>> index cf3b4dbb0..de97b7e70 100644
>>>> --- a/kernel/cobalt/thread.c
>>>> +++ b/kernel/cobalt/thread.c
>>>> @@ -1273,9 +1273,10 @@ EXPORT_SYMBOL_GPL(xnthread_unblock);
>>>>    * point, expressed in nanoseconds. The affected thread will be
>>>>    * delayed by the first call to xnthread_wait_period() until this
>>>>    * point is reached. If @a idate is equal to XN_INFINITE, the first
>>>> - * release point is set to @a period nanoseconds after the current
>>>> - * date. In the latter case, @a timeout_mode is not considered and can
>>>> - * have any valid value.
>>>> + * release point is set to the end of the current period, or to
>>>> + * @a period nanoseconds after the current date, if thread was not
>>>> + * periodic before. For XN_INFINITE, @a timeout_mode is not considered
>>>> + * and can have any valid value.
>>>>    *
>>>>    * @param timeout_mode The mode of the @a idate parameter. It can
>>>>    * either be set to XN_ABSOLUTE or XN_REALTIME with @a idate
>>>> different
>>>> @@ -1336,9 +1337,14 @@ int xnthread_set_periodic(struct xnthread
>>>> *thread, xnticks_t idate,
>>>>         xntimer_set_affinity(&thread->ptimer, thread->sched);
>>>>   -    if (idate == XN_INFINITE)
>>>> -        xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
>>>> -    else {
>>>> +    if (idate == XN_INFINITE) {
>>>> +        xnticks_t start = period;
>>>> +
>>>> +        if (xntimer_running_p(&thread->ptimer))
>>>> +            start = __xntimer_get_timeout(&thread->ptimer);
>>>> +
>>>> +        xntimer_start(&thread->ptimer, start, period, XN_RELATIVE);
>>>
>>> Doesn't that mean that we skip over the next tick and fire only after
>>> that one + the new period?
>>>
>>> | ........|...........|.................|
>>> last      now         next              actual
>>> tick                  old tick          next tick
>>>                        (start)           (start+period)
>>>
> 
> According to the documentation of xntimer_start(), the `value` argument
> specifies
> the first time the timer fires ("The date of the initial timer shot").
> Then, the
> interval would be used after that ("used for reprogramming the next
> timer shot")?
> 
> So, to my understanding of the documentation, the timer should first fire
> at "old tick", and then apply the new period?
> 
> At least that is the intention here, complete the current period with
> the current
> interval value, then switch over to the new one.
> 

You are right - but then "start" is a suboptimal variable name here
because it suggests that this is where the timer starts, not where it
fires first.

>>
>> And you also need to update the documentation of rtdm_task_set_period,
>> no?
>>
> 
> Ah, yes, I must have missed the mention of that case in MIGRATION.adoc
> 

Richard even wrote that rtdm was at least in the past to only use case
of this API change for you. Good to see the alchemy extension now as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

