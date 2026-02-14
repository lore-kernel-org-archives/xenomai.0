Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC573B1BD
	for <xenomai@lists.linux.dev>; Sat, 14 Feb 2026 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771069193; cv=fail; b=Jx9lZo9sFGJzG0WXVkw9dtJ907eJMg5x9s0uhXGiS0w6t2UnCDliOpF886GpvQaDczawLHzfdPTZ1XrBe4u7BglpwbQNxgJntCAfJnk+3SMzq7c6nuapVNw2dK224r//kJiuxl/mNFMD47yD3/ddjea/Z9fRgR/kgL/GIy0v9fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771069193; c=relaxed/simple;
	bh=CEgiQ/dvwc1IZHQAFx0FZm3f9Tc9Sd24cfFXXgRo0v0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oQRZwiN/Mjah8YM1o+ofUqlXI0w6Bcr/u+vz0oi0H+qbAv2J9MHua2l7daXR1VtjX7Je/zDJKkpqrdgVT/W8QAzFvjHwcA0Akpq3VqJiUKGx/eaqdS3DmDaWhBPQAGWYoGFNJDwxT6SOzLvdO7CSVRI6r9d/13w9NpZO/+DdNT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zdlBlPKd; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zdlBlPKd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2HVAnyKpAXwWglIeJymC710LsyewJJe7qaIBk4jb8NZKvwx1XOAWXyBnbGj0u1/8EQzLb4rZdbEIZiEdjgknzdGASI2fduJIlDR/Fi09LivRn7g+H3qnzjjRhd/KWV08GXr2lvA5zHoXoYGSGNmk2UNYZ825fphNRxDsjvxd+ZuvT5T6p0YThiwxoRZRFErkzHHx+FkxrexUENRT0/FBMU02Ii0uT5/8qSABcimr/OV2xoqc9PGfEhDr83HwOM+IoT/VcFMqullzJZo8EpHbhAziB4lBIUms4gyewjuj56jJaD7gEHr9vEcZyamjX9F2fcgnPKWRwcxqFiCeVOXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAHh9IEPJszEoJW+VNu7Ppiys/PSnlkNSBHkok4vGNY=;
 b=msiB4ohMSHPw58KZkkxOxBY9g9jqOTKF0Ko4cdIy8iX+Dk0bUsq0nY/CGMnFGGFn2azYm+4/Pa8GniIwfuVoxK2U6kxsEwaOvFcifPn6Ygkw78kFDkpOLtKBB3v2P8+89Y0DLmUeXOKkiGEq0AoYQ2gREa2GYODsmtVU213fjEeMPzFjVIhimBoqRVS9vyAEMOLOa6E1S6r9CbHiMFGPVFjEThshJppJLaMg2gXpWHW4ngymJT8QvQelUasyz0eF8c+rbOyMgCJQIO6tIlsXkv7cDyMDrCPmhux/QWGmShHVodIJXoGTCUDM+i6/fdYqORr8+1OXSX/TrmkovOO98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAHh9IEPJszEoJW+VNu7Ppiys/PSnlkNSBHkok4vGNY=;
 b=zdlBlPKd6KP98J/jcPzOXVUtk93Oecs44aNKFcIhrTzFma0iCvOt8OqSKdMTCcMluqELdMQ7lFrSiByWbnaKdzISm+LfGNEg/6gl3boUWy9luNJhq35QCOuEpgvTlOoW2/t0HwJeGkS+aaiKuOv0o93U+lV3ZOwv4nVVf7BKBFtZpYw0TDM/wZI9OaBkmEttml7gDIr40VsiblmcPwAqwm6TSevcvdzvPbsN7XnGsZtIIHIUeINhRFq14yncd6w6O7c2/KEUArt7eWmwCJgcZzL8aQn6VstWE0VqZJPpYSGtALky4kHZNCEitfVuiN6zIfeVWOz/IK2MEc2hsvwRyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB8535.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 11:39:48 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9611.012; Sat, 14 Feb 2026
 11:39:48 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail] irq_pipeline: synchronize inband IRQ log in exit_to_user_mode_prepare()
