Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C338AC97
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156804; cv=fail; b=pqLtCVUDceLZFFCppZfp4fKFOqM1FJ+4aTK2TNRBgMYHyhDLkrOkWstxfxLDnGpv0T+BbxWwAA2PM6X+9bXQa30c6usM3Quw/+3R5iQmWNLj8FISxdTb2mw6vDT/P0T/plJznWcrfn/GlWRxm96JWsBBRVS3rC2Ak04LQuAKGbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156804; c=relaxed/simple;
	bh=ZLNcYhTfQAPqq2HHU1SAg/2bMZfJscgUzqM9Z/o4/eI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SV9H5OFtfL6zmOBjL6+2jUqkEbGWuEuNWbmBNaTszvnqvL4A8chR57eqvfTOVNl8760T2eAJVLrJfG/nvWgRLOcIDS5MN5TQvReZ/3xu8oot+Nz6kTmP1rgkLlSkt23k3s0WPI0qt5p9LfiIRoDTRQDID7WKOFE4eUmTERhYiJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=G9eLdP8R; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="G9eLdP8R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3u3d7Vdbl6yB/vLdZfS6EI83DylcTYdVgQar3xAwUmun7VDApycKJO0K2a7HxbGE8ZirsKiU5zvjFs5NkfePS26UohaHbjSfky3lG8rOSZ+7p+qWx617rMGvAnVNv6CL+0tuCOOYtrCrxc+9s94VQsD6oLDbXLRX7zZ6eaJadMmZ3/c1g9dz8HV9pupuO/h/aq8nhoO+LxlqblHYOAJGe3igbMP2JSBT1fDPwSPUR+Q5i2VUFU1ZMdKa3AFvcMdc4KwbaJLNisDQXnu04YAJeMOzem5YE+2sPVvPCzrpmSscqe+Hy78ffqBugpDUmcxnoXnbM4prU5trWALlzCKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgw2dCMxBJKj0K2yMra6807teRU1eBbnGwWP3gLhA+Y=;
 b=gIt2sqxi+PoVA8li9xLrF5DDrS4oGWK1pCu76C+a0RXGU1+B/vg9LJpzqdyMDGOd2dc/wR/99/eNIQjtYqM/aqPNaB3rlhSwXxIGjghLtcdw1t2s5GRKb9J2fMcstgsFEEZ/6rdNjobdjZwe//U/TbeWtgLJsxLlSEvvfAscPt+mQVJPSt4w7udPvNbjtSk9Zk/6zDqifG+EsXKXpvNzFivgViuFau4jivIemMzBQTR1wGQyL86KUnci/5GC8yrWKZRuf/8p90K1DFygSiapP6mEmG4y8LdiaYFlRPI382NBWaP1VrIRSaMDz932NUCxe2DUAI/sPxzjVSmjEjPHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgw2dCMxBJKj0K2yMra6807teRU1eBbnGwWP3gLhA+Y=;
 b=G9eLdP8R6K1lx5PtXxj2mKxGQ62Md+gyfPq9mTBo660rAiP1/3zxvyVFdTsOfPhnbrXfG8TnrBAsmqBC17eeZFmOWD3RBqMG/MQHghDoc9Yw4avDQyFgYNoEM3YfnXOoLDUlOMZR+f6YDkZd/ouUMTXdSsZTL+tavg70LJnFxGsX/bWUZyk7QABASpXSmjOk39dEdqdMD5Q5wEeOlKXouWCX3Ze4PtgzYT40Nwsh4bkPuHoKIsf7hoV0PQQBqZ04vf01UOCBHwAaBq+14UADdEkv9RcZyMVd/FD8cDbG6ZTr0TO7EUC0E9qSUh2lVoH0N7LolY6V4kpKbJbuIz9GbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 12:26:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 12:26:38 +0000
