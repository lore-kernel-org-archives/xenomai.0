Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71F372
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 15:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeZRQN362PBlyyA02lI/+Ss7maa5LQdRUeOgMZMV0Z80T8lfjkkfiz9XMVKgN8FQy7smG+WVGj0O4eYlHvR+HAQKWB8Jr5GuBoF2f8qalTrk5LjJC+hY1ZfWzm/2BnTUkmrWnn+gE54NOCg/Jm6dNWndegIsZVWS04wBDZCO4KX9Hm1cED/3xquodevaLbbCavB9iWrn6I4RTHGXg4a9uJbV6IpgfeqMp4bQRz5u2gDyrATwS48SUHZw+SXFNwNHYY2s9veiyunoyJkJhUpyb86gh7aM0AY58NSDaVfWH5XgOSgvmNW8TmEBZa+cwvHIt5lh/h1VY3QST3l7keH2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybMHdF3aN63LrXx4m3/CxGlNl3Hwzm4Yq3neZhxc/tw=;
 b=RIT6yojwLROHiRR7JD3h5PjlCaY9COyGLF2poD+Iq9gYFaU65jaeIza1YFdGFutHOYnIu56qEZoNwau4rOCf55ITxYxDFA1l1hA/lCOZk8tqRelYb0AidpFCoLl1XBjGUE/ZytfWUAz0jZ7WhBoCRUqrGgqFeG7PZgUy1PlLQK15uLv6/Dn7zPs4nlDVPWJrsfD6Ih5zhaWroUyNA3p/iBsgeKiw7BrZTSNf5LI1+brNwF+8QQeyrSHZYgFFWEnb2amAWYhf9Fy89ZrGEeLSPwg2IuFaPk6vW3Ba0SwmCyafd5F/cHUmKrL9cv1NlZwH5+pCykhGeyrrwQ0OBE8hgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybMHdF3aN63LrXx4m3/CxGlNl3Hwzm4Yq3neZhxc/tw=;
 b=R3tzkD2lD0M2i6tO5HcTDNnXbBcYLMkJT0sHBH9wZ/7lk1zeB7WjSSnJVoXSsd1qKEyzr4BPVApBmTrIvPEkjXjcKjqbRsCc93/hK4ppv5stlG3LWsXjbMdoq/JYASKGF314tOLpUDrTC63zfY8l6wFAzpJDulm482kvPjqLvYhfVDYJCHWxcm88yR+9WTBvu25ijxsBHEFu/JDlLpml5U6SqRwRU3sy/nSj8YFewO3oU/tIW/PgUum/52epOxO5dYSHcOk1NCIIyHKj2MZklF79JpaaClPcJv3L8Zec/z7kl4A/9vsxcEUC6hS2MFFXVQ/x7hNSmqLc2mDIhgQr1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:02:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 15:02:35 +0000
Message-ID: <b9bfa2f1-5946-4437-b5c8-b4f40959e44b@siemens.com>
Date: Wed, 9 Aug 2023 17:02:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] testsuite: Fully integrate vwworkstests into
 smokey
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
 <20230725082959.5144-4-aaron@sigma-star.at>
 <d80c7841-d6d7-4014-807c-63afe6db6366@siemens.com>
