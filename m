Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE84429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG0t7ZhFPmJ+rwmwkHuzcvOXLxHfviSfP8AjcfT8utjZLCDlbi1Jn4z/fiBTxVyObpKLLBv7mMy82Ix/ooZEdkyFDKL6aBd9Xbjn+rvc1kiEv8yg8PnfchI+VDsY7xRbSEzYAtYlE02Lf+XGRJVhCCyvfASTNFrmGYdABqnKOfbRIqmEgeoaMx+zav9HYUglNLAvglWMOZ+y8e6Gs2tv6vTclV4TGhYOi7xmHgkefNmeleZiruvmQiK+X+dk44G8ix1SYiT/AGfUrbzi91WAvoiSigZX+0R0oHsObDErUz9+1texIrBGCiafkSJoOuQbL6ATQrytBfeaQtJa8Jgtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQgmM8ZrQGS0KJ+rkR4xWb0ytxNdh1h57Gjk5FXQ7MQ=;
 b=JUr9sIT1co5lYJ7k+APCp7aXHnQ8JNsRXeA8Fy1/ogH8mClZpU68QOVIQmqjt+YDryC//HYZqs7nJGKTsQRUUU7I5nXjo0S7x0FJp6svQq0RITU2wCJbjqfIOMNsEIraJFXma9tVTXewjhubM+5g3ED8Z6gUxrRzhZlCKKLS6BWfJlQUvTHp8UP6jlbBtHKBL64BH6ulmatLTLFmXWjOP95u1aTd4olI8S1igg8QA3Pqov74IULDPz9eb6bJHQUYkvO3vqFC502P1UuVnKH3PHd4fV/qF3seZbJO4aKpSblUpAAkVa7OH7aMQoPwxrT4GutHWrW2Dowlk7qLFfmfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQgmM8ZrQGS0KJ+rkR4xWb0ytxNdh1h57Gjk5FXQ7MQ=;
 b=Nzz9qB8f5YSKeBmE9eTeVHTV8oO1FfUx8G26YrG7xaa/DQ2LsvjqaCEHqSf+h/viWHRvtpc3jYMsKaeyTWe44EVFALyLcro8JLpJLL8IG4uJ6cujgrzZofeieyWhPJb0SR5rveapObYJTxL3S/ihWrPHMeYgPvKWze89pqqYVz7ldtdYEnCCTMdvgIZRFobHfdjOFL1PzJkfP8NoS1oQrWyJwJShhWFgbhm1wkmcxv/ipJQiGUosZfdXMQIWJjosbN9nvDU7qnXpv9GgMwtoiIEO17wzKaBCilY6rfLYixWpEUILc/3PRt0eRqZtIg2XQNME3QWs9up7nEiXtPEnlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:44:01 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:01 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 13/42] y2038: posix/mq: Fix mq_timedsend syscall routing
