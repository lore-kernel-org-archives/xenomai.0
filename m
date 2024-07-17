Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EF749C
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244723; cv=fail; b=N9SsvzhOVoV5NBRyZLzbQ5ogE0y0GEgjjHxUoCKWAJcNQO0opHHNx7TneEwC2wwLam36N+SS7GXL/KNhQG9SA0DiTgC8R4GsVMDV7IRkcsPJbn6NrHLaL6Q7WinEP/16aaI2yQRBaaYULKQTg3/wudYY27ydFbVslXIvuzO1uA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244723; c=relaxed/simple;
	bh=krUf2qw7C4lFMEZAgmYuA9j0vuDdG3QWqslxhg25ZP8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=o5Sky4I69Bt/Qc0beMIco5OsILUvkwP9XqlydCJxCxm9ciHwQYnayfkh3R33ODk3ACvPpR6XX7T4mMFf1XVJBTdI+1OXQXn4yk3RH/kpAIzrxg9E9utP7xyPQl+2gxBW60Tst7GJpVfagCDWzQ8TXDwFQFAGttPdtr/z/kTHHzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=E4JTts4c; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="E4JTts4c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBB79f7QObMttF/KSmNo+xECOmvXP9uV0Njem49FBPvEyFvulB50MgCn59IAkthipQG+tx9vjBODpmyO+gn9fZNgKh67ZU2tEI/O1o35dKB9xGjg+gwyEFUPLDKfbeHIgQG+yMD38LQ7DV2EvXP5S424cuRH0+vDXLpOeSH/ZoR0zRfX5rdabaVFotl/aftxSDxNg1sRfACdzbncSWDMzTeG0bNIXMgaRLJfRGXwL7/ZmfOD2vz27qbglg9X2rAZjz8q6aBp186/l52jX1xd87lFb/Sep9mf/+FnG/atuTLVvnnKtMw6Jo2JPy1REdxuVd2Yx6c5MC2EAynf8AiOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HeuwvK03GUZNi8dd1Jd3xwUPtp6f5V6CGvYzohc9UE=;
 b=yP3v56wwxNH9V6Kv10iUOJxsJASyiwPK/lc+WBDbtgmyUpNvEFus/S9hOMlyLbC/U2Q2hp4Thd+3ZEWoopdFgmcr6WK0YB2F+hJj15SX/mFJOfM+XJfE+t78mdfglRT4g+xVQcYh7MBaxgdZyUw762/Aue7aHDts+l6Bf3FAgJipYODEDendkcSbfS7EA6tQSX9f9ncPcQws/j6YwnzORcrR9ykyFleFgzWmbqmmvYzbpwdSNnPuVKMzjyl+heTGomsHLm+x51DPCqIPxeXdxmJbFTARY8ha38iJRVdKQgFXSkDcYxVO0QrgkkaYAeg3Ej0TNvypKH0E41hqgfrZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HeuwvK03GUZNi8dd1Jd3xwUPtp6f5V6CGvYzohc9UE=;
 b=E4JTts4cD+4CYuM599doU++C7mBBkQrJLOP5jlnOuAT6jk/fZwpdxsdsN2Zu5Y2Srirz3dxAURyxbZWqSPx4xv1wZkKuzeI82RS24kqWoHf4CiCskrD5Sj2q5UMq9M4OLCEAAIidUtzbAQaRNIOMVsKCsEls6ThbaqmBRAWq1zTselNdPIsMhAX0ulGlzybGhTNxJeFB7RDUZjJzqqt8DG0d+s3CLwasceqnN3DrvVNOGHNWHo67xey2e2kJ3Hwrkg2FmEM2SmIaRjr5rDnWc3FjQzMrMygrYTFwHw+G2Hk+VDbskUhLMVNrMpnrw9m1Kzsfqrfix4X56h91tY94Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV1PR10MB5793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 19:31:56 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 19:31:56 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH] ci: add x86-64-efi target to long term test
