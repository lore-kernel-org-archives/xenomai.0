Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A42E610F
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660610; cv=fail; b=a2q2cvbKXPVkyxYCbto55jArWHEeJXEb9s5oJitYuC4dghM38gVsasYXA7CadGw6se1ZrwWHruv0RHon5CMm/UToa1QwKjRROE300ePhShRT7QAzcHwMlq7LoBobksv/ICDpsXcxjZMmz6TjmGTesHceIOJfugUidtvj5aw498g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660610; c=relaxed/simple;
	bh=WdfwDAMiPuRb66ZsCOfbldKB3rbgxBj9oYrwlNiia6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jaIcNZe7EctXpEKVyjhNIEU6v7QACtmnP8i85dckc/mvG4L2y6eksFgyoK9LQhan7/dPh0hSDnfK0RCf0kiY6TRprfZ5Dxmflz6/YEiOfZmSQf+GkNt8olIHpPtZ5PfMl/VdLOAxi95K0Z/1TAh8ZYe9U9hJ6C6meBIpt48AhyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EJHsxCJL; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EJHsxCJL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXxLl0PV4XqibKhL6rgltmxqSkmiFJUOJ9vkQJSdKK9sH2CZsw7C6NaB0FOEDdfkJrdb18e/6IXtpOiE933b7qcYwqxBghrenSCOTvFAemA5yLq9zSOq63z28MP6191N297LJwA4ZmUUvqxmdXfZmqSSsSPcfqsSdHHAfn1fE/0oAfkFzhoE9CUmHHEoCi7E2VGMkwMC6RsTkjt0io84WJzC3x1BWSmh5GdFcxWUISk4Rpnh5uB9qbNn66TZPC32AHNXka93+VNQnzQ2gG3pVJ8AlfM77DCnjPXCNeUhM+XFw/kwS0oEs1uMn71uv/chWVUMU8DHSe3C9YWwOSaaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VLFcjPAN7vFUTvPMGUuGisLL+fYTJLPOYWCx98iE4k=;
 b=Rfi0i/T2Scb1U8InsDVBjKdddL2WrjkCkT1zinT2Jc9ewjgacxzi1YiSk7HyuhXmWgwmleyW5PkySPHL9l7EKUjmxqw5N0DyQvGy1YLLzcLy8o3qUoVE3l4tMcF2Zj2sD+FOGUu8IxjBLgMg5aUnCvnqy57faKSzCul2FrShTuBHuAJnFUutTw05J0SxCnLPzh8RmagIF2CrUvTch1Ux8RREI4fwDkTBsg/g5p5f1C1QLbYK6EHEIBEcOtaVYT9RkXwm1Y0J0uwsWxaWhxYQIZEiU6hTyWsqZthSyfYNu9o5fpz2qbPML26FPgyIYF/iy8Pyo2IKS+y4YJs2F0xk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VLFcjPAN7vFUTvPMGUuGisLL+fYTJLPOYWCx98iE4k=;
 b=EJHsxCJLBqph84AZ2kPCfigrbEsl3cRzkt8rwgFlVeszPzqF0pnHrMA9CwhnGydTlgWZK4bIZitNOSrb0nA3qhC/YjSGbOLjt77fW4NuPrqJBqnEC+7Pq31jU8iBzDgPTvpqDtl8QW+dcNMtFtHAJ1GDzHVc4QaUR/wXJJBUtUx1yJLZgqxxnRwggjNxP++k+FKpP/YGQYGeSnvOnXHX2WI1pIICHcRhoojgfA27gFnFSW72wOfL5Kwl4pAf1WwYETAjT5fjxVz9KLnlwHXIvoznsq5hEbVcEyt+YnU6KNcrVGzEV6aQqZkpBXjeCwWUzGxdwHLjJAN03NXsSyH2YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Wed, 11 Jun
 2025 16:50:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 16:50:04 +0000
