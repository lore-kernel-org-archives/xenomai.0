Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CE209689
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632389; cv=fail; b=giEp5Z9R0mzvGPxoRa9bsq7IKaKOzspn1bGC5lhtyEjEHLCgEpc4lBXobHNnnnLyXBTR4RpFU4jXKka/JueXKcU0Esmv4xsIz6dcHjYukACQYiN00fTUh4cnsqqrNt0sfaUj33iNR7qttKMDcTk/aHtkPicgXhAnQZn9CLqv9pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632389; c=relaxed/simple;
	bh=dBKAZoG7YUjfoA2jWKUrDfzQd64LR6gxFyVan72N69o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gbogv4So6oOdqms+7MdClplZYIGPyk06Jx1EVnvehkUfobFOhxzUMjy4C1uR5sWJXR+iPWTcNo3feED96eJe6IKC7nThpmLt44fKAHKKTmdCzVmbb+4kNoSBY+J+LnPwBeGUqVW4ipenSqG1P4bzVA4Q3aaqq6SQ1TVCBsw+Zd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PcXzND5u; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PcXzND5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvO4SQ8hJjKM+k5g1z/qfX+HtMyeof1RQshHDqA1fFL2yV7CS5sOGlsAMzzn2BzzRscCN9zD8F4b5BYwnfRKpTDVkhqOaYtqAx2HoMqcUUKQ9Kz8wiSAJg1S7fQwUMkYNv6P4Q90guaTYgW2i2vDbNuOhhkyFmwFRxEMs223cggjZfjByL1Qebl3QUPEQbPPhP+YI0fVhmRj6wv+HlQKGrLJs7UwoJRiOxTll/C1tY0cD9hxNREwuPplXJV71lkIPOpfHljSRoIJ1FEcgpwFdDk3eFDh0t8ZWVIJ9hPxvAZx2esyNSUz7uvzzSifd7wBnjhF009rXi3f0QIIxR++TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYyRxftXnUJSbT4BghCeDat6BhqZ0sxTnFYKB3vaBc0=;
 b=BNOSc8QOHpmH7kzOHIcSqBfLAbQ7YdNLLVq1z6kDLp3lYDa3f22IsnCLWI1Q1s44uRx+zUlMOBafiSK7FPPgp0JiO5UZQEIoXdICZBdjfNJSNfO7puZxCpzG7DCKsE0TnccT8o4OYFW8uNR79azGa3INIE3PONFulPtoRUXMqQzMleEeNQ68Glrb9w55qvvflUAFHhx77D4rMA2dWktPFxshvBSDFLpzuaiI8BqkVEHfOKRXBAyF/sYzkoYpiYfNy5HWIzDTrV/gCuLaYYXC45YhpoqPfX7Pqu9qbKVasVJOw0e4/1LlXeylXVWsb3kXH5q4F0FkpErCnC3MjXcNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYyRxftXnUJSbT4BghCeDat6BhqZ0sxTnFYKB3vaBc0=;
 b=PcXzND5uS6aKoysjEAe6j5lX+ERxp1JOfR2ZpmtCwPbTSFx2WU1vIzKCoyroOYxM0fHZMsGQpdBUOfiEdD0FZ6OE4AMgSvHBaQKE4caYD6+AzMmuJ6k1eFAcg7ga9aIKj0rnp/kCePfC+VC+wrtTv4MUUJ/ceNIevTPbF+X/OToxzLMWpfXHr3K+RVFCIEdW/urkd6yUERIevoc2yxJBBAWpP41Y5FZxJVVO9bL/jBJIrRmbGZzUQWp5PAqwOizjkxbdOuFYWGbkba7YaWEWpXtqWib2xAO9B4pp+SoFLWmydOffY219uE7QHK6RnrLSyB/cLw/wz57ADZCJ7BQt7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 07:39:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:39:43 +0000
