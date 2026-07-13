Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A71DE8AE
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939026; cv=fail; b=pspaOuf4qPz+nvUmsodomrzG1r8YQH4jdWC5mt6YJpjJbXMrPZYGJ7IBtHE4vTFP0N25hksMd/4H1SQu++pjE8arIkLMOreK3LBr8yIDf7i74MtZlA4TwF/bqelSDysrOWCN7tCizkwBC/4wRQCM+Unep4MTx6NX5nf2CnUKIyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939026; c=relaxed/simple;
	bh=YuNbN4xVh8HHe/vvQG5haxGfMNRA8u2YKLFa6jiY3yY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n60Rp7tjvU1rWwfkBZV1dfcEOgHpE5wiB6POsEBLTJNCz9rUgna/QOTT2WlKuNMIksk/Q5TIepeKlnnCwlmPUWNpuj3YzbUHcDLNabJ9YGgVw1GkDSgb5yRcJdUScs7Q+E4WJJCYtdXjmBnGj+jCEApKi0GZh+VFy8j27mU/tG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fotXRSWT; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fotXRSWT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZZiH4I5MuPyj0+70qvijqFHoMicSY4FICznpY/fahI0LdHFZP2mVIh6x00xomQ9Us1fPSKTb5eafHfD5RuWZpdXBWyc95PNs78wyElGml1MX+WYCT/gKxL+U0fiI468JVGxh/5Kcei5lkR8fYjFzvyhkp4242yrLZFw6/nNvgeeUgK0x4TUFvWRohqBoOTgRYcYzSTAfa2Y/gyjRqILfNFSAG4gZm5EJD/XHirQpOGhOAkxSqQi8wYOyUYiijM3DN6xiYjG4bSeTHkhStS5cnNL7zeTil2F66c8GFiuFauaLpS+iDR0Bkci3uEFhmGy/Y++gAgiMPDFPM+1mkrv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHy5WRt+arLsAM5F2yhGY0Gd4h63ME6Y4CqMT36nW0Q=;
 b=D0bhEY/RCyz+YgsvecbNaezAC2jKONaYCrCQVh9lCDHa2S5i8mUE1+d41DBhnyHn+ybU+yt8BKwWINz121JSkzT3X1clQbqOR/DjJnfG9nO5Gl4ZOScJslKKphvr+E/hxJekW6rfLvJ83xM0+BNElKA2QVLJ3Tmgld+nQea5XTRiULM67wB663yhjefxxzhD0WAUoZh2h1ep/HtcDNDpc324gUCfW1R0jU8HcJZsGjdeAf2yseJGkI5fAdGEDcRRa1FIqB9uQz5yclTqwjH4X9nB3rdTmAAjH9wQrJUQTeqvf7J6I3nTGN+ArLcyiIhu2Fp1LjDSeLyVnjspItxi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHy5WRt+arLsAM5F2yhGY0Gd4h63ME6Y4CqMT36nW0Q=;
 b=fotXRSWT3RjqHYUne5di28g0Gv0vn+tjqAUKMJsottxifYhN2QOhwP1CMbH5qqbPRJw5CELmWCJhCDWfso/r0BC1z9RU87ef4DjKvEQqXwYRmfWyZXl3lc0Xs6Ig6uAvS0aa9JjRyn1TXiAVPGBTmUarEpchaiNCaK+u8eUTH05CONG4HlW0Cq2MtcwFzmiAoxiFZjxuW/bAUY1Nh8FtP07R5i0viSiO4rE1AC6CgdzOyQLCtkATysKNOcWEXR8NFaqBqXeA3a4sm3W+I813EDt+uB9Zwi6wWLB/mU7gjSUGQBeskwAUixJ/CLtaCY27LqkgPs7Sxb58kT8CH1DJHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7710.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:37:02 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:37:02 +0000
