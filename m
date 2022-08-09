Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83FA4429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNjNOSYG6MWYPNON4P1aeAb81nBT4ohKCKWOlyNnWpG6nUbn2zHFgjOWssgCIMl4+ogzVoRV6b9TkEOVLTCHO5vx3HzOOLWr/h/sjziQeGXGQVXn5/xvDli4Wcj6TLlFIE/cqa0yA+3I59aMn1tiLjCW/If6/MxsD9yGa6PNPFUNnplpmw4K+TSrgRuqEEXOHQ308SCJRDI1rOdlcpzueRgJ8UntlS3LiFq4ZLFInPpAkUibSQmC16C0eQree/smMXaP6g1tenNrxm7FbCceOSpBXZkPqtQ2y9Q3rbi3Xk8fqTtWOZO1cwf1+gniJxwKGf3446fRa8c+CfpQsIeOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N94Ipr5mn1mGniVMTR62PzelPuBDVAlgzUKyD3SnTzQ=;
 b=hmmIYoZVDN355pzDoOb2Yw1u+HJm498uIJ7Hg7pa4xQM4e7ehVInQT5Qt2U2FEBCNLU87CIj0DhKtFRLo+UPrr3/0Qw0fgJCWGM6rETs2ivaAAxiPpdOfRIjBK4+qXVsPb7XX8o8qkjaIqacZRPp1XQ9M2Li9SeWIZ31oAOxUksoIO0x30l/6hqN5f+3MJO9kG5xq7YfQkOKNuV1+THHigSdNAkrNzwuO9fRnNLU9WVJTYIceXwOmNDW03lM8uaQPvohy+u9lXN61P5EdCZp6bmM+M5wbyXm4/YkhMYqPu++6nUDUM4EJe6uohhzlrg90X87RbwrsQQ0miE9mU7WuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N94Ipr5mn1mGniVMTR62PzelPuBDVAlgzUKyD3SnTzQ=;
 b=fNwkt9uAjImc88XwbIsUCjXSJaU56fxnyktvJqyuOL/ctVAWWAWow8PbhES0x5Q5CR5SV2I72SpJG9hsK1roO8kLMLS9VeSaAu9fArryfa1xtYO+dmLTBX5rcpzbgHGSjwKu+zNGUu3ye9OTed0OA5mTypvYm2LlStGXb9X7q7w9p1x4ywW+TrxdllxynP66QKBX5cM2U6CexfeODdpjVfKmpwNZhaGaMpjcId4Q79G2lIQwhs9iNCiEqzvKcBpmE7iwbFtfuD0OiKT59ZzS6BwZVq4yRBxrEfSn5b2dk1NiKZyUlvxPsfF328Ll8aovg+e+nq3xBnRQnytYmE0qWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:57 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:57 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 09/42] y2038: cobalt: posix/monitor: Remove compat syscall for monitor_wait64
