Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C279C3D1A97
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081781; cv=fail; b=C+0xctqz6xcC5JUHsG966PVn6bVuVkCA03ZGPpygsFVoiimpcv42PY5xeFZd61knvoCq6bxD1zX1yhRevH2C/Rvlg19JwPMYtxD6/wVMtisk8ZT8nAly2/DbDPBVhTQHMUN2sS17+3CIpeRH8Lnn4UY+dZKgA/w5E4iiihshJF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081781; c=relaxed/simple;
	bh=+jD+FmQWdKlK7ksicC+OAVyqywA2xztOhfQi7geUZ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R1mFoJnkTVfm2TbT3JGwketc0ndmgdmJUTgAJLEhSJsK5MlfTGIwysEliSnJdoiXIWqiqPHRkQpSmf6Dj6E3WyWjOg2clMIJyZxNOpP7I5D1cQGaz13xMkeasWcB2kxBVcfqKbJxmnwZ+s8WATULJH2CzWkwGHM8KOQl17SlHjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vZiQZUUH; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vZiQZUUH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tpg3wRfKim1Vj+syBWXpa7OpG7u1o6mJhqWZZIqRAEsj1WRHzHnRY2BTW6u++UPB6Iu2/X1Fekk061doUQ+tQC4I+pCGMjtitfHc1dI8G3ifGZNmXEQ8ivdCRwsB532Fm3MZPpz7RatT+2RzBU/HxjTx8fqjpaUR5xBkakNKk7MGf9Zl3h7YmLEjxG5RSd8k9bwUa9L8uHB2scqdbtmg7z92Zlnci/cYs+yVUAgtpJTHXuEw7WA2E6go90DsLDlyZMkQfqS5jJH3OX2Tex0IFf3BItYpiYWaAsWwi8zfaUJQ/ms9L4LOKk4SVHDKkbsu1qNnxwCf56L0Mh0VYX6SOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcQOvBMn45BPPhyX6DmGZOKkIc6kvZDkKa1lSQPBHu0=;
 b=Qu+LgC0tolZN+FvWwc3qq7+I2wtF0pHHvpdGv9rexeujxU8Cu6ajALEHPzzFrtlsKTLTPE57Z4/OEANCbWY3G6hz8TDDAoCom03QV3zLfA22IT8JSHm/EI379N/8ziHwNOn42KJ16Kth8UAY0KmYIoxXkA2i+6kiz3o7IGIsHfjP3o+hXlUO7ix/RDrtWeGkrglMiU+vfv/0Ytbf0FZjg9bMVeAVyhlx3cKBrUOSUgMrBuAXV2Dsa6bDdB7KD3lYdeYJLhscbcrLZZStmGYpxWLJZjpNz1TA4sjJonvkFt7P/2O9I9HJUPzFIxPURT/6gc9ekvwz5FwaxE46eabJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcQOvBMn45BPPhyX6DmGZOKkIc6kvZDkKa1lSQPBHu0=;
 b=vZiQZUUHJqj52+RBWxwoKWi0W13TvzR9vJEjDBPuuoklqLIxYcsm5Cv3YgnOLKU23TqFGmFygGVZ/q7H46rrF3gC0ahmzNGpPFCXUSeMpq02zuQ1WNhHQw1kwQ+n6SOj/lVhUDacQl4Nz7ZQ53tJKXMHiogQwx8j4p5upqNb/wXa73P1iPxog9Hn+L7/umxB9Q3aiw+IsTsyPe3X9beZgjRLq5jq581psqFCP27od9CxTKqePmla7m9Ubk/qVL/FSPlD02FN9YwS0+UxU9w2PzVZhKgq+kRR0j8yIVTUWIcYlVWa6Hh2imuCVipCLFlE/oON3S5H4g9eOmVntviSKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PR3PR10MB4093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 12:29:35 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 12:29:35 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl 2/4] evl-test: run latmus in the end of the test suite
