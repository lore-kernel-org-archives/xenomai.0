Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50C41C63
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765782137; cv=fail; b=DMBlFQmzfKall1gIGyg6eJLAJtT8YYqMipQtarJ1DWGG3cqjWWy6/II9Ep7yPEOJfKE/lMh+Nf9w5wv2VKXTI5k79CFo6HjpKWDrFZg6wlqEWGWtCkiXQwdRIsUPrKZCONBUGaQ6+GpuV0EWWajfQbSmqTMAjfPEj1l6d5RR30k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765782137; c=relaxed/simple;
	bh=7vMVPuzEkPIQ4Uvq3N3NVZhBeU5pvo0Ndz98PCPhjUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=owLFhvKE33AwTu6UQlZvd8UxI15RRTYC5d7VD5nHRfIJIfHQXOAar/S9+oUistCcVRygXg77+ZBUGEJbV+jD1GxWyfTG+3tSUUqRG/NuzgMZKzKmOt/MqLb20vH/sAF8oqA1Yf2tnHFN7UOochmBl5VQx4XI8ve/kqFoTViZY10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U8BFYwkC; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U8BFYwkC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqshiVMlAgSuvuURmNx0eNIBR/lZIT5Z5gTDSxSF2vPHUV0Rpcs6lUqrLoyJXOp+uqufZWSndr0LAsNxse1Q7Aa+ajtCuuMFwKZO80W0gpj3pmEIlugUh6NvkmpuLC1vAE9KxM4IViG2PiJrkeFWGWZH88vPyoZFCUJ4sDrdeSu+vp7y2SnrTN0VvJ5gfa8tT2s309b7KPAD2bFqSErD7dLaBUutLbqZqzqjNBGmOjCFaFwi7CVuNiJCbatZJUMgv3J1ZZMmZ/QJSdmT/YDuH34oI/kZh88EwlY/WkQYL88DXdnhYGxvzhdogRTqmf0IS4vtqv0Dcqc3VOmwNjlf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFqHxI0+sktzfSCdFLkbh1e48ZQDNhYqynfiZ03ujU0=;
 b=Lrnx1+Wghx7Glj2FxS1dqbz8a++Zbl/CfjSMbC2iKIiOT4UcmaH64e1apiOfz8wNlthUMgVp16u/8iq6kw5pmVKpxpqtAABS4MC2/Wz8qBSZ/xsh3NDSNB9MGW/0Kuyqw7LmMWzTbPnnllBOXnhBSQbEWQkj0tnj9r87rIn8urLrqRLTO09MxgUDIrJgFiyvVmyIAg480DufDg53ziUOML3Nfi3grcb6Yj8JTU8fO1ouB4qPS7nNnHGF2gUeow4M9V4y2WuUVJMXJN6NvnVuXZDUch6zZ7eXh5K9JlRByp+thzjUwd0Khq2iX4IWlkxELbOXjiaOtrDDpgqMmzRC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFqHxI0+sktzfSCdFLkbh1e48ZQDNhYqynfiZ03ujU0=;
 b=U8BFYwkCa8IACkswz/NOvPuC5rrSEr6Ra0V5JMwnsxKqvXgjhWZg5XKBCESU0R2pne6ujsnp831pTHAZxjDTTcyYvVvi4I/j41zoVr3Aad6U9qek+kj8/0N1s/BThXY3tZcBmgH7RBk3bUpGsWsjXNuzge0vKw59LRCz5kL+gwJD6rBPF3gIlBrennLLkZBnZqUTtOMHIuO4fhdV/RdcoIYJfpQqz4yJBcRNVG+WZEpLYMsYs6Sfh3ctnQdbVVu5FQgCueMSTgOiN4ekQc7olOM/54Cr3hUSFK4ubkNLV45Q4unWzm8akPsUkGhIDguxTfGegYSMCQBMYanJ0vOtig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:02:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:02:10 +0000
