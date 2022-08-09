Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CC4428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUaW0z/iXTubD0LAO9YG6NOffOq0G6J0zgThN/d36MzXgszfSaE7MRl7922F5pPF7RIImkjSmEzaXw3CVCj8xxJd2cNOdvtpUMiZ9Z3lboVu9ULRIycCrECuoO+SJiNylvQMiJJi6pRs8QTLC3xKcNAfOc4h2/h8ee5/Y4If4fdOr26RQFyORPqzYvCsxTP3du6433TqbZRQJOViNj+i1Orx7a89HlIGkPWUGpz3X9ATHAO5ug60freC95TTcFx7XhT4cBkb1P1oRSj/n/rA8UrPkHnG8/hul7Iv9/kK5Ap8z/AcU839EmcqwfIhnd4dk8aIfR0ClU9EUGsk4PRzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVMyKiwKBColDEJ9w2hOhQi73nYWgdA55sKw4jSIuQw=;
 b=he89/5162Ytru2sMEmwa8QmsNqitKIMUFNo/tFlS0GrDZiNlAJmWyYKBxwcA4JfsuGXlcAUTMfV4M0AhrTnyj1tgfyD/MHaQPToU6wgpNOL271oF+pZrUJeHPH6hahoQ+6BTcNvNyyV25ZSeuh+sOWMZ5z2SKhKwa8RvfK8LzK8aOAIjLgXRs9FIV3To7S2jHt9ge+FVXoh05eUmpvp0a1sWZ8b7cuib1vrs6G5wo9IGv4ECOmeIfs6kbVsmL4Wn9fuguWNXBDQofH4jr8YsyIFJ0gGKwwYVgqL5Jeim32pWIb0NK7ELrHPIHI8BG4p72qEoey9Npw9XhRz5O5WfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVMyKiwKBColDEJ9w2hOhQi73nYWgdA55sKw4jSIuQw=;
 b=rc2+TE3y/i8Bo4wH0VgrFqXHQBRpjfvULtGqEWalW7Ig62FL2kChkfN0onkJIziELnPw3wfHIH5LlRAaGugec3mrUZ+sOfoYTxuqZAKHM4Q3ZLVX7tcvEzR0xwO8BNO0lCAsoI19oQXjqGJcUiguA5Ew55/V1zhSFycYOEBEAzAm6hLTKjn1AsRDCJ5ap+pVGpCkOzQA8W0hIt01mCunS50FOFMb9XAV6HxaF3vMV+UVsOwhxfuAd9Sl3kJ7/rqrbM2YEBWWzHLL6Xn3XSji7nMQ4CMoxWYgHbK5Z+IR6syFq3E6Lqe8/fuTOEWzXrK/tV/a86aGQ4vWEj+XBnW6Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:49 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:49 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 31/42] y2038: cobalt/posix/timerfd: Adding timerfd_gettime64
