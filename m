Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91433D1ABD
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081781; cv=fail; b=dUosQgrnXfPvdR3ZHu3oAWBljwIRsQnbuTxTGKilDAw59Spk2q17rpUtDh+mvbB5w4gs8au3dNF9+wIqnZVQYZX2FUQkMywKujO5gEaYtwERzJ4Suu6F/VL6F5sSyNbTMuZ22TDJnx0Nu8MasONkpUj4KLbyt+5Hup79t/OOd00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081781; c=relaxed/simple;
	bh=Kjekokm1mJVS7LHfDxSjZTNtyk9fvMhC0NHcnSWzshI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gbly36WeVz/tsaljvU6+PnEUVOMGCquck54QRKhc+0PQ3CeiPLVby7lh/t8gLIZ6H/pcz9rmUwZw5vSjk7Tf9l//gxeeIOiJJhBEotAtnpHYIgI6QN0Bg0fTiPsQT9NEPCuyGrXuOM2cozJ254q/4p9KvCH5HP33KPcsGAi7kl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=h2uO+dbg; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="h2uO+dbg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK54lseW76sg7RbAlyyNy/iTJHSFsVQM9r5EosFVYmhl09Iv7x/NFCerX7ux0THu/dFdSpKUPvvHokrxalEc/4BxuxRoOCvghvLSQ1nmDAakoMy15XviwntCqrmN9sbIOBQXpnRSREX9WDgU1guAVlY0ZOkSB7qKGz0OHI+fXP+uwZ1TcvT82iuUJAunMeKO7bzoUcvqB0380zjP2S31ze9rfHaX6wNM5P9zLVHUPKsrU8ofygyLvZhjdl3JqTat33VrltTF9pIlQDs0/9eYp91PRH48usI8t7p5CqNNAeToBrSWdyGUwFZewzgZFec6dsj6KRYa8mADRWNHb/mq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DBrU1zAYMOyyqEvWlJ2huw2KBVKOxckUyKaZQE/4lU=;
 b=yYNOi4DUPegZl8Zcr7LhbW/sPfEIJeQO4FP8J6bG3O/NGHcgczmfdNF5bDlJtfQDCSozVxjEXkVhbieWUUwd8OR0MCjvkR3WwZL4ErfH84NptbZlO7y7yobjjBbDyJL9EW0ytBPs1oCAGcv8qn7NEwEuj4UsS7UrWrK6FZl+iTdrt7pz7fVuOiw34MjHxq9LabUPETZUV/JWNNPEDK3sTeIz2WIH9l6ccKkms8xCjnDPZUs2ZjyTpOfUNLk6xZsPWcB/uyMTGYC5NYn7xEr0W+nLfNBw6bRJ6STrA/Rppm3oOZ/4N/7xljqwOCWTHGhmxzo6ZknjhItH8YYr+DxeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DBrU1zAYMOyyqEvWlJ2huw2KBVKOxckUyKaZQE/4lU=;
 b=h2uO+dbgTIDz7zmTmIH2T7wnrdRl1XC/Qi3vdtXzR50l7SvRueXoKHUvJGxcZ3K/hKMhwHtrmvtoT3HK8DTTLLvZaYNQsh/llzgATARehYteDiXZcAGtqDUfAXRVSBjHC2ZvjQR5a3aaskhGWsCAQHtmVPrEQQcYliPFzRYzTijEFViUzhJa84LpFSpDO0a6weTJZoaSSv3A1Z9zc0KNFCMD6zHypfnzd9udnoWfB72J4j4wRWzK1HO+sELhhASB9WPc1185pzvbRnV3yCdV80sPWwBxn9mm7hHwxQ/0JgQfLu64vTdgZhD9q6VqNB/SqP7MV9AEaeHteLeH5f1xNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB6032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Fri, 3 Jul
 2026 12:29:33 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 12:29:33 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl 0/4] evl-test: stress load and latmus integration