Message-ID: <45907429-314f-42fe-b38b-6e2f7140a01f@siemens.com>
Date: Fri, 11 Oct 2024 09:39:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] RISC-V: enable IRQ-PIPELINE
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 shannmu <shanmu1901@gmail.com>, xenomai@lists.linux.dev
Cc: "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <20241011063730.310568-1-shanmu1901@gmail.com>
 <20241011063730.310568-2-shanmu1901@gmail.com>
 <bf826225-8056-47d8-8a9c-f71f368dc26c@siemens.com>
 <a59c3c6d97a76ea423dcdc283694f9c5baaac9be.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a59c3c6d97a76ea423dcdc283694f9c5baaac9be.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: f77173fc-ac8a-4146-37f7-08dce9c7df50
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cll5WXJUVDVoZjV3QjNTWGNyRzBRcGpSYklxT2MrTkNvQ3hObU56Umk1aFg2?=
 =?utf-8?B?NUpqUWFaRVRRTFFPcUNUWXJwZFQxTHg3NkZjTVlhcVpFbVpoLys4S2FESWw4?=
 =?utf-8?B?ZWNDdUZoUm91ZEtUT21RTENubDUwZkpGRVVyWWZhQmtuMngzRUcyWW83NFd5?=
 =?utf-8?B?Z0FZYUx6aVAvcTZySkpjYU80WDkvejZpSktsQmVYTHlqK3dmbFM4OHpxenJ5?=
 =?utf-8?B?VGlEUDU5NkVIWVgvMEpka0pBaWgwc3NIdTJFdWJHbVBSREVwU3ExQzFRT3M4?=
 =?utf-8?B?V0M3dkRsdFJvS0JPd2ViR29MUFNnRWpFbEx0eXRhc21MZytsc25vZ1M2Ulo3?=
 =?utf-8?B?TkNPdXYwaFB1UDNWSDFPNWpRL1lHV1hjMVYvZVJnYlgycHpXaGZTM2lnSnd6?=
 =?utf-8?B?UUg4aUhCenBUOXUrZHhlaVR1YzNnS0tYUVd3MkF2bGFlN0FSckZjc3ZadTVV?=
 =?utf-8?B?Z2ZqeCtwb1g3eDMwdzIxb2NVUEg0bDBTdmdQRXdKdVJoc1ZxOC9JQ093UHFG?=
 =?utf-8?B?bVpWaHJHQjJSVTdyQUhGelVnenlCUmtuTFlJeE4yR2lUeUxmTEhVbDNTZWRq?=
 =?utf-8?B?MTNReGRVYjgwNU1zLzlGekRXQXByOERBV2VFWW5Ka0ttVU94L0tEME5YUzIv?=
 =?utf-8?B?SlljQWdGWVRGMU9ENXBCR0ZzM0JHWUlqeWFISXJWU0hNQ2dKRGJnUkI3K3J6?=
 =?utf-8?B?bmV6bE1qTVYvZWIyVDJxb1Q3Vzcyb2VQRXREdmg1YjZrSEp0dzc3cVVyZDN5?=
 =?utf-8?B?SmRCTElvWE9SeEQwMEM4UUlvTWFSMXo0M2dZMDVnalFDZGFwRnZNNmU0d0RJ?=
 =?utf-8?B?TWFobUl2VzBDQWZtUlp3M2FJR2lFZ2ltcnNiaUxyUVRialpMTm9pU2t5Z1hS?=
 =?utf-8?B?WnpzWThNeEpnNmpCb1pqWGVaS0JHZFpiODFHYUdYSUVZcVIvdFBQL1FNYW9z?=
 =?utf-8?B?azlKNW9BZGlUazZJMHBnclVOQjMyeEZPTXo0d0VDREVMdEhrdnV6enFTSHpz?=
 =?utf-8?B?R1F1eWJHVEhLekFkNFErc2ZtUEVUeEN5YXFnY0pvMDkzbVJqS0k1MkhweXBX?=
 =?utf-8?B?YmZXcWZYUjUxWjE3dGhVRFk5L04yaGR4QUc2Y3lzK2U2czh6eVZUUEMvNUhQ?=
 =?utf-8?B?ZEFtNWVCcFlucU5paytidG9ndGVXSGxMYzg2N0o2UTFaK1lEa1JDbHNQSXFu?=
 =?utf-8?B?WDFvZ256UElWL0dITlY1b0JBUUhuRHNZM2xILy9BcmlRTGhUd1c4d1Q4ZWpZ?=
 =?utf-8?B?S3pFWW9RSy9GUTJIZWNuNG5CejBYSmh3SktWbGUwVVpaSkdWZDJQSStPc2pi?=
 =?utf-8?B?UWZtQVp2WUVCVWE2QmpiMlVHaFU1L3EzM1daZ3BaWUw1dXpQeWwvTEExT2VP?=
 =?utf-8?B?ZkpuV2JJcUJmNGR0L0R6NllnTEloRFc2RzU5d1FBK3daSzFtOExJVkpNM1Y3?=
 =?utf-8?B?TkNHNmRjSU0zVDkzVmF6Z3FrSDFFVE5kU0JNMHVDeWMwUVFIUEZBSTFCNU51?=
 =?utf-8?B?L2ovL1VZL0p6bCtZakorbGFMdSt1eXhiZXZXOEViVGR0bW5kZ1pWWGVEOS9j?=
 =?utf-8?B?OW5xODdhL2FLd1NSWWNKenF6OEN3Q3M3TndXcjdjT2kwRjNyTnJPd1pTTm9j?=
 =?utf-8?B?QURMd1lISnJQWUFJREFiQ0YvVWtxWFI5dVI2MUFrNnFnWWR6eXlmT1NKaS9w?=
 =?utf-8?B?MVZKVysyd2JSdkRVQVFmM1NKS1crL2ZKK0cxWUdtY1l6RDJRZktNZFZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFB4RE9xYkJGOU9MRER6WEpyenpFeDRSa3FXOWYreXdaNDZHek9FWVowY05X?=
 =?utf-8?B?Wk9pemNyNjdaZW5hTnRpL1pDMlJBTTBoaGEydkQ1cXlVdWc1djl3NVRmTGJZ?=
 =?utf-8?B?VkNCa2pkMkpNdElRTFFnMFQ3Rk5pYWl5UVMwd1g5NTFId1pDdXdoQjNLb2w2?=
 =?utf-8?B?U0RDVllRVGNuVE5mVlNCZGV0dUNGak1mY29jZ0E2TUQyVFdNWkc0bmVPb1Ir?=
 =?utf-8?B?Z1MwcWR0UWFhaDlRbzJ0cnE2YU9iNFZxUXZNL0Z2WkNiR2FqZXhiM2lOQUhS?=
 =?utf-8?B?aUNJMm9NaktpancyWkRUOXhKRVkrM0tGdWJNSEdaZHZqZm15TFp6Vkdtekla?=
 =?utf-8?B?eWRNcks2Y3QvTHM4TC8xTDVYZldCclJkNndKVDhlaVFBSHVwSndvR1VmYll2?=
 =?utf-8?B?UzdwZFV6NngwZExpSjg1MlovelRCNkNNa3kxWnc2MVNlQU9qd2xhTFcvVmow?=
 =?utf-8?B?U3pKZXh4UEYrMmU0Q2puZTJRUHk2WWtKdEtYd3kwV2k0MWpqRE43WVhXSmhj?=
 =?utf-8?B?b1dMRWl3YzhVT0l5UEZjV2xBeHE3QUdLSkxOOG9VNFMzb1FOUTVPME4rQ2Jy?=
 =?utf-8?B?UjVqWUlkVjdnNGE3Uktmc0kyeExqUGJBTHpCWE4wdi9nTTUyekhveGk3bmNw?=
 =?utf-8?B?ZFhIQ2VGQm04cGRsVmcwYzBIdk9Qb3RkZ0pHckZicHBPNHJFcDh5VERmOCt3?=
 =?utf-8?B?bjVvUmh3SmpBMUdRTXhCaVkxdHZBdDViS2xQTEhZdU5NL0IxOUdaU1lNRTMr?=
 =?utf-8?B?VW1Yc0xaOCtNNjFjanN2dmFZUTg4OEVZUnovVVM2MnNYWVo1S0p4SmVOQm81?=
 =?utf-8?B?cHc1Ym96OFIrNUtCWUkyUFpoVmJFT2pYOVRkN2V2VjBJZTUxNWhDK1NmazVI?=
 =?utf-8?B?QVVXTHdsMTJKeWVrMVc3YVJOYkttK1VETnp3dnp6MzFReUYwbUJRUmxTNzV6?=
 =?utf-8?B?QkdsaGhpWHN3eTJaalRaUEFiSFpmWVplQzkweXg5OVUvWmdZT21abVZFckty?=
 =?utf-8?B?M1gva01kelg4Q2k5RGVQZDhNVjFHMkdkZGo4aFdkNFdjN25sOWJJYmVLcmhC?=
 =?utf-8?B?K1ZYakpZSFpjOGMrYXBsUHZpSy8yYm04Q3RQeFhYVFRZem1lOXVYVCtrWTJz?=
 =?utf-8?B?Wk53cWhLR1hQeVR1OTRBRlBNVit5cWtJRmFFeHppYmwwcWZrOHJqQytBVkoy?=
 =?utf-8?B?bXRFR2U3Zzg1L1UwZVQ0T1JqMG1IdGFGRTJzWUg0ZDFhMXY0OTJYbW5UU3lo?=
 =?utf-8?B?aEE4aERha3RjYmR3djdQRVVtMkovMXFSWm91UzA2N3dmdXo4eDdubTAzMXFx?=
 =?utf-8?B?ODZ1Z0tCbUxuUXhjQ2FqUThaWHlxRDZCL210SzdKTWR6V2FTcmJrSDM2ODhV?=
 =?utf-8?B?YnZCcW5COVRGeDJNYisvV1lyd1pNUjVRMW5KSTZPTm9xamlNMWYwdlErYUJV?=
 =?utf-8?B?ZG81cDNSd1JhM2tSRTB2YVhHUkkzblptQzFRbk83WUVpWVd4cjNoMndJbllX?=
 =?utf-8?B?Z08rWVJvR05lZmoybFVWYXU2RGJTN015enI3ZllySURDWXBaRDJpOFg2RE5p?=
 =?utf-8?B?SllKUXgwRGpUak0wMkkrNHg2MnpXRkVwVFFBakxJdm1DRmhtdmRaRDRlRmpi?=
 =?utf-8?B?VkJ0TFJEQkdrS01GNi9lODE2Zm5SY0xGcnVCRzRQYlhrR0NNRnRDUWdiZ29T?=
 =?utf-8?B?K3dwZG1pR2c2eTlIYSt1QWwyYlJ5Qlo3NE5GM3g1aWUxWGhaR1JOQnRlTTBi?=
 =?utf-8?B?L08zdm5GV2JmbVlONVBGWFdwN0ptQkUzblRBdTQ0RGx1ejhPNDlBZ2Y5N2cz?=
 =?utf-8?B?UzE0SUt4ZzE0eUFkbTJoQk1qMDBCcCtRREp5bGNzMFVVWCt5QTJaa2Y1YTdy?=
 =?utf-8?B?R0QwMlI5SkxHMjNWUmZMbkR4VWVQYUcwUG04elkxMzRacHZ4cHdTSlMvZTBI?=
 =?utf-8?B?c3g1djdhL1hiL21oQVVGRC9CVUplVko2eldKUExHc1IrUWZCSmsvc01VS2dl?=
 =?utf-8?B?bUgvd0xZRmUweHFZNkQ0OFV0RHRQTERZMmFiclhteXM0RFRMVzRsOVVCL3pu?=
 =?utf-8?B?K3ZsTGd0b1hRS2V6RVJkazNCazJmS0ZFK1B3KzNVN0x5T1hyeERKamNVdnFB?=
 =?utf-8?Q?qiIMVDjzEaindxynJSG2eiuZp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77173fc-ac8a-4146-37f7-08dce9c7df50
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:39:43.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IO3D763U0n/SBBc3q9BmCiR2SL9XtCi3m9blXR0dzNa1FHkXeKIwSXGozEVENyyVHiSBlB3J/9pkYppOE4ZZPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6068

