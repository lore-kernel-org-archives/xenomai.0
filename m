Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898B6674
	for <xenomai@lists.linux.dev>; Thu,  7 Jul 2022 14:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbQwnir70zJRbhB9PPUOEBfb0lbjUY0MFVcJzc43dA8ZOU/LeLNxbBWfRLIR8w0onGCbFh8Ps6x+cxhbc5NGccAhk4vzWV8wZyNichOUANvsikH5YV5D+A4Nw6Onf97YYzxi8Pxz9JbxdBSGSIbg2MclwjvYcACTjx44+rowc7Xlgk85zZPB4iTelHfadRm6Fa48ZN5j40zILMSgwqZZKf+hvf8DN+yvHpm3yio+1Wts2nlBrBm5tZueF1ipdW5ymP82YzKRBHSMTv82JjCykQy0m/i2ZorWg7C/VM1G6DTSMcU1OI/Eq6QMuBXFXzWBRWRtv/n84Qcw6IY1NaY2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys8GzmPzNcKYiMldxkr86ivhTktoTWfj86ijFM8ACbI=;
 b=jQbEqxjrHMK6F+8w0MR5hnLOh+6mrLflOKuepkzOD2XOZMUvfk4NmK5s0dV5y1c/mpDiLHgGCQ/F1MgL+Sqk7bFB2vfJwk2elBHAS1zh2tkEcC0vYmKe8//0lWFPhd/mIuuG2tSmPBKxldu3h78BLqOWKq81ZEwOp8uUtaJETR1DG0OyfB1fxjH72MA4qeFXyASvH3+/zDzRDstS7fT6oOXf9xJu8X22noDvEpwII0OsbjrPPTUfVl+FE2eDeGbYEylgyEhgAP80Gr/YWfrDK9dKIHbmJGP5M2l4UxA2ggEalxLMn1Niz1JjmfFPSl01iyTWjMrmxPRKG6aZrk+6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys8GzmPzNcKYiMldxkr86ivhTktoTWfj86ijFM8ACbI=;
 b=Whqj7u1GBvHeqF2QPOw+UPuIbuPvNtuE3j/ZY6RuarorfU2ZVu4Mk9zVMs4WtGtUWHQ48VKsrsIvxzqN3yr34repdSXdeumwwDtYbKkajiUCMZqEn/oFWyi3vvfEtY2rc+kIj0nxVm63QT8AMqhWeKTg81P4VzRYN3+mGZvKGK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AM8PR08MB5730.eurprd08.prod.outlook.com (2603:10a6:20b:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 14:00:04 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 14:00:04 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Subject: [PATCH 0/3] prove of concept
Date: Thu,  7 Jul 2022 15:59:49 +0200
Message-Id: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:803:64::43) To VE1PR08MB4909.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa4150af-7991-440c-0883-08da6020fe2c
X-MS-TrafficTypeDiagnostic: AM8PR08MB5730:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AZaJd60jgudjDsGSlb3AoLpK6WZRQE9O8DVHdQVRlWvt7Hf/wCESbVZv74EYyn0+HsB0H/6MihJQOL3Ls9H06qunZ8MCHNn7qQpzrpdFWwcL/G9kH+bcmFF3hW/9k0IFHemuQRzIGmyALHZ3EmGNnHzzlANrD29dig8P0juHoY38hESCz1+wPB3Btq1JdTIY/PdpQtrEZ4tn6R0IKsy0jvs4DfovBQPUgo1Hboay+mTVr8mYl2hDss+4nNyY8VFrMVyq9T2QDjdA6eaJKdyWlGi4CqVQfg3TLKt2vqsiZ/pcn8X4bh8CgTUj882DYXfLA4jDBcL8k+a3Nk5olX9fCRLISx13cmoWqMGEZZmsERnJuP0kz8NbQqYDU6u6kSVkNwGBaNhRj0gUCO7b1AiXAzHO2n15+uuYzwCxbl/Bn30OZK6HE98+ApBbfJa93hSiQTdUZ51aHtbYh1W4DSJMV5dEuP7OhzECkLkugkpvCxIZkdVHHss9gLsFswrToWlKTS45sPpQk6P0ySzOSTp7miAtmdL4fEO0WURlSb01cRJb4EbUFtNQsWXQfaTYM22YV1jWZnfNdZpvrEhplGJlY6yQZ0fkukxdv0aOmlXDMpB1BnEh+3S1UoZIOYfdOipHPoaiUwIRr4uHMz20Io9lKk+GgquMnesnNgAB28KhipJbdUfUy69fX789WlSAuCC/hqKf20tWtkM9bVbiG+SQur8qximEthJcymMuMAaYTJIsihzWjj/WHfg5nwENgoszcQMI5mNNSl1GqHwulILaVWHeVRGrHT9igT0GDirvkhK3YmBX+32/Jl12171rYyPS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39850400004)(6666004)(38350700002)(38100700002)(478600001)(6486002)(2616005)(1076003)(186003)(2906002)(41300700001)(66556008)(52116002)(36756003)(6506007)(6916009)(8936002)(5660300002)(8676002)(26005)(86362001)(316002)(44832011)(66946007)(83380400001)(66476007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6W7AayzHIy0y5TO6OnfYk2sfdSJ3GIsS6pKGNBKQzKWN2bqQ5Ow8QF9JBPck?=
 =?us-ascii?Q?e4jAqVEXwaefrDnf9ePO2tnYxnheuqnI93fqz3Ieq7CBTXBswsyELUphRJbj?=
 =?us-ascii?Q?twuM2wPVS0DwWjfio3yna5xDmrZHfnqtSzdT8ps8jGDY7yuh0VC4Sfg3ZO6d?=
 =?us-ascii?Q?pHHmpvEAQaXyhkkGJTi3EgYm/fjYCTJJLwUpqhMMvEr8BjkMAeknudJUsDww?=
 =?us-ascii?Q?SqEmkh8R6VPhFbQOVv0+bs224YOV4pLvXGspLvhkIYo40YOXeyXWkmfu+5TA?=
 =?us-ascii?Q?qFiGNOt/j5caggZy3nRalLhNU36Iu50jUvuwoXq/eBRt9UczOnyzjrDwSywj?=
 =?us-ascii?Q?/k+9PoQTUtmB8eeC399HLJrDguL3ApGi31Y50ncRYrGa0YQWHOwPyq7R32Ig?=
 =?us-ascii?Q?zKeDkoo5uvBsIEFr6AyjtMN/qIWiDRaBLg6Gf2GugC9jjzAPBkNzd3Dx9evU?=
 =?us-ascii?Q?W24tuohXS9APpeNk+udfwhnGnOt3Yo2VnZTZx0H8tZpOUUEiO7rIx28DIulZ?=
 =?us-ascii?Q?/N9Chm/KYlFAxcqHwu8wINCe+q4gpuuZytmz+7iw3LjUjVfTV7eSi81Yc2iU?=
 =?us-ascii?Q?7flrAhNF9M48ngE1aNkvbDb7cbWJ0ermoMX1R1f/bBjW/kWK1TQkHcRaJ+2I?=
 =?us-ascii?Q?/V4gTqSwchRTNqKb58uD3MCv4p/LXXDEnPZ8of9s9mzzi4XLibkJ5r8qdbe7?=
 =?us-ascii?Q?C+IiZBHOIF3xwyLia2vCGz3gpcxc5eYAGzSbD8IIlV++59eZdf9E3hTh4MvP?=
 =?us-ascii?Q?vEYPTjNbyqfBIDqYXOwE4GZyc4YAtCZ4HNUYiMNcEpHafHww96Vqa+fvctsw?=
 =?us-ascii?Q?gY4fsfcn8J9mKjm/1hT76Pd5IJQxtIO1U/0qFikYY2gRkG2fOFu9WApssQKP?=
 =?us-ascii?Q?4aBwSO3Beo7qSByPMPF4JNorCXiGlGNJ0nbTbMMnl9URe20LCTTqZi1rZ209?=
 =?us-ascii?Q?crIa4kHPicAwL7BOvKOcuH4nj0ER6j+CX/bVD9wPCEWg2smrrFrlkI3l1ZhR?=
 =?us-ascii?Q?05ZfI6dSj42f/VDvE1V2hJQbusx9y3kWrxDyhOEzKb27atGmM6d+cHBKGk2J?=
 =?us-ascii?Q?yJjxV4iz3ANaVPdhEBDDmtbeGI2kZUTaC/8mjpnZ5KOyOnimBgE3AeYTeLYh?=
 =?us-ascii?Q?d6io+gZPMwSHizdLIK9+TBSfCHbTZCwdHih4uTmxb/G3PbraSP8WkEPPoRVt?=
 =?us-ascii?Q?vNdqnQ8irmmJr4gxSY+Jh+N78AG0uOBIQi9YvXwwG+rL5TbTKTYLNlsn29Hr?=
 =?us-ascii?Q?OTqQtbxGZp9lkuDOof2e7tLxrZZMaqgOSxH2s/49bi+7pHGiJ5Wtfaf3ZxnL?=
 =?us-ascii?Q?9DvScpdQPq/4vsQcvWCbhOl8uKLGleAqCarlgmnHGQd9vjzomss11MYqaff0?=
 =?us-ascii?Q?5/1v9y0Iuvm9zCDyxXmlQi6RZyTPpc6VB3u+GXiyOLt+uTObY6Mg+72KtOmZ?=
 =?us-ascii?Q?Y7WfCQAvHddTq+iqSAMgn3+o8q5eBjizMiq5PATkbdqyAYEGqN+4Kwd+krIX?=
 =?us-ascii?Q?UU2lHmNqvg5l5KFEW1bO2TwXiZqvq+5K07AXHjAhym5A0s3Rn8SCmz2dVINx?=
 =?us-ascii?Q?/8ueKhRK6dVidDODTEBtQmRsbfCN+3kLhQbP3Z3vGIh796BOTKgg1uvwAX/c?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4150af-7991-440c-0883-08da6020fe2c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:00:04.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ak3Xh7F9Y/DhdEGMxhMtQ6HagTzGsG0rwYJRAqzahQRypdcErJPtrEhi3lA9vsL2u8jFxo75DmenHhGIGjSvE9Vuscnd/CB1+ZwZZUf11Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5730

This is a prove of concept implementation of exception handling in Xenomai real
time.

It implements an interface similar to the posix signals but with a much smaller
feature set.

For now, this feature can be used for handling floating point exception (fpe)
and illegal opcode exception in user space without losing real time.

The fpe exception handling can be used for fixing division by zero errors in
user space code without dropping out of the real time domain.

The illegal opcode exceptions can be used for implementing breakpoints. This
can be done by replacing the breakpoints original instruction by an illegal
opcode. At the time a task tries to execute the instruction an illegal opcode
exception will be triggered. The thread can be  suspended in the signal handler
in user space. There are two main advantages of having it done in real time.

The first is if a task does some time critical IO or has to meet some watchdog
constrains, the signal handler can be used to bring the IO into a sane state
before the task is stopped. Same for the watchdog, it can be stopped before it
sends the whole process into an error state.

The second advantage is for processes that have several real time tasks. For
example consider a process with rt tasks task1 and task2, where task1 is of a
higher priority than task2. If task1 triggers an exception and is relaxed to
the Linux domain, task2 of a lesser priority would take over and could block
the handling of the maybe more imported work/exception handling in task1.

Disclaimer:
This implementation is far from being ready to merge. It is mainly intended to
be a starting point for discussions about rather we (the community) want some
kind of exception handling interface in Xenomai and what a maintainable
interface for this could look like.



David Oberhollenzer (1):
  rtsignals: Add rt_signal test

Johannes Kirchmair (1):
  rtsignals: add i64 signal handling

Richard Weinberger (1):
  rtsignals: part one, core code plus x86

 configure.ac                                  |   1 +
 include/cobalt/kernel/ppd.h                   |   3 +
 include/cobalt/kernel/thread.h                |   2 +
 include/cobalt/signal.h                       |   2 +
 include/cobalt/uapi/syscall.h                 |   6 +
 kernel/cobalt/arch/x86/Makefile               |   2 +-
 .../arch/x86/include/asm/xenomai/thread.h     |  15 +
 kernel/cobalt/arch/x86/signal_ia32.c          | 293 ++++++++++++++++++
 kernel/cobalt/arch/x86/signal_ia64.c          | 283 +++++++++++++++++
 kernel/cobalt/posix/process.c                 |  10 +-
 kernel/cobalt/posix/syscall.c                 |  28 ++
 kernel/cobalt/posix/syscall32.c               |  16 +
 kernel/cobalt/thread.c                        |  40 ++-
 lib/cobalt/arch/x86/Makefile.am               |   2 +-
 lib/cobalt/arch/x86/sigreturn.c               |  22 ++
 lib/cobalt/internal.h                         |   2 +
 lib/cobalt/signal.c                           |  14 +
 testsuite/Makefile.am                         |   6 +-
 testsuite/rtsignal-tests/Makefile.am          |  30 ++
 testsuite/rtsignal-tests/test_rt_signal.c     | 185 +++++++++++
 20 files changed, 955 insertions(+), 7 deletions(-)
 create mode 100644 kernel/cobalt/arch/x86/signal_ia32.c
 create mode 100644 kernel/cobalt/arch/x86/signal_ia64.c
 create mode 100644 lib/cobalt/arch/x86/sigreturn.c
 create mode 100644 testsuite/rtsignal-tests/Makefile.am
 create mode 100644 testsuite/rtsignal-tests/test_rt_signal.c

-- 
2.25.1

