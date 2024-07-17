Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA314B07B
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212684; cv=fail; b=MQXjs1rBekr4oxmXt36qXftxw5DMQby1yZDPenibsdAst/ID+EriWbsb+gmsrSJiKz7BjCr8oBi9TI2GV4aGfdI96jWZzEN3CGbZg7UpjjMeSLefe6ZfF8v74Ep8juWAQaKH2toRpC5+JccYnKjFfQvH40BtnAYv3a2ruG59aAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212684; c=relaxed/simple;
	bh=6PxBpVcwf9kfFY1wORDjBKe6c9tCsJWNPgV7ZfDfmAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o6OQ97XzEYehtLkb2szBioyPUH0RT3OEQHwf2U70t8/kBHeBQx442IuLIiCx7cEY90YW6Qty1/F9xi8I5Wqcc/mJBrh2XZ55oX+yZYgj3t5yWvo/2oSYuXWMkQIYwD2hUZ+iRo+GO7yMd7BV68D14/f0LpVFbXeFJ2KkT9lL3A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vITETGlK; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vITETGlK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqz50cHvDDX3Feq4V8pZdVxde+QSZvnZHh3dRSxHMITFrbL/MGuOeO5sL0YRhVC0iNw4o4+1bOV8sBJXTTNuilXMz1g+l4Zr7QAudfmPxVjqLEtfhcerud4jEk8YlyCmLY44HFDblFM69mt4rq5h4N0xmKeYlfZD+xoASo83MCOn3LI63vvAcEI5EHhcnBY6UKxHzAQWHcksTAWJsb6zVRQTrsQNzmd4fq4CX1vLdYV6KOArF82jpUZPNF39CqBDwXfT8JHUpmn0cOQnVhLp+EPPnYY40Z31+YHs1nuV5WNgPRD97v3qu/Zk74VSAvkAmSevqfBfz6THL/0X68bpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyzeVC7b/Db09izcVn60KiZLandecgsMNBqCzUheZnc=;
 b=iVL/KhJwJaXTGTFldNANdOw40h+UEVyZxEDXH8RlZ1O7Iaa7kmhHJ/krHA3cl2lLTBDM0z7+Z4kNnlfYgeLWDK9E3LCTz8P/MG1IH7lmTpctKAfXofbYMJsF2Qvzz7fR0XzGAwdMpVEMZujPylAHLO3tpEJ+Yf69pbA89mdqphZsDjbq7L54TjjuXAH4p0FwTZft4OCAkCdBLmGDgkQjvCGf6KxOTLtX2HuEcCBdc0QlOi0nZ9Rf2mBun+aBlCddZiw/vpTpruoVwDttiSdVDf7Pkk2pkQ+fep++tYKIdYG0sFOvKjCV3CSRei3gvTI+lnUGAJ8kRm1vCt6S417I7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyzeVC7b/Db09izcVn60KiZLandecgsMNBqCzUheZnc=;
 b=vITETGlKQsfecq9w/OoN30dSlnPN429cTL6mPoxI0IpAIs/UFJTpqV38CuzNBgpYY7bGrhWpo9vACpxfWQGUYJC4m6OlDr6ok5btC/7YT+XOIEQ8tOZiThJV2I9H0B7GwKQGl/A45fcc6drcf/Pzm9gClFwBEyHUmzo0utepcAUkK9mN1eytRdLj2O2hH/5nS2tJKuAce16ND5K3hQMhxfN13roCn186+rHmSsjuj2SiiTjvbJA0jpmy3udmoVRSPvy7GyO2gBlTDpuVt679nXj6h7rOaWohmTiUIJGV0/cfk31V4s7xDGBYooXmLAQVd+Tzb8+9HiBjQLk/LyLk9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 10:37:58 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:37:58 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v3 1/5] ci: let the lava job fail if xeno-test fails
