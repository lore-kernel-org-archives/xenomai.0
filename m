Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2F3672B1
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607731; cv=fail; b=Az+5A0XSjhNcj9bKlU1Ag3WcVPr6n2JtO2omG6nZkaO46KFyyuM2QwFAmS4xdgW1fDXP3BiTSs6U3c/HL14O93p7OebK1JZXyvd9aaxEKpxq4+QcX6zJGxMT+nD9OoXoWk0HI23RAHbGp1C8pqJs/At8JLHBQRw/DeJAUHflsSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607731; c=relaxed/simple;
	bh=OpfVhoxAq47E7kGJQlR+aR/ZQDw7eYivJCN/YxqAlec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLO+1MFz5WLTXs2sT8e4t1v1M/gd8miz6arke8dhYi/GUTsjt1jnOlHk8CtkUWG2QzOY2ZqEMeqZ3sXCLkrXHBS5/+JlJmUagbdisul7QdvQjc09Rvz7SWE9yCw6QFsuEpmdQE62MM6jhtouAuotlIanzontj66fBFma5xBl8CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iMrCTjWZ; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iMrCTjWZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSJY1NvVMzbNVmnI8Ankwm5UtZUOy6LjKd8s2skFMmCmdFTcAdSvSE74BeLweBqOH9CRKn35ae5mIlqtXAlbYifBc/LLm734agdYmfCpCBkLPEFs+NCI+D0TCG/LOkcPkPsH7VbqAXbvXOAIDqp6o8ypzutQZKnscj4yQRR5LAoV78Q1oi9b8BNhZWmGBl4HLD/rQI82NbFMdFoZ5aK0tPm25ko3+s7qlNuJz2bGs3f1D8niErYLddf8kNSb9GPmJOnHJvkKLhoX88L1Pbw5Owg6ckltAI9R0VtgjgtoEufqtl0m/ePtxn/MMN/VWTMB1Kn7fJfWWEVlHIjqxoJQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNqV9ZOX+eFhE1VhBppg726hRCPZ5hAsns0t4YaVajA=;
 b=QzJke+dmbCwqFDKAdAHn2kI67l7WUHHqDq9FcQit27j+uKOC5tp7PfB2S5NcXY5PB05GmDA+g/3MN9gcbZ7MjLKAaZZr84dJLH303rdOQUXQDkOma/hV+qzTfKhkEONW5dDNjtHEtJEe38/SUG1In3i9D68L2fJIfPj881nsnQhZt8WTSu8w23QxBY3TrMTq6N79DrAcLPfil/qVTvXtiG3kJe+hqkxUN0uMFB5WWFF1imwr3tDKsWrYaQB2F+8qhRUF+HYOUAes3oMmyO5NN/wlQTeRyHAaLPiU44st/ZAmOFB0TqqMJCegkD+8Qbnvp8ETPRomjMQA3oT0oYf6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNqV9ZOX+eFhE1VhBppg726hRCPZ5hAsns0t4YaVajA=;
 b=iMrCTjWZBmRq6mDugjgAnCfc49EYGVlvPpXnE4CJmwgTReARk8oVk9iZX7JyN8zDIOvp08pQWGmQGVeXiCOoZ52Pm3EkCAgYzc36ijwW/LbeWFoSstL3sWa/0U5yuHCXU8lmpLlLa7DhqVa2U2kZxlXt4qmIPxov42zvHUs+G3lcbw+imRKZqIrYHv6PZxoYduLwv2miPFHrIRZZrMde+uNCIPZGnk1Bz+AJeK7w07lKbtuDEZeT5KTE0XkEnTzmmR+TNIF7Rt7zOTlMs9NOmXUyNckDwawqKjqEy0EH0DP837JxcxHzXcn7wyR5fWRqibmf1Omt37gdBldgNfYx1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI0PR10MB8984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 14:35:25 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 14:35:25 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl v2 1/4] evl-test: add stress command support for background load testing
