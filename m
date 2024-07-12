Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F313DDBA
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774363; cv=fail; b=opA+raxJQzZoSz0fNF5XN/PZiNTBOH+0ZsuqZd9THq9hKChqvtMecue1durtRyk6/aJ0WIObmVmCKvbp78qTV/+axENdh8PGf78w5nhygUWIVkt9mtGLRIbZA9/qhqQdE6cOB+ao+M2vmH97tnMX7Ni6BJPRP7TlQmPiPSeDpdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774363; c=relaxed/simple;
	bh=W8mbD5iwGCbby6TGZ64YxDohtPkq8z+r/x9QLsCIDBI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bGbndp+Xdg1efRRusOrRjYpRIqX0yqQdoCq22Lgf0ZJ6YCddcxCHiK8I7IYtY47vCglenlxQQyMZ3FdVIcsteRSUKZtwAkehTm4F0W7o3YwJXIOOLo1Ulp9islCNT1ZAesopkqWSiaIJBYhfEBQLfbUJj/8RbJtLWo6Cm3nPDSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=X3G9HwQy; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="X3G9HwQy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaQBSK55MkFkhGWxxaYQUKUsRrWmVrzFVQwrOsmWuUiFlMYGId6LQVvzNwW1U9LM7jpWh6RxJXy211zBeuPWHgn3ryngBZIKhBLu32+0N4l8x1aFimEamY8B572arJ9zL/tRzLGgwa6pD/Ca4WEErjC0WS6fBXd3SOrM8P6p+nbkVAYq7D50YQQ8wCCVENo0sEp6wFTCWauOXq09svC76/JLhkkXu0iUtaKkcSEflf1Mtz+inf1jOb6c/WSFsF0wlfq6dkJFWRAUGuYYuMBvYIYx7KCU+vRg9C5cRfXj785ehkgkZ15RpZUmuEG+Md9w0AovleneiUdTsSSC5NBkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm07+T+wrt/zeO5cl/axw3cPVyI7tUisyiPiRbxJ3HM=;
 b=P1nu42w4VfsQXXwJ7nYer3tl/gLL4tO7kd9ZFWuyBZyjocft0ufkwkba2syYxvaix/t1zIYZ8YiI3WNHBVHJxC7huutPxji0XXlyP2VYziuJMjGTNuGNa29+oKRxeGkCZH9aRpPrsQrvrRfXI8vVFVshkKqVvvlPItxvJmN5ogNNiPOytpHuZHjw1RhoAD8K/ykArlB9x9pjFCNNGsqQJjqjJ/h/ynsEPRuNeaWt6Rc6ljtUlzkHwBxOMKmGXJZLJE1TVx2fjDk22RxWuMXLwXOaq5hu4wmf8Qf+vtCp6LWOvvMBV26Y2T4xKeCEUd2P0lJWZIqUucn5lAX6cofxyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm07+T+wrt/zeO5cl/axw3cPVyI7tUisyiPiRbxJ3HM=;
 b=X3G9HwQy9I5Y3sAHYFaFKG9/gIU4Xy5T0kp0dFVV8Dcm8JyATGFRT7zBr9yVIKAtK0iYzbfS9Y7uGX4c5p4GwykF9kDVrV2HXfjC5otUHVffG5d3WxJun7p6d+/3lVl1HoJ4d6x3tAKyPi94EbtSgSi+E/76lqBl+Z6CIXtuLVw6K7zG83r7yUPFKju4z42PPvIIqJ0rJkpc9q6fyF2PexFnC/kWnDRe+DH26Sqqs7IxZMDpcWYL2AODNyYxElEMSNT6TojL8y7yOpet5lFr70USpshya75090BwiiVm3aYFFgqXXLAcNVBvE8Fe/d0b+ACFqZLQxHTjQsbF82LeMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PA4PR10MB7940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 08:52:36 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:52:35 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH] [xenomai-images] Ignore name when searching for failures in junit report