Date: Fri,  3 Jul 2026 14:29:20 +0200
Message-ID: <20260703122924.30212-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: a3eb952a-27f1-4c3b-c7b3-08ded8febcee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|366016|376014|56012099006|55112099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	jIlqDtoNChhzEjw0PFZTu3lKaRODaI4qgty9ibCSbavPHM59PngT/qePHAVvuTJc3S+zaaw05o/Ul0msdTxcwzDbWb+chp3SbmPVZMD/6JZ67u349ysxXqSXRqes6FqCCqqYuVloTuzh5SzzKS+7rPbKAt4PeIYNc/c2blEeutU71DSIXxUQbr9LxGS2BeHSY+16OHKZYf1HLT2Gjr2xZ/AL3WIXEcgSA5UqGk02+44pVx6NrN8BfXlNXg6LDnzJPZospKkb38qo1itcYOMJO7ZyN1zMoiH9aATeLzidKBd5S3rjXNiM2/3X4ozVVotabLZIxMpTYYmq8nhh+QPZf+7oWUs0I/ezMkpKNQ62q6IWft9yNwwmGGGIV14eK2TayDpqg/N49MwEvf9QiKO2jkyTRWxVvBMnfEWcMjuu0/Rik+Y/7ZAUomYZPfJyA8bt/VCArG3fLxNb5FAqMz4Zfr8KVzgUdRyuv9bE1TPXa0zMP6wdYEKqYLmnbFlthSH+TDrH4crLIG2R5dYHPekG1ke7FjjirOpB/IM9UBVJcRdEp26dcdfaLm6xUFJzOCuZmNQjGh6ymKeHcX7eF4uccI7jkyh9v/dHOKYqi2BMEWZGrA18NiS2+taVoLtxyoaz8hZwdCkaMxLK1ZXi2moNxqhiJ/teOv9bgab+yxZG8HU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(366016)(376014)(56012099006)(55112099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B15BlUger+QfQQbo3KR3uTcNtGAXzYp83POyST1cjvuKn/BmIi2VwEyHchto?=
 =?us-ascii?Q?WvYeCc6pkdKqSrGSo+JVmsTtywdtTpeEcVxdZhaVOIjj45h6L6iFzHznP9CV?=
 =?us-ascii?Q?n0O6VonwD8ixxSXFj3yRNjsQadstltwU3/Af23eHtyX3CcIJ9teIhpmg8Ves?=
 =?us-ascii?Q?BPKUf64z5El2cSKlYm5p5OCk2RYjgnfaO0xY75NEviQDGTbmMhbGkYxEcxxv?=
 =?us-ascii?Q?8UMDMQXMlz+smB2gbDB060JwFa51qyESOOyA+p2ZqjoeuaNBHQtnYwO7A53e?=
 =?us-ascii?Q?4Sg/T2YVtTL7rUu3HLDRsp97bwyt4RcPk2MzsUugt1nMoRQbW/SRUvJJB6Z8?=
 =?us-ascii?Q?rj6PGYYlbg1ceIhYR9+oS5xupERd5DySVPxZCSUrMMYRHWaXwy7FaF5FrLaF?=
 =?us-ascii?Q?KcngxIt1r15o3A0STSJAGHdPFs9PFzyhukH1vyfW0XUFLZWzNvNdoEYDXz3I?=
 =?us-ascii?Q?YmY4i5eFckdJ3PTWM+07nYxvVt8CGAXwBw+biSYVNdRDQHxzUlSHvDn24wLM?=
 =?us-ascii?Q?GqkrFyPDC43/p1jRr182R5MAIFfXD35jWQr6g2XnNsAaFLCnN+JtIkRJXWkI?=
 =?us-ascii?Q?gf8jPXNZPK35sg+vTTAlMg33rLncA/zq5hA4XIl/uRj5/K9bB2Ey8ymIIcVR?=
 =?us-ascii?Q?fAq5hvmF4Cz8syCFxha3aejEByl6ahtTqVRUevniYJKeUXWAY7w8vJm+/27K?=
 =?us-ascii?Q?s50e79utMQi92i8XXLjSZk5YFiHJhWr0BxBU3gbYpuPepCtDpCtR8ZPpcPXb?=
 =?us-ascii?Q?jAM0q9p1MtUjBZE89qjfkg4+wY0x4dwf+aw1k1Ub24goR+Vv6SbZVz3nAFH2?=
 =?us-ascii?Q?acUpjB7CS/ReE+GAGVEpdv8syBpQzqLTA0HPkgEgNo+lOzEP5BfYWStEZjg8?=
 =?us-ascii?Q?EpM71uv5b14naMtFdCqMAe9bodxboShKux6+DfF0A0L/W5tNXw8GwIabTxjU?=
 =?us-ascii?Q?C52/vKPA7swPac0QB08kEfMRmlD/ME4YzfiruUd0i5zv6Em2+Rxs9Zf+JUr2?=
 =?us-ascii?Q?hFd2dkf6IlnH8xDmGrIorD8j5qh0/UVzYn+jUySx6rcDa2AsNbdXcRJIpsqr?=
 =?us-ascii?Q?Q6qa8QzqxUMdrytJS+k72Rb9tJ84VWtkebU93OI0b64knQDXdqTkkXaG9En9?=
 =?us-ascii?Q?tT00o8havEGSofSRafsqDGNmMQwJSRnamuR9sdASahUjbfO2Vw3q7C2k9bzo?=
 =?us-ascii?Q?OrFMPdDLRw9CAyWYlFW+4GWBVRu5LyGY2j/DdA2BePDhQ2BDcGqfuff7Bftq?=
 =?us-ascii?Q?4iYpLhghjeg8gZ+SUIeaUHTqxUotooludbOuJQplnNyUO3YGsa4kJeKg1qpE?=
 =?us-ascii?Q?WDkFiQ+pZS+fVqxwbEulttcrgVwmlx8ta0LQIZH87OZFkEfmOlcmbhaAmCSN?=
 =?us-ascii?Q?prIIW2fqEHikxJGH3UHz6Rs2k8lhewCczLOykwa12lQ/xOenHycabA62LLzO?=
 =?us-ascii?Q?WByoRoFGdrh2GcG8yOqEU77G52MPzxCAiBcITUfMjA+AOgRz+XSEXyBy1XVq?=
 =?us-ascii?Q?dubBLsigxvGQlxokuv2OGrOeX/Ql9VI5uR7rlqDoF/MUlR044CmkmpAA9EdC?=
 =?us-ascii?Q?et8WCY/lV/Gveb/6cfJKonJ3LNT4yYfFAPGFU4tlL6lvG0CDd7Oka80cgqsK?=
 =?us-ascii?Q?s2OEVRj17VUGBFkBRWqHFIrJJ/rfCf0L7aDlGd+uarTuNDoWf8L//q7zB16o?=
 =?us-ascii?Q?I9OwAqrt9gmK+o6G/Tp0noeLXtdMCHMe2OG3JSMC0oQkpjdiOXmOfZDkI/eB?=
 =?us-ascii?Q?ZB04NC/GzTfN9XO8mIGVOCB41PLjYuTahh+0BavKCFgBC2WFVhOHDMd6grTO?=
X-MS-Exchange-AntiSpam-MessageData-1: nD2qch0AvYhsEJ2xUBvC350mBGP+0bcYGEA=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eb952a-27f1-4c3b-c7b3-08ded8febcee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:29:33.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y2iWBa0zglDLvEt8WtSMuH/r4+iF14SjLpLU6vLpEKEpWgFXNHCbgLIFy5fbGkaM4XBfFDF3Wl9n1fcQ2Ccn6Gy/OGH22buzOsyjCf9ftM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6032

Extend evl-test to exercise the system while the tests run and to
measure latency at the end of a session.

The motivation is to allow running the suite under stress in CI to
surface bugs that only show up under load.
latmus run under that same load and with a latency threshold will allow
the pipeline to spot latency regressions.

Example:

  # run the suite under CPU/memory stress, fail above 200us,
  # keep the latmus report
  evl test --stress-cmd "stress-ng --cpu 4 --vm 2 --vm-bytes 1G" \
           --latmus-args "-T 60 -A 200" --latmus-out /tmp/latmus.log

Tobias Schaffner (4):
  evl-test: add stress command support for background load testing
  evl-test: run latmus in the end of the test suite
  evl-test: improve help message with detailed usage information
  latmus: send setup messages to stdout instead of stderr

 latmus/latmus.c |   4 +-
 utils/evl-test  | 100 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 5 deletions(-)

-- 
2.43.0