Date: Wed, 17 Jul 2024 12:37:44 +0200
Message-Id: <20240717103748.161788-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240717103748.161788-1-tobias.schaffner@siemens.com>
References: <20240717103748.161788-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:610:33::13) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a749ca6-bd1f-4aeb-9569-08dca64c862d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lbi/bTpaoAEKSOKdeUDtRZWBk478GtJz6CsapNKSUxSq1nDctdRo85O8qUO0?=
 =?us-ascii?Q?OJxHnuErc6SgpY+4qsSHETrPyQ8WzdKq0vLc4+SwVMBGAqaa3UMf1LqItLjP?=
 =?us-ascii?Q?MvQv97oyO84Gh5bQzFsBdKVvuki/tJHwj5Z2gLPrlYO1flFQyEQLcMnng8pu?=
 =?us-ascii?Q?vDkb3MjMbPZ0Fg4F2TPNQ5zWUqiczfc7V4eUCJpmQlcA/ilcOVekO/Lzhush?=
 =?us-ascii?Q?bCrpaFeUKSf2k3UdCPTThyIgPJUC5dzFCiKz96YJQP2rfSROAqPTgWgYtTV1?=
 =?us-ascii?Q?p1l5yfVWn5HVBfZ60xg501NlL1yHRGQUzr58TZBXDbc4xDgGpzQRpMX20SEH?=
 =?us-ascii?Q?/Mu5uhqOz9QCqsg1lg8PTOCEQTi9C1EPtFo/PTQIi8eQGkfoXEZ+JevXY79+?=
 =?us-ascii?Q?BjEwk2X9ojiwngShO2iblTzaBqbc1NzJXmFTMShXZEtkqLwOCLs9Y+5CTj/r?=
 =?us-ascii?Q?D3Uxh5+FAkpXsVS7XUKSBQtTdtaCI3mgYVZPMh44GR3jwF5YZCymLKEfDrsT?=
 =?us-ascii?Q?0VRoIytXxuwX5/6xEuyPs1OOjtqQsIlbKrl5ysj3ngCBD9OCkEMzVIvLunVO?=
 =?us-ascii?Q?ZAn3c+ZKCvmawTBV8wXyDKRRh5Vw+xu9qdchk2udW6P5e6hK9+C0PDn/AHDk?=
 =?us-ascii?Q?7XSazF+pNIuFkDO2kQ2vqUmB8FTgDQAmfwg/hQXpYPIYB1dGnhW6e68SRhfo?=
 =?us-ascii?Q?RAjgmOLr65AbbHrkS4sIw2W0aoUVoTFdxN5fsY6VhmNDxE4dBUZBIzQTmwGr?=
 =?us-ascii?Q?ux1shRZZSxtMtd/bJXWzHcTN5N74bbq5/+yvi99W+AbnDzl50hkmBdL5T0sY?=
 =?us-ascii?Q?ee1iIFtSMFBg2J029Vi0Hs3QYGvChdjchB1WviLxmRWgRlKj/HcYKvPi6uo2?=
 =?us-ascii?Q?2L2XttTn6DDaG2K4yQHBAThLcDzLuTd9Dp9VzfcTAqXD0jaeL8V/JtFfJgT6?=
 =?us-ascii?Q?006DavOwzkkVQ6xNt0l9OQAy6CueQPu5iu36MM++r7zQBo4nS9caKYoEGoel?=
 =?us-ascii?Q?q7bPxU2jq26Exmrwt3OyLtmoNvXBJaHzYbSzom6n72dHhE8XsNsotM1OAOBX?=
 =?us-ascii?Q?p5+W25OzI9UQV5yKRQcppIEO6Ak1q6sDj+RREkGCvHG5MTKQ3kxkOoGoNFjT?=
 =?us-ascii?Q?yINXG+rVqGWZIekeWw91GO2tIw1ehkIA3zD4hLWmxSygCWka2Musj9xMdGFg?=
 =?us-ascii?Q?m4qvwCIY+7Yje2Ckhuv7wjDwk/adgtPe9XmtCuuZDCbWI9U9IbKFF7xNEZrj?=
 =?us-ascii?Q?1hV8LjGGI1DeWFNf+H2gJhiDT1uKJeeHq44IvrwqqcGX+FHMSDRpJHt4Dj+X?=
 =?us-ascii?Q?H+Buh9ixhbHbAigGDDpo0zHVfjMCkaPTUDYm/IWkNaHjMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/PFSsrwfcAxXqo1hR9oh0bFZAbZ/rG8BCaGiZeQcwYJehb7iIDwycUH6Q5J?=
 =?us-ascii?Q?b5KpB5+KtANfzLXOZAkchnPyEWB8fT/irsY7cfiQOqf1V4Yw78it/42SLuad?=
 =?us-ascii?Q?uHhV1tk6wabwab8ETzlSW6Agde+xxnKaC3I7ZdChtM+kBJeOS1MCFNe75pMQ?=
 =?us-ascii?Q?6aNqmt6stJNuGNCxHEkFimrYw4a1MqgwBe9ApObEZltReU/Xkw1wIRoFbS4u?=
 =?us-ascii?Q?K4o0fUmVjxJ5msRrI+zUz76ax+4ifBm+EtMiOdc5Nt7bWfOlZwqwpfN+mmhk?=
 =?us-ascii?Q?xuWRuvKcSfRND/q21xykLOE+rz3KhC9PA8b0IU+4Cpoteop3sutI/CKhtTuy?=
 =?us-ascii?Q?rS3IsusdCy7qk34TG/VFVX8KWRhL99S0Q/K/r8yPtZBb466JWJ6hjKPkxds5?=
 =?us-ascii?Q?/VaouO7rYfqpVe+s/B4VmPHWIhooADFTavlE18kLLYfCryXtabd5jpD0vUj5?=
 =?us-ascii?Q?eitlRA/qZKOky+jRDIJcf1CFLdGmPs3NNE1TdZlGAQ2OGY3jjZelPAA+uJxd?=
 =?us-ascii?Q?EdQxT5YlqoDuA/CFcAzJqtPKcltI1lS6n7gbu2Vz6eA8NToTR4+qQktOaJcy?=
 =?us-ascii?Q?536eMF3k/u55DgTud+7otqGX7dAbYM67GTfwu0s6IIHvfgdeAWEpCbspCCfN?=
 =?us-ascii?Q?kVqRUtJSXZtEvsSLwWhh9/IyE8Dy1QA52TM1Cq/+6D32uHcltSP6jKPiyVLA?=
 =?us-ascii?Q?PeNyKnOfrJarh0F7TjIAp1ITnQO5kkoDbT8vbSUW9jrdsZ2oFH37OPu5WtJX?=
 =?us-ascii?Q?Y2zfds4xp8wT554fgcBLhitH1pfNThYv7JAvQC6FvbNhr8YBsUhmBXXdj12O?=
 =?us-ascii?Q?ij0a8XsRwoYFfK79uQfDxEGm+CPC7kFZRgqa8tXSnMWQdPtsl/Jx05tkz3QN?=
 =?us-ascii?Q?YViDBOuRKn1N935PFu/eZwdmm3hztryiOaQuptUnnOzegjZFHwHVRIaLlBeD?=
 =?us-ascii?Q?4kxbQcFY0De1tZn+Az5urc1H2O8KeXMiVHSJdOT8uPimw9fOdunXYgcM0lHK?=
 =?us-ascii?Q?vLI75FXecAMKCTg8qqW9l8EbVGgMuGhJH8sFmT+0HMFwrw60eteHI30AaATp?=
 =?us-ascii?Q?FKZ4cr4B+R0SH6csf605mtSMXNGFJzP8cUMubQHle8n6r1qVMWk5YXIS0O9K?=
 =?us-ascii?Q?ASlMCODHjr2+GonKgNULh8sxo/c6SKPqb9jUSj9G6tfNXJxaZGpVDiv47BaI?=
 =?us-ascii?Q?3J3v/p9u7qfn0dwejod769PCautleREYpORjwSjRgb4y+c8YQzye6GUPNNwg?=
 =?us-ascii?Q?gcK+GL01bqbVCpMc/zrMt60Xm9uuKZNLPsNplTCXFB2nk4Pu8IoOsQwTcUK6?=
 =?us-ascii?Q?V67p6alVCxR5fDfZifFLvL8IuU4XzUKe8/BloSl+Z1KzfUqq1o6Dv5IX48GG?=
 =?us-ascii?Q?jKbsmBYyvLmKcVduT7fxqTydrYpUiKVKB8Dshtuq+ZRLxzPOqxCar4AxbEpw?=
 =?us-ascii?Q?UuZNBWRMowEmOzbyppRhGDdyEWLi+0uDNoAISUyOcn0wlmm4pNkOewPxmRn5?=
 =?us-ascii?Q?lcdHU36Qb4th2mTRJ+wJliJ60luWBQOefo9snUqonqodWvdQCLKr9wa1KkUd?=
 =?us-ascii?Q?O8K+2RGSjsYm++5kgitD/6LwcYmbKPG75kIgyxzuYBOnVaxd7eWTDpHKewZO?=
 =?us-ascii?Q?rwDzfkUTE/KBLswEe15aIKc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a749ca6-bd1f-4aeb-9569-08dca64c862d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:37:58.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmnhFG1vYlaxr4wIwtQ1v8XPDYPosbsnkp0zyAuSjkAb5HuRv5KHocuZk9kUpLe14Cuj5/2lNQkzuvqClbpfe2LP7QJQtW6PSd6Wmsc0a/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6439

