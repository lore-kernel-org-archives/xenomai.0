Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3031A71
	for <xenomai@lists.linux.dev>; Thu,  7 Dec 2023 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NEppeACR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIJCaO8O5Eq6UfnFPLxWvE0PUO4Oea4CQHPuFuqTEAyJsocdo/Voq/BxrCwtszpK0qEDbj8RH7z46dW7GY66IQHi+yxaIXjJxyxpjlA85LKN+PbnSUdnGg3gfY5KNfS8uHoeS0CPEpv6EX0/rUP3RKChWJGQYYuV+wxfBgxEc+HoDnh/nci+c9f4/M5+h7s4+CWM/nIRdnGpcD3e6NxW0xgjVc4UvITs2NSknXL9oJUPnHyGErZfGXbXe7C7Ba5Hz6HWNz9jXRKbZopY8DN4KlhnNC9b7VkMhCP6CK8dAE5AVVDAqTQtwaaqYLwRjbtnKkvW5e3W3Tn8myScdmgUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4Z4tQEm4vd78FWORMcYPreoYMpTsHzIgXCWUpFkU7o=;
 b=f076ETbgxMYpBNzo2RwBhhK4QrCi+DoqRlsDlVtbMJb2gQamVIEO+ElnGsloxoZjBcPrwg0Cy8koC2D1vgYFs9qozicKdPmqT9Atu4ZvazaTz1JQqIE/PgeESs78KZ3OqTQmhU/3NjH7LxyrSPrJt8c8ot66laTmll5qAtaTS3B8Akvz6ByILLwtyPWKuKnxJ8ik1Y2TvGptQMKFDRS56GodVl/BImzAloMEBufgpYLHuVPLMiuwtvmLL/PBr2TJooTn8X3u99/Ro3dbRDUF/XWhdPP6jSTFRnBD03goJiMGufkTTxTZ7A02nOpwqX0lJgghORJK6ZR/9l4wZbJoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4Z4tQEm4vd78FWORMcYPreoYMpTsHzIgXCWUpFkU7o=;
 b=NEppeACR7BC2yI1Yn9dgyL7DSpwZlj9ASxDGpwPGhvJVfvQc9dHS6FlcMAb4VBx9EkUUpfX/K2NrhlrMzfB2ZX1KOu8OMfM2z8yXUYZ8a8cI4DoiVRvAyhItS/Z86bIA3hGlZN92LkBpo3AbZ0SH1FWTHnSH83pRg+FWC1K6OtG4wVI32HN2IGfVtLsgbPgn2r1zOdehC6B0eFjcTbb06fSRy14zRIHY00y+wy1OaUPlwAi22YREfY2uSB4JCNCpS7x4kv7lnMHdgop+a97hbDoaWp4MmuoLyJ6zuYxLeB1YrvI3t7M6Esx7RJGndsTeD2fr4BQdXMU9PBJDNJaNqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 09:12:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 09:12:42 +0000
