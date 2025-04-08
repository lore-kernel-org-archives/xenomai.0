Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13451267B96
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115317; cv=fail; b=EqSFsD+y+LCM7Hvq5nhoy1uGh3KA5NsJAAv10EdwoWKF8bouKsE25B5/kW+6EvxnjaEh/3MerWzgMM0CR6GRnlSU3/enpvS/vlI4Vdqzl/WCqMpCQQ6i7PXPdxjiqRt81jJ1ZnihE6NFz1Q7ORXzkMeLmbmb+wZ4lqOTvz8d44g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115317; c=relaxed/simple;
	bh=cbI/TJTx5gdfKZRx3efCKwA5XuyFC1c/2rerEoMwuyY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AJl8J1biKUijlDSBkGA5caIJqsdTUcPMhhe4sEQ3Qmo1+f+4UG/V/sqGT1ummfQ15A8ks+OEbcu2pZbXCKmyuvK2apF3wXH7RwD4xhlWFEfLHiOdqoQIDUSXuYqqP5U31k3BrBOkfR9L9fDuTutMRu3yC3cj6RB/tPzS1z5+LFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=gXcUq0qO; arc=fail smtp.client-ip=40.107.22.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="gXcUq0qO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxJKjehfXldovetzjx/ODcsBQLWpUZbV2dplmWkTe2iQI2Ykus5j8Pe2MwSWvkayVz4QNHWSNu6L2Qi+KhmAQNR4B3fsTLByRiIz/mwxbdAmApmgLvWayooyJbJHcpFDr3g0Qr3bnCyNvYRfnwLxHmGR01YSV40X9CSt23zPJGpDF99q+qCBexU+dnWxFhsX7BUFG/b/kUAAkL0HcV6qTiB/H3BrCuB9T4g+JMYuoel/O7k3tRqhLtVlPwVe7v4dZ9E9oAr7LEH3w5KHNELZ/m79lWSNnbPF3Pvr2Mdj5rprgztLmj9CGnmfwKPKqojLBB/xcveg7di13yu/KBd1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvzYpTdqgR/uzxZ9wpJTc5PilJJbQ0kTllJUaR8MZvY=;
 b=wKGBbvqFUjpM7nczZ14Za/moG3StwBfUOJzA60eyHuYuK0lRW5cefR3PyfWJ+18+POEt6NQ5LsWRMB2VC/t+0ixVOaC9F163lUWYJF/Y24UEPndqT2rWVM2g51BsvNCDYNECddFLc4icoAqhPLtPg/lfsawycTBUXyI2cnx9bMGMA5j+XOMh/kgetEYQgj1hV1zUvvCSmRn8BlxQm+8HsS7meIA4WE4EdiTOANJK1QhbVEFcQcJ/kipIJhlDazrpekh+Y+QdNwGd4xyj8xxmBdRfs5qz+UKLZV/f0tRQxDcjwr7+kEHFimaEwTtj0gvtKo8OkPnRlMN5lc+uok2cRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvzYpTdqgR/uzxZ9wpJTc5PilJJbQ0kTllJUaR8MZvY=;
 b=gXcUq0qOr0SIB5owfD3YrubFA9sfPHUNUW1e5042WOk/S2cyq9M2aXB2EAZwXnNP0n2S3kfpekFPJa9E6ieNMAjYJuFL3eMxr+zdn+bYel+cOK5657kXUhANbeGc+w2CcH1iMD8zgIdFlLjoFs+K4xDbsgBpauc1Or1+JY5M7zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by AS8PR08MB6424.eurprd08.prod.outlook.com (2603:10a6:20b:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Tue, 8 Apr
 2025 12:28:24 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:28:24 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 0/6] Xenomai: Real-time Exception Handling