Date: Tue,  9 Aug 2022 15:42:57 +0200
Message-Id: <20220809134326.23688-14-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7beeab2-4d1c-40ae-3211-08da7a0d37a5
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b6dEyhWPKtMvhaAlvfVBBhMt46o9CkQAdDAKShtG6priVT/J3hZK/1xj0I0Q7EWfsd3vnB/CdNhjXll9uL/y1VC7RpASY+8+qSSPODKu5hgDl4rk8lMOnyjdnWXpQ8BpVUp7sks6yQHWZ7cbL9hKpMqPe2zepmi0ThztLA/QssCZUkVNGzop69yRoaxChcUPqPWPo7fsyR9b0iCcNAtT4bo2pU1D8ikNT7eyHpXL/j9AgoLaxlAFj/VBmvCv9El5Wt+gvv1B0tdPy3Smf68GylkJ+xRLuQiQGuPWYoJvHiAVaSWMgAzjlYJIA9yD9V7/faksijlV5l+crR3SWHZ3VNHAbq+FdM3PTOWLCdFVXPYp7vhu6mGhttOoXTaQ/jKc6pawiVdxdOj7iGODLCGEUoRAESnEnxZhrHYxwfQKUWPigjOvxhd9sN+09OuNL1ej7Fszzsr4ytGD2HPCEppMaNYn8PLEfXzV+NTqpmxSnR544rUanf/k9ajsY7TXm70bsq5pasF+ml+w8hDR73UCQWpHG4ok32aeDoEFy4SFfWL4+5SgQlRblkG6nx1DqB9sKaGAef25Ou4YGw0EUjYQeZhgUvmxmGbbQ2jrPJPKXKX+WU5pkP3Nwm2RSk5vttGW56EFeG+r+8mFZOoW/9qzOTwE6iADjxknmLhTDd4rePq2EKunig+4aiEpa0L6xYnHUjGKZQNBTwyV4dj6f9aNXSWgFw3oRotv1ZD9P8EZJJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(55236004)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TaV6T0ZCza95P5pH7VpvxDA9jilw8U9cPmQ4s2PF4SvystKUZZ4J0cAXuzbg?=
 =?us-ascii?Q?gvH+2BaDfOfgQTUqk7i1E8XhZTFDsLVgsXJON8tIGANwQ7efSyPX66Pj2Hec?=
 =?us-ascii?Q?cNem8ntGOeq3/X73dXJKJ7NrDLKDk3bBIHqzGVVqV0r2ZObBxIAJEg/wbgKF?=
 =?us-ascii?Q?I6X/gmd6m6/ze3QSU2ZxG9LqWfmO3AXsrEZgPMhch88iOqkEFWZ5W681sqse?=
 =?us-ascii?Q?Z7bYh5Alt1uL3kkl2GEq04gRMDM8NNYt+UHCMBZGAdzzEeZsL+xNUhe4AXfE?=
 =?us-ascii?Q?TGrpLOO/0TelIwXRed3YsQI81DzQAJC+JTkTjZ7LilzgtmgLtvrQzGLDpHtW?=
 =?us-ascii?Q?61N85mJp+d1ugC06aM3vmNGap2j9QDL2qEwR3Zw49t5qoxjlTymL4G6UeM7F?=
 =?us-ascii?Q?z4QChPiYUXnxclirAifUhMvoVoheCGtd2bVQgCYdKEsM200GIC5aFeWcd2l1?=
 =?us-ascii?Q?dmnniNDNqTUN4KmmDzksiDKkQUrVga5//vo1C3qI8sMaeI2l0oHLcPhLpdKY?=
 =?us-ascii?Q?6+UWUeZ4gMvgb+CyuUGMfDIAFJM1sFG75DDrZK2Qjq9OhOn+nJpBOy1iaxrX?=
 =?us-ascii?Q?z1LKSK3LdKcmCFdWWWTnVap8QuzQcL5Xc17XlBEa7kqoJHTcDKGwloKTjLDB?=
 =?us-ascii?Q?PLzzW3V4d+GpdxiMTYzwKUHAk2RHQO0I2+c6M7MhgSvpzZjf4CfxH1z6QBiq?=
 =?us-ascii?Q?AB+Q9G1dR9uPowuxGRRZO0I6fd11Oszlzp/4hwI5PiSsNqp+vlADiFQ3Zw0e?=
 =?us-ascii?Q?2Z7yywFfM6dH5Ao1pFvua/vunNrGYYKxRuLSHWtFxr3adSUWcSq6w7w49yGo?=
 =?us-ascii?Q?WuHjLBqET6dkEOUBVUrLwoAnWspblCqMBxP66qem8falykHff5I9wBH9WUUP?=
 =?us-ascii?Q?7Z81njnIEXtsQlYXqWlUUNK0cOnFur5VKUeAYko/yYk6e4l5NLFyepdDm4eH?=
 =?us-ascii?Q?Pm5XAaHFOO3MEDeE37w+S2+Fh3E1TQ+7GIa7yo53a39y+LqGLlsUsmJD8V4r?=
 =?us-ascii?Q?eTV5PTSbFKAsJBCZYP+FuXaJAPc6D93QOZ1kEvwLb39/QQbMnzbpAKysoq/l?=
 =?us-ascii?Q?rHBbmMDdtkwNIW0VeTuLmNXpCF4O9TyS8ASEV2C206wyZGSy3XC7HXwyVp8+?=
 =?us-ascii?Q?cV/V7zI4mVd4CM42FM44Ltim8RxrDAQVg4dOXKNVrjvMTueI4mK/aq5hwJxj?=
 =?us-ascii?Q?aiRkN1GmLrHNK38PwpauJnyH0WcXbu75i/5i21XfrPn8j8pajjMPd84TdmR3?=
 =?us-ascii?Q?tyLXD+K5H2Fag0IMVu2EibaoD12rtuKt66dAIl2n0EPuPSbjXVcq2B2coOIW?=
 =?us-ascii?Q?tUaGCi3hptGZi77LaxYSbiKdkaB0tlwXgmVlTrk0J/0IEiNQlo9irRNiliTP?=
 =?us-ascii?Q?sTl3MvM6NUFL95wPu44jjdeSSCa1dhqdSgYmJZnLy/iQK5s1RbY+m8/42kPM?=
 =?us-ascii?Q?CD2me6SWlEmio1+r5SwosWvZf3+w4demp62wivWYthzK58aBz71P3L3+5x/q?=
 =?us-ascii?Q?ow7R4RdIUn93QgutUXEkEIF9K/HGd6M2nRpWCGBnPEtVZiSCqjuunZUfVTwA?=
 =?us-ascii?Q?fBqmFDY+eUXMpmtur3ZLwHKBrV5bO/6Y3TP/QEyJD5ChdB/iA32yt/DTfnNq?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7beeab2-4d1c-40ae-3211-08da7a0d37a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:01.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWR0aS2wiywkqXv/V1hqTqYXHi8S2f+X0G/zk9lHINLRGZV6r9aBclwv9/iw0w7O0X4xD7ffTVT9HJ2bRNn2MMnC2hYwC53FAhbLRIpe1Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

