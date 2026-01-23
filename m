Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F520325715
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175771; cv=fail; b=BiEzBbnlKvCYenwx/q8Wpd5fFxkJ0G5MBNmCMt89YRYsgLmPt8vUpLqKGmEQeSXmMBgl18ixr4dsIqyd2Ch4zvGwk1IttFseHr5fZA2EcrDFhuLhAdQ6kJ41ch0CJvKw0DSxQfv20uHBaiCCcpTOub5lRjcDkEIMf2l857fU1O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175771; c=relaxed/simple;
	bh=6vJqYJSQAZ8XnLtT5ouZzJjxAksOTPtRL0Adr8xCXVg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dXhts+7NeZkKsPtdQoB3H5QV0LFa/F9cl2NWu6UwPnfHq8z0NvERjRNeY3SJuiafsYrcWnvU2CgKLWKXIIDqr0uo0qds7UHLAHzw10JIH5kbYpwdvAWIlHyM9Yfdzv2zu8weV6NqyXUV4Uo2mUMvLPrnAYTvGCghbpynPfPd640=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=g01NBxvI; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="g01NBxvI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul2iVM8kJtoQiXYBXfPsCGtLzB4qEJegRHfzigmC6R0634d8Xtn+gys6WWAiofztIizsWJsGfv/ngYUXDT1Ti8GGZt5rkUlolJsnsX5YeCZxezWrfKzP5IDIOBi7rOQR2+wjbPVPn3LJIJiaD+/V+4DIq/94vuOM4OwUX8l1KOwVfKxCLZWpSpDli4KVnZ433qoFUCd8V0eCGfnvju5ybj+HKUU6dbDfR6eIGaKtikvZjagKUFI3AopfYD/lMQUVicYw+yb8Vhr+nHCVzoULLEEWx/VPyX47IVmo7kyv5uXt/iFQPxg0spPuA7DnyjFP2TibtfC5lpfmGCVxaWBdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh4WvBbVtILwZQ4PMADzLGab50LGjM/SUZTA61yeI7A=;
 b=EN8Z4L4eO5rpEV6LpggzaG5GDrlz/fNSlyhdmjw/XjBY/IqgAq4T6cXFSgicN2RBdR2TWn3U0/F0NzISWci7fZIi/bXsIvxLS5TooqAKvpRmEcrCz9FUUs3Q2vTB7M8KqVSMf4z3teNyqG/bW+A4TRFHJlf/0f01w6iUh1PB+atg1GQ+cbdUfxuJRmJ1fDhIqkD/VmhnKZMl5Aq7JzOF5crm1PKQNs9N/stHmu9SKcqgG8KEvFzZRUqB04TkfjWk8inIeOQ1G8E4SLqsEvdIr59hoJHv8N1hbUQBUCfuq0E9aMYYdnYhoHIueohEXyYS63wB1uD6fjgkKxbK9mHEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh4WvBbVtILwZQ4PMADzLGab50LGjM/SUZTA61yeI7A=;
 b=g01NBxvICVoou/c1XFWcRle3FVYrKbShIPtGsdQQDHF17rW+/NU81Q8b2mMnDBYHfeZJ/3otijx3OqALeC30fSJ4BwnyHc3piUw91n69/bjFIzlCO0hdxXVvS86LnP3US2IY3+dyEQtcNhS8ltlrLbFoHliJTTqryJc3UkHo5mIFbtPZS55FxjDESQ182gIxDHhi7b0LeEGWqoc/oCyyF2dTe+4CyatjvVl0Y3eUnAipBIslb6StBUywEUnwDevfcywlsvoUty+aNPrX2DJq7tz7PT9oQjVIdzHb9jEtS4Yp/hgtAneXQZC4IoUZMStBXhlSoIbsxpE08Ib4+CBsyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB5140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:327::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 13:42:46 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 13:42:46 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl] evl-test: add stress command support for background load testing