Date: Thu,  9 Jul 2026 16:35:13 +0200
Message-ID: <20260709143516.395611-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709143516.395611-1-tobias.schaffner@siemens.com>
References: <20260709143516.395611-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI0PR10MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f578ac0-88d8-46f7-d990-08deddc75079
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|18002099003|11063799006|56012099006|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bjwHZ4hbE/GIgef6sYgUEVhRqb4pNdUPmFzTAPLOUaS/RzExqXHwh3cCkUuBN12poe0lP0hNvzNmMNPcUvUUghRdhVGNMx1l9xtdBnVcqOJGydTuZyXYOjsihsyLotEirto7NF5s4wMYPFK5lWZIGdJJqhnoD9tF1EHWzvWALe7jNvFECt5t7HGl1gBrHiW4J8J6c8c9Y1b5k7ptMKP5mpGY38Z/WfXzOrAywNWijGnSZnlkIQ4Xgpdbioh+zhNjj4USCoDppwpGNr+FgVEhv0F8FIfqmrnQpcNInsOcHJ19Z13qMiiz0K62nUEgGv2uV12SN0iLn6GJld7nh+bpZkspIBCBIsxHulFmsh5INd96eFozsb+mifYERiN9xzl+x8dRCRCUxKzZzdtfOhe+CRzC+LD7qkWH1brlWDWdzE+DwyzHiie6A/IeHkbRmM3gz+eqN6ApfLmIaS7G1BGRsFQ2qkWekaSiJZT6BjD/nqw5HryEAiaILNvQyNPoMh1a20FCTfhInCUo72f0sT+x0MRwAwE0Z7NVaDpS0U80rvk4wst8tXuZQXkdUJ9yZZXfU3k+5YRoCHhVujK6BzKs7IFHT14lpTjHPQzUJsqShH9BbGk4ZYg2loqkJRJyTlNB7OFxfMtyjpyvLe/mcSJVZboosWkIhiXJsilUxrL/ucU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(18002099003)(11063799006)(56012099006)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7hF8po9YjwnB47Kw9rVSb9jP67mJTIkbpbL8Pdx28I7/jy4Z+m5Vh+k+Zl4?=
 =?us-ascii?Q?4xMw9LqonoE14bjg2hdLPqMglry3Hi9dhe8MtUhvCulRr2n+wA24w8hMqgPx?=
 =?us-ascii?Q?CAtL8kSL77I1u7ywlloT4MdpHp+uyjZhkxXWPBMgzYuv1OY4R7ohyqEZ/glj?=
 =?us-ascii?Q?nxnx2Wjk7iR7HKYZrcX5GNqP+EXsuBWgb689nP9GYPKLgryjnB94Fk8uQ+Qw?=
 =?us-ascii?Q?AKdw6422Xu0xPeAbgkF2hTYln2IYnxdooG4N558keuJOMjfr8K8KvmTBEIlk?=
 =?us-ascii?Q?BxebIfsyTJ/XPFiaw0Kg87IHCT0hMMaKrZcb0NjfHTzUqMW0OWHWfysR3iMB?=
 =?us-ascii?Q?MUZmQWr99miUTKTFLMgm1TCKsbiPHBsvvFAERmO8b+PlAxfrVSkbcvnbI7AY?=
 =?us-ascii?Q?qW+FqE/mmEhUbERcdvAwn0Z93zt1bifiTDpvqs964HdxUMbz1IQv40ooV7ap?=
 =?us-ascii?Q?Pb+tUwY9eP+Ecgs2x1Nqt6IANIe2HOviR5Ji+gkzQP9rYTx0TwxhTxSNvzZT?=
 =?us-ascii?Q?5QrAOFlFU60k7raAniJ1U3jfIn6jsZUgRqrpHj9iolAreYqR+IVCZPMc7/Do?=
 =?us-ascii?Q?ImukADilhqlIU8ycTv3l7HBZ57ncyQRgK/HpYA+A0bxvUsVcGc6h1la6WSwX?=
 =?us-ascii?Q?djfEtaLxxMEd1Gd2+wY/mgWRKhJHZcc5bHSIz9uEnR9qm4o9XSi7k9n0NHA/?=
 =?us-ascii?Q?heHPRpxwbRpNLUXgneDeeI7jpCUwNIJKxfQfIwRqN3l2QBIW3/gWyJtoft2/?=
 =?us-ascii?Q?AD0AeCHPmFIENTj8907JJw+BYl4/Ko5Q3ZKOcFjzAKY0sH9o9EcTfp7VX8y2?=
 =?us-ascii?Q?bHBoYvQTd1pmyslGRAk4PZ/1iLy3Fc2fSdrrUi59rGnkpkIMVGOed7EJlS0x?=
 =?us-ascii?Q?emx8Q192G8rWYSQkeeVbvgYqoI6tQaMsDYoaUlWlpU9l23LgMEgwb0/AHmHv?=
 =?us-ascii?Q?7GhwHZTSbkIrTYZr9EMshdwyzj/ycVyXn7NCy3+IiiV1o+hbpwqhA41CYkUc?=
 =?us-ascii?Q?fkLLmUAj/eYxT2/bRc34dr05CkKU1DOiCUeA8layV1Xpuyu1B/h/QboQ59xX?=
 =?us-ascii?Q?U9U57OW2LvJVaqrk2w4tPgheaHWBpQgE7GcO+GZm6wEdM0gkdNonixVDtiGU?=
 =?us-ascii?Q?CSe2BvKR25wZ+ABO18EH70Kxb1Nu3+b7r7F+jp0oPgLtGp/6FLfWNOoka8Qn?=
 =?us-ascii?Q?co/8fljgWETY9Mz25CgvaU11TM8//bxWcgv8jjlI8bk60+smE1EiIZQZ1qrS?=
 =?us-ascii?Q?ISAzo/7Xaa2VmeUNwgMlpycrpEkCOruzjXVTJDq0nixux0wYI/AoLLUtOFWu?=
 =?us-ascii?Q?hCcuQeZeF51+EnL+oBVZou+5fC+bQt+pcYzoNKTvmweR33aEQf+lG1Kh4p8N?=
 =?us-ascii?Q?TEM4ZYx7MLbmu5gZ99Zo9rqJ6SqHMWkxtXjl/9/Jzt+e2Are0W/w7wV18wsf?=
 =?us-ascii?Q?0eY1Yl9seN7/I9BGDxR2IyRtN8XxVvAlarZZKainAxqkjqGbbysLTu8xcFnJ?=
 =?us-ascii?Q?cIdUut/2lJZ8brrMwAuB8y7P9/J5kGrwe+3K+HBN0lxwfOU2SnCSappJHZty?=
 =?us-ascii?Q?Ipf9l04WD5MdVi5c5eZcpftlO/iTvA/260d7hO/w2+klN1QJe5U8HYma94aq?=
 =?us-ascii?Q?12DVRZ9G4Vsc1KT6CD2vSvvY/4qQbJoipJptM6veiRfSHKt8OPSbsKewVw6Y?=
 =?us-ascii?Q?te+l0XJTfhaOwj84IWPETyKqICWMSWN3NqcitX0CipAvD7BjddcLqU+oo+u7?=
 =?us-ascii?Q?JpxLalGg79IcXcYfiH2dc25ECLLokC0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f578ac0-88d8-46f7-d990-08deddc75079
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:35:25.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhgYL9b+uWr/8MDclvHfxvlDjvUfusiJg9SnAg9J/ZfuPKYjrtvkRspKL8aTaY5+prqV9BqKr1fBSAnlpT0KwwnylmoBrFyznNyfU4HZRVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8984

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
index 5139d09..f6bd82f 100644
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