Date: Wed, 17 Jul 2024 21:31:52 +0200
Message-Id: <20240717193152.510216-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV1PR10MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fbd331-e349-4aac-a9a0-08dca6971eb5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D4y3E8K0NjWh+eA28Qy2fPmWLJZB7U53ojIl6FXckTGTTZqvcY0KEOLtUg6M?=
 =?us-ascii?Q?qk+eC6D30maghJVz7m9l7wCZTU+vrt4d4xc98Ri/4U+9A77KJ68Dv8vxZ4w7?=
 =?us-ascii?Q?ajua82jgNtSIOJmMaLmx1uhGSXv3DC9MbBWhKVrFGrlFZNFHCNaImdLkfrYL?=
 =?us-ascii?Q?wUGT+nLtAzOtIkb5hVn4+un2vDDVz7ofHPwg4va3YIOLRconxLx03Upb1EmP?=
 =?us-ascii?Q?VMOlYTgESQl9MGRD2ZJ0S/8eeqdhxO+O85Qwl6M5hlvfN2BiTYnczZ8ucF+u?=
 =?us-ascii?Q?OYm1TctFzUwaqjI5p6AXZQTZUQUWPpTJzTyscCIb8F3UEuUxEFKH4dmYbmP9?=
 =?us-ascii?Q?ATTMmVc+tmKCr88lV0FBJpZh6Zysa9RAi0HsFaxkRMVSafMSPt/PwvF066gG?=
 =?us-ascii?Q?NAywoLbzwfotgGa8F/jMPiJExmGC8BVr1tHMnf1uX97coL5f02tiMGGy9qwR?=
 =?us-ascii?Q?5C+zqoe1PbZhs0AiyV/MuJy25ZvwvrdNflUyCIlONHTSR4WAArq006QD6+/B?=
 =?us-ascii?Q?qGE347UDm10ku8WcN7FWnoFRy7iGBoV9i5ha8Tv8bslvC66I3xjvVhWT8cj4?=
 =?us-ascii?Q?EtNnjZF+R8rNWEiQNXArvUVb8b2H9r48b6LcArj/SG1IJd7mv9Gb7IfX7R6M?=
 =?us-ascii?Q?/t/pjuoBX6vRU2YDxgDi4vGl5SnMH/MAdJAwlAjstKTgiAArVTAbqryqIt1C?=
 =?us-ascii?Q?nrg7NACgmyfSKN3qHoep3HAO/dHnkxk4JMOKK9un5Y35YeJg0ayLoyi50DBv?=
 =?us-ascii?Q?tbRvXRGl6PQHYMDUjVJg+RAowW5JY7iI8ITWiT7CkEHV3K7ZHo9CHrQAM8tE?=
 =?us-ascii?Q?ZC4CfcBv4CSNOSuKi3SpIoCFnBD/ePSl/IUcxLC5roGhxY0TdnXd7Euja8ar?=
 =?us-ascii?Q?uOInTm5DXg2BtKo9RCvf+rUw1yHimTW3G0sJGrqgCThJbfbe1eTcCSz25AT/?=
 =?us-ascii?Q?g7zYEF0SbGcrY6S4hR9JTQK76QvjDqzXWK72UYviuQ5xFWRVO8wPymw4HRJf?=
 =?us-ascii?Q?IWLqFXmqQk8rxoOlYMMb8R/Pl75mGGBSNUwfFEeHhm/AS9z0uSohfXnTh5Gm?=
 =?us-ascii?Q?u8svM7n1P6eXJ7f5YvFX+p6CdPDTfb59hRr82rrl+ZQKu0qzri2y/txGkC8G?=
 =?us-ascii?Q?+SzZQ5O5LH7OZ5RmYQqNy5VPd1DaWlk+XHzIFk14C4a5+LoM4AfD2S+V/R1h?=
 =?us-ascii?Q?A3cth5V8PbCnU28J4x/wfdbhxdoOZUWt9l+Gn7Dz+WNbxbqI4AovTBnyYhAp?=
 =?us-ascii?Q?bQ2W0ocQdewYZrD9NfipKlpf/0o6Q4jRjgXlxJyka3ZkmzGmrewRvd7RYERI?=
 =?us-ascii?Q?r0c5sHv4XO75VdtrMxSKWrQfbc1RMugmcwO+7X+R+OxZ9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?heiC8/qgyenz+bgfuC8HjI5iP9g6FzSWiY1tAx5nI9ECLc/Ktt8TRHoJ+wHl?=
 =?us-ascii?Q?XUS/G87oesJCByiXeh4v+XpwUQQx2JgLudr/DKymSWMzxiR5sdlIDqdDNTLR?=
 =?us-ascii?Q?zPq+N/hKHmEVGeblY5P/4+VMAcwrIs81PlYAveVIfpV1Z+5b4XTwAA7/GVIV?=
 =?us-ascii?Q?NLejKs1ztI8dKcV9rKy0tv7UaD296eGeZPdAwVrJMR8ybTNjtWPxXtu//YsN?=
 =?us-ascii?Q?PfDju1e7c41vWYM6DGGGg1OEns5cPQtl7lSTK15/72sp/bvIx6oZAt84tVJp?=
 =?us-ascii?Q?NzthrfCvAsj40oDb4WqtPt+5ix1Ukdoi51SKvi2XMFpHK9MZN5rAE/yDeJ2x?=
 =?us-ascii?Q?YIUuOLFVZF/8eun0qA2GicFefKO4wvNkfFJN/EwEkkJB1KEc4LJMvQr9toCR?=
 =?us-ascii?Q?kl95DDtKB5MZjNRhxGGXWZVUp7BBAcbWybXp8KAilwRng+vSwiqSk0qYzrIk?=
 =?us-ascii?Q?C5eeLE0Pt43TvtemU52SBaCdYaGZ1Zx75m4KWfvhBK4LAcynCaiqhMFLAkMo?=
 =?us-ascii?Q?Ag8QM/vkuKUR78UqUcVaMXJQwEYssMdfZO1bjTe+wv2HJCDlfY8pd14GZYrg?=
 =?us-ascii?Q?fkhyE9ndG//w29OKhRkauQJMlAfci08Dv0M7Z5FGeHlWeZMLLG8gw6s4fEEH?=
 =?us-ascii?Q?eKh7Z1R/ad0o54PFMvCpQnv52eGC3hPrpYhQpQWi0hFgnNL0ISAdoD0dR/Sb?=
 =?us-ascii?Q?mZgxoqTvLa01KoJQ8L+qqYpWtBXRp2oOkmB1gL7yszR4HlDTXJKPXISScdBH?=
 =?us-ascii?Q?sPPwN/Rw5iUlVPqKKzq1g3XIRSeLevkDcFjgYigmN/lJSldHM433twFG6THn?=
 =?us-ascii?Q?ChkSFYLUSXRfA5VPOEm9L2g1h2pT8g5BVQQhy3ECKYxk4FJzZTlVzT1PbIm4?=
 =?us-ascii?Q?WE0n9fry+xQkRgIbPCy1ZXuP+Vq7sO4KRECMk3nAWHN8R/pbZ1z09aDOpyRL?=
 =?us-ascii?Q?tiKyl1wHgdW2L7zHGA/vtDHx+R2pXmQp9stWBf5n0H9aePIBKlde9X92ld8r?=
 =?us-ascii?Q?5ZCJRIq10740ayBrYDXHzGKEkDZwgIKQDM3NXJ2EMa74SEgkhCdGy3lGPD1i?=
 =?us-ascii?Q?neqiUW/M7Pj6VE48xaKJNRoPSkI8ddjN2wbwNTZC5R2V2HzyzbeSqIip1EDk?=
 =?us-ascii?Q?7o29jeEu8Omy6roEKWaIthy9GuBSd2NZTlkw2+qhwoUmgjPEhIAWBo3sGqCF?=
 =?us-ascii?Q?+Yf96rcN1szkOx8XKcuug20baPUOMLS1zlUqEJDyKTjgUyfFJL/MH94ZWER+?=
 =?us-ascii?Q?socyh5gQRuyEcm54pMUxas5ScmFacPS9FtC6Tzuti4Cmi9/jgB792+hfDenx?=
 =?us-ascii?Q?xd72SEnsWt8ye82Hgmp+rsMqRTgzFNQmAiBvSE2y22qvSlnq61IB7fxaSsEm?=
 =?us-ascii?Q?iSq2aVB9VMP9oQlYIpTl2lvIxxGQTMfZu9C6YSbAc2ZSzc/PUs02bej1lpMT?=
 =?us-ascii?Q?3nzNyehhyDdvrrSHp5cQ5V2wAkoE+CK4IiZqlIOIqoEDzCRGFUSiVXfjzVxv?=
 =?us-ascii?Q?EhYAeK6bSUiBO8CWwGJTzfOanWZCzYBfEgchy8ZipJz7ROYz39zmghiwUjDy?=
 =?us-ascii?Q?nWhvZHXBNmQSckrB3qeDF/Wq2cjZ4ODStpAV9bOxeW/qKadkXi1agf9z/y58?=
 =?us-ascii?Q?PnkwuCgwafK57goFZm5tUZ7QbQBELafDJXHM8oPlc17+EJ01ENSvvuuoJbSz?=
 =?us-ascii?Q?sY027A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fbd331-e349-4aac-a9a0-08dca6971eb5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:31:56.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yDnONCVwZS3+85eYSPNJ5+rZfXxD3rq77O3sBv1NZtHG0tSmwsql3A3x0QYEMGpDzNXD/AVVjtG53Bw8p0vdm9urO7cI6wy3Ms1LvGhim0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5793

