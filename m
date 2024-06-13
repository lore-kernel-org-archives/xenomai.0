Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F51411DA
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286405; cv=fail; b=OJm9jWt5RCiySff+pnExW6uj0k3bd/yJBNNlRbJ01GTJKNOrocxjRIAEFx5qF1bK7U8KWa2CvPoyLhboH9BVzgFpHjloeCiI9bJoMORDx0DV9LYJr/DR9Tfo544/DhDCN/OV4C/k+wmaG6RDdNZgxVSsXaqSwAu8huanRVJFh74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286405; c=relaxed/simple;
	bh=Uz+CcDDAg+ctOLGjRBKqKHP+uuadJolVO369XS7YQ2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nj97p7fLnysQET6XnOBDV22PNJTq1wrwYDdA2LUgb/SEfDKJMTL99tW7Pu5JHsjEcqS0TDlnlQfixAremJdEBm9S7HYQaYW5vOL/o+6mcJXAddS2fyuzHwwcepWGHaHWsAE2oZjGR89OGKhfwzB7moH2nT10qO6VmGCiLllXc5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NbaUVxwY; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NbaUVxwY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibc46YPztNzBDDGsYL/7F9d/hsB/j8hcZPgRb/f8N4NMcNdqbgDcEMhDzejapfUaUPHThvwjBR34J0AVFkc3JW8E9Vp3gzJknJbziNXIrBav0jRXRTwrCRHq0RfMZQEPgAVI1W1zyCS2ZF0DbnqBGY+0NFwCfU3+zCQXQjMdKuUg3zJEotOES6r9XB6QHTFdmAdGRnQq077FBCweW3m+j1JuVlcwsCn+2cInUFCLLri4Gh1Z9/dlO0JkMcJVBt5DQH5TM2YSKC9LbxwCLocJuc9Uf2BSvqh5/XACupdPnErJGiVxSkOEk/wakHIv4h8s22K0thskqus3vvnxsnjW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M4Sy8VIRkoEgrucrD3Eer2cpBtAlrcNihATpaQpvr8=;
 b=Zq1NI0fG/7v4p/3XAW0FqpPN7+PONwCKoZFOnreXllVYx8Q6/WyOwNGdTXeTmDAR5ZQC9w0TIw49WlV6vXo6DBRFqW6R6rqVTwP9fuMdhiZ4Lgdh26/vKQieu3Htx6VvyrzIznIeSQx3kG9oQIJhBuOzNGMOdD/fQary9yD18Ha/dv9XCwfwRfmBEv15jbzP7jlajYiSP/EIqzdICuYZrvR7qAHW6TQNtCDWyLcWCQsUNDVEnYwEJZ5OmzmHBE7TbFWiyVcOPFFNjV4orZJKtvRF/lsS+dD7lkGRadWOb2SmdugBkxzEzPwRgpUa3kiWdZ3BCQfy+CognjWSp+D+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M4Sy8VIRkoEgrucrD3Eer2cpBtAlrcNihATpaQpvr8=;
 b=NbaUVxwY+We7gz3U4C64u8zswItXxB35bFu9PNr/Dc5iy6/G0cCxXbZFr6MElIFekK5gJFxs5WbjZUaqTbcc7jWf3mdpNXw+K1s6YMZXUSiQEUxnragisx/CV5PaiBnvCoNDk0fFfjvR3+u+6GQathSl4Pod08cXDBFHsOSbwfjRiGpcsOX2X2Rqsbsq6AsW67VQXiaWFH9dM8Dj0x2U2GeoA+yw00RXrygQ6CB7nLyGaV38mbv0UKUbiqqPQNi4PuiOEKaYWBhyFgxb3KA4w95b1HL5vfj5g3RJIBm3Lit3YzFQ5ef2u6QSyI0GZ4KXR107LEokNG8wSL6AN9ITuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PAWPR10MB7176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 13:46:36 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 13:46:36 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Date: Thu, 13 Jun 2024 15:45:56 +0200