In-Reply-To: <d80c7841-d6d7-4014-807c-63afe6db6366@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d80d763-5fe0-47f4-ec10-08db98e9aa31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VUwALi7VlG36vFvbFXRT8GHgVMniNdz1AKiEr6FHDtRmixY5wB6ti1k7K4vYDX+7yMFzK3bx12N3XspOFCbsgEE812Vikcx6W0uooSXiMk5tKnnUp+brt0FfrknT5t6c/md8XP3jpODL2VVMtuKeyi4or14cMLTorURgtId+1dx+yDemwGZwoDVbBi1m1FXA+dfiVrc2UL00v6MsMpEyf21W68LuyQj7o8JU8FfGk9uYEUajAsmaWHDN2MbckbxEOSPn5iUWVsyMPyorrek2FNwEWwiJrdGNyBmIbdNYzkXZHs17mGDyTa/PqCXb6E3E+oLYoHTUhau9SFDOsqWIXBqWP73nVxusyRGs+AsIp7XhjJc/u3EwTyou0EouyxXBnR7/ytH1Tko2dHI/BLYKPjno82/ra6WT1QgQ1w8sJyXqejm1lozwcDGb2Um3afYFiZPscCycXpUWMX4mICRxmAOd4/yDsZ7NGyoGG97SI5ziYsO1OG+hMyK8SgJpqSTj6dACnY1S+TXdvDxi0F4mQF3gbcblv0qxb1Au6JV4yPqntMMyTKBjkLK5K4mf0sHGAD9uWg5cFaLhED7XsIsln5XeJ3DZNnpLhRWl8FLQ3BCP8XMPIBP1z+f+Vxmndsjz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(186006)(1800799006)(451199021)(82960400001)(478600001)(31686004)(2616005)(83380400001)(966005)(6512007)(53546011)(26005)(6506007)(8676002)(66476007)(66946007)(41300700001)(8936002)(66556008)(316002)(31696002)(2906002)(30864003)(4326008)(6486002)(36756003)(38100700002)(44832011)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpZRzlRLzlwc1dpeUFVeDg5REltVXFaUk5xQmdpMWJUU3NkenNTRTNpN2RD?=
 =?utf-8?B?aFQrVnRqZExYK2lBak11WXJqejBzcEFhbXdyMm9XVjRHODRJdUZqbTVzMGU5?=
 =?utf-8?B?bHlkMnR3Zk4vZG91Ni8zemQ4RHp5Y1cyVWtRQ1VIcTlISk4wM2ZkNGpRY1lx?=
 =?utf-8?B?RXFpWTNVZmhEbjBhRW44dnFXS21ndGpRaWRCMHgySGVYYjhHY1BGOXhVaXZv?=
 =?utf-8?B?djVXcVFUSk1SOFV3SVJZYmRkT2QxWnJYdG44UVNLS3hwMDhHN3M5NTlPRlBU?=
 =?utf-8?B?Q0lLa0pjRUZ2dkNTdXJXSEJ1TVl3ZFRoa3BXNUwvcDJCRzhwam1uMGl5cFMr?=
 =?utf-8?B?ZDNOVzUvUldzUk5LYTczSStPa09MNTNsV0dvZENjQWFBSmdxMm1SdDY0VXor?=
 =?utf-8?B?SG1LOVh2bnUrVm5DSm5zbm9DdFg4RzAwempoMzZmU0lrd2I0YWttQWJQbmti?=
 =?utf-8?B?NWl2Mm0vaWVwYXFBVkxUa2pnRDJoeEsvaHpQUG9jS2xZYStWQ0RleHk3dVVO?=
 =?utf-8?B?REdadnRvYmZudStUd05SODNkMzRkTjZHQ0oxMmJRc2p3TFp1TEJ2ZUovdzk1?=
 =?utf-8?B?MURFZXk0cG5rQ2N5eW1ialFqTzI0Y0JzbjB1WElJL254RGZwNk0yT2Y5aEZE?=
 =?utf-8?B?Vm9FcnZicFNia2FCTEZGdWRBS0s5bXVuWFl5VHFOcHlrR3JsUHM2Qnh0L0pN?=
 =?utf-8?B?SXpQTnlRcFFOK3dpL2IwQ21xRlg5Nk1CNWVRblRkcTBJajltWHdJTkFwU05D?=
 =?utf-8?B?T0lBME96bEhaRk53WnAyNDhac243dEdpdnRBbGJDYnBla1RjbzVYN2tkd25u?=
 =?utf-8?B?TVAzT29ZVnpabzd2RlJOOEx2SlhXQXFmcE10L3orZnJqMytBMkNzZmtzdmI1?=
 =?utf-8?B?eGN6UWlFYStuR0hieTNaRi85dkNIV2JBN3JCTWpBU0RyS0Z5cTJvM1U1bm15?=
 =?utf-8?B?OHpRTmtMRzM1bWlGSVd3T1kvVmpsUEt1MndHVjhjbUNmOTMyTXJWMWp0WVcx?=
 =?utf-8?B?TlVyN3A1RDk1L1pjVFZyU3hzYU1CVXpQL0ZOVkhENHdDSkxCV1VpbFNrQmJ3?=
 =?utf-8?B?VEo0c2VyR05wNUQ5VlZKdkVQV01pTVlSUUdCK2Y5Z0oyc3k0b1NGNld4SXRB?=
 =?utf-8?B?aVhFSGxtMWcvN0tuTld5S2RwZ3J5cG84c0doWGk3emRyWXdoeWlXR2x5SnB0?=
 =?utf-8?B?VHBUQlFabExMVjRuUGpoblNUQ3cwd3YxYTJGeWZWMXpFZE82b1JhdUZOUm9s?=
 =?utf-8?B?bmZpSTdXMEVyV0hqUU5TeVNuRzB0SEthOEZuSFYwUk82N0NOMXpMZXo3elkz?=
 =?utf-8?B?UC9kdVl3MUhUdStqTFpUalJ5RXZVbXpwVWdtWTRHaGltQnc1RVdlbUN4SGJR?=
 =?utf-8?B?SEtZSFZTQ3FqSVhwMWlyZm95MWRDVEoyUE9OYTB3RkQwdG5WZXoweXBnSWY4?=
 =?utf-8?B?T0g4a3JkSXc3ajRDcno0Tnkxd1Zva3pZR1NuQ2JuN3F6ZGh6ZWNnVC83U0Z5?=
 =?utf-8?B?UVZqNVVqVy9TSGozM3NxN3V1T0ZSVDJ6THlINTFYem9vSEE4RDRiVlBZU25C?=
 =?utf-8?B?eWJ5bE5wUTdZY2FKcEdqUkNpSHUrZ3U0cEdubExQSkNKaVpINVlwaVU1ZU9L?=
 =?utf-8?B?TGNYU2hHNG1XUDhZSi9QSWNYbFJiZGpkc25hU1FUSitiN1F6RTdpU0tYaUdH?=
 =?utf-8?B?T3krT2t0dm5ZV05JcVJhaTBkN1F0NHZjMGhXNHoyemN6TTAwN1pYZkt2SG9U?=
 =?utf-8?B?M3dhd2dtOW0xcmlKL2h6RmpBTmo5M1ZhTk00cmxGZjNPRWVwZ1J0ZlhkUFJT?=
 =?utf-8?B?WXUyL1J2TXdaRExNZmxKcFJ4bFJ4LzRsNkN5QmhNMkxnNUk5aWJqV2E3c1Iw?=
 =?utf-8?B?d1ZEWXd0cWNsZUV1U1JsNHp1Ny9GTEFXNVRBNEVITEsyVm5HK2hkVjgvaFJh?=
 =?utf-8?B?NWpZTkwxYS9wdmdtSjF0SXZoOEs4QXF4RVRuREFPRUNaTlRSNW5wRllydHhI?=
 =?utf-8?B?N2tCOTNucFFMbVpiZTJmaWw0S3N4V3F0Y0p4MDU3MitxZnArTGttV2xHZlhZ?=
 =?utf-8?B?OWNMdHB3WXd2RmEwNDViOVlMTm0wZEorY0swemV5MlpselNadFJyeWx0ZWQv?=
 =?utf-8?B?aVYzdU85OVRxU3VGMCtpcGRPUW5pYkxDZi9KTkV4bjU5dXkzTGNyU3NmTmpP?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d80d763-5fe0-47f4-ec10-08db98e9aa31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:02:35.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afJpBblMGGee5boZp0Gqyz90cDYez0HvKowTl4ol4eBNKW4qPVV/EeCy42n0edWh4tadduwPQQsYba56fp9sew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374