Enable the x86-64-efi target in the long term tests. Set the maximum
latency threshold to 100us.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/kernel_6_6.yml          | 13 -------------
 ci/kernel_6_6_physical.yml | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
index e9efe20..59e9704 100644
--- a/ci/kernel_6_6.yml
+++ b/ci/kernel_6_6.yml
@@ -50,16 +50,3 @@ lava-test-6.6:qemu-arm64:
   extends: .lava-test:qemu-arm64
   variables:
     KERNEL_VERSION: "6.6"
-
-build-6.6:x86-64-efi:
-  extends: .build:x86-64-efi
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:x86-64-efi:
-  needs: [ "build-6.6:x86-64-efi" ]
-  extends: .lava-test:x86-64-efi
-  variables:
-    KERNEL_VERSION: "6.6"
diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
index e57eea0..2693907 100644
--- a/ci/kernel_6_6_physical.yml
+++ b/ci/kernel_6_6_physical.yml
@@ -36,3 +36,17 @@ lava-test-6.6:beagle-bone-black:
   variables:
     KERNEL_VERSION: "6.6"
     TEST_MAXIMUM_LATENCY: 150
+
+build-6.6:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
+    KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.6:x86-64-efi:
+  needs: [ "build-6.6:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    KERNEL_VERSION: "6.6"
+    TEST_MAXIMUM_LATENCY: 100
-- 
2.40.1

