Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C40340280
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459328; cv=fail; b=oH6vo/hCNMNuVVP+FXY3C3M+iFcK0pjWgVzGlYdpN/YfMLYBPKA6yLSOZXkrOCAamIPAi4FXBD3Bn5MhiwCK6+IjY+lHElTjnMNgLupRMR/HhuHt7DfsahAsHiGOtNx5kxxSPpHyPgG3hoQfHLYzwqIbfpda8k3T1efFZDAfkYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459328; c=relaxed/simple;
	bh=EAbh41qaVgm0K3jNVwfeRZZskXSnmLRuCpTCss9a9vM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SA+MvKQPkX/D9kkgbNM4WJsa/Ve9QGifoYfKIwhClEtloPZ1xvexh2E4U/Hvw+ywvo2gPwzYTZh1cTu5OWrsb9dxod8YtDVa9Xv5cmBfv3D4pY/3HKX7cjBLUhj7i+ggo2jRnLxrkzLxd+N4wTjY4249ZI4Vz5mcDvmgUUdzO2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=V6SKHwxI; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="V6SKHwxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h//H3sa8+GNCh9u+iybQCHrHJ6bEETV6zIFyASVakkRbWtbomuNe6BS+GmtMuHInQMaW/OIJXMaA3US/NYH4aDAqtkuCdzERDhf6U18SPcDRkGu2DeTXOMFp5hjuEl3c+F+w0lcXcJaLrmrQ7lcnW0Qb68NlNQMW92Ar4+ibMvwcAzQhvP1kkXNuq2+uQPEz9j/eM8YIIIOipdnknr52fxutxlz/WBLJcnAwwdEPMI+DpDtcDE2wkCGsGGeCYwelRGJnNDWECXNestGOBfhH+MVcss8qJ7c+AEa68A9F+Kes2PbZKxS0Zotu6Od8jj34D5/+WHMAe7QuiRGLBmJdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKzj9bsMGeR2+Fz5RLtvZk+NopXEGXRILVDXVmwdsNg=;
 b=xPCKXN7cLzDxKhk7CeASzrRsuoMkeVVfZfQ1fblDbC44eiUZOKvYW0S/bDgudA5NHw44oMTQg9XgfgZCDU5FK8GFgNYgNBsE1VsVTY5DSzUaSmncuNuGZQ/UbS8dTN7WvJr07zeh7BjjJyi3A9sgOEDDaH0zNYM4ndPKDZ+sZXOQxG/btLCJWdfDGmYi7O8+ykQ57d3Ey/9D3uuMl25LTd13aPiKbtQRQCnuwpipDVQohBCaLfvMkim6vJlmwDRCvnzuMeEJmYwP6dCKX7tBML5F6QfIQJsUKJU4Gfmjxtu0JpTRNy2Fc/OAr9eaoNik+M+VtoSHfAK9WUFKtv/0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKzj9bsMGeR2+Fz5RLtvZk+NopXEGXRILVDXVmwdsNg=;
 b=V6SKHwxINH9HtMuktNbKBSeU0wIr8EmWjxflo9MKIJ0JpzzCiKpu63GpZyEcqpotHvlTc2MAy2Y+SCT8xCVV51xS+V+IisxVgAJ3PqMaynXHiYDbLP/j8KvKEHn6H+hW/+oG13gIOB+V+hDHUhDryGycqmwF+7N3g8Evn2f4/zECBEumC1Kjo5zDJzChKlrcoBa17yE7lsQmJOC1HPDdkH0PAlN9et33882aB1PWZVqjTQD4QbYkvGtyx1uh5jxvU5Js1rvix7qVF26TbwDyPG6rqK469osI15yb3waYZV2Hp99X6OP/3U4E5yqvs6dQkVIUzRUUngvqnJmTBHZJFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:55:23 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:55:23 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] ci: Disable evl monitor-event-untrack test on qemu targets
