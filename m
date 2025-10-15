Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8F305E1D
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506880; cv=fail; b=eInCLyZNSFtvm4+9OkD5JQ9IxLAdxyXDco3Rqy6SDvi0c2tVChGpkVU15ivY30zZTHp0+5bGPKFjVOTCrihCw3o2WnqvuHYlHQJunKtlfpWus4Yy5sZRi/QcAZU9Wkl7EVQp7a7an2MZQb4FU7v/LtbEWURZFMLqFU1TZAqSoTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506880; c=relaxed/simple;
	bh=7WYnaQkza3UtRIBvtrDe87bg6Pih7yMVNf3oG8Orejw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FqX/ErsIi3m4bKO2IVI6/xcGsDBj57bCjWXhzV4JIyux78hIkZUiKsQSDVDIYO0YPxPiQz5ZjrrMR9LD7NHE2OcstSHg7yZ51fXHcfWbv7SDtpxixwOzwwkCvXOTux/zADGA1e83Oh4UW4VOgcxR2W5OrR9knZ0yhq0U2KHUJzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=T5Er+u59; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="T5Er+u59"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOOWfCKx2ajdAw1QPKe0EYGyL+k0CBhJAbbWrjUGbqAvuUu+cDWPhXM3Uo913FEFDm/hKamSS8n3jvU3Fxyb7cmURlx/6HVPSIg/HjDyAPFgtTm0wT9YZsQwiQSOH8LBAe8E2yvaLk0npGDKzfR8DXEOc4n38ZEQ9SMzZ7V/PMMGvFidSPc6W36+tehr+oruP369c8/tEhNSW0Dk2oOwwQFIZ02ntxjWFk76uDo4N4Aasx1thbPDNMXhFYw+zQkiel1YRbp6vgxvGybIH3O4GtkaUEK0Tqq3yw0BDnqnNtHZ3xXRcMVs3m+1xoTdZ03cXKe/CyfMwHxuj1bFPklDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lubgqE0JBDRa8mnMqMbGJppMrRx/3nOTXz+ySLFLQ7M=;
 b=oKKH2nLIJ0na9AJ8wwAPfVrK/wbEf7JYN84jCnsOM1ocKHXfZ8uZXPuVifnJy7AUUcrFJUKZokgOYfob3j8JkNIlERGD7pvgNoCVaYYpDG+QVARasSObn6Dd5Q4N0Ura4DioVS6pnVOilWq3B0IN6O3urepus+L4AfiTXjdQKfxCah4v8jxwiQgTMXO4/+axkOP1hfxWtUaHtj+1G8gODmC84jfWgOEOrlVUmmq1h1wMS+orBmHwMhn4zygEmrH2qEHgxKowumNgJ97JgeV3JWsZPfSMy8GoquODKNX9BbcBlvdeLIVAR5Qm5N7gGhkTBAdYeInws0a91TD3O5vUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lubgqE0JBDRa8mnMqMbGJppMrRx/3nOTXz+ySLFLQ7M=;
 b=T5Er+u59qMag4QmB8IhaWr1q92bUUmmEUVeb0unh0ZyzzzO5rgKFqzrBJidXFDTDxudIBye2KKpwGYjm/ahIX7LvC/wPCk1DZpdPdZnWqeeEADArU6HC0n3B4tqd7X+k1g9F+vBgX4jq4MyUlPADccFI++JHBtqLATcKV5s5BMPeUd5SR9FGChAI5saTIWdK+OAAO7LUilgoDW+baGlv7qZpjd9R4LunSPfaJ6PfzQHt9JgIkpDoSI3BHlwgx25sGow00Wlra4Ex16tDcDXbnMMQW2gsyg94UzbvrUFcf5BGc63oSeZv+iuZ7fu51+9Lu8n9shvABjnnljzCU6ruxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM4PR10MB9403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 05:41:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 05:41:16 +0000
