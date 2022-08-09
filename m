Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5473442B
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dle1/rQT49wh8zGwNvEC3rnlUAyb0C/P+/otNqM2TyAQeGXjjE8dwqrHPODEfypEuUjNeeu75cjDZwnA6tbqsQrcqR3KmZ5d9sF/3Z9nYh7xWv2/9ZkfK4pXHOnrlKuNq87vDF5Qk/7MQ5w0DgYphBxtXV9phAT6EydElSfz3R+xZTVsKxt2uvBc1PctssZlW7DE8gBBvbZmg/OFcXtlPHng0weJwpwZuzZmGeFVIecZx7il+0dGlG5T9IANb65qOomL4i2+1AklmtCDcluOXrrMdsEKFaC/tNRn+eMMB8tTM1IaJSQOn7vjmff5Skg+b7WKvc3T78/iF0CVq89eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUkLeZU9Gj5zQYUwu/WQvOjePSeBkXpzKHVpsYEHIBw=;
 b=cgPxHesmA0T8T9hLn/HKv+FOkyisbm9okA7+tsmSuEIw3nOhS/KT/3V8Ud+3KHAwF9wcJnIPYnzspqzDHfb9t8pvzqhtbfiDIseUi75VU6N+NhNkUzJJdbQdRDONj6hE2c7AK8IxDMiwGUlvZlqrfUMp6OabmW1mDeiNJjcgOUQ/0iAW68YsRU4NhTxQnghiaud9DsH/dNoW8NHLTpNzdCUDeJkWxmRe0q8AVP2peP0avg028HT55zexMQwv1Y9QbqGk266fTfxlPqaU/ihU9u2aDMX/LRX5zyk2vBUAsk401mZLc1wv2H1jxgRVAF8fb62DELK3WRrV5jASYKuMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUkLeZU9Gj5zQYUwu/WQvOjePSeBkXpzKHVpsYEHIBw=;
 b=StIBCGV59oRQltq6w/K6IvmUyfrfPyupLtjPvGBpfNNE7m2B1qpF+lvvjQYKsO1yHgBNT/TN2XQ3sEgiaKKiE2YJfvxbH2z7YhH9vrPgEgE/gnaEkRV8WlkLMMFWpdwUYYwyknyd3BfUm5Ttnjewo5iJgNOxi4pb91hiAV7Bm7v5WTqrd+Ddxze0j8tPOeCu2UW/QqKbGih6yAza4r6RmyAmg2Xm4RovwoAvXBZwvxde/qpDL6GJEne2PAxhQHc6sxOsEnVlBE2HmtHXwrz69q+6/CT92mUyzp531cOtgglpDZNP082ZMrqwFS4ONJTN3UzVX0SExSx0yp7Aqu17BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:13 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:12 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 24/42] y2038: testsuite/smokey/y2038: Adding tests for timer_settime
