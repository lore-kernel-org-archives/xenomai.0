Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5C1C14
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 13:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJEySLJGKhyHpq5nAiCCvqiqzxa42IgP+qY9WIAWnrL5WwD7sItLXvV0ahzstRRdjHhMEpSYSiRp0+r3mlgf2qFImVov1L6tDcAFSnJFTwmNL3rCkYBk2UcyMbRwx/DA4ZfR3egvQLOtnJjnyAN1+2oocTxTyBU+rkluhqqsk7ZkB04+KK+El/0tZX0cdLNE9XHn2VfxtA2RJgULCH2wfAQDkhdjMiHsI6z4079RhgmP1GipC8z8+lmEpXHvUlp5Ub14G/OMN7nrDnk9W/AWkm+wzzZZjRFqE01ptZfNMyVV2mLtdQbl/BW8YKXBfqXh2J4gdIA3OsA29fXI/WSsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8gSIGJrG1aIrMQc/nAPhxNylYpOk3CQ+XAgQD435dI=;
 b=lh0++DmiJhs29rhLiCgkSSREnHstuK8BkFYFEC9OnCCpGVTtMIb4Gjj9X+RvlUcC8zdeT5aPrJDm+y7iEDpAkzlpmRNUk7/7QMxCo75zXamDIMR+6XNDZM4xjCB6UY9z107YCiU6oyVDgRk84n3WALAx7/Q3/3sndhtu+pM89+CEsQWoNC9GCXbpqNiiXTL0xVeip94UmP105sxkCugNfld/k3EaV7NomcHjJ3BjcxnWe+j8NetKZfatXmaHckQ1x5m8TJ784n63lDn+kGDzzy1imqUz7zURskt8HlrmCQPNOVm6q0DSCIysGi1IgKwVkdxt2KYAylqweW5UY7JIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8gSIGJrG1aIrMQc/nAPhxNylYpOk3CQ+XAgQD435dI=;
 b=u6lcd4FnMqg25ACv8Zx7Zj5GPcqS/T3Gv6D7wcFmKqpHIrEB39B1Mokb5KFXE0fmLM20tTlHkwUeV33IrU4RtBCsWMn4jAxGMMO4HGqN9fPtTMLZsJeYaYppVXqAXC9QK6JgmxOETaMxGDtEx6rvxRCWxe7Lm3Kx8oFjCY4ll9qdyNqPhvzWjLjzm+645MHXqoZQlN2Kk4krLP9pxzb/GPCJMin7ZED+6nPC0hGr5aHwyQjOyZPxQ8DI/Ut68idlye1JoG6LZ0KggYPMlLus22cBgK9gSyvMwllv+o7JJw0Yn9ioZhaV2qGaXil9lTIhbFfv7/PMHc9Lkyc9BIpCqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by GV1PR10MB6217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 13:14:59 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 13:14:59 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH v2 1/4] linux-xenomai: Update kernel from 5.15.9 to 5.15.57
