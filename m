Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88442D760
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557861; cv=fail; b=OBhQJg0xIs8Xi0RsDcm8OG8WsCT+n82uOj7MBWtQ90KBvJShwsJmnoDR4B7TQfUqUD6rogU8Sga+OWjt0d2881XQehUgZXkN5vh3YjZFf7KRHBuEpjoJ1jgU6I1xKLiEgLL3GrjSYbhUUn176StFPNgA+tb8xr3fSnHYEdURdOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557861; c=relaxed/simple;
	bh=6+vfm69azaQUA30eaFjNAZCMc5e8OeNssXp6LBSy23Y=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=nS7cX/87qwuVrVist/NerydcjtEyuqqChoBcovSB+h2KN8DKH/t06ZxL8vyDgLDwU8PUcwBaa07Y+iCqqxobhHk9s/IrXObZS0bXRELH2p4UQUUIUjbApefe9AZ5YJrG58g5dZ7JFaPFUpltODe7TiI86VcwQH/RuvE7ZLndtEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=R1evirt2; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="R1evirt2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpQbA1uIQOCgh2/qDkD96zVZNzr3maunY9pQLUxMSpJC5UZwo9nyuQG35owUswV9oQTd10YTOqDRoUI7HN/tS2FONsicPAJPckfCI4xPHhcfQdwViLRUkfjeMe+JCtUFBJC0bJHXBKiqswmcwzlpMMfhQohELhg/W48T0iPFmIYTll9pPT3cVtcC22qjNWzaTLEEpwsDoSp4fioFMRj+ckpWIX0HDd1GzwyIP+BRETxXZQCkiEQtd7Uz6MuyfRYJO00Kd1o5LQF5by+JdQv7ahawJ0n/dcRwjp7a6s8TN/r3snfzMGhBGvMPbq2MOnMQLONEEmae6c5hY/+R/Qb3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpuW/mPjz7S2cyS7Hjm5d1iZ9zkVdv+DWJx1J7FZIa4=;
 b=LDHdpXHMtUYezqVfpJ94KUkHs7DjGCFWiNUZ+7Rk0ThqQ/Eo1kjCXM7NU2BCT6zkf1ME1876+MoIaiXK0QCZ4SmyTknXKg6z6r+pPGcJJUgZ32zcVAp8mzGHvJUV2rLPTAxBWqwyxPVDROWhSjuVpOJ2RgoxPj47+1AV5xKS/L4rTx7qDA9usqBcrK6ON6wS8fW5YbAMzuVFdheYm7E/rjIMVIKqGl43M5LMMVqETzhG8U/Sz+qjwez+cmulVYDUPDI4MJJrM3K16dy6p63dXThFMuWAA6pB5RsJzTTXUTt0EpgMKcUXsqgDKTFZhpNPmEeeCMl3mPEpY5c42I5XAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpuW/mPjz7S2cyS7Hjm5d1iZ9zkVdv+DWJx1J7FZIa4=;
 b=R1evirt2PZ4K3dSy8ACtXimGBdx9vgWTJ0bypCtD5WlSEP5N08pUjHhrGyf26/yi3RCXyAJF3nK/ZMNHpzMa/QfeX8koTbipgtgupSXD+JnF2WBpZrbScgSezQNo3yQzi6rdwiiZ10Tg1tsnITw5HRQG1hhqzYlx201zdAQQ51vtbFRbzDKiKrFuIB0svl5K4V/PIY9YAimutab9YCGkSlpYCfxWbldRzbtyeLLg8R++o6sONaw87Ox7xM9UyDxdbQeZ0jZQXlS3sLwxBftows3JIG7nxgZV8w5Q+6662AJjUpTkSmb8RLt5dSqtqNDxfm0vrnUWRLFHc5MrL1A0rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV2PR10MB6359.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:30:55 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 14:30:55 +0000