Date: Tue,  8 Apr 2025 14:28:11 +0200
Message-ID: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|AS8PR08MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: be44787d-6fc8-428c-0ea9-08dd7698db77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HfID+1+Zm5aZ70Zc/2jHxd+uFHvQayds/Z9KHNp9X+g/BwZcWgkCvSmuVzlA?=
 =?us-ascii?Q?yVUCvrYLcUXOQCG5b5aCawHfMJIRKJ56U/7DNTd66fbC/16AVZFS4ezVCnxp?=
 =?us-ascii?Q?YMQsHx8qXRlJgbu5srJud2Qyd9NISv63OWxY8Gi/+m+SOdap86amOc1GVDnX?=
 =?us-ascii?Q?FKw62sLXVDvj7JOqLdZhtmM1Ce630Io/2tfhaJFhGyRpZhLqT89lXAMnaWjs?=
 =?us-ascii?Q?5zseuhF0m/Pe2yYmAQzlB/vSkOPqRPzKrbQNC80q93phkuPiVtQUMSzmcmNb?=
 =?us-ascii?Q?n0A5lEz81nn08npmVfK0a9RVpEIskaIN7mKedXKzHNDUU0TypbKVntZWTJGp?=
 =?us-ascii?Q?o89+i/y3m3W5RRcuX+aaB7eoKuTb9CvtrUs6g4pdPKCO/v7NYztisfDkqzIw?=
 =?us-ascii?Q?cTZlcUzMO10GXZwxTVsSqmDTriJrUJ9P1htZgyCXXi6wHbEeI40lBpTDdnaI?=
 =?us-ascii?Q?hASQcbSohgaijUoKk8tri1JX0wLgasqhBgHzW9/9S1siXH2CO++WFDcKAwOQ?=
 =?us-ascii?Q?sxd1EsqJvMiQCqvtg2QR19+wTMCETkAhWLIezltbRDsjrSF2yjblj0Q9Q0Ms?=
 =?us-ascii?Q?CE489BeQmUpvXGiQPoWyJi7gjlZFIck9BKbQpmuvejzQTgA+/nl0lzt34BjU?=
 =?us-ascii?Q?gIAkEp3igW1kO3HrPB7nrYRf/1mrzdTxvB9ao0ajKnpABZqJy+C/KvdL81Pw?=
 =?us-ascii?Q?CwqrFxxSYqbdjQ3NLhnQWk69jQ6z5LNLxNY+4MJrmhJ7X8Oe5VtY3bDF3Iiz?=
 =?us-ascii?Q?Am92V4ywDpC1fyzFjegHj6iEEnqomXUmflT3BpH1QHclrjZxcp8STPlcdx9L?=
 =?us-ascii?Q?eKKO4mmwQbv2NRn2xwUDI05u+XVQgLH8BaOTVVwLyauLVLscueAUsMjbbDwY?=
 =?us-ascii?Q?u+/nqIIumDJnJyxn6B4PRyABRhdim7sG4vKVnDKZpIeqDNEwcix4SAjIN6pm?=
 =?us-ascii?Q?dtvYWRdrnzksufQlXLf/B1cDqOVX7kS11utzj1h9Ssp4nLnUK5kP5fuMKpl/?=
 =?us-ascii?Q?9q8IIwCddGojswhb464qhenzsaTRx252HAyJfB+mJBdTKAg3cu4P1EWejr8y?=
 =?us-ascii?Q?WSrF61yVYBIlIRMX8+oZqT8EcoaTVi9vv8GjoQ21lvG4KtQYtz/OKILSQ3wZ?=
 =?us-ascii?Q?xEAWPMeVUiWeFDrQhkNstW9QwBX4QTdxeX9Vglh5DtEYk8wORWjro96RUeg8?=
 =?us-ascii?Q?dxlYxHCKnru6XYlEw9M2rC0a/iEo/sSCvPQoyxPjp0vlhuHxCv/R3/lEPiJj?=
 =?us-ascii?Q?GmCVhHxcXefgHO7H0i080CUZ7ZirOV4QaWbszwGpLDmChmAvh7NUTAx6ujCT?=
 =?us-ascii?Q?RnQ7soryfAivrPwhC4hA+DSx3FfDH8IqIYt5t1no+9nA8Wl3JFWoOHDlToYC?=
 =?us-ascii?Q?Wyy2xzCBlxAI8wVEUagj7RoicAkIphk+Hezs3kpjXRb0PFGz+a5NQAg7ru2e?=
 =?us-ascii?Q?hvl8X16gtrkUK1TpdCWFiLCIq9nTEAvv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qA9x0o+CfA1woCm89OpqgBN5g8/JZo/9q/8XwHw5G0p6TQvQJeqhj5gNY7cN?=
 =?us-ascii?Q?CbGdbU7mKDQtZf2peL5JOsR1MhO0LiaZTkKzx5IFSB1WjhQNwFpLZ+xpwouM?=
 =?us-ascii?Q?JYQujNMHpcUFTt3pwMlMhT5ns+lzs/ldL4HAaft6xt81k0VgNCT6hdM2cdJo?=
 =?us-ascii?Q?sN/OUiIURF4k42pXv5eyhEtgVyt3g4mrYSyzWe6su1KE8ueRo6x4hyFFkcCj?=
 =?us-ascii?Q?l9sDV/t8hVojkaTK0FFWB2aY3hAvqJcJ65RsY5q2Qtpb0aHtlQk28xTvxjYA?=
 =?us-ascii?Q?botgjpbzIqb3VXbuJnI8nDkf/h0Ez4sj6tFOjD1xcAgAM3LW9+y33AkaLauP?=
 =?us-ascii?Q?XgUXuH5lZCRbibj6bVotjtjEOxxpLAw7lhEQuc5AcGoCAEU6L01BzIFyxjUj?=
 =?us-ascii?Q?9tAL6xa7CX0Dk7cyUzH5bwklCBGiOmn7wLuqZ3hGoTXpcYERURHhiP8VdwuM?=
 =?us-ascii?Q?AkB/g7P55wUBTFKj1lDBQ8RfrqV8lJAjh0p/FBJ7HaJx75NEppFwhNEWSOUb?=
 =?us-ascii?Q?R9k9nLsNAiKto6vN50Bif9B0GFFrBQNk47WYJumVS3Iw4UmgJi25Gj6egPtA?=
 =?us-ascii?Q?WgMUmTziqbxgSbp5vASSPt1NizRNwNc+BQmcTp/KBwiDWLSzkz8Ifs8ClNno?=
 =?us-ascii?Q?ZRpOE+LVBCL215cGsZjoAsIOCKBQQRegxbnBEK2/OkWhrZ1Su6yR1ESXxW5t?=
 =?us-ascii?Q?QnAxOqnl/o7wGF/amCAGi1wOYr/dzOdGL9NvmXbJ3LDF5cII+NCaqVH3ytVs?=
 =?us-ascii?Q?wfiq7cp40xyEJaNGRO3beYpnnTwKk8EOmnlvcvPzC0li2PSFen7CuZ32epvf?=
 =?us-ascii?Q?DcTiD53YYCHqbS16HZHfrDeWS+jnFVDWeZAQyTlr9ibSTK30MO8J7vu8rSOh?=
 =?us-ascii?Q?L30nEbhSC2zWWnROCG2y/BhcR1ZpoWaKh4vwJX2bRLkOIyhV2QEq211K2jsZ?=
 =?us-ascii?Q?aiq6r4IRvTAVeBrihEj7JaNQgF81iBltvz54xeFs1Ul6aOaZSyEVdeWY6XS2?=
 =?us-ascii?Q?vRynSkWlnM6PxaQLsJnLfgyuR6jGYHWy15ymNQjepCYPNM4OEn/3IEfizkT5?=
 =?us-ascii?Q?aYPWZtbArgjRtxWUxcA927GL5mjmFnQlP7fQFXmUJ5y5ZDfbjZcAGbNhT2j4?=
 =?us-ascii?Q?AJg2WyFSQ1UKfkwoiRJGQoOItQMtvn0bPra6YFCzuuVhv2pcCv6DLFou04n5?=
 =?us-ascii?Q?yHaeSzJNdmdb2vm7U/5R5FHmpVvsLkI/kcgORxL0z/IDgg3DbcKH9S7xJQE3?=
 =?us-ascii?Q?hHPAmzbUMrejMZYhF5FiB0Jc57Zb76uaTlbqHw+UbSMW8WkUSFRqhb3QJ9jM?=
 =?us-ascii?Q?Fi8oPNYI2hajjKMfvuZqMQXp5ZDfJO8PEOCFmq03/EW++8slnveIWCbJivKz?=
 =?us-ascii?Q?66C+0hMGBxdmKh6Ffdqt9lVGzYPliryVvDF/HeWBXGJoyNBMX7d38nM+8wi3?=
 =?us-ascii?Q?/YKweZiHwdhvjbwitSIk/GAJ27/4ml9A4q0dDYxc1t4crLl6xq3bFdRzzUFS?=
 =?us-ascii?Q?6SSMAnqu1APgSTzyiFM5TY580viL4Lf6/1OBim78LfaI0FeoF/6C9BuzI+Ca?=
 =?us-ascii?Q?aM1SHbKxky2U1EOXzJc1V7XjS5jtcmc/83dAd4t+547w7xArP/gB2zT/5vRw?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: be44787d-6fc8-428c-0ea9-08dd7698db77
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:28:24.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUfQz5sOtyQv/E0P1Mc+jiwD0QunbKZwY4JbQUM5FPQRsaqlAFSdSF20PjiYhmakwco9KUpALClW9CIiOCVa/6a+jtQXAnQexxQCekwHqx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6424

