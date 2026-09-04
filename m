Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C549505E
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529173; cv=fail; b=B+LdLsCdTiCJpnXPCs/yTrHP6QGa8TlAQSmET86AElPW9RPIJfrMqRR5UY/Pk9xsbrNc6dtSso6CpZAQN9r5V2/X7dOYT8zZBPP//bAJ0jDdHJSM3Ao/vfhgdaBWp/0/zZZIxIx2Jo3WdqKEzc2XZEUuALM1ykZH7EdNgDAE8N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529173; c=relaxed/simple;
	bh=1MlwB/508gK1dSY2x11CbNountJmdYGK3NT9cl8Ob5Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rA195cRmYo0TTAP1eX8jmjdtC823v1MM4PNJuSpS3W3GtW3ErPkqOm04FjaB3httJ+BsDLqLBd9KO8aUeMZuDtee4AEiz8DzV4RY8PNNHNS9BXWh+ClYb8/fR+8chmfkBExcPZzD1LGYwU/R0NnN70hmMt0inXmaIFkS6EA76b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=m/iv/zFa; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="m/iv/zFa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgJtKmHLT7MM0CHxQT4gPO+04pLMQ6VoExH9JW/E7RA+Uu5lRRM2wPtfGb/0egNyl96Xu8a9TitDXbo5/Dj5LE11AVoW5L+8o6ldvyvACgnhu4Kx2o6C8eD1HXBwzSIXvadVHNBNn5s8Xr/ZJ9/HW3c4Pu6FxCK40KHeowcFaSDjC64JUvKdDCOfKIKpQSLH1EXwyv81RMEpRC+PiHKOOK+Vkq/8kCxdCpQ05x1RT5KvyIOP70XtlY8bcqZuAG9NZoQZKhAcIre9nKiw1YsjU0Cr5MJkPNkRiI+tMxzdsN5iNAe5X03BDU62jNV6a6hotyJ0LYMfZXH3lzEKUXuWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKCza9IKXt9pwmY0+Ycd15CeYDe258PjjW2yEb1PmOI=;
 b=zUKnt+2xHkX+gFhkSSk/pPkxCpIwcZGzRNrTEG5PVOIoS8cyabW9g6DcKoBg971DZWyyCTR8L3GXlnKonaCtWpcBcCI8LJ+FH2ed23UW+xTx/2eAi0eri2FOgMlga2SKmcFy8iAQ7TkaiiRysbdxnqG3ViRm20JodJYG21axWeA80Cm5HyKxEXCRFDJwOv27YChs9rGesPNlz8QbVyY0jSZx7GinSnAaNe5EPUMU6cRi/d990SSaqhGs1CRRiZ/fu88AJUL98KimMlMjQjW5lOxwEXxWNtXqyfOqbha/QCk/o/Rh5s9RtG/IA8LXG7zSxjXtKVPmGUmnThF0DE9sMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKCza9IKXt9pwmY0+Ycd15CeYDe258PjjW2yEb1PmOI=;
 b=m/iv/zFaCpNyDqG1tklg9GUf9qq7H3tMeBntfRNUysy85A1mUCdbzkW8BR6SBwcTVUfLu/yNGAu4tgLMz5SjyKNiqe4pr0e0aJquXe8FJswGkY3qAexUQrco9YLEl7og+ipiznOWzqzXzQmQFYXDkuy+q/cguLWM5PtrNQncNBgnfEUfiPFkTkM+zciQ9G72RqNMkp9WNK9x38Mw65O5+NrRN1attiq0C/fwucNo2gKOthRDpYq6+rrzA9vOao8fXo9aRhDVbu9mVMLwxAy4Ai8F0mAyRPEYJkBaWzPHhW4dH0D9ogwySVAb1ARxTm5s0cYyo9SJiNeaZ+u3xJiNKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 13:39:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:39:27 +0000