Message-ID: <60f4470e-cdb7-40a7-a73a-9bb6d4a10ebd@siemens.com>
Date: Mon, 20 Jul 2026 16:30:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] libevl: Add debian package config
To: Hannes Diethelm <hannes.diethelm@gmail.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260717205820.8359-1-hannes.diethelm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV2PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e738b2-a109-4a7f-33c5-08dee66b81bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|55112099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lZwPiUGeg1DBo5zcZkDfulLEBHp7kYXgbzhIEZiZupaadAjaOvgUakZd7o4+arlQOULrcDfJiDIyG9B+AuKX/G58rSL1DH6wnaZ2JU4I9K8C5ZJ0HL5UNrQhnt2+GCCdzIqlH3UBn/wMB/MgD8SLwoQdyLxKyk66DQt8k51qDjgJn39VrmVR7uJfswkrlukJfEt5BbT82TpDq5qOS8ZCY+n/iV6RblD8nBEwZ7pQKLA4QeUAO1Wse4HqOeHwsTWf5oyQ+2SxJPrd4y+eQw9o4PYBTVbp/I+lwFwg7ZVqRdMsWYVca2fRvEyg3sn3ZKlEoz+4tKC2AqWU/RwXCRgWKLjF+zlGsDnOvL62OQd+yulS5qdqduHYPiodUJh8T1x3+3uMWfN/juZHEljMf+BRHPIbb4iC27lIpAxRcYc7POQmfrBpw5W/yQSMEacxUABllInzfJDnLzLRKSVwGLEa9z5B4pyo1ULYDxX911DeH7B3EILFENDp6RPE7f0OqAk+Zq06hnckSkoqWk2YM3AwP9aYp3zW8vhFxDUlHDhBA2OIn76Si3UUjnzw5yCNXadA0OwDDiTlxRVBnyvHC1DiO7skhlh+RiIWBSANhWfUrFVAmeRi2lZKclsywSLZk+ngoOa7S5YzPeJ7bnI4BgKT+ErQUnlep1SaaFs/BxJbMuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHBnU3pLMzVpOUlnZnlIWlk0dEZYNHFQQ25vOEhQaDlIZmw5UGREY1h3Y3dm?=
 =?utf-8?B?NFFoeDNiZ1RnNi9zNTJQK3dGcEVKTUNyUFVleCticUlqVGU4NUF3R2hjUE9W?=
 =?utf-8?B?S041ZndrMm9Ca3lrMnhRT3VBZWd3M3lmSVNhSE93OHRDbEwvbUZvaElsTm9o?=
 =?utf-8?B?RWpJT0RRS2M3MjY5ajA5Njl6WHJQdGQvYmRnOUlLQW95cFB6QVRqaFVxQkt6?=
 =?utf-8?B?bGo1K00zZURYQmphRjlwZ2F6YzJZTVVaVzYweHBoZXc3QVJOR3BLMTRrbk5W?=
 =?utf-8?B?elE4NS9wV3RqTjQwRXlHNU9zM1lGeFdIdDVSMjJRK3VETXBDY0lKM293YlVs?=
 =?utf-8?B?VFdmWnpTclJ2aWJ5MzZNazNGYWFlRVBFQUdXU2ZZOG1EUC8yM3BUK1A3OXNq?=
 =?utf-8?B?NG1qKy9MY3JWeHk2bVgrNkFwSXlsMDlPdmdaZHFHKyt2ZU4vcFJ5QmhkYnhR?=
 =?utf-8?B?bEpOZ1BibkdnSW1UMDRkejlkNHdmNFJ5c2lpZ3ptSm8wNnBReC9Xa3Nsblht?=
 =?utf-8?B?a3NKUDgvNW94ZlIrTmlzYjFOZ1Bac2pIanFJZ0h1bStvb3EwNXZnRllrZlJQ?=
 =?utf-8?B?b2JvdXp5S0dQdmpZRHphSzlNSXV1WWFyK3ZLVjJ3QWpadTZsMk4ySHZKUUZp?=
 =?utf-8?B?eFJoM2dKRVZlTzRhRmJ4YkxxZEdVMXJHcG4wWHdiR2s1SkZmU1BhVkxhT042?=
 =?utf-8?B?MlUvYk9QUjRBQXBycnFCVUFXbmRybFRNWnRlb0ZrM2Q3MVlKOVBNcWV5eGRi?=
 =?utf-8?B?c0JDeWlVTWRINHZJTzJtOVdrRWlidWZnNko1bGlXblJFRDFTYmlOLzlRU1c1?=
 =?utf-8?B?bHA3Zjd4UE1Fb2pUSzliV3Fhci9aSDhtd0crektudVJrczZrKzZSTmY4b0RM?=
 =?utf-8?B?U2VNUTg5L09odlgwVFJmM0R3R2VTenVEeDJRV05wYUhVZ01uVkVTUjF6K3lJ?=
 =?utf-8?B?L1Mrdlhvb1VCd1Q2a3VWNkRIUTZhTnd1R2dSdDliMVpDdmpabWw3NmhlUDlo?=
 =?utf-8?B?bDB0NkJDUDkyK3Y3aFJFT0lmeHhuODkyT0ZKaVJ2clFWUkZLUm9NMFBzVldD?=
 =?utf-8?B?eklaMFRSUnRDTGI5U1E4RTFBSVFPSDBtdGtyaVREVTFUYWZBRGQ3QkF6N0U5?=
 =?utf-8?B?UmhaWFhOSGs3SEJueHNCSjNqRGdZOGhjb1RtUzhSbSs2bXB6RXJDNWg0ei8x?=
 =?utf-8?B?S0dNOW9lM0ZvNHdEaFBZRmN5TVdKODVQS0JvcnphYnlRdzdMNmkrdEx1YVBN?=
 =?utf-8?B?ZjZoOWZSSHpMb2s4SEpZc3ZseHY4QmNQMjZHM0pzMytWTlJwMEtybDRnZ2hl?=
 =?utf-8?B?K2lyZzBoQ3lPSlFjLzlsbERkS0IweGQvVk93cjY4eWgvcUpETHEweUJKa2dh?=
 =?utf-8?B?bXpQS28wVktjdzNDbnVFQ2tFck1BTjY5Q2FFN2RESE9ULzJLVlk4YUtsRHVm?=
 =?utf-8?B?bi9YWlJkQ0lLZUl6QzlJcUdIbHNHTzVYRWdDc2x6Y2hVbVBFY1NtZ0dIOFdq?=
 =?utf-8?B?cDF3K0pNcmdMMEZsc08ycHhzWE1JYkZsK3dobWNWaWlPcTRrU3o2MVBzRHpB?=
 =?utf-8?B?NUxObjduU0IzaExDT3dYNGhyanRVV1pFSmVkaWt1MzlmYjdjbkg1Q1YvMGR1?=
 =?utf-8?B?aHpkbHJoQnRYbG0zV2prMkFUQTAvVHJyczRWTDNRS1BGNjBYaWlIdUlnQm5C?=
 =?utf-8?B?N3RzZXl3ajhBWGxPSTAxZmxidExsUjFGaElTK0pOcjlpMnZrc3JhVU9qVzFQ?=
 =?utf-8?B?RkMyb3FUS1MxdjNkMm5TNVdiTjFFWldBZHhsMkZ4cTl1dTlMYmQvUlJYWkYw?=
 =?utf-8?B?SjgwUGdkdndnYWJNc1ppZnMvdDl5RnN3SDB6QnM2QW5jdlF6V1VWRHU0Mk1n?=
 =?utf-8?B?M1hXM2tXcFhEOFFUcThpamxnUnJuTE55NFpZc1lFTFRJQ012ZE0xM09pMzBV?=
 =?utf-8?B?OUZGb1cwNGxkOE9NaU1jTHNBbVVmM2VIUDdJRGVaZ091eUMxREI2bmNmQks3?=
 =?utf-8?B?ZjBKVDBnM1RTTkhUaGgybWp2eXJlU05ib0dlUUFHRjlHdTZ1ZXRtekltcHVw?=
 =?utf-8?B?Wm1UOHBoVTVwWVF4bG1ZSko2ZWhwSDVEN0tjSVRVWHFEQXdOUE95M3RkWGFw?=
 =?utf-8?B?akxsbSs5anlPdVZXeTZQU1FCbWtYSGZvSHZmWktJUy9paFNqRHlNNGVVMHpM?=
 =?utf-8?B?NU9yVWhGN0dTcTVESXJQWE5CU3hoSWt2bzEwSElvb0ZwNEVuNE9hY3E5UURj?=
 =?utf-8?B?WHdtQThrc3NSUGVlZDFScDhiQmQyTzBwblNlek5VaWRYT0pjZ2tJeFpJZERO?=
 =?utf-8?B?UC84Tkd2MU5NMExocGRlNXZucUFCMXBXd1B0azBlTTZwNU0wMEhiZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e738b2-a109-4a7f-33c5-08dee66b81bb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:30:54.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /51WE17DacjIF3qH4UV0o6j5o6v1B57USzOUCJ0wmf09ZLJ0yy13U8xCWc+/ntTwlteDfFwTkilebPz0ImUNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6359