Use lava-test-raise to let the complete lava job fail if xeno-test
fails.

Fixes: a regression introduced by 22db8c10

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tests/jobs/xenomai-beagle-bone-black.yml | 2 +-
 tests/jobs/xenomai-hikey.yml             | 2 +-
 tests/jobs/xenomai-qemu-amd64.yml        | 2 +-
 tests/jobs/xenomai-qemu-arm64.yml        | 2 +-
 tests/jobs/xenomai-qemu-armhf.yml        | 2 +-
 tests/jobs/xenomai-rpi4.yml              | 2 +-
 tests/jobs/xenomai-x86-64-efi.yml        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index f7966ea..8e47dd6 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -63,7 +63,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index 67c35b9..aaf8949 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -62,7 +62,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 6a548dc..041157d 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -79,7 +79,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND} --vm"
+            - ${TEST_COMMAND} --vm || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 35dd3b2..09cd0ce 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -85,7 +85,7 @@ actions:
             - quirin.gylstorff@siemens.org
         run:
           steps:
-            - lava-test-case xenomai-smokey --shell "${TEST_COMMAND} --vm"
+            - ${TEST_COMMAND} --vm || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 9560a85..0bfed71 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -79,7 +79,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
index e8b9a7e..50ff9ee 100644
--- a/tests/jobs/xenomai-rpi4.yml
+++ b/tests/jobs/xenomai-rpi4.yml
@@ -62,7 +62,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index 4aafccb..4f1a7d8 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -63,7 +63,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
-- 
2.40.1