Message-ID: <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
Date: Thu, 7 May 2026 14:26:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20260507122357.2463483-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260507122357.2463483-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdced3c-180f-489a-847a-08deac33e2fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EyDNMmLma5IqqfPNup7SRKQq9hnIfXy9YlIoR3v8fqs2dnZgNk6T96mSg8COxwAvXfWWLlVkSHoDILvDrhWMoZUKjnchmPIXlbVNXkqrcI6JqR1S9C9BiX6TYVHIt3e+lixrfMESr+6w7BOjhVHuTT//1E7CkRtxGiEeKBfeP5Gy0j2GanvMgL7ObWQ7+NASgiSgDsJNp/CTUJjUQLftXQbO7KiZXc4JSH1/TbcliOmZaTjNKcSYf7AlaA2nL7H+ibRco1Wl915/CulQhB5uya4k8M6dTGAF2P3/f21GtkJPWKdbNxGl8aemiv0kyP9tBZ1zonGJOPJLu8DZralGiIc7dpFhjNcrvV+bJ7PD+YmmH+7RrUWxmgla+q05eRmbHT/AZlwG501AuZ/jMxK+Q1/RrOrd9uhWF89ZOEXSoCk4J483GZfr1gt/bFhIHBQuxj42W0sQtj5Lc6j5Emy8RabIhhtLtpg0YSmthwG7I2yTSKRlyhZ1YkBCNtFSW7avNcsgDNi8UKkvBZ1iZlUg9EhfBKkVMj25x1MLSoDTEv6lgAHExzJUkBHrHOm6KlE33Hv60TlHEdKZKFfRU6YOa4NDgeDGy3YSm5o3KmI8Q9wGiB9E1XbOxVIHvMqZoNbiLrhwCUYcvMqeiEG0IfYlz/9eg4WZbN/sFOWsiB/Tf5dqvNSJud/DjoM2dKNWT+GZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVRqRTNqUjg5Q3Jpa2pXcW1zOFhBRXBFT0szSU9KdTBYMmg2RDllVmNkRjlK?=
 =?utf-8?B?UFlpaENoSFlHdnN0VlhjaHZYK2J2bDh0cVc4bVNYQW45LzNpTi94S3kzZUxh?=
 =?utf-8?B?c25ERWRiUUl4S1hpZFMzcWRRNWp2WVhMZnZjL21kOGxRazNQLzY1NWNmeWFn?=
 =?utf-8?B?VEpURm5YVm05MDFmcmxCWjRDaC95OE1HR3RZYkxHM29Ha0ZPdjdtQ21aOC9h?=
 =?utf-8?B?NFVMbm56WHZlOU1jL21hTFg1YytjMEcrVTFiOVhtQ0xaTmJDZFQ0R0xkYmIr?=
 =?utf-8?B?dklaTUFsNnQ4YnlOa2dIbGViQWZmc25PWE00VzJIODQ1SEpnd1ZwVmsySjY1?=
 =?utf-8?B?Ny9Wa1RQR0t3VEZrNElUVlgvS1A1Zm1hcVc3blhwNEFKbVBpcEhWcGY0d2ZU?=
 =?utf-8?B?RTNmdTZrTWZLZ084WFR2Z0pjOWFGdWl1Nm5UbWZrSlJZRHdpWUdIeU5KTjhM?=
 =?utf-8?B?YWFOM2hQcG85REkzWitXSEl3VEZWUzFiUkJlQURodGtIeTM3Y2k3Y2ZZd2tn?=
 =?utf-8?B?dkJyYXpVUUxJeUxGdSszYjZYdzhLWWtubnFZRitBVFZWVUtCenBsN3ROck9V?=
 =?utf-8?B?dEVQei9vQUxLQ1BzWjkvNEIrREZlNEtnZnRBeGRVcHB3Z0dCUTAwelNGbTl0?=
 =?utf-8?B?dTJkRzd3d0sxb0p5ajc0NWUwMFhIRExkZ2M2T3k2dkJWbXRuSFJsM2dzbkNa?=
 =?utf-8?B?UlI2SUk0Wnp5cnlHbUlZUmo2ZGpZbmRnSlJlTnNrUWZBdWVsMHdTK1pGNG1G?=
 =?utf-8?B?NXhuR2hUeUF1V2NkMW9mZ0pZTEZZOGJhZFZ0TGJiY3MwMG0rcmVzaDNYd3RP?=
 =?utf-8?B?Y1VBMGNTdEp0VTVsZUhHZFRqMkFJZlNLNjNjNlRVemNzTFRqTCs4OWpuRW1u?=
 =?utf-8?B?OEczdjBIZUQyMWlZMTZZUHdMMzc4WW1JMmFqblNXTlJOd2N5K2d3aWJ0UzlI?=
 =?utf-8?B?SDBGTXFhWlJkV1RXRG5qU3p1TzhhcFJoQXg1aGdnTFNwOXBFYk1UTUZKdnlt?=
 =?utf-8?B?VnJOYVdxQ280Wm9hUjkvYk9pUzZGc2k2bWd0ZDNUWVg3SmpmTGRzT0JuT0c2?=
 =?utf-8?B?c1VHL0ZzemIrU0dKUThQT0RnbnNQZXlOenlSOFEvdWVPQWtWY2lOV3lzMHQw?=
 =?utf-8?B?Vitaa1ZMVW1weStsU1FrQStFVXhZU3RpSm1nQXpkbWN3cGRyZkJRamtndHJK?=
 =?utf-8?B?bElLdmtjVUZoNDdJYjJTUXBRNEJPM3JyWnc4Skx3YXpKeFBVTGp4UEozZWNP?=
 =?utf-8?B?N1lsUGlFL011UnpTSEs4S0p5aWM1eW1OQnBPMDZBVDJaQmJzSlY3OG9SRlJB?=
 =?utf-8?B?SjJsT2hhTlp0NVd4d3JtZVhrQTRnS1doYlRuMmZ5SXJlUGdEUWMxclNiSGVp?=
 =?utf-8?B?c3NnblR4WmtDQkRwNXVYaVk2amYwZ3BXeTM4cUpIdnN6L3ZzRnJNQ0NYVlNv?=
 =?utf-8?B?U0hZUnNvQ3VFN0lCb3VldGVrcWFEVkRObnpMTHRQYmxPTWVOR2RRaXdVZzFW?=
 =?utf-8?B?eVVQS2tKVVRaQlVYUzBOL2xwNGp4RFcvS0J3MkwvSzlNV1MxVGxVWi9iR0h4?=
 =?utf-8?B?ZGNHWExsejBtZEhkYTNuYVJZNlZIaS93WTF1R21UcWxpcURydEZsWlRvUnlh?=
 =?utf-8?B?UzBJaEFKSnhUWXlmZjBpV3FxRHdyc3lINVdjcFNFRG9CajBEVFdNaFBTM2M4?=
 =?utf-8?B?WmQraUozc1E4QTF5TjhuakpwN1pLYmhISk9JQms1Z3Y4cVZLQlltOHhzRVM5?=
 =?utf-8?B?Rk9oNHV2VGNEcjN3UUtBcHlDSFdGdGErNXRKQkJadmJSMENpQkt5SHdNY1NK?=
 =?utf-8?B?MWU3MStncHpnSXNNcFdsNUlwSDkwSG9DaXA2WlpBZ0tlaUdnQ1krMUZPbW91?=
 =?utf-8?B?MG4ySmhOazluUXZYYVpFaXhwbnJOd3diK2EyalBFZkhMcHhCbzhhenRST3Bv?=
 =?utf-8?B?MTBoWW9RUWlidDl6MEVFSFR6Rld4TGNIN254a3pRc3lwamFhbXRYL3hHZU0v?=
 =?utf-8?B?ekI2d2xhTDZSS3dMRDIxcEVlbXFHc2thSG1PM2grL0gvQWZydFEwNHBoUkdt?=
 =?utf-8?B?SDBCM2E3b242WEw5WmMwN2taQWQyeTAwT2UwWk8xQVFaK2ROaGNtQjdGaWpY?=
 =?utf-8?B?VHpIdWJxUmR2VG5BM2Y2RzQxOWZMNytSWTR1RjF4UThaVU1rU2JLYkd1V0ls?=
 =?utf-8?B?TkVTV29rWXAvSkl2b0NPeTNGdzhOZUZ4Q2VBTXRWRFhCTldGVzZLYVNROVcv?=
 =?utf-8?B?M0VLZGV0aFEzdFZFdTY2MENSQjFCRnVwU0d0dWxZdlVhc3NPZDBmR2lQem5I?=
 =?utf-8?B?N01NS1Y1MUNrb1p5Zm5rVmFuL200cDhFTGVvSXdoN2ZCL09mejd2Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdced3c-180f-489a-847a-08deac33e2fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:26:38.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R968n7xvFp0r7M6mJZpHixXJiLVaGOJIB16on89Yous+dWLWIsXqGkAsQ162exaZYRBzWfo+vRT65/xd/5qqfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8959

