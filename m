Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2038442F
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4iLaen9QRFzapHFjQAehtiBnM0LkPjyIeMuc6po6Q0cBYIwWOnGxgIouA4I0n50RpwHHcE0p2i5lEKIGtCaEdVM9RSdCShkPTutd/h3Zuewc9sK3fCEtrmbrMgHOsop0L4wp5s8YNjz7H3Rv7SRb5aabpf+I2lye/arH3MVb2T5y8e6F6fypOhtKCcEF/D22WOF4Gh67NHjavVhzXo/Xxvf7SPjr1fPjnrG7fOCe446vb7wXi4Je/yZOHBQ8fNYz3lJjJRFqgUr0WtqnxpjghndzVjpNvfdkenvb+EKjwh+rBxpD6kAy7Ee67xTYXk8Rs+Db1zenGIPgB0YuZVGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeXH25BmC5Bhw6Gzu+Apw2C3E/+5nqChR8A16H6FCqE=;
 b=LrSvkAXNKPxvZFrZ0dAnCQ3tMEbFvG/lE/LZBPHeoemREW50TIT2Cq8AvL8auPxECxo/dZ2MGYrT4Z9PI0T/tPl6SAFN+KoHc9hUTYTSo+znLbAnmTdvUWFieyaXAmWEKWKe0QO79PJOfIBlCl5y7QICXeRQRNTO9ITqf2A7kxDedkXrRln/pmIWMOZuAL3UJ/w09MgL1RLDLh+Wsj1azQsNCv8fOXmDmXwiRUEedRYRBMWDGO5lmVz5FRwAcKeS1cTl/aZzYxYPlGrVAUopI5sdFiibDMG16MnicgKI72Vpbx0ETJPM/QVKqQpQqicKm+Rx7MiAn9LYlOYqPCgD6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeXH25BmC5Bhw6Gzu+Apw2C3E/+5nqChR8A16H6FCqE=;
 b=VWHUm89rI+N6SBDXt6CDmfYBrpNsuZqCmQB9+HO2/abTYIp1PNuMoHasI6LBuAQyoAgJ2xdHszFxyFGSG5/gEkeczhlQRTTtiCpMZh9+9Bfs21EGlGrSaegOWFJ3n+kRM87Q1+19Ew1i45UdKlPPZKd9P+3PvlmyRXYPjiCDeEqHEi/RUJDv+3yIjTfJ/Gaq3fJfw2NkQXkMgy5ZIdyKwdcfmffbWoPiLnHHFMkystSvp4W+XMenT3Ky6lthxmR+BE9SPNO7tMo7ib4t6oky6BuZdTVkSoVe8j/fOt6zFEN4yrA9z9SyCBjFrsS1AwjHG7CrWG7iNcbh4VwQHA0dHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:10 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:10 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 22/42] y2038: cobalt/posix/timer: Adding timer_settime64
