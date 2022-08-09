Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC015442E
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4ot+vck9lOtUwlP/W5v7/rWq+cxV1W/694SiA2HrY86zQHfCxzRu6bO9jNAzEGpNrP+HjWfTk/KRyWTwKVrLB/3g4K40GbVoCbRwgwPb6V4blGPEvq7+uEmvNNIgQ7V/c6SSi1tnveVRrlKw6hV2rp92n1yWzouMCHir6mKbDXt/l57CBlYb1dzaJMZJagUxaRHscyvfzuTM9w+hSGuQehqUXOSrb+Vh2OzQM9mVWj1uJ1GkImVUE7Jot+ksrpP1RRSeFAYyG+LMWoxANoPw3ZpuDhIi4InCeUFZ6XbDTX/7tnxvcXM+pkHG913zZ2JZ9X0eVLXlRBwlDJlhBcI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjQJE9ez6XqHeTKr51FBkXU+LK5GKpu/a444OXw29n0=;
 b=CbxufIP65asjdbLBUcUdLKFNLrpbgNtt10YDWq3T4wdTEiR2jwdGpFlUUBfVw9cRV1mhG+ohtd5EygNn2NNpi46YJI32N2x30mv3UvmkzHgyE2VKLto/4H9TXmUM1aDp+/DymWMggpTTGTEvBi7xN9wC6b/jQsW4nUv+1HFYycb7eEUpJQdjv0h4viA0VykTRxg8l1fS5XZGhr8Ec5yLgUZeaWrTygtek4U2gABDDPAbEhA9d7T4S4VXG8iiaHjlkQJ7X2w/EAZZNAEJfI2d4+6/zXh9S9iSrygsK+NGG/7tzyksSj93FJY4eLhX5aoAq6vz+g+dx3IuI6dxMkzBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjQJE9ez6XqHeTKr51FBkXU+LK5GKpu/a444OXw29n0=;
 b=MRGtvLHjGEzhly6bFlWXdfj7dknIw52XnmX1qe87ItKCRf+HXmJqNQngPQfnKCe0G8CGcS3xaGI4fMUin0QpXSrABLwYETQkfg9CPy5IH3jgmWdS/kw7ptDwTIG6HsM92i+C3VBGc5oShcVeY2QP25+ZkfXYuqZqowOPVCZH7VQGBuJ6CpUw7Sn646qLGBDc5LtIiQ4mBHMchwoC9DZOrbmZ2c9J+YI1zMsU7jtR1Cbf4zMXBfDHxvKNRgXBP7cnib/e4/f+6i//QbZeVvjeLILhh2mnC9OR/KVm7iYxB1cgANQ7j3YlBDMR66YrIPmnrK6AW0ccoKb2Y8QYSINZEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:17 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:17 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 28/42] y2038: cobalt/posix/timerfd: Adding timerfd_settime64
