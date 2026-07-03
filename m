Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02F3D25D0
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081779; cv=fail; b=d0N8aSEdReBFXAga7XRYmqiUo4HRLa4CKT+MAHHKyT96A2GkuWn83DV6PbjoxTTMecO7luk/Qm4Qv/lAMsM2wGMPJdelWwwWGxQ9CvwWtsG5WsjKjd40jpa220yFuDcYeZnYduifqdx1XG7KBbv3Uvy8R8h4+3rCLxcMQR4WGgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081779; c=relaxed/simple;
	bh=rNnOmWoGuqMTsHQu6+hNoguE/A2wpnu+EVW/WZBsRjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnbqaQ+nZvwSoF/o7D5T//g1i/bcHI8LbBsMWRqbu9gq12q+WiC0tgCqGWTKZq6HDEYaByOQp4n/H2nZa9806nzKxBdShs5ics2ueBAKsSkvjJYzWeYhvQafrXlod40DA8WR+2P4H3z+gYWWC0gyiR6uAPSqXAGhUnwczgb7p24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HwsBZcbE; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HwsBZcbE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os2tUKEWhRTsysHCKhmGnDEwccRbSxJO7A+sl9Bw0jC5bKTzCrNE0ITmTw+GHxK7lnWvSEw05beuJnVbPV3+vodL7Uyljr0f3HZdo5+BIL5njLon/DrjOmwkE+cj1Sm3YmKs+AApHxD6j+JCjI03IDAlvKS3fZR4H4v1+KonYtbdAgHzn/1Za97gAdPmi8FtbDZ5nIsmLy+TT81Ls4LNzxl8dN8Wrw4OWkt+Sfs0FQkFw/xPgyZy6E7Pl7iFHUmIR6Qqk3hQmnqCzfA7jYsQQbGsWiSP8Kh+wCml14K0CkOmhGVsm4LIe3zKLvcTo40tdtLdAbewmVwoyVekhfJO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCWfydtwypq8kugXALkQuZkwhgrmkJJ8hKyqIimpapY=;
 b=vf0qaipgggmulmqXyjiyG8A7AdrPj5W5jjquA26yAnYCfZtv1p61/0l3NR7okGp13tY0b599bDt5Vl6LnBIDJDs8ESW6xwcKXMmyw1Bl9NCX1TKcA/otCJoLYr282iaNSGSkzch8qjT+wKkcqKBK3bqo8SXsCzOGXad+VA43o7e2gjKCwg7u0sRCcyGUzohzo4jWw+L3z83h28eO2/jbyLN20oRI4pFGk90a2Pyob7mQt66MOU/2YYfGayMwyJV+15KRxkGe12utYcSTGw76Yge/rqWB79mFL7GkDU6rKEJja/tpLAgPkvbMUgsWv9dBzInh1Wz3R3/9CbJ+YaXk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCWfydtwypq8kugXALkQuZkwhgrmkJJ8hKyqIimpapY=;
 b=HwsBZcbEvI5WPR0Wv5FLs6FriqV9wsGo2FU06OmgSgpKB62ppaFhpJBZyoYO58wIiQ0Xx1MJFovyv9LLmfln9cGgqPSeeCgrW83+JdoiAsTVmXli4AbtJ6hbTFF5b3jijHUZtH4r609pPHGbfpOeKQnxODEApgKwYe6yPI5KldWj9gVODlv8ackp89oELBBjdt0VlxyBPsTnYwK32VMvm+Gp9gx4EqaJSh6uj3m5/A1gZimT8po+Svxm4TTeIEQuooDlqwOGsuPo6WX3h1+JPBX8Rrg35O/OmPY74sKVKeEectWJlNCytW/n8QD3ZTBMjLAY8oQweilS5TIF47arXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PR3PR10MB4093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 12:29:34 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 12:29:34 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl 1/4] evl-test: add stress command support for background load testing