Date: Tue,  9 Aug 2022 15:43:15 +0200
Message-Id: <20220809134326.23688-32-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::17) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e0dd758-a261-4b2c-8174-08da7a0d42c2
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tazVp5wgGatuWP2RgdbWXmTvhwxLK+v+CqftkjrsAC/aA+bCf18qJKKWgu5IYvwGsa2xQi9DrDhXGnLYg1HLIvA8MlCuPtOLDSlqlrHzHSOesciiz8CGyteEYN2fmyoapvLiePcKlt5GP3Mu4foLEcO+Fs/asctzhq4XdZjYYCfYdSV6Swfn6fNufqhq8dhMdXjajqPh5lnjHfK1inyNVwTboB/BdyFUOGYPoPwZaKczZq898py9IubIg4bxZSVXHv4ECOWP4bbl3nkhVnaLgmE8jyK1VADxBMq9cAwQh8G/1pwHmEaUj4Zpysd0S9I7Y+KPNMvSH1RA3mUViZTUHvW/YopZs9tQ0tE5kQzubQSx55GJZc7QNhYFcx2Tscp0CzBt/40VH1k9FlPjmW7M8bPDcaUIuoQnufAlG9LtNuG8OlTwZm+l1EQ4IW/CXXI6k8h+/e1FUQoupSq/NgYpfhnHFtabh2d5jCUfCVVnOrzRRXNUpPpGxujZJ+vbu/QNPbGg0fPcZEpbTtuMVRgoNxwH1742prUf2ozGhqeaaWm2/ArBpzCFBiahjmV1WfJKZls0Q/MXAyzllTBwuq9i5zuTA01tsa1rEvBEKVhxL15SiDgZhKtMU9MNblfoVQwjXY+uxwxHFDjsvBoSce5E6RQf8xl80WlO+0M4DzZMbc0Y0vMiPPFb0R4vAZt23hZ4a2vSZPBl02cc1rnslTqPRiBS9gsYehpBks0DuDL7C4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VD1vz+BUslIYU6nLU1YF3VzPMWL6Gx61mHcZxkpbeT/BmixG52Gl/yOn40uT?=
 =?us-ascii?Q?6PW5ExOmqVbyE0wZWUFafy8FqY52gnrclDr893vsAxj4PNDsWpMvTNnDWJo+?=
 =?us-ascii?Q?klupao6jm7yRu8N0vnIkI/bY39caYlsDx+LIE6jxXFX4hWovnNc9G6D4PaIA?=
 =?us-ascii?Q?MOs5gs7CG6BhTCO+ZkdmctYtWynBR757+euF+p9R9HTTwwu+VFR97qax/ac+?=
 =?us-ascii?Q?bWTwO8k9lNxHMZElWAwk7KWyDSo+WQrrJfNKEzVccqvf4bSdsP4/l304BOk5?=
 =?us-ascii?Q?nQ1/hSLpRcOxHE+2zzjWC0JOBK91RuNTZpVpK4xYypUfBvKP36JbDnlk7K49?=
 =?us-ascii?Q?Lk9hF4tM0k8+nIhJiFAt0ciKVuwAk5Olt1ZkMfIFNqHeRWDVjt1fiAuG3S5j?=
 =?us-ascii?Q?iI9CuZrP0dw8SuTaN4twN2Q4dFc4cBiEknat4DuQ+55C02Fwj7hVH+5QZURw?=
 =?us-ascii?Q?sj8MXl9+UYgSoaJzkfYPAjrxpK8mr7aDjb65DmMXTd3otlHSY9HykruryI/h?=
 =?us-ascii?Q?WUDicj46+q3P6HFWASD07hFR7zdrH5FLi/lE1N5By8LwWibbfwsyWxFjV1FG?=
 =?us-ascii?Q?2c+ZYTv83FfAb9G2prUjjSe3GkHfGDM6dReLlz9Ytkh8dcI6Etos0vSMwYkc?=
 =?us-ascii?Q?WBdOGtujzOVMtWZRyjf2q92WhnhSNnRBMrTXiKcfXCVeov2pD6AVIX3Z5S9R?=
 =?us-ascii?Q?n1aT8OGLsFAO7IeGUQx/BpXT7kBd/GJJCzWnzsbdRuZbCeCBc1p/WVvHGmha?=
 =?us-ascii?Q?Z0twE6rzarcVLapg9F4DUwOD7fiOUOTYNRm5doLgFZG44TnynJtK6wJBGbzC?=
 =?us-ascii?Q?kqOvu5ntrJ0XYlEQm2MGC7xFMEvZrWTwUHwwiOfy9q43VFPK7eGh/ibNL9Va?=
 =?us-ascii?Q?Zj80ROMFIzfHB6q5MLJJFVNr2XY8PMUzSEM3P/PdFShpG0LWTkmLsJQW4Yp6?=
 =?us-ascii?Q?mxpwG/cMm1Ne1wOCx6kF4w3k6nu1y9HxFGJGXW7WJomJHCCHWZwyPwY5yEUX?=
 =?us-ascii?Q?/JERX1ewE2LFh3pikOK2F9cTp6JHUVv1/zssE2Xqwk9GM6VPEgRuqlVARWPU?=
 =?us-ascii?Q?t7I7zq26xOHoFUyq0+oipdsdnkGNJdXtkRfn3hYSPxT7em+gyuwqm6bAhpvW?=
 =?us-ascii?Q?ZJcXf4fW5xz35h6P1mjKK3gbhD/G0HwQ305xRWv37Rb3nu5topz5mVyAqNtm?=
 =?us-ascii?Q?4veG9nzXT7+pBDB/sJSSE1Ne/qEbPyCXyCnnOJssHEliJ/hdUH58dz6YPAwV?=
 =?us-ascii?Q?WQoh08WHyPNedNInXrACwoAzPfIRQA3JjNL0MTVpm2nnLqMh+x82j3AIYsmF?=
 =?us-ascii?Q?Pgm28r83r15s5gMSps8qyhIZUVPSguiXe+BbioyfiiOUZ0oHjDKnI7i81O2u?=
 =?us-ascii?Q?5I9NitTCJSFFQie+8ocVPxossKL3vlPjdhgFmF4f0vy+A0JgPd1dl40dAaJI?=
 =?us-ascii?Q?qhcV49Uc+piSQ71kWdexil5qPtTbr0WtlVlG26JSNjLRHbvItPxJP7wEloGM?=
 =?us-ascii?Q?cUbLNcgdc6tTJIB6SBlj6YhBi6mSKQEWMcfM7bzX4oISqaRTaX3Hp3XwOHLm?=
 =?us-ascii?Q?8qJa3XHvdrBtx8QdvOCAPz/8itnpkg1U20MjspgrCWKo5/1sU6hpC+8S+bgT?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0dd758-a261-4b2c-8174-08da7a0d42c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:20.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /C96e2UDdZ3zHTn0E56w6d0dTOGjiU0gX3gtsX0cKlvumOGOdNtNioYlGieL0Wi9EMvbftWyWov0X2VBakaZ794lODVk2W1lPIgtnOeSf7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

