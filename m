Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6CA4429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXMaa7rso2DegIyZxYLmx/DRZuxoMcVUNxjpZSjCeaPWOictvfG40CfsRf6e915JVHsK2/CF4vlJsdJpbjK70rAjCOw7o7fsbOgq+TAYboStpkqqHoiCjoYhhhQ8EExi/HNGieo+VR+Sv/3VyPu2kV5IGujRtnJKWvlfIaIbIm28IA6prOX2jGGrmSiU4eX0+2I3KYwpx72YzZqxMTjAEtW+xmh7vJwz65Vak20BPaVHgLKlEeBGUY4SqYnJotBgBlLuEwXrhMjZi0w2LpegYXLKeZJQ06ogiFpECjxjVU2z+Ic5xVpD8xNY8X8FPnkFRhLLMKgCLjGzelSMXcPHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT+kL621QZQg2y868G6jLoq6Zw0jAZw3WtJVqP1ukVs=;
 b=GlQzd1peqHWSYAilISqoSQ/gnJy4sAbCav7BIb0PdipYK0JZkMKuJLBuBXrMOg6zHIB2pnFnf+7VjeZwEFe9ccQ4ccGN8/Fy5vbgEb/fyX2P6MplROEvxMKO75posAgOVMLtNltRtAxO0eBGfboTHKd+U0eOMwz4WVnOlSyj2Sjrhxf1FTknNqltltpfAwH8JFpHKZktLVxhv7mhEjqDB2BqH34UWfpSZK4Vi4KMf3N7yjQQpBCBA7K07nrsNAv4LnvSqnmsm+pIM4+lDoYToGn/96yJt3rMFmV2ofxUdFTDS5i5bqHV6tS89Bs2PfCZImwzmgY92mBBYXwmrnpOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT+kL621QZQg2y868G6jLoq6Zw0jAZw3WtJVqP1ukVs=;
 b=wlnGyBTb+AdEigUiFETUIKUArqlZb+0V4+P91dCkkW7+Hw4DGSgqCTCG8QO54tTY3mxswXEplbN04xX4xRX+rnFALx24QSsVrRU7QqnQKxDzKkegy6150EZk36U5FF6DI7Mlgn1897wJ8Z6OlnBuZgJdcLQuv0+uafNSC90/yNBXTvTzZT6nxQX9LQA90vE9O7Jfslc6yENlv0EwEzQu2OyZ0H04wpA1wGvYhikwqoAtCtQUEPX4tGk1aCuL61L5We+B74dHrm8f/IkWidqezRw+pviu9+tuT6JJvf+Nw/CTdgpE/w5XEX6OVyWl50gX/eWRgOBgXlor/fFl5PGg+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:59 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:59 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 11/42] y2038: cobalt: posix/cond: Remove compat syscall for cond_wait_prologue64
