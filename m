Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93042BD20
	for <xenomai@lists.linux.dev>; Tue,  7 Feb 2023 05:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCXLLDmNxKYi2N+bHkwky8x1480b8Rf7GluXaGcZK23w51wSWMiktL++WMoP3+ymHQzAmikcU75jmyz5a25sJ2G1K3vE9TH0wiF6EjUUR+nF1PMbUcmqhdc+ntSP8wBx6Dx1CtwcUonTlVIhek1XNrTmDSZhW/dXVQwo/TOVIgVGjIi4RmP4iY6kZxUTSabjaa/s1mFmnK+BvACkNtvQO8YCOxKlxeM8Fpl7ULMUVYbgb3FfBjUR+WRi/gqdTXmUidXxiUEt6+88ybKA3fEK5007Tgh81turdHvslztFjX9Fxt39zr7w68n3//yGlAU46Su9lJ/C7O6tPxrzt0DkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtI+FAmcoU1DhabyVYV6F6iuvN4s7nzYd83IvwybBpE=;
 b=Ks9H/OPZRP8I0JUdkJJNvqo3uhO3eTrRnffogXnAfrpBfHZYWHb6lGmUTSorGt2ZFF1xxpHz6MjVKhGbJdEicN/TeCkHTy1yhTELnTRQA/jKgzdh8u/H3XkK1r8mks0/iXw3BGH/xwn4aQZzCLvcY8Gmoio5pOyeAqetN0HtFpLQl+24tmk3aRHQQ4yFh+pmHib6fApjm0dEZj0sElQIoOI01/rQQNkvZIY0xBiBRj8wXWsmbJdsa678AU+DCIfLgUuRs0dSeWRj7fbn9L/LY3ZdIwmuGrzCRbwr58cblAwJ7tt78jJtojm++T2Rdzr4/cnmX8AadGuVgIBMHdkH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtI+FAmcoU1DhabyVYV6F6iuvN4s7nzYd83IvwybBpE=;
 b=zz7+GUoI7sXJGkPmhNmID5UtGKFFiz3vH/FWd/7uBHJMpgjURRuvbnjC0kKJAkYIRo0+I+27mzubuJJMApTp2hRRsTSlAo7jk72VYF4XTWRrBlAFB1fqpO06jzpRZcyDGagFtMzK+ttRccXbj69cwdUJeG/dZLXyFkLLv+QIxw6vi7dLix+24XD0s46ypWlzs87gdP8XfXjpdK9JstjdYpuC89fzHaEIz9shPeAnle+sLo/FNiw6jFOvICw2wYNSwb50UzM7yoFnGBMCHtiktCitAnQRrToXu+zwy/hlujErG3Cpu+NYZFOZf2ma8/JKX9mc2NZtH0DAErHxStXpnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3763.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:176::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 05:37:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6064.035; Tue, 7 Feb 2023
 05:37:16 +0000
Message-ID: <87707210-f29e-2884-51bd-2e38b3bd47e5@siemens.com>
Date: Tue, 7 Feb 2023 06:37:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2] testsuite: dpdk: Add l2fwd example which is based on
 DPDK.
