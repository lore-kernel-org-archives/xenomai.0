Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B985C52
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650816; cv=fail; b=qW3rP9z2vDLoC2YD01wZVd2gMu2ao6EDAvKxHVt/kipGlTpMJj151937fNMXNb6kBYTCHmkSQSsv/KLEa9x0azn40UQ4X+2OxWwbwmNn7AQSa1JqqeH98SSJaxpYq7KBhC7nil3UHs5tYsBPgkS9GJl0oUm8ptSiAQ/rI+UexBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650816; c=relaxed/simple;
	bh=Apy349u06i/4hBM0+fs2yZtaxcBF91QX//363vWNPmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=arRrFDqs2woM56t4bA+BfLb9HAz4w4ZRcks03M+iLR7reyt4S4UYjWDQ8eeOsSBBCyDRt4r5je6FvZnwCjtp+wp/TleWnJwNeYAWaMkjZeiz5a7RvnRfRkZhE/LRSkd+i2UPJ2chjyvtPcRBm6qHXFAlRyW8wqSoAH8FUum7SXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ofAk+B3k; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ofAk+B3k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY4pC3hYGlDu2iEIwIE8CfjcvD2JgVpOaffBfVY/ijRjF9EUsPlKwlze6rusH8+WHQGbDsP5nMlf259ukQyeu96pin8luVoWSNCsIIYMLlTNL4sYFKs2EiDsRzbjbE6q2QGtnknWum7Byj++vpckstieZCwefq8rlcHzsi1IOJUUx0KqQ+llQm2zwt2eH4eXM1gBX8M3ng/0/htSPem7pMLrlfT1AEmd97IzPa3AwRp9DW1uSnpDIgytRq96Ft65AVIqrLx7x12siev2pjH+5MRxWAqQ5UUYGTG9HOCoXMIs2NxhIwVv5gnMX/gGP8s2dtH8WZmIk3nh4Q2Z937IlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx366WYs6aezl60T3+ZULNX2vu8SJlOgMV0FwptY9Ew=;
 b=jPPlsCq9RTtwXfPszRenF5Top6kZtru5/qTxYsfu7fR5OwNyYN1mqHP0mE5V7L5qPQjy0fNuicyxyxB3NT1gNu/0XnJejLBdm5JZ6gwmsKRP3/lm98ve2AGWD2WkIva3iqiFGkMeXG12H8/iau/HuAPAH6dvZOJRQiaMAP1bHHkYc/zSv/brD30duXf3roVogZiamEaWPZ1z+lLjNxP3YUGEtJqOYtbuhxd/cZohKII6JIWiFTXn95b1mGIpzG+soNaO705H8w/XwspIdkxLvxxPxPeVIDv+g6R2rbjYuT9hO38rz0sgs4jZQcN7xbpC6I2y8kDFXa011dmADMR2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx366WYs6aezl60T3+ZULNX2vu8SJlOgMV0FwptY9Ew=;
 b=ofAk+B3klMe7XxsNN9bB9DhGj/6p1h5Hgp3XGRKh5I4pgoLeh3abNe9Qwelkq+GLyLcGyCVupp46umOTJmDUHy5lWLht8KFugbHDpJ0SPlAohs33Fi2ya61uZcZcm3VMiBqAwTlmWhnEgB/EDmukaKzWiNuLemxiS0ZetJxfLBF5ptCp+210jIpsLz77dSPaSk9Px5aqQxl/IKmn7GOv5pb1bsUqzlEeSEi/V4oxsDrer/XP6LSUT4kqT+mnOUJY2Vlc8GUB9TecEk+lhJPSxfACXr0VkhpDKrzNh50ZGHd7F1vEeY7deo5YvI72bU9jSokyyYKx96vFK0jQnp3PCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3532.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 15:00:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:00:08 +0000