Date: Fri,  3 Jul 2026 14:29:21 +0200
Message-ID: <20260703122924.30212-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703122924.30212-1-tobias.schaffner@siemens.com>
References: <20260703122924.30212-1-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PR3PR10MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: d8de9bc1-37a1-4485-c39f-08ded8febd37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|11063799006|56012099006|3023799007|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BiTdChGseI3xhTZYySWxAx40zbNI1A64bEZujJX/xXBYmSTAx52IjEbYHqux6fg/38T9O1GL4AYhJetKLKVUVI/ixRYGy97T4auy94XTFWm/gV0Ib/L2joK3qzy3sWvmRmnnbQJQwMbRJApQCBI95g0RVASJ2xC/L+TjROaf2/V44mhNOYn6C/CG+AVFewdud6h2eAcMnj9pl97uEQ/r1WIDOxXoCWnN4QECRm/egEN3T3WIEK66febyxJF0KfsZzpF0aenoRlkOLybEJgcDf1Tp1be0M1var/bFA4K1dNNv/XC68e5pSilPpvs9/bNMFdSGRd3UjTr4vONW917eR40R+7I0OVdBuTM1/ZHoNEmTttkZAHZN8gmY+1EUYBtkhLTB0SGt+fMt+Y0vTq2vAAPnWy3lecSurUMCG3xgy7kvaNqwHIzH/04yG0wf47SZ11t4AAnvyPwq2iuLS7NeG9m/SwlQ18mFljbayT1jldGQuV31h+dMfZATd/f/8WKIiqZCQ+fkBcbdfEw9iFjMKKsLMULBzgkrEEV0rJ9bg9Q1aTsNMO91nBqy9WdMMN+l2/oY/jE+DJ+UhTnxtpUnR4v1ANeuPEQwP0xQB0JeJA6qM0dZhF/CzRlD26bRAqCZNtSVLFz2kKB5C208PBaEuPlWYI5BJxazRQKsTzbwVrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(11063799006)(56012099006)(3023799007)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2Jaqv416xKcD/d6X3ZWPZC6EBmf+cOzxrseDH3gxwCWmDZ8GglybHNkunxC?=
 =?us-ascii?Q?9dGXxXqTybA2poZItQrrrTjkXcVXRlbNNSEv0Ij23o0Zr5hkl3uKrEgLt40w?=
 =?us-ascii?Q?S9DzakL6R8xIIazJcmSu7xz2A/3fXIPSjjAptJ9ZSlsNOT+j2kC/7A4TUktF?=
 =?us-ascii?Q?ccmK1CFZuZXgGPnWiDQAZy2UEPwBYir3Xa+Ls1X9Kz8kLUqaybGk23lpRJeS?=
 =?us-ascii?Q?LlM0+wGQ8IctYmN6jwGkeYJ6wCT2mWcgMvG+wfeeCuiM1YY3zuvpVgsvbvRU?=
 =?us-ascii?Q?dZvnoCRlMl1XSNLnfSx+cOaOVBUpdaQso6EZ4e4n97/+6WVVgZaTwv4w6HD/?=
 =?us-ascii?Q?cioqY+crGWt1bXtZqyX2Noy+E4+U43ak08ow7F7okC342mJeJNPTFowQd082?=
 =?us-ascii?Q?TYb3DZpOe6Y8yzSkHDUG65DgjXJ59/DXB5mTbgkwO5m3yt6cIpQmkZGzhfpz?=
 =?us-ascii?Q?iivb4iv93x0Odb2+Ac9W8EVpMSSuXM/dy8DWS4cGdI9rjFL4mdNClrWjH+rp?=
 =?us-ascii?Q?gOBrvGsc+CEFevXzEiR+d6GvbUlq5NbF2pgJaz4SYtUZwoRqEDfrxnlKBgjt?=
 =?us-ascii?Q?Xve/ai0nPUNAT5dvWz9c67QTJE+WhEdJKxVUPTcbOdkJcVEqNsYhA7/P2Ol1?=
 =?us-ascii?Q?fUXEVNh2sVeThzJL5ZAAJTQDnyE5l6Y4ymIOvT9jhG8t35JQfDEyxCWpZglq?=
 =?us-ascii?Q?fqhMcpTFuR7hTZsCXdz0cjdujULol3V87EcVZlHt4QCGQa1LNke/FRxYY+en?=
 =?us-ascii?Q?Lw2dgoqElvS8Sm3uE/6MJHn2fm8eN47SBhyN/NS4IEah1XoYxR2hs+rh89Rb?=
 =?us-ascii?Q?OfCspBDJLTSV54rcIuuL2kiDy9ckB+DJVMvm+hmJxq0Wwif5Uv1omvcjDJsM?=
 =?us-ascii?Q?HyWFvUelSkEfwBi9/03pgRP6KRKFRch3aSYxQK6S/G239RM+LI6A09xNcnta?=
 =?us-ascii?Q?3Lt81hINRe3GlPhY3dGWywBEof9nKG5ESEGkXVKTT4bMODNvwaMqmAZP1Qh5?=
 =?us-ascii?Q?XgjbVv1vfR5Ose9x8IgNG34FW8zIOTQzyNmUpzb59vb9LcSGPlRjFzog2cS/?=
 =?us-ascii?Q?gElXPB1MnSSBV50/TC1RF3fkZwOn2TYkh/alUIlAcpXasLumQVC1/TofpyCW?=
 =?us-ascii?Q?vPTd1RB3fYsIa56EKwULG2gCoXavLCDiJVZ32GO0PcIfwxPVEvq534yEcK80?=
 =?us-ascii?Q?VrLtBHika3W8DKwOBAlpLLs4feg/lKiDI+OP3q6gHjAraU8EgoqhgrZr/aD6?=
 =?us-ascii?Q?+um96P/Yl0Iu5ZWpfIMJ+RP/4Pjisf5kEi1yvHoS404qrC2P+esbN780r0Bc?=
 =?us-ascii?Q?ida++ExL7cJbFq00kb6QE5X4b0AY5ljI7WhRX/NqfJHoR8eL7DMIi6Qv6T1i?=
 =?us-ascii?Q?m9/thfa9uVwhRNDx5w1O+OmDG6qEgn5ueHuOdkJIPLFulJnn1sGeYMYXrl/9?=
 =?us-ascii?Q?8OCttknz2/z6sLe6uY1FbNzEdsoMepeAJ//v6OvS73KPEB5S0YB3nAmSFyiZ?=
 =?us-ascii?Q?ETUSFLDkOq4qWjf4P53mvnrlWIaXuUVtF/bu+oENv6nhTjWovn2mGP8xiofy?=
 =?us-ascii?Q?W6GfdTgb13lDQEF7NrCijCb9YbQqbEbgZw+QbWvm+eHT7ENQa695Bx9pdxxN?=
 =?us-ascii?Q?mBjp0TS0Zs+sAu+ouBU94GSyN0iKnfoCOzCgU13lQHui+2+ztJPJoXJEQsCR?=
 =?us-ascii?Q?6jIjTYwcR4zNy08ycxmE1+aNMJ40AkodRRTlPxHm8VRxZbXmLHLJK9rP+6pC?=
 =?us-ascii?Q?XloRRNQJGFfsMwXx9/oXt+yBSLAl8LBZ2jNMuAlffd756iwbTQbmm0fXdNKE?=