Content-Language: en-US
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@lists.linux.dev
References: <20230207044042.5132-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230207044042.5132-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3763:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fcf832-2d8d-43c0-1067-08db08cd5f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VjHr73Fyr8Gh3EZAeEWs4ZB2OdOcu0XBbrlo7aiqQ0kipGKWWi2Oy9Woj3QQwIvYx4tc1mJMsmoJhscKT76C4leuXv7wCV66gAqnW0vgcWHkU7w+85UoAVDsyltTxgNOMu+XVICeQX4/XuZ1Ele327Ypz8Zz+7vhSz0HCq9k/MHol+nA+0mzmSKUN4ug/7KkdHmYAGmSuFKst9InKRvH2otWYGI7Pul/XHJFnSsRoP4NAhCtf+MV4OUPS4cvxXzrARsOXI0E0iPxKrybPQYD7oaoz3MKKAnKlz8F6MGssIMO8qdpYF25SYQaDyP5mc2lQNL0V9mryiVn3Nug2Rm6prP+rbOlZJj10RptEziSBjdEmHgYhCd/KKCosgKOahEWKzSnJqz7V7z25x0WCxEfAQez9kW1WcLd7KqNAzwaWVK6akuEfe5s/iwvmwZhwqujJa4ZoRTPkKL1JrHoQrJsJ2X6e2+wygDDmSv7n35r7vRmnukX6pwjbE5QhTDqUcWPW/GuUS7AO+k2RegiDQOjoReH5eqVSacWZ6dwtscbR1wLeCd8UaJrT55xhuoHQtGXaTBO12WiWERtA+hP1DGUvrbzQiGV8VUo8baXs1Mg5z1LsmUhvGtpqN9upFqvz8Cal1wOfWOd0mbQx3KiZDJq40gSBJMhEmAzlezHDbPOdUrBFxEKt2mQ1ICs84sVWGuFo0kilrouaXPoWLeixGGH6CEU/u0fNn6C7DqYi2ogqyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(38100700002)(82960400001)(316002)(83380400001)(44832011)(66476007)(8936002)(66556008)(41300700001)(2906002)(66946007)(5660300002)(6666004)(2616005)(6506007)(53546011)(26005)(478600001)(6486002)(186003)(8676002)(6512007)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STl2dE1ad2dIQXRHa3lBVmVXWWdKSVd5QmFCNXBkbE9lV1dZYWFPSzBOM0ND?=
 =?utf-8?B?dkxtN3dmK0FMU2tKcWw0cnEvZXNGSkNlTmZxWlU5Vmpnd0hCa2l1RTQxb09D?=
 =?utf-8?B?OGVhREI0VWhiTXpnK0ZYdDZ3NWNsdWp1d01ZY0wrbTJET2lHdXVFa213dUVx?=
 =?utf-8?B?VkZTdHREOHlGOS9aeU5HVzNzZm1KRXpSMDV2K0xMRnRML0dabzZIK1VJK2tR?=
 =?utf-8?B?R2M4YVFjdWlCNjlpZUpTK3VKNkQxaytVdFhiL3M1Y2NGdm1ENzFTOXJpNXhj?=
 =?utf-8?B?RnVRbDg5bTh4NlJ3bkszVStGZ3FseEZKZm1hZ0REVzRha2dZellIN21MU2VN?=
 =?utf-8?B?Qm1TM1Q1dS9oV2N6L3ZsZ3F4Ylo1dGRyM0ZEMlk3WTFmdjBjRzFJZjVmYUli?=
 =?utf-8?B?K0QrcmpZeTU4d1R1ZmFueThuMDhWcmd2bUxObTAybGxxamlMa0had1VpZURx?=
 =?utf-8?B?MEF4d0ZsYzJReEU4TURRU0s0U3NWckRMcEZsRlpFaktpRHJTVEl2RU1WTlgy?=
 =?utf-8?B?OGNaaUVoTnUzNVhtNEZrdnZYRmJZMWhya09kaS9pTkpISnV4dzVnNHBNK2I2?=
 =?utf-8?B?OXZsUnNudXoxMDZISkNtQXBZYnlBbWFZejBHcnYxRFhvNS8xTHg4L3NwVkdK?=
 =?utf-8?B?OWdXY2s1UktGK0RralFjRmFYbFI0OGZuY3hnRGhYdlI3Tm9TdFBHVVpFSUJR?=
 =?utf-8?B?cVlUblltL2VQUnY1L2IwOUZVVkNWdkVmeWVlanZ1SVZ1bm1Xc0sxMldUZUY2?=
 =?utf-8?B?VTVsL2dFYk9WS2hLTDUwTkRRUmNUS2U0SWcxNHF2Y1hlK1loRklJWDZ6VVN6?=
 =?utf-8?B?UmxZeUhTTWYzVlpTK3Q3NXZrdDJWa0czV1hmYnp2SDNFSjdtVUIydDdwajE0?=
 =?utf-8?B?QlhvbENkQXp3WTVPbDdXQUZIU0lYc0t0MVpKQlUzQTNJWTFwZkR6MGZaczZv?=
 =?utf-8?B?dGowc0RwdDVpSE5uZDlNUWVWYkZ4emUxNjEvQ0tiSXhGNHRjRXowZFBjQWZs?=
 =?utf-8?B?YzlOOWl2N1B3V1RBaHd6WXNadEV5R3hTeUFjTDVhR2kyQ0ZyOGlkbFVGK2xy?=
 =?utf-8?B?NjUzczhWZ2hud1ZDS3dUZ1hFanV1UnJBUU8rRlhUdE9FUGhqbUdxNU96T2t5?=
 =?utf-8?B?dmVseDVmcytjTmRyMXRSQ2lVQVlvUTNyL0FuSjBWMzNpRU9iWFpDcDgycjFS?=
 =?utf-8?B?djhHVmxNbzlMaVBoVjhGODFIRlEwZkpRQjJsVHoxQ2E1bFR2a3NLdW14dG9u?=
 =?utf-8?B?MHN4LzNXbWJLT3laaXM0eDFVU3NwVnRWeUZmWDJBMzJXT3E5UnA2cGg4NUhV?=
 =?utf-8?B?YkU2Y0l0ZGpWWTY5eHZ6OTBSWkNMNjkwaEh4a3dJWG1zWEc4b1FrUWduemIx?=
 =?utf-8?B?YnFVZy9pTUdyWVNrNDlVZGZKUDZkVnNDUG9jYzVzSHpvMmRsQndiWmp0Z0tS?=
 =?utf-8?B?dmd0ekhET0cvbEd5L2dERURpazFvN2g3cDJ2WEQrSnYvc1lnTmhjSWZBMTds?=
 =?utf-8?B?NFlMRTNEL04wRGVRRWN0NGE0ZGI3ZThtOVF1NENCbnRYc2xtTG1JbVBJWTRl?=
 =?utf-8?B?U1hNMG5icFdRMEpjYlRrby9NYXVWTmxtbjd6WXBET1M1N2tyYmZFbXhWUmdm?=
 =?utf-8?B?WlF1b2tHTUorbDJmcVczdzZuKzdrak43MGdDNVpUTytMMFMxWi9MMnY4YnBV?=
 =?utf-8?B?Nkg4Z1I1YkJwZk1mcCtzNnlwamUxUEV4YlRJUjdrL0lHbHJFRHMyVU44dzdn?=
 =?utf-8?B?MHRVbnBLaVB3a2huTUtmNk5IZjZIdzQreFE1c3hGQlpHcTlUeTl6eG5uMFFs?=
 =?utf-8?B?b216MzljUUc4dUsyenJQSjZRUXdtYzkybGpHQ1czTll1M0ZGRWRLcFhKaGQw?=
 =?utf-8?B?SnBLcWsyemZjNnE5akJtako0TDRVNU5FNm5oMDk2Z0FMN3d4U1JtOGs4dWpI?=
 =?utf-8?B?SkZ3WGxrSVBhUldkZ0NsVzNIbXBCdnQ4U1pYSStPMm81MUZrR1o5VUxkbVB6?=
 =?utf-8?B?aXRKRXI1UDVJUjJOVzFBaDdaRVd5L3JXYmdkUWFtMXdBMUpXZTR6STBOeUtk?=
 =?utf-8?B?ZFRjTm8xbEQ5cDRxOVNWV3hHUkMwTXgxU01ySzN2QXNtRDhkZWkxbnRKeHN6?=
 =?utf-8?B?RUZJQ2V4R1piY1NRSHBWNU1EZmxia2Zzd3Fhd044V3pkeGlNa0pLRkJPbUll?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fcf832-2d8d-43c0-1067-08db08cd5f72
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 05:37:16.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLD+5h8A0Wp18qLRXDUs2SJYNpdg7thblM6YcZ3Ndc9KIApQoj35L9J09lXrq1w8DwPWfNU0jOFswTGys0QRYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3763