From: Richard Weinberger <richard@nod.at>

Currently, any exception that occurs in primary mode triggers a switch
to secondary mode, and Linux posts a signal.
This change allows certain exceptions to be handled directly in the
affected thread while remaining in primary mode.

At present, only SIGILL (for x86, arm32 and arm64) and SIGFPE (for x86)
are supported.
Adding support for additional exceptions is possible but requires
careful consideration, as not all exception types can be analyzed in
real-time.  A notable example is a page fault, determining whether
SIGSEGV is appropriate requires deep traversal into the memory
management code.

Patches 1, 2, 3, and 4 implement the Xenomai-side changes for this
feature.  Dovetail will receive a separate patch set. Patches 5 and 6
introduce tests.

It is important to note that this is not a fully-fledged signal
implementation.  The only supported use case is delivering exceptions
as signals to the affected thread.
There is no support for sending signals or handling block/ignore masks.
The only user visible API so far is cobalt_rt_signal().
It takes a signal number (SIGILL or SIGFPE so far) and a handler
function with the signature fn(int, siginfo_t *, void *).

TODO:
- Better naming, IMHO "signal" is the wrong term and will confuse users.
  Especially since POSIX real-time signals are something different.
  Maybe "umex" for "user mode exception handling"?
- Document new APIs
- Improve tests
- Carefully select more exceptions

