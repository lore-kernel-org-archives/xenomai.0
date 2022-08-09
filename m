Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B014428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCEhBC4Mk2NbmJKGIkpOz6OajZrsjPgPhbui917NvxaShcRRJJZLTUEnBERyimmOCdtreqAwVzr3HdrKt8x+qMWXslusGPtp+/3XMoMuroH3BDNZj1LoSOSudFbNGB9uM3byWJPlB7CEdzJmDsmNlvSnsnOfEaHkyzPwUkn1+3/Ucr0FfwebhUlKcbwe+27Snp3fQcvOc+aqw6wUQmRXnKC3jAZzzOBjeq+f/weUC0OXF1a3l321bkZPiCuiv2l2ginbPL3+KeHJmABKssoxERpuEd7PXtlLQ6TbGMkbaGa8oHLclbUZF+OZOhVE351jzCAA+bR1uadMySISATOmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0KQZNsfokRueLWi0Ujs55cGua3cqM+QMBYH7TAlE3g=;
 b=CINxupX5thUQqO9Dl5K3tVgV0MHoQNNpwh/0azY4ipm77Hq4fdIZjRPckeleAVyDpD+BmCFeW4C1Be7Vgmmff7tuwuGPeSaGzKz9l1F+fA+XSgglBL1PuuVZxAKY2JQYvcvMPqOZSbrDnSQgCkwgdP6JLIe5+xnvd+9fTahSJbCJI27OTq7fJZ2d5OK6JkMvvPLEdvvIZS/Cc/T1IokKXAum7J4Y1t2DUaeL22SLYnNbtHue9frEhLgkU5wvjFvlmJaSURS3dtO3rnXRbjP7w724iToo74BrW6j+QIyjLufGjn1dHHxgbfIS8n1cCQF/DX1LfGd7cSYk53NPezKZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0KQZNsfokRueLWi0Ujs55cGua3cqM+QMBYH7TAlE3g=;
 b=Tiy7zgJqjLUKVLQE867cnq6SdzQ+TN1qFvIbL5p/Ar8vbYJHl/n9cw3tESG/YHMoD7i2L2GPe/CzArWAgTYTSr3wwRh/U3wbFg+nJpyWZ1PVddhyu8SF/49ngfUr1h+66aVwGDtUA+FgC8pxHIdcsMvlmZMfSzbNhlisxms9mERcMrI3093Wx1qNb/Nv47+OyZUh0yM3EGlBqKg04fPUTz36D1ZlWM6Yax3W4KXXv1LYdGTwiEuJ+CZkZvdQpmGTrrresDBkjXDQPjj7U9l4FQP/j5UtoJInIanuQVcOMfFGqS+tJNPNzA1y62Ume5hTE1UgFpTW2Ky7OY51zvOqUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:43:58 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:43:58 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 10/42] y2038: cobalt: posix/event: Remove compat syscall for event_wait64
