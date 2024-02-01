Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117B84FA6
	for <xenomai@lists.linux.dev>; Thu,  1 Feb 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812496; cv=fail; b=CvcwFmF6Apo0TiR94QUeJonS4I6rF2XlEWdyt7BXUoikMAgj6DJIV9KGHgxL/czDp6Nkaca78zFUR+2TxhecusmU7FpkR2Y/ccdgFnz1f8R+5zHoX4zUPeuqr2XFQIJTv+I0dk34Tv9Ee57WbHv7iap++pBVBH00pvbUw/jB4Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812496; c=relaxed/simple;
	bh=QsO4qG+TvgH0MYD9xpvui6O98/5C0h0FT+VB2LPUZ/k=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=me8Do3YU92BJ395jQWV2FFNr3KPVfxD6oFEmMHeIUedIkIBdog0Jk71fByXmRu/ynz0nhzYR72SQX4S+q0cxUpO1inkHYuTexlkL2pO07ZL5Fhm78nFaY/2f5vFUETlumrcDSYpz7O3y7K4BKBFkWb7YtJLGjovpWi22gj46/zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rK0YVq8T; arc=fail smtp.client-ip=40.107.105.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rK0YVq8T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNTOHaTpUkyDREuClx/Z/NCdEPS9zN5lUI3sWyJpJ5id7SpFeO89RjtS0cmfJxOucl4WNWbxh6RKj1bheQcXJi05VWcZi3hRGTHxuhgvyU55IBMZRJLRsKcOpxe+dehFsHwbaTEK3GiLWcvidUB+2Td/ee3FJhdCJ2076bwFQXx+RtmOWSo2Cepn5hUyqhu62duTccC1t3mYvpuEx7jQPMUSWEynJmKpfwFzJEPRSYSVmU7IG83szYWkd53HJfdd6gyTqV1Pw556lcuHuauVzq+hhahtF3jN6yUhnp0ql0Khq26ZzCxDoF9a6FPsL4zlkZ4nEF2QKOb90cb7TpI22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKrEaOdmsATu5Q3+yNibGQiWF8kD/mRRyg3PMEhzf/0=;
 b=gTvTiWQtGUg6Jew0g5bIgNsfmkzW+wFCUPvZRY+KzCgFyrUDFgv+DLTCLcSXCp7WLVyur2DqOKSoWCODFdzuSwnFNAAdR4EUhVD39Aa1MUKkxl4xkZTmbyP4lsEP0SNuXcMPd9+o5/7mMwi2nI2BO4zTtNDJyQ9b3hIYLdZnk/fsq6EifNwhLVtLJ5UQ1BLFd0ngSFZZ29SXynESnRke2V8V9gvEeXcuFhPm5WCzssLiUmhG+PTgCfNlfu94ltrDQ8hb2C1UWItso1SIVIk5fPsMcVwgw0R+VWqEltAaJpV05ybMymg2x5z47H50c56MWrkoi0l/1mUZ8Il7GQ8jIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKrEaOdmsATu5Q3+yNibGQiWF8kD/mRRyg3PMEhzf/0=;
 b=rK0YVq8T988Xzoz7guTgxe48uGynN18fQvd44A6K3GoLGwHHSnoRfy8Q3fmHlhgWaeqlH3Vten2ecpSb6AJwe/9++xhCzt4hsn1yYtbG/fKQrBUT+scuSXx3bs8naPzX/IKCZXgRMBk94OXK3iRP8g/0uusLIMVjmE7JFxkKOsEMO0pa2fz9kZmRqntxYFlIfbg6SG9olve3oorjhsEX7LRj6G9t6bLo1fjvKypK+Dq/HcMvUTEpPMF0sm6c66mTh4x4wOriYmr1e2nx2c4tSxNn5OAxOz0w8QIO2ZwPuk7AJ7nPhYGEx+L1V3ZAzPrj7UfdpCwCFmijbCCDCDGzWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5512.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 18:34:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 18:34:49 +0000