X-MS-Exchange-AntiSpam-MessageData-1: SHuH6VGu9ZYAzMsu6+9Sro58hVoVF6/6lHY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8de9bc1-37a1-4485-c39f-08ded8febd37
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:29:34.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBlgw739xbg9r+pn8Exqz5HvTKbxivOkaFAuwz1ufLULHWz7fRMPt2N5SNV0Rd3AMEGKlkCIMUXxWMFcIkg2YeDCn9qsnfpx2sxg7MOM2vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4093

Add the ability to run a stress command (e.g. stress-ng) in the
background during test execution via the new -s option. This allows
testing EVL functionality under system load.

The stress command runs in its own process group (via setsid) to ensure
clean termination of all child processes, and is automatically stopped
when tests complete or the script exits normally or via signals.

The stress command output is dropped by default but can be redirected
using the --stress-out option.

Usage example:
  evl-test --stress-cmd "stress-ng --vm 2 --vm-bytes 1G --cpu 4" -k

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/utils/evl-test b/utils/evl-test
index fa3ef73..eb7deb1 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -7,7 +7,7 @@ if test \! -d $EVL_TESTDIR; then
 fi
 
 usage() {
-   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h] [test-list]"
+   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h][--stress-cmd cmd][--stress-out file] [test-list]"
 }
 
 help=false
@@ -18,6 +18,9 @@ full_path=false
 test_args=false
 test_arg_list=
 test_list=
+stress_cmd=
+stress_pid=
+stress_out=/dev/null
 
 while test $# -gt 0
 do
@@ -37,6 +40,10 @@ do
 	    -L) full_path=true;
 		do_list=true;
 		shift;;
+	    --stress-cmd) stress_cmd="$2";
+		shift 2;;
+	    --stress-out) stress_out="$2";
+		shift 2;;
 	    --) test_args=true
 		shift;;
 	    -@) echo "run the EVL tests"
@@ -49,6 +56,27 @@ do
     fi
 done
 
+stop_stress() {
+    trap - EXIT INT TERM
+    if test -n "$stress_pid"; then
+        kill -TERM -$stress_pid 2>/dev/null
+        # Give the process up to one second to terminate gracefully
+        for i in $(seq 10); do kill -0 -$stress_pid 2>/dev/null || break; sleep 0.1; done
+        kill -KILL -$stress_pid 2>/dev/null
+        wait $stress_pid 2>/dev/null
+    fi
+    exit
+}
+
+start_stress() {
+    if test -n "$stress_cmd"; then
+        trap 'stop_stress' EXIT INT TERM
+        setsid $stress_cmd </dev/null >"$stress_out" &
+        stress_pid=$!
+        sleep 1 # Give stress command time to start
+    fi
+}
+
 if test x$help = xtrue; then
    usage $0
    exit 0
@@ -78,6 +106,8 @@ if test x$do_list = xtrue; then
    exit 0
 fi
 
+start_stress
+
 result=0
 
 while : ; do
-- 
2.43.0