Date: Fri,  3 Jul 2026 14:29:22 +0200
Message-ID: <20260703122924.30212-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5963177-cb10-4f49-90da-08ded8febdb2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|11063799006|56012099006|3023799007|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	odNFSJ9tZKr1owEgAQ9WH3B6DYSSDBQEuf9UaLqymoXr7DDri/X+s7usINFLmciwUoNBILISIbr2HEB8HhrfdW4Dm/7j1uls2wyg9XPXvnNrHojSeDGErUqJucF8iNP9UacWS6j+vO2IIYdQLKfaJXh8kOLcQkrBiAKCuLkFfcMr1ZeE4YdpV3MFtiDbx/+sF9NI00UtRy8PkCYbdFJESQBsrVmUzAprarsnrg6pBj3cwycCX3zT6gpJ0gMtKNNeOe+lAyiwfW8HX/vYcGDusuDBockb/MqQqll989FuqFZ8dkC+dvBRf13rF20mBJfj+aARcQIHkZOetSXmqpGo8rzJVZb+KQwiofE0yqGh8YUX2LnSQtvCdAYFqzIS2/3iV7iyCZTCvKtge8WyGXmJmayCEETmyF9RRa8gobRndKU7A9qSiW7mpSycOg5YXzxG2gBTTDfhlH0P5D5GmwA+xCggtWHQCPGRaa54Dlkq+Dh9MJMsTH37V2MbvWn0RVIKZ0RYrEPJR2bpdk2QD2jl/DMHAoe1SnOxB3v1u18GBX0WAGH2/VWwJ1JmPgTu6z7gt0uaz/9GsOo3PhrNSTT6U5xsLEYnOTL8Eap2M3Uro2bnH/04NXdBKDpVzSo4lEIriSa1lpH3orjMMRFo0Mm0ucIdh2V0sy7CyT/G7rk70K8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(11063799006)(56012099006)(3023799007)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8rDidjLH7ZtoVe55+11SFGnnOgWpGVXI8vrUfO0B4Hpyt3Wu/B9P1ftGHWP?=
 =?us-ascii?Q?DOT5G5ORJcXf1f0bXwTd0lysbs2TJlJZcMEDEfobzwScSinOMFKDQDV2w2ky?=
 =?us-ascii?Q?kVcf0slOLdBL4D/sFcmefeaVqz+PmEKt2DdLpF2Rkee5jLU2DJZK91lkNVjp?=
 =?us-ascii?Q?NpxNLkRAx9Etl0jGPHZL6ovlP6aIhycucx6sZYQpWsFwYzyivFg0Elk6yq+l?=
 =?us-ascii?Q?AItg/WqHs3zqH3RPofu5C+TE5JIrwfQLoF/Fm+iqGkZWs7YzdE2IxvwR73Xs?=
 =?us-ascii?Q?NyWt7oPBIJA9bg7yMMFjX510HhA+YgXrm86LVtaF/veLHnXj4SK5JFMIsvDC?=
 =?us-ascii?Q?sk/FpTUgSZi4H2rhyu4lyLYl7CVl1oikYPCKb08jIwtzaD+vNHZtC3V9tFc9?=
 =?us-ascii?Q?XSXug51U8YcsqlksDTJQt0LaHprAxV7D76uULJDzRqEoxVeynOAEy+d5/R0H?=
 =?us-ascii?Q?YYpif6/1ZTsuON3I0l7woTs+0ib5i/isXFnHoa40rQZauFLAmekkxvSl3cnY?=
 =?us-ascii?Q?1r6eoJWX/rG9ROU0lbzl8meGMI9wDadPvx9+aMU0jCc2jB52bLeCd71H9pEY?=
 =?us-ascii?Q?2YECtdzOWpk34NmAMu2vfd1BCYGM00jPyI5FY2w7n1LSTjVH2sRjAh5YxTAv?=
 =?us-ascii?Q?SWj4mUM9WKj8zpeT/RFX5D/WgJLEaIle9T0S+zJI+FhwRzDvSGl19tFKGcCH?=
 =?us-ascii?Q?SXmOnYAoqfk9evDEiow3WAJJh9te9b1byZ6I9ESTjUBAs78Y/y1pF6GZGAno?=
 =?us-ascii?Q?ydlnRGBePaceWAiFgJeTmXBuwXFBaojNNr3vsqhppeHy6jIlHsS1kDonlubo?=
 =?us-ascii?Q?zZwQCLERLQvMRTP0lZTuNstTDUPyl6aeZFgc7UgoK0nG6bgFaNcvaQdyKMQS?=
 =?us-ascii?Q?xZ0ArSs6SMVg3afyzwMPyuz+tzIzh2y62zHfuIstUfGpBlO5VrtcEM5Sifov?=
 =?us-ascii?Q?5Rnjp7g/AS05/d9z1xECM5N0yO+oX//35f+Sdj9AcgIx9isBruoN7E0nCFWA?=
 =?us-ascii?Q?QYG1Hw2GEEbBm+qutp6vYYkEhu693YdpXkHgXgEabCU2Zt1egDxE8zyM3NQn?=
 =?us-ascii?Q?BPGyRxuWHUmeQ2RYj57POoEQtDQSht4ay6kfTAMawgUWfe+eas+nVl7H2Gbs?=
 =?us-ascii?Q?tl70yvb0/J8o2JZ/+7+BDzY0zdwH95rNy88lNbX6u4HNO86LgaX9Re26GYc7?=
 =?us-ascii?Q?9goyLwLpqkrGOLsN1/lY+sglzXnN5XXYCd237lwGVCDxtwQWeQqW7s3fZb3p?=
 =?us-ascii?Q?VidMUhcMbRrKPM4r0tz4lg0bWXvhM5L8GvSHomBRxJzR8Rr8VwdC3/7xV2jV?=
 =?us-ascii?Q?te6c5D9Mcg1q/auluYGUyI0+wiirvM5Vbow5ZeFZwqMWpiBJGvNInVKZCq1v?=
 =?us-ascii?Q?DqKqJUYjXpNPW52Wro5ZBP0PdQxFy513rxVBCi7nM3CNJKCotz/XJIleW64i?=
 =?us-ascii?Q?/JkirbbFN8xL+b2bnG35uDQdhGLwXXwh4xlGml9u2MKFWkU9IYzHB1xJH6ds?=
 =?us-ascii?Q?yUFfCVW07uK6+7QAxRWyrbahx+W31NtiwkCU1FAG1IcSG1VPPglN3Sqh5h2i?=
 =?us-ascii?Q?gYhCbo1ZpF9fkx2IZk78XFh7tXlCwmTyTGPouv/0eW/DarwzetBEROvgNvdS?=
 =?us-ascii?Q?zAwyRb9FfaAZO1p0NwFABR9jzPjouKOF3ekBYphYpOELyaDamrjASzzNM8o6?=
 =?us-ascii?Q?mvH4lk3+amoAfuLWvp5XShMboF83qyF3Epxp8+LWSo6lqUzL2nuI3fCDhvIv?=
 =?us-ascii?Q?EOCxdMIRW8HsKmt3zz8ZykRaba+YstaE09sMKWW6P41fzaSxazQ5dQ8AR+MT?=
