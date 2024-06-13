Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F02C8C7
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286407; cv=fail; b=fiKs/GPnauNiiy905fhr+jJxdyDe2YgbSed7JBjAYKQvd4gLsQUYCC64PdePZkkCHTaGO+pD47Ajkhy+C4WMF6jgQBIfpthXkJ6U6z1O0rVaq3zdg1qnqsipwpxz3XCFlF2w8ndUV1sRd120R/KtTkdAjycKC1sPNj6B7Bnjk4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286407; c=relaxed/simple;
	bh=u0bCER6wvDJnIyCwvL+kM8S1aVWWbfLNo3TXkohV/nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QfVIHqXhjPrNiWyGNsln2AfK16YQ1gr2ZHLPJ3/YIh0N5HDEwYDAMOMrl+C/ZxMAJBMOEVkMOVkoQnAlYQkx+tu9No3I92TJyeRLufAJOKgBmfH/aBpaLcSzYSQJhDDzFpZuBKEKRsTmlEN7jjFMNcOGxFBdtvubUDqofmXt+70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KvpjrKEb; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KvpjrKEb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bederRcqFZkLMsERtD0E56bhSdLpHE/U/TYrm+NOmSwePtFMjEjf1SQ5N0yVdpav/ujT1Zj7XyIjodjkLJOZoPioMyX86sHvoRnj+dVfjPimwSvRHOEh0/0/nmT3xnDpEkmmBhNDTOHFZ938nNyA1jGHEi59UXDF5h83ed6MUGQ1LTuFcgBOJEirxCJGaTQ8zxCxYkcd6lv9BU27gRATAkSwM8vjPgAaPET4z6e9RpKAku98Dq2lyXoGxm76j5SqmRBa9TTIoSTnIpwbfoNzmuHg7+LgXh/wa7rae0Izpyo6cdodDncWnCRZzMZb0dksmqTS8tJU2xKjimbugReqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exTlDU55X5o11S7SNfO/nZV08tssR4ZWUOTbIUSp0T8=;
 b=YLJC/r3NmAIjYPtu7cppIj/aMpUOwQpX/JpaNaZPVmiYjRDWTD7c8xACzgRyg5qNEogAbOLH0El4E0QA/0XWZ/7XHmfwZOpDhxgBtNFzOxFuL20CF8ZzWDnhlOrYgKkJcS/gnRRGsKuSpttghow/pwvYBZsm2y4Cf9x0Td6y+D/OfrvJ0zXnmL8z+64r9ICjhNaqjjwYQGwFvm32k7vqXpZRBby7DgPWNhIwQ0dVWyoOrtqsoAkrElp+KORrW+6tZNodsvbRx5Xcnq+cehgofc4g6CzxIXgi3NX/JM7o0Wcyk/xecRh7ZXFcbMhrMAil85/zKXmtGrFkuvZozPth9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exTlDU55X5o11S7SNfO/nZV08tssR4ZWUOTbIUSp0T8=;
 b=KvpjrKEbTlVmfoNpw8ecqxQlFTb3spPUv00NkYX+wuaqdhJIVVlaymE248F1/vxAI7UnfZjlKEzWjeHeKTG+mmgXKXH0dP9LWlfZnIkse6n4iw33G+HN8OZ8IHr4p7ZV71WcGrZ1kcpjNGKCY/gr8z/jDK0vPPChF5sv3VWnGuBhH5fGAYgT4QcFokhzrIPJQ1sJz36lgP1CqDoRvG+dgbbeBOHdPHlT5Ixno8ifRvJ7GkGpCT7NsqkeTX1Fxo+e5FbDFEa6HfIhOmX48XHU0rTlJm5d0p9xQKQCwTWTnRkjuvJ2npEcteR1whxxAMY+Kk8cWjp4PJDGXv1K66Gxvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PAWPR10MB7176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 13:46:38 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 13:46:38 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [libevl][PATCH 4/4] evl-test: Add hectic for real-time stress