Date: Fri, 23 Jan 2026 14:42:37 +0100
Message-ID: <20260123134237.1836169-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c4d518-4061-4fb2-c142-08de5a854a68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBjS5QDiR10uHAkGdu1kzE8D2eWKldavkllDTnhnM6xQwybmV9+DTODXV73M?=
 =?us-ascii?Q?Y8fjfHuEGbfeGrzLKoTfhNVsAaOTrgn0aAqjZTJMkXgIF5Q8TMMjvF2vPtqS?=
 =?us-ascii?Q?3kg5gdep3/pzkAsyONa9UFOBawUgtadUEmLhx8s5bvccLAJSIQR0M4Jy/7bl?=
 =?us-ascii?Q?NNz6air82I/IOvxkLvasRNwijTrv0Ens0kS3h1GktE0NqxF1Lp9jSED+ZRqc?=
 =?us-ascii?Q?ywoFuZ2Qz57Kqp1DIWXzZRNRUVZdk9XEAAqeh2D7SpfTArGbPg1KIQ8yAWy8?=
 =?us-ascii?Q?+RXq21WMTw+VoQQZ3TYU2hMNuuGXNNWkXUmAVQpcKheFMAfkjZpwTdJqhKx7?=
 =?us-ascii?Q?q6z2qLB8Xf878jMQOqWnwRms3FsEBmZGku79US9bYrodPbYmAzejCdWW2Ocv?=
 =?us-ascii?Q?Qk7X6H06DwvTD9qlNbcYKozoqWcCP9AHB65G7IHkj5YcN3DvfNk7bJQdUOU3?=
 =?us-ascii?Q?6Ugvm/KJmbGkLW8yr8bSw5jIbAMvCOnu//gp/D5vIjfq2hfSjtDu+GECKmX3?=
 =?us-ascii?Q?qrnw3AtI/rQbRitGVcHEl76+2ukpg4T96zRNMMMlbVfj67vMhIq5B+prlAA9?=
 =?us-ascii?Q?ZM/qvlubmTiMvJ0jZtHTZk41ky6jo1D9suCjCtT8NREsjn+dHqteAttPwYx+?=
 =?us-ascii?Q?ddlJYFDcta3cZcMjs04ZS7Q3Foj9VZbgD3CBEsy0QO7u4Qu03uGAifx+DQym?=
 =?us-ascii?Q?qayHsgEDbloj3+H7SHWdFs5273G5i3j488A8JavIfbmcJDlMi9YMoUNLThLp?=
 =?us-ascii?Q?RCBW6WIeM5snYQ2tssReV1YK/+VmpiK01pDbcAKndVtZ0aYrnvA7/ScsBtle?=
 =?us-ascii?Q?Sa9tAhAokiF8pOkhrh/dZNqLHKJPNGuZx828Gao2iqTa8n8nhSFGVOBFUnMR?=
 =?us-ascii?Q?H1d9Xjwl1HrBciFRFSSJuKEggQwEVy0dhU7WoEZ/RR0IVu7lf10/jd5IxqIY?=
 =?us-ascii?Q?vXmfmPAAhpZa8QXBzVt1JFbOIDvERAcaQ4N0pdkJA228/AVgAlaSpLuz+o/A?=
 =?us-ascii?Q?6qlYMqU1TRgxAl5e5MKm0kY7wsRXBC7NkB3y8hipRQFXZwAHnt56rQk2yG++?=
 =?us-ascii?Q?rfGjCnOr+dzC5IYTf07xw/dbty7lN33gHpnVlT8QPrF66TEsZ2SqrwogS95b?=
 =?us-ascii?Q?weYrEhVPRtuexOe5Xe6V+ph/4myBPmVNv14/CmdPwCkysdRfdUTKn9i2oDk0?=
 =?us-ascii?Q?sON5DLxZnaxKvm1tJpnvUKF73YJmJsWar0BZBm1l1M8GDlrSNkp+ruWhgSZl?=
 =?us-ascii?Q?ZAf5oe4E4MzU2Imto2hRNHpYiKgmpLxSxGaIWSBMCSOioNYzQrhZ4mXdhvJ5?=
 =?us-ascii?Q?o9MvKDOxU4icsNidcJoCOdaC9yrLhcZedOp0v2J9ODfBPQezFPs0ay6GMbAZ?=
 =?us-ascii?Q?yJtX2gFsSfsmrjhbQ8NYzSm25dmTBuuXztAfNTFUBME3LOmJ+QPfiT3IKlrS?=
 =?us-ascii?Q?P+7VCSABK5mEyTlhN8b4ZfYSyCBewli/diavUQ2vRara4WMK16eJP1Gi7C+6?=
 =?us-ascii?Q?GNf7FcFMwlGEg+uBjrhDrZkkvfajKfcbFuJD7Pmbeg7V/amHxQqucEOCiZ+/?=
 =?us-ascii?Q?TcNa7ZmLhzvg823Ue3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yP0jpCJUUJGsrBn4DJU91bPQWSiLzgZkWXD2wxqgWBqC1HXTXIloWSqZYLkx?=
 =?us-ascii?Q?Y1EYBJk/FaAGgc0hSznZ+MtDvKVTxUP9mjLCBNK+i4MKmfWpiazZosxHkS7y?=
 =?us-ascii?Q?eRUo1Nqe1FCUie7NlEIOHmFdy5EEG2ZjLBkxl+EJTneK46LLZEO7W7hp7cS5?=
 =?us-ascii?Q?nzIJFqE2RekV/fzcMQQgpYCcrMYcifhvtV6hD+RbjtwwWd8jsplsa67dPa66?=
 =?us-ascii?Q?JEifVhZMwDMk+tIQYWuv4oniGh5AesRuiVNGYo/GcJMiTA9zXWydg9g3e+7X?=
 =?us-ascii?Q?0vKQJEYtNIrpIzUkowL8jXS0vzmaeFrJAYYFC1q6OOYKdaEYtwyKTBPysSMr?=
 =?us-ascii?Q?4CzU0fFDKuwg9jIZzjK//+7MhyygO5ME//CSbpAvIMujhHAlNSGbg/O0VLAP?=
 =?us-ascii?Q?9clCmU3CGuGKYf+Z9AAvB0zi6nhQuXXU5KGfi5cmyfqkeEGrHbXx5aWf/AXp?=
 =?us-ascii?Q?i+PrtO77hQso+CUQ3HUBp0ZSZKfzJxjEMXzkfMyi6vKEJwk2SCBWRt3kEhkw?=
 =?us-ascii?Q?xeMzDLVM7EDLe8FN8jRwLLIkgc+sC/JWaJxpsHeWofqSteytvf4u9MvocXC+?=
 =?us-ascii?Q?42Bvsuh69xi5Qdnjb6H5AJWMY0So3LwNpukAx06tIFV87BJYjMpVUDGWHeDq?=
 =?us-ascii?Q?Z1hGtL66sipBfpV6LFSuBMuRaSzDFYIQnTv/uNajk3gbxHXMsdFkU7UDj93J?=
 =?us-ascii?Q?ECzHFjv/jcGfEskUnFffByhO+TMdTFv6FhOKPV3RHXGEY/WAAaZbsKI431yx?=
 =?us-ascii?Q?hnFOEtqyn7N5aLLkHzaoagtwcU7NVYLiPMH6Jul39T3jfp+jb5dLhdZjaibQ?=
 =?us-ascii?Q?QOcomoSagCOkyogOlsCTrrwprJ23o2lW1JDqvXC/MGuS0dhKhm1Xa7bGkWlS?=
 =?us-ascii?Q?9XVADe6hGrJC/uB/ToMcv/ecW6h4RmU7RLRzJb0H0SFVb7yH7heusweBsxgB?=
 =?us-ascii?Q?eHbUE/bO+XC0ojiUIoBmyiKSYdGlMPGF6U/xWHgh4i8HgXgce8MKGE/CebkT?=
 =?us-ascii?Q?VGHJYvGqNK1E1eB8hPDWQixcN4mxtQbKcIQokue+qvLnAarD+w72+rfim4EH?=
 =?us-ascii?Q?QNAlQ/TJFRE2AKcZ/sepQwfAqIaD3cqY3mAoNHNTo+cSDrFosM2IoIey9jdd?=
 =?us-ascii?Q?lvwUoRFZ2DXQibGHo/yr7uD6pXDTCk7WmnP7URMK3a5OGiSsaAeXadxy33XG?=
 =?us-ascii?Q?TXg5r/u4cTl4vZD6c3y3ppTf7sbBduogr6CMW4JekPQ6grh6Z0LL0T/9MGdY?=
 =?us-ascii?Q?h1a1ErgEf9mXrqpExg2cRvLXOSA31DOPlIVtieyXFs08CL8Gjk4M6f2cSzx7?=
 =?us-ascii?Q?www80g5nl8O9i71LGw2jD0YNbPaUWh2XGolAxyecHeHkNyonhYepIo7zEdyE?=
 =?us-ascii?Q?kEHthLo20CmVY4m0qNSb8q0JYCtWJMvn5MRXL6zFVo2Rcqv0kUSPnT3o9mpL?=
 =?us-ascii?Q?8q4HLOQ3U8K6kPOjN9ScgLaVRroy2+UG/BRKs4dpIlGhpvIcm4a3cKRICcvF?=
 =?us-ascii?Q?EnoldXT4TP9VMjs0h66r9MlL1cnsWbE3lN5YkERg6QAaWHqP6s7FIbNisvHN?=
 =?us-ascii?Q?h27FzAdVgmSW0pp8gfS0uVPMrJgChkOaYI5F1YYXuTGlxp8QLYdsBRi3AMwk?=
 =?us-ascii?Q?+ya1pSiRAiqEVo9VjeM2AIdti+8sGkUGgmov8+5kY1Yly3xRV3GokKzbdMuV?=
 =?us-ascii?Q?AnrziqkevUEPwCZxjF7CqNkZr8UIC3xLWuE3ysBz9/36rJLPZnKBUmqmSjsE?=
 =?us-ascii?Q?lGCdik2CZAwH3duI6usFDVm7MB2PoSw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c4d518-4061-4fb2-c142-08de5a854a68
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 13:42:46.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FkHpOIl7a0xeoAYPUhO4lIo2hQ+wvSxeHaDJaqQQmgjaAx4+yAR8oDkFNzypu2FGExR77+N860KMECtfrbrO2jgxzQSOF+yYENG1vY4k+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5140