Date: Tue,  9 Aug 2022 15:43:06 +0200
Message-Id: <20220809134326.23688-23-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0377.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::22) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b040d6cd-00f5-4598-5c2f-08da7a0d3d37
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kv6Po39L1GKiyZsEgZNJB3wQEBoccwsq5RurVqOF+fxNc8iWV4qVPhYQODLVpbD2EdUgWKS3eKhjUM/F6dfzsJdC3I4sezDK6r1eWAl1HDY8KdaUkZDrK0I4wLtk7kvGSzxbcRa09m0A4pcbbPCn8mgBTK62WdXXPPx1ymBkCRW78GmOiZW+FQ8HNsQHKBKWclHJjUQpQxY54snhvCCVrSWR1SbNJUZ8zz8emgsZA/VRzWq6FNOxJgvophAYaOVKxfxXqWXF7QiVP4JOP0XqUQ7j5h/tfU87qPaSuc4OPIlZ2lVzaZzgzYT0a25Koe//jCPT2F9bH3gfN+nl8v/BwdDbn42/aGQEY5ekEAr96vOP9gdb8LH1X6FPd8iTOEs74hCS92b1eMk99GVd7qkQuVnDmYGMnZ7iy2HT1AmfRRpgtc+yptEHRO5IevgQdF+xS9a5LoBKYpw9qLn5uyHiKQ4znitVqcmassPnAm7A3n3y1KhlcORU3vF8FrmawIgDfrv0VG2xv5i4PrbcdsKc/A/6QJZtKZn7i4T7RxF4Ce2kijm1T+VxGmmrsBlBwqYguSWEwbkF/8YHrPhfdQlf5z+0bDxsKxhswl60EhZIn/pqbWpUQUucmGO9PK3xhRhqfy6MidaWpE6W8MgWFjR+QlRKoA2ELDROnl/Z8qtcYizV/3IwgI/Ac4aUXzen+MOG1PFp9BXk/yRY7yZTCsAZuAjNZug4J0Chc4Jt7FOXf3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E6AUDoCJZRXviqxyVb9Mw8+std/KsA5zf+px73AyCk2LHKLGqbfU+b5vknox?=
 =?us-ascii?Q?EGcPJgR/1Idi3XP5D5V5eATzw9SlLCjj0GHy0esGm/zl+eMAK4SdLt8Ix28+?=
 =?us-ascii?Q?TUhltbIVL6wb/03Pp/8raAiAJDHkkOfelULROdW9npj9kVqcTk7KQ3Te63v2?=
 =?us-ascii?Q?MV+ij8lxlfoghxSCsKX2NyHQdNrE1xMM6G/ujNImbjoqnRtirgAsMDlhLKvt?=
 =?us-ascii?Q?ZNIBfC22UdAPDs49cK0SRCuAdXYfDNf6lCdRHIDVq7mUiE5LWMWVO6Z5tMPs?=
 =?us-ascii?Q?PDViFO3K0xBl0WgI4O0t7Tq8K9+z3APmuSeXVvBIgEAUWVRJv2xi50y8ODpz?=
 =?us-ascii?Q?o9A7AakpZhza0AtFTF3Ln0ii1ptz0ivW+TQNI9DgTko4os/RaIpRStxgUq42?=
 =?us-ascii?Q?6aNXEGEWcpCFVD+8UG1yE1b2f8wgbEqF9kOXKz42LbIP7iPfcjS30RT1/qsv?=
 =?us-ascii?Q?wYaqZaT6kaWG815Ik8Gd6mhqqf1B9xNLdubbBtnTu9tWbEv+ODlWBRuFw38u?=
 =?us-ascii?Q?+qnCRMETml9NZck2ARPDvWVsQLBZmseS1NnKXh9s20/W0T7uRhL6TK/Y1UQT?=
 =?us-ascii?Q?C8Vms/IeAJ0rlhLiKdQxt1L/KrKd9HQPExUgjiOLQQGeL0qYiYHKZYGugz/y?=
 =?us-ascii?Q?0t/X6XmIOvedxRdnTrVDuX0pEu2X4EsWCJ8cDBme8V/HsvyNLeuC3t7ewFKA?=
 =?us-ascii?Q?lgwIb86BwS2cIZgDQaS2JsxK1ech3M9EBvELna7Z+DKZRSmvhv11wPUzvdgy?=
 =?us-ascii?Q?4XOsZfLeTBPt7pnbCOxj3IDlNsFgnfUHw8hqCLjY8teRiteqGUaf0dPqoLv4?=
 =?us-ascii?Q?t+KuUeIx5hPH/E/e0/Rbrmn4zm1tnb403597RdoACs8QQgBt1DuzIa2Wpz+R?=
 =?us-ascii?Q?amDlrRGeNrdq4tUGNzRC4rqVpEQ46UD+wpKTnVtwWUxLmcqR9c/m0SQ3kMqo?=
 =?us-ascii?Q?dVgylRuL6Y64qX+T7zHJfnaDDtSWorAajZPV7Y+t5l9rxxf3IQhedHzyfe69?=
 =?us-ascii?Q?O08/H+gZ21qgWAxYQcy4OxzKnWWtpvwSGI6u7ZthpYNEFasw8dtyyxJl5GCb?=
 =?us-ascii?Q?9ir23jT9esRNgFEbqfQeXSMx8mhK6xt1i8eiI2lLL65E31idFMza+33RiO8H?=
 =?us-ascii?Q?LaGUL80pT9I/jJVd0Yxd1kHvey0UOlW4Nf3sS9/06D4LYegoDBAIkAnSaEDA?=
 =?us-ascii?Q?azMD8/VvWu0GDbX92kiUS+z5lTBQuTm7SFlgQBq52XBY7we8h62DP+ixItK4?=
 =?us-ascii?Q?Z043CPtSIjdFG9S/aM3gh0GQfye3zZN/MclQ53pmVAGG4UoNOcH5KkWJsxc5?=
 =?us-ascii?Q?TW5KRPFmrNwEgve3kXhZFW7sy9ET4TbGHAw8RbjYekT+kf9pb1hjQ1jCECs/?=
 =?us-ascii?Q?qh6LLSLNkNmXaBfqzsTW9WnD/ify3J2hZmxVEJ112ee5Ig6abpnk3PRYHEo4?=
 =?us-ascii?Q?RcNPtZ+hJgkLnOQIAyR+XR6jRNnt5cSmzdg0H7G/KrO0B5FWHzcHkmBdsQlw?=
 =?us-ascii?Q?5NKI/f/ObhPdOxEqkJ6CFWqGx7U46rHCRUwIVtn3fb8oQYSJbacYaD4+1Cma?=
 =?us-ascii?Q?Bo89r2VBsBXXZi/QSve57m5xdlDOKuHZD7Ap4Pgu/HrHuNggUMom8QlmT1rX?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b040d6cd-00f5-4598-5c2f-08da7a0d3d37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:10.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blu6IGwmqLpslfH6eeB2cR9xxv9f0Esu0T1jKbcJgEZ2PDHVI08QiPBzWxOZUauX0H35O68UGx5y5w8ctqnA3i5ziPIjm2dGW4vbKumvO3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

