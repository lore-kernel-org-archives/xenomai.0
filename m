Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B5442E
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7fpYS8JWEJtF2XG6Ng82TgT4Cu6SFtVKbU+DZWZDZPiwc/c9/B3vGbYx32E0owRa1SPzH2n4bs89soZMr0QTSWufqiWHP2kPNze8+XURR6TuM/9YClm9mnWXqr2sDLl4ESfo9qUbJ95T49mrJcZM4XEloGR5x/5BbbphqErT17DEi5naZZqgQU46zSj1E+h/GWJFmadJBidTHbFtVopKgaNXYlysSLtKCyTrvrJuwMlJxwVcx/MxeT7XxOnd3DIDPHMNlFNlmuqZQz2bw8eOQb4PwgjHXGNZZOhifW5k3bm8vjlNiPMaCLvOE4OPK85itVNmbgNyYWBlsYKE2TxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htXlUmcrNmXe53nloIB+gYpqXRnUxOeAtiB5KV83dw4=;
 b=CX1aOTLFmNqYrDMQYfRU9XmEGD6hZPcz0HbhA3GMV6oDmeIT+0754yAHktnNGcm6P8zvtfzqaRNBTlUxbrkrcroDi/X3095+8iuoiigWCkSarKfULUOjHWhuKriUeM9g+9lDpfJ/ycoqXLz3nKQsI2P37Lg6YmGvnfvsZfWkToIDf0OW3/DRJL+dU4UWBF42rgL819YyXH4t+lWAVWHPNFbHfltzimROvp7lcyTyteXjb1g+tW5vkpOmbv+Zj5z9hWEieRuAjAI6RBJbyia8BKXaoFmMXJmErIdLXjYcjastT+5lvF28V4qvwdu7Mw3KsE34FDznQ7cxvqQCYO8RAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htXlUmcrNmXe53nloIB+gYpqXRnUxOeAtiB5KV83dw4=;
 b=w8utul1Sgg5KvlcYIbl1uGG/Hxijhny/7Dr5zk7LxSTb+LBssrzV7J4Do95QH/rMnB04y80eHjE2gswdBG+V4OniUcVuKFaYIZK8jhZrIJ4LeyibMNFqVftFV8CUvJihlfmMWkx1hZPKW8jEKruqtm0Sbwnr9SRtcjQKPmq83CnPmzApsYnk1B3KjEy00P8RsgCQagdZhy7JwwOULF7Q6d3hv83urPf/rCHEpP3YNCdM6w3z+Dk7vZd3HFHTHVsYpW+vI1pyHD/+IZLxfXALbcoMLctb+9zjSZVwJYbd2QUx3uoj4EDnVx8csRlsP0HXJYFFhwNiSPMq2hEFU7Mh7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:14 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:14 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 25/42] y2038: cobalt/posix/timer: Adding timer_gettime64