Message-ID: <f28b3691-0e0e-4d41-ba4b-86027a6d0850@siemens.com>
Date: Fri, 4 Sep 2026 15:39:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail + EVL: RISC-V + 7.2
To: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
References: <878q5he1ei.fsf@xenomai.org>
 <776fa79b-bd7b-4309-95c1-bb659793d63d@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <776fa79b-bd7b-4309-95c1-bb659793d63d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db02950-e3ad-4128-a990-08df0a89f0a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	umcBY7fc/vMPcrMfam7Kp8moxTTivXQRNecwimJu/ZZ7Fwa0YzH09c/qrXXr7U1pgg5puG5gQ7tA9Pbu/yzF45XZ/SS4LVcyDd/mbb4+0yhNn49e0IWvYP/p0O5GViV55dKiUSA2i33GP5JtTrEbncPuNyaSKoCq6DBeEsqBA4tr2L+npicln5JVdJ5Ra6Kt8W/+M+aXi7hnnUGlEj1n6iVUMZW8GWoOpVIuNPQpvfp2sR0PeE4GN6uTDZ1tSCHZyJeobnvXl7ShRGuKje+3QjjBfzCIBUpftW3GxsIkQ3xd8Ox13KvjP+IYf1DbJ2iIBP938H0mB3oXIXbPBj1QvcdBz8qGwWJ31IsDXYOol0DiJGK+pDA9EJpdQUY+TwiLOcAuDOKOYm6NJyJXZ7KGwKFHyOPNfLpf4ye9XwQcdoJaDUa4Y7DNZe3jDiAXggdeCCB6y665DCn0SS6D2LvI4hLor4YFv+pxSk+ibEERrdxzofnsu6dxet/+HP/091udqOFgGTN/5VrCfswWwuhuUBvS7+b+jBeY0pdE1GibHs7FObxlWRC9+Pz5ypsvip0GUicNbjyexAcF/X/muXspoTba7TFhxAqFVeKr51bUyYXIs91ca1CuLt9L8eBxNgfT559oCmpDmMJBnf7Q0TRzo/twFx/3UXTBbAsMPRqLM0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVdOdUtKWjAzbVhra2UrLzJScFF2ZzRsUzdhcWV0Z2t5RzNRa0F5amZaUnkw?=
 =?utf-8?B?QXVEMFFHUUVySG9DWFZQWmx1eXpuQ2trUi9DZjBKZXdXcVFNZlFBZ3lkNWxh?=
 =?utf-8?B?eExYU0w0elZ1YVVCSTVzb1NIdUU1MGtPWGI4ekFMeE1aZFpqVERWYW5SdldM?=
 =?utf-8?B?c3FPZEJqcjl1aFRZMVZGYmlqTUE0amF1Q21JQWNwNEpiZ2VsUVZLeHhKN1Qw?=
 =?utf-8?B?SDJrR1hMU1ZBd2Q2MDByOGg2anJSUEFrZS85MVh6RHJzcCtPVVZlSWhRTnI3?=
 =?utf-8?B?eGdmSW9kS2NsTEI0S0JadnYybCt5WkhnOVlndmdoZ2ZlL2s1U203NC9xZHZm?=
 =?utf-8?B?SkxTRnRwM21yYXlJODhtczAwSTJ3a3FYWnRZOExodmJLZ01Eb0hKSDNoTU54?=
 =?utf-8?B?alh2TzlFelJRdTJRajZPZ0VDckdkYXFTK0lSeFFEa3FHVlkxYVN3OUtwenBi?=
 =?utf-8?B?Q2tRQ2poaWFDdWs2eHZyL2tLdU56WlZ0YjNBOEtpaTJNNnpXb1Y1a2xta0Jj?=
 =?utf-8?B?TkQxN3pnSm5RVyt1cjNQdWpJazd1YncxOFVRY2RVaTVXbit6WTMybVlveFVQ?=
 =?utf-8?B?bVQ3eitROCtVK24yQ0pPOERtUkdmWW9MMVJSejNvT0NjRDJZa1Q1QzNOVkJI?=
 =?utf-8?B?Q2dkWUY0MEdyN0ozTndWZ3I4ZDZvYnAwZ2Jmb1lCNEg5Wmg0a2dIUlpFczVp?=
 =?utf-8?B?RnNkTldNdld6d2pwRklXOXhFWkVrVmMrTHdoY1YwYjg0dlp6K3d2TUl0dGVu?=
 =?utf-8?B?V3d0eDVlT0Z3RE1KWEdZZExMaSsyZXpKYlY5anAwd3VpQjJzWVU0ZXFwRmFW?=
 =?utf-8?B?WkRPNXpsUnlYTWRFekxGYktpWW00bXhjVEpuZy9Md1NQTEN4alROS1c4ak9Y?=
 =?utf-8?B?OHBrNFcrUlh1Q2pXZUk0ZmRiM3haMExTdHBwYVcra0VNK1k3Rk00aXdVb0NW?=
 =?utf-8?B?Yk1PWFV6aS9iZzcxdWh5RUs1MkFRRDFvME9HV2xpVTFnR3hGS2hCR3h6THlw?=
 =?utf-8?B?RzJwSjcyZ2ZNb1dxVUZ3UVVHK2FZa05rdHlqRS9BRjJVYmRCVGdybmRZYzNV?=
 =?utf-8?B?eWxMV21sU0xRdzRmU0JsT0l4cnVlNWVRM3FMY09pMEUyWTQ4RitNV3lHRGxu?=
 =?utf-8?B?MjZHc0F1VDRUNm1Oc2hLWTJNd0VReUNiTVJTWjN2V1VDZ2hidm91N3NVcG1G?=
 =?utf-8?B?ZzVRKzB2dEJCZlkvZnZzdUQwaUllb3lyeVNIUTVBaEZ6UmprWnNtQnMxSXNk?=
 =?utf-8?B?dHRtQUR0RWV3Q2wxTkEzMy95U3AyK1laQ1c5ODJXVVRmSmJWa2ZVcDg4Wm1F?=
 =?utf-8?B?dzJraFRqeGRRb1kvclk5eVlhQnNFWFAzc2NGNlRWencxbURKWlVKZVphQlZW?=
 =?utf-8?B?NGdlZkU3WDNpc1FCZjdEOGFHSDJxQ1E3aGRLYjV3ZjBqMjFkVjNUYnhGdEFw?=
 =?utf-8?B?THZaRE1IYTVROVM0SmVtMmx4T0pCaE1pMmJVVjB4S0dqTnRjYlF5YXpJZDls?=
 =?utf-8?B?eGFkQXNOK1l6dFJVKytYSGdCK0ZDS2MvS3NmZzJtMm1HVmp6Tk1YNDltWGNR?=
 =?utf-8?B?b1VYRG0rOHhva2JjcXc2Vkp0bGRobERESlgzT0FzZFJOa1hFMjZPb0k5VFk1?=
 =?utf-8?B?YlpleWNTd0RzRWtNbnB1YzBhRkdoQlpzK2Zqa0VFU1hqRDRDYlN5MTVMUEVn?=
 =?utf-8?B?eDRxOUlqaitnUWc2MWVWKzBFc0ZleStZb2hidVVCdTVNUjg0YWNEV3R3bWw3?=
 =?utf-8?B?Rm1QbHN5Z3JPbjhnRDFxakhSSEtYeUhtUzF1QzFaZEcvY0JRREZTdXNyQVBi?=
 =?utf-8?B?WHFoSGErMVdxNmp2YnR3QXVoN3VPY3lReDVGc0ozNUI4QjRrSDhWVDBwWnVp?=
 =?utf-8?B?bVlmRzVoNHNQYmUyK0JoY3ZYd3l1Rmt5ZHBsUlRmbWVWUThhSXZPbWE4RGs4?=
 =?utf-8?B?RE1YeUl6VTlSSDZvTjRMS0pWYmdrVHlyZXVUb09tTFBGbGE3d0t1MXVkeEps?=
 =?utf-8?B?Mmw0aTRkQWE2RXJGUDc4WnFnc29lRElGeVBwNXZjWjl5OGQreTlIRUM3U0cx?=
 =?utf-8?B?NWZrOUV5ak0vbVI3NjdZb2xSTWdYVDJ3TWVFWG53V3ZpRS82T3ZnU1gvMzgr?=
 =?utf-8?B?VC80bjYwamo3TlRxaGtoSE9DS29iNVJwcGhHS1RGQlRhYmhVWlVFSit0dTJV?=
 =?utf-8?B?amRvZFlLWUVIMGRnY2xaLzFURzFrNXdZZWpMZlpFRjhta294OG42NStFY0tm?=
 =?utf-8?B?UEtTaEgwWVRrUEdzL2hseDFSemRBRkFIZDM2VkZucDl2djJDR0hrRXd3T3ZV?=
 =?utf-8?B?KzBtVk1CWHBjUjJIWXlKWU0wQ3dBQUlISXZOWkhPenNEYjV2OWlVUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db02950-e3ad-4128-a990-08df0a89f0a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:39:27.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQTvwozrwqC4q3iz70aAXmfiH/FdZaWJeL6r0wbMjA8iEkYQZ4fhRsljsnUAHNZ/wwE8LVg1Ei24ChmszNuS3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6996

On 04.09.26 14:46, Tobias Schaffner wrote:
> On 9/4/26 12:50, Philippe Gerum wrote:
>>
>> The (slightly overdue) Dovetail and xenomai4 (aka EVL core)
>> implementation targeting the 7.2 kernel is now available from our
>> development trees [1][2]. Starting from this release, we support the
>> RISC-V architecture, thanks to Tobias's work.
> 
> Thanks Philippe!
> 
>> Building applications for 7.2 requires libevl r61.
>>
>> [1] https://gitlab.com/Xenomai/linux-dovetail/-/tree/v7.2-dovetail-
>> rebase?ref_type=heads
>> [2]
>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/v7.2-evl-rebase?
>> ref_type=heads
>>
> 
> Will there again be a evl/next/v7.2-evl-rebase branch or is there no
> next branch needed anymore from this release on?
> 

There must always be a next/ branch for the active kernel, or CI will
miss the version. That's the deal.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
