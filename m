Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8F429033
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107716; cv=fail; b=B4I9W5e0kk0oKdP1cWiXJHXrX/8NBHp/BNh+yaVsgw1rKKwRF5CiEDYCpX0d2azpA5etnbTSOPiTOoSMRhuxb+hRZOvmbEoo3n3eh0Qt0C/lk14xOO2Qu3nnmm5YwkEvnRhmDzr4yDfNW/wDceXz0nuLNu9RdH4v1TiIuVK7TtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107716; c=relaxed/simple;
	bh=d1R8TqZxzlUZ5sni8evfdKZDj1nh6bp+fW8eqIxXCX0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rnjXXiEtlGfVasexg2zrHEBQbFbwW3EPVLOMr4z0VrcqQ+uvHQTMZRq0S9EGwKflsXLRwn6c4d1U9gLgpY3b+fhsuCecJ/DwKJV7McCgcx3bL7g/X3xaXPpnWt8gqTYnjZ+9KtjXF6Bu4h0+fmMdn47EtXCeu6OTeOc1RdP5ioY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IVmcmQUD; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IVmcmQUD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXcMmyBzNuvY7irzEBbnDdZvp/a3fhPXV+8Z1OInzG1Jx8kpcutUkZb1qcC1xA7/+FSrh3PdSbvYLPcjGQVu7TXIGERag6FpHviiC+2Fj4/45TOe5PYy/vAc/20rstSP82EatdLC2P6soXj3w9RI3Kp0awA2ebSIZ8kzoCPmSltdtVupPOefdf3ZjN+Uoqr+5V6RG24XVBBeTdWcXtkYMtoQYAZZhqn8XRRkOifPlRQH+t++a1gwrjmkXbF89MDaljMaEuXOOamc9GcFqelIf5PXMUlzVzM5UZN0wE9q0FoVZd6yDq+KSKE8R8f9qDzEmS0kKHfFZGoecF0XkY1HhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjX7ru9ED/JXLPd3heRTm0llUjZDIF6wrPU4oSXpcK8=;
 b=mm8lme3KHokgY90bDzLlVuvDFKmT5ZkUpihbZmy9QWyjDIm0Q6BsbwRGbrc2KNT+6cbxdAfh5KvWcpb1OP9nLA4fmgJllpbytJoke4PI6wSYptlYIdsgjdVzOo/WTUk36Tlr6d10bOzIeOofnx6EDys3kFnNoy9taSu32om0DexiJq76YU9wCf2NKW0uVDlNGLOlbVy4MqvIixeyrrSVBuqJwY3SPNnDicM3+FTO3T5p8NspStIKhaKLc/vp7YsYmWalP34KYUjcF+j61QoDGbbTHbMIMr+e45yKmBDOL3H9+y3yqNuAADaXaQOrOPxO1XjsCG2rxHg5q+ZW1+mOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjX7ru9ED/JXLPd3heRTm0llUjZDIF6wrPU4oSXpcK8=;
 b=IVmcmQUDVHHndsdAOAq5zmOCI0rZG23aUazKmJqu4VQSFqkc3Mnj1Uv1l1hxcYacH8h0uZQsS3yd6y8a6KWi4dlW+FbImCNI87uQxCJxO3nax624xhUwp45yHiytXRw2TQw3AO2F0JXNsFoD24XutcbtTn07DXhuc4qEt8kf67swTfmjLSCDnhJECg+y/kIRoZwaMikzZ4c46eTjGJsQ81rAlJkA8VEap9K/6hSpYPG7Bu3hO+la0a5bOecFUZatajn2dWYB/Ujo6GQDkuD+tvq65O+JwKZsgBdPwHkVwdX905dsryuxk9E8yryUse5d38/hg4M8Hzh1qkyJAwYPmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 09:28:29 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:28:29 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images 0/3] longterm EVL testing under load