X-MS-Exchange-AntiSpam-MessageData-1: N8iyqjvhc1PLcYNUC/jcEgoX0zQGhLQeJec=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5963177-cb10-4f49-90da-08ded8febdb2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:29:35.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1hTgnU6z2sLh0O1cpGTUKvZoczwrZzFlRGsEuaJ1DHZdoos++qgA+mq3QRj0ly9dpo7Ziamn6KSpkn6ozReeh/UVWomwtBaD3Qa7/lz+aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4093

Run latmus at the end of the session, before tearing down, to allow measuring
the worst-case latency under load if a stress-command is given.

Add --latmus-args to pass extra arguments to latmus (e.g. -A threshold or -T to
override the runtime).

latmus runs quietly for 10 seconds by default; a runtime passed through
--latmus-args takes precedence. Its own output is dropped by default and
can be redirected with --latmus-out.

Examples:
  # default: tests + a 10s latmus run, latmus output discarded
  evl test

  # fail if worst-case latency exceeds 150us
  evl test --latmus-args "-A 150"

  # measure latency under load for 60s, save the report
  evl test --stress-cmd "stress-ng --cpu 4" \
           --latmus-args "-T 60 -A 200" --latmus-out /tmp/latmus.log

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/utils/evl-test b/utils/evl-test
index eb7deb1..86a3d0d 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -7,7 +7,7 @@ if test \! -d $EVL_TESTDIR; then
 fi
 
 usage() {
-   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h][--stress-cmd cmd][--stress-out file] [test-list]"
+   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h][--stress-cmd cmd][--stress-out file][--latmus-args args][--latmus-out file] [test-list]"
 }
 
 help=false
@@ -21,6 +21,9 @@ test_list=
 stress_cmd=
 stress_pid=
 stress_out=/dev/null
+do_latmus=false
+latmus_args=
+latmus_out=/dev/null
 
 while test $# -gt 0
 do
@@ -44,13 +47,21 @@ do
 		shift 2;;
 	    --stress-out) stress_out="$2";
 		shift 2;;
+	    --latmus-args) latmus_args="$2";
+		shift 2;;
+	    --latmus-out) latmus_out="$2";
+		shift 2;;
 	    --) test_args=true
 		shift;;
 	    -@) echo "run the EVL tests"
 	        exit 0;;
 	    -*) usage $0
 		exit 1;;
-	    *)  test_list="$test_list $(eval echo $EVL_TESTDIR/$1)"
+	    *)  if test "$1" = latmus; then
+		    do_latmus=true
+		else
+		    test_list="$test_list $(eval echo $EVL_TESTDIR/$1)"
+		fi
 		shift;;
 	esac
     fi
@@ -77,6 +88,23 @@ start_stress() {
     fi
 }
 
+run_latmus() {
+    # Default to a 10s run unless the caller passed a runtime explicitly.
+    case " $latmus_args " in
+        *" -T"*|*" --timeout"*) ;;
+        *) latmus_args="-T 10 $latmus_args" ;;
+    esac
+    # latmus stdout is dropped by default, redirect it with --latmus-out.
+    latmus -q $latmus_args >"$latmus_out"
+    status=$?
+    if test $status = 0; then
+        echo "latmus: OK"
+    else
+        echo "** latmus: BROKEN"
+        result=$status
+    fi
+}
+
 if test x$help = xtrue; then
    usage $0
    exit 0
@@ -87,7 +115,8 @@ if $(systemd-detect-virt --vm --quiet 2>/dev/null); then
     export EVL_ON_VM=y
 fi
 
-if test -z "$test_list"; then
+if test -z "$test_list" && test x$do_latmus = xfalse; then
+   do_latmus=true
    test_list="$(find $EVL_TESTDIR -maxdepth 1 -type f | sort)"
    if test -z "$test_list"; then
       echo >&2 "$EVL_TESTDIR is empty - broken installation?"
@@ -134,4 +163,6 @@ while : ; do
       test x$repeat = xfalse && break
 done
 
+if test x$do_latmus = xtrue; then run_latmus; fi
+
 exit $result
-- 
2.43.0