Date: Tue,  9 Aug 2022 15:42:53 +0200
Message-Id: <20220809134326.23688-10-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 788f7fd3-f8a5-4246-c30d-08da7a0d3574
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l5eTV2nvir/fNgOpjIht4otk8wF1+iD9YLu1v/1HYr6LlmwbbGBgWzcYaLkNjgnMl0uJ9tHWd3ON4fCg27Ru0V0HCO9pYGHdKGUJFlmAZ86KVPlPRVaoK+HvJKkhTmdhwGQ1/RVlwuxDsvcloCh7fyHPZ0CUA1dU5viJV3fgr3bKbCOuOf9L5xpNfxyiCrvdJnkLdXDyse+VTfQSMqJWk/WzA35YEDFd+HNCAXF/w7xSxQikNuURWiDih/fw88RzLE5jTfvk9FsysJNC+zgKsZ1h6eRCxLHXu5+7SFqBD7DS6+1zrMvazrKJue9xlOun3YWe0+7odWEPpEmzeQPhd3pJb2iIEYZovR8/+cMMR+aX0XpvT5VbfWEfDZAGYakXteRQVhThdSUd/tNdzJqsVDnY1eAlPADRQpHBGcZ8BTGwm757t8PeQ4plZC+DGTHmLszdMdRWHv+Y6gYOchuK9LgrDttEMop3/fxrEq7JOBMip9yD3MxOjb+cqlyXknB0/jlIUocjeJU7UBFzv48V8gmLCr6dZafODuSl+GlsxXfj8GrHxNwEEk4QLRRfJGuuDFGI8RCVysrvv0fJlUbo7BSz9ifzB2N7hchEtMPeejTF7685fwqe9mAcFH7EyZahoF+d6/ZIhVc+gbVuwqMmv0u8tdbk7Wk34EP8K0C8lJlxl+/Jg1KXytMVugmQz6EAfoNAVQRrkmvUx5lPj/9o5f41UHHJMUoTYUhi/0e59ao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zqBWNSMCipqqavVW3PLzA1aU47EM+A4KLqhprCAYy4WoYdnLcNaMcXyt4Ylk?=
 =?us-ascii?Q?zjqhJH7tTLtkEhSNY4eifqMRL6mdohOCFQ+MaH0Aawag3XH+K1RKujGx7oDf?=
 =?us-ascii?Q?8R2QtBcSDymPXfJeKVnfHAyghFV6E+KtODQChyhVBY9EY3tdPDwJVbykXfuR?=
 =?us-ascii?Q?+3cmArUKS87ARl26g40MgIMVmUza1UWT8z4hgk5B6fPqg3z0hkIrZ0WUGKZm?=
 =?us-ascii?Q?DCZeqzK9bJQR/cjwlbmsAX0bcH6oXyQxFSo4Eb4Rl8qMbR2Xm/HLEXwNXfw4?=
 =?us-ascii?Q?7n2SsM0mBSbvksKcoldaPdM2E99x1cSOIW8UZEtNzDeunL7eeJjR4H9c5ioZ?=
 =?us-ascii?Q?eQNnkm7rGWPvnwtTpJJzK7kZ/ucfRLyhpJVs7b+p4Pqp+LUPn3hVu9lHzMLU?=
 =?us-ascii?Q?etVImSMd8YT0FF72M7M3xsG50mH0ilpY5au1JrtVHIHW5zYJ9oR2+Lw3b++S?=
 =?us-ascii?Q?i3JIX15IfzYGvqQXEFKIbKKuRthgT9AGOavUvEIALB1QAGNomuxSLcG6srb0?=
 =?us-ascii?Q?RXYdGRuf22CQ3kV00l8FNyAI/9qjf2CzNOhlIm1soNK77/HYlEHAS9WfUi9t?=
 =?us-ascii?Q?VhtANSqUu7SlgDFY3BRxoNLnCVhpULoh3AzQK9HCGJPso0GliRzJikmBjBzV?=
 =?us-ascii?Q?gInLOnl5LayK1F2m2QRp8akyVN+VvjS+HkJCb83a8jqFj0K6PdveytVdq7lB?=
 =?us-ascii?Q?w6WKqeqHd5MkPsH5w6vLgKprYnTwhjhDmQXvnW2t4kWMN0578VplycG+sBo8?=
 =?us-ascii?Q?8lJtZ45Sq0ZuHmPA1Ug23Igs5fv/iIfOsDpOXRmoYZ7mjbuKjRlxPS2+cfRX?=
 =?us-ascii?Q?UjQoAZ3PLyAj/XqCXDXzAn2gcLFAPau1tdwTX51Xr+OyWQ8CFawzRTqij+G1?=
 =?us-ascii?Q?AtBkyK0FZQ9bF5gmSp+4ca4qwVm4Ma0WGyuUyRZhboQw7Y9xkDAUhc20Ts+k?=
 =?us-ascii?Q?yQ9XtiWPDrPKLMJdmJqbaqadAG/7cbwc8gmBw6EdaHUyDp7aWbbBFpRh5uBs?=
 =?us-ascii?Q?7knd0jThJh44BRiFYBTIVoTCjv/izBbr/E6Yrx0OwHxSF7/8rentu9DKlDf5?=
 =?us-ascii?Q?2jV/cbiQbVfqJSwkdPylSPd5eE2WEqBQIRbbJbVcyPnWv3a/dgBzd5D9Imx3?=
 =?us-ascii?Q?Rs8znxidm1zxVYC2lveWDS2N2asJ1s1H/bjF3ojeGSqfUzmfoMVHaqPAF9DD?=
 =?us-ascii?Q?KNTUuCy16qO2nvqa+KQqJ0D5ULPlb23k0uCwuXtWBS8cVNaqRgvZ0Kxa+g5b?=
 =?us-ascii?Q?sHNkx7RsZguTh8pb4t5Q+dulqfbxxIJ1Rfx6yyeT2b8CFjx6p/Pi088dXntC?=
 =?us-ascii?Q?nh7AwK1GGmMdBvVG35hu3Xgf6794Bc9NUEt548EefJXPfIgp9rUXT6n9AJH0?=
 =?us-ascii?Q?/eI6mb/HEzYkg7/lclzxIK0tYKSueyY0xUf75UYjiyCJNX7cV/KUA/6UTAcZ?=
 =?us-ascii?Q?J0dAlsmUfh42Hdv4FR33eoyi6q5LdKfBJR75qcHBc1ghbrkFbQUQ73HxKwPU?=
 =?us-ascii?Q?wmfqyLLBmSYNEC/tsddT9pQxalP/OOFRZF/9KCciFKbZFS4o0rmeK3AFcv+t?=
 =?us-ascii?Q?HJ7J1e3BUzPF5alPK4TW/5LUHjELQeSF9sHYUGYePIqO/v45wl3koiyqQc79?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788f7fd3-f8a5-4246-c30d-08da7a0d3574
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:57.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSRzISBccbs/2EhLj/Eu8J721iIx4nBJagOhjnHzrNzEU4Zpq5iiFuf5OSdsyFANhCfiBNDrY5tVGlVp9hz7eweMZTNZrtFHRnKtOH7CPHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/monitor.c   | 26 +++++++++-----------------
 kernel/cobalt/posix/monitor.h   |  5 -----
 kernel/cobalt/posix/syscall32.c |  8 --------
 kernel/cobalt/posix/syscall32.h |  6 ------
 4 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