Date: Tue,  9 Aug 2022 15:43:12 +0200
Message-Id: <20220809134326.23688-29-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66eb1504-010e-4992-444f-08da7a0d410e
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WdlGgg8usm3A3EK/5cVd8D1HzYgY1R6IEW98VCB9uLqbhPFktIoczwbrV/iTTnT3tW1Ek3Lct9sejJ5SAPsr8klX1beKTVleLkQgn/ZwCqV1EaaN1htxK3r1Pr5IHAlXdE7eVtwGRl1wwcTM61HrGJzTJm/XGgv6UWAtdBAprGSG8pA39XYKIT8jHPnVCpn/fTeUY62F9LEFuJLvNmcTIPcTm7z0vpxquP2HdalHcODnNxDmB5wvCA9br90XrnKh4CxXL+z5XOIdAvr8d24rD/s8fFAYmIO3E19skxY7O2GzxN3VD5Aq8ptnQhDkiNpT9rik8rxnpNHxTwV2ybjg4ErDpmwT0Dip+ap9MZXRQyrVM5II0OwqTRB4e9mqqISUZ1Xq6Dhd3aigfiSmTR18tfdENwN2N6muQ5OmmtjxlU+/az2SUrqMUGFCKlna0bJXXoLQD6l4Ty1JopVzFxoH0L+vbjLCQkyN9GBA/bD81jzKxCPxk5uGHfz//zfh7XFznqjWb/6IzdsZU0se6xDnQ/WqXBjra7SiTe+/WT0Y6H59CMwXPJFnXEmDPS0ox9IFBC23l1QnAfnSPQzT9paBmKEj5zyEIcPxQ7pjL0wIHyh+H+muSYE+/flNaQn03Om0lqBWUsH2rwNSjpLT7y6NoAgn9fZxKNRb7520s+tkalPWcL8sNu/vz2/LQgXAVvL7fdPm7BPGP0tdN2iSAxYf9pwMe9oUjV4bNpDv3/+Uahw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fN/KGlfYDISJX9GmTg0jWW7fbCf2fvppACKZOnKdBQGi+CjtmeR29fy8tg5Y?=
 =?us-ascii?Q?NyGwrWbA639AIEoNB/FhzpohNEIppM8yr+BdmKQrOWVRXa1/hZaddqYsBk03?=
 =?us-ascii?Q?dqW/5NUt4miqSeEKYxaC2dsZ3EvELkzddNP7ZtFU5drkt1NKhUyCvNfT7AZT?=
 =?us-ascii?Q?uoSsuex8P647/72mEUeLex6Wvp6BNGAp+hSy9HYmj3vFnnkkUQX0U/Pom+Jb?=
 =?us-ascii?Q?jqNIi4iTum/7HC5f16MPCBWrfq8hb6SiOK9jR2ws9tfc7E3uub+NLtuSu7G5?=
 =?us-ascii?Q?Fffg4WPex1HcuN9O5ODQwEn7x4NaZtsyQKycqXw21ZyKxKH/XUss4lu/aQM2?=
 =?us-ascii?Q?s+iIff5Tc7XO1BEaaop7tH+8MuVTpmbHiejYUQn4/vCvrirk5RcD2wp3vnzj?=
 =?us-ascii?Q?wyiUSJ5/d5WBQ88wYal0EeTStq0m14VUo1P7Q2NF6ejtzwjmIfkXmqchOCiI?=
 =?us-ascii?Q?x3oSr/ge2LteIYq/NwXXi35YieLhY188vdZAZPqSpGAPSbhYEpA45T2xElC4?=
 =?us-ascii?Q?OVHyfw1JZfiRCakuHPoFwTProfB3y7NTJNeI0nMknidbIHli/ALxYjHKUDD5?=
 =?us-ascii?Q?KLnLZxq/pjc7gjOwnSBPUSwF6+9X3AHogjKtbcGK688U/rbOiGVActIFCHOM?=
 =?us-ascii?Q?7BR40WnV3pt+5xfdOuxEHmhTR6qB/PPsfvZjjJ4SDwBBDFTtq/xhisHze4+Z?=
 =?us-ascii?Q?fcmG/6gfHWLn8F2dJyj9qcJmkBTJNonl22eDCPpshcbdc3EnbGsyjQSoJoXa?=
 =?us-ascii?Q?qgOuSHStF7Z8LjvSdcMnlFIFhOhcnGuviHLIFvYQEh4Lif/Omhu42E36K/m8?=
 =?us-ascii?Q?1YVw0tJYKEnKaNkZVsUl2nxL5sYXKpuE2yTRNFV3MC24FH42QWZBJ0Eyopq9?=
 =?us-ascii?Q?9dbepZtsXNCCqp4srjQY74+sSKzmDQg3oI+/5p9IkUxC9glAsBPIJCKbdpm7?=
 =?us-ascii?Q?mpOz74HPQ9J3GhmLzaI8/1ij5TDUlaNS4ZyFH7Bf2QyX4+YuohhwYqKAW9C2?=
 =?us-ascii?Q?sv6meZX2H2VX8pgepeg+m8AcTZm2KohkbNvSMfL0s/QCIc+tyCqoTqmN1QUY?=
 =?us-ascii?Q?+rBAxdP3o+59PiSWhG/fWSggs8Vdo5lUvEf3vvlXpxlQ/WIlnBuxUDQEbULE?=
 =?us-ascii?Q?b7DEFdI0nMOMJyZAPICBZ17uslhlUcIZqQQQVm04U0zc+em9WDwOCB1FuLUO?=
 =?us-ascii?Q?GDg9Zo2ypiFFUdl2FapXzx3CHnkiaYi2B7eI2SIDHHlMfYxHZqlvOe5jJb2O?=
 =?us-ascii?Q?LAL2/4733tBs3l089zbWRUFX1aE9dxxjb7HG+FNfCwb4H/Wy754aA/ZNwY7o?=
 =?us-ascii?Q?3wsu5moltGEeNq6mGk5Mi7lsAWcLSavXE5HO69L8H73Nk3IFbTOpi4v7uPQk?=
 =?us-ascii?Q?KpNaeMGtSMwxMol7J7ehrelyQo0n1k2ciUdMZV6imrK33Yulitw15D4OnfcH?=
 =?us-ascii?Q?IY/EPjErDaI9Go61gcreH4CwnEYhxsCnyyY1qwn8bNIAchFugFVeX/BZtBG3?=
 =?us-ascii?Q?giHQDHaVk1K1G1+eUAK0TCHDEwxvZbaX81ybDL5Y8UQBW+KkZ2il7Nz++VhE?=
 =?us-ascii?Q?gvRtF+LGFQI7kT4pGCTAWnALVvvJFYjKBSKVXIv8GvuQcDb5R5mLQdyuQLG0?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eb1504-010e-4992-444f-08da7a0d410e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:17.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47+mB5gBfsU4Rvl8/MCWs5acKMByNzs+u7bojBpaKmtUbEfeDmsSyCvbVKfUWMCU1lPj2h+3GOWZGvNZstlyhggKD2X+gxT5S4zxRjXa5us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

