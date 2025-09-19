Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED22AD24
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266498; cv=fail; b=sGRookYT3NI8c999U+H6RdYx2S37l2eGsdFbPD/y1Qgg/OAi+GA6THuTrtIDsP7j0jesjGtO3L1njpfoy1PBa5uT0hJ5pxdrPjaTzYOzksgMyqy6j53bE/3DyqpNmu/hMbopfmDTc9knP5geD2E/ehlUGTKzn6h+aR95CsSeUWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266498; c=relaxed/simple;
	bh=J0ijLWdJw9s/hfs61CLKAwEyHkKOb4y2oFa4yPHBhS4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hfj/3h/3JVWACG0Hm5ja28ChN3zGDhLHUkveeTNcZGG6VR4UykQuf6PPD4YVn2tZbRla5hJSR4drSiRN9KvDDJpFHCQ/OfDokCikx278arQ2NiYRwaI3R29vokyYymoeS1ReJ4aWa62hl3SThXgdJ2FtPkcSkDoyaiPltP6MjYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NGTKl4oQ; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NGTKl4oQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsBbDwUFzMTVFhV6cmm3KV3uzxdXeRPtqNHu0VwNfMEdpZxXNfzcwDTtb4DSfkcy7lUZJGCELHZxs8/lqj5QTRpheBktSP8ZdTcGZPW3T79LT0ENxTO1Q+Vh0Al609aDq1DgyZDwbOm658tQo6AlQ6tB1iTsIP/i2LGBumtDCuSyZYv+40L9fmdya+y1r4dKB6yj4FWR3xQLhG3SriKW8xLBBvSEqyYIf8T8ffL5S7ovTdRSaiZehlmr7576g+JipDEZW9BvfXqu0NWBQBuxZ3BDUZ1xpG4MlYgpQsMa1d1iBMO7bC8FgHF9XlPUzD9HHwnBY6YvND7UDQqkjqJYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AA0/OAehuyb3UGvdd0m3jzXRDchIO/X6Pv3FAYnCEc=;
 b=F5NkridgIqe7vfClln2/1Vpg4Qpo/wRGMJKbkubEV/sQBEuDDU6pM6XGPH1BRwdrpvss4PIoueOJmPRYMRQ25Z8Pf2Lo1hNtkecTQp5F0mSbTPUhEmGTax6Fz+1BPtIVIjXW05QTTicz16T3rx8nnXt9HrhmWocTmamt4Z8sYnrEbzvYh1YiBFjzqmBZYjPimYuVwZ9Z08+VZy4jWx/W8uXyXWc7BxBj8PHUvEbXlBKXIxdEcfnH7qGCku8WnaVfTYn97PzLvAjxzRp64v/ZSJRxjMgPQZBgoVjuP1laLMQMpoSdVbfNhwQ9OdbFSyb9MkaVufbImzv/MzQgH9pi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AA0/OAehuyb3UGvdd0m3jzXRDchIO/X6Pv3FAYnCEc=;
 b=NGTKl4oQosSBM6BxNd5k7es5pR/S7Qu41bihSa4cnEv+oEc+XMgXOPXTYUIuvbfZs0AzM4phXUBEWn6nt9sGp448Ni/PiaAa6Zbw7Sv2JHnhJrp0ubYrQ1R0YTrLJQ+s/lYPyNgQbSNnWSOhnGZdzKvQ79QUM7v3ShJmOh49hOwvksqkSNVQoy0prNAA2/pSoG6dYCclQoWY85/QWgc5fq28KfA6k8ixa7Fzz3s+3o/lz47yOLWANz8gfIMRQOzGNFPPx1HJiy9AehZPEKXpnFtHtswa6eLfD371cVE3HhZEEaePrSq63zMwglQ1/VCqqlc66s0Sfr/vp/Xb6lZQ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by AS2PR10MB7048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:21:33 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:21:33 +0000