Message-ID: <207334db-048c-4c38-ad21-bcbd139899b4@siemens.com>
Date: Wed, 15 Oct 2025 07:41:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Latency issue on 6.12
To: Jeff Webb <w1@codecraftsmen.org>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <UyAUfjoIsmXhBUPBcslxRMNNb8GuRTy_kf6DCgLluexP13gUInYxr2sneftMAHkSwlvsvfMJMWnYvdXgpQCSsVSEDKG2-sFu1AV3dogwtdo=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <UyAUfjoIsmXhBUPBcslxRMNNb8GuRTy_kf6DCgLluexP13gUInYxr2sneftMAHkSwlvsvfMJMWnYvdXgpQCSsVSEDKG2-sFu1AV3dogwtdo=@codecraftsmen.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM4PR10MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d91d7d-7ca0-48db-6572-08de0bad752f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnVqU2pJVEFnNnpyZk5LY0w5dW5zS1U5TThjRmNRVEp5bEZGS3pnRHRSYUdw?=
 =?utf-8?B?UnZDVTRVMzEwN29YOVNBVituZnVlLy9EVmdJcS9iY1dMN0NVVUhWZ3JOOGNB?=
 =?utf-8?B?MzJjNWpqSjFyOTlsaGhkb1ZNb0kvR2VLRVhsMWdDOFBzbW5vR3NEM2EzaTIz?=
 =?utf-8?B?TTVpY2FqNEFpSXoxV0lrdDh3b1hlWmVmSlZINDN2T1dMbkI5bldCZWp6YTBV?=
 =?utf-8?B?S0lFNmc1VUxLdzViSmhvc1hXVDJRUm85eFRpam5TMDhVejEyUFVRcVZxdXRZ?=
 =?utf-8?B?KzJ4NEN1R1FRRUNsUnludnJCMmNReFJXSGF2SStoT0YyV1FhYktYbWc0R0tG?=
 =?utf-8?B?SGk3akNCcUo4VWZvVStHM05UZ1c4OTNrVnkvV21ZZnB5blNGbTFaM0NoVnZP?=
 =?utf-8?B?eWEwdEJOWTlta2duVTBTaG1NdDJEYnJjWHBkM0pvK1dHZnh5YXJJczdpUitF?=
 =?utf-8?B?SFBkRStmS21TM3gyK3RVTkVWbUlta21HbmsvYk1mbGNEcEhFdG9CVldOS29J?=
 =?utf-8?B?WHI2MEZLMlJHbDA3TnFNaitwZS9jVGN6ZC90QkRraUNXNnNtWjBySzRmMUEr?=
 =?utf-8?B?QlpDMEtHQ0xOTG9zQVpiUU1QS24vMkJNT1QxV3M2c0Q0UGRNcWMyVU1TWlhu?=
 =?utf-8?B?eWJOT3lTaS9sMEdDeUNqM2JubU1lK1VJeHRZR2d2d09qNXlmajZzeHAxNHVn?=
 =?utf-8?B?cGZPNFB0Mm1LU08rMmtSTWFrdW1YTk9wYnE3Sm1PenFSREZPb2x1MWRXSVdB?=
 =?utf-8?B?bWFOekl0Z1FnbGpTSHQzOGpid09pOEptNXdQd2hvZjRkVGcxeU9KVTFzbm9q?=
 =?utf-8?B?S1RrYjFBWWNnQmZHaUMzeHFIdUtObTVwMDFKMXE0ZVo1OHdZU0RFUDMxaEdZ?=
 =?utf-8?B?UU0rM2RQVmk0WWdsV2JoeDZKeDlHbnVLTmpIQi9yRnRqUm1HUkNZUXBrNEZy?=
 =?utf-8?B?NElxU1dDQjEvd05EdjlqMUZuOGVFWFVob0VKYWZCNzFNSnlFb2pUaVR5dWc0?=
 =?utf-8?B?WCtDVGFHZFdxWW5meStHa0tUU1ZLQi9WUmtHcGNvV0N0V3ZOclN1eG52Nmdi?=
 =?utf-8?B?QUFYK3hQOERSSTkzdk5oa3NhSnkzWmJsR0FXUVdvKzYwTzA0R0c2SExDazRw?=
 =?utf-8?B?cTg2YmJ0dXd3bWlvc3paTWI0ZkZaZURvOEo1ZXR1a3ZpVmV2ZllkUWIzd2VF?=
 =?utf-8?B?cnliMm9zcDBBT0xJYUJ5VmJhMDdvVlpMRHhnNTVydGxyWHVMci9PRDFBNjBJ?=
 =?utf-8?B?Z3BreExsR0NYdjNacXNGVDlHc0xCSE9kRXF1RmFqNW0rdmNZcGoyUDlYNTU3?=
 =?utf-8?B?QjIrNmRrN0lrczB0N0M4SE42cm1Gbk1ZTVpvU0dXQ3hqVk00eHNWejlyenVT?=
 =?utf-8?B?aDFVeWN1WE9sNFFGQlJERlZRdlFUelF3NnY3cytBSkVXcnoxQm1DSlJscTln?=
 =?utf-8?B?eVdHU2IrVFg0bmNvcTh2ZUlHTDdBTkYwMkJJeHU4eW5Ncm9JdktTR0JFSzlw?=
 =?utf-8?B?bXQyeU5qNW1SOU5CSUk5YTQ5ZXcvTkJGVFg0MDNPbGhMMVptUTMrUHlNNUcv?=
 =?utf-8?B?Wkx5L2kvZ2oxYzZmWnd3Z2dpNXhCVlR5V1ZVTENER2FqL3FMYW1vbXcvT0tr?=
 =?utf-8?B?NVcxSDVocWp3UnUzUUxVRDJOS3VmeGQ2QzJFUE5pRmR0TjkwY3dHWm85YUFM?=
 =?utf-8?B?TEpWeGJaVTFJSHhmZ1hwRzErQUVUb1pkYjlDTFZPenZrMTJUL0VhRGI2ZGdl?=
 =?utf-8?B?YlFkeFBRR09FVmxjQWNwcXZOWHMyWkF5WnMvTFBJVWExVUhhWGdKRmdPc2xi?=
 =?utf-8?B?Q3p0cHZYL2ZpMjRWek9qUTI1L1hqWjlFS1FtUS9vVUdQaktNQytUckxnQytt?=
 =?utf-8?B?SFdBWEQ4alFRSU9DTkZiUTJMSzF5U0RadklRU0UvUkYyVDA3Y285T0t2T0xi?=
 =?utf-8?Q?YbYRo7nKA0+FtgFf4Hb1AshKim58CQuD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2M4NE9xNE5RQWF6OFFidFpOOHZLNXcvdnNIY1p6aWpDY2hRamVPZndxVGJH?=
 =?utf-8?B?RW9wVHY5RVVjTjlRWjg1dFNTbGhqYVVWVWNHSkR3ZEx4V1ZpUmprU28vQm81?=
 =?utf-8?B?TU1ybGE5S0VMTWZHUHhzVU8zOU9JQmhuVnZKSjl1Zm5tQjcrdXVGb2FZaGtM?=
 =?utf-8?B?dVAvVm1saldjeDBQY3FjREFVZXpCZWtvcWd0K2o0aDFKWjdUTFNFQWlid0dm?=
 =?utf-8?B?WjliMkcrS2F3eUxFVVVYKyt4R3JRR2ROOUZ1YnRMS1o0ZVRhS2JEU0h3K1lH?=
 =?utf-8?B?bmhmL1FucmJDOVlXWE96bEEyZzVZdnk5L1lONDlqODhUR29jTjJIY3gzbGJZ?=
 =?utf-8?B?OERFMTF6VG5sWi8rMWhoQ01Wa3NVYnBlRiswSUxqWThwQzNFdmxWdmNpYkMv?=
 =?utf-8?B?Nk9TRDhuNEFZUFl6eVRJbjYzbnNyMCtxV1ZMTG9yTTJYZ0JOektJQ0lPUFpu?=
 =?utf-8?B?bVNxbXVmbzlwZTBSdFMxdjVMaFVHQkpKS1VpREIzZkxlaXlVY1BXV3hHcTRh?=
 =?utf-8?B?RXpsZCtKWUYyZVpGanhGZDh5UmYzQjRldkwvUnF0UENoUGswYnJkNFk1am8v?=
 =?utf-8?B?WlhZTGZRQXNXYkZFWG5rYWhFYTVKMTdTbzNOelhBMHNlSzNyWGhEWUpQajVq?=
 =?utf-8?B?bHdKclZYZnkrVzlTaTB5UThrSkZuOGFWQ1drMVQ5YlVzOHdTaDhudWUxbWFn?=
 =?utf-8?B?ZGpscGFBbTdvczIzcUh2K0MrZ0dXMlZGSUtoU2RFZjMrZXdGMm5vRlRUZFZY?=
 =?utf-8?B?N1hRMjU1alV5VmI1MTQwdU1VMkhpMEE3MXU2ZUZ5U2dnaXdMOFpJQ2ZvZGY2?=
 =?utf-8?B?NkdsOGF6UkJRTFF5a1NiZzRjeDNlSkorKzdDU1g4Tm9RbVlZNUhyb1lWYVhq?=
 =?utf-8?B?TEVOWWhSZVNWUTVTbVk2OStXUkc5VkRHZVFIc1lodDJaN01VbHhkdTZJdEdr?=
 =?utf-8?B?L1MxL25PdGNnVEdQNXN3akdrcXB0cmhaNmgyZFFWRVJHTmdCRmEwWmE2ZmRZ?=
 =?utf-8?B?UzNURllnWVdpQi9lRGJYdmxyMlpYUEVSN0dxdGVmbHp5Q2JxVk95aUw2dUs4?=
 =?utf-8?B?Qzd4YmsxbFo4S2dHZzBLVysvQjFTRzA5cHB2Vk83eG9qMktGWlIwd0ljZCs4?=
 =?utf-8?B?MnJ6MUJDRkhjSkx2YVJqRmVxVzZnZzA5R2dPaVRseVB4RWtaU3hJTFlSYzkz?=
 =?utf-8?B?cTVhVDhhWXRHQUV2eFhYdTJSS1RhL2tvN3Z5ZE8yQXhudVJKYzBOMEhreUto?=
 =?utf-8?B?Umd6N3I4QlZ6b0ZEMGRqVlUzRzJ5WWdnS29jZUdaNi9GWC96SmRiM0xtMVJu?=
 =?utf-8?B?N1JIRWZGNmF1eTd0Vy8xTjZlbkpFZkVBeUdGbnFqYnhPa3hmVXdHaks2NVVO?=
 =?utf-8?B?SmcwVVhQSmFQeWZqQmdYZDRLRC9haldEQXFPbEwvalZvWUtZUVNmNzd3SmhD?=
 =?utf-8?B?NXQ3TnNiUGt2aGlPQlQ4Tjl2Y3JqdVc4Y1ovVXdZVWVyeW1VTkdOVEdEcVBr?=
 =?utf-8?B?enMxbjBpcUdoa2NrUTNrcW4vdzBKaWVRd3h0a2VCbW5xVmxjNGRwNHdPbkZy?=
 =?utf-8?B?SzM4Q2xMMnpJNGtnQndXNzRsV29iTFQwVkd3VjJRNTR4ZlU5d2Vkam02dDVB?=
 =?utf-8?B?b3hGS3V1b0tWWW1EZ015Mm9HcW4wQURIZHZRUG81dGlWS284TGxYK2Y2RHZ1?=
 =?utf-8?B?WTZZSWwxVC8vM1BScDFhSk1ESDJXblVCc1RoMjJVMnNDNnRxdCs3eFg0cFlI?=
 =?utf-8?B?N1ViL09tRHU0a3pCbTdOYVAwaFdzMGVybEdQRU9hem1ZSWZNQXk2WkRvS052?=
 =?utf-8?B?NVNNazZpR3FCRWRIdjBwaVpGeTlxbU9qWlpLc2VackhCREg4c2s2bHEyUnEx?=
 =?utf-8?B?R0NIR3pxV21hV2R4c0tKZ0IyNjVxQ2ZVbi9lRE9jdWd6Nmk5amNFRGpCL0ZU?=
 =?utf-8?B?cW0zNmNaeWRtbGdTRXExaWhrVi80dzlSNzJYK3pycm9WUld2UzV1S0NMaVBx?=
 =?utf-8?B?TG5VeTN2elZ3Tld6ckQwbHV5dGtYV1NGNzkyNzRoL21OOTdTY0Zwd3ExR21J?=
 =?utf-8?B?K2hGUHhQR0kzNEx5OExrWENaZjNuOE1xMU9Lbm01NWU2VGtQaTdNNVdka2hs?=
 =?utf-8?Q?3Xulhg1krwp350NTTIn2WEUKG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d91d7d-7ca0-48db-6572-08de0bad752f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 05:41:16.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPWXfg52cHwLUQodgX98zVJUJonA8tilzx0yJfyA7RoxtLiJ56w+SRXMzdPv2J3Z0mWjj+1PIJsFvvflDxfE+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9403

On 13.10.25 15:44, Jeff Webb wrote:
> We have recently upgraded our real-time x86 application from ipipe 4.19.266-cip86/xenomai-3.1 to 6.1.137-cip42-dovetail4/xenomai-3.3.1, and the new setup seems to be working reliably with both our own application and the Xenomai-provided latency test program. When we use a 6.12.30-dovetail4 kernel, however, the latency program and our real-time application seems to still work properly on some older hardware (i7-8700K processor), but we eventually start getting some latency spikes in the 700 us range on our newer i5-14400 systems.
> 
> Tracking down this issue is on my to-do list, but has not been a high priority, since we have a working setup.  In light of some recent posts mentioning latency issues with 6.12 and later kernels, I thought it would be a good time to post this information to the list, in case it is relevant to the issue others are investigating.
> 

Thanks for reporting. I think we will need some traces from an affected
system in order to understand better what's going on.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
