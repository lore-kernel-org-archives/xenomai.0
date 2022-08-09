Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CAF4428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHs7pzCPpuargkxe8CNikpwK/t+sc0rPH8AJQ7XJ9ED5lrDNtmKE6TD6n8c3dBdOjeNROCCD/9LOKxhNeDcJr2DXmuU9YE/3v/gEWHw2tdBQVzt+GJMQf8FbG5S4UFD2MdeCaLiDViBvR6fcJTZutvw0oVTgV1RFXUJHvsOML3SaCHo4aeKjyaqKXvDjOk/aAFY/dwkgY4VmtZwHlxJHNONiKR8vlPGG5QCOY7caFwQm/+OylgCn93y/3LcTpb8GXokwvRVpKbGNHdMuS4yYqOeTAV4sIMAA1qPqKfFgvhsLQGKz4UCqy2wcgDSRWuU5OS4K1S6T6fJQvtdBkp/Epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av/7iDCCEaLH76nye62FdtauuSpiGPC3oMKI3JeJ/1k=;
 b=gyGsEdjbf+btndlQ+4WJeIU9Qppvm8cKJ+09Qm7D1i+YJ2KYn77Ex9JIWMnY4smtjPYupyuXf0x1StcfcMhRF9AbhYBkbjGV0BIhm8R4xYNA049vQB97a7gngtXDmKJmRZN/WcfAL18q8uWYZO+5a3APmLcQkhZfPHMDlDS7MM9oMD8cq70on9R9OaYynTUur8Yws1EWvIJ1Z8ipXEFkCq5Z8pbXXB0opqY0McHPzIK+gw5cOep94AAnxWz4ORl8rxTixIQLuiQS+RjVbGDhTxoX8wBprLn5Hg9dqZf8YTwMRCvqDoiCleEm2klNgS5q9F+8MRr4Jj8HM8UHz8qdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av/7iDCCEaLH76nye62FdtauuSpiGPC3oMKI3JeJ/1k=;
 b=NgJybFFjPA4JwhzcYiMGEoArlNqK5xMTtwPa3/2GFibTRQZ53v5wc+E992detYXC86xFw9tj9VZhLk1+mdiTWLggnmJKwdD44il0mGQ/wD3QU0hgmX5FK6NKLZ9hE0vk8TOEXwLvx9zTMmcGt3bM510HKcuzewBQsz23SXnf9ItbM4EG27FH6GvTSeBHXC0lf0moj5L9qWiNuwyZOuN45EOV4BDY91K8pACtNLWNktJW9YSMj7gal4FqUVPpIgIOyIlkGhXcHRh6+gs23EQiPZSCr7/fsJ5XWDNlltTW3TrzvJJF/PWqc6EJKrw7jUJmFjJPnEsZ2n4osJBZaArO1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:49 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:49 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 30/42] y2038: testsuite/smokey/y2038: Adding tests for timerfd_settime