Message-ID: <c1aa91be-a8c3-4d36-83fc-1dcce598dcef@siemens.com>
Date: Thu, 7 Dec 2023 10:12:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/drvlib: Prefault io memory again
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 rpm@xenomai.org
Cc: wg@denx.de
References: <20231205202210.25477-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231205202210.25477-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 12da6812-b2cc-42f3-ea8b-08dbf704aaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wiZ7X+CoA6ahkal1VOpRgAoa3aTImnTu6mnG2HtpGnVEM71Ya0QL2BPnTXShFtiemAHKs59NPlAP8ml9smczCPlB/IjlXTdorYNvd7eQkC4PO2s4P2LcZa8eaM9Mzhv0pvF/EN4BBlRq6FP8Q5IUQSVgI5ZlA6LlMAjFgJOP3HqGmKJBs0oRkUTyHMUOScuv30evhTOPBhaRoJgxP1HFk0kB9r6PsGAy1CGMmMTIYdVkszHfioqGUGT0e1EBYPOc4oAqUqXaE/HaESCk8KVD2+4JK6kKkcRFF/jUocN1ejJzK21Jw6r34G9geidR8rOnY1SXUxslpMYRSy6r436ZC/wjfVXvfYTKWsHtlcRyKzdL4Io9wd8ktpqDSVB/zSdcuIoV2APkmDpgE6RZOWVrLus35XR05seAjZ+jid26uTrPNzWWPyqzR7MIuog7F+dE1ZZuRWEo+L7MG9rPw87+CIemrOH1Il07JDUCgPhLEXeQENPMyK89iftWVcPXpd0a0e6DB9P0bWx2iWHJMToUsN7g0zP831k2DOvaO6jDoXptGhY2WBdOtwxMPybjolL4fB/f9sVeyGvpQ730aKiyg27c0OllXATmTT2iLw/NEQevk5zrsmAaW2UXDVLGk9WobX8aOkjQx+7meoAEbpdo2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(66556008)(66946007)(66476007)(6506007)(53546011)(6512007)(6666004)(41300700001)(26005)(36756003)(2616005)(6486002)(478600001)(38100700002)(86362001)(31696002)(82960400001)(83380400001)(44832011)(2906002)(31686004)(5660300002)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzZZZmU4SzJOM0JyZWlZbThud3puRUtZNWFaOVdVTFlackpPNGxNeVZLMDlY?=
 =?utf-8?B?RFJMUEtBRC9iblBGMmMwb2NjdW5oTDBuV3hDSDJ4QWVzYks3ZXRLbHJIeWZZ?=
 =?utf-8?B?ZzJoM2dGU2tPM1lLSW5LVjFnQXZWd251aXhJVS9nRmVrWDBBUmJwcm05dFBN?=
 =?utf-8?B?cTNub0p2OWdialhDUVEwTzNBNkJQakZNNGJkeGxxNHRieWsrV0Foc1pCM2J5?=
 =?utf-8?B?eHc4T1FNOGtVUWRCNmhEeFZwNWNWU3oyOW5scjJJTVVITEhYeUxKZ3BiZHlG?=
 =?utf-8?B?QjBEZVk0WllHK215QmQyYWU3cS82QmJRWGdmbkpYVXZiTzNta2IzKzhaS3c5?=
 =?utf-8?B?OXZYZFRSQ09XZ3Ixd3NiSFIvS2RzeUhyQi92eVJBYWtEZjZJUGZCbm03emV1?=
 =?utf-8?B?ODFwZVh6R0YyQ1JsdWVPcTM2WWg0Uyt5VDNYS0g2dFd6eG92ZGNrcVdvODZP?=
 =?utf-8?B?U1p3L0tTdmVNZ201cW5WK25WZEM1d1RuM1pBdmwvcTJ2V3RaemlGWEo5UmJD?=
 =?utf-8?B?cUtvY3lqOVZ5M3dJYWRIVnIzenF4d1hBMEZPM0wyNDl0b0J6Nm15N1dYOUJr?=
 =?utf-8?B?dzVjSnY1RUVhYjZBWFN4VjFrV0Y1SkxCMktOcjV0NnZmbHNOZG1pTGtrVnEr?=
 =?utf-8?B?elhtQlB1WDdzZ0wrYXVUcnQyUDZUVGZ0eXJzb05HdzZQaUphT2p2dkQydWE0?=
 =?utf-8?B?YlVBZmFWNDZxd216K3hvekYyZTFuN1NtNGQ1dXcveGhJUWN0R29yNmpPUTVu?=
 =?utf-8?B?YkRGeks0bmdZRkNOU2k1c2ZFRUJ0S3B3ekVaNGI5M0wrUit3SW5Sb3pZMFN2?=
 =?utf-8?B?QTU0eFBlcjc5TDdMMExKTzJLY0VjMFFkc1J3RFlEWm1wWlZCQWVwdjg5OFM1?=
 =?utf-8?B?RTNiaEc3VnUrbDNjL05KOElaVGpVbTZHbEJNWWVqbHM2WlJwbUpCSllUb2hK?=
 =?utf-8?B?ZUJEZzBYb2hZZ3dkWm92dzBVdmpTU2JQa1NhcG9jOFY4Q05Kck9zTkw3dEhQ?=
 =?utf-8?B?SzBlZUpPL0JIa3psMTZNMzB6UzNoZVRicUpXK0YyMzFSSmhRNFQxK1BGSVA4?=
 =?utf-8?B?NFlDaytOTmFBZXV1MHl2ZHlzWHJadFNpcXZQV0J0Y1RKTHF4eUZ2SDdjWTRV?=
 =?utf-8?B?c2cxa2xOT1M4TzVyK1ExQlpYOHFVR21xakZuMEgvNElXRklxcmMrTUFRZVNN?=
 =?utf-8?B?NzNhZnU3VjN5UkE3SEhDOVcrWEJKTCt4c3Y4YnQ0SUpvVmxLNlNmUE1RZytL?=
 =?utf-8?B?SzhNK1BQOHVLc1JtL29keXRYVjNKblhHYlYxVlRrUzBSUWZVM2h5UUl5UStK?=
 =?utf-8?B?UlNSVkkrSzFqdlh3TDdZb0VqbGlIMHkrL0hrNHgwOG9tRFIvb0EreUU1VW0w?=
 =?utf-8?B?NE1nUXJVOTFmMlhObHBIVGdWUGU1b1lNV3cyTGY2Y3YzM2ZhTG81c0NCL0J2?=
 =?utf-8?B?QXEzZFRIcGNFM2hCZHZMSXRPaTJ3WVNicjlhTkl3cjY0QzNiMzRISFQxY3Er?=
 =?utf-8?B?TjRLY243NkpSa2RWcFFOcEZGWmFIUGwzZ0Q0eENidk9Jd3gybGtRYlBuZWNC?=
 =?utf-8?B?UExpWTZ1eFMrZGpyc3JET1VrR0hFbE12cWprRGVQODZVMHorWXV3MjlIQm83?=
 =?utf-8?B?d0IyYXY3cXI4U2ZWNUgydXBYOTM4MFlEV0gwQjExd3hnckFKWThlMTc0blZn?=
 =?utf-8?B?dm8zZHBuaWd5bzRRdUt6L0VSQzNya0V5Z0xNQlMwemN2cUpSRjNXc09TTUdM?=
 =?utf-8?B?akRoOXJ1TDlGMW5OZThIYjBlRDJuRG5WZDB4S0M3SWRqUm1uR1VRcjZudzk4?=
 =?utf-8?B?WE1wUmRjZjFIWmhkMDQxdkNPR2FlclE1VGExS2hhT1RubFV3ZFF2Q2NlTXhp?=
 =?utf-8?B?Z2FBQUFxWTVWNHo4ak5vWkQrN1ZzcWYxL3VmN0pacjE3ZTIwaXhsVmV0WGZG?=
 =?utf-8?B?eXZNQXFaMG5vUmU3aXYzaHpEWXNhaGYwRTJacGFBU0xtb01RaXZ6OTRzOStJ?=
 =?utf-8?B?bGxjM1FQTEc0cmNCQXFVdXZ3SmIwendmdlArNlhFYkNZby96QmtEY1Arb2xo?=
 =?utf-8?B?NHBNNFdPTUdYd0xsT2JnakVyeEVTajBNanBiZUVIalNSQVMrRlJjSEcvN2xt?=
 =?utf-8?Q?3BO/xOsJAz7DrAZoM3iQbQMmI?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da6812-b2cc-42f3-ea8b-08dbf704aaf6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 09:12:42.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct2RPMUD16Zg2FvwhqgrLSPldGeINve6INFnU4ajSpODG1BnaPdAQA3gEsBu2qf3VA6VvMuUTmfDgEP1ZynjfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6113