Message-ID: <5501876e-57cb-4b24-b83f-815f3ee1cf61@siemens.com>
Date: Tue, 5 Mar 2024 16:00:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: ARM64 prefault weirdness
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
Cc: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
References: <CAFLxGvzXWdySKjXmWv=onYk0urPzkn8bxWuvoFEmLzLyuQTj1Q@mail.gmail.com>
 <CAFLxGvwE76ud4K9iE-Vh8XOdsePWC7JPuearPxZu0omGTFE=ww@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvwE76ud4K9iE-Vh8XOdsePWC7JPuearPxZu0omGTFE=ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:610:4c::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3532:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8d5806-54db-444f-62b7-08dc3d24f2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	knCa1paFkPG/Fsex1/KTN4Av7pL9ahDUK+LxZMywk7RSE1jh3GWdgG1odE+nqslUxbv5eFMqT2IZL9rBVfdGFUqUBG1oATguMaO0SwoXmdgUZMMXfvrFCUDQBTkvxGERkJ3DbQla6jstAoEeF+S8e9s+WC7AJg6jFkShexGtADob4CV1aFkwLjFqdzBBEG2uLOPPGEkE7glx/hDebfv3pONinORwJR4vwB0uhAyJeqPkQPYGJ50DzkVthQAvbZexCLBQBAwdudEH2fHKbe6VEXAS6DFikLLmvRBEkmQqpB1P02XA6sG5MlyJ7zE15gUdDuI94HlBD5QbH9dFyBq4aW8LNDQGq606Yz5gQBtXFH7o44UHeW/ztSwtxpAvXpClTtVXc66dqZjnsR41ftOU3SwRGCulKZ4lr/4rUPFEHUD+OYLwaKjoD6uamhQwPFjwoVOfxVYqGqJhJjUunmNDJddX1Eyd9dyUGlFso+xa/6lkDwRaubNNkRxL+b3kXKeDCPAUkPLILb716Fg4Sb4DKqH4uVbwZw1dSkfbdPCr+E+i31Me6ppmpYW3oZE+pwW7ilCuiPm7rihgmw6GGTuWvmAgdWiWxowkhqXuRpcJOhuv9xejd2GA4adWtDjaSnX8adl8uZ+ynSimKHSeMl2o/d8PJwuvUqHRJWbmRm2654w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHBCRlZ4WDdMWXo2anhlaW8wQXg1VklDQ1BPMFhvU04ybmRpeWtGVGgrSEhS?=
 =?utf-8?B?M211Um5lNWEyb3BRbjJHajJudzN2dWZNeWhPTWkzeGVLOUl1WVE5blc1Zlgv?=
 =?utf-8?B?MTNKbnQ3SjVVdXVLSU9oSkpXQlVTVXpLdXJjNmhyWmgwSENZaHpjYW9oZGxF?=
 =?utf-8?B?aUttM1MwY2hCQk1zbXBDdEZ0UytTTWlCTE11V2JJdlhYR1J3NUtRVWVKR0Ro?=
 =?utf-8?B?NHdKa2ZvcDh4TEo1QVBkRVBVNVFXUGVRdnFPMEZCRlBhckxJeW01aEJqeWRG?=
 =?utf-8?B?dWdzZjFDdzV6VUNhNGRLV3ZCL005c3lwRUUzTGQ1ZDRBdUxJazVVWWJENGlQ?=
 =?utf-8?B?aDQ2YUpvOUQxZ0NORVEvOWNVSVhOUXZIOWN2eG04bnNNVFdmeWxmZWpaNjUy?=
 =?utf-8?B?TFpvNzJiQVN3SmJodUkyMmQrYlloRFA5RDB2S0I0R3lYeXAySHZTVm1GeUxk?=
 =?utf-8?B?aTl5NG9JL0IrMzQ4R3poNlF1WU1NMHRxUXR0ejlYeGhqSi9WNlh4T29ad1Vz?=
 =?utf-8?B?eWFWSTIzZFQxdExTT20vd000ZDFoQUp4VzZtbEpJSkdGaVV1eWI4bTh0MjI2?=
 =?utf-8?B?MEJGZ2d5aVV1WDA4UHpML253anFtZ3NFNTFPajBBeElCNGV4VHlnU3hMMHBi?=
 =?utf-8?B?T3FCa2djTzBRdEViUEpkUkMxYjZydTlkYUtiUCtVV055THpEcnBFUlFoL3kv?=
 =?utf-8?B?WFRVNmxGU3NqVTFQVUtEOHRvcDdCemtNdDR5QVhTc1V1V0U1NVFqUHVsQUds?=
 =?utf-8?B?R05UMHpxOW5LYzlsS3k2MGFnOWJIQzd5NlA5Vm83a2NRclc5WWxjMVBvMm53?=
 =?utf-8?B?VUgrQjNPWUc4Uk9rTHZxdTVHVnZ6MFlWbk8vWEN0Ukx6WkhrTG5DUUM5R3ZB?=
 =?utf-8?B?NkZTUWpkYkJ2M2dER2J4dGw5NDhqWVRQYkgzbTVNYVIvaE0zdHlUWGhNR3dD?=
 =?utf-8?B?N3IwTWovTk45UFVlQzRHNDNqNEtaRWk2citPUkdDMnR4cDRXM0U3VWlrckRx?=
 =?utf-8?B?bjZFbklWUnE3WkFzZk9KTnhNRUI4L1JDdXJTTHgvMU1Fdk83eHl5QjhPb2Rn?=
 =?utf-8?B?eEVPR1M2bGl2QzlaOTM3eDVmMElCVVFIUVlYVUhzUzBpV29MbitHblFZQm9W?=
 =?utf-8?B?RTliT2FkVkxIZGgwR0dsak5pNHBBalM4K3NIQ055QWJtOXlEeW9uMVcyLzhD?=
 =?utf-8?B?cDJwdk9nRFNFS0ZJRjRxU2dROTViY3hrcW56TDl0RFF3eTJJVmlaYXdEQ3c3?=
 =?utf-8?B?UWtwUit6Ny8zT2hNREpSak4yNkVVTW9GbFJpbWhVMGJ3Vm9XS0RScDlLSEtM?=
 =?utf-8?B?WnVybmlCdzE1dVA2cjJNSDhVMGdkZkJ1MmVQUFRwY1hJRGMxTlVWY2xmdTFS?=
 =?utf-8?B?UlhQSFdzakY0M1NVYUpuaXpMUEU0by83VFl1MTBxMVlHSW5SVExsZDNraGIx?=
 =?utf-8?B?UkNlZnYvcGVTVlp4YkJzZWV3bnVhZ3B2S2UvZnJmeFVJcW9vRGNLMXFKbFhD?=
 =?utf-8?B?b1JveXk5L3JmcEo5YnNLTUhObnJkbDZEYlpnWE1jSU56UXorT01kdzFvVXYy?=
 =?utf-8?B?YndsMVhZVk1qL2lHQTNWVE94V0d6T0Z3UkljczU2eFp5R2lMNDAxZTl2SW1j?=
 =?utf-8?B?Z2YrSG5TbEU5R01ON2pJNWlnckdURTQ5MHVUeWIvbHFiWVNNako4WGZQb05U?=
 =?utf-8?B?cUd2blVKY2JQcGM3emJGUVRlNGUxWVVPWUZNaGxWdTZPTzM2eXZvczM2QVY3?=
 =?utf-8?B?bzFRaGthVlc3OXBtaTVoaXdrUzMwWnFUTUFWMzJpdUtmL000aTlaTS9UY0N1?=
 =?utf-8?B?SkdHT2Z2SFFsQ2szMkg0dUp2UWRLZDlYeis4ekdEdWE0WDFhWkt2TytjUjh2?=
 =?utf-8?B?MllBNkZmZ1c0UnlZcW9tYy9qSXB1NHZsQkh2RWtQUUhoYStEekhMNEVoWEFL?=
 =?utf-8?B?YkZYVTRadHdIbi9rOUllaCtTUDNObGZrTjc4cE12MGJmaUNHOHQ1a285My9k?=
 =?utf-8?B?SWhSaDFzQ092azZMSmVReVNTaHZYbVZ1Qm5OUWhzVHlyb0NWZWZndE0veHo3?=
 =?utf-8?B?ZUVYL2ZCMVUxdzNuc0N5Q2k4ejhhaGt6VEFCd25QcVBKb0FaSzRFdkVvS3Zk?=
 =?utf-8?B?bXR1d3dmelphSWVVMmRFbDJVWnN4ZGVkUHJmRDZJRjgzRjl0eEx5Q3RPVWJ5?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8d5806-54db-444f-62b7-08dc3d24f2d6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:00:08.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCfr7QYP3F8Sn5o0Kh1NHAmlLYMu4FKT0RQYWgg/JZZNznrfZF5k7IEFzorni1SZvRsXh4iKdzxdXZOzrHJfHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3532