Date: Sat, 14 Feb 2026 12:39:41 +0100
Message-ID: <20260214113941.91453-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: d39b5c83-d6e8-4f7a-05a5-08de6bbdc235
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gXeqgSyErmrdW2mO8F5v0EBKFBlL5AsaCWQmXp8DhAG79GutTv3+jAtgTigL?=
 =?us-ascii?Q?Xjs7JbnIhaRtRhFRSeXzTIYU1qcULgxjN5HUn4AVfITKchLmioMwYlaUwcl5?=
 =?us-ascii?Q?dQYPtfr64InnEeFydaCG1LqltnaSBr4uDoW7xQ8+5Jl9nWSbVWQY32/SEEN/?=
 =?us-ascii?Q?heGtqsn44ylaoHWecS3/ZK8wq2MqolmSbYjyJljPOCOxoMRiMap3vnQEG4TV?=
 =?us-ascii?Q?xm9XP8Oh7WS6GNZVm3TdUR5e18pisxbTJig2HpwkveRd7HOJnOnCGEOIBSP1?=
 =?us-ascii?Q?CPd/kcjMoy57tOHuUFALTG2GoK485n9RsEkn8bBSoGT2rdxcnvsb4xfAsnq7?=
 =?us-ascii?Q?GJK6v+djUbq91vzGzaNT+LK2iGYo8EVP13+N+Do6FkQQddZ3KfDINx4JKLFw?=
 =?us-ascii?Q?stbrBa90Z65zEfm6mIJ1a6XIG5FE+UOL89bfhTz4Xf/IJNtvj40moPRvWfTT?=
 =?us-ascii?Q?9IUnQZ3PRACWij9U7HP3G6pTpOuqm49cIDbySx0dfWlrjj1p40cNq41Y4kAM?=
 =?us-ascii?Q?OA9IaIH1uEguYcm9gRs7WQ9ZR1KsTUG9245IRl5lJL2jVidCYIM0yIcSlXsA?=
 =?us-ascii?Q?4mFgZBYeWHyAyiU+pWUhztztmGJV0rhNTa8SUnb9gZXWbPZJoK2u9frAOhAf?=
 =?us-ascii?Q?EZr+oGDae7gGjAiPjzD6yPlhQeK1BpCRW165C6NMqUlVzwQGegFEr21Pgj90?=
 =?us-ascii?Q?0hggfud6gCiBSnp6sl6EbWREp9jhDjun/SSZ0MsgVJbQs2ajK4D047Un34xZ?=
 =?us-ascii?Q?zi+YuXebybg6yHtg+rfu9RBi5azNSwLjv5wq40gpqq4QFb0dAK4zL7rYhyDv?=
 =?us-ascii?Q?iEWUeeEtMICKdblbg20C9tLbCjvoyyveHmwysi6ahU8tNHMHDqCzaR7Wgdo9?=
 =?us-ascii?Q?/QHBov9Fb+SjvcJyHg1KPO6v6jJbLb5ojPft5q1ciCj/wHZ1U6kja+yG7Zbg?=
 =?us-ascii?Q?MqLKVN3bj15Hca7aJ3+dhH/QrUB3hT6ySMVGZPJiUTda45rmc2BOyWW9bUBZ?=
 =?us-ascii?Q?kaEImENYmRL5XGgWhcRpIw88fKH7kNPSi0n3MKj6Sb/EZRMW2gfqbme/j9gP?=
 =?us-ascii?Q?Kf2fecOTxtQgImm8evaZgQLjg7Q1PFdDhA1mKDOjPdqWNx0QGLfULHaYSjxa?=
 =?us-ascii?Q?ODIe0HgG6/Ph2zar3moBPwkOvGXcqVptEADlSlmUUvwgeATsxkW5swJXi291?=
 =?us-ascii?Q?op+NwC68BUFEI0ybsCvaa55ThkMyoxZnjb2I8zsxKafy3AJvAYHqb7EKGiNG?=
 =?us-ascii?Q?3l67W/q3Xn6LVIK61iUlO1zmu1dXl483UzY12ww7c5w/Mq97UZK/p0B80Nhr?=
 =?us-ascii?Q?XbYxEo2lRvJIMnc4GxNzoM4hPMlHpcuop/tzkNRckdLVOvqAiWX/Sf/f8IOb?=
 =?us-ascii?Q?gu089fIDgRyMo/RD6GSGJUTEi1X/3rV43T9In/8+A20Edmqc9eObmE1wFCHE?=
 =?us-ascii?Q?69UIiX6xYajHbBwZLyiuVibYAPyMkWHM/kl0R5ndjD5NhKdAKm7Zvlg71v7e?=
 =?us-ascii?Q?dLtUM0Q8u8WnWXUY3hadZQ0EfiN8p0i5GynenFBr6MCP5vw2pm2uCw7m5NG4?=
 =?us-ascii?Q?2HTgl3x72K0zQbBpKYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWWmNxCpRvw0LTxhbadg2MVZz+MLD8O/ULQynhenz4XwoX76jUVAmzKP+Oem?=
 =?us-ascii?Q?r2o7HaJ18bdYxsfICN34rWNCeFd6oIdbSN0WgdgqJJdQCWS2oKkBDPusvetm?=
 =?us-ascii?Q?8GAPDMtN6Tx+28+99up3YF5ibNS8lt00iKd9Z2jtltJubSmdiO29yN7uKdtn?=
 =?us-ascii?Q?HieDx+aM+k3Y5aAHExZ7ZYARQANyaS0/q28Hl2k23vr8DhjL/NiYuvuGgCdi?=
 =?us-ascii?Q?sfEp6esxsRXD4hHwQTfp8CNPV438DWpG0ByPKl1JkUJtYXObKvgd/hKXRgSN?=
 =?us-ascii?Q?FpMmQRWozfSm2JEKMRQZC9wcUkFrHogz89IM+wjyn8f+hUSHRUthzhJOy0QX?=
 =?us-ascii?Q?STXD8FvnReaql3h1jwwloh31FXt3pqBm2ZCkCSTFFDhS18gI4/DAs86fHZbU?=
 =?us-ascii?Q?dDXs+kdfafdNGKFWUGyFsU8pt5ITCaXfe4mkJafp19hFNeAWk8bn8aX3nFkq?=
 =?us-ascii?Q?doWBqsK/hr0DXtoITL+eAzJlaQCA1QprWpQ7k5gZeCh1AHysHKTRs+4Z9BHB?=
 =?us-ascii?Q?5BFM1HxrRMbmZnj8kd3gU+H45Dg747MiIrhvTrmlDez4Bq60jUIbc1zaMSUs?=
 =?us-ascii?Q?5r7d0lDee5pZ0nil4xIbzQfzv8EzOIizw3fuKB3ldD7RXUySRkw0csOxKLzY?=
 =?us-ascii?Q?XxfqdLoFOF4FFMJTLh7mPTWCjh+WcNp9vXOVx7kqfEnMEb4SczNNcUUAtJK9?=
 =?us-ascii?Q?3742yIKEUl8Tx1ZFW8/0CphzvCGbo+MUeJlZh3cICdI0twXumbHYlGV7KbE3?=
 =?us-ascii?Q?t1KDZjFRmXnu0IGYnfVO32dmqkzPFiM5yxJNzLjd546+zKqpvVYgFJhV/5+q?=
 =?us-ascii?Q?rCp32W3JVIhXisvOx76OeEwfQmXxERPhlXRvQZoEw18WRUrTeVAbGcAIZ2FG?=
 =?us-ascii?Q?S2DqrBXIzmAznNCzLXrtIdJn9EnWm/sdhcStzTV6MaocqrTLVdiMI0waauRI?=
 =?us-ascii?Q?Mzixz4uo8B+B5se7Xj68AX/1HYUxahyK+MxVCswsP5r9NjnyeVR6YREELvoS?=
 =?us-ascii?Q?gWHvBBUHDB6oqQ9nb9jPGGOJkvSzyax49lhgoN06dY2d9vu/tt5a+YAAGZTk?=
 =?us-ascii?Q?8RQtk0ZJHRp+ahKzfXXNLi+IFlI5SYEqx0/USHBOJlxByee6qDFv4LQ0YCkZ?=
 =?us-ascii?Q?Dvf9nHaXn4oEAdY5TkZGLBEsjKRBZuP8ovQ8CdBJAwdKHY764o2IfKiY3wxd?=
 =?us-ascii?Q?ZqCOjIqSgiBSW5lEYlRrb3Hb67zMnyMPJTJDWONNxOpIJdT5JxovK7tuprkI?=
 =?us-ascii?Q?e6DqElfVSSu7o70Y7QR8kTBlD7IRp/Ao5vlphnUibnozMkZ6jNHn97AH5Ktq?=
 =?us-ascii?Q?4smvcw6ENygE97CjyB8pEdrPgq9i9h85R6mIc7L/aFf7ovb0CA12pq3zmHxX?=
 =?us-ascii?Q?2DGUJmri9qca+1urxgPAZ/vDPIkTBMpP7OVCPLACUhsnyShHnCJzZ00FsTnK?=
 =?us-ascii?Q?92jGz5pF789/0T76zEcJcc0Sf1JUEfBL49PSFo3JLg/bHpJpIfaTGQ2Bkvsa?=
 =?us-ascii?Q?3I+8Xgs80sCEdY+dNfGN/VOV/nqkXlBzgjKqo1YwKK4yLsqDVyveAv0LU3ER?=
 =?us-ascii?Q?UX2GfUNzpdTNE5M+m2wEKP07QQY2JLD4czNm9tUIPHkyLfAsTSOEQTF5IC2C?=
 =?us-ascii?Q?jDvztlKzCSN8JpB52r0ATEzcNvK+cgxPJzrHAhRjv2MkwItVL1AGNbdc2p3C?=
 =?us-ascii?Q?smz0uo9Vl7nc+Dlx3gtJa4zxW8vkZwTeuwZ6f5hUb5BvbytYITg7eW7LNoxP?=
 =?us-ascii?Q?iJzGYyb3obV+kqZc0MHav2Ve8KvZLCA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39b5c83-d6e8-4f7a-05a5-08de6bbdc235
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 11:39:48.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZqs9OE52XZHjmQpgrL7s8wh9nbgCdwTcyM+ZWF6pZUQABmCa6AKKWx+NlNHS6NsgsSsUUotcxBef0xBRPApUzDdzkmI7piTPLXGCsSbF/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8535

Architectures using the generic handle_irq_pipelined() path do not
synchronize the inband IRQ log in handle_irq_pipelined_finish()
because inband is still stalled from irqentry_enter() when it gets
called.

As a result, deferred inband IRQs may not be played before the kernel
checks for pending work in exit_to_user_mode_loop(), causing
those IRQs to be missed on the return path to userspace.

Flush the inband IRQ log in exit_to_user_mode_prepare() before
entering the work loop.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/irq-entry-common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index b21fb5893a67..e5815511a80a 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -8,6 +8,7 @@
 #include <linux/tick.h>
 #include <linux/kmsan.h>
 #include <linux/unwind_deferred.h>
+#include <linux/irq_pipeline.h>
 
 #include <asm/entry-common.h>
 
@@ -237,6 +238,11 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
+	/* Synchronize the in-band log before the work loop so that any deferred
+	 * IRQs are played before we check for pending work. */
+	if (running_inband())
+		sync_inband_irqs();
+
 again:
 	ti_work = read_thread_flags();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-- 
2.43.0