Date: Fri, 17 Apr 2026 22:55:15 +0200
Message-ID: <20260417205515.2288339-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 2744628d-06a1-4310-b35d-08de9cc3a4e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	iMcRLgJ5ooBkq/Uvddg4UTKcrGX1fkiSS6xfhK1d6JnirG8TfAFiV6WQV8219zDnBXE1YAu0oc4gHGT7SymMhZV3TXM+efMFlDwD+N4gklUh3THkz5LtCyjgAH2zv4OWFUqNDf7kl/rUbeYmp4BsOCYF69b2DZH5z494d3lEG5jObJaDsNMp6Q1zWqssr06aKnyP+si3WanDRfC+WqKeMRuOrsJaqUkM9EteJj5PxTDwKf+Nfcd5jjZwtn5jftqTm6D6eXuVrXWKYH03+3oQIeW164LSsYdv+6IFXuqsbvVd8R7QTUExEjnjBxZofQmVKMNuXduz1UJwXnhUxGT5PpH5qeQZ5+86EKhwE/Uqq3lODsE5Wq3h6S2I2KOrGXrX1GGrRr70FtVNRoFaLO5u6Wj/Pf2Llrm6dvkavvIapThzvxUpUv4Uqd0awdLTHHn12kAObbu/A0U+VB4lRsj+cxtC9piOFSn2gUrlO53w/tlaOivWMNcJJcAsYd57yt/akK4IrDabZqpzyqLzt+2UWT1hZeqWaI6drRGnZq6AXEOCvavAKEbb2cx/cJAdSAq8m9Jc46YH/yiGWycBnbU5astPY01PfWW1XqiYg9WmU5wyLq5b4KNjwGHBehGyR/eSSkF79kfJBX+82Mr74SZbZtQyvXOMdMjGQ0oy+Te6L7qGcyYVr0+6MQck9Tvxf5xgl1J8d/0sA18qqarMEBCdWswFAvCQV3rh02htxNNjTdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1RdnM/uMKG/C/qEzE6opNbU0Y2wd2FEiBV/0L1HJe6SBy5CaE93f/9V+pPZ5?=
 =?us-ascii?Q?l995fP2j/qgBXL1DCDRav06Vpc3Ra8Ph7Q9lBhiS+FhKHv8e7/25y1EslHYG?=
 =?us-ascii?Q?qtzPfrUgJ8g+nhmie0fi2Iir11Acfgc4koAw2UeLizw6/x6BV0Ginh7lz9aZ?=
 =?us-ascii?Q?LLbJiY+d70EEVjwqTAeP7TddWXQ1ynIl4ZHTzabOxym1f9ibljvnNMZ17PED?=
 =?us-ascii?Q?4gAwDzHJhDQ+lj8fPWKJOYFi58lrnOVRHiCoSzks5C7rw4QFlqBbw3YIhrPP?=
 =?us-ascii?Q?caLDN3IPGrZCL+AW/f1P8jF74FMXOXaNlDOopr2Dx/KeVZDpjLWpr3SqOhOL?=
 =?us-ascii?Q?LsojrLF+Y9KwkPYD/ozuIEk48/vZLpaAYOAX72eJLscI3HHiiqdpqFYjdgD1?=
 =?us-ascii?Q?Zsv25LavoTPRDEQZkFd4OI3vGmuL4VXJp5yqzuYDCcw7EuU8kNtcAiLgcy7c?=
 =?us-ascii?Q?m7CY6FixqlBWNYUjZlPvc7EoxS+jHul5WkPKt71yzjgfw4YVwCBESbdB7s1R?=
 =?us-ascii?Q?IE7oUh0kdk7OHf5Fn1/FmJpeSkM5gbqPaPVZLRyU6NAJnBQnbowbLKhS2g2w?=
 =?us-ascii?Q?vj5v2kQaGuLNrAKO4XCoNTb0vG0BtGKAdoZZvg0LUdiSwTCF7b1D2/xsd+jd?=
 =?us-ascii?Q?DhDkwDnSuZ2Q79YMXAVUY6ryADvPTcwe41EKJW3/fF1kKlIC1XilKYiLsRjV?=
 =?us-ascii?Q?kPtQI0iAIbR4lIWVbmncF2DR+DqIyobhbHYeyx7e2H4xcAbCr+PW04Zuj2+x?=
 =?us-ascii?Q?SGDoSrurVrIFAdwZyDpTfa6HAJyNehZC9YgbkP8NS7hgUvTPcLl+kvmBI1mC?=
 =?us-ascii?Q?t0IqWZjQ1BQ9i/+VWp3Zouxv1SfeD8AwIT25ZYnP27DpFSbOrWk1gDY9LkbL?=
 =?us-ascii?Q?xsvFXTKQ/3Wk49WdxA5HqoASWYy0CfdW6jpmCPaPgKVabNRSPFoRIphxUjEM?=
 =?us-ascii?Q?hS+H16j4FpqGsXbXJkyJKH8NWO7nI7+8CRNb6nShbjsxHVJ4FVC/nCy5n+VC?=
 =?us-ascii?Q?BGAa1jorwmJH6NoDlPQMtR0PM6TYM0ZafF2mSgK0pqRSTpqKwNY7et3o8E4P?=
 =?us-ascii?Q?RI+/NgBbq2zehd7X35yTeJjowk8y6QiKVekj6SHFpw36upedWnI1JfZL+a4J?=
 =?us-ascii?Q?ys1lzEjYRhZY/kelhHrH9/K5MzuPdh5f6MoRzGVOfukVAI0eiGRcq7S2I0Cu?=
 =?us-ascii?Q?uuFGf3yGclYs6O+rxykxXPwSnT0P5nAozjPv0Lxh5nrBQG21UHVzRFfuzvfS?=
 =?us-ascii?Q?zAJxhCADHMiCXwOq+z62yEhha++MtpKpqMu6c10b7MgBt/BY5BPmmPijRvjQ?=
 =?us-ascii?Q?ThurLKswRhRqdZ1dsVr+qDq9g6VrQr1ET012akBKyim0ITwL7tAZVaJF6TNI?=
 =?us-ascii?Q?Brql8TB2s0g20GcxI1IcgLgeZ4zD+uat+xcFhD9QWmFZV+rnQtYUhHBqL5ov?=
 =?us-ascii?Q?hVR+pk7wfM1n0clbVsW97K7Prj2N1CfI0v0cFcr3RzIjR+3TiKqlwmEf0f3w?=
 =?us-ascii?Q?8EdZXtpYrf05+qauTM1dMqqf31UWmlA1i9sk1jkq3msmkc6cO6ReykEn97xK?=
 =?us-ascii?Q?GYEGy4dkY+fOdfpDZe+Qd6uhQexBMlejLcg+qdUY1FnS0kVSVbn1zvqoNEBI?=
 =?us-ascii?Q?tA0DLdYxU5iQufAheVzDE7X37fSlJryv1NU7ImyKBl7bs9THvwURbCxovYUa?=
 =?us-ascii?Q?DZeRxnATXRKi9Nl2nAorBqBTKy7aHnxRZ9Ne31xjOd5nPzuR7giiAMdwkYas?=
 =?us-ascii?Q?ps2q3s0SiJLWMlwUJITpkOrfHcxBo5U=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2744628d-06a1-4310-b35d-08de9cc3a4e1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:55:23.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pThjO2KJkdd1GGbBnDsT4zyvahfq61g5RzTbcqVec7xHKrAhKZ4XEoYSPmfQoDYJJz4zbTca0zFMK+i8QQlu5NkjZHaK7RMADa+nnftdAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

The test is time sensitive and flaky on virtual targets.

Disable it until we have a proper way to relax the tests on
virtual targets as we do for xenomai 3.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index 76e38e6..d815474 100644
--- a/ci/lib/gitlab-ci-base.yml
+++ b/ci/lib/gitlab-ci-base.yml
@@ -114,7 +114,7 @@ default:
   variables:
     ADDITIONAL_XENO_TEST_ARGS: "--vm"
     ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
-    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun"
+    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
   rules:
     - if: '$LAVA_TESTS_ENABLED != "true"'
       when: never
-- 
2.43.0