Date: Tue,  9 Aug 2022 15:43:14 +0200
Message-Id: <20220809134326.23688-31-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea67659-5c98-4cb5-0461-08da7a0d423d
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MDCIgDiCR/p2CP5yOHf/a8j7X3jSmkL9ttOjP8erXXPxbev2pK2KaWViTT/vqFfEeBY4Ak2nK8wT+akq+plxC3JnaXuIRo6XMPdrHXf7Oout1CX+gSvVrUEDHeakPh/uG66pjFDDVsVJLQfCNIEcGr0uGPb+dyMjm8U5StWoVremsX1rp+HPl0M5LkmD4zJXYSEvGvAFHXWd6KCdyZH2g1eRzMKsKBTJITyh829C2FvvXaUmGxx/Lh8wssC/xsiLuIxlv10TR281uqCebEsCmvwZkpOBrCAudnBFj6HrlBcQ5X7EZAj5ZSXIYSiyHo2DnHc7SX4jjNuAHrcVHgmg+BR/Ms2jM4t7q7EVC7WJXTpLvSv0F/ggguFrIU4S/DZpBubruyjcpp5/oy/8N/DuRoe/ZP5Rp0RVOsT099HleMImNzzheHXG/HIJUOjVAdxlVyaUBttFSQ4B5SUvz/qp152meuLSJq2LASaa9+6dSwDk3ZSi8CyuhiA40dFGw4QJXwRQaQ6eRRVFWOfeP58ZUSG+16MySn7dKVcrgkMrJa4YzqGg6JWn+hWmTyJEcr9Zk8G09HGKjdQM6s8JwF7yI33s9X5hs4RdW2xlrn1FFjooFvWFX/FvYzk/yFR2ilA8/uN/gQ3I2Fq0PxYUkH2sqn9m5DZ6bafmO7Ui1XeabBSvbK5dEMYMaF6t9zuYN6nn+IgBgcX1d/m/SqxoODdRqpea2ynGIrPXAPMClDV4QPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOLDV4C1H5mv+dbny2hxY1qA3VjJ2AYCZUPW6CBqrpWcvzH61lsgKRyX3Gd0?=
 =?us-ascii?Q?835cx9kEf5Zsh4J3WcTcajPRQ//l6u8Jgt9bs4c3Di4PDDd/CAUG1v7qiHD4?=
 =?us-ascii?Q?+U98eKppFOHQD49A0ehZAwY9wM2uxTnqVSfIsiI1t+bfxJXEQdfv1Q/s6Ury?=
 =?us-ascii?Q?rjLn0g40J1jpAljuEwMKBIP8N/RmWOgZy0+btnVX+fzOTvPrSh1+17sMpnwQ?=
 =?us-ascii?Q?QCgNYb87ucmWRwyr951mKnFzVAXl8Ek82QjeHCRjPr3cvmz4gbBgaAhBA1jI?=
 =?us-ascii?Q?wXqvPI1kvLd5rZwPNLEADbMsV1rCHkyPCO6QxUJfGlrBiqd/Ux/C41E2e5Wt?=
 =?us-ascii?Q?IFVobB7CpgNmfgGGVPcBjuSbUsjInCLytOMUtshzn9wUweepTYgm/NRvQ2+y?=
 =?us-ascii?Q?dkvBz3R9qZA/zXoYHOKcgr0QRXl0t8rCVkXXwTSxfOsJhv3TtHjhpJBVmxc+?=
 =?us-ascii?Q?T8JoObPjAtHR72C2aINJy7e7AGy5+ILlioUplH30PB+hLXztan1ruAMUqziN?=
 =?us-ascii?Q?U78+3ag4ccwsU0ZcgitkD6wHdYwg6xFFZENhF97z3MIcFL98pNg3+OzLZQNs?=
 =?us-ascii?Q?GkQBOVLT2nomPYfMowDQf2guD2XiCp/fCY1f7mH7yF2sEpn6S4R7rZMUtFZT?=
 =?us-ascii?Q?MyGDY8imc3g4S2e/UhtYW6n986C5bwdlqgUjSI5N+EFydtDXeCbL29VBUB1I?=
 =?us-ascii?Q?OLHAJOu6JuH3Fuj+UuD9udoTAkVRdyfMrRguUXxFOeLv6+kpm4SRwj2gI1v3?=
 =?us-ascii?Q?YdNXFXNWqz0vPEjwK29uNqVR6iciCkyTgpOARqEn7ovd2ymQfyoB6+7vmMFk?=
 =?us-ascii?Q?uI343ireEovVxczDVsmcLki4z/hVJ9NOd+GPMFkwwxrzcdSbD+yBLJ7KMYwU?=
 =?us-ascii?Q?UsUjBXONNr2OFKrgo3Goqyd8V/EoctDiUs74sIQPFN0PSP6N347KUDbsZF1g?=
 =?us-ascii?Q?oYB2bHX0HaLB4XleVQmJMW9OC+YaOkm02WVIiqfkn5zYxQSOSUqWxKLjnItK?=
 =?us-ascii?Q?ZyJkNQF0wJpRH0qARWJfn9HWuQQqF7/ZEEEPJ0NkiW3WeDFht3M7pRacRzsm?=
 =?us-ascii?Q?qAJ2RjBdCqhocryi+gOzJVOyAtCBY87wkCV/p04zol9VTH+EKjnQrDAmyefe?=
 =?us-ascii?Q?BGQBQyumZCdpOr0J5tIbRVmovRFsdBQHTKjkMNlxB2n29U1w79IxJcbxyXtZ?=
 =?us-ascii?Q?agxc7HiYMmkCH/dJaFzdMb+hMsoBbb6H+nTDlfBJyACnNLIxOcsXEdQkK2kd?=
 =?us-ascii?Q?oS3Vs7P+aWH8iRRDXpi3vVMDRoNPQ2VVlsYGTiE6hYiuf4p7laSRSw9AsdyN?=
 =?us-ascii?Q?T5BuDTpGchnhwuulE1Q1aEXGmFafA8hfDU71SsQD26IvQ14WbJ1HJ3h509QU?=
 =?us-ascii?Q?60RZ1EoTyOd8lZRgQG+lWfMyUFCK9xYBsTTQVaH1vjv9gLTqJi/KkH3rnomJ?=
 =?us-ascii?Q?bWVO9pRtTDlhYHszfrBZXHYWfAgjqmGcYc/IEpQj1Za+V35pS73UtGXofzbG?=
 =?us-ascii?Q?YNwzaa9BKUPoNjuRJf7EACSfLW5lJeEiM81dJdkEJkxlh6hCgMXgTAuaPRzm?=
 =?us-ascii?Q?y2UmYhTPR+w4aG4s2eS2+YdC5aZtWfYxc0zD9mpHSSsJERGQ7Z1ZFXK5elG2?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea67659-5c98-4cb5-0461-08da7a0d423d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:19.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/gmB4jUw/rnKVLfDbwabMzhrgCKfGXz/vJStpkBLLt63wBuYFNkJNoqAF8bmCxFNrHAmDHNxzsbhqqdDmC+gQkAeTmEnnUNPuI9Oldin64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

