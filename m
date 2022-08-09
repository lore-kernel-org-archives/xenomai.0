Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354234429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaDQ8Tlm2ZXL0LcJYXxsgbIy6hv1y7ar9HT6i2VtUQtfrbEHwUjYC73+1xgakkvBPZY9AA/Rz3NxmdWwNrQS0dvT+8hykjzlNKI1FETvyyyzA31/HaS3MhGcwCuCVOU2mkuH06FeFA9ryDtAe/qtLwQjMfU/pE/zdrYJkaQU+IwxbOvtP40mW0bp5KNCzkCofoqgSE1qEE6uSblzfJeB7L7XMAgyuYvb+UWZRAeIC9YLwFVBuCfRn9YltF6uP2PRCs/E20RAD51FPex9HPnFnptiKPu1VgH0eApxwYUlEzS7aZL7DezSdv3J4NXbvUmfPJsCiCodRyRmXnwR3EEPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SsgC+BoyRJSMcegM9n5mHFV7aaprZb0KduOMCz6WWA=;
 b=XTQY4KJJWOSOHG9lgfwtnl7WcjSc5VnqHJ7p3O3kds0KoETAinjuqzOzBvrsuHlXYGqXzFe8CQPvdB65/l5MpTHVJy13Uq9wZX8/D3wo4kVGdv0Xi1iKB8sAaZ6mW8yojMwPUDP9RStuPCcdoWhuc+NT8TUtt+C1I2lVgUlPzzq522B/L2HUJCVtGysPjVB2vpmyAii3lP5ex4a3/Vq648jChz8WdFk4Qb1rUEF+CKaLh8IH6RxCwREu/d+Ll059jE9AXXdWGOnmUvT4SG9vuFxynF3UnQiXH9TjXPFcMr9sIXdZXMKLivF2iCldcYn+/QKT+TQWqoCZ/5i1ZEmO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SsgC+BoyRJSMcegM9n5mHFV7aaprZb0KduOMCz6WWA=;
 b=MiOQZIDin6Cx2Fr9vBfTaSdk1Tr47FbADIU/qNow9INrPUcK3RiO54J1bTUq6bbdT7qrrCY66PV+qNQKc1R8Yh22Jo0DORi/B1O5gG0+B7Onv0HiHsgzeV+yupKsuzLvYSSUHAtwCw7MWEVJGI2SDXcZSbFKxsbfqjpF9Y9QLYX5S/hrAgQeTiuaEiT0h97MEiT3Pke8uncKvh/C11yhxqUGcsbBfb3cDRWHuD+lsp1AtiD8ggIaOxr6IPWUm5KHZKzMjUOL23rz2ir55HFq+vdO2GeU/knuJgwlhbdnoNn+54woI3b0EVTV0RPwHj8Ohuyr96fdrDjF6iZidOTmrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:51 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:51 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 35/42] y2038: cobalt/posix/select: Adding pselect64