Date: Tue,  9 Aug 2022 15:42:54 +0200
Message-Id: <20220809134326.23688-11-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5d6fadd-53c7-435e-41b9-08da7a0d35e2
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PVGy+CH6Ybdaq9FA8JJK/h45U+5sLD6UUuU2i/Ht34PFck9mAKoHK6OmaWBqUVWuky00z8v3pIOJHI9LITw/Od9xNu0CKrb4x91CsQMfV0OL8kPVeYlKgr2fjv8OvKY5t9ljEIwmQIIeMlKw+/AcrrKmfzcFS0e8Cp9hZwVb2q1hi0wx04JAQnJIuWQCYPZj7Sz9Q4NypsElIIVzmYDrIgEvF37jO5uzsM60wVtzhdv4DiP4JwZfAa76946DyceAC7/cu7TK1i/7uZMWxl8D8NhvGIwu0PItaTMc64jqA++PzcckYXXPRxu8doAPjKICuV9DvRDzAzLHbmqOh/YDngDvLaULOY9XG0EGTYf624wvTkC7MbPzBeqxBMiGi7qTCLgoq21w2ILShNntFdBz49JTp1y4wKJZnWcly8vdxWCS6FLgDLZLtS3rmlCTBr+pN/0gqRIReEfPArSq8EhzLSyGK7+Kk4C8kvEw2BVcpJGwaRWDEZoB3crZR0CvC7iTXdAsQpSsr9vhL2zLEAIn2uic6tgfK6svC0AirS6S/EH0MwlQiyEmpzie3Kds38kUjknHmgJJI++XMAg+FEOtXQXucO5AszwZPbPT/wXRMNJFaS4JO4eTdhoT4E6UBNul9gWe6to3mkB63yJGa3oC3bHoDHwNt2tELNmtR9wHZ3QtcgIUgVU9qFF+zvCEvLnrhgZS0oSaCN2Pn/Lg3SEefKoaYKISJXxk2IO+sah2+tQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGlxfzhPOtsHWXVZ3yDJ/6QNda77xXmRxRKO3pBNxQtlIW1fys2c3ut7xszT?=
 =?us-ascii?Q?QjDSNvBjSyEeJiquJIhW6ul1tBXfQcumoZdqrUpHkpjZNx85HoSRwr75FpUn?=
 =?us-ascii?Q?dj+8SxBabsv5N+J4IgunQ/TM9GbKSpe8kTHbyowkcUMPqPEZ5UPApyTQH8IC?=
 =?us-ascii?Q?Kxx34GazJur9e261ZlRSJ1NQeeJrIaknAlfjo0zdE+HRAxHGPiiy4VaHUNhi?=
 =?us-ascii?Q?QSjEcmVg4IzTlVwoIcFhmEMTf6SZyN9maILUYBqe9iY2nPluaFl+2E7Sm+V/?=
 =?us-ascii?Q?QcWo+pzUkWYmSd1jjZ8+WGQtqNQyxMT+YoEtQ7UbAUP/1npgnuNOsCQYgaVN?=
 =?us-ascii?Q?QKgvROShThc7a74f8kHtyFlhBMog33f9WMALjoUKxIauyAENvzBtmuzF9mjV?=
 =?us-ascii?Q?PEoct33BybE23CQoBf19uspJn3sJaU4daOuFQ/YaEYJ7kc2/Bw4YHMjrnLoZ?=
 =?us-ascii?Q?dmNMhs44RBMuPlkB/mQppDz9phHBdwsG5syZtdW85thHfcsDf+49Ly37x+oM?=
 =?us-ascii?Q?4dy7r7ldMMAC4kyWmYULX+13AsOQ8grZVWE+FBp+z1tOCBmFBzuJshk22pzO?=
 =?us-ascii?Q?pEYC24HJbsaH3WeHywM1fh/eXaVrCzeZicICUoGhVhNU3rwHsoUC/cr7J00i?=
 =?us-ascii?Q?pT30ebRUQSBeAXQGEawRqu97WCTFUhoA2RvFZ6d++VzPqyrOdGt3GslC6i0A?=
 =?us-ascii?Q?EkqdleHw1l0Icdb954vBvUnkDZWR3yw5d2q98xbVvZ+skLhCeTeg92wXBdCC?=
 =?us-ascii?Q?+m6ElvQsHuShLFlSG9QBZiYDovIoPN2dAwmPJqOpZL7dLUYE+V6Rr17f6no3?=
 =?us-ascii?Q?nj99akiz2yhZfU6FdIUMEUhp+t31+atdqwFMclk8gOd01jU8JB0xijSRzh6L?=
 =?us-ascii?Q?wt1NTzFOnvKeTwdqnbk6U3Zmty28ie6w6VUOfEdr+7flPMt6+vuFJVVC01ac?=
 =?us-ascii?Q?pzk46EQpQom5tMLbFuwnIOC9d66wqzRbjrvxqqMuVkl6uCPH6R+D4h+Nlieh?=
 =?us-ascii?Q?bns3i8y5koMv7wpnwK/7OVfblKvgg/F4oMZHOGEkUQrKsYQLaf6w2N05nICC?=
 =?us-ascii?Q?2MJ+mGwtp1BGzool67iv1nLpdMXQGJyggt2cW3XgyConweK/hRSoJxoqiMwz?=
 =?us-ascii?Q?igpGbRuMZI2pqrc6H7XYML6ILyiESKXbPmjpN1Na6xjgxfI0dCzWUDD5ZYsQ?=
 =?us-ascii?Q?D7k+Kgs7jp9YBF2YSNphk3uyV6aUyLs27COrUJQPZ1sxD8gHmpVwocH5EVMS?=
 =?us-ascii?Q?w4vQ4keBP00knB27oi+vvAUueIasz+XlvzffF1QMuJ4eVTXRSkJAwFkhGulJ?=
 =?us-ascii?Q?OMXKn7vSTN7OENmxTaoBzp04lKnuriQ0i7UwShp16tpcsEfCACWu+huGIKtT?=
 =?us-ascii?Q?JRWYQJ0srAjXYbIe05GfzgXXR1QjXdno3DIFLG9Eryo0fbCSm53P6N3t2N/A?=
 =?us-ascii?Q?oehSnV/DB4EatXPqZTWheZNmu3i7Xo4N0rMO2mF2cYLY6YQjDgNNtj/VuMh2?=
 =?us-ascii?Q?kJW2WZDcjxt+xm69ZoRsHfZxOlE8djZNJBHhwCV6M/ZXuhzN8cRc78/S9Zuk?=
 =?us-ascii?Q?KUj6NG1ieGNO+6/x4YhS93HHIFIlQNIyYVOujyK2KsdbKDssT9esnlyflW44?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d6fadd-53c7-435e-41b9-08da7a0d35e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:43:58.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZOY8qtG/yvpjlcejn0A4Z6LkVetF4Yd10Xrb6Xqo3BGclinGL1qhMhoxulL/CSouRQZgpvZINKMo8Nc3IiARwcRv1c7sLnniGFJyDaoVrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/event.c     | 26 +++++++++-----------------
 kernel/cobalt/posix/event.h     |  5 -----
 kernel/cobalt/posix/syscall32.c |  9 ---------
 kernel/cobalt/posix/syscall32.h |  7 -------
 4 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