Extending the smokey testsuite to do some tests for the recently added
timerfd_settime syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index b2cb9da61..371c3a79a 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -11,6 +11,7 @@
  */
 #include <asm/xenomai/syscall.h>
 #include <smokey/smokey.h>
+#include <sys/timerfd.h>
 #include <sys/utsname.h>
 #include <mqueue.h>
 #include <rtdm/ipc.h>
@@ -1339,6 +1340,63 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_timerfd_settime64(void)
+{
+	long sc_nr = sc_cobalt_timerfd_settime64;
+	struct xn_itimerspec64 its = { 0 };
+	uint64_t buf = 0;
+	ssize_t sz;
+	int ret;
+	int fd;
+
+	fd = smokey_check_errno(timerfd_create(CLOCK_REALTIME, 0));
+	if (fd < 0)
+		return fd;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL4(sc_nr, fd, 0, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_timerfd_settime64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	its.value.tv_sec = -1;
+	its.value.tv_nsec = 100000;
+
+	/* Provide an invalid expiration time, should deliver -EINVAL */
+	ret = XENOMAI_SYSCALL4(sc_nr, fd, 0, &its, NULL);
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/* Provide a valid expiration time, should succeed */
+	its.value.tv_sec = 0;
+	ret = XENOMAI_SYSCALL4(sc_nr, fd, 0, &its, NULL);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	ret = XENOMAI_SYSCALL4(sc_nr, fd, 0, &its, NULL);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	sz = smokey_check_errno(read(fd, &buf, sizeof(buf)));
+	if (sz != sizeof(buf))
+		goto out;
+
+	smokey_assert(buf == 1);
+out:
+	smokey_check_errno(close(fd));
+
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1433,5 +1491,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_timerfd_settime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.37.1