Date: Tue,  9 Aug 2022 15:43:19 +0200
Message-Id: <20220809134326.23688-36-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0206.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::26) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 238d13ce-316a-44be-e9ba-08da7a0d44fe
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AM2qP/1UU9/R7tre6Hc7FbRXyqzrnXeO917HFdLPnd2SA34U5mHREEdzuze2zsvg8ZnpPIQQrtKl/3eVBNH6vJMhdKZ/eEeQwQYKJvYBo6Fm3S1LU4lui2ujqzgAhBuWMj20uz/izdt9KN5ZGtlB1v8TrqwcK1CfxmsHfKus6gKX4ZCVx2tkJCIln2gp2AI6lL6HJC2qH7LkV+FCPzcMabmynZGKP9cJFSoVy7D4xW+rkpGHghdWSZwYagsAp/L+i2RICv+T0lHgF+BGECiZaLXqzXe41PnJkxq5w4d4Bh2pyqDD6JNUzfSh+Ma5BuLmSbE1zx77BtyQ48aPW2g6fHxa2Vo2PA525sSd/Nb9AOx0rgn2TdmGtfHtZIi7cjsilaspm/u85O96oE8VR9qhfTd+LcWbwBrXi1+pT8MNrP1kJKfFFr0MdULI/ZaZTG7KU5shESoeoEB9LUKH960fYpVg/CaqpaDzzVsSas0heZHd1tZnY0yZjUxTOrdj82BEwntlNMNn/xuNTizOBjvHcP+wTOlu7AGpD/zfTKt4SmG1krEwlYylIi9MP4Ofv4JP3RK4szsqB0VFBIiZo5CXZ+Vs8R4BEbsigjh+zsuM/3dJ2URo+zIeBpSpC2DeQBvRPOUXCSmHWn9LoweK0c73CGgPOU8cH02NwShZ8/g0GFX6KKx9+H1yHpfjBFxPBwS0dVPZThKbRZIHsgzHhi3n7Bx/kpt9qAF1FiZcQOeBEyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(55236004)(2616005)(186003)(107886003)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?edZun9IWQ+6NcB1oDHp8CuVUDXJ8NE9gh9xgvfoY4UnvW5f1Wquw1zvPk7rK?=
 =?us-ascii?Q?Hul0AcDxX67i6HudMT/nk7pefNyFtrLNU4Fgud1UPTK0iJbv8DxuCLVoCC4p?=
 =?us-ascii?Q?W2Za+YvJnCjhM0zu5GJ+BDpmV79dXqBNzbCef/HY+POVJiXzzV52kyyBiU8T?=
 =?us-ascii?Q?tSVc5AW4zk4T7ZhZG0JpEvpJCVjEn2eE1tbncgrf8Gpl4srYoe6AP0m8GObV?=
 =?us-ascii?Q?GMgvtev0HlyW99NUeB2fGgpGkoM6IjAPOS99SuNay5NqgR0z4wbq0+IgQGSw?=
 =?us-ascii?Q?Q4KAEUBkiv7GzP0j90qxLw0nnL0Ju3NATeCtWjyK28EtDe+HL9E7qGyN6og5?=
 =?us-ascii?Q?WX2ioAzJsmQts32+w9rs06X5HpvvfjSOvE3zzLLOANVwe2HFip0GeJEaegnP?=
 =?us-ascii?Q?qAb8Bec2iS+IEhxyWv5Rbm9V0V7WX+oxzE8Yr0rnSoeZ5D8aOONHmDgy5hKl?=
 =?us-ascii?Q?XJt2jcy7LJNy9JoaOpD8MoT6IHYCkUNDR064lBnKdvUdHHrJ1noKwi/L/gXA?=
 =?us-ascii?Q?29gtNb/9L6DIk9/BQSop85TQhgo6nD7AAKy//rw0djrlNtiECtCHS7JNKNKs?=
 =?us-ascii?Q?mWUa8GZTY1yQQzMA1uu9XMDdemFHcRTfrfsuyHTTqFq1+xTRG2j8hgEr4tGj?=
 =?us-ascii?Q?dGy9KUbYg7bsI8RO4y3oKpXnZM4vGIiMGiHUKk4ECAf9iIhOLkPEdEtIihJI?=
 =?us-ascii?Q?AICPFNVLg4gzte5/JDn9TuYq46f7KFqpzAVGtwg19GdDP2QBqtTtCTyR1+QW?=
 =?us-ascii?Q?Opoq56E2jZVBOdHmAMzyDF8xJrh/+hjku8WxHy1235qu5wRW8WeAA9lCVHLo?=
 =?us-ascii?Q?/P1ZFcr1/mFPFwqC/NXzjP7DO2rvN0XKtPYRngBPLp2b7unBSA4dzLtYykLC?=
 =?us-ascii?Q?QrPfTTIa2nE/66gQ/Zou82A3C/FYwnjXMc13v9KfnYqnw+3QVt8Zo/fU/ocj?=
 =?us-ascii?Q?JzBP4Q5EOORXOihn0+rEB0iiq/vFtGIRJC4Gvf7b8bVBtM0MqKdsgTgKNyee?=
 =?us-ascii?Q?JkqSzF3RhgtslxG4ctSRiEVgvgyPG2AUrmY4JH5/j8Jc2MXMP5el0uIfMU9n?=
 =?us-ascii?Q?+uY4g15LSeSW5bIBBZaADxoxxE2lpkOuAXbEIyNtKKXOriSZxQCA+2dn5FGB?=
 =?us-ascii?Q?FJmcqSXT2jGIk623VFgmkbfsVZ7yeneDgcVFhyI0o/rRV55fSYNEPmYOvzf2?=
 =?us-ascii?Q?HzrO0Ik7uKbWs8/9VLrbldSosPBtQLMbcLunHmYwf1/sBTcUZrUvG6DYxYup?=
 =?us-ascii?Q?nLbFeninOUVr9pSuRNTx42birfuVk/rJnm2KjiJEiKbFQJm+1Rk0gZiBVgE1?=
 =?us-ascii?Q?5CeADBm5TxLtkZSj0rjiKDY1ygprLTrT7YdwnwaWgR6w+nooxrYyjq+REgq1?=
 =?us-ascii?Q?Zfu4eY2WI7S8CD7SKJ5uXTWEkflxiQ/VN65ovECidGn9cvCXkvNZZWk4cMRo?=
 =?us-ascii?Q?wqD+AijM55Gp7qDOHCFAoNFCbAMDrM5ifIMJR/uGmbA3ACzQiAF206vlysBe?=
 =?us-ascii?Q?g5uuh8iseauxGorI3Wrr6RanX0w8Ps+vbPUVh1WZoqfoE5G/lhGt+uq2kwvq?=
 =?us-ascii?Q?166q5C2lYfAysvZiYlwoxu79MgnR+k/QzBlDNkMn5SXJ8/phO4Zq5Gildxc3?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238d13ce-316a-44be-e9ba-08da7a0d44fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:23.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++/K5kgKbfSAaM2LSkVupQRRq5H1R+O1FB8L77vb7FqGUV7ty4zyS4Y8N09IQeC2jsu94lH8mSdzSy2dfF9fmB9BjNy+grN/BIAo1TWjjMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