Hi Hannes,

thanks for carrying this over.

On 17.07.26 22:58, Hannes Diethelm wrote:
> This patch adds a debian package config that allows to build a deb's
> using dpkg-buildpackage -b -uc.
> 
> The packages are libevl / libevl-test similar to[1]. However, latmus
> is placed in libevl. One might not need the tests but still want to
> use latmus.

For the purpose of tuning the core, or what is the reasoning here?

> 
> Additionally, libevl installs /usr/lib/udev/rules.d/90-libevl.rules which sets all evl
> device files to group evl, g+rw. libevl.postinst adds this group and triggers an udev reload.
> 
> This allows to use libevl without root. However, using SCHED_FIFO still
> needs either root or setcap cap_sys_nice+ep and possibly some other tweaks.
> Some tests and my application work with cap_sys_nice+ep. However, for example latmus fails
> due to unknown reasons. The debian packages sets no capabilities but this could be added
> if desired.
> 
> Caveats:
> 
> The test ptrace-sync fails with <timeout waiting for gdb>. dh_strip -Xptrace-sync from[1]
> does not help and it is not needed: When libevl-test-dbgsym is installed, the symbols are
> available but the test still fails. With dh_strip -Xptrace-sync, the symbols are not found:
> warning: could not find '.gnu_debugaltlink' file for /usr/libexec/evl/tests/ptrace-sync

But the package built by xenomai-images does not have this problem and
runs the ptrace test successfully. Already dug into the key differences?

> 
> If linux-evl is also built and installed as a debian package, linux-libc-dev can not be
> installed due to /usr/include/evl/*-abi.h are both installed by libevl and linux-libc-dev
> from the kernel build. However, installing linux-libc-dev from debian trixie works fine.

This looks wrong: The kernel is providing us with a different UAPI, thus
also needs to deliver an alternative linux-libc-dev package. It should
be the role of libevl to deliver those headers as it has no knowledge
about the actual kernel in use here. That's why xenomai-images is
generating a new linux-libc-dev and is not relying on libevl here.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