Add the ability to run a stress command (e.g. stress-ng) in the
background during test execution via the new -s option. This allows
testing EVL functionality under system load.

The stress command runs in its own process group (via setsid) to ensure
clean termination of all child processes, and is automatically stopped
when tests complete or the script exits normally or via signals.

The stress command output is redirected to /tmp/evl-stress-output to
avoid interfering with test output.

Usage example:
  evl-test -s "stress-ng --vm 2 --vm-bytes 1G --cpu 4" -k

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/utils/evl-test b/utils/evl-test
index 6e1edc3..8a72401 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -7,7 +7,7 @@ if test \! -d $EVL_TESTDIR; then
 fi
 
 usage() {
-   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h] [test-list]"
+   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h][-s] [test-list]"
 }
 
 help=false
@@ -18,6 +18,8 @@ full_path=false
 test_args=false
 test_arg_list=
 test_list=
+stress_cmd=
+stress_pid=
 
 while test $# -gt 0
 do
@@ -37,6 +39,8 @@ do
 	    -L) full_path=true;
 		do_list=true;
 		shift;;
+	    -s) stress_cmd="$2";
+		shift 2;;
 	    --) test_args=true
 		shift;;
 	    -@) echo "run the EVL tests"
@@ -49,6 +53,27 @@ do
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
+        setsid $stress_cmd </dev/null >/tmp/evl-stress.log &
+        stress_pid=$!
+        sleep 1 # Give stress command time to start
+    fi
+}
+
 if test x$help = xtrue; then
    usage $0
    exit 0
@@ -73,6 +98,8 @@ if test x$do_list = xtrue; then
    exit 0
 fi
 
+start_stress
+
 result=0
 
 while : ; do
-- 
2.43.0