Message-ID: <c2874537-14c2-4e1a-b8da-20ed0e50661a@siemens.com>
Date: Wed, 11 Jun 2025 18:50:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 6.1-cip] igb: add missing header for oob
 extensions
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
 <87wm9i2q1s.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87wm9i2q1s.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: f5708164-ce8b-4495-2f9d-08dda9080397
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0t6NURRcjZnS2N1OEpxcUpURi9HL2ZpUVhuVEo3eU8vdU95dTZQR040YTIr?=
 =?utf-8?B?Sm8wNytxZ1lrcDR1UFhkRWRFcGkwWDZiRjFkVkErcUpMWEJaODl6VTNwRGlI?=
 =?utf-8?B?UzF3V1IxUXpRN2puK2ZITkluOGZHNTBjRmxXTWp3dnJnaGZhNnZ1QzZTVkdk?=
 =?utf-8?B?dFdvczlRTUNUMy9FS242RXhQd2tEcHFTQXY5TVZGcC9HS0hWZmpSYndQYmd2?=
 =?utf-8?B?SVlXTWdrR1pzS0dnTGNLZXQra09zK3dFNzFrKzFOMHFnR2F4dVhLWmd6MlRz?=
 =?utf-8?B?enMvZUNxTjV4MUJ4MjF6SXJoa2hkdzhBcStEalVraEgySmxNblhMZTVxUjU0?=
 =?utf-8?B?aS9rdUtTMVJ1L09wTUdWc0gvYk0wL2xOdVY5WHZXRjRGNXVqaTBnWHJHbjJn?=
 =?utf-8?B?Yk9qaHUrYzNVdEp4ekZVdnBQYVhhcTlMZUk1cHlmaUhSYm1IellPbWF5WDJo?=
 =?utf-8?B?VU9vSFNROXdjQjZ4VytoQ2FWVENocjBWYjhHQjFkVm9oSkFXM1ZtZTJiSXJX?=
 =?utf-8?B?Y1JuUUFnUmNhdXkyNmIxNHlJaTlHcVYvemlYMWNyV2hCRldpUStnQzd0MVNh?=
 =?utf-8?B?ZHFrVllPZ1RwZ2tuejg0aExBZzI0d0pvdDcwaU5HWjI5MkEwTjJ1NWsyeXNw?=
 =?utf-8?B?YTNvL3lpNmtnVWpXbVUwRnRJQ1l0bHhsMVpPNEJaV291QWZoZW45bkdxU3NB?=
 =?utf-8?B?U0Z3cUtsdGZ5b3FSdnhIYjNkNWNrWmhGZ1BtdGxOdTFpTGxVRW1nU1I4NzJZ?=
 =?utf-8?B?SXRQZnA1cjg3cVRwK0ZJYVViVi9tSjlRMldaTWdRQ0dzTmNub2cxMU1ZK3pK?=
 =?utf-8?B?aEFzM3MxOFdLRHBwUUwrQTJ3ZlJVNzJjK09wTFNSVW9YeUlJeElFb0MwUWR1?=
 =?utf-8?B?elNQVXF6blI0UVhDWTJHU0Frb1hpaXdWT2IrU2d5cmM0ekhzKzZWUWNBdlZW?=
 =?utf-8?B?aDdtZTdqbDIvdTJYek82TldzazRMeWlLVlcrd0ozTGI3OWtnVHdQc0QwM25z?=
 =?utf-8?B?S25jWGs3ejJuMURaOWRkM3pXRFBJU1FjanVDRW5BNzFMam9oeDVFKzNoUUZ4?=
 =?utf-8?B?V2l6c2xVYmQzays5d0NNMStVK2VwTHluRGozTDhPTHBESm1maWVPNnpybnVw?=
 =?utf-8?B?M0JGYlNQeTRnU3BoRCs3WW9NU3hvbExtOTN2bjBhVXE3TTFiZERYbnNBd2Jk?=
 =?utf-8?B?OHBLbDR5YWk3SjdWdGpmaFdzdlBoYkhHT3lVUzQ2Z2lwdEN0U25Cc2xQcTVo?=
 =?utf-8?B?LzhPUU5NNEo3UlZQS1BkR2w1M0g5bldNUFdCOCtpNHdQR3ZGdUVUcFFNZk5T?=
 =?utf-8?B?c0lQbUxZb2R1c0lXdlFHdDZVZXlFTERGcHlnMSt6NHhtM2F4Yzh5bjVDbzg5?=
 =?utf-8?B?dU1LRHQrd1NnUjEyUi9pMkZxKzNOc0hON1NiR3pDYTAvWVpYY1o5MThsdFV4?=
 =?utf-8?B?ZVk1TnNjUHNycjdjYk1WMEN1RU1xY1VQS09UMkxoOGdJZDVsZ01zbU4vbWlp?=
 =?utf-8?B?bDFqcmZJK2NnTkFWalFYRHNJUnN2dUZmVkpjY3N0cWRRSVJIMXB5NHJ5aUlt?=
 =?utf-8?B?WHhnOVFzNFltbUNVZGJ0RzRuaG9rdkJ2QVQvR1NaOVgyQ3VaSVRVMkhEcTJR?=
 =?utf-8?B?T2QzcHZ6dmNxUk5CM0JkVHJXQ3llRTM0VjV4U1IvWUljR0tRVHpOb0czNTBC?=
 =?utf-8?B?VVFCek5SSE9uOHZUSklNYkFFSW1neXlMZlRHS1BkVmRuRkZFOUp6VmNIZ3lm?=
 =?utf-8?B?Slc1TzRiQ0R3blpOWTladzFiNVl5SXE4K3NqdFVZTmRicFZnZG5Fb2RoRVhU?=
 =?utf-8?Q?/lht9/UhHxkekVQP1dcJjNFjL2T7z2NcInIDw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXFLM3ZUdEp2OU01T1diWndSZ0U3ZjBPYW5mVk44Qmx2U3RJdkVSbUREd1Fn?=
 =?utf-8?B?YnZBUTNTWnNIcjU3UXV4UGpNdnFnd1pqckZnMU9WRHRxZTdqTVZod0liMjlL?=
 =?utf-8?B?MGdBUE1DQmUwSFVud0pRbkh5YnFVZHVnSDk5M0hMSnRXNEtYMVh2ckR2R3ZV?=
 =?utf-8?B?VWxQUEJZcW5GcklzTFgwQlV0OVJuMWVVRnBmbGpUV0ZjRjRwVzZVOW5wZEZS?=
 =?utf-8?B?MnpSeWYrZEVlZDZwZjl2UEJoQVZzRGVncDBPa2pubEU4cFJMRkxmNXFvOW5X?=
 =?utf-8?B?dXJlY3ljWHNsRzZCb3hqemMzSkg5eXRYcnVkaFJaQkpsV0tjMEhGSmJnUGh0?=
 =?utf-8?B?SjFSaXEwc0RhWkwvZFlaRmpGM2I4d1ZGdEpBVm8yTEhxSUFGZkwvMlM5dHVN?=
 =?utf-8?B?WUZnM09KNU9zeDRzVzRLM3dPUkVtb0h3OHIyMjZLS2l0SlhQMDdIRzFnOXo4?=
 =?utf-8?B?dis3b3NZdCt2N09oL3JOalBueVg4M24vb3d5bzZxSm5lN0UrMG9rckZOcnBW?=
 =?utf-8?B?VkM5Tzg2cWJEVjN5bzE3VmZ5SlpGZ1lRQXBhV2RLTkp4T3JOWG1JZVVMSkJm?=
 =?utf-8?B?dk92RkFXT0JtTHljM3ZiUHAxY3ZRdXY1dFQ0cEtkUm5ZRXl3Y0tBY0J0WlhH?=
 =?utf-8?B?RHVyZmF3ekJINjh0MEhWNGkzUVM0dVFJVGJpbk1wQTZ6VFFjQ1JJZ2NLb2pp?=
 =?utf-8?B?SFVSMEgzUkpYR2tkRFZPVU84Y2t0ejdBVUhvdHVjZitSWnhqZmJ2VDJEZ0Vm?=
 =?utf-8?B?SFViNG50dEtLaFVKWld5QTBqd21YUHpSYXJya1JNaTFmbG5jbk43cG1oVzlj?=
 =?utf-8?B?bFB0OCt4OUJxbW91QzZoQkV4c3lpYkdMYVNyQWw2TWdhMldCbUZlcUN0cWNB?=
 =?utf-8?B?V1ZtMzdqdUhUL01hdDZGTC84WWpFZzR4cWFtMCtFUVFOWDdleXQrZ2xoL0lR?=
 =?utf-8?B?YXp2U2h5YnJFWSs2c09FaEwrR0JMZzc4VEFqcTJRYkp6ZmVUQWNHczRoMDlk?=
 =?utf-8?B?ZC85cHFuR3VmcUZWbTNmcExRbSs4QllZQTZDSDM1dkZBNXJ6K2VGekpBSFhl?=
 =?utf-8?B?ZnlScmZLa0gwVFJ6Q09ycCtFVHFkOGQzbTd5eUR5aVFKNStEbVJvNGM2T3hx?=
 =?utf-8?B?WS9kbFQ4QUpUREE5NG5YSlFmRnV6Rjh5Z1c0N3UrUWNodTBBR0IxUVFobjhV?=
 =?utf-8?B?bUo3OE4zSXNVQkY1UFFCRm8waEVrcWp5YzlLNTJtQklPemt3Y0RXSTBIcjgw?=
 =?utf-8?B?U3hKcUVTSmw2WS9TMDVGam8ydlJndkVXaVM4dndrNzhlUkt3N0ZYeEEwMnha?=
 =?utf-8?B?elV4MHdoWWgveVBybStsZlVObEJRdkdTdmhFU05lc0NzVGFDUzNSN0VuTTBR?=
 =?utf-8?B?anhnS2lkOHJ2TFlFczZwUEVqN216SEtoU0lVeXZJZjhhVUszKzRVLzZiTVFv?=
 =?utf-8?B?azdsRm9CUjhVc2pkTXM4ck9jQ214ZjBELzJtV2tLOWdhY2tGck9ZNFNyemdY?=
 =?utf-8?B?dEpGMGppOW1rTXFjM01CVnIvRERmcGVldzBzWEFERG5NU3g3SVQ0R3NqK3R5?=
 =?utf-8?B?b2VpeThZZUJWY1duczlHWFpFMUtRakp6c1h2ZEU1bE8wMzA3OFg0b1d0RWxh?=
 =?utf-8?B?bWcwL0w2RUg1ak10czZYbzlydGF5QXJDUkw4RE5USVZ1QjNVOVhyS3BnYzI4?=
 =?utf-8?B?c0I0dmVxNEV5MytXclB3MkRKbnBOMlRka2M1L2ZwMWRiK2lqMlo5OGZyWkph?=
 =?utf-8?B?ZjFET05XUkNCdVFaRXU4QlhCYnZERjl0NmU1b2sxbWRDQ01Ua3dlQ0pHT2R5?=
 =?utf-8?B?dS8rZmlWQ1YvRXhscDJjOENwWlkzUnYvbjk0MnlTeUZkOUMrKzVkRloyTkJx?=
 =?utf-8?B?VVNaQUpKNkRFQnU1ODRPcGFBY2JRWDM2a3lBeFZCd0pZSWtEMVVReXVEbVRF?=
 =?utf-8?B?ZVZBVkxTeFFrTjU0REVxMnVpVWM1Y3gvdjdTRy9UZnkzem5SQ2FKOFlxejRF?=
 =?utf-8?B?aExNaGhJTDNnRkx4OXEzZmhhMFJNa2V4bWJhbHh4ZUM2Yms0M1NwUWd6d1ln?=
 =?utf-8?B?WWlOYTAzVXhFeHpDdVZzRTg3STJVZGFvVHlQazBFS0RuOVNzUllkRVBxeGtv?=
 =?utf-8?B?NjY4a09SQTRIZENhL1h6cVJqZlJOZjJ1d3NZcU1jNWZENkxwekthalZjZklk?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5708164-ce8b-4495-2f9d-08dda9080397
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 16:50:04.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfB+zD7R09IR8CxkPwuofBcXQZi4xAwO9MjtqtA07kJsS3/Jz6ddsGvI25GydjF7I0TzewvIVIeg9g+PhSAkQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5205

On 11.06.25 18:36, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Not yet tested, but this should make our pipeline green again:
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309
>>
>>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index c0932a3cb220f..26be743f2a6cf 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/netdevice.h>
>>  #include <linux/ipv6.h>
>> +#include <linux/skbuff.h>
>>  #include <linux/slab.h>
>>  #include <net/checksum.h>
>>  #include <net/ip6_checksum.h>
> 
> Interestingly, the original code never directly included that
> header. The x4 includes it indirectly, x3 does not since it does not
> use the oob netstack. Applying this patch, and forwarding it to v6.12.y
> which is going to have the same issue.

Interestingly, the current 6.12.y builds did not fail.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