Date: Tue,  9 Aug 2022 15:43:08 +0200
Message-Id: <20220809134326.23688-25-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0363.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::23) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead2aca2-a2a4-4f08-50a6-08da7a0d3e7e
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u1wPToYrRsGHmDgJpHmnKR4G23WtQTTN2ZCprhUD5VWPakEpdifLJ/HlyTc7Mv4nXTGOmg4BVN7ezqFKNHFui9rTTKLv+1i/nNu3jZLmgoufNUEseysgF9AesIXGB+mJuwqlROb+PrvCZ5kUzSlLHRy2IqicyaLR50sLJrYvJRU8dAxNkz/1j3z/ZEG53qV0ddn5g97Vl4qFBRepmdPUhbyvbjP9MOSJnmUOURdFUJFt5byeV9HvLQhCAc/2ftiMLn8NKx9y5Ge7B4POlunXYz2FN3QPPSw2t7WozdOz+Vr+GcN1DxcPXcKa2IpCx+SmZFRdm9rihtQf0fbRSBPkoG3lEeJvTUFnwGWvcq/GRH9d0Bd/57+zR5xAaAlYw27dqMb7gEeVdJI4z0TTWexWgZcXzwO0rWG2d929s0MTC2qS3Us547bYbWSmyE2A3DRW2VeyCbnf3TWx1xTz52aBPO0hwMhmYy2RrwAs35ZhkzIcXIRXaUdVRPTu7Ct4Sxp9nBHQ1tOqNZeuCYvdjOqb3jGQJJ8tCm+1M4oQPnt8MpdsF6r95uqTNThk6mEMSTO/FqkWdeM/hur/DDXxtyzmJl3D/vik2/+fOT3lcTcrG3NFCSuMY1ZZ+dZmGRmSw1nofzyfPLfd0yce463rVN3nmhEWfpudSqxmy7JcQ4zACA5lKpTy5o6DJJ6iQql52js1/wuLSGVdulxCJ59WZSR7XCNRrkcA6IJHZh6/4PXQ0ns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frk1zlMVxIIMKph9AHBgzpSBJdZ034XL6vukXzF06YdfQ0QfPi8pqMUtRFbh?=
 =?us-ascii?Q?AWlAwgzMf5yhmpH8KVWmfa8KEpG0gk37wa5cj7+Czd4nVW6xHYdwlkOmZ9Fj?=
 =?us-ascii?Q?x9XHJHc5i92yNfQGdRI4dMyDTPGDyAr5VRi/x5XDHEDLajHkjyJoub1XJOWE?=
 =?us-ascii?Q?UTUaO8D3vRWyXv7L2Fc71eBTSApQN94U+ah+kvV21mc1TlTjDfd3Zy6tXYGl?=
 =?us-ascii?Q?RI0NpO1fxuNwvOQPnLwIs2OhXVpa2irQKpjFS4CPlXB0p8AARTzfa8wlXcLv?=
 =?us-ascii?Q?qXJEbbWFWxvvmUR7kU5xc0sGyyvRLzdTv4kGCr6BrtC9aUeuUcEbEkEIYKh/?=
 =?us-ascii?Q?hq2A+esUrPOb6Eg6vF+3IgbKAiYzjCs7I0oyGQbVeoqcaxPF5+sj7szN4P6W?=
 =?us-ascii?Q?2s/1U9MdIFTkoqxV14rbPBxzy2Qywxqu5KN5GncfwZQOVzwv8NyqGs9ctksf?=
 =?us-ascii?Q?d+8YEBLHeGEzwZpVew74QV7tmJlB5f5T6uHs0mX6Iyk+TCGe1HKkAIlsUjCT?=
 =?us-ascii?Q?WD5sIkWtAe4R3vjXIiw0qrdwQKaES67EHwYHj9Cx5PMB5wUOz19vJ38nbVfM?=
 =?us-ascii?Q?Y70VIuklfD3paizC83L0YEzCBDmRA1AdzReQIgUDw2OLQWXhX1DPRK5sDj5h?=
 =?us-ascii?Q?hf+h7tOao9hVLvcwtM99VSlx0wjznXamFWrbQXaKj2ViPRiNd+qbZ99ztEWv?=
 =?us-ascii?Q?I/CmobE/pFk4iN7El5tFAYZ5UrbhnhTgfH7h+klOXHPR87t2uN0Mc90kieqO?=
 =?us-ascii?Q?GWQcx3mB5OEdlDHp4800Jsj8JH2cFxT9UL99kgH7hrHx4tmxnD0fCNr7x+Pi?=
 =?us-ascii?Q?HMmCkzHXq47J48/FedCdcPoEKZkeBA/pFDNN5N/fVavy84HHLjZsEaNpEq6r?=
 =?us-ascii?Q?LQ5MUA7O9w2UGO+p5we2d5XhK/08VjmjNGIni4w3en8TxPo9QCRqlFUztLMw?=
 =?us-ascii?Q?9XlX3xnxrwR+NfdA/GOAF/N9BLivqiuovBMGCnNkgpuhBtQKjVMPkWxNN+d4?=
 =?us-ascii?Q?xSCZYIMWYtULTEBJLsynQ/CAxQuZFzBQi21sXNE5bWD5A/q5pYs+HVZbTWl3?=
 =?us-ascii?Q?lpFnrHwdeqNLGYQxwNLHP22n7wjZWqOOLaorGAY6ib/oJRoxrS4RFAMCagmd?=
 =?us-ascii?Q?1e/p/ai4sEIdVeBjskLjo8Ir0sWsIKUlVWm7PTdSghWiq8C9kegQpov1PiK1?=
 =?us-ascii?Q?Nipf6HSYu7Jji28PzuNhKLqnohvet/UdJ+nod4yVLErgZ/IS/XArLCwxxBeG?=
 =?us-ascii?Q?DtzAqWoWXLL4CU1LhFGZ8S0MUs2AbjNkksocbRCzEwVC/rKFGiIu1tRIrFwR?=
 =?us-ascii?Q?zKQpjUCzYBARz5lUs62yGzrIJzdYHu/3Rkjb/k0MSShdCRNMWFScNjIjg08y?=
 =?us-ascii?Q?10E/j18NNlkKM15uJkTdL46qD6s73x2aASHdBBJESp5+uPC//BtvKqW36U1U?=
 =?us-ascii?Q?lFhwxxZtgqGi4pG2Zm7OlVxmzhN2k6SyYLt7OT2oAZ+qWGldnlRsK0hgVmzN?=
 =?us-ascii?Q?PpMBKp13oJ/dO45ZNqW79W83KKG/xN6N3AV2zMWjxiH6lU2i+rdy3c3m3BgS?=
 =?us-ascii?Q?Ql6CS5d1zs+GQZGOwhQ9E9tVPHttGmMt49gN4vhmqAGodkZUktKnqdcMdi0Q?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead2aca2-a2a4-4f08-50a6-08da7a0d3e7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:12.9069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTyPk6WqeutpCnPRJAWlole7a6qxq9Yw0Yd6vOpjwty8/f6JxHgIOnUMB0Xubek9VUWy+//YYaBfqmaOk5Z57XzzV2GLjqvyp/+kuycTf6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