Message-ID: <b0ac1666-2aa9-4b1e-9b2b-fe7db1d11e08@siemens.com>
Date: Thu, 1 Feb 2024 19:34:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update Isar revision
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: d6718799-b3b3-4f73-b0cd-08dc235478cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LEP716zNArOn7bJTu3i/XwuV1cX3qmDBuGAf/3WZeX/rSuOnI0ter4LJOrZPa8PcGR+9Bt4wPWm5Upta7Iv8rt6gpoNROeipnynJ+RRpAHrQAU8T1PrzKQ7LT5pYuOmUHKESWjN2yLYsv1yO0QSuXwNNTMpe5nSNhDShTroyQZ8rFGtZbMDDtBoNne/Bw/BRmhV6OJe6NA1gofeioZuhimXWkd1NcQ7qRbmmUBlMkNUxH48XU6aqGRKGfUkI0r1RY8P9ddkjH3q4t5bwWnktv9uCoUYKzYpgN/Fwy+rviK+0xIIwQcaEME4hQl+P4vXPtzduvJB+zbtjSziMfM0BRtRe0NzbzJI1vVHyJU6D21zfEx2LnEiQ3fqrR16jWaEV0jlAH9G/12MY2XbQdZnxO/KrA2nVvGizXDfKT08qmr+VicCLAKl4wG9gAc84muPwu1SHaGbHp0SCp1co0T999OONWNcpRYSohyq5E4LVRqdknzGTOcU8eBoTcvGvkdax3ZswDAPgtlWrUzI7M40vnmeR2Ak9+yYofbmIPngqfuIAzFUc8zg9NIM/Vrw3ZMOwAyxL6X6D+KVup5N0gTOvfuLWViQZMg8PJwVXvmNRapnQ6/L+qdn+eVX/5FxOPRX2vRX/mhEee+M2RkJkvuvgWkMeznedombFoLBHnh11okE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(41300700001)(966005)(6486002)(38100700002)(83380400001)(31686004)(82960400001)(26005)(6666004)(6512007)(6506007)(6916009)(316002)(36756003)(44832011)(8676002)(15650500001)(8936002)(66946007)(66556008)(86362001)(66476007)(5660300002)(31696002)(2616005)(2906002)(45980500001)(43740500002)(360504008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHIyWXlxWDJub09IRHB3cENvVU4rcTBRbnVpMFBkWDRjTkt3WjlHb2RkcFVi?=
 =?utf-8?B?Tmt2c2hweWI5WlhCdmFXZWREWWZYUFU5MFlreElCV0ZGKzdjcVVRQ0Q4dGFY?=
 =?utf-8?B?dUd2a01leFlWVlZyTWR5YXlnbTdTeHU5amNKUVQzWWV2Rk5oZCt1NXQ3WkhQ?=
 =?utf-8?B?Yk9JbklKWXVEVkVoVm03aitOS1dKRWFMNG5obUZ6aDdrMTZVMXZBYnllc0Nh?=
 =?utf-8?B?aks4eFlmSHBTNEdEekhDeEJOU3U0Qm5nS2dIUGIrd0E1cjlZUHRJd2d0aTJr?=
 =?utf-8?B?ZnBsZWNxTGl6ZkdMSXlJb254WlM2UmJicm5mSDZ6NG1vcWI5SEtqdThRVlQy?=
 =?utf-8?B?ZmxkRHVVMnBVWUZObXdBNzFHNkZocWtDWm55Z1hhMHVQSVp3cmxVT01UMkJk?=
 =?utf-8?B?djRHeHFuU0VEeUdtUHZ6UWQ3dFdvQTFIOUxzTmk4emczSWZtQ1IvTzZqMlBt?=
 =?utf-8?B?YmZMcWRNcXdPMjd5QkhockY5aVprSjFzc2JsbEZlNzhmRW1uVXpMcStkU25Q?=
 =?utf-8?B?dWhha0JxSy9hdDUwMEZ0YjBQOTB4OVloQkpYWmJ5ZVorek5QMm92L2lwTlJD?=
 =?utf-8?B?SmFMeDVpQXVlWkRBL3VDTVZaKy9tMGNrTDZ3cE9uUXZjVWg5ZERua21Ud2dM?=
 =?utf-8?B?SkZ6Y1JsOWV2dGY1US9wTTFXK2NRUmFRSXFWZXVLWlFWNkVqUGp1RGh0SW56?=
 =?utf-8?B?djllZjJDRnBPQTBUWmhrWkpyVVZNTzN4RTYvL2czY3RiTTNhbWZlTDlmL1FV?=
 =?utf-8?B?VWlRdVNEVXZYYnkxY2ZKbXNtK2tiVDlOQjBtdzhDdy9ENTlIdWRoVXNOci94?=
 =?utf-8?B?UVl4YnF4a0RpSkxFbFBtK0hGRVVWWm83UEVQbVRlVENyTGtmVVU3b0RpT1N3?=
 =?utf-8?B?eldCNXVVREdmL3FEeEE5cnE3Mk1LZ2t5KzFUVTBkUUg2Y3UxZkhrK0RqM090?=
 =?utf-8?B?Q3Nxb3hZWkZPTXlFZ3UxbXE1Q3FjemRkYm4zWm55dTllNWhnLytpbENkV1JX?=
 =?utf-8?B?b3BESXNmLytPeElMS2JQQ0pBUktOTGg3OTF5cnZHK01wSnYrTk50bW1Calht?=
 =?utf-8?B?Uy93RUE0ZHEyYWVZNU1valplc2czMm00OGgyRXVPQ2JJb0cwaU9UQWduVXlB?=
 =?utf-8?B?S1FYb3dBSlRjSUFRUUVFZEFuSngwVVdDNnMzZWZvOTlBelVjM1FQR1VOTXBi?=
 =?utf-8?B?elBIK25NQm92UjhWOEhsVTkzYmtsK3YzUlpSS0E5dHc5YlBnZXBnajBVbDVC?=
 =?utf-8?B?SVJIdm92ZDBhc1JMYjcxK0taOU1EaTdhUG0vZmZQYm5mR3Z6d1F4cklFdGNF?=
 =?utf-8?B?VStyNWNkb0VHeHVwc05IZVozZlJPR0xYc0VFcVBnckVHZm1QREFoL0JuRGZS?=
 =?utf-8?B?Szk2K3FuY3ZieXhFOHJTWmFGN3dndkpBYWdZK0pINnJJVEpoSlNqV09rNktm?=
 =?utf-8?B?T2RmK3FxTWZPMEVWOGJWUXVwbnVDa2xwK2k5U2lMSTlLNVlMS1l6SVE2VzN3?=
 =?utf-8?B?eFp5SXhXUnFoZkduVWpIYlI2WkRWYTBuWWZJRFBVcFZ4L0s2UnF4Z29GaG9v?=
 =?utf-8?B?aGhTeC9BT1ZXZzNtNXlENEdPbGN4WXJ2UXdxSXExTFVQb3ByWnptYzhHMEhU?=
 =?utf-8?B?SzI4VVJQQ3psZ0phdXRzSmZmRXpsU3QyM1QybVExcjRvM3hmUmxVYnpTajN6?=
 =?utf-8?B?bUZXTlBOZjhraGlBdXNsWi9yL3BKMzd6MWoyOTV3U2lhc1ZMbUVFajU0NXkx?=
 =?utf-8?B?eE5LdUwvTm02S2k0UHpNOGNqTi84VXU2Z3hraTBaQVVhWWl5LzQwUWw2cWFx?=
 =?utf-8?B?SzQ3cEdFcG1ocnd5K0Y2VjlnM0lBUW4yRVdENWZ0dFh1TURxVHNZU3BYT0Jw?=
 =?utf-8?B?eEpFcVRUekNaSUZsbW9kS1p3TExVeGIrN3pubVRYd0RleXJlZ0c0WnI0anY5?=
 =?utf-8?B?ZnFmSk9wcFIxN2RXT1RiWGpqYlIrZXcrMXJVa3ZwdTFqenNXcExyQkwyb3VW?=
 =?utf-8?B?eXFhNjVsemRhUmp6ZDR6S1R6UjY5Qzg3LzV6Um1Ia3N6OVFXZ1JlOHEzbjU4?=
 =?utf-8?B?Q2xZVzBlaHFTVzh3czduQVR2cVpkd0pVMHQ5ZmNMdnFKaHEyVzZGYkFXSWFR?=
 =?utf-8?B?YVZtSEJMSkd3Wmo3dFFHeFd6Yzd5VEhqejRnMHIvSUMrbzBGekVrYTR1dThJ?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6718799-b3b3-4f73-b0cd-08dc235478cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 18:34:49.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ls+QvpE7CKRAy6tq1Iv7P3Wod7aSAFmT7y7WklmfB65ENAIYNofVEbC7vyjWqf+pW10zA+zfGNDfOe2qRHWn0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5512

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop our own patch again.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...port-for-replacing-pre-installed-pac.patch | 168 ------------------
 kas.yml                                       |   6 +-
 2 files changed, 1 insertion(+), 173 deletions(-)
 delete mode 100644 isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch

diff --git a/isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch b/isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch
deleted file mode 100644
index 3132f06..0000000
--- a/isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch
+++ /dev/null
@@ -1,168 +0,0 @@
-From d65b5f67405dcc83044008e589fa9ff98604d0e6 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Sun, 17 Dec 2023 17:27:01 +0100
-Subject: [PATCH] dpkg: Restore support for replacing pre-installed packages in
- sbuild-chroot
-
-During the migration to sbuild, support for using self-built packages in
-the build environment was lost if those were already part of the
-sbuild-chroot. This restores it by adding --apt-distupgrade to the
-sbuild call. But that is not enough because sbuild will only upgrade
-packages from already configured sources, not those specified via
---extra-repository. We therefore have to switch back to configuring
-isar-apt during sbuild-chroot creation.
-
-As rootfs_configure_isar_apt configures the isar repo under
-/isar-apt, we bind-mount the one in /home/builder/${PN} to that folder.
-Another difference is that we now need to run apt-get update explicitly,
-but only for isar-apt.
-
-And because the sbuild-chroots are now left behind with isar-apt
-configured, the configuration in imager_run can be removed (credits to
-Srinuvasan Arjunan).
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/classes/dpkg-base.bbclass                | 27 ++++++++++---------
- meta/classes/dpkg.bbclass                     |  5 ++--
- meta/classes/image-tools-extension.bbclass    | 13 ---------
- .../sbuild-chroot/sbuild-chroot.inc           |  2 --
- 4 files changed, 18 insertions(+), 29 deletions(-)
-
-diff --git a/meta/classes/dpkg-base.bbclass b/meta/classes/dpkg-base.bbclass
-index 7b054d3f..52baf169 100644
---- a/meta/classes/dpkg-base.bbclass
-+++ b/meta/classes/dpkg-base.bbclass
-@@ -19,8 +19,6 @@ DEPENDS:append:riscv64 = "${@' crossbuild-essential-riscv64' if d.getVar('ISAR_C
- DEB_BUILD_PROFILES ?= ""
- DEB_BUILD_OPTIONS ?= ""
- 
--ISAR_APT_REPO ?= "deb [trusted=yes] file:///home/builder/${PN}/isar-apt/${DISTRO}-${DISTRO_ARCH}/apt/${DISTRO} ${DEBDISTRONAME} main"
--
- python do_adjust_git() {
-     import subprocess
- 
-@@ -221,8 +219,17 @@ def isar_export_build_settings(d):
-     os.environ['DEB_BUILD_OPTIONS']  = isar_deb_build_options(d)
-     os.environ['DEB_BUILD_PROFILES'] = isar_deb_build_profiles(d)
- 
-+dpkg_schroot_create_configs() {
-+    schroot_create_configs
-+    sudo -s <<'EOSUDO'
-+        sbuild_fstab="${SBUILD_CONF_DIR}/fstab"
-+        fstab_isarapt="${WORKDIR}/isar-apt/${DISTRO}-${DISTRO_ARCH}/apt/${DISTRO} /isar-apt none rw,bind 0 0"
-+        grep -qxF "${fstab_isarapt}" ${sbuild_fstab} || echo "${fstab_isarapt}" >> ${sbuild_fstab}
-+EOSUDO
-+}
-+
- python do_dpkg_build() {
--    bb.build.exec_func('schroot_create_configs', d)
-+    bb.build.exec_func('dpkg_schroot_create_configs', d)
-     try:
-         bb.build.exec_func("dpkg_runbuild", d)
-     finally:
-@@ -288,7 +295,7 @@ do_deploy_deb[lockfiles] = "${REPO_ISAR_DIR}/isar.lock"
- do_deploy_deb[dirs] = "${S}"
- 
- python do_devshell() {
--    bb.build.exec_func('schroot_create_configs', d)
-+    bb.build.exec_func('dpkg_schroot_create_configs', d)
- 
-     isar_export_proxies(d)
-     isar_export_ccache(d)
-@@ -297,11 +304,9 @@ python do_devshell() {
-         bb.build.exec_func('schroot_configure_ccache', d)
- 
-     schroot = d.getVar('SBUILD_CHROOT')
--    isar_apt = d.getVar('ISAR_APT_REPO')
-     pkg_arch = d.getVar('PACKAGE_ARCH')
-     build_arch = d.getVar('BUILD_ARCH')
-     pp_pps = os.path.join(d.getVar('PP'), d.getVar('PPS'))
--    debdistroname = d.getVar('DEBDISTRONAME')
- 
-     install_deps = ":" if d.getVar('BB_CURRENTTASK') == "devshell_nodeps" else f"mk-build-deps -i \
-         --host-arch {pkg_arch} --build-arch {build_arch}  \
-@@ -310,15 +315,13 @@ python do_devshell() {
- 
-     termcmd = "schroot -d / -c {0} -u root -- sh -c ' \
-         cd {1}; \
--        echo {2} > /etc/apt/sources.list.d/isar_apt.list; \
--        echo \"Package: *\nPin: release n={3}\nPin-Priority: 1000\" > /etc/apt/preferences.d/isar-apt; \
--        echo \"APT::Get::allow-downgrades 1;\" > /etc/apt/apt.conf.d/50isar-apt; \
--        apt-get -y -q update; \
--        {4}; \
-+        apt-get -y -q update -o Dir::Etc::SourceList=\"sources.list.d/isar-apt.list\" -o Dir::Etc::SourceParts=\"-\" -o APT::Get::List-Cleanup=\"0\"; \
-+        apt-get -y upgrade; \
-+        {2}; \
-         export PATH=$PATH_PREPEND:$PATH; \
-         $SHELL -i \
-     '"
--    oe_terminal(termcmd.format(schroot, pp_pps, isar_apt, debdistroname, install_deps), "Isar devshell", d)
-+    oe_terminal(termcmd.format(schroot, pp_pps, install_deps), "Isar devshell", d)
- 
-     bb.build.exec_func('schroot_delete_configs', d)
- }
-diff --git a/meta/classes/dpkg.bbclass b/meta/classes/dpkg.bbclass
-index 1d684e98..0cdb5792 100644
---- a/meta/classes/dpkg.bbclass
-+++ b/meta/classes/dpkg.bbclass
-@@ -110,16 +110,17 @@ dpkg_runbuild() {
-     DEB_SOURCE_NAME=$(dpkg-parsechangelog --show-field Source --file ${WORKDIR}/${PPS}/debian/changelog)
-     DSC_FILE=$(find ${WORKDIR} -name "${DEB_SOURCE_NAME}*.dsc" -maxdepth 1 -print)
- 
--    sbuild -A -n -c ${SBUILD_CHROOT} --extra-repository="${ISAR_APT_REPO}" \
-+    sbuild -A -n -c ${SBUILD_CHROOT} \
-         --host=${PACKAGE_ARCH} --build=${BUILD_ARCH} ${profiles} \
-         --no-run-lintian --no-run-piuparts --no-run-autopkgtest --resolve-alternatives \
-         --bd-uninstallable-explainer=apt \
--        --no-apt-update \
-+        --no-apt-update --apt-distupgrade \
-         --chroot-setup-commands="echo \"Package: *\nPin: release n=${DEBDISTRONAME}\nPin-Priority: 1000\" > /etc/apt/preferences.d/isar-apt" \
-         --chroot-setup-commands="echo \"APT::Get::allow-downgrades 1;\" > /etc/apt/apt.conf.d/50isar-apt" \
-         --chroot-setup-commands="rm -f /var/log/dpkg.log" \
-         --chroot-setup-commands="mkdir -p ${deb_dir}" \
-         --chroot-setup-commands="ln -sf ${ext_deb_dir}/*.deb -t ${deb_dir}/" \
-+        --chroot-setup-commands="apt-get update -o Dir::Etc::SourceList=\"sources.list.d/isar-apt.list\" -o Dir::Etc::SourceParts=\"-\" -o APT::Get::List-Cleanup=\"0\"" \
-         --finished-build-commands="rm -f ${deb_dir}/sbuild-build-depends-main-dummy_*.deb" \
-         --finished-build-commands="[ -z "$(find ${deb_dir} -maxdepth 1 -name '*.deb' -print -quit)" ] || cp ${CP_FLAGS} ${deb_dir}/*.deb -t ${ext_deb_dir}/" \
-         --finished-build-commands="cp /var/log/dpkg.log ${ext_root}/dpkg_partial.log" \
-diff --git a/meta/classes/image-tools-extension.bbclass b/meta/classes/image-tools-extension.bbclass
-index 58799fcf..46bdf78b 100644
---- a/meta/classes/image-tools-extension.bbclass
-+++ b/meta/classes/image-tools-extension.bbclass
-@@ -44,19 +44,6 @@ imager_run() {
-             distro="${HOST_BASE_DISTRO}-${BASE_DISTRO_CODENAME}"
-         fi
- 
--        # prepare isar-apt
--        schroot -r -c ${session_id} -d / -u root -- sh -c " \
--            mkdir -p '/etc/apt/sources.list.d'
--            echo 'deb [trusted=yes] file:///isar-apt ${DEBDISTRONAME} main' > \
--                '/etc/apt/sources.list.d/isar-apt.list'
--
--            mkdir -p '/etc/apt/preferences.d'
--            cat << EOF > '/etc/apt/preferences.d/isar-apt'
--Package: *
--Pin: release n=${DEBDISTRONAME}
--Pin-Priority: 1000
--EOF"
--
-         E="${@ isar_export_proxies(d)}"
-         deb_dl_dir_import ${schroot_dir} ${distro}
-         schroot -r -c ${session_id} -d / -u root -- sh -c " \
-diff --git a/meta/recipes-devtools/sbuild-chroot/sbuild-chroot.inc b/meta/recipes-devtools/sbuild-chroot/sbuild-chroot.inc
-index 39ced80b..2f07de82 100644
---- a/meta/recipes-devtools/sbuild-chroot/sbuild-chroot.inc
-+++ b/meta/recipes-devtools/sbuild-chroot/sbuild-chroot.inc
-@@ -56,8 +56,6 @@ SBUILD_CHROOT_DIR = "${WORKDIR}/rootfs"
- ROOTFSDIR = "${SBUILD_CHROOT_DIR}"
- ROOTFS_PACKAGES = "${SBUILD_CHROOT_PREINSTALL}"
- 
--# We don't need /etc/apt/sources.list.d/isar-apt.list' while it's handled by sbuild
--ROOTFS_CONFIGURE_COMMAND:remove = "rootfs_configure_isar_apt"
- ROOTFS_POSTPROCESS_COMMAND:remove = "rootfs_cleanup_isar_apt"
- 
- # Do not cleanup base-apt
--- 
-2.35.3
-
diff --git a/kas.yml b/kas.yml
index 2017e68..e63bf3f 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,13 +22,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 853784cf1732c093acd537fbb1b0b1c54e6b59ff
+    commit: 962a4ee24854db8b3cf0ff2499e26705f54808ad
     layers:
       meta:
-    patches:
-      01:
-        repo: xenomai
-        path: isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch
 
 bblayers_conf_header:
   standard: |
-- 
2.35.3