Date: Tue,  9 Aug 2022 15:42:55 +0200
Message-Id: <20220809134326.23688-12-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6725e742-4821-42f1-b660-08da7a0d368b
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1OsGrxm08fTkuVffDFJ7groQ/Jcr7/oRTOBXp0I8Bgcfv7v/pNiI6Z60Xuv/gXE9Lvr1J/CvQ/UpFDEokSS2U6T1+x5qPjAjRScxt+J1eL9YGmfiSKqQm9yLuqFJ0oSgQ0qiYleQ61c3dnx7ecpcdtcxYKUKFzjSSXrLyLJ2+F8bMuRiVliVG7/uD/43b7QI3d8iyDXpBKKVwNcM8vmG3/BhTaxBT3exY0/uc2EpwydOHwsfjgNS1oyrQsp58Fdlf88wpCHKfEt1/3pekqjOfxN6m53xPkHGxAKeezGT0c6eGGzD0RC2Ix8IbQ4+tFsRvtF0a0yQ0DVyk/u7TbdBtvVLXn2l8fk6feXXN8J/+JyO62VybFCFdnmGhlm4pdfvl+WVdCj22YAERdmTDnZ2+NJK6cJrjrIUWtIT3DLCCpeGKLVxUwDJhv7WfgrVNkHLc1Ul3nDccjD70UVeZlQPr121nLSbsp4uf44OYCcG+7S/UIvAcWmdoaV5ODqGCuMgSyVqTMG6ucm1v4eLtBJyLMt4F9n8c1Ta/Cuxlw4dBm/kI5/+xEXyEOfJ2sfzZQKdKGVEcfa8J4wFWCtALKHJj2pSo0yeIR1kxbOwTGvwvaBgdb3tnUSV2JwBV2jXqTMCBjJs2nUcQ0fHVsDh1eevju3gCwIRU2z4xT6adOlwKl6G11goMnsZM5GJcQQ+5GOXAQOjLQtejx420wSGb+ltDTbBEc+5G/5k5qftE9ObioA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaYnRVvbgPl8s7BSi/KiHoktiRxaxnF1bhtBhZpYFhJSdWqUHjK65g1mKOL0?=
 =?us-ascii?Q?d6sWybrn8pa2V1vtCh6eaHDR6261vWdeEIrzLEpaKhiT1xABWAEPN0FMeAoT?=
 =?us-ascii?Q?7y+x90f945tfTeTsDe3TFjz4lwuJ3C0ljHSltrWpTNH9Vl7rZBx0IWmMB9AI?=
 =?us-ascii?Q?lJLpSZrq3f0mtJF98NzRxlJFC0vuZcF4cwa9JXtZJLgssO3rEP9OPRmd9lu/?=
 =?us-ascii?Q?+YGm1Ogjfrf4q0YRS6H65DThGJhy+YtVHyX3DDzYX7MWiUGtRxP8cTzeL7nQ?=
 =?us-ascii?Q?HxCMVovxuT9xtsWEFa0G3DRWrLbkigqwpqXIydVyMUjF1vRMyVgSWyQ7MZKG?=
 =?us-ascii?Q?cQ9KcsHzouWwf0lu3mJE9+9vbTlgI4WWbZ7+VfLtPcsrvNsepD6pU4Ud+HP9?=
 =?us-ascii?Q?7yGB0Yhu5jcBYCQMlBDDclsRe6TbBrbBHZBeyuMs0FJZurHXBlreceTfxD9f?=
 =?us-ascii?Q?XmkrZBEPUXPP7rnkRy3j0lYrrtPxbN8l0aqzoTsREIEthS1cJCqdb09UdKeZ?=
 =?us-ascii?Q?d2VMPxWuLABdS0Nup+7A8DIFgBsGimw0+XtLlpqIfPazYzzLBOPVN/R+dDlF?=
 =?us-ascii?Q?WTfN53nzxc6x0PAVDbDB00ILCiKI4/WzxLv8GYalVFja8CUfsADwlCyk08Wm?=
 =?us-ascii?Q?DLW302SenQRXBVE2PdCp9+W3PQxbnBl7XbrBQaaG26fixNNnkXYKeKJx28qF?=
 =?us-ascii?Q?mUwXy+NWokLSeA6XPWpfN2x3/vUHf3B09OSMVrxIb2CiMT3ZZt8vbp1AuV7Q?=
 =?us-ascii?Q?3rDOnA2LWrsIjJ6W4WyGqqRuceH7VtpcAKe+pHxd/iegGYvZZGHhefe2+n9V?=
 =?us-ascii?Q?FRJZWDFzkz8q+1tb2OlFbZRxE8TRt/Ss3yCelKR6Dwpbn2M4Zfjs8RZzEi0J?=
 =?us-ascii?Q?tjTRdrWJjg/uEFvuOAN7aCIIBlXw5+XZC6CvaQBq1NxpKEzwPoF8rzUL+9NA?=
 =?us-ascii?Q?KW5P1pz8gO1dSGPxc5J/tGWRsMfdqWTViOr8CclJCvbPo+DUmXxffN3cu/sB?=
 =?us-ascii?Q?UwrkiN7LVHGjSvHSIR6EMo00zzdtKuKlc3WyXWv8N8v/33BKUZN2B3+uxhIm?=
 =?us-ascii?Q?t1drbIspFjc5Nw7Q22k1g1esQUEZWjm0B5dt4JTXzzs2llNl7Xob7wI670uP?=
 =?us-ascii?Q?clMIv27IGNqvOX9bDhldRlT3qLKcxrwaLkXk1PEYpyHa/3MfcdaqP2/0rwK0?=
 =?us-ascii?Q?uEdfaEwV5lPLMhRMVZuJWUlxZYTyfxqFRbelXQeytw3aVDhJdq+R+WdQhlWL?=
 =?us-ascii?Q?+2kxMChIxNTEWp8PfsJ18drFL8qzeqdxmY4UAK3u9OxO3NfkL6hQAK9Vyd1t?=
 =?us-ascii?Q?nGmsFYjtYjLGSGduW5DpxjCO31hHFQLvpoJ4uMPXzOfaIjRmfuFvxdmJLFP1?=
 =?us-ascii?Q?kD6Mq9z47WScZPSPejBj0PPjFd+lahzI4vlthob5atDFO48eJBljtoQgrDNk?=
 =?us-ascii?Q?RSiPk9Df0Efz+ytSEzlW5qY5gSEKp2co6FjHYVV146toSCNLfMMHGfQ3ncpf?=
 =?us-ascii?Q?8hX4twFrL5ww5BHNq/gFw51IiF5EEdG/lnvbRFAWcgNc30zpQjjo80Lg8GCM?=
 =?us-ascii?Q?4o44NHATYoUkDMSdRYCPvLq0k2BFzbSrtgmLGntQrrctapkeeVURKaj+S/QS?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6725e742-4821-42f1-b660-08da7a0d368b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:59.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVZD8IQhz0/m+Eimq5SkOuMhn43rmO4ifePyCgd4F1zhQFRamw4ZyjvddRoD5rO2X8Bo5UdMhcJi9LfE7+v7o6UOWuS8bM0c73PjKgQ6DMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/cond.c      | 12 ++----------
 kernel/cobalt/posix/cond.h      |  5 -----
 kernel/cobalt/posix/syscall32.c | 10 ----------
 kernel/cobalt/posix/syscall32.h |  7 -------
 4 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