On 09.08.23 13:32, Jan Kiszka wrote:
> From: Aaron Marcher <aaron@sigma-star.at>
> 
> Same as for alchemytests and psostests.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> [Jan: fix whitespace issues, clean up makefile, do not hook into automake yet]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  configure.ac                                  |  2 +-
>  lib/vxworks/testsuite/Makefile                | 43 ---------
>  testsuite/smokey/vxworkstests/Makefile.am     | 95 +++++++++++++++++++
>  .../smokey/vxworkstests}/lst-1.c              |  1 +
>  .../smokey/vxworkstests}/msgQ-1.c             |  1 +
>  .../smokey/vxworkstests}/msgQ-2.c             |  1 +
>  .../smokey/vxworkstests}/msgQ-3.c             |  1 +
>  .../smokey/vxworkstests}/rng-1.c              |  1 +
>  .../smokey/vxworkstests}/sem-1.c              |  1 +
>  .../smokey/vxworkstests}/sem-2.c              |  1 +
>  .../smokey/vxworkstests}/sem-3.c              |  1 +
>  .../smokey/vxworkstests}/sem-4.c              |  1 +
>  .../smokey/vxworkstests}/task-1.c             |  1 +
>  .../smokey/vxworkstests}/task-2.c             |  1 +
>  testsuite/smokey/vxworkstests/vxworkstests.c  | 45 +++++++++
>  .../smokey/vxworkstests/vxworkstests_driver.c | 33 +++++++
>  .../smokey/vxworkstests}/wd-1.c               |  1 +
>  17 files changed, 186 insertions(+), 44 deletions(-)
>  delete mode 100644 lib/vxworks/testsuite/Makefile
>  create mode 100644 testsuite/smokey/vxworkstests/Makefile.am
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/lst-1.c (99%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-1.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-2.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-3.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/rng-1.c (99%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-1.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-2.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-3.c (97%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-4.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-1.c (96%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-2.c (98%)
>  create mode 100644 testsuite/smokey/vxworkstests/vxworkstests.c
>  create mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/wd-1.c (97%)
> 
> diff --git a/configure.ac b/configure.ac
> index 9db5438eb6..a601f94cd3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1045,9 +1045,9 @@ AC_CONFIG_FILES([ \
>  	testsuite/smokey/x86io/Makefile \
>  	testsuite/smokey/alchemytests/Makefile \
>  	testsuite/smokey/psostests/Makefile \
> +	testsuite/smokey/vxworkstests/Makefile \
>  	testsuite/clocktest/Makefile \
>  	testsuite/xeno-test/Makefile \
> -	testsuite/vxworkstests/Makefile \
>  	utils/Makefile \
>  	utils/hdb/Makefile \
>  	utils/can/Makefile \
> diff --git a/lib/vxworks/testsuite/Makefile b/lib/vxworks/testsuite/Makefile
> deleted file mode 100644
> index 648c9be90a..0000000000
> --- a/lib/vxworks/testsuite/Makefile
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -ifeq ($(DESTDIR),)
> -XENO_CONFIG=xeno-config
> -else
> -XENO_CONFIG=$(DESTDIR)/bin/xeno-config
> -endif
> -
> -prefix := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --prefix)
> -solibs := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --libdir)
> -
> -ifeq ($(prefix),)
> -$(error Please add <xenomai-install-path>/bin to your PATH variable or specify DESTDIR)
> -endif
> -
> -TESTS := task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4 lst-1 rng-1
> -
> -CFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=vxworks --cflags) -g
> -LDFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=vxworks --ldflags)
> -CC = $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --cc)
> -
> -all: $(TESTS)
> -
> -%: %.c
> -	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
> -
> -install: all
> -	install -d $(prefix)/testsuite/vxworks
> -	install -t $(prefix)/testsuite/vxworks $(TESTS)
> -
> -clean:
> -	$(RM) $(TESTS) *~
> -
> -# Run the test suite. We pin all tests to CPU #0, so that SMP does not
> -# alter the execution sequence we expect from them.
> -test: all
> -	@for t in $(TESTS); do \
> -		echo -n $$t...; \
> -		sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$$t --cpu-affinity=0 --silent && echo ok || echo BAD; \
> -	done
> -
> -test/%: %
> -	sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=0 --silent && echo ok || echo BAD
> -
> -.PHONY: clean test
> diff --git a/testsuite/smokey/vxworkstests/Makefile.am b/testsuite/smokey/vxworkstests/Makefile.am
> new file mode 100644
> index 0000000000..a0aa9df764
> --- /dev/null
> +++ b/testsuite/smokey/vxworkstests/Makefile.am
> @@ -0,0 +1,95 @@
> +testdir = @XENO_TEST_DIR@
> +noinst_LIBRARIES = libvxworkstests.a
> +
> +libvxworkstests_a_SOURCES = vxworkstests.c
> +libvxworkstests_a_CPPFLAGS =	\
> +	@XENO_USER_CFLAGS@	\
> +	-I$(top_srcdir)		\
> +	-I$(top_srcdir)/include \
> +	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
> +
> +CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
> +
> +test_PROGRAMS =				\
> +		vxworkstests		\
> +		vxworkstests_lst1	\
> +		vxworkstests_msgQ1	\
> +		vxworkstests_msgQ2	\
> +		vxworkstests_msgQ3	\
> +		vxworkstests_rng1	\
> +		vxworkstests_sem1	\
> +		vxworkstests_sem2	\
> +		vxworkstests_sem3	\
> +		vxworkstests_sem4	\
> +		vxworkstests_wd1	\
> +		vxworkstests_task1	\
> +		vxworkstests_task2
> +
> +vxworkscppflags = 			\
> +	@XENO_USER_CFLAGS@		\
> +	-I$(top_srcdir)/include
> +
> +vxworksldadd = 							\
> +	../../../lib/vxworks/libvxworks@CORE@.la		\
> +	../../../lib/copperplate/libcopperplate@CORE@.la	\
> +	@XENO_CORE_LDADD@ 					\
> +	@XENO_USER_LDADD@					\
> +	-lpthread -lrt -lm
> +
> +vxworkstests_SOURCES = vxworkstests_driver.c
> +vxworkstests_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
> +vxworkstests_LDADD =				\
> +	../../../lib/smokey/libsmokey@CORE@.la	\
> +	@XENO_CORE_LDADD@ 			\
> +	@XENO_USER_LDADD@			\
> +	-lpthread -lrt
> +
> +vxworkstests_lst1_SOURCES = lst-1.c
> +vxworkstests_lst1_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_lst1_LDADD = $(vxworksldadd)
> +vxworkstests_lst1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_task1_SOURCES = task-1.c
> +vxworkstests_task1_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_task1_LDADD = $(vxworksldadd)
> +vxworkstests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_task2_SOURCES = task-2.c
> +vxworkstests_task2_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_task2_LDADD = $(vxworksldadd)
> +vxworkstests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_msgQ1_SOURCES = msgQ-1.c
> +vxworkstests_msgQ1_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_msgQ1_LDADD = $(vxworksldadd)
> +vxworkstests_msgQ1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_msgQ2_SOURCES = msgQ-2.c
> +vxworkstests_msgQ2_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_msgQ2_LDADD = $(vxworksldadd)
> +vxworkstests_msgQ2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_msgQ3_SOURCES = msgQ-3.c
> +vxworkstests_msgQ3_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_msgQ3_LDADD = $(vxworksldadd)
> +vxworkstests_msgQ3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_rng1_SOURCES = rng-1.c
> +vxworkstests_rng1_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_rng1_LDADD = $(vxworksldadd)
> +vxworkstests_rng1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_sem1_SOURCES = sem-1.c
> +vxworkstests_sem1_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_sem1_LDADD = $(vxworksldadd)
> +vxworkstests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_sem2_SOURCES = sem-2.c
> +vxworkstests_sem2_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_sem2_LDADD = $(vxworksldadd)
> +vxworkstests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_sem3_SOURCES = sem-3.c
> +vxworkstests_sem3_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_sem3_LDADD = $(vxworksldadd)
> +vxworkstests_sem3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_sem4_SOURCES = sem-4.c
> +vxworkstests_sem4_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_sem4_LDADD = $(vxworksldadd)
> +vxworkstests_sem4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +vxworkstests_wd1_SOURCES = wd-1.c
> +vxworkstests_wd1_CPPFLAGS = $(vxworkscppflags)
> +vxworkstests_wd1_LDADD = $(vxworksldadd)
> +vxworkstests_wd1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> diff --git a/lib/vxworks/testsuite/lst-1.c b/testsuite/smokey/vxworkstests/lst-1.c
> similarity index 99%
> rename from lib/vxworks/testsuite/lst-1.c
> rename to testsuite/smokey/vxworkstests/lst-1.c
> index 03dec367d7..878f32c902 100644
> --- a/lib/vxworks/testsuite/lst-1.c
> +++ b/testsuite/smokey/vxworkstests/lst-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/msgQ-1.c b/testsuite/smokey/vxworkstests/msgQ-1.c
> similarity index 98%
> rename from lib/vxworks/testsuite/msgQ-1.c
> rename to testsuite/smokey/vxworkstests/msgQ-1.c
> index fd15e1ddd9..71eedd44f5 100644
> --- a/lib/vxworks/testsuite/msgQ-1.c
> +++ b/testsuite/smokey/vxworkstests/msgQ-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/msgQ-2.c b/testsuite/smokey/vxworkstests/msgQ-2.c
> similarity index 98%
> rename from lib/vxworks/testsuite/msgQ-2.c
> rename to testsuite/smokey/vxworkstests/msgQ-2.c
> index 58f11e3a16..d3ee1397c7 100644
> --- a/lib/vxworks/testsuite/msgQ-2.c
> +++ b/testsuite/smokey/vxworkstests/msgQ-2.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/msgQ-3.c b/testsuite/smokey/vxworkstests/msgQ-3.c
> similarity index 98%
> rename from lib/vxworks/testsuite/msgQ-3.c
> rename to testsuite/smokey/vxworkstests/msgQ-3.c
> index 1a4e20d26c..a23d5c3d09 100644
> --- a/lib/vxworks/testsuite/msgQ-3.c
> +++ b/testsuite/smokey/vxworkstests/msgQ-3.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/rng-1.c b/testsuite/smokey/vxworkstests/rng-1.c
> similarity index 99%
> rename from lib/vxworks/testsuite/rng-1.c
> rename to testsuite/smokey/vxworkstests/rng-1.c
> index dd944a58ac..1e179c6f66 100644
> --- a/lib/vxworks/testsuite/rng-1.c
> +++ b/testsuite/smokey/vxworkstests/rng-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdio.h>
> diff --git a/lib/vxworks/testsuite/sem-1.c b/testsuite/smokey/vxworkstests/sem-1.c
> similarity index 98%
> rename from lib/vxworks/testsuite/sem-1.c
> rename to testsuite/smokey/vxworkstests/sem-1.c
> index 245eb5c484..b64aba3b8f 100644
> --- a/lib/vxworks/testsuite/sem-1.c
> +++ b/testsuite/smokey/vxworkstests/sem-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/sem-2.c b/testsuite/smokey/vxworkstests/sem-2.c
> similarity index 98%
> rename from lib/vxworks/testsuite/sem-2.c
> rename to testsuite/smokey/vxworkstests/sem-2.c
> index c9befc4d9f..67caf2924f 100644
> --- a/lib/vxworks/testsuite/sem-2.c
> +++ b/testsuite/smokey/vxworkstests/sem-2.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/sem-3.c b/testsuite/smokey/vxworkstests/sem-3.c
> similarity index 97%
> rename from lib/vxworks/testsuite/sem-3.c
> rename to testsuite/smokey/vxworkstests/sem-3.c
> index 1041d25b0d..1f4252e3d9 100644
> --- a/lib/vxworks/testsuite/sem-3.c
> +++ b/testsuite/smokey/vxworkstests/sem-3.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/sem-4.c b/testsuite/smokey/vxworkstests/sem-4.c
> similarity index 98%
> rename from lib/vxworks/testsuite/sem-4.c
> rename to testsuite/smokey/vxworkstests/sem-4.c
> index 5c82169e19..0a8daedb1d 100644
> --- a/lib/vxworks/testsuite/sem-4.c
> +++ b/testsuite/smokey/vxworkstests/sem-4.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/task-1.c b/testsuite/smokey/vxworkstests/task-1.c
> similarity index 96%
> rename from lib/vxworks/testsuite/task-1.c
> rename to testsuite/smokey/vxworkstests/task-1.c
> index 3cf5f38061..a07d643c39 100644
> --- a/lib/vxworks/testsuite/task-1.c
> +++ b/testsuite/smokey/vxworkstests/task-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/vxworks/testsuite/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
> similarity index 98%
> rename from lib/vxworks/testsuite/task-2.c
> rename to testsuite/smokey/vxworkstests/task-2.c
> index 46d99a266b..7f9f0f0020 100644
> --- a/lib/vxworks/testsuite/task-2.c
> +++ b/testsuite/smokey/vxworkstests/task-2.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>

We still have failures with this one, see

https://source.denx.de/Xenomai/xenomai-images/-/jobs/672278

2023-08-09T22:41:46 vxworkstests_task1 OK
2023-08-09T22:41:46 [8] at task-2.c:86
2023-08-09T22:41:46 [1] at task-2.c:33
2023-08-09T22:41:46 [9] at task-2.c:92
2023-08-09T22:41:46 [4] at task-2.c:58
2023-08-09T22:41:46 [10] at task-2.c:98
2023-08-09T22:41:46 [5] at task-2.c:63
2023-08-09T22:41:46 [11] at task-2.c:104
2023-08-09T22:41:46 [2] at task-2.c:38
2023-08-09T22:41:46 [12] at task-2.c:110
2023-08-09T22:41:46 [6] at task-2.c:67
2023-08-09T22:41:46    0\"009.525| BUG in __traceobj_assert_failed(): [foregroundTask] trace assertion failed:
2023-08-09T22:41:46               task-2.c:70 => \"ret == 0\"

Seems like taskSuspend is failing. Please examine - or let me know if we 
should disable this test for now as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