Message-Id: <20240613134557.4013044-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PAWPR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d143199-b862-46f3-a53b-08dc8baf3e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ACy1MoBnVFD+fHU0j+VT9VyIsx9lxgjkF9GYRa9nYt4FwhvFw6waXELIepfY?=
 =?us-ascii?Q?iX+nqvL++p/HRjRa3o3aJq6g+q56KVyPhHpJoNgOjGsmJPr7A+H2n9xDI8wV?=
 =?us-ascii?Q?D+TRf8hbgYcPnTWuIOJmUakASxwfz/3nz+f1nhCIq+7g415R0F3v5efwik/8?=
 =?us-ascii?Q?L9o5oCa8GP5mIxGCxmjOoLGGRuidbklGjhAj8GI4XipyWOf3kPyTIoYksN0A?=
 =?us-ascii?Q?E1tZ6OWnYeu7DlJCgQ9iTMNPu4Wg44qlPLAosCHmNOyQwT+D4NdpZ7lCN5rC?=
 =?us-ascii?Q?JaossGA0xcqL1QAo7q2ZEKlJ+/LVMrGVnNOcAMiGDmvkc+Xvz1GC7r0qDBub?=
 =?us-ascii?Q?bJSsEXtnC2k5fds8A1H++1GBmAI3YTQ0KD2yidWcJ0agCLTeq72u2G2mJ3PX?=
 =?us-ascii?Q?+7Fl3R73Lbb3q/qNvd1e/o/Tr8LH9jBAbxxPKgLN/+exwXeLd8T3tuOkzkni?=
 =?us-ascii?Q?anXlb1XkHeoerSrQ8nq57APrKTohVzduD54Go/dgQBegl65aXzc346xcCxbS?=
 =?us-ascii?Q?BSN0xKu5D5iu84PNgGJLdXCk1W9zsU0M4+GEZhLZi7JpP3muYGE4xLL+cU70?=
 =?us-ascii?Q?drpaqbm+uoPH3TGi2KU4tdeqh/mnlG8g3NZ8U/u3udXHLu+2lLedYz0It04/?=
 =?us-ascii?Q?juf0YwUAUNoNylj5aL34+Lq/wNLmY0sjoBIHXSDvffUXf0xnFKsSUM1GxXsF?=
 =?us-ascii?Q?689sasV2/NVOh3qgrUDXG5vBRN/1Lm66fqC9fUdcRkTw5p3922QrSV+epBKT?=
 =?us-ascii?Q?WnysiExUL2rQ1E9jflvG+JDvEEl3M+ALk6Cw7qe8bJzduXztwMtsIGPAaa43?=
 =?us-ascii?Q?LrloU98JwUrZG6/qbMYJ3CrII6qsOD8VL/h1WC72hXTjtFz1xhA54z/LCp5A?=
 =?us-ascii?Q?wuth4X3tn78YQoaQnsZ3RMhDLPB3NsB2YFQbQTRl+imFf80H46j7SiQwtuYM?=
 =?us-ascii?Q?iCKy+pg0gmMz/4431kjoXc5J60xNRyzdZBietSwVG4YfIW3ipCI4OlJa+ysh?=
 =?us-ascii?Q?q0MFPkrJta3fc5DQiLAo+b7yIarNrC37zkdBmwQmPT7cBKvYi4f9a9PNDmpD?=
 =?us-ascii?Q?HEDRqoWzXNF8KW6qQIsSmp57YtbhWv+a87/l+5JBjREXiOOu0IBlnNhejHk3?=
 =?us-ascii?Q?ez1DwP1iJpFo18l16mIeKaqq1FbbY/UQDKU/qqzWXDXohoWRl5iSU2PltbHW?=
 =?us-ascii?Q?jh602JfQPK4Wpk5sJCh/iN7OH0MQN79jcDxUNY2zqTQXTm+fIV0N8zjDdG3R?=
 =?us-ascii?Q?HcQMQX1PUWLibGdXA839wQAGy1IliHTQ7EcQT0gI6JXsmtKZm9FW78A+6cxu?=
 =?us-ascii?Q?Ok4RU9xLeJiNuJl/SMXIEm+f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBOG3j1CgL14BgS0Qtexv37J+47PS9Y27iuqNoC/X+jDa4O/HomkhXFY8iaz?=
 =?us-ascii?Q?3OMeeG+QdB+opQVYK6FHkd2OzSeszW9HPY6g4zyKp3YYYubpQuac6zpcf0oo?=
 =?us-ascii?Q?NG5/zBZU/iUcup/HEqLz2ukz2jQg18ocRYOYhAQqZ5hTeYst3I8nb4EDujLn?=
 =?us-ascii?Q?0DT18o5FS1WTBR3I00pnCym3zLdAir7K813QWlSkAvreaG/jOX6ILlV1GMFn?=
 =?us-ascii?Q?KDrbkyPIs7Rj3jNTi/m1kOGX+u3qpUGowwGR4RxDeYcLDqnkaGT/vx3mMNSl?=
 =?us-ascii?Q?8WbF0vzOGXaZ6dOiwa8OTz7dLgFq0Ra2TAU9i3ccEXx26cwzFlTZcF0r4Wvl?=
 =?us-ascii?Q?PcVOGE2J4/7ekadp0oUri+lZMyQ7r6fBN9DuMehVbofL6sYc4FU4zMBsJMNH?=
 =?us-ascii?Q?JQQMHnXObqumIRb614k/mYkf/tleytMQ9Mn4gEGMX19xl/CjAEUvB5uQUBML?=
 =?us-ascii?Q?zFb+snU+vXCp1ynM/MnfuMrkgMyhRSyjQuxUkzUmCM9knsMSyNkktHURiGPx?=
 =?us-ascii?Q?NsSSoPfq+d1i+5UpwqvfiQmDOhW2z4C9EdOoYEEovRMAmdcJ4wrtdqVML1yx?=
 =?us-ascii?Q?Ru/5i1NWnK8zgAamvOkIJYUf2bqwoHHbSKh+FOsWwUTnJ9aq2AB8G/2VoXWk?=
 =?us-ascii?Q?SN6LlQu71ORvwJwzTFmJvsUN0BNpINbW2yfy8/ebjCr6zmgImze3/p34F/v7?=
 =?us-ascii?Q?dwJrVV5E+DKhQVQ4f7ao9dtPpaW1kl2vCdXIzaw/g9MXktQnL8RFJdTfMXK0?=
 =?us-ascii?Q?XgiItlIINppLk3enGD8nTMDfdMr0/Q5LwvwCS7puR+Sm+cfZ2fZfUhKqXVyD?=
 =?us-ascii?Q?sxw1mSR1zcQ4tsJhOGpIqfG0vcOp+dsBT8K+RLSdFWW9STwPRjLovZpBLf+G?=
 =?us-ascii?Q?dkD3Cnkteaz+ZDMks7RSw8qVI+4TAerbh6XW4fIPDFuMxdpJH0tkREU5yCZp?=
 =?us-ascii?Q?o2Kanb0aKKMhJRZWyaxIDCH12jsfdJUxQg4/gxDpTiKgQhT0+3pvlbHDRhhH?=
 =?us-ascii?Q?5+HzNxuPwqU2EYFBPLi0V/QNyALhxkLNfSdGOGwsHJvHGrPvF4kJHhrUOSRh?=
 =?us-ascii?Q?shJIDTotDjGY423kxsQOOPzCf0yybTAZvNluNuavK/twkL2G9wnHhbcD/2fq?=
 =?us-ascii?Q?PMNRE8UPHFC0wpuxrFdjZs/dwGqBNrF+2zZ0n/wx/DADj0NAFcyY3UM8OdI7?=
 =?us-ascii?Q?SbfsfpUhchnX8hcDPg1jVNVZnKVAultad6geook27qT2n/2+sLGoWNUEzfL0?=
 =?us-ascii?Q?SOkKr43z10M6bJ6OXQU8jhjuiubetl7Qar7qLWsuLQIo3FFKz6PcuDUp9t2/?=
 =?us-ascii?Q?4vazlY2QryFaTbHL/yIQpFZ8EfHw5AD7U+mQmUEnNBZv7sXIPFYH0M9UBZzz?=
 =?us-ascii?Q?mozUSQ6N9zLGkVfJugnzBGrNAXrzBxbuok0EWoKVHZlT1K7R/jNTwRdeSYDu?=
 =?us-ascii?Q?/mEqn1EFVlDP3biD6ILkBJb4QF+XPCnVcHltAdT72KTnrIFRCLwxzGBk1gmD?=
 =?us-ascii?Q?KkBHAdASSSwrTt5t1vWmHYxmFxtgBg+5wxLt4TmbSzmOS96EVq5m+lK8UYZW?=
 =?us-ascii?Q?3R2ZwNOpuXI/Nx7KWhfX5NT0ZN5qCXIjCuHfaJo7W5jD3xFIKC4/0Y9Nmo5y?=
 =?us-ascii?Q?hoIo7BYlgaAMYbRZueXcHoVQrX0QAH5zIsBoNbF3zGL0KPfQZIgiMvC0gJUl?=
 =?us-ascii?Q?vG/O1Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d143199-b862-46f3-a53b-08dc8baf3e84
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:46:36.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXleZr9YRP3aIEzmrBYpL7mAkgCyjiJlRLXR3MFM7g6kpXECAYvE6a3ZrjeHqDmSzmNvUaPW6zMWiQIHEEX0PJxf/qIwXx9G4wHvBSSJyfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7176