index 1e7128352..c266b8b3b 100644
--- a/kernel/cobalt/posix/monitor.c
+++ b/kernel/cobalt/posix/monitor.c
@@ -294,17 +294,17 @@ out:
 	return ret;
 }
 
-int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
-			    int event,
-			    const struct __kernel_timespec __user *u_ts,
-			    int __user *u_ret)
+COBALT_SYSCALL(monitor_wait, nonrestartable,
+	       (struct cobalt_monitor_shadow __user *u_mon,
+	       int event, const struct __user_old_timespec __user *u_ts,
+	       int __user *u_ret))
 {
 	struct timespec64 ts, *tsp = NULL;
 	int ret;
 
 	if (u_ts) {
 		tsp = &ts;
-		ret = cobalt_get_timespec64(&ts, u_ts);
+		ret = cobalt_get_u_timespec(&ts, u_ts);
 		if (ret)
 			return ret;
 	}
@@ -312,17 +312,16 @@ int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
-COBALT_SYSCALL(monitor_wait, nonrestartable,
-	       (struct cobalt_monitor_shadow __user *u_mon,
-	       int event, const struct __user_old_timespec __user *u_ts,
-	       int __user *u_ret))
+COBALT_SYSCALL(monitor_wait64, nonrestartable,
+	       (struct cobalt_monitor_shadow __user *u_mon, int event,
+		const struct __kernel_timespec __user *u_ts, int __user *u_ret))
 {
 	struct timespec64 ts, *tsp = NULL;
 	int ret;
 
 	if (u_ts) {
 		tsp = &ts;
-		ret = cobalt_get_u_timespec(&ts, u_ts);
+		ret = cobalt_get_timespec64(&ts, u_ts);
 		if (ret)
 			return ret;
 	}
@@ -330,13 +329,6 @@ COBALT_SYSCALL(monitor_wait, nonrestartable,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
-COBALT_SYSCALL(monitor_wait64, nonrestartable,
-	       (struct cobalt_monitor_shadow __user *u_mon, int event,
-		const struct __kernel_timespec __user *u_ts, int __user *u_ret))
-{
-	return __cobalt_monitor_wait64(u_mon, event, u_ts, u_ret);
-}
-
 COBALT_SYSCALL(monitor_sync, nonrestartable,
 	       (struct cobalt_monitor_shadow __user *u_mon))
 {
diff --git a/kernel/cobalt/posix/monitor.h b/kernel/cobalt/posix/monitor.h
index bf8794e36..3c76a036b 100644
--- a/kernel/cobalt/posix/monitor.h
+++ b/kernel/cobalt/posix/monitor.h
@@ -42,11 +42,6 @@ int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
 			  int event, const struct timespec64 *ts,
 			  int __user *u_ret);
 
-int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
-			    int event,
-			    const struct __kernel_timespec __user *u_ts,
-			    int __user *u_ret);
-
 COBALT_SYSCALL_DECL(monitor_init,
 		    (struct cobalt_monitor_shadow __user *u_monsh,
 		     clockid_t clk_id,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 0197c749b..dfa4d31ec 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -733,14 +733,6 @@ COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
-COBALT_SYSCALL32emu(monitor_wait64, nonrestartable,
-		    (struct cobalt_monitor_shadow __user *u_mon, int event,
-		     const struct __kernel_timespec __user *u_ts,
-		     int __user *u_ret))
-{
-	return __cobalt_monitor_wait64(u_mon, event, u_ts, u_ret);
-}
-
 COBALT_SYSCALL32emu(event_wait, primary,
 		    (struct cobalt_event_shadow __user *u_event,
 		     unsigned int bits,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 5569af7d8..973a0befc 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -195,12 +195,6 @@ COBALT_SYSCALL32emu_DECL(monitor_wait,
 			  int event, const struct old_timespec32 __user *u_ts,
 			  int __user *u_ret));
 
-COBALT_SYSCALL32emu_DECL(monitor_wait64,
-			 (struct cobalt_monitor_shadow __user *u_mon,
-			  int event,
-			  const struct __kernel_timespec __user *u_ts,
-			  int __user *u_ret));
-
 COBALT_SYSCALL32emu_DECL(event_wait,
 			 (struct cobalt_event_shadow __user *u_event,
 			  unsigned int bits,
-- 
2.37.1