On 28.02.24 14:44, Richard Weinberger wrote:
> On Tue, Feb 27, 2024 at 10:24 AM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>>
>> Hi!
>>
>> The more code I read, the more I get confused by Xenomai's prefault code. ;-)
>>
>> On Kernel 6.1, David and I have the following situation:
>> 1. A kernel module does vmalloc_user() followed by rtdm_mmap_to_user()
>> with PROT_READ | PROT_EXEC
>> 2. Arm64's prefault code triggers VM_BUG_ON_VMA(prev != vma, vma); in
>> find_mergeable_anon_vma()
>> 3. It triggers only when PROT_WRITE in rtdm_mmap_to_user() is *not* set.
>>
>> While playing with David's reproducer I discovered that even without
>> calling cobalt_machine.prefault() I don't
>> get page faults in the RT application while accessing the area.
>> rtdm_mmap_to_user() calls for vmalloc'ed areas vm_insert_page(), so I
>> guess(!) we get there already
>> page table entries.
>>
>> Can it be that cobalt_machine.prefault() is not really needed on arm64
>> for vmalloc'ed memory?
>> Maybe older kernels are just more forgiving and tolerate unneeded
>> calls of handle_mm_fault()?
>> The VM_BUG_ON_VMA() assertion is also rather new and you need to have
>> CONFIG_DEBUG_VM=y,
>> maybe nobody noticed ever.
>>
>> What do you think?
> 
> FWIW, with this change applied I get no unexpected page faults nor the
> VM_BUG_ON_VMA() triggers:
> 
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index 99d54f58f..c2061b776 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -1721,6 +1721,7 @@ static int mmap_kmem_helper(struct
> vm_area_struct *vma, void *va)
> {
>        unsigned long addr, len, pfn, to;
>        int ret = 0;
> +       int skip_prefault = 0;
> 
>        to = (unsigned long)va;
>        addr = vma->vm_start;
> @@ -1740,6 +1741,9 @@ static int mmap_kmem_helper(struct
> vm_area_struct *vma, void *va)
>                if (ret)
>                        return ret;
>        } else {
> +               if ((vma->vm_flags & VM_MAYWRITE) == 0)
> +                       skip_prefault = 1;
> +
>                /* vmalloc memory. */
>                while (len > 0) {
>                        struct page *page = vmalloc_to_page((void *)to);
> @@ -1751,7 +1755,7 @@ static int mmap_kmem_helper(struct
> vm_area_struct *vma, void *va)
>                }
>        }
> 
> -       if (cobalt_machine.prefault)
> +       if (cobalt_machine.prefault && !skip_prefault)
>                cobalt_machine.prefault(vma);
> #endif
> 

If prefault was only about breaking copy-on-write early, this would be
fine. But we just readded it to iomem mapping helper. Something still
does not fit together for me.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

