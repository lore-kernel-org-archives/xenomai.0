Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A71A58B
	for <xenomai@lists.linux.dev>; Wed, 14 Feb 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920846; cv=fail; b=r0+QE6maBM+M+SyR85V2QBOLAZs9zsF5UZuWJGYF0cqKHuKQcl+O0SjciGBAi6UimTAHfN4R2pJMJnGiwG+2ok+PVH+2T1BNgqTgs/YQJav00o7+CGeEocv9tB6nS9EylvkChpOik8WORDikXU2Bka//s/sty5AvxCthb6O2rA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920846; c=relaxed/simple;
	bh=JPZuka9Khs17lBTMIy/7NPWg5UEUGFyAkidMnOJ/X/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BMvwat3rRCu9RC3uzZfWPTKCmzBDzWXfGN+WXiLgNi02BciIbRze1TIfQUh0+ASo8DpsChYMV6DA39FDLIbhGDh4NrW96DmnYZomBN8LOo1iOvqPav0fKsoRB2iXp8uMno0xzCDDGrSoWtSh+pcCKb1EoeQJd9xfX6wvyXN1amM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RAUQymUl; arc=fail smtp.client-ip=40.107.7.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RAUQymUl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/xCpwu6cq0WL6hwOi6PQQnqBYnkpFJEgBQY5CWeVxhOHJE6XhqTThTLtMH0nAJQb4gDQHaialwCwT+nQ+ECdhVUqJPKdp4V9i5R9JmeZdolk2wZ4uFIfqCF9SqpWvNwSRoU/80L1P+pPc/udnFHFF8/fveXPFMf0Q9O55ywV3RvFH7bzDJIEUyioItua8QbnYH9KcIMbzUdq+VI5kkS1F26RVCgS7V5GQdIpOjn6IZvAQTDfE1PH77f4GR4t0Txt5JHE7guD+38KFJeDuE2uqyUr4vO7BOJrDH3JX1cBQJeq/OH7HVGbjYQxAhRPz2nXOewZA5/WYrFNceY97edEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxSSImycD06ZjCRuzcv1F2xBXtl9zer9uxhYmTE6//Q=;
 b=ODUIFY/Ykg/lpXT3opAKF2H/pphMpRAuskqphWZZ2bfXFV3RMZHoZM8eULm4IAYcnriveogrJXf8LU210jlFrXJdF/DV8ZbjklVEcWrl1wQMxZszbJpJzDD6t7v6Zq0zYgZ+IEbbJZI8NPYLMjvPVeannxW+fLGHSqCCPuDSr0GmroNuRq3GhRaxQGoDkrNiwy9xwctGeE5MvxgP6BRQSrvYMOe48yKIt9S8yLSgLxnGcX+cdNNHNroz/eHIpkBVzY6ttnAbdoS1OsB++U32+62D2p+l3UjppjYXQ8kFrEeHMY5zJ/fSTjxgGws0WKZaC/CDcf+loiyBZ3E4xp6y4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxSSImycD06ZjCRuzcv1F2xBXtl9zer9uxhYmTE6//Q=;
 b=RAUQymUl7xqj34ZGrlf+DzGGbPBYah6Vbf/yNfmqX34d+gje87US8DYxOMKpwJoxBcEXaINByA7TVp3fZNF54BI5ViuslnKiOjznE5LejfSB9AbI+cgsEG2F8V128yPNvKoEJVqNcIX0ylzx3fHZ8CoWLe68bVUu3zpY9RAs18me4ziHe7nAtg0KL0aicjJ4cLOVyOhP8RUgOuh0bMGdOx7l2fOjyJ/+LKkoRkd3ZjethYxh/k0dfB31hOiw5ng8mwIq7czGE2j0tpGFvkaKlX/03mh4ZJEbH6iOlbpLW/d/dZaiuvdxBs8LzU6xADBObYj55RBwWyvauOon3V2zxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 14 Feb
 2024 14:27:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 14:27:19 +0000