Stress evl with a load command while running the tests. The load command
may be set to an empty string to run tests without stressing the system.

To align with xeno-test the -l command line argument was used for the load
command. Listing of the unittests can now be done with --list and --List.

The load command is moved to its own process group to allow a clean
teardown of the load process with all its subprocesses.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 71 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/utils/evl-test b/utils/evl-test
index 5c1c3da..fb85f69 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -6,33 +6,79 @@ if test \! -d $EVL_TESTDIR; then
    exit 2
 fi
 
-usage() {
-   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
-}
-
 keep_going=false
 do_list=false
 full_path=false
 unittests_only=false
+load_cmd="dohell 900"
+load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
+
+usage() {
+   cat >&2 <<EOF
+evl test -h
+
+This help text.
+
+evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
+
+Run a basic test/benchmark of evl on your platform, by first starting a
+few unit tests, then running the latency test under the load generated by
+"load-command".
+
+By default, the load command is "dohell 900", which will generate load during
+15 minutes. To generate a more realistic load see dohell help.
+
+This script accepts the -k option to tell the unit test loop to keep
+going upon a failing test. Otherwise evl test stops immediately.
+
+Use -u if you want to skip the latency test and only run the unittests.
+
+Use --list to output all the tests available. --List will print all the tests
+with their full path.
+
+Example:
+evl test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
+
+Will generate load including network load using the server at IP address
+192.168.0.5, some I/O under the moint point /mnt, and the LTP testsuite
+installed under the /ltp directory, and use the latency test by measuring the
+timer irq latency.
+EOF
+}
+
+cleanup() {
+   err="$?"
+   if test -r "${load_cmd_pgid_file}"; then
+      kill -TERM "-$(cat ${load_cmd_pgid_file})"
+      rm ${load_cmd_pgid_file}
+   fi
+   if test ! -z "${rt_load_pid}"; then
+      kill -TERM "${rt_load_pid}"
+   fi
+   trap '' EXIT
+   exit "$err"
+}
 
 while :; do
    case "$1" in
+      -h) usage $0
+          exit 0;;
       -k) keep_going=true
           shift;;
-      -l) do_list=true
+      -l) load_cmd="$2"
+          shift 2;;
+      -u) unittests_only=true
+          shift;;
+      --list) do_list=true
           shift;;
-      -L) full_path=true
+      --List) full_path=true
           do_list=true
           shift;;
-      -u) unittests_only=true
-          shift;;
       -@) echo "run the EVL tests"
           exit 0;;
       --) shift
           break;;
       "") break;;
-      -h) usage $0
-          exit 0;;
       *)  usage $0
           exit 1;;
    esac
@@ -62,6 +108,11 @@ if test x$do_list = xtrue; then
    exit 0
 fi
 
+if test ! -z "${load_cmd}"; then
+   trap cleanup EXIT INT
+   setsid /bin/sh -c "${load_cmd} & echo \$\$ > ${load_cmd_pgid_file}"
+fi
+
 for t in $test_list; do
     test \! -x $t && echo "$(basename $t): no such test" && exit 2
     # Swap stdout<->stderr for the test, capturing stderr into $log.
-- 
2.40.1