Date: Tue, 20 Sep 2022 15:14:51 +0200
Message-Id: <20220920131454.121225-2-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920131454.121225-1-florian.bezdeka@siemens.com>
References: <20220920131454.121225-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0147.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::32) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|GV1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 14250d2b-53c5-416a-dd6d-08da9b0a1e83
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lAzbdk1ndxmJACDUYkdQA4T7HSGqmYnygVfD9nejYLAzGkIw9ewhBfk91ZZ7DVvC8A/+/6pLrN6wyVUvzqzcpinHhmxga72CqBooq6st1rhG6yA3+sZx2LvQiQ8olBT3PU+ADKUKmSig24ACFbr5yEd8m3HjK11O09aiQhsp41hK7gQURCiAU5zdI0TuTUSTMo7NPXjRaPxfe42Lo4CexVoqM6pM0p/dpNGI6bCfDudYWsJQRXRnH5WBIrbgR+gViWbldqcdsZ5hLwaxYJdnjcZE0OPOmsjMQZpMwQgCts94fC2x+7dINxXd6Un0BsX0RXf2VN3Lu/pmuzLH22Hg5HzaGhvt2zTQaFAt4mPE74N+DkmObVlQ+W2gk9uXRZRwKf8k5vE+qymH2EBJIYIwVBbEhNgqp+/4DVz0qmTsSLtCAk1+Dr3V52a8GrzuoaPB/9dWb/I6vXGDbqGRNo6PAjFpT9DQtC+C+/Ty5Sbh0EZ6SttgpByBb5lHj2k7u5rO2j8nqn76oD6Avsjul5hdKHxgmMWMkG29did0N5zVT77XYvtVMOE5F1fyllEvBuL4tghPtOYwx/rHVobZeFs2+2tnFW84go1CRQByJJxZ0QmhrqzUUeRrj6XBOCHr28Kr/ZKdRLI/J438P3pXs2RVYqPBxoLGoOD1I5AXmoD5rK547mH5gDzyw49aotKhiNctSTQmadS6BD7p67y7gYJpQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(66476007)(66946007)(5660300002)(66556008)(8676002)(4326008)(86362001)(6916009)(316002)(82960400001)(38100700002)(8936002)(83380400001)(107886003)(41300700001)(6486002)(6506007)(478600001)(2616005)(186003)(1076003)(6512007)(6666004)(36756003)(4744005)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H7YYSESWwkK/1fuqObrw0NAf+bxizEuuitEMUl7garDwFptwTyIwws/Sn81v?=
 =?us-ascii?Q?MZwotjQP5Tsz/mFacf+0U2k2q95GQvFV/H48Ogjjxil2PGYg9fMrnEinqZnk?=
 =?us-ascii?Q?SQY6qqR9Dm8p1ilztSj9/CW7UB7kHXT7gVANlOfpKiy7iwkSvuMmGnhbMNVe?=
 =?us-ascii?Q?+/ai530r5T5WdcecmPDy24Y0SP60r8mm3Ds42ZWoOytkG3NQxJ926tnRtJon?=
 =?us-ascii?Q?kKbW6i5ctKD99v/Jsve827Ek9UUSiNX+1wrwQfG1RrP3PA0/9P+Q1RxBb4QK?=
 =?us-ascii?Q?fHhD2ZdHwv4rplvjvMlCcf8qwL2A3yIoaHjcBgO+Kha1rGPLBpufR+YXy02k?=
 =?us-ascii?Q?GkWlbLU2ZoNciFwMA5MEYduuiibLWNWlFvDGo/glFJxwMwHsxVo+5enhHw1Y?=
 =?us-ascii?Q?LFE5jwDYO9xj+FdRS53eeKcolNwL/oXVN/1/uQ+lGmHWdm9d4ptN1LlD5SOa?=
 =?us-ascii?Q?ANLkdUb3f6abj+hDbKYls4QTrfn0I7xQysx7F2RntEsWN9a2J9o3Hw41M2gg?=
 =?us-ascii?Q?AkblF9pBH5eJ310k93lakkhf+ZSdwwIt/6vJ/8Znq17N87rr18Bxb+GTwygu?=
 =?us-ascii?Q?dOs07IGOXdWCnr2pvAHfRYjmOnavfqKTVj1LJgYS0+bu8lgPuV3EtW7Xkp65?=
 =?us-ascii?Q?VCMC7cfaX1zygA2K7O2OnzGphXngFFYgz4tdLZcIOriJ9XXi4rzOs0cPlx/M?=
 =?us-ascii?Q?u8fRColFSZs8AEJqfLysRjBK1wMfZyaA4JMlbHnw1GUCSK3hLbcVGalDwiCw?=
 =?us-ascii?Q?1iAUfU6yrHiZypBzdGnmKQtRSLdYnoMeJpPbWsjE2lnUERQgBX1qeqTR6Dy/?=
 =?us-ascii?Q?r7ORdBY2i5g4aMHUC210j2tMr+HEKFvna6GrdEVhL56wGSB3dv7hOJsW92bP?=
 =?us-ascii?Q?d2tNboapjYCbfQtzuUKIJtfIhJQra02/2FR9gVRon+hTLrFthESZlkODMHgC?=
 =?us-ascii?Q?CErZMPPZAtQxPesXVtVWjBHl77Hx26s2dSyazSyyPmo44wAbvnEcmcuut40a?=
 =?us-ascii?Q?Pd999tzSEnlE787CBQVg4yAdvsBWvoZm53r7rTa89The+FD7Z9Gn7WzCOK3N?=
 =?us-ascii?Q?1wVA0BYsHg9+uFLGqYJacfiYsMenKOop+FHkUHDxf6fErznIOkFUVPjmnhRv?=
 =?us-ascii?Q?XNHuhSi6qCB4S0Jow7AZdUsrjvynZSh2ONMZeg+inIU0anMnc2DONMVW7m30?=
 =?us-ascii?Q?RnPBqmsfEMVzBjVwOmNIH1aN9UfXquRa4Eh4O86V33KU2ZtGs5dGQGSp6HeD?=
 =?us-ascii?Q?Y2WFllY8JdyN7KDdP4Puih3df5HbSS6ZaC0fJ0fqFWzt/dCqfQx91R60BydD?=
 =?us-ascii?Q?XQidGGbK79DVfX/hWXQAZWxO5Y4edAfOnHFljYsIV6/vmF0/MNcdZ8SFlAqV?=
 =?us-ascii?Q?X1Xawl1MYKYLK+LbrIwt4Wixo1MYj+c6dn/Tg3nwW82NamPrs/zZA6jytuYA?=
 =?us-ascii?Q?wMUH3fnxdbeyNF68twP64lqCL9NyORGbVVX3e6PW9j0oFgNbOM+NJuNbVokY?=
 =?us-ascii?Q?9g4PxCld7S1BbIxt3euIWQdg7GHWg1R0T5A86hXbkmUba2uw2aIVQkMpPISC?=
 =?us-ascii?Q?cQ4vfR4uFiSXoG0wUgGGCvP1YgL6RF8+y7t06Xqzt04wPokn4Q0KKXQU2rYP?=
 =?us-ascii?Q?gaKS1qHUY7ZoDVD4Hbix0c+KWj6gIsfjMzRqnfnkE/QErR8V+mxTgNM2sd7h?=
 =?us-ascii?Q?xRRvgg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14250d2b-53c5-416a-dd6d-08da9b0a1e83
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 13:14:59.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9Lcc0piTA28v3Q6sCmIlYSSr4c3kgZ6+vLQzxJKcey6DLpH0zg9zeUJ+GlMyfEteKshmbA+ANmSXH0ILmKhbpCJKvOfATX2pTAP1tQ0WBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6217

This fixes a test failure (x86io smokey test) on kernel 5.15.

The necessary dovetail fixes are available since 5.15.32-dovetail2, so
updating to the last available version 5.15.57-dovetail1 fixes the test.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_5.15.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_5.15.bb b/recipes-kernel/linux/linux-xenomai_5.15.bb
index 9a3b12e..fcfc4b4 100644
--- a/recipes-kernel/linux/linux-xenomai_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.15.bb
@@ -12,7 +12,7 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
-SRCREV = "v5.15.9-dovetail1"
-PV = "5.15.9+"
+SRCREV = "v5.15.57-dovetail1"
+PV = "5.15.57+"
 
 S = "${WORKDIR}/git"
-- 
2.37.3