Lorenz Kofler (5):
  cobalt/x86: Add architecture specific signal code
  cobalt/arm64: Add architecture specific signal code
  cobalt: Add signal core code
  testsuite: smokey: Add testcases for signals
  utils: Add rt_signal_hist

Richard Weinberger (1):
  cobalt/arm: Add architecture specific signal code

 configure.ac                                  |   3 +
 include/cobalt/kernel/ppd.h                   |   3 +
 include/cobalt/kernel/thread.h                |   8 +
 include/cobalt/signal.h                       |   2 +
 include/cobalt/uapi/syscall.h                 |   2 +
 kernel/cobalt/arch/arm/Makefile               |   2 +-
 kernel/cobalt/arch/arm/signal.c               |  27 ++
 kernel/cobalt/arch/arm64/Makefile             |   2 +-
 kernel/cobalt/arch/arm64/signal.c             |  28 ++
 kernel/cobalt/arch/x86/Makefile               |   2 +-
 kernel/cobalt/arch/x86/signal.c               |  51 +++
 kernel/cobalt/dovetail/kevents.c              |   5 +
 .../include/asm-generic/xenomai/thread.h      |   3 +
 kernel/cobalt/posix/syscall.c                 |  41 ++
 kernel/cobalt/thread.c                        |  59 +++
 kernel/cobalt/trace/cobalt-posix.h            |   4 +-
 .../arch/arm/include/asm/xenomai/syscall.h    |   9 +
 .../arch/arm64/include/asm/xenomai/syscall.h  |   9 +
 .../arch/x86/include/asm/xenomai/syscall.h    |  15 +
 lib/cobalt/signal.c                           |  19 +
 testsuite/smokey/Makefile.am                  |   2 +
 testsuite/smokey/rtsignals/Makefile.am        |  57 +++
 testsuite/smokey/rtsignals/rtsignals.c        |  35 ++
 testsuite/smokey/rtsignals/rtsignals_test.c   | 370 ++++++++++++++++++
 utils/Makefile.am                             |   2 +-
 utils/rt_signal_hist/Makefile.am              |  22 ++
 utils/rt_signal_hist/error.h                  |  15 +
 utils/rt_signal_hist/histo.c                  |  47 +++
 utils/rt_signal_hist/histo.h                  |  14 +
 utils/rt_signal_hist/result.c                 |  17 +
 utils/rt_signal_hist/result.h                 |  13 +
 utils/rt_signal_hist/rt_signal_hist.c         | 237 +++++++++++
 32 files changed, 1120 insertions(+), 5 deletions(-)
 create mode 100644 kernel/cobalt/arch/arm/signal.c
 create mode 100644 kernel/cobalt/arch/arm64/signal.c
 create mode 100644 kernel/cobalt/arch/x86/signal.c
 create mode 100644 testsuite/smokey/rtsignals/Makefile.am
 create mode 100644 testsuite/smokey/rtsignals/rtsignals.c
 create mode 100644 testsuite/smokey/rtsignals/rtsignals_test.c
 create mode 100644 utils/rt_signal_hist/Makefile.am
 create mode 100644 utils/rt_signal_hist/error.h
 create mode 100644 utils/rt_signal_hist/histo.c
 create mode 100644 utils/rt_signal_hist/histo.h
 create mode 100644 utils/rt_signal_hist/result.c
 create mode 100644 utils/rt_signal_hist/result.h
 create mode 100644 utils/rt_signal_hist/rt_signal_hist.c

-- 
2.48.1

