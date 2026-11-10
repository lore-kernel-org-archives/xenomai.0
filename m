Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334121;
	b=rdf9JrzUAO4hY83iwlaUEUegpf6AF8swwpwQaway9w/PXl8g1FT+cOyngopabPlT+vqY
	 eLCrJzsmCz0jvAmGlz0Cpi3w1FrC5DJvfaKBv8SudiUjpS3ohpErJR2mrTdblJ53aWEgi
	 oJcDTDUDSUFM+NVMopsubbsjsEA6iOFRLHr7AbhnCA+VYgF9j/pUSfepzBTGMCaWDIz7m
	 l5tnfpk/boZPJ0f57wwlLVZkJsnbihtmp154n0cSIJg6iUQIxvHjJG2Ob4y4dBVx/CzXO
	 Sjfeoxdgbo6p2t8fkOFtyDIw8utJ3S+ilKUyc8oG9YaImy2LkVFXU+7ShhfFF0+DhOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334121;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZQ2Y4UsPzJaFfy6Pv+A7f+w4RB/6FKhDNwmOGQS4vFY=;
	b=3kcToRQRWvHpoQMT1RUlYpW9THWt32x/R0xDw2NfAvM1T3j1iTJxaeYEUnhno/a8lTR/
	 rwXuXGltIQFfyI34xuEA1hrg7GQQTTfYbBJJqy2+S3lidb1qsoWsOLzIqRR9gq7pTksiv
	 Ii5lYwV7SLJ1IuwnsuVZlTrVWxy++fRrI83G8v8zg6t/ZUbpf3XZvyfksTQjfeDptFTmO
	 iMaOVUQPdCRONfG45e4S1JyvgmYVZgblM9cwTdsNsTp8BfKXR413OVTVkrcQcf1gQVtBU
	 pdLnevXgRZj3tduqSOTkRAfekTc9azT1XvWQqFJtxPE2WnLbQJd0gW4575JXftGbW9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=khhrpjC6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1FE606A320
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF1FE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=khhrpjC6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSMFZkoVrlr4LqViUyAGRDSSRCpFWLx881YJFq2sDdEJBVIOdKT1PhTayzMpvd9B2BiN0Sr5nhYzIOOdml8jAnFuQ1oyk7P4omZMfDGes+gR8h3kcW+A97W0hY5CoPcGWyULna3WH0h5EcDI1e49Wy83ybQVBNI23faAcqz4cEqfljGIf7LfNyhOMQhpCn1/deIO0NE7iw9oOnpAuWHjiX7Fc674NIGjeiicjYX3PnSqFCy+QmSM2pvSdr+Jb3IB06NyrT82aVp7+owEtuRrMLgt54axIBIfQaT3BPjaVfhKRp6P0HGgcSwxCe93aW3N8DyBIaY1Zcsnk+9ZqXmDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ2Y4UsPzJaFfy6Pv+A7f+w4RB/6FKhDNwmOGQS4vFY=;
 b=XRFFKmpt/NM1medTTBbeR4nMpMZRUSVZ32nq+GAx4DBOWKDX79JyWDJY1jg+pnUkP3E67rvL6nQDJh84p3wk/hj6fT751pAv8lsBL/yLQ/cfH9uMBGNHSbkrIvwzFmnKCgTj3Xjl8rmT+nFHKpX+YSNDzp+3LvVJS/rdYveRO2R53+xSIG2e0WyGe3Lqm2fVCwUyJ5VnbPVznJ4/khjdAJkBitU9Xk362ADgWEXaTYAo1m6Ehmj6XOo/bxSqzcTzZKEVCT0+vkw4a4d2cXaV2PG9ywO0Sovl4Owl9bTfOHkn7p7Ksszr2/vySW6x2HqB/RfBIE9uFcB5aUjl9RtsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ2Y4UsPzJaFfy6Pv+A7f+w4RB/6FKhDNwmOGQS4vFY=;
 b=khhrpjC67SWWFCBtGsOif/S1dECy90GR7f30fpOWbcJKamwGJaTuaf56kGg3icMPiudRfkQAyvF29k8Kri6KbLXmP1TZocz4GaH+WBUxk7DdejC2S8cozjDXXClhVcY+xBPEtHhkLIqObyv5nJ+TbXd6f62bxgfy1ecn0OuTVunpMtJNHcTsGTeQJPIxu0MzyPaOj1SbMIoowMLzrgUbOa4rj3d9CfMbPm+hVpyYsAEnolWOgVt3xODovwwi4fiX7iikKzQ3BRqCEVK8+3foZuA2OWssiJ2FzuyWW+eIQ2yhqp/dt93AvwRr8KJQV9iKbY0/ojvO3eNF1Q/RyRBGeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:781::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:08:37 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:08:37 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail 0/7] rv: runtime verification monitors for Dovetail