Date: Fri, 12 Jul 2024 10:52:32 +0200
Message-Id: <20240712085232.2989424-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PA4PR10MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d30a78-2de9-4e0c-574a-08dca24ff9da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWxH1o3AGmQjzyfboXmK8hTt3F5wdXx24qfCvmySXb2Vb+Oydfbv/tBFCmsT?=
 =?us-ascii?Q?3BbIH0le6py7F4q2BjE/tTllrjWr2UunOYv1fk9L5RF1TDlefogv/0c8+F6l?=
 =?us-ascii?Q?gc+vbiZjvSs40dUWOQPb6D+0COcbGbEuHFo88XqBe7p+GGihDM5rmZ0vW08f?=
 =?us-ascii?Q?hsLuW5VCVzg5BwHghhDfsXUiQZi/ikcmi3/uc+OA6UOiLjVBJ6eWaaAuaNaC?=
 =?us-ascii?Q?2JIIGQiVFWTygempOQnmq2C1AtTr1RAoC3CCTAH6V1bRdSTmQiVu0KSfjDoB?=
 =?us-ascii?Q?8BHCSLm91EjFTmk2Ma2fDksoxWuVIF50DmXFsiczHQHKdwGuWBe5lqQPceln?=
 =?us-ascii?Q?aaaYDzdoDOtmQ43e5FX7DJtzLiyfUjel8C8MtidpVkBvcKdc9f3umn7o8eJc?=
 =?us-ascii?Q?7ou2HaZdaUWOIuFBw0vH19ZfFaiCJ7Nv8HT96HeLr8RLRDC7qYzObB9BaRx+?=
 =?us-ascii?Q?EwmWQNm86C6HA4Nx8XsM2yM9ftreHyyCHRYUnS14jem/TUpjvaeifUb//i28?=
 =?us-ascii?Q?qFydCuD7sCiqYDgu8ltOhzuH5LxqLepnwUxy5KCNTX1JXC7T1eY/i5mKqREb?=
 =?us-ascii?Q?5F+zN1rOCT1lVY+PVmdRMYfXT95b4N5Kca1E/Usmz3scYY8vRo/bTT+cpzNv?=
 =?us-ascii?Q?TxzNS5b/Oa+qgz1FZTZ0CASDfHY954RMW11QFMGKgeKuE48W5ogW0XdpcolF?=
 =?us-ascii?Q?6XaTaNjuMZP+bh0elbCKMs6UEhlXinVFKypxf4OMTxIxmvy6D/shvkYq5YcH?=
 =?us-ascii?Q?VleE2u1FhTnP2yRSWAsybh9W5FoqADbcBVN/uM2eoXLh1lz+9jvx5L55PhVf?=
 =?us-ascii?Q?GLeDAgKeffAT451V7+mTAbFID75XF2+faLac60iGhbuqUmUSOe+KHJNWj8xX?=
 =?us-ascii?Q?MavCMJbJ9DTGYRbR8IsRiX/y7jxItn3nGEKyLHjckAgQHG8QkHhA9a7TvE/Y?=
 =?us-ascii?Q?SJ/N/SiKU8nzc7EIGGgDVourzsVzbTW9ktAdhv/a3meG+ZP9b3SBmhqkbcDd?=
 =?us-ascii?Q?ModzLN4M2V1Z+deOnw9W5gyp+iRtkuOFlV18wUK59JrLscnGcQlvQhwFDINr?=
 =?us-ascii?Q?AkpFZedefI9QT/W2EaT/h/7KqfTlJuifmnLR9F38YkzBlNqWFYEM6Pa3KH9A?=
 =?us-ascii?Q?UUWmNfiZXN6nz6B12HMP84jT5oQoA7GrmoRK3q5twXFUXS2DQgrWBpBibj7K?=
 =?us-ascii?Q?X3hHMYmyqx1rp98lAlvIQroHScwpgjYtCr0NthUEgLTy0cXjw8pmclzb3Lzn?=
 =?us-ascii?Q?9FySTlRZSRq1U8Yrp4lUGxLjNxUsAIgZWIp0Z8Ws1CKEtzFwBOXYZSRmJanP?=
 =?us-ascii?Q?ghD6r783ief/Wo+2OUXvbMZUhoNs/RD39bk9h1r9nxlJXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFNOl7+qxxhKAGO+lFJoh78q2tviX2RlNYF0ONIn6ko9wlJAqbuiz8HBbcTn?=
 =?us-ascii?Q?EwlWmog5EtjMl8UTNkotnJSqJ5JGTr94pcCpbwoElJ0VBQX+vJ3Qk88nvNIQ?=
 =?us-ascii?Q?pB+fksBiqCJm9rRhMK0Q4uBFi1mq361EHMx+wtkbncv4cd8q8pduxY0044dd?=
 =?us-ascii?Q?lMgVWJHH/6jG6zhYpIiOS63oalbb7a8b9KWnBXuoQ9AU0CmNmFJTEsjtTyxR?=
 =?us-ascii?Q?uDZyV+cbv5mmQTtDXc+k7ZaK795EO/VRjeecQlGdFACQyOUUUe1114g88IRF?=
 =?us-ascii?Q?CAZuL8TcBdc7IlJ9bb+qTsy3hL5jMaNWKs9q2MjJbUt+r1XXQ2+sgC8ZYGyX?=
 =?us-ascii?Q?epMvmlbimNH71vtXNdGOXcxHX4UVjahEj+kMUrDs7b1Tmz8DZFfOlCOwsQhx?=
 =?us-ascii?Q?ZgjUwUXQxKjP2m7p2nHNmx837+rdKBvYGsw5Nn6H80+jZSSxeDFl4UORC1Lz?=
 =?us-ascii?Q?AdZXJpMJhhfjZnPvrCDRbkW1Aalw/LJ4Qb+YSHlrdckdr/G3nCWB+7ROns3F?=
 =?us-ascii?Q?K53b0NUUQNFNclwH75+fX75lAmRc8sW144mTEGWDtJpR0/VfTuDVCLNP6i1d?=
 =?us-ascii?Q?WZ9OfVH9tQldfTLZcdcfuB/VgjaVdc/bz5ohicaZigA+Mst4DrWytat76xM0?=
 =?us-ascii?Q?vgDigxrdquW5HmLd4s90p778QSBNzKXtyaVyJoOg3OVJdHzZwrKFcCwbeEHy?=
 =?us-ascii?Q?mYxkpF+ghiiQQJvEBKA2OKbL61nR5OiKBmn47VysUlIRei+lg1AJS073WTJc?=
 =?us-ascii?Q?koE1bcG5P2/4J34IldZkMG83iBBIUDTsMuGrCuW5xaZgBhivcJlD065/Wvd2?=
 =?us-ascii?Q?ZkIfo3LMTXLRVTh5IwtS+T41q8Lzankb3rf/wkZDDMcIq1rzzBxlCIqPoKvw?=
 =?us-ascii?Q?yJAUnoQLjQzjSMDkvwvlgW5jOcB3b35SaEEZF1Xhha4id769tekNUyzv5tYR?=
 =?us-ascii?Q?fx6ZvRx8ytU7W7BnOGwQ+XudwG4dMt5vclfPmv6Vk+gCPXkFWqWK7QZHJCrB?=
 =?us-ascii?Q?Pf4IzyRyIJMjB9qaKelv4k17grFWHkTSfO2PBNgZZ6IZxSlcR3xgYuVgHCqA?=
 =?us-ascii?Q?a+LmC9d2cZCbTAXNKXY3OnuMbiEKFaynuF1eIEjIyG3iVcFwt+KJGn8Xtkva?=
 =?us-ascii?Q?V5PU5Me7vxA94r4HRlN/7cylbemaRA6b/ILocemUz0Bly394ZDIV+OIM0/t+?=
 =?us-ascii?Q?oMM+hxGdA4q5veSrfAswizRMLhsNwjgu21/oEJ4CnHfnSOFsxZ9Ip9fAV1UR?=
 =?us-ascii?Q?5sM1dyJ5zVF0uz7xlonFwmkNK3CHrPK9gImNvBn3EGfnPMsSoFv/dzzIn4jY?=
 =?us-ascii?Q?tcYfoRy5htVzZM1Yz+tuSsUpALzg9v6Hdt457IcyOIIaD3SwuTOmDRn/koBe?=
 =?us-ascii?Q?PTQyL90ihGUXpQUGK2alvzuN0M83h/eq433SLsoTb4EKQZS5hyUfd7QDpPOK?=
 =?us-ascii?Q?rh2dSFV0bClt42a1KX3ibIXbeoFSkZlxrnzmEqqlIsiZKEeaxxkHBZ40nNcz?=
 =?us-ascii?Q?JPfcpAdrn8LzlfwtOhi810D8WNQRIetPkqCvdKvHYh6M/Z8NV9LLa0cl5hAF?=
 =?us-ascii?Q?SEfLaG+Wt90Re0eBhG3lKtLs0DC96ry27OReB3/AokMVn3ssPqDgoByZF3Jd?=
 =?us-ascii?Q?Uj4avbOrFYSEher0U8fZGfeQEgitLDTZtTr2xDcBgPLQAGnRZj0vD0MyBXV1?=
 =?us-ascii?Q?/Ga5AA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d30a78-2de9-4e0c-574a-08dca24ff9da
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:52:35.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zodgm6fpVnoYH6jz+/0e7BYo9fnqgkNFLumpIunxhtO+5O7MGzSFpTgouE0MljIVAwEtRHeJASZ9N6vUYZ6u/VE4YUL9ujI+ogev+QhhqNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7940

We only search for failed test-cases that have the name job. This is not
correct. E.g. the xeno-test result will have the name "xeno-test".

Fail if there is any failed testcase found in the junit xml report.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 scripts/run-lava-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 97061cd..2bfaa5d 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -64,6 +64,6 @@ url="${api}/${auth}"
 curl --silent "${url}" -o report.xml
 
 # change return code to generate a error in gitlab-ci if a test is failed
-if xmlstarlet sel -t  -v "/testsuites/testsuite/testcase[@name='job']/failure/@type" report.xml; then
+if xmlstarlet sel -t  -v "/testsuites/testsuite/testcase/failure/@type" report.xml; then
 	exit 1
 fi
-- 
2.40.1