Message-ID: <58292771-181f-4b8a-b8bb-6ae464c5643e@siemens.com>
Date: Wed, 14 Feb 2024 15:27:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/drvlib: Prefault io memory again
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: wg@denx.de, rpm@xenomai.org
References: <20231205202210.25477-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231205202210.25477-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb91db2-cf90-4d3a-2a1a-08dc2d690d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4cPO5W52fNmazsfT6ZbWc+VGOWjUlnfN8C83uaEDqEQiF876LNzHjwmFhkTIf5RIQRhDJg3/no1LJoVflaa5zKhoxxdlwcRo4LeBHp2OTlYYzNCJChSRnoRIwYcZIpKqMAQCSyQnM8DbZy61dGBhGmAFG+hh0rO+QUYEOUliIIjzluXRrqRF43uZa4o0Pjx3KFEoh1iTRaWN59obwvUkCk+LHdj03EGTXtVRKiOpAKjUKwP7AUqYDyRg+WF4dvffNMYOIMZmUIdKvDCcDS0vAFIBxyUbxLXHYnvzdiRFp47gYhMm0d78gEmVWlwmoBN3ronZXkMs4AHydUKSEfXJZHdWxjUc471x2dCkFRPhU8kUIT9BIuj8X5lbxjUwIlunmdUGs9MsUHygih1LSVVM1PMS9lka+9nqBqaQFKQaIV6HG/nIaEafxTYqcWw2C3QKDIDSM7Iqy9+6aWpufE+B+nrRCUjqmeXlcWXcRsI+AdIx/R1iB4p7Lm+dfA+/RYPRM/icJbvcM5OyFMmRG38+p8jxx+8yXXBJeFPQhDtBeti5At1jOL0Crc3gnj8PCN40
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2906002)(8936002)(38100700002)(478600001)(6486002)(26005)(5660300002)(6512007)(44832011)(66556008)(66476007)(8676002)(6506007)(2616005)(53546011)(82960400001)(66946007)(36756003)(316002)(4326008)(31696002)(83380400001)(86362001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mnlpcng4UVpUcGoxNEY4Rk13MGp0V0lWRUpHU3NQSEtZUWViYTUxT0RrK2NW?=
 =?utf-8?B?elBObjNZMWc3TG9TVzQxSUFUTndCR2crQ0dYUUJvUmo1TlR2WE1yNEp3ejVC?=
 =?utf-8?B?SHloYUJyZWRERHZETHMycEJnMGYyZHZaYXVtclE2aWNUaUFTcU5TYVVqVGpS?=
 =?utf-8?B?VEl6UmJGREdJN3hITFZaazcyc1FqVDU1L0xHdzRqSDVCU2NUUUxMZ1pPeG9L?=
 =?utf-8?B?VnIrTHJ6SXdHU3pSSkU0dGY3V2tpVXVvR1k0c2hkK2xDYkZ4QWFtRWhhMEpD?=
 =?utf-8?B?Z0N0Q2xBRXZwaDRyK1N3SWFRT0Z1c0E0Y3h3OUZFc1dxSjY2RUppTmJoYkd6?=
 =?utf-8?B?OWxRMVFlWGFXVEZNN1ZEUTZQK0VFTHdacWpra2J3Z1ZIV0lUMXZ3dlZNQ2dn?=
 =?utf-8?B?d1RNZllxYmtGNmM5SGpHVkZ4d3JoMUdNNVZveEFER3ZyZ1IvRGhkRlhuK0kv?=
 =?utf-8?B?Z1BQeW54eXhEL1BUWkJpYzdLZ3RDcjBPWFN0bEtab3BwREJubHFuWGEvd2pm?=
 =?utf-8?B?OE1iTFJzME1uNTNWT0hEc29WRWs2QmtwbS82VG1adlBxamZwQ0JpMHpDbExp?=
 =?utf-8?B?KzVjWXNiL21QYTVCZWUyUE9ma3drQUlUV3V1OFpuM1FHNi9ocS9wdjhyOUJu?=
 =?utf-8?B?ZEYrZDkwWnFTUjQyb0ZoUXMvZkJaQ3BEdUdTRVl5SzE3OEdxSHRpeU5kRUlV?=
 =?utf-8?B?Tmg1YUZpZjBQUS8raEhsOXllV1R3SUhoZW4rWHJjdm9QVm50VkEvMmxDY081?=
 =?utf-8?B?Y2tZRUxMdVYxdndZY2tKMmFFMzBsd2J0YTREanFRYnlaUDhRaENJeml0Ylc3?=
 =?utf-8?B?TzhtSVhONEJ2YTIxWFRXa3dWbWRjbjdBZ0VEcUJIUHpTcWRkUVVRNDBtV3RU?=
 =?utf-8?B?alhPeGo2ZXpoNE5kdHpkd1N2RlluYmdzZnVkNWtVZm0yMSs1MzA1VEJYYWpv?=
 =?utf-8?B?NzdMMlM4TldtdURML1cxamluSXFmWmhVSnNrQXJ1Y1FGRXlaWG8wRHV0RFVJ?=
 =?utf-8?B?NU5XWWE5cUJQdk1ZdTZ3dWFVYTFteFROdUw4Y3VnK0djYmtwQjZmd1cwWFdY?=
 =?utf-8?B?VG5EWEFqeGZ3Z3RkRnZZakdxUU5OV0NPRkZTdGNoQjJiNDAyMGtKZ2Mrd0M5?=
 =?utf-8?B?UzNDWXlsSUMrQkNXRXZaSkJiWDBJSlRzdlZuYURidUo0ZUMrelVtN0dwZUZJ?=
 =?utf-8?B?TnlINnpFNUUxZldqcHlLeitzcHJTMmdlNWVlS0xxRUNmZDJMSm5scGMxMFR3?=
 =?utf-8?B?Mm4vUUJDTzFyb3RockEyVjc5d1ZRNmkzYjJoV1ZHa1hMaHZRM1VwUjJpemZY?=
 =?utf-8?B?ZlFLMit2U1Jsem5UYzBjTG10V25rVjRmTnRnT3dKUExDcnUwWDNWVHlTN0xu?=
 =?utf-8?B?cERoTkRzR05aczdrSVZtQVBnbzFOVVVLVzZGVW9kVVFKOENwZkdoeDdUaEo2?=
 =?utf-8?B?M2dKSVZScU1OOW5PUXhXejljSmx0bjBIaFN0OXFWQVRSazBnQXRCMG16Q3NZ?=
 =?utf-8?B?Y1FEa21WS2ZPaGJCVTlGd1RWblVZdGd5MlJUSit5VWNxQlFHOVVlMEp6WEI2?=
 =?utf-8?B?dFlYQm9TQ01NblNuVWdyc2tYNUhRbFJlZ2d5QXdpenVGV2VkYktGSWhqREI0?=
 =?utf-8?B?UStiVUlCaWlWYVpiNFdCb0dBTjRhRHhuTDZpbzFtT29mREJOa09kR3ArOWdY?=
 =?utf-8?B?Ny9jWHJNUWFsYXQyaXN1NmtPV1VBdEtuMlVzWS9Vcjc2SWxvVExzVGVzWkw4?=
 =?utf-8?B?TDcvOFpxWEwwbG9PSHA2dGlzb3lFZjZERmtrLzdJb201ZlUzQWZueUpoOWtv?=
 =?utf-8?B?bDBrbkJEOXJFZG5ueDI4UnlaWlVZL205S2g1Z1pzWXZQcnVQNmxPZEJpeksr?=
 =?utf-8?B?WXFQSWN0b0VydSs3YVIydXFHejByeUVtZGdLU0hBSDJLWmZhREFKK1RLYjQw?=
 =?utf-8?B?TWdZWkxpVkJ1VFZZZkpsUEN4ZDNQWkhOWlh2VFVGQWh0VXZORFN3bFlXdms0?=
 =?utf-8?B?K1loRngyNVNWSE1ET3pwdTVsVktPZ2g0UG5EdGY3YU0vWSt0eStCTVg1Ujlz?=
 =?utf-8?B?cEN1Y085T05iNGJFZkV1bnFzZE1HL3ZkQ2FmNUxFRnh2eHJHd1lQN2hDNTky?=
 =?utf-8?B?T3Z3bWt1d3o1ckhjR2V3Ym9rNEY0RTA0aHZHcHZBMmtFTHJDOGV3UGI1TW5k?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb91db2-cf90-4d3a-2a1a-08dc2d690d22
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:27:19.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gaaf3KnZYo6YLulI8nEn+CpdBjBwhUzsFA4FB7MKEwSIR6V9QGbnl83epgKyqY9XY0KZ3vuymGel382VkjuDbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5932

On 05.12.23 21:22, Richard Weinberger wrote:
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

Thanks, finally applied.

I suppose we also want this in stable versions...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