The sc_cobalt_mq_timedsend syscall was used twice, once for the
mq_timedsend service and once for the mq_send service which re-uses the
same cobalt service without supplying a timeout.

The mq_timedsend case - which actually counts y2038 wise - has been
overlooked by Song when introducing y2038 support for some reason.

Both services fall back to the same helper now, so we can handle them
the same way.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/mq.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index a8c88b406..88a74095b 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -289,6 +289,18 @@ COBALT_IMPL(int, mq_setattr, (mqd_t mqd,
 	return -1;
 }
 
+static inline int __do_mq_timesend(mqd_t q, const char *buffer, size_t len,
+				   unsigned int prio, const struct timespec *to)
+{
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_mq_timedsend64;
+#else
+	long sc_nr = sc_cobalt_mq_timedsend;
+#endif
+
+	return XENOMAI_SYSCALL5(sc_nr, q, buffer, len, prio, to);
+}
+
 /**
  * Send a message to a message queue.
  *
@@ -332,13 +344,7 @@ COBALT_IMPL(int, mq_send, (mqd_t q, const char *buffer, size_t len, unsigned pri
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-#ifdef __USE_TIME_BITS64
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedsend64,
-			       q, buffer, len, prio, NULL);
-#else
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedsend,
-			       q, buffer, len, prio, NULL);
-#endif
+	err = __do_mq_timesend(q, buffer, len, prio, NULL);
 
 	pthread_setcanceltype(oldtype, NULL);
 
@@ -397,8 +403,7 @@ COBALT_IMPL(int, mq_timedsend, (mqd_t q,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedsend,
-			       q, buffer, len, prio, timeout);
+	err = __do_mq_timesend(q, buffer, len, prio, timeout);
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.37.1