Extending the smokey testsuite to do some tests for the recently added
timer_settime syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 6fcb97cac..8cf533f7a 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -25,6 +25,11 @@ struct xn_timespec64 {
 	int64_t tv_nsec;
 };
 
+struct xn_itimerspec64 {
+	struct xn_timespec64 interval;
+	struct xn_timespec64 value;
+};
+
 struct xn_timex_timeval {
 	int64_t tv_sec;
 	int64_t	tv_usec;
@@ -1212,6 +1217,69 @@ out_mutex:
 	return ret;
 }
 
+static int test_sc_cobalt_timer_settime64(void)
+{
+	long sc_nr = sc_cobalt_timer_settime64;
+	struct xn_itimerspec64 its;
+	struct sigevent sev;
+	sigset_t sigset;
+	timer_t t;
+	int sig;
+	int ret;
+
+	sig = SIGUSR1;
+	sigemptyset(&sigset);
+	sigaddset(&sigset, sig);
+
+	memset(&sev, 0, sizeof(sev));
+	memset(&its, 0, sizeof(its));
+
+	sev.sigev_signo = sig;
+	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
+	sev.sigev_notify_thread_id = gettid();
+
+	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
+	if (ret)
+		return ret;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL4(sc_nr, t, 0, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_timer_settime64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	its.value.tv_sec = -1;
+	its.value.tv_nsec = 100000;
+
+	/* Provide an invalid expiration time, should deliver -EINVAL */
+	ret = XENOMAI_SYSCALL4(sc_nr, t, 0, &its, NULL);
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/* Provide a valid expiration time, should succeed */
+	its.value.tv_sec = 0;
+	ret = XENOMAI_SYSCALL4(sc_nr, t, 0, &its, NULL);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	/* Wait for the timer to deliver the signal */
+	sigwait(&sigset, &sig);
+
+out:
+	timer_delete(t);
+
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1298,5 +1366,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_timer_settime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.37.1