Date: Wed, 15 Jul 2026 11:28:19 +0200
Message-ID: <20260715092822.223712-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3745:EE_
X-MS-Office365-Filtering-Correlation-Id: 4981628c-2eec-429a-d7f9-08dee2536e33
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10070799003|55112099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+YIjinYnff4y1lLlVaZKMEsvqxsbH87dn31PI4pi/cFKzjl1T2EtSOBxq/z9pCWEGPTISrOu8g2AtfkXyIQ2CEzLpuWOpPaPXXVnOJBH9EL87CXFTJ0bKltHuQ2hsGItWrdhgqQghWKNUPaIfJaNsfOi38hlXrUicSVYfbYCBPWM+2rs98b3FKjJJ8o/KkEVfpBXLru6J3kLEjTwMaqvTYxNm8SltNmxuO9y6O0hwsMxBW9YPey+zcz2NW2H7THBnMS2T+4n7GQb/gQkBV4PNDelVbK9CXX6HlA32gE/Q1aLi6p9zbNJ0CnmZqKmYf2KzZ5ICVUeAjNx9BHmVQAhIP5IVHphLGhFcrI+ZM9cJvHF7iuriCJ/9YhMj7VYSSf1ETGDkWgQUL2jOg8sHnmk2p9vKHeu1CRzTPGyIjjqm+yJCf8M/f+tDzojAU8edCtgpkSJ/uG4FuVSgZARFDar71DmdvpmwvZPI9GboAYa5hR2P6PrFntjsT/MC2gkRqJnyEQqbK6CavU6mfYbSfK3WoRB7jhhgqluoHU7hhgvyMjLQq/ln7YzB1Lx7I8OmhQAlj2qrOu6kLeW+8tIXxECMZWx8Z9YPXXXkhm3wKqYtZPiwohIyf9hdgBAxYxno3Ykuz+uOUDSLPWKW9MWSKCo9ys2FQUNLtygRb/D83ZpGl4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10070799003)(55112099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ma/xV5ZG+gCYvAVRuD+fLJdEG87me3yNCuPWKJ1xO6Q7O5/9mDTuL1JNJAF4?=
 =?us-ascii?Q?gMOp7V2dH7oMJyrSof5bZyquq2uWn/lUVpoQvL/4/gNxZg34j3T69RqZFIUK?=
 =?us-ascii?Q?Nxp+CrWwnZrJck/3ZfmaN0iyHEeL8i0vySUvgo+iq93O2Xct00pi7fJOYQVq?=
 =?us-ascii?Q?cZGKYIxtc9yWKHiuqSzGEtfUl3WqdozJiC1EGUJHv2ZZJYRge5JRVHPslq4r?=
 =?us-ascii?Q?gvShCRfzAXIsaq0WXhFrioyAFeaf2r+qudoSWpRAnRYMCsXpA3ZNm6zK06YO?=
 =?us-ascii?Q?YODHo4oyM1ViJqyoBPOSx0hEP4a+HVVr7Sa43A5Vqn5zlfP8XuC5JIXkhi7B?=
 =?us-ascii?Q?qW7yhL4+33RyWF4YNGHiYzWiusBzn5EuZnwlYP025RU1oNFjN9+8aZiC9by+?=
 =?us-ascii?Q?pFHK7+N0Be0G79DzfeSZ9tIER+Gdw1fwYUtlDVMziOMshkf+CSrIsXmRgDDg?=
 =?us-ascii?Q?adpylIAQGs3SXNV8FIlW6GMYybPNfqHBu0LTZsqqJbtxEX3mdtVwEfEO7DRr?=
 =?us-ascii?Q?ioxdVoJwM+EJis6lNSQRRIUAIA1AhR7UgDKUCydLeeAL1FVUwXIqiA0HoTDJ?=
 =?us-ascii?Q?iMOLoEhbajxKrKy4bXTYS7buFT0FQ4bPyMxklZo3pEQlhOf9WmSbfrszQLXN?=
 =?us-ascii?Q?slbosUgmtNRA6S8ZmPgUF//jALhzDOc5GfZ3v7i3NcS1wiKt+ykNu+f65QD6?=
 =?us-ascii?Q?H529NOxGK8wYEQRn9pbuJ6tE/8dQQ6An+6LcKrekfNLdYa/5QF31rjHd+b2K?=
 =?us-ascii?Q?styn3FBR7sI+tmTIh+s4NWnAjcQoZ62MsWwfYMyTDS8Rje2KC3DPrmVnVNxV?=
 =?us-ascii?Q?Rv2P2EQuzV8mVgl1BRU0MoIHs0I120L0BdTWH8JdMMS6ORUYfPv+K6NzEoRn?=
 =?us-ascii?Q?wgbMWuCbpkztETaCukJx1we0I0f1D4xcCJWJMY2f2JkMgI+3cYXhNdnSg7Lv?=
 =?us-ascii?Q?0DLTecLDvQCRqeVxGL13UWOmHIdgFdV15+2WoM0J7/yHAPQvcV2j999KHz3c?=
 =?us-ascii?Q?HSr+lhHFWpnCdoow8ugcb4ceKnwDX/Mq84iFzoC9YzlC6D2HLYhfbOXWRcX9?=
 =?us-ascii?Q?0OGV10tVeKsV86gBL7ZoWv+y9oqVuvXQZFpxMDGpj+XIw5VShD6fb+J+KCsc?=
 =?us-ascii?Q?31Itu7+VqFDGIKMBeOnCvjxYvtDc6OWfp5XH3h6EFwIn2xCV1vij77NU7BRp?=
 =?us-ascii?Q?kHDePS9nWBKLq+vP6CW5ujVQd+Fa6rG/+21H2Ms4qfO8aMXTdk6wJ34hfm2i?=
 =?us-ascii?Q?RHRRQZYj7nfYR/Dgjccq5edB3Wl6JwVn78/binXtompDlb444Ms46niaqhMI?=
 =?us-ascii?Q?P0w9OtwbOhFpZ+3J0RY6eN0WLTPsoavlRa4orERU/gebbaG15DCGizlWyYhU?=
 =?us-ascii?Q?q2EFNYjuDQ8oAfFlJOadNLzPYu4EV0O/M8Ybn7g4q2UIPJ7slrICDH/jsbkw?=
 =?us-ascii?Q?PV7dOuwxIyR4grcdyaM+MYrWkOQ8xH725yXPJsQ/DFXK2XZApfglNrnBvb6v?=
 =?us-ascii?Q?q1p5dvA0MG48OUWRuxjapkY3YL7LrbYPqsd0RSk6o7VBy9BM8silaKd6LUA6?=
 =?us-ascii?Q?6IqOZMbmSzmzTGtXyIuZDy9+Qlav0IUI0JtFs6UtW0stHFvAQzI2m9o15kmn?=
 =?us-ascii?Q?78m2URbLZEzlMxYqllFkQAtIM22NUy7mcLH3bIUww6otayXG7rtbBpiLsZAO?=
 =?us-ascii?Q?sCif/8nDXrdZXe95KC4TE2VvynG72H9tfNgzOZkDIBvzQG56QLVoobdmCR8x?=
 =?us-ascii?Q?V/eoSHT1/fTP2Hel9Khw2B/4oH28BYu+4W/rE0ADzO0CMWztBbE4S300n/OF?=
X-MS-Exchange-AntiSpam-MessageData-1: gnKF1XqPZERpwc1ueXRr58Qwx8299rlXixk=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4981628c-2eec-429a-d7f9-08dee2536e33
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:28:29.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ynlbd9lZoRpseRNgLG0gdTFhJLeJ5njcnnUaK3KC1uFABv6tTaugXWO0LR/2yNet/aAYRk3VN8dux71ztFPouTU5XYXC2XyRCtd/McIwsu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3745

Hi all,

This series introduces EVL test runs with additional stress applied via
stress-ng, as well as long-term testing. Along the way, I also updated the
long-term kernel under test from 6.12 to 6.18.

Please note:
 * The clock-timer-periodic test currently fails as soon as stress is
   applied. I proposed "tests: skip clock-timer-periodic on virtual targets"
   to address this.
 * On the Raspberry Pi 4, even the 3-minute test exceeds the latency
   threshold with debugging disabled:
   latency threshold is exceeded (150000 >= 163.951), aborting.
   https://gitlab.com/Xenomai/xenomai-images/-/jobs/15353275174

Best,
Tobias

Tobias Schaffner (3):
  ci: use stress-ng to stress EVL tests
  ci: Update for longterm test runs from 6.12 to 6.18
  ci: add long-term EVL CI test pipeline

 .gitlab-ci.yml                  |  8 +++++
 ci/lib/gitlab-ci-base.yml       |  2 ++
 ci/lib/kernel/6_12.yml          | 45 ++++++++++++++++++++++++++--
 ci/lib/kernel/6_12_physical.yml | 52 ---------------------------------
 ci/lib/kernel/6_18.yml          | 42 ++------------------------
 ci/lib/kernel/6_18_physical.yml | 52 +++++++++++++++++++++++++++++++++
 ci/xenomai_3_next_long_term.yml |  4 +--
 ci/xenomai_4_evl.yml            |  2 +-
 ci/xenomai_4_next.yml           |  2 +-
 ci/xenomai_4_next_long_term.yml | 24 +++++++++++++++
 kas/opt/ci.yaml                 |  1 +
 11 files changed, 136 insertions(+), 98 deletions(-)
 delete mode 100644 ci/lib/kernel/6_12_physical.yml
 create mode 100644 ci/lib/kernel/6_18_physical.yml
 create mode 100644 ci/xenomai_4_next_long_term.yml

-- 
2.43.0