Add a syscall specific for timerfd_settime with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/timerfd.c      | 29 ++++++++++++++++++++++++++++-
 kernel/cobalt/posix/timerfd.h      |  5 +++++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 24e759eef..b8271618f 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -138,6 +138,7 @@
 #define sc_cobalt_cond_wait_prologue64		115
 #define sc_cobalt_timer_settime64		116
 #define sc_cobalt_timer_gettime64		117
+#define sc_cobalt_timerfd_settime64		118
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index 2fbe152a5..9b2683ad9 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -18,6 +18,7 @@
 
 #include <linux/timerfd.h>
 #include <linux/err.h>
+#include <cobalt/kernel/time.h>
 #include <cobalt/kernel/timer.h>
 #include <cobalt/kernel/select.h>
 #include <rtdm/fd.h>
@@ -295,7 +296,33 @@ COBALT_SYSCALL(timerfd_settime, primary,
 		return ret;
 
 	if (old_value) {
-		ret = cobalt_copy_to_user(old_value, &ovalue, sizeof(ovalue));
+		ret = cobalt_put_u_itimerspec(old_value, &ovalue);
+		value.it_value.tv_sec = 0;
+		value.it_value.tv_nsec = 0;
+		__cobalt_timerfd_settime(fd, flags, &value, NULL);
+	}
+
+	return ret;
+}
+
+COBALT_SYSCALL(timerfd_settime64, primary,
+	       (int fd, int flags,
+		const struct __kernel_itimerspec __user *new_value,
+		struct __kernel_itimerspec __user *old_value))
+{
+	struct itimerspec64 ovalue, value;
+	int ret;
+
+	ret = cobalt_get_itimerspec64(&value, new_value);
+	if (ret)
+		return ret;
+
+	ret = __cobalt_timerfd_settime(fd, flags, &value, &ovalue);
+	if (ret)
+		return ret;
+
+	if (old_value) {
+		ret = cobalt_put_itimerspec64(old_value, &ovalue);
 		value.it_value.tv_sec = 0;
 		value.it_value.tv_nsec = 0;
 		__cobalt_timerfd_settime(fd, flags, &value, NULL);
diff --git a/kernel/cobalt/posix/timerfd.h b/kernel/cobalt/posix/timerfd.h
index 245b8698b..ae9945152 100644
--- a/kernel/cobalt/posix/timerfd.h
+++ b/kernel/cobalt/posix/timerfd.h
@@ -36,6 +36,11 @@ COBALT_SYSCALL_DECL(timerfd_settime,
 		     const struct __user_old_itimerspec __user *new_value,
 		     struct __user_old_itimerspec __user *old_value));
 
+COBALT_SYSCALL_DECL(timerfd_settime64,
+		    (int fd, int flags,
+		     const struct __kernel_itimerspec __user *new_value,
+		     struct __kernel_itimerspec __user *old_value));
+
 COBALT_SYSCALL_DECL(timerfd_gettime,
 		    (int fd, struct __user_old_itimerspec __user *curr_value));
 
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index dc4f53a5a..3d396674c 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -170,7 +170,8 @@
 		__cobalt_symbolic_syscall(recvmmsg64),			\
 		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
 		__cobalt_symbolic_syscall(timer_settime64),		\
-		__cobalt_symbolic_syscall(timer_gettime64))
+		__cobalt_symbolic_syscall(timer_gettime64),		\
+		__cobalt_symbolic_syscall(timerfd_settime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.37.1