index 052c68605..a5fa45db8 100644
--- a/kernel/cobalt/posix/event.c
+++ b/kernel/cobalt/posix/event.c
@@ -190,17 +190,18 @@ out:
 	return ret;
 }
 
-int __cobalt_event_wait64(struct cobalt_event_shadow __user *u_event,
-			  unsigned int bits,
-			  unsigned int __user *u_bits_r,
-			  int mode, const struct __kernel_timespec __user *u_ts)
+COBALT_SYSCALL(event_wait, primary,
+	       (struct cobalt_event_shadow __user *u_event,
+		unsigned int bits,
+		unsigned int __user *u_bits_r,
+		int mode, const struct __user_old_timespec __user *u_ts))
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
@@ -208,18 +209,18 @@ int __cobalt_event_wait64(struct cobalt_event_shadow __user *u_event,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
-COBALT_SYSCALL(event_wait, primary,
+COBALT_SYSCALL(event_wait64, primary,
 	       (struct cobalt_event_shadow __user *u_event,
 		unsigned int bits,
 		unsigned int __user *u_bits_r,
-		int mode, const struct __user_old_timespec __user *u_ts))
+		int mode, const struct __kernel_timespec __user *u_ts))
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
@@ -227,15 +228,6 @@ COBALT_SYSCALL(event_wait, primary,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
-COBALT_SYSCALL(event_wait64, primary,
-	       (struct cobalt_event_shadow __user *u_event,
-		unsigned int bits,
-		unsigned int __user *u_bits_r,
-		int mode, const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_event_wait64(u_event, bits, u_bits_r, mode, u_ts);
-}
-
 COBALT_SYSCALL(event_sync, current,
 	       (struct cobalt_event_shadow __user *u_event))
 {
diff --git a/kernel/cobalt/posix/event.h b/kernel/cobalt/posix/event.h
index 919774c9a..a67141f2b 100644
--- a/kernel/cobalt/posix/event.h
+++ b/kernel/cobalt/posix/event.h
@@ -41,11 +41,6 @@ int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
 			unsigned int __user *u_bits_r,
 			int mode, const struct timespec64 *ts);
 
-int __cobalt_event_wait64(struct cobalt_event_shadow __user *u_event,
-			  unsigned int bits, unsigned int __user *u_bits_r,
-			  int mode,
-			  const struct __kernel_timespec __user *u_ts);
-
 COBALT_SYSCALL_DECL(event_init,
 		    (struct cobalt_event_shadow __user *u_evtsh,
 		     unsigned int value,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index dfa4d31ec..97981bda9 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -752,15 +752,6 @@ COBALT_SYSCALL32emu(event_wait, primary,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
-COBALT_SYSCALL32emu(event_wait64, primary,
-		    (struct cobalt_event_shadow __user *u_event,
-		     unsigned int bits,
-		     unsigned int __user *u_bits_r,
-		     int mode, const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_event_wait64(u_event, bits, u_bits_r, mode, u_ts);
-}
-
 COBALT_SYSCALL32emu(select, primary,
 		    (int nfds,
 		     compat_fd_set __user *u_rfds,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 973a0befc..c96fa1379 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -201,13 +201,6 @@ COBALT_SYSCALL32emu_DECL(event_wait,
 			  unsigned int __user *u_bits_r,
 			  int mode, const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(event_wait64,
-			 (struct cobalt_event_shadow __user *u_event,
-			  unsigned int bits,
-			  unsigned int __user *u_bits_r,
-			  int mode,
-			  const struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(select,
 			 (int nfds,
 			  compat_fd_set __user *u_rfds,
-- 
2.37.1