Date: Thu, 13 Jun 2024 15:45:57 +0200
Message-Id: <20240613134557.4013044-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PAWPR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 26331a3a-7600-4bbe-6e7f-08dc8baf3f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LHxjsiI6j9fT6CB8QdpqZ1Z7f1j2d+FzchbdhDkzEqFi66vBAMismnZ4C96H?=
 =?us-ascii?Q?SvhUXzlSEaIeGBjCWSgH1yfX78iFL7DchkMwmhnc98GwpB0TTvWasDqtLRzf?=
 =?us-ascii?Q?py6hRzvAQ2SzxHoWfAnU65juBzalyOF+2YX8xNwvSak7d+TLczbl4cxam+xC?=
 =?us-ascii?Q?kfIfR7pcgVSroorPxU4JjQIgwr+WaA3n6g0G9mRPoOorvalyPFQVEgQ3H2EM?=
 =?us-ascii?Q?gxAU6Iq0gMgSepReWZZOhw7GubTJKRROe0IRGkv2WdhL6U/YYG7wMGkxMkRg?=
 =?us-ascii?Q?JaFNEJccaVay0STR/iajz1YAatNC1PXF3GKpO5z3vShoJfFov2vgBUdPoMdH?=
 =?us-ascii?Q?RhpfQVL/ZTusqnerz701Jp0zXZxKMLqovQ0O5ZPjFRPDnVKWBt0FGLQlW+YI?=
 =?us-ascii?Q?OKRSynKFLpmf1BJwmowChVg6WUT+LMqOmpgvebgXdiSpNKBu54Q11/IixYso?=
 =?us-ascii?Q?ocSMnStj2aNGOopP93iFH1BuM4cktDaN5p8kiKkPv7ayvVBlkSmtNWYceygi?=
 =?us-ascii?Q?Ph8lfrFtfCIF/j6OF13f8VkieGj4HDWqFyZzelYcyLSsJCznaF1w67OomDZa?=
 =?us-ascii?Q?W6U1TDvN97dBFIW4VepMVQXo+g+1+/Sm7myNl39HiF4/wrbk6onNgJVSCb45?=
 =?us-ascii?Q?XUaQhhuY7R5kGljCzSsrT8LkIpbU/RJbnnlsfWPYGMiKqFG85UazXIi3ASgE?=
 =?us-ascii?Q?T34TI4O9u8PB0ZZq/vcPpii0pdUlPFYXCABGKsBQds9rDO/SnC57vSD6poyg?=
 =?us-ascii?Q?KSDvOshFDveIa01iXseRhX3FXLYfGdzGnAqSxtobX/PPujCiFAgWE/F8E9fG?=
 =?us-ascii?Q?1doQ5eOI/jSyztCdbZznHc0DmBaFfnYL2d2oiydZzjFzE24hhiLxq43qNRlV?=
 =?us-ascii?Q?eXQ4dw3/QGWdWOtjR7CNGxwdlIO90Eg5jdgMrDSeuEX+TKJ+wgNIYJxpBQad?=
 =?us-ascii?Q?I/vxIsTAKiszvxXDWqbIcKRCmEzn9tEg65ahxYJ78EZVYYTzX1JFyzHhuxIB?=
 =?us-ascii?Q?TUgkfdkru3GMIT7yvoKHNVYrV2Nfl6TwJHWss6CrDpYK108+YdtkT/PwggeE?=
 =?us-ascii?Q?8W0vPNH+mP3rwHN22z0p6WLkGu3hVPdngLn3h4LPnGDfm8uVb6whg1yOpAfs?=
 =?us-ascii?Q?gllhni1+nManyIGBEhpL4eJfmUtZHsvIIg0AAcNAbPJAdDo7pqQHuu/uwt0S?=
 =?us-ascii?Q?pwUxwcBzeA7QpT/lmK5CG4WqY7eWyo0Hhb5sg6XYIL9XsgkD4uVXPsjqSG3Q?=
 =?us-ascii?Q?SnpGOwXvPe7Aulfu/gCAv7LotJCsmEog1wLtybkS6b+/T+tFhycNftvAlSWo?=
 =?us-ascii?Q?K3v9zykaE4m5H3vdBBzouAme?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxM28HtRfIIXloXz9Wfdrd7ELW0jvIc//JE63BWCfwOS2+gOT8+CTW10ucbR?=
 =?us-ascii?Q?DA8zJe3QnE1CHygxVtrrSps+BPNM4CJ4Zk10KSqnKvCnLEX1AplvTCP3x1kf?=
 =?us-ascii?Q?D7MZTIehEcxJLwLLKxujWNJudg+hlkfHoeAyIZWOtMb5USYt0Ehj6ResKKrg?=
 =?us-ascii?Q?AwD5EMuaZSLdlsDJxUW+IzJbf2FuNrzy4qPgWh7VPBviFUczguiP9I2jcGyX?=
 =?us-ascii?Q?qIBkL+FG+LFP0Koe3bAvExIgR6k1fhPv6Zv0jax16WQVkjX5icFas+8XfH6Y?=
 =?us-ascii?Q?MFFoH4gsGDjDVW5NK8JwOe+LSH3XE9Y9I35EMqb0OaK4bzbyUlyZb0N1yqEi?=
 =?us-ascii?Q?WGoGdOKLo4tt+8r1JrxmaLcUw+voLW9g5F+9RjZRAhCg0MxRzoFmMB4HPE2T?=
 =?us-ascii?Q?ttlfsAsig0eIyO24LuGRTtfcW1WUAfpgczKsZ2LAU/37AAGRpCuRJx4M6NNs?=
 =?us-ascii?Q?ZqXDuYpgs5o+6jT/DDBVRHZY+y6QSffDvvj5urIc+mkVQoYHB5Tg7gVLRcN7?=
 =?us-ascii?Q?P6RuEjA3C9vHC4QEfJvWXKksn1WKG3/TPROTpgOYbEbKxRHwL0dbn9J5HDP8?=
 =?us-ascii?Q?o33autV0n2b/kCYBUYWkf4p2C67nzfAPMPvds6DKxqdx8E5LG/ithHVyWZhc?=
 =?us-ascii?Q?PdYJrd3cFzRSJUtxV4u+8Q7Asq9vuucj2zFizFLpGhEkRzDdfSmFDPw9Jxhh?=
 =?us-ascii?Q?d30ZL7KnCVAsppG4zrSXvs8YI3V4kFxXEjzVcz7n/+bXPd80wPDpRULXE4XB?=
 =?us-ascii?Q?ZHicd5dWU4xY7hWPprbX8shw9bhbLCXKF0nnHS9RLBnoXp/hnj0jPId8US+Q?=
 =?us-ascii?Q?StnnJxbl4mf4lgiw03yM3bYBpBK7+Q3KLtk7e6PndN6w/hdZWO77TX/sIhE2?=
 =?us-ascii?Q?xsY9kA1ow6qI9oaBcPf/1geBAgzsPPvlrJ1u60ny+wV0nlmYMyLSAfcElHSN?=
 =?us-ascii?Q?bqlOPdGWJ0ZFE3ZWASVF8H4DaHymlgrrC5BkmMAMQ449d0KCKG88ilBvHkrw?=
 =?us-ascii?Q?P1xhYmZgK6UX/Jbr75RAaZUqL9GD5AGixeSV49ZpZpFaWX7jbUbPcrdi4Q1A?=
 =?us-ascii?Q?UpOLAn/pZJ2hVbEIHITXWFSK9ErxnKzv0XOoUA6YGZSPCA66gq6IZKNI5wW1?=
 =?us-ascii?Q?5LzftaFi4gluyKxlqg+qulS4HFCNkeOkXdvZeik+Bnq5n5Drutn2R+9b4uV/?=
 =?us-ascii?Q?DQOMZx9M62DzNGOCOtjL25+dXVj15pPGuFMY6QZAd5G0fnhXNA9C0LeN5zRX?=
 =?us-ascii?Q?fL6IbMikblt3sVr4KtpRGZXSbE3d0UH8xzQ+cZFtw4YR+TQaSs32IkbUSZXI?=
 =?us-ascii?Q?Lnsr+v9DwjoaMTfG3Ap2vaWW7DkIqnqDl2lUfeVTmRDMjJ1KBMCVAHgSqs/i?=
 =?us-ascii?Q?ACY5HRJ//BTL5crwCHbDids6JeW17yN/ryjM7dzMVRxEGn5Yqr6/aTBjSyie?=
 =?us-ascii?Q?hB1SIcfkpQhvGV+sckEoLWSh3yqw+Xr8NyWmRG1DXmATy3McjG4NNHBEf4Cu?=
 =?us-ascii?Q?fWS7AiLlfY3/LThccE6hPtBOlo/YA7opTu1s/LdhsunCYVkbNZWylzMz8lw+?=
 =?us-ascii?Q?Rn8b9pYi0zFkpJpLJN99lQwjmygDg4LrERNP40NBWwsmXBTmcNz0g5awv6X8?=
 =?us-ascii?Q?4BqxThgm7h7QGQ6uApdFR1LuQDe+7x3XfBebKQVux4hxglJ0if0fS8wX5A9a?=
 =?us-ascii?Q?roIStw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26331a3a-7600-4bbe-6e7f-08dc8baf3f6c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:46:38.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSRIOt4ZutvM0aRBLGgTq+doc7PLZQ/08kMZLoSze05QFyq2ayo36fc5PklTbtkGNQ4ZfUYIbKk3p8lzShUcIF88A/uuI4e5TUcJgOFO3kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7176