Message-ID: <771a9041-5c1b-4ede-b44e-37a0712ad5a5@siemens.com>
Date: Mon, 15 Dec 2025 08:02:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] y2038: lib/cobalt: select: Fix timeout writeback of
 the compat time64_t case
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
 <20251204-flo-fix-select-syscall-v1-2-7f9c545a63ce@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251204-flo-fix-select-syscall-v1-2-7f9c545a63ce@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: eb19ec7d-a888-4896-a4c1-08de3ba7ddea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXJQVEhpSUNuM1d0YmZNWXFBQWV6U1Y4N2NFeEtKVjkvd3EwMFE4TFdEV2Qz?=
 =?utf-8?B?NVVEZzNnN1puUFRSb0xla2RtVHZocUpmWUhhSUtvT3RiUnU5RXZPVkwxT280?=
 =?utf-8?B?MXVtWUZVWkxWaU9IbXdTanczU1ZpMHJkSE95aWJkWHpndm5wUWZNTkNEZy9E?=
 =?utf-8?B?NnpSQldDWFZadFZyZUUyUFpXZGc5Y25vMjZralY0d05yd1FLT1pWMmxQSkJU?=
 =?utf-8?B?TEloY0ZXZjJUbmtScldGenMvVjBPZ2llNzJlS2xROXVVa3BPOVB5cmx1c3ZQ?=
 =?utf-8?B?d05wbG1xZXJaSlBVOFEvS0NzZHFrU2c0Q1BlTFFnS0txb0V1Nkt4dUl2QzEw?=
 =?utf-8?B?Mkl4N1hOSExvSG93WVVPWGI4UVNxSzdWMFltY0hmT0FhQlZQb2NEVVJtR3o3?=
 =?utf-8?B?MUxzc3ZVSXFabm5uWWJza3BIaTNNaGtTT0pRQjgzbnJWY29yNFBsTHB0eGxT?=
 =?utf-8?B?dlZKSWFVRzlUbWtVUUhkTjI2SVZKUlBLMVA5MFQ2SGYvYkpadlNNZElRQ0di?=
 =?utf-8?B?Y2hsL2w3ejRrc3RONDg5dTBTRWFobkFwbTZWSEV0eTFrNFZLNnZuQkN6a3RS?=
 =?utf-8?B?S0tSS2tLS3U1bEJrQkFVUDBTRzJFYUFNOERhdmN4UDM2VHQ3b3FKSWVWVVN4?=
 =?utf-8?B?cllRRmh5Uk1YNEYwMlhRQlB6VzZjVjBacjQzMmdJcnB4cHhNajhTeG9wQU5a?=
 =?utf-8?B?dmlTTE5sOUdRZWxzVGZwRFNFWEhQY1VEdUlsSVZiQ1FQUFlZOCtKU2lrY1hY?=
 =?utf-8?B?dHpxamcrcmd6bkNrQmttNzBORTk5N2l2M2lQVnF6bXhDeW9GdXdROGdZUGUr?=
 =?utf-8?B?VkZ2bVI4RmZ5U0FqN20zaVRHVVlOTmx6RkNVVmVTMm4rajNVWXgyeXNJUFNP?=
 =?utf-8?B?dGwvME5kd0w3Z01qVkpFOTR3cWsxbjJTMlRROS9yNU85MVBWRGo3RkpLOHgv?=
 =?utf-8?B?MmFBdVJhdmVYaFBkTGw2SXJqQ1l6aXh4ZloyWlhxb3JDeHJ0cGhKMjVwMXh4?=
 =?utf-8?B?SmphYmc1dVJseWl6ZDFTNHdHeWVVc3NKTXh6ZFhaV3RWZWR0dWpWaVg5Sm0y?=
 =?utf-8?B?QzFQbFYvcEt2d1ZNQ29qaE9oa25WTTFxeUF4bW9ScmM0OVlmZmVpMndxb1hm?=
 =?utf-8?B?TmtQTHpleWdhS1V5WGJOcEdIeHVJM2UvVm83S2NFY0pNNHdjVSt1cEg5Q1ln?=
 =?utf-8?B?emt0bnk3YVQ1Zjd2WGkvN1JxQklHd25RdFZxdHcwOTlnZWc2VkgvcWp1azY4?=
 =?utf-8?B?S0YrK29sQndFaUhkTGVBV2VrVi9sV016ZDhsbUdGM0dlMkVhcHNmMG5nY042?=
 =?utf-8?B?R2oxOHdDN2tQVC9OczRKQ1haV1dLcVRzVTM3bTREWHQwT0hPZDQ3Y3I0U0dv?=
 =?utf-8?B?cjBxZWZ1TitjUE9oeHM1WmNoVmp3aVNoV1g5bGFRM3BmR2dXVm5zbk4rZWxN?=
 =?utf-8?B?Z3JJSC9MUGxuc0RWWTl4TVFCMnBsQWZ6Q0VVaGtEaElkOTgzT2g4dm5zNUNL?=
 =?utf-8?B?bm1hWS91SkdDVFZ3VmRGWTY2UEhpWk9hRHU3d3c1Rmg0cGtiazRINk5qV1dS?=
 =?utf-8?B?RHZGaTl6QVpKM3hlYWdwQkRuOTA2WEpOUFdRamRtVUEycS9wT1l5S2UvamRw?=
 =?utf-8?B?QjlPMG4rRmxpOWc3OEs5S0k5MXgzUlNoWEpnb2FzNmpKWXFjWHdKVU50ckx1?=
 =?utf-8?B?REd3cDVYSERuM0cwNmRBL2wzWW9GbWxyT20ycTliay93T09td1JuYitacUdQ?=
 =?utf-8?B?TnhjTkNWU0Q5RTY4TXI4aW1XN2graHlPZEdXMnpmcVFoeUFtSFFwYXcra1Mr?=
 =?utf-8?B?cnREOHN3WUNtY3ZOQVlHLzR2MUVqdXFHZm16RHZxd0ZXbUtHd0VyTmhvYkdt?=
 =?utf-8?B?NFNIZXVpNVBMS2JQZS9aYllnUXI0Sm1tYWtaVzE0WDFTaXl2cUVpSzNVajdE?=
 =?utf-8?Q?lVZbNqy++xnL9wnWnjIdty0lZDfLAPOz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTk0UnlZRkZoYVBRK0IwaFJPdityUlFVdUE4bDdzcVdvYXJWc09aNk9QS2pl?=
 =?utf-8?B?dm5CRHoweEZmZUUvendxcFFoQVNid25aM21iMktNYmpjbS9sZzUvYkJhSFJX?=
 =?utf-8?B?SW54TlFhbjF5UkZ1WkJHUGExZ1hNVmJBVDI1d0dUV1VFb3duazhIN1ViVDZB?=
 =?utf-8?B?cTk4RGFid05UQngxbEs3UjN6THc0ZlJJMlRwZ3I4cGVOcjdIOGU1bHRKMERl?=
 =?utf-8?B?NFRhUlRUNTUycG1HWkU4Y3RxUUxPcEh1VTBNUDZneVp1TUpzWUlHSzluYWNq?=
 =?utf-8?B?U0EzZ2tnRU1wUDkrcmdPM253Q1RDVWp5NldGR1UwK2U1RTdzOUdWeVlXbUlE?=
 =?utf-8?B?ODNoKzl4d3JsNzBKUU5TeXZ4SjJiRERrRXZNUEpQUS9mU1FFeCt3OGY5VnhB?=
 =?utf-8?B?eURqSEROM3pvWm9CdlpremNjNlNMSDY2aTdDbXhjMWYycENobUlIL1BWODl5?=
 =?utf-8?B?RWJSSW5tMnRwMW5EVlhieHBac0RlMW1rOGh2QnZHZXpJQy94Z01nNHRFODBB?=
 =?utf-8?B?OWZXcTFYc2JSeXBSeXVMWDE3ZWtUbDJIdkY4WWttVUtKZzRYcHpoKzBqUVNq?=
 =?utf-8?B?ZURBSC9iVEFrb3luM2xZdXJ6aUlRKy9oZlZyMjFmdVpkYytJbDNyTThQck5W?=
 =?utf-8?B?TU1DWFVqQzJLU3VOWUdLemRTUlU1WjhFV0gwUGxsTVVVTTdkMTRjZWppZWxl?=
 =?utf-8?B?ZjFLN05WUUpmZFNTZmhUM2g1ZEY4Z09yNzdjeUJxUllQbUQ2aFRYbGdJOVNv?=
 =?utf-8?B?L0FiNExZdXJYY2xqZW9ReHJTTmx3NSs5RVJ6YjRRV2FST0RzaHBtNzZTRVpr?=
 =?utf-8?B?czhBMzdVL3hMVndNZ0JiZ3AvREFLNjNHRjJIbHF1RWl6b0M0RWFxWWZ4UWN5?=
 =?utf-8?B?Zk9VS2N0Umh1Z0NHaW9RZ21aRSt2NVhYdEFTZTg0MHAvb0V3QXVYUGFMM2Y0?=
 =?utf-8?B?VS9SN3poRXhBMWloalZPa29kOGhJK3l1V3k1T3FIWW04OUp0Zk9GVUNEeWlY?=
 =?utf-8?B?U1UwOTJVTmVvUXJxdHVYd0svUm9ZcytOdUdWY21TZVhtNlF5RURZcDdhV3Ji?=
 =?utf-8?B?OUQxODhoRyt1cm10N0RrUzBRUjN1K21JNW9ybXIvbDFidHhEUVFBNlRzYUpU?=
 =?utf-8?B?T3pKNythS2NlN3ljclJqN3p2MUtIU1BXYnV5TEc1SDJER2orRENpcVZXY3ZN?=
 =?utf-8?B?OEptSldDVVJDdDZrRXd0eWlUUGVwQnVrVWhBeWVDeG9Ea05FQkFGVXhVbTh1?=
 =?utf-8?B?ZzFQQk1HMExGZTlYeXpVekREQ243YlVxckh4OGlVRmV2ZU95c05qdTM3TFRI?=
 =?utf-8?B?Y0tBUnlVcG1yWUZJRmRHSC9NTi8wT0JDYzJHZ2d6azVvcnJyZVhpZTE3REUx?=
 =?utf-8?B?YkpWSkUvTEdabm5Lc2d0aG5rNTdHZlB1MjRZRFBmWCtMRzZaK29MNGRPUi9h?=
 =?utf-8?B?SXgxZ1JoVlY1RjhOQVF3VFVpZk1QbHczVSswSVRsS291SDRyc2o1dlJPWnlV?=
 =?utf-8?B?eGVYT3VSVTZ4bTJGVXZtMEhVbURpRzRXODFRSmxYL1dzTVo3ZzhHc0svaVEw?=
 =?utf-8?B?MTkwb2lIc2ZHK1I5SWw0L0JrbHF5UXp4L2ZMZzdhRG4zSk5HNUtUOE5lczgr?=
 =?utf-8?B?TmNJenc4UFFUcUhFZTQ2R0FQaVlCWCs2MzNnV21mYlZyMHRpZFFFbnBiQllL?=
 =?utf-8?B?RHVrdTZiYU9xcmFWSzNodDE0NGJDZU03c3V3NmVYS09UVmFzdTZKRTd1OG1u?=
 =?utf-8?B?emQxemNEaXBTOFNxVEorN3RHUUM5cGNRb0RweHV2eWNqNWcrSkRrWEFuaGhW?=
 =?utf-8?B?YjdocDdVTkZtWUJ4UWpjZi94S0JhbmJzUCs1NEpud2FjcmR6TW1takNkWWlv?=
 =?utf-8?B?TGdtT083cnJrdkR2ZXRGSmcvYXlSUVVpN21YMlU5Z1ppQnA1RFV6QzJzNVFh?=
 =?utf-8?B?KzRTaW1zWXIrTlpBck0rQlVXeS83Vm1lVjFMQ0FBZmk3cTFaUEo4OFV2aGdS?=
 =?utf-8?B?Uk1aa2ttOE9yUFUrb1I2VlFwUXBCY2lINFdHUUpMdTVhVThIeFBrY2xXbDlP?=
 =?utf-8?B?QTRPQk5hSis4U1JQOWM0aVd5N2pqY3kwc3ZyazlkSU9DTUtEeHhkOW5adnNy?=
 =?utf-8?Q?8hIBTPeygdZYzUvHKY0ALRH3Q?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb19ec7d-a888-4896-a4c1-08de3ba7ddea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:02:10.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8V/ztwrdPza4OQWsqCY3j+9z+GiQzulCHKxWECFRSPI/3PjXQyFyKBDCKLSZkGazBeAWJ6Sza5o9BogIgVA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8897

On 05.12.25 10:03, Florian Bezdeka wrote:
> The kernel might modify the timeout parameter. As we have to convert
> from struct timeval (user) to struct timespec (kernel, pselect) the
> updated value was hidden from the user.
> 
> Fixes: c2b883446b80 ("y2038: lib/cobalt: Implement necessary wrappers for y2038 support")
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/cobalt/select.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
> index 611994d17..4a44b4fc1 100644
> --- a/lib/cobalt/select.c
> +++ b/lib/cobalt/select.c
> @@ -57,6 +57,11 @@ static inline int do_select(int __nfds, fd_set *__restrict __readfds,
>  
>  	pthread_setcanceltype(oldtype, NULL);
>  
> +	if (__timeout) {
> +		__timeout->tv_sec = to.tv_sec;
> +		__timeout->tv_usec = to.tv_nsec / 1000;
> +	}
> +

I think we can skip the above if the branch below is taken - small
optimization for the forwarded case.

>  	if (err == -EADV || err == -EPERM || err == -ENOSYS)
>  		err = __STD(__select64(__nfds, __readfds, __writefds,
>  				       __exceptfds, __timeout));
> 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