On 06.12.23 04:22, Richard Weinberger wrote:
> This issue was fixed a long time ago by
> 03d5b0b0083c ("cobalt/rtdm: fix caching and page fault issues with rtdm_iomap_to_user()"),
> later with commit c8e9e166b ("cobalt/rtdm: introduce mmap() support")
> iomap code lost again the call to cobalt_machine.prefault().
> 
> I have no idea why this took so longer to come up again.
> Last week, while upgrading an aarch32 setup from Xenomai 2 to Xenomai 3, the application
> failed due to massive latencies caused by page faults after writing to io memory.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/cobalt/rtdm/drvlib.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index 30455c3d7..620be27fa 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -1761,6 +1761,7 @@ static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
>  {
>  	pgprot_t prot = PAGE_SHARED;
>  	unsigned long len;
> +	int ret;
>  
>  	len = vma->vm_end - vma->vm_start;
>  #ifndef CONFIG_MMU
> @@ -1774,8 +1775,17 @@ static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
>  #endif
>  	vma->vm_page_prot = pgprot_noncached(prot);
>  
> -	return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
> -			       len, vma->vm_page_prot);
> +	ret = remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
> +			      len, vma->vm_page_prot);
> +	if (ret)
> +		return ret;
> +
> +#ifdef CONFIG_MMU
> +	if (cobalt_machine.prefault)
> +		cobalt_machine.prefault(vma);
> +#endif
> +
> +	return 0;
>  }
>  
>  static int mmap_buffer_helper(struct rtdm_fd *fd, struct vm_area_struct *vma)

This makes sense to me, specifically as c8e9e166bce43 didn't provide any
reason nor even mentioned the fact that it didn't add prefault to the
iomem_helper. Philippe, was there a reason? Are we side-effect-free /wrt
actual IO memory accesses when pre-faulting?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