Message-ID: <2336fe07-fdea-4875-96fd-46c4aa5d13a7@siemens.com>
Date: Mon, 13 Jul 2026 12:37:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH libevl v3] build: add initial RISC-V support
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260713103445.34208-1-tobias.schaffner@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <20260713103445.34208-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::9) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7405ee32-514d-46cb-5dd0-08dee0caaccd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|55112099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PpknPNMXBmij7u0hEuedghgtSNQjpqO5JYb28S2VQa+pwTBEHmmEmu+Uxo0nfPxdkgaDfidAUNuHALaZFD7n7qVGn7Ieknu+IuONFTc4hOTMX0+sBS2ggwzZQipkHGouFpgknIbBgrBmZPnmyl+6ZaX6qt1VwtpSZXYzVAf1Rs21mu2Flo7U+sccnQgFNrbibnLwrDuF78oyhj1ArpUsI3l4txqsEFtLHvoXiThgDxA2ALYwdjSsRNqolqZ8niuaqvJ6TjLc4HV+6RPHM8294DKPW8hRiTBEjvzpg88IOEQvnM/53GQeVFxtdyDmUG8TigivkFgb0n759FvD8NpGE/tLFOma3n2WraGC/FnjL9c4TsBVE6r7+4pxEBppgU9LNRHGrF+zjBRE9oCn10FwNR+xkOMX1zxi9d52vYpZwsGSzCUniZ0X639KDxHxa3lwclg8nEtNAONzI5d/pUf/hz4RBMOgIHboJAjwoH2jN0q6fbx+QTg4tf+nDzcn5JrgfPckxbbxwq92xYFWPz9qUd1Z0KtgdF+xoGNHwIjwXBnI5Havht/crrD/lKvSOsiY+oI4penVtzFmNcmz88/r5AahKwlrJ6vV28lGpcKvJ7NK1rXvLfMu/C1ZczeKAPbd9rghfKPVES1zM4CcjVzerL/YaOg9F4uUBPACtQ1y0CU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(55112099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elg0M2NDWjN2VkNQUmxMb2Z5UWxyOGN1S3NRSm9Ic25oZEtJRy9KeDJXR2Rh?=
 =?utf-8?B?bmRyNVhLdVNadFMrOUtnWWRqdndEakpzNUo5SitiWlVrZjZDZElkQWh4UDVB?=
 =?utf-8?B?U0FYTjJuUFo0UjlJUHVrbVRIZ0tKQm9vMzYrWm9xQ1JFMkVTRGEyTWJWaTkv?=
 =?utf-8?B?STVJSlZMQVplV1V1aWVaaTBQYVNiMHZPbmR0ZkxBRVpiMW5GQ0o5elB5M3BD?=
 =?utf-8?B?RXZRVlRwN2EyTGFjNVo2ZjVieFZmcjd0MmZ3QnVhRzYwTWFBc0dEdEcrelUw?=
 =?utf-8?B?MFU5U0JjVzJFNnd2UllNYVJQRGRnb2ZFbFNLbVc2L3ZGK1RscW1teHZab3J0?=
 =?utf-8?B?K1d5aFNiTXU4bjdoQWl2dHpjalVrQlk3UHNyaDVjclJ1cjlZQ055a1FzMjJZ?=
 =?utf-8?B?MFI1RUhid0JvRmIzWU1NM3drQlBkR2xuUnR4V2loVHVaaTE5b3hlZWFQNmpK?=
 =?utf-8?B?TzFmRVB1Vi9RdTlBZjhkbDQrbStKSWdiWFA2azh3aVltUGFESnpWdUtZRW92?=
 =?utf-8?B?dXVzWnRJNkFZRS90UTl5YVptT2xoL3JjZmt3aEFJVlg4QnlsUmRINGpSdUdr?=
 =?utf-8?B?QTFsK0lIbUM4aVlFNFRIV3FFNWJQT1BIZnk5am5yRlJNd0s0elJMS2c3UnN1?=
 =?utf-8?B?ZjUvUzE4RkJLNFl5UG1iL1pXY3JBU0YxcE9WUmFrU25kTTJQMFBXMnJGNkV5?=
 =?utf-8?B?NDRqSU43SmZCRWV3RFdsdGdZV0hnSExYb20ra211VWJlRlQxTStnWU9td1kz?=
 =?utf-8?B?NUpqdmd5WWc4c3hIbXBQTUhsZEtGTm9DazBkaGdFWjhNY0VKU3FBQmRzbnlr?=
 =?utf-8?B?c1BPSlRxTlhHUzc3dXZjUTgzQ21FdW1XQ2tEMzlLNkRwNmsveGFjS0ZXK1V6?=
 =?utf-8?B?SjU0T2RhVlF6SEdrNC91cVZ5UFFNc2ZTMmU5ajBmSDU1UzVIZkVxdno0bVgv?=
 =?utf-8?B?SURtcGJUU3NhSkwyUGQvaWtjN0hwSHpaOXgrdWRtditWeERwMXdqamVnOEtS?=
 =?utf-8?B?SWxQU0lXaGtvSUsvZnhFNzlkd3BIb2tSbERKL1NBbjliS25kaUUzamRIYUc3?=
 =?utf-8?B?WWx6Z1lXT25oOEtYR1kvc25NOEJLcVRRMXNHcHRpRE9GdUhIMlJiYytCN1VC?=
 =?utf-8?B?V01YaVd6djVNLzExdEMyWU40MWZnbzFJaGdJSmJiT0FpWk1FclBpUjB1SGhG?=
 =?utf-8?B?L2dGUHNNZUsyS1BpN2IvNWQza01HbmhGTThBK0paUldwdncycEp3RzRxSHov?=
 =?utf-8?B?VUN3V2l3aTl4VEE3ZDUzVE5JSzBkdXBXenRBakx1VitqU0ZaRldQWE40Q2xq?=
 =?utf-8?B?RURrVmJwYlExVXVVNWFJMzZySnhJa3VQczZ3RkhzN09rRGNvekZ3em9jcWti?=
 =?utf-8?B?VUJuV2JiQmJpZkpsZ04vQmpvQ0ZrZ0RTVGN0MnYzOW9rQWY4Z0NVR1M5N20w?=
 =?utf-8?B?dngzME4wTm8vRzRyUkpZUytLcHZSL2QwNE1SclIxb1B5ZTMyOWpSZHRzV1lW?=
 =?utf-8?B?bGFiMlVDazFpWEkzTTFGajR5dEF4T3EyTjVVMnZYdERSUnozVGJhKzJ4VkFq?=
 =?utf-8?B?SU40cnA5c0ZCckd2MnRVRjFoMWt3ek0rem9yNGRqVFl0U0VtNXoyVUtLUDRO?=
 =?utf-8?B?dkw0Wmo5VEdIa0x1NnlHVnkzYTdlZU5Sd0cxVVhxQUxOSDE0RGlPeFhJa09O?=
 =?utf-8?B?TTh4eHVWUmNxWXlnUEt5cWJYY0xJcmNHODJpY0NGcSttOGtTK0dTSm40RERl?=
 =?utf-8?B?OGk3K1NVUTR3aVhYSnJ5NzdPN2w0RHlweW9DRjJCQ0IrT3V3QkNjdE1JUGgv?=
 =?utf-8?B?UGtlNi9QMnFqN0sxUVhwSjlMQUhoMVUzbUdpNE1yYUJRNkxJd3lwTHpNaWo5?=
 =?utf-8?B?RjZJYWxpYmhxT2NKOXNVeG42S1cxeWsyZXhhV0RwbFo0RGhuUUFNMEN3MFhU?=
 =?utf-8?B?UTlOOFhrZThQUWRnMXZkbG53YUJLaGw4UTgyWTh4NDRBdHR4TGY3QTJVOElk?=
 =?utf-8?B?UDl2WkUrZGVGYnRWOU15TmwxVFFJNVlTd1R6YlNIcXV0c21nWllUaWJXNEpw?=
 =?utf-8?B?U3FsNno1ZVZkMUhNOVQxUFpHRG9nWVpGWjNmTDVLQUJsTjJsMWxMSnhYZGRv?=
 =?utf-8?B?MitQWmFDaHZtcGRKN3BCbmoyd212Um1tbFB3ZFl2YWxrUnJIclZ2MEF6ZGtC?=
 =?utf-8?B?MjI4ZkVRYjNxcy9ic0JsSXlNOFFXYWI0UnhIczg5UW13UHY3QlBwSVBLdlla?=
 =?utf-8?B?WjA4dHVJbkdvV0dyYnloaGZ3UXllQlo4SGJIalhaSkhLTTBPcld4YXBJdTJq?=
 =?utf-8?B?azBUWkJ0WE1Dd3ZFbFBacVJENTRlZWdXZDJYaWpmNGtpdjhhTGxtR3J6cEw1?=
 =?utf-8?Q?+kwjtEcUCt3fMoGA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7405ee32-514d-46cb-5dd0-08dee0caaccd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:37:02.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jikaaMVz0WxxtjwIjYsCYt2QeTtp/+efSIofF0NCymwQVxVZMBe9sUfX5PIu9j1C4ltvXd0LREVBMQO5/gPdBu81WwPyKFUDDoUqyFgNr20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7710

Hi Philippe,

On 7/13/26 12:34, Tobias Schaffner wrote:
> Provide the basic build infrastructure required to build libevl on RISC-V.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>   meson.build             |  4 ++++
>   meson/riscv64-linux-gnu | 17 +++++++++++++++++
>   2 files changed, 21 insertions(+)
>   create mode 100644 meson/riscv64-linux-gnu

I removed the vDSO-related definitions from this patch to allow you to
integrate it together with the patch you send today.

Best,
Tobias

> 
> diff --git a/meson.build b/meson.build
> index 674c661..4acbc40 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -63,6 +63,10 @@ if libevl_arch == 'aarch64'
>       libevl_arch = 'arm64'
>   endif
>   
> +if libevl_arch == 'riscv64'
> +    libevl_arch = 'riscv'
> +endif
> +
>   post_install = find_program('post-install.sh',
>       dirs : libevl_scripts,
>       required : true
> diff --git a/meson/riscv64-linux-gnu b/meson/riscv64-linux-gnu
> new file mode 100644
> index 0000000..33c47e4
> --- /dev/null
> +++ b/meson/riscv64-linux-gnu
> @@ -0,0 +1,17 @@
> +[binaries]
> +c = 'riscv64-linux-gnu-gcc'
> +cpp = 'riscv64-linux-gnu-g++'
> +ar = 'riscv64-linux-gnu-ar'
> +strip = 'riscv64-linux-gnu-strip'
> +pkg-config = 'riscv64-linux-gnu-pkg-config'
> +pcap-config = ''
> +
> +[host_machine]
> +system = 'linux'
> +cpu_family = 'riscv64'
> +cpu = 'riscv64'
> +endian = 'little'
> +
> +[properties]
> +platform = 'generic_riscv64'
> +needs_exe_wrapper = false