On 07.02.23 05:40, Hongzhan Chen wrote:
> The L2 Forwarding sample application(l2fwd) is a simple
> example of packet processing using the Data Plane
> Development Kit (DPDK).
> 
> After init DPDK and configure ports and prealloc and mmap
> enough memory for ingress and egress with making use of DPDK
> API, it is possible to implement real-time network application
> in xenomai to receive or transmit packets via sharing the
> resources with DPDK when there is no activities that may
> cause switch to secondary domain again.
> 
> The RT network application may inherit merits brought by
> both DPDK and Xenomai even though there is limitations
> in it.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/configure.ac b/configure.ac
> index 3ce34048e..3a90fc201 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -848,6 +848,17 @@ AC_ARG_ENABLE(libtraceevent_plugin,
>  AC_MSG_RESULT(${libtraceevent_plugin:-no})
>  AM_CONDITIONAL(XENO_LIBTRACEEVENT_PLUGIN, [test x$libtraceevent_plugin = xy])
>  
> +dpdktest=
> +AC_MSG_CHECKING(whether dpdktest should be built)
> +AC_ARG_ENABLE(dpdktest,
> +	      AS_HELP_STRING([--enable-dpdktest], [build dpdktest]),
> +	[case "$enableval" in
> +	y | yes) dpdktest=y ;;
> +	*) unset dpdktest ;;
> +	esac])
> +AC_MSG_RESULT(${dpdktest:-no})
> +AM_CONDITIONAL(XENO_DPDKTEST, [test x$dpdktest = xy])
> +
>  if test x$kernelshark_plugin = xy -o x$libtraceevent_plugin = xy; then
>  	PKG_CHECK_MODULES(LIBTRACEEVENT, libtraceevent)
>  fi
> @@ -856,6 +867,10 @@ if test x$kernelshark_plugin = xy; then
>  	PKG_CHECK_MODULES(LIBKSHARK, libkshark)
>  fi
>  
> +if test x$dpdktest = xy; then
> +	PKG_CHECK_MODULES(LIBDPDK, libdpdk)
> +fi
> +
>  AC_MSG_CHECKING([for test source generation])
>  AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
>      [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])
> @@ -1004,6 +1019,8 @@ AC_CONFIG_FILES([ \
>  	lib/trank/Makefile \
>  	testsuite/Makefile \
>  	testsuite/latency/Makefile \
> +	testsuite/dpdk/Makefile \
> +	testsuite/dpdk/l2fwd/Makefile \
>  	testsuite/switchtest/Makefile \
>  	testsuite/gpiotest/Makefile \
>  	testsuite/gpiobench/Makefile \
> diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
> index 4932f6d33..fdda466e8 100644
> --- a/testsuite/Makefile.am
> +++ b/testsuite/Makefile.am
> @@ -10,10 +10,14 @@ SUBDIRS += 		\
>  	xeno-test
>  endif
>  
> +SUBDIRS += 		\
> +	dpdk
> +
>  DIST_SUBDIRS =		\
>  	clocktest	\
> +	dpdk		\
>  	gpiotest	\
> -	gpiobench   \
> +	gpiobench   	\
>  	latency		\
>  	smokey		\
>  	spitest		\
> diff --git a/testsuite/dpdk/Makefile.am b/testsuite/dpdk/Makefile.am
> new file mode 100644
> index 000000000..ddc47a67c
> --- /dev/null
> +++ b/testsuite/dpdk/Makefile.am
> @@ -0,0 +1,8 @@
> +SUBDIRS =
> +
> +if XENO_DPDKTEST
> +SUBDIRS += l2fwd
> +endif
> +
> +DIST_SUBDIRS =	\
> +	l2fwd
> diff --git a/testsuite/dpdk/README b/testsuite/dpdk/README
> new file mode 100644
> index 000000000..f430ce907
> --- /dev/null
> +++ b/testsuite/dpdk/README
> @@ -0,0 +1,167 @@
> +
> +What is it?
> +=============
> +
> +  The modules under this folder include examples that ported from DPDK[1].
> +It shows possibility that implement real-time network application in xenomai
> +to receive or transmit packets with sharing the resources created by DPDK
> +without modifying DPDK itself.
> +
> +Dependencies & Limitations
> +================================
> +
> +  If you want to run these examples under Xenomai, you would have to install
> +DPDK at first on your system. Please refer to [2] to get dpdk started guide.
> +
> +  In addtion, we just validated examples with uio_pci_generic on NIC i210 and
> +vfio-pci on NIC i225 and limited X86 boards with dpdk-stable-21.11.2.
> +
> +  1. Functional limitations
> +
> +     1.1  Parameters --trace
> +	We cannot pass --trace to DPDK so far because it conflicts with Xenomai
> +     usage so that we cannot use trace function for DPDK in the examples.
> +
> +     1.2 Multiple thread
> +	In DPDK ,the term "lcore" refers to an EAL thread, which is really a
> +     Linux/FreeBSD pthread. "EAL pthreads" are created and managed by EAL and
> +     execute the tasks ssued by remote_launch. In each EAL pthread, there is a
> +     TLS (Thread Local Storage) called _lcore_id for unique identification.
> +     As EAL pthreads usually bind 1:1 to the physical CPU, the _lcore_id is
> +     typically equal to the CPU ID. But RT threads created through Xenomai is
> +     not managed by EAL. They are not "EAL pthreads". For these unregistered
> +     non-EAL pthreads, rte_lcore_id() will not return a valid number. We have to
> +     find a way to bind 1:1 to the physical CPU for RT threads but avoid using
> +     rte_lcore_id() in multiple RT thread model to use resources shared by DPDK.
> +        In addtion, because Xenomai has not supported cgroup, we can not make use
> +     of such cpu set to bind RT threads.
> +
> +
> +  2. Performance limitation
> +
> +     2.1 non-available rte_mempool cache
> +	In the example, the RT thread created through Xenomai is not managed by
> +     EAL, the put/get operations of rte_mempool will bypass the default mempool
> +     cache and there is a performance penalty because of this bypass. Please
> +     refer to section "4.3.5 Known Issues" of [3] for more details.
> +
> +     2.2 polling limitation
> +        In addition, in dpdk PMD mode, the performance of receiving or sending
> +     packets depends on polling capability of caller. But when the caller is
> +     xenomai thread, it can not dominate cpu too much time in primary mode(out-of-band).
> +     When enable CONFIG_XENO_OPT_WATCHDOG, the default XENO_OPT_WATCHDOG_TIMEOUT is 4s.
> +     That means xenomai thread cannot dominate CPU more than 4s or else watchdog will be
> +     triggerred to avoid frozen Linux as discussed in [4]. This polling limitation may
> +     also result in performance loss.
> +

I do not find my first comment on the first version fully addressed yet:

"Can you elaborate a bit on the envisioned use cases here and go more
into details in the accompanied documentation? The latter only describes
the "how", not at all the "why" (or "which use cases")."

To make it more concrete: How would and application look like that wants
to implement a real-time controller talking to I/O devices over some
industrial Ethernet protocol? IOW, how to convert that benchmark example
here into a production case?

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