Date: Tue, 10 Nov 2026 19:08:40 +0100
Message-ID: <20261110180847.633167-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AMCPR10MB992240:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bc22e1-4fad-4d09-6467-08df3f55a47e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|261021123027099003|261028144727099003|261102123227099003|10067099003|20046099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BZQuRwIMn68gfv4uIs2HSEhw9TEL/A/u5MUOpfaNPquBdKX5zKJ8br6x4JC3n/ryCgq/ojH69P6YlEQ0CLuJb5UsECfeuaQGi0OL9i3vrfDjJ8z/eOYlLHN0hkCoN8AdkvT1XituU3LSLxoFTyFGawkFpPDu3XSjMKNOH0iqzhGDZ+YqKvLwc+YOQTcG/+aqhlxLgUfCcms/rZxLYFlQ9IvHAutq7IyiVR3NH2wQjDNSY90TpN7QiMk+nDtsULSP+GycLjpvPXAfq78o18NMOozlL056IqznxuXqDj3nTdwYNskRe5o7bJWtrawqHrhF6Y/e7Z3jog2FmHmsFihwgLMEOq2KXAPkOszul59+skxt4/emx8pc1DO/yAbWJ5j6U4Pc8TSvXebBkIsqfGW8ipnZ6RzVT47UE67xmq0JQl570kZUu0A84JpW1TxJenQkj3AMfQETbE1nMLYWupV2MJOH2rihM9scIOQEHniM/XYyRHpLU7qMsctrkX0NrSJXtRfcQITQ9WwfLbXc8tS6gC0qIHf0TDtaucxriYhsp2XX83kFD9kZ5ZTCjqRlMtyKdr+Ha+gKi7JHipqRJMj5xtGieXBN3uTdq3Fr283C4hCmO2DgxvheY+ZItZDQF9SW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(261021123027099003)(261028144727099003)(261102123227099003)(10067099003)(20046099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CasdWk8z93SHuVOkHqX4NbnoA9tPrt/mrLa7lc6ttNRq3LKCN7lflOqqT9Un?=
 =?us-ascii?Q?Jdaw2Wr4FjUCrGcWuoxasWZs6udVOCz8SaMw4NBWrq6mrlZ+v6tYXMrkQWlL?=
 =?us-ascii?Q?b42teKKFuqCepQosL2XkMJOT36M9Eyk/aXn2iUI2xXGuiBrm1FWIHdsVd8eJ?=
 =?us-ascii?Q?HI0ujWB+rI/pFfMOameGAiHTGMImNnCu8rx+kFXn0yV7o1II0JEaBK1sern5?=
 =?us-ascii?Q?YHXebePFEgkB+58DQHSg7OSwIIqX0ngH3S32+4k4zkHLfmWaVBMa5R8Q2YK4?=
 =?us-ascii?Q?yh4t9M0y/FfNmAIBGaTg4BvnSEd7rEDO33BhKBNUOoSHy5/9KXR3kbWYPzWI?=
 =?us-ascii?Q?c0W45d9Gt2UzsJrsfCIAFH9T7F7daMnUzbuZeqpUYQBaMx6PePrPTHwmPI7s?=
 =?us-ascii?Q?XSA+XMkI3MDw5tl3uCx6IQkAFF7AdndjEkCdRkTNECjbVFXeCDz2kuBYbLZS?=
 =?us-ascii?Q?wR9A2yvOeCsLpVP0HwHbw4T1SWbWXzrKsRCGfh9nGSqM7aDBdAoqS6AuwnFI?=
 =?us-ascii?Q?kENY9JcaY0Mut4oLyqyJyj9jWr385bwehjT2RGD1dp23t13SWyWYqzKl6wao?=
 =?us-ascii?Q?k1fCTKQqLO0JrAzGnfK/r24YHng5FxvzcPeDXPyjLOqgp4rfefvyJTKZo6JP?=
 =?us-ascii?Q?v+dBf9MkplgKo2xEQZURrepZ6/TEwus5gOC5dN+sfJu6eGeB7sG/9NtRA1Xb?=
 =?us-ascii?Q?u6xJSJtgiz2CzfOqWiJnwJGgnuOWt97BA5LFAxgqUmioLpcJkwYTn6sZiofi?=
 =?us-ascii?Q?K7/Ace1ilwxkaOqJkgGQSydF0zJIGl4+xVTVBTgx25ZLr+714mwTgu5FRNxn?=
 =?us-ascii?Q?4Ys3M6NNWJ+kzsP9+TWAgH0GW/yvAU+UinPCIlO9iTiMkG9VcojCR+H3aan7?=
 =?us-ascii?Q?fnTqtyYqacNrzvd8hfT1zxEZZ4Kq2Z6L3OAjnkbaUGHZS2xPUAwsTN4JqEK2?=
 =?us-ascii?Q?i4cwNy+9SGF8Cg1z2JhnRjowu2fO8pVkklgzF2iKmjEFI5XtJBhOn3Z4568G?=
 =?us-ascii?Q?ROmMbjqAnLgiEwwY1aGP4So0Z/M5AE76l0Yio1EuIKgS6ZpuegiYiE+gHbVj?=
 =?us-ascii?Q?+VHjwrwyMsnqjedKmbd6bw45AEfHtN45O7c/4Tz/cpJSzA7HYCV8mWWTQv81?=
 =?us-ascii?Q?xqwJm2+3bYKBu4Ht31Z0ndiz3HYR66l8CcRkJy8QSXPVyObI3gdWR7RtHOjh?=
 =?us-ascii?Q?/q+RfgfCY+PZ3uZnrVnGt8MT9o/7IKbqizpmR5UPQLvO4ycGeQIp2Vmzokdq?=
 =?us-ascii?Q?mWrl68S2eHKpKIA1b3JpJM9zsPhNXiL5oX40q7GbOBK7PyPmJMuhe2cqwV+7?=
 =?us-ascii?Q?r1bVmKRcpN1C5kNe9RF3MRo+uIqD0C37RKVzxbMATd94kAyIDQz+xPSDhsHP?=
 =?us-ascii?Q?RTXbmCqMTbstfsNTgceXsqpOM+7CA9QiD1w4x46q/r3eu2ldXGFcRf1VSmQ/?=
 =?us-ascii?Q?R7W1IendaqTcv/zviEZ2N43htUdQZSyLDkRTbhtWu10jcJ92uFsORPdPvk4a?=
 =?us-ascii?Q?x+kT7lagNSvzcUd56MciDv1s+py/rDpyaY/mdnenzbVYOOKlPJ7qrPF8RAGM?=
 =?us-ascii?Q?QAXNdoa4oLQm1PFBzEFin8cR2T2lIuWX1wCHqur2/4R409SRoqx6/CMcjhMz?=
 =?us-ascii?Q?YDEYXdqlOuoV1TEk81KkeuXTVEJg9GVGEWwvvPWiy2+8uDslcfRxQoZvPuPi?=
 =?us-ascii?Q?BqWSLS1v/0RiptID+e/INgO33POJ8B1MVK0p9iLgtP1g/l5QXAtnzPU4IBl/?=
 =?us-ascii?Q?OJPosTxrligO5IbgIBYEbi4zpYwf65Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc22e1-4fad-4d09-6467-08df3f55a47e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:08:37.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lP+Wgruf6fG4yO0XtTUYAK6FTEffJ1TwB0XZPvagdvDV3MZicj5spuSmJHa7HMjFrDXWejr19XEewcjL1UDjHR7AmrDD1IHo+Pvundo9ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992240

Hi all,

with this RFC I would like to propose using the Linux kernel Runtime
Verification (RV) system [1] for runtime verification of Dovetail based
cokernels.

Running a system with RV monitors active should ensure that the system
behaves as described in the model. As this is checked at runtime we can
verify if the system is even behaving as inteded when it is running the
real workload.

My ultimate goal is not only to use it for verification but also for wakeup
latency tracing and decomposition in EVL by describing the whole wakeup
path. I am working on upstreaming dwell time measurements in the RV system
in parallel for that [2].

This would allow us not only to get a worst case latency and decomposition
for a latency evaluation tool like latmus but to get a worst case latency
for any load applied to the system (e.g. the real application of the user).

This patch set proposes three Dovetail monitors bundled in one container:

 * offstage checks that Linux leaves a task alone while it runs out-of-band. It
must neither schedule the task nor let it raise a signal on itself.

 * oob_trap checks that every out-of-band trap notification is unwound for the
same trap before the task goes out-of-band again.

 * oob_signal checks that a task receiving a signal out-of-band is kicked
in-band. Once the cokernel handled the notification, the task must not return
to user mode out-of-band without a mayday pending. I think his monitor found
a present bug in EVL: since "evl/sched: get rid of this_evl_rq_thread()"
evl_kick_thread() skips the mayday for a thread running out-of-band on a
remote CPU, so the thread ignores all signals, even SIGKILL.

For the monitors the series adds a few bare tracepoints to Dovetail. They are
not exposed in tracefs.

The monitors can be built by setting CONFIG_RV_DOVETAIL, which enables RV,
the monitors and the printk reactor. oob_signal is not available on 32-bit
arm yet, as the out-of-band syscall fast path there is written in assembly.

To execute them:

  # cd /sys/kernel/tracing/rv
  # echo printk > monitors/dovetail/reactors
  # echo 1 > monitors/dovetail/enable

Looking forward to your feedback, input and ideas on how to use and improve
this further.

Best,
Tobias

[1] https://docs.kernel.org/trace/rv/runtime-verification.html
[2] https://lore.kernel.org/linux-trace-kernel/20260827072400.45734-1-tobias.schaffner@siemens.com

Tobias Schaffner (7):
  dovetail: factor out the mayday check on return to user mode
  dovetail: trace stage switches
  rv: add dovetail container and offstage monitor
  dovetail: trace out-of-band trap notifications
  rv: add oob_trap monitor
  dovetail: trace signal notifications and out-of-band returns
  rv: add oob_signal monitor

 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_dovetail.rst   | 124 +++++++++++++++
 include/linux/dovetail.h                      |  19 ++-
 include/trace/events/dovetail.h               |  40 +++++
 kernel/Kconfig.dovetail                       |  14 ++
 kernel/dovetail.c                             |  35 ++++-
 kernel/irq/pipeline.c                         |   4 +-
 kernel/sched/core.c                           |   2 +
 kernel/trace/rv/Kconfig                       |   5 +
 kernel/trace/rv/Makefile                      |   4 +
 kernel/trace/rv/monitors/dovetail/Kconfig     |  13 ++
 kernel/trace/rv/monitors/dovetail/dovetail.c  |  41 +++++
 kernel/trace/rv/monitors/dovetail/dovetail.h  |   3 +
 kernel/trace/rv/monitors/offstage/Kconfig     |  15 ++
 kernel/trace/rv/monitors/offstage/offstage.c  | 114 ++++++++++++++
 kernel/trace/rv/monitors/offstage/offstage.h  |  61 ++++++++
 .../rv/monitors/offstage/offstage_trace.h     |  15 ++
 kernel/trace/rv/monitors/oob_signal/Kconfig   |  16 ++
 .../trace/rv/monitors/oob_signal/oob_signal.c | 114 ++++++++++++++
 .../trace/rv/monitors/oob_signal/oob_signal.h |  74 +++++++++
 .../rv/monitors/oob_signal/oob_signal_trace.h |  15 ++
 kernel/trace/rv/monitors/oob_trap/Kconfig     |  14 ++
 kernel/trace/rv/monitors/oob_trap/oob_trap.c  | 144 ++++++++++++++++++
 kernel/trace/rv/monitors/oob_trap/oob_trap.h  |  61 ++++++++
 .../rv/monitors/oob_trap/oob_trap_trace.h     |  19 +++
 kernel/trace/rv/rv_trace.h                    |   3 +
 tools/verification/models/offstage.dot        |  14 ++
 tools/verification/models/oob_signal.dot      |  23 +++
 tools/verification/models/oob_trap.dot        |  14 ++
 29 files changed, 1013 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_dovetail.rst
 create mode 100644 include/trace/events/dovetail.h
 create mode 100644 kernel/trace/rv/monitors/dovetail/Kconfig
 create mode 100644 kernel/trace/rv/monitors/dovetail/dovetail.c
 create mode 100644 kernel/trace/rv/monitors/dovetail/dovetail.h
 create mode 100644 kernel/trace/rv/monitors/offstage/Kconfig
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage.c
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage.h
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage_trace.h
 create mode 100644 kernel/trace/rv/monitors/oob_signal/Kconfig
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal.c
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal.h
 create mode 100644 kernel/trace/rv/monitors/oob_signal/oob_signal_trace.h
 create mode 100644 kernel/trace/rv/monitors/oob_trap/Kconfig
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap.c
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap.h
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h
 create mode 100644 tools/verification/models/offstage.dot
 create mode 100644 tools/verification/models/oob_signal.dot
 create mode 100644 tools/verification/models/oob_trap.dot


base-commit: a3ad77d7ba3eac8a73f64026272747c01dd84fc6
-- 
2.53.0