This is not a full implementation of pselect() as we do not support
waiting for signals yet. The xnsynch infrastructure is not prepared
for that.

We will not wrap pselect() in userspace. We will only use the new
syscall for providing y2038 safety for select().

Another reason against a full pselec64 implementation is the fact that
the XENOMAI_SYSCALLx() infrastructure ends at XENOMAI_SYSCALL5(),
a real pselect64() implementation would require XENOMAI_SYSCALL6().

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/io.c           | 32 ++++++++++++++++++++++++++++++
 kernel/cobalt/posix/io.h           |  8 +++++++-
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 2dca90071..3e65efaab 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -140,6 +140,7 @@
 #define sc_cobalt_timer_gettime64		117
 #define sc_cobalt_timerfd_settime64		118
 #define sc_cobalt_timerfd_gettime64		119
+#define sc_cobalt_pselect64			120
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 6709ef639..acfe03329 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -390,3 +390,35 @@ COBALT_SYSCALL(select, primary,
 
 	return ret;
 }
+
+COBALT_SYSCALL(pselect64, primary,
+	       (int nfds,
+		fd_set __user *u_rfds,
+		fd_set __user *u_wfds,
+		fd_set __user *u_xfds,
+		struct __kernel_timespec __user *u_ts))
+{
+	struct timespec64 ts64, *to = NULL;
+	int ret = 0;
+
+	if (u_ts) {
+		ret = cobalt_get_timespec64(&ts64, u_ts);
+		to = &ts64;
+	}
+
+	if (ret)
+		return ret;
+
+	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
+	if (ret)
+		return ret;
+
+	/*
+	 * Normally pselect() would not write back the modified timeout. As we
+	 * only use it for keeping select() y2038 safe we do it here as well.
+	 */
+	if (u_ts)
+		ret = cobalt_put_timespec64(&ts64, u_ts);
+
+	return ret;
+}
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index 1d9ee0918..ca46aa309 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -24,7 +24,7 @@
 #include <cobalt/kernel/select.h>
 
 int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
-		    void __user *u_xfds, void __user *u_tv, bool compat);
+		    void __user *u_xfds, struct timespec64 *to, bool compat);
 
 COBALT_SYSCALL_DECL(open,
 		    (const char __user *u_path, int oflag));
@@ -76,4 +76,10 @@ COBALT_SYSCALL_DECL(select,
 		     fd_set __user *u_xfds,
 		     struct __kernel_old_timeval __user *u_tv));
 
+COBALT_SYSCALL_DECL(pselect64, (int nfds,
+				fd_set __user *u_rfds,
+				fd_set __user *u_wfds,
+				fd_set __user *u_xfds,
+				struct __kernel_timespec __user *u_tv));
+
 #endif /* !_COBALT_POSIX_IO_H */
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index f2ffdb3a2..47dc77e1c 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -172,7 +172,8 @@
 		__cobalt_symbolic_syscall(timer_settime64),		\
 		__cobalt_symbolic_syscall(timer_gettime64),		\
 		__cobalt_symbolic_syscall(timerfd_settime64),		\
-		__cobalt_symbolic_syscall(timerfd_gettime64))
+		__cobalt_symbolic_syscall(timerfd_gettime64),		\
+		__cobalt_symbolic_syscall(pselect64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.37.1