Add a syscall specific for timerfd_gettime with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/timerfd.c      | 11 +++++++++++
 kernel/cobalt/posix/timerfd.h      |  3 +++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index b8271618f..2dca90071 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -139,6 +139,7 @@
 #define sc_cobalt_timer_settime64		116
 #define sc_cobalt_timer_gettime64		117
 #define sc_cobalt_timerfd_settime64		118
+#define sc_cobalt_timerfd_gettime64		119
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index 9b2683ad9..ae7578d29 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -359,3 +359,14 @@ COBALT_SYSCALL(timerfd_gettime, current,
 
 	return ret ?: cobalt_put_u_itimerspec(curr_value, &value);
 }
+
+COBALT_SYSCALL(timerfd_gettime64, current,
+	       (int fd, struct __kernel_itimerspec __user *curr_value))
+{
+	struct itimerspec64 value;
+	int ret;
+
+	ret = __cobalt_timerfd_gettime(fd, &value);
+
+	return ret ?: cobalt_put_itimerspec64(curr_value, &value);
+}
diff --git a/kernel/cobalt/posix/timerfd.h b/kernel/cobalt/posix/timerfd.h
index ae9945152..b82dac748 100644
--- a/kernel/cobalt/posix/timerfd.h
+++ b/kernel/cobalt/posix/timerfd.h
@@ -44,4 +44,7 @@ COBALT_SYSCALL_DECL(timerfd_settime64,
 COBALT_SYSCALL_DECL(timerfd_gettime,
 		    (int fd, struct __user_old_itimerspec __user *curr_value));
 
+COBALT_SYSCALL_DECL(timerfd_gettime64,
+		    (int fd, struct __kernel_itimerspec __user *curr_value));
+
 #endif /* TIMERFD_H */
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 3d396674c..f2ffdb3a2 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -171,7 +171,8 @@
 		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
 		__cobalt_symbolic_syscall(timer_settime64),		\
 		__cobalt_symbolic_syscall(timer_gettime64),		\
-		__cobalt_symbolic_syscall(timerfd_settime64))
+		__cobalt_symbolic_syscall(timerfd_settime64),		\
+		__cobalt_symbolic_syscall(timerfd_gettime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.37.1