Add a syscall specific for timer_settime with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/timer.c        | 32 +++++++++++++++++++++++++++---
 kernel/cobalt/posix/timer.h        |  5 +++++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 9646a0d97..77184bd22 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -136,6 +136,7 @@
 #define sc_cobalt_event_wait64			113
 #define sc_cobalt_recvmmsg64			114
 #define sc_cobalt_cond_wait_prologue64		115
+#define sc_cobalt_timer_settime64		116
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index a58ea99a3..b888f1927 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#include <cobalt/kernel/time.h>
 #include <linux/module.h>
 #include <linux/cred.h>
 #include <linux/err.h>
@@ -296,9 +297,8 @@ int __cobalt_timer_setval(struct xntimer *__restrict__ timer, int clock_flag,
 		return 0;
 	}
 
-	if ((unsigned long)value->it_value.tv_nsec >= ONE_BILLION ||
-	    ((unsigned long)value->it_interval.tv_nsec >= ONE_BILLION &&
-	     (value->it_value.tv_sec != 0 || value->it_value.tv_nsec != 0)))
+	if (!timespec64_valid(&value->it_interval) ||
+	    !timespec64_valid(&value->it_value))
 		return -EINVAL;
 
 	start = ts2ns(&value->it_value) + 1;
@@ -495,6 +495,32 @@ COBALT_SYSCALL(timer_settime, primary,
 	return 0;
 }
 
+COBALT_SYSCALL(timer_settime64, primary,
+	       (timer_t tm, int flags,
+		const struct __kernel_itimerspec __user *u_newval,
+		struct __kernel_itimerspec __user *u_oldval))
+{
+	struct itimerspec64 newv, oldv, *oldvp = &oldv;
+	int ret;
+
+	if (u_oldval == NULL)
+		oldvp = NULL;
+
+	if (cobalt_get_itimerspec64(&newv, u_newval))
+		return -EFAULT;
+
+	ret = __cobalt_timer_settime(tm, flags, &newv, oldvp);
+	if (ret)
+		return ret;
+
+	if (oldvp && cobalt_put_itimerspec64(u_oldval, oldvp)) {
+		__cobalt_timer_settime(tm, flags, oldvp, NULL);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 COBALT_SYSCALL(timer_gettime, current,
 	       (timer_t tm, struct __user_old_itimerspec __user *u_val))
 {
diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
index 3b580d470..16d3a572a 100644
--- a/kernel/cobalt/posix/timer.h
+++ b/kernel/cobalt/posix/timer.h
@@ -78,6 +78,11 @@ COBALT_SYSCALL_DECL(timer_settime,
 		     const struct __user_old_itimerspec __user *u_newval,
 		     struct __user_old_itimerspec __user *u_oldval));
 
+COBALT_SYSCALL_DECL(timer_settime64,
+		    (timer_t tm, int flags,
+		     const struct __kernel_itimerspec __user *u_newval,
+		     struct __kernel_itimerspec __user *u_oldval));
+
 COBALT_SYSCALL_DECL(timer_gettime,
 		    (timer_t tm, struct __user_old_itimerspec __user *u_val));
 
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index c7eef7fba..5f99b1162 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -168,7 +168,8 @@
 		__cobalt_symbolic_syscall(monitor_wait64),		\
 		__cobalt_symbolic_syscall(event_wait64),		\
 		__cobalt_symbolic_syscall(recvmmsg64),			\
-		__cobalt_symbolic_syscall(cond_wait_prologue64))
+		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
+		__cobalt_symbolic_syscall(timer_settime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.37.1