index 95d1e75bc..7b87fe908 100644
--- a/kernel/cobalt/posix/cond.c
+++ b/kernel/cobalt/posix/cond.c
@@ -354,15 +354,6 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 	return err == 0 ? perr : err;
 }
 
-int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
-				  struct cobalt_mutex_shadow __user *u_mx,
-				  int __user *u_err, unsigned int timed,
-				  void __user *u_ts)
-{
-	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
-					   timed ? cond_fetch_timeout64 : NULL);
-}
-
 /* pthread_cond_wait_prologue(cond, mutex, count_ptr, timed, timeout) */
 COBALT_SYSCALL(cond_wait_prologue, nonrestartable,
 	       (struct cobalt_cond_shadow __user *u_cnd,
@@ -382,7 +373,8 @@ COBALT_SYSCALL(cond_wait_prologue64, nonrestartable,
 		unsigned int timed,
 		struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_cond_wait_prologue64(u_cnd, u_mx, u_err, timed, u_ts);
+	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
+					   timed ? cond_fetch_timeout64 : NULL);
 }
 
 COBALT_SYSCALL(cond_wait_epilogue, primary,
diff --git a/kernel/cobalt/posix/cond.h b/kernel/cobalt/posix/cond.h
index 1fd4256ce..c2fdd40e0 100644
--- a/kernel/cobalt/posix/cond.h
+++ b/kernel/cobalt/posix/cond.h
@@ -46,11 +46,6 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 				int (*fetch_timeout)(struct timespec64 *ts,
 						     const void __user *u_ts));
 
-int __cobalt_cond_wait_prologue64(struct cobalt_cond_shadow __user *u_cnd,
-				  struct cobalt_mutex_shadow __user *u_mx,
-				  int __user *u_err, unsigned int timed,
-				  void __user *u_ts);
-
 COBALT_SYSCALL_DECL(cond_init,
 		    (struct cobalt_cond_shadow __user *u_cnd,
 		     const struct cobalt_condattr __user *u_attr));
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 97981bda9..10b080dfd 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -236,16 +236,6 @@ COBALT_SYSCALL32emu(cond_wait_prologue, nonrestartable,
 					   timed ? sys32_fetch_timeout : NULL);
 }
 
-COBALT_SYSCALL32emu(cond_wait_prologue64, nonrestartable,
-		    (struct cobalt_cond_shadow __user *u_cnd,
-		     struct cobalt_mutex_shadow __user *u_mx,
-		     int __user *u_err,
-		     unsigned int timed,
-		     struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_cond_wait_prologue64(u_cnd, u_mx, u_err, timed, u_ts);
-}
-
 COBALT_SYSCALL32emu(mq_open, lostage,
 		    (const char __user *u_name, int oflags,
 		     mode_t mode, struct compat_mq_attr __user *u_attr))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index c96fa1379..3df6224b7 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -83,13 +83,6 @@ COBALT_SYSCALL32emu_DECL(cond_wait_prologue,
 			  unsigned int timed,
 			  struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(cond_wait_prologue64,
-			 (struct cobalt_cond_shadow __user *u_cnd,
-			  struct cobalt_mutex_shadow __user *u_mx,
-			  int __user *u_err,
-			  unsigned int timed,
-			  struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(mq_open,
 			 (const char __user *u_name, int oflags,
 			  mode_t mode, struct compat_mq_attr __user *u_attr));
-- 
2.37.1