Message-ID: <72b84bca-3781-4719-97ed-95663a9bc433@siemens.com>
Date: Fri, 19 Sep 2025 09:21:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 04/13] libevl: Unbreak build of r51..r55
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1758210955.git.jan.kiszka@siemens.com>
 <45ee3b4aed024b1fc66864a77e09ddb49346e1a1.1758210955.git.jan.kiszka@siemens.com>
 <864bf229d505715df5d0b9f43714021e29a67a77.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <864bf229d505715df5d0b9f43714021e29a67a77.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::10) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|AS2PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0ddc85-be81-442f-22f1-08ddf74d295f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDVMd2lESDljcm1obFJGVUdiR1pqaHVqaWpaa0ZnT2FGTnpTVlhaRUJycWVI?=
 =?utf-8?B?ZVluSjhRS25xZkZnQkx1ek1KWi9XdUVTRmdNdXVaVGQ1QzNVeGhocVF5d3NG?=
 =?utf-8?B?UnN0bWdQZXZuMVppeVRGT3pMUlZzbU5VNy8ySVhtQld5dndBVWdZaHFCeHM5?=
 =?utf-8?B?ZU4zMFY0RFcyeUIxWXN0RHJLdXRGdWwxcFBDVkxNTzFKb0Ewb2ZrRCtMWTMy?=
 =?utf-8?B?SnZmU1FvQVF1aUw1Y3RWNWZqVjgrSWNCYnNlUHExUDJIVUlkRE5EQVRjc0h0?=
 =?utf-8?B?RWg1V3RueXZ4aGxkbCt0LytnSnZWM2ZqWDI5bDJYUE5IRjltVHovN3NWQXls?=
 =?utf-8?B?bUx5d1NkM2Y4UkVKR1RDbHA0TlM0dFI1a2hQVnlQNGErYWg1S3Fwc1lBOGdF?=
 =?utf-8?B?OG4zSCs3VlJDTGc4MnJ2SzBjS1FOT0FpRk1pRTlFVW02VURBMEU3dlNoR2g2?=
 =?utf-8?B?TjJrRU5KcFVVVTRQa2tFcENoY0tKRGhuU2NTRkJ3aHpjQ0ZXeU15bTI4ZXhN?=
 =?utf-8?B?Y2d0Q1FSQ3R4NFlML0RKVHUwR25RWmVQa1pUQWppT3NGSDlVMmNKZkZacUFV?=
 =?utf-8?B?aHpISHBRMXBDZFpiVHhLN1dzS0J3LzFFSDdqYVhUNjh5T2htL0dEZUxjRENx?=
 =?utf-8?B?aFI4cG5kMi8zdFdqUlBtbHpxL0EvQ3BrQlB6WVdPT0pvK294SXJDNUd0Nkpt?=
 =?utf-8?B?cThla0xnMEhSQ2xOcHd5bEtIUWVhWDRaVk8xcGR4dG1KTUR5SnpDQlVkODFU?=
 =?utf-8?B?TUIwMkVxWk9XdVFYeU5vSFFWL0xKdFU1bXkxcm9QcnI5QVltR0M3VStFaVBT?=
 =?utf-8?B?Qm0rR3JOOGpibzBaT05qblhHT2dqSlpOay9JUlNDSUdKMlVHdHZDTGcxTzh4?=
 =?utf-8?B?ejN5QmNxUWh0bEFoazhzTWhlYXpoZ3VKd3pxTnVjVGtOZHc5UUlWbTJDemk4?=
 =?utf-8?B?S2lNMjgwcE5iZWxNdWJ1dytJTklpTTc2MHpPOWx1czJocmZ2M05XUGljMjJx?=
 =?utf-8?B?YTBFUlB1Y0FRdjQ0OXJaWStib3p1ODdXeWZSR1gvdVBmREl6Ym5HU295bGdv?=
 =?utf-8?B?OXFBK080T1hjQ1EzclBKZGovTnc1ZUJTV2tOcGxJVWt6ZGRTdGZkNjU2TWcw?=
 =?utf-8?B?VmtZYk1FTXowQzg5dHBBSkFxM0NFL0EzZWFKR1EwbnQ0SWQ0VDNmemJDdDZx?=
 =?utf-8?B?bzhKbUtsWXhPV3p3czJaYnhtcE5qZTByZGJHOUF5L3lrZTFtdWtnRjI1aGtD?=
 =?utf-8?B?OElVWm9KNFhQYSs1NFVvRDJQMUhiN1Z2Y1d3c3h5WHRyTWNMenJBRUYwOG1U?=
 =?utf-8?B?ZUo1L1E4bUtyaFpPS0pyL3RwNFdMTWR5Skg2YlZsNUYzQWVlQ1U4T21EdlR0?=
 =?utf-8?B?NmNGT2o4b05BVGJyUy9wN203UVZhOE1HUWFtc3QyZGUremFzMkhuN1JKMjlr?=
 =?utf-8?B?L3hEb2ZFaUNSK1NKMHBIRXBUaHQ0SXI2dENMVnNCUVZSZnpsL1pMQlJjRHl2?=
 =?utf-8?B?RnhwUys2cHE1cFhWVW11ZHEzdVZwaVJYUkFZOTdVb0tlcWZ3U0JoTi9Ob0NE?=
 =?utf-8?B?Q0lNSE9VRXlRYU8zWFN3MnVaYVltZk45YnZSeU1tTkJWOHNmanhIZDFFaU5E?=
 =?utf-8?B?aHZidFJIU1R4UXFLTWxlMUw5ckxRSWdnM2RKb1JobjNDKzltOHI4WEJuSjlu?=
 =?utf-8?B?VStnWkkrR3B2MnRsaGhwV016QTdNcHZTd2lFWkhXWVBFY0JVOFJqdU12TFdO?=
 =?utf-8?B?aCtIQ0VqTWsvYTVjNXVnQ09uWG9teHM3UTd0Vy9iVzVJVVBkMStyVzI3VUxV?=
 =?utf-8?B?c1g0QVNCUUVSYVFvVHJ4R1RqbVRVOExjMnlLaU82Q3pvdTVudFBOVzczcXpR?=
 =?utf-8?B?ZE1Hc3hZU1hCUjRPY2tmMW52ellWc2NNd0JCdTZmZktQM0xnbWN2cmVSUUhk?=
 =?utf-8?Q?pfsWMNqekqA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1E2M01XU1lua0JoekpXK2lubGlJbDJOK2IvbEtLVGlyS1dXbjUrTGdLRVVX?=
 =?utf-8?B?dmV0Yi8yWHAyVUgwSUE0a0NjNUh1SUMxcmdNSFhsUkQvNFU3MTBFcUplMzNT?=
 =?utf-8?B?YU9RODFKZ3FIVTYzd0RUVk0zc2ZuOGFxekdwVit0TE11eTJJWXZYOTFRSk5h?=
 =?utf-8?B?bVY1TFIwZEp3MmpCWFUyMjlCcmc5VUthTlRVNVVOVUpyT1hPYzhVU0hQYmlL?=
 =?utf-8?B?bElpaFdWVk5WZGhKWEl6eGMwcDhxQXQydjRsSWhQc0svUjlGS1pYSDhPZ2h6?=
 =?utf-8?B?V05TbDcvMGpLZ1IranlYZVk3YnQ0K0F3UTF4VlBCb0F4aVRKTFFKU1BYbkIx?=
 =?utf-8?B?M0pCckx0d3loV1lhOXJxeVdyV0xud3hlZWovWis5eHcvZFN5SlU0bGdEZnBC?=
 =?utf-8?B?TkhXM3lqcGdEVEVrakhnVUlkbHl5Mi9FSVltZFRETytxb09tR2VnTmtTL2pH?=
 =?utf-8?B?NU4vcUFnY1FHUldUeDY1eHBKSHhaaENJUFNMNmdWR3g4NE5HRnkxME5ETUcr?=
 =?utf-8?B?SVNLNEo5d0syUWg3YzNHeCtvT0JRSUJ0a2FraU8rd216SXo5dlhqTzdiZkY5?=
 =?utf-8?B?STVTWTN6TjRrQ0FHQXR5dHVOSUxSbVFSYzlFRCt3Y0dUdmhiUjhrbEgwMThM?=
 =?utf-8?B?SWZhUTY3ZkY1SmFMMlg3cEc5eFBWRGwrR3VNamtiWEVXSmNqRUtVZGZnUDZn?=
 =?utf-8?B?N3dBMmNubDAwLzFaa1NIeUo3YTlxZWg5Ri9rQ2x3TTVFZlJKTmdNT0t1OVVa?=
 =?utf-8?B?MTgxRks4VURVQTRlTFhkNjZNZHhxYU1wVzZlaThUeW1NUXl4MnNkUDY0bFNT?=
 =?utf-8?B?QVhMZXRaaW8zcmdVdTVIbTFMRkN0TndPcCtwUXl4NXpJYTlUdjhNVkFpeFBk?=
 =?utf-8?B?Y0VhTGpRY0NnbHpyNk9pUEhaOUQ5c0tmVVdLQVB4Zzgvekdud0JNVGNZNm9I?=
 =?utf-8?B?S1hyUWVQQStQTDQrR0hWclRWZ1dQYXVyUjcrbUhQQjJ2UTZOc2Zva3FsUTBs?=
 =?utf-8?B?ZERKUk15ZGd2aFAyVEpHWVQ0dk5aTlRHUzUxS3paeTBuVjl2SmFGcWtza1RW?=
 =?utf-8?B?T0ZYL2JBdXkvVDkwRlUwVCtKZkVRTWFvbHdwSzVEUmNSdmErcWR2M2FjSkJt?=
 =?utf-8?B?dDl2V2xWNjcwbFZVclZUMHA0S0VOempmVGNUMHFXWjMrYUVjZ0ptNDBRMGZ1?=
 =?utf-8?B?VGR5VUpMWTZNLzNFNWlJc2hyaWRlUkNMWTYrS2RDak5yZnlKSHdZNVliYWx5?=
 =?utf-8?B?VnY1RFM2dWFwcnVxWitVQU9LaEpPWm81RTFGaHBDK2xaTzRXQW1SNEYzYlY1?=
 =?utf-8?B?eE9oeHhvSldTcVlyMTFXOE1CQVFVcWUxM2Zqd1d4dHJCWWJDTXVkMG9NSkQv?=
 =?utf-8?B?aTJGQjNwNzVISk9SYXlKUUhJR1JlZG9XbVlJMXpGL083ZkZ4TzBmR05IUVNK?=
 =?utf-8?B?VVU0VGRscldiY1kxYVVUTi82Qy9QYmNxbVpSekJGeFJJRUd4Tm51eXI1a2ZT?=
 =?utf-8?B?ZUs5WGxtTFpsY2FmeG5xaEZSdVIveUJEZ2JrSmk5UHZBZkl3UHhCb0xRVzlS?=
 =?utf-8?B?WDB5U1VmUXNNc0h2ek1GOGhaampkemYyZGpDU0ExT1hsdlFNVi9yemRkL2Zv?=
 =?utf-8?B?UHFxVkpJUUd6WnNGK2ZLOVczb3gyZ2VlWUxKVEdma0lsVEc5UTc3OUhFRzRk?=
 =?utf-8?B?TndZMjNtZVAvVGJwLzJLbVdLSFhEL1JXVTdBVVJzSVRjaFlIWWxoVllEd1dJ?=
 =?utf-8?B?cHd4SDRTYVNidndQWHU0R3ZkbTlsTTJmbTYyVEhHTldLdkk5aGo4OHNRaDIz?=
 =?utf-8?B?OEhpWWorT0EwZHgrVGFqU0FlNEVYMHozdUlqaHJscEhnUUxjOUxQZElGM2kx?=
 =?utf-8?B?RHJCT2hpS0Rabmc2MU9Kc2JLVkRSa2lWL3ZRTVBseHhXZG4wSTQzdVJQb1Aw?=
 =?utf-8?B?aGkyK0JvZEJLYmIrNTlMTWpGak5XczVHU0NOSU10VTdmZUowYlRZZlEyT0Zx?=
 =?utf-8?B?ZzA5RkhSZXdXZ1gxK2p5aml4QnltUThGaFdZVU5vcDY5T0wwM0V0U0xiaDNC?=
 =?utf-8?B?ajFjNEFNSFlZR085SDFPblNqY2ZVRDV4eWZaMTVxZU9Mc3RCTy9OVFJtT3ND?=
 =?utf-8?Q?RTumNtdi5HvtAw+aNxzyXlaPl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0ddc85-be81-442f-22f1-08ddf74d295f
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:21:33.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vv2QNekRXkUFGR3KNABDG66cOJLDLuhIP4vqBEuA+eCMV8vZdH89Xp52UU7V7jCNvBQq7vq5SmA97l1ZBjvGyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7048

On 19.09.25 08:47, Florian Bezdeka wrote:
> On Thu, 2025-09-18 at 17:55 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> One patch is needed since r53 up to and including the r55 release. An
>> additional build dependency is required since r51.
> 
> This is due to the compiler update, right?
> 

I might be that gcc-12 didn't complain loud enough or at all - I didn't
check that again.

> So the patch is already upstream but we need it for the older releases
> to get the Debian 13 tool chain working?
> 
> Hm... There are no stable branches, so we have to maintain all further
> patches within xenomai-images?

Yes, this will get dropped once r56 is out.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