Date: Tue,  9 Aug 2022 15:43:09 +0200
Message-Id: <20220809134326.23688-26-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0258.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::30) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c7e8f30-a8f9-4673-3bae-08da7a0d3f25
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xy2ZrAf6o140q+tvguDmZ1z4onw3TVNV54jrCJ5EezBtVQ1Pyijia71JmAVb7PjFqAk5vWyLrmTq68RTDOZsk+JWu3MiTbqTlZuFexgImFbQ5nVnVmQDmrxXxYqszb0XGOfofVG8OUEwpt1r8I4FaYD5LQcGTNy+wCf3Cq+/ofX/atyDqOgMSsEgrWLuLqnfNedn8MLo2P2MrDezxNg7o/u2OGJjNQZpoBhLe89Boe0YrFi7Z6Gan9jUNgYQkNWb1Fmmbr4JyELSeT9tPyuiFOGvhyVqP1kC/8ZAUy/DRlbQOtIq31LMIAuPFPv5pDq3fNKIH3Ti5pVGl5tDuUhd7JC/uwlrxSFwH3VI6rqG1r3s+YvgWjHP5yUMjmPRig6+ABDcbDhSGYZj5x6Ys42jai6tEoMhaUETSlgokeUjeb7b7yxrEdqcO3vTMRFsesO8ijYZ/cmM5x0z1rgqDOi82ma5iyUT/NXfPkvo0xgwOETmwqHIf8LawjC57TBqosfsyYc4p+qpcMU2XkDIj+JgXihZYyMlUV9yHmHx9wNyikqkX4QULWnBbHZAFLubjw5tWQO87gqgN5QrZ59W/hjK+FRlP7BgM2QwI1eivybs6i9a+JEwTP7iMCCD2zfeqfsDs4cvbmW7Zbg68D4IRGcia+WjHl98EnKx+ZnqHH0IfI0vZaM5+GxWlbo14ANUKLYOBa97Zt6dX5TPEiQMNrkrEzzw8FevTJBlGBVXua5o9Ik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlVD1bQioU26XzBGurEV0zeWiL4EQlmYNchzMLsmL8eLFbczrANBnXEfZGEb?=
 =?us-ascii?Q?UyqdbUMhUI8UfqfnX4iC5/ktyCT9AbNA06UDnskUUbAX88wYMPNCu7Wni4VL?=
 =?us-ascii?Q?8eMMLkG2EyZFQ+1shyYaj7pyiG7q+1kEzBMnTWAmb8C4afhRe56JH1rNZ89m?=
 =?us-ascii?Q?hRkauBRUcR9RdnMUWL6iB1v+2atMnYtAQs85aGvBOMsxwBIunBULc85vTypO?=
 =?us-ascii?Q?e+vp+Sok+VaGh2YMRMTZQI8G7kN3vrwMUhFQo/vainPUehH0j62+steU3aOY?=
 =?us-ascii?Q?KcLesZeHgXv72BDt1bUQUHzCSMLLzkmKeDwLHEMikSikXO3kz86ZG7TJCo/c?=
 =?us-ascii?Q?eQzJe8hBfAv/0CFVPMO1ncbbJS1IkGF6Gh/AkZrBi/0FgJx9ubjkyRJhdRMN?=
 =?us-ascii?Q?NjdrHybp+CbRwvJVwd+EWRATMuoIGJb1ER/F0BY5zXmTpJJfpiiFg4iHyVzb?=
 =?us-ascii?Q?1Fwc+ALrcPmgiRB/1NLoJTwiwlWEcQEOTfB0PEqN0fpODzUS82Y0PVjo6fQz?=
 =?us-ascii?Q?BAM3z0Q3IqrmUIsLyJTL4axkUfYrIFk+vsvuyVpld12CRHGbR9KKmwcwiPkB?=
 =?us-ascii?Q?JoR9z9riRCeJTygLs4GVHobRnWh2FpQTiH/ZWBAVS514k2CcTsT9sfaIvHAO?=
 =?us-ascii?Q?zoaZ1rBLBQBNwmZALVrAcQBh8g8LazTQf2pD7JZC8JKnvx8cFwXlWdclIouj?=
 =?us-ascii?Q?9Mgz+BlE3Va0yDWLfzUvDFOJanceV9tHRfvUVb6qpUydoTDohpPHsxgkxcpq?=
 =?us-ascii?Q?OJDFnM8Zb5A/jbJ/kjh99IA0pxxi6Z/bt0uWTKkPqutTbr2wTHqTgtmMAlx+?=
 =?us-ascii?Q?az270eQT/FqDWnpducSkL5qoxCjkvZyIeBcAaps+XGEd0nk2yxFctci9rBT8?=
 =?us-ascii?Q?YqUPrVjqH24OTs/MjAEtDBtJ/oxfwSeoZgK0VF2QbBezgWlc24uWqAL4lguo?=
 =?us-ascii?Q?hNOWn6G7PR9D8KtVVt0Qex7L8STtxGn4K2X11lXM6rVCRjQsHrId7/UgudeU?=
 =?us-ascii?Q?XgCLW2Xe70oXHzh6+ueKthXkYI0LKtdwd77k/Gkk1Q/uYkSzKCm9A+3yqhYe?=
 =?us-ascii?Q?tg+Q6A99TjQWko9jAAGfyTQCK9o0vAB3QJeYe7Dw3PLxUf0jQOhQ6YeYHRgA?=
 =?us-ascii?Q?cvEWhV7v7vAaEExtU2xlX1AVkU7U/Vz9aKP+yzsRvTD4jQaaN1BwW5qm/l8g?=
 =?us-ascii?Q?zXvY9+EZVogoVju8k/cI2HIzOnnsY80GRTVgj3D/4PDc/zszH5dykARtGyQI?=
 =?us-ascii?Q?CBpsk+ZtzZQtQnqDDlj/NIEGIQiPcb5vjx5dXVd2WcaT3k6rvuhxLnAXRT44?=
 =?us-ascii?Q?UNE0jDND5LKY/TWtMDDl4yNR09zdusV1SszNzrLDLLDlPr4BURUazl+CnIvx?=
 =?us-ascii?Q?mlQVAG6U6kJNlUTnorksfZhwbM06YVJ8iaLzsJGtTYjIIATOF0i8/uF6UN3y?=
 =?us-ascii?Q?eBnVR1s1wP+WDSQqAOMUXaSz8D2qiHVVtAonLCagzjv0lCwbygLQyIWNZCxD?=
 =?us-ascii?Q?cHmSnGWOt6QSc0tZIMZugOIhTE2tFnxWgqAN/Ixgv1d0aTSe1sbZHJnX78Hb?=
 =?us-ascii?Q?p8RQ/jTBU8L9m9pI8hWgtwdSUubBl5zgU66BtXlL0rBtYjZV1AtkszW8bVk5?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7e8f30-a8f9-4673-3bae-08da7a0d3f25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:13.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +02CrHdLzV8nxiwDKzeRZJOApszrDFVtTbbYCXwojsAru/Z/KpyMyjoJpasn0o4RO/QvLSXVxElyN9pVeIQcxx1Fnjh5am3LGIJE5YhrXxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