On 11.10.24 09:24, Florian Bezdeka wrote:
> On Fri, 2024-10-11 at 09:15 +0200, Jan Kiszka wrote:
>> On 11.10.24 08:37, shannmu wrote:
>>> This adds virtual interrupt functions `arch_xxx`,
>>> irq-pipelined top-level interrupt handler `handle_riscv_irq`
>>> and `handle_arch_irq_pipelined`,
>>> real interrupt-flags functions `native_xxx`,
>>> `mark_trap_entry` and `mark_trap_exit` in trap functions,
>>> multiplexed ipi_message_type `IPI_RESCHEDULE` for in-band ipi.
>>>
>>> Signed-off-by: shannmu <shanmu1901@gmail.com>
>>> ---
>>>  arch/riscv/Kconfig                    |   5 +
>>>  arch/riscv/include/asm/dovetail.h     |  58 +++++++
>>>  arch/riscv/include/asm/irq_pipeline.h | 173 +++++++++++++++++++++
>>>  arch/riscv/include/asm/irqflags.h     |  26 ++--
>>>  arch/riscv/include/asm/mmu_context.h  |  21 ++-
>>>  arch/riscv/include/asm/syscall.h      |   6 +
>>>  arch/riscv/kernel/Makefile            |   1 +
>>>  arch/riscv/kernel/irq.c               |  72 ++++++---
>>>  arch/riscv/kernel/irq_pipeline.c      |  46 ++++++
>>>  arch/riscv/kernel/smp.c               | 135 ++++++++++++----
>>>  arch/riscv/kernel/smpboot.c           |   2 +-
>>>  arch/riscv/kernel/traps.c             | 212 +++++++++++++++-----------
>>>  arch/riscv/mm/fault.c                 |  46 +++---
>>>  13 files changed, 633 insertions(+), 170 deletions(-)
>>>  create mode 100644 arch/riscv/include/asm/dovetail.h
>>>  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
>>>  create mode 100644 arch/riscv/kernel/irq_pipeline.c
>>>
>>
>> Thanks for sharing your work! Could you explain how these bits compare
>> to what Tobias sent earlier [1]? Is it possible to combine your work
>> with that to ensure nothing relevant is missed?
> 
> Thanks for sharing +1. One major difference is the base branch. Tobias
> was working on 6.11 while this one is based on 6.6.
> 
> As we now have two different works streams it makes sense to
> synchronize and ideally align on a roadmap / work sharing plan. That
> would help to minimize review / testing efforts - at least on my side.
> 

I would say work should focus on dovetail/evl head initially, then it
can be backported.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