On 07.05.26 14:23, Richard Weinberger wrote:
> When Xenomai is built without _FILE_OFFSET_BITS=64 on a 32 bit system,
> which is the default, but the Xenomai application itself is built later
> with _FILE_OFFSET_BITS=64, we get a nasty ABI mismatch. Since only very
> few cobalt syscalls use off_t, the mismatch goes undiscovered for a
> surprisingly long time. In my case it surfaced only after a realtime
> application which uses mmap() failed sometimes at mmap() depending on
> what functions it called before mmap(). In the good cases it used to
> work by chance since the extra bytes used for off_t on the stack were
> zero.
> 
> To save the next person in the same situation a lot of time, compute
> the size of off_t at configure time and compare it against the
> application's sizeof(off_t) via a static assertion in a new generated
> header, which is included when building Xenomai applications.
> 

This should have been resolved (but apparently we missed most of it) by
0bb6608b6fa7129de1ff4213ddf31298616cbf23. Can you name some of the
remaining mismatches?

Jan

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  .gitignore                     |  1 +
>  configure.ac                   |  4 ++++
>  include/Makefile.am            |  2 +-
>  include/boilerplate/libc.h     |  1 +
>  include/xeno_off_t_assert.h.in | 10 ++++++++++
>  5 files changed, 17 insertions(+), 1 deletion(-)
>  create mode 100644 include/xeno_off_t_assert.h.in
> 
> diff --git a/.gitignore b/.gitignore
> index 402604c59..8b35071c9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -26,6 +26,7 @@
>  /configure
>  /include/stamp-h?
>  /libtool
> +/include/xeno_off_t_assert.h
>  /include/xeno_config.h
>  /include/xeno_config.h.in*
>  /.ccache
> diff --git a/configure.ac b/configure.ac
> index 0d6dd87b6..b3d08d6f0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -19,6 +19,10 @@ if test x$prefix = xNONE; then
>     prefix=$ac_default_prefix
>  fi
>  
> +AC_CHECK_SIZEOF([off_t])
> +AC_SUBST([SIZEOF_OFF_T], [$ac_cv_sizeof_off_t])
> +AC_CONFIG_FILES([include/xeno_off_t_assert.h])
> +
>  version_code=`cat $srcdir/config/version-code`
>  CONFIG_XENO_VERSION_MAJOR=`expr $version_code : '\([[0-9]]*\)'`
>  CONFIG_XENO_VERSION_MINOR=`expr $version_code : '[[0-9]]*\.\([[0-9]]*\)'`
> diff --git a/include/Makefile.am b/include/Makefile.am
> index 1e9fe0210..05dda9539 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -1,4 +1,4 @@
> -nodist_include_HEADERS=$(CONFIG_HEADER)
> +nodist_include_HEADERS=$(CONFIG_HEADER) $(top_builddir)/include/xeno_off_t_assert.h
>  
>  SUBDIRS = 		\
>  	boilerplate	\
> diff --git a/include/boilerplate/libc.h b/include/boilerplate/libc.h
> index 44ddad5af..98d49648a 100644
> --- a/include/boilerplate/libc.h
> +++ b/include/boilerplate/libc.h
> @@ -19,6 +19,7 @@
>  #define _BOILERPLATE_LIBC_H
>  
>  #include <limits.h>
> +#include <xeno_off_t_assert.h>
>  
>  #ifdef __IN_XENO__
>  /*
> diff --git a/include/xeno_off_t_assert.h.in b/include/xeno_off_t_assert.h.in
> new file mode 100644
> index 000000000..29b544b29
> --- /dev/null
> +++ b/include/xeno_off_t_assert.h.in
> @@ -0,0 +1,10 @@
> +#ifndef XENO_OFF_T_ASSERT_H
> +#define XENO_OFF_T_ASSERT_H
> +
> +#include <sys/types.h>
> +
> +#define SIZEOF_OFF_T @SIZEOF_OFF_T@
> +
> +_Static_assert(SIZEOF_OFF_T == sizeof(off_t), "off_t size mismatch");
> +
> +#endif /* XENO_OFF_T_ASSERT_H */


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