The -r option allows to add realtime-stress by running hectic in the
background while running the tests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/utils/evl-test b/utils/evl-test
index fb85f69..9a12d58 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -12,6 +12,7 @@ full_path=false
 unittests_only=false
 load_cmd="dohell 900"
 load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
+rt_load_pid=""
 
 usage() {
    cat >&2 <<EOF
@@ -19,7 +20,7 @@ evl test -h
 
 This help text.
 
-evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
+evl test [ -l "load command" ] [ -k ] [ -r ] [ -u ] [ --list ] [ --List ]
 
 Run a basic test/benchmark of evl on your platform, by first starting a
 few unit tests, then running the latency test under the load generated by
@@ -31,6 +32,10 @@ By default, the load command is "dohell 900", which will generate load during
 This script accepts the -k option to tell the unit test loop to keep
 going upon a failing test. Otherwise evl test stops immediately.
 
+If the script is passed the -r option, real-time stress is added to the test,
+with the help of the "hectic" test. But beware: the latency test figures are
+then no longer meaningful.
+
 Use -u if you want to skip the latency test and only run the unittests.
 
 Use --list to output all the tests available. --List will print all the tests
@@ -67,6 +72,8 @@ while :; do
           shift;;
       -l) load_cmd="$2"
           shift 2;;
+      -r) rt_load=true;
+          shift;;
       -u) unittests_only=true
           shift;;
       --list) do_list=true
@@ -113,6 +120,11 @@ if test ! -z "${load_cmd}"; then
    setsid /bin/sh -c "${load_cmd} & echo \$\$ > ${load_cmd_pgid_file}"
 fi
 
+if test x$rt_load = xtrue; then
+   hectic > /dev/null 2>&1 &
+   rt_load_pid="$!"
+fi
+
 for t in $test_list; do
     test \! -x $t && echo "$(basename $t): no such test" && exit 2
     # Swap stdout<->stderr for the test, capturing stderr into $log.
-- 
2.40.1