Add a syscall specific for timer_gettime with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/timer.c        | 13 +++++++++++++
 kernel/cobalt/posix/timer.h        |  3 +++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 77184bd22..24e759eef 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -137,6 +137,7 @@
 #define sc_cobalt_recvmmsg64			114
 #define sc_cobalt_cond_wait_prologue64		115
 #define sc_cobalt_timer_settime64		116
+#define sc_cobalt_timer_gettime64		117
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index b888f1927..37baf7a4a 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -534,6 +534,19 @@ COBALT_SYSCALL(timer_gettime, current,
 	return cobalt_put_u_itimerspec(u_val, &val);
 }
 
+COBALT_SYSCALL(timer_gettime64, current,
+	       (timer_t tm, struct __kernel_itimerspec __user *u_val))
+{
+	struct itimerspec64 val;
+	int ret;
+
+	ret = __cobalt_timer_gettime(tm, &val);
+	if (ret)
+		return ret;
+
+	return cobalt_put_itimerspec64(u_val, &val);
+}
+
 COBALT_SYSCALL(timer_getoverrun, current, (timer_t timerid))
 {
 	struct cobalt_timer *timer;
diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
index 16d3a572a..864c780e8 100644
--- a/kernel/cobalt/posix/timer.h
+++ b/kernel/cobalt/posix/timer.h
@@ -86,6 +86,9 @@ COBALT_SYSCALL_DECL(timer_settime64,
 COBALT_SYSCALL_DECL(timer_gettime,
 		    (timer_t tm, struct __user_old_itimerspec __user *u_val));
 
+COBALT_SYSCALL_DECL(timer_gettime64,
+		    (timer_t tm, struct __kernel_itimerspec __user *u_val));
+
 COBALT_SYSCALL_DECL(timer_getoverrun, (timer_t tm));
 
 #endif /* !_COBALT_POSIX_TIMER_H */
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 5f99b1162..dc4f53a5a 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -169,7 +169,8 @@
 		__cobalt_symbolic_syscall(event_wait64),		\
 		__cobalt_symbolic_syscall(recvmmsg64),			\
 		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
-		__cobalt_symbolic_syscall(timer_settime64))
+		__cobalt_symbolic_syscall(timer_settime64),		\
+		__cobalt_symbolic_syscall(timer_gettime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.37.1

