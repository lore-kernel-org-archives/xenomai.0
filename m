Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D01411DA
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286402; cv=fail; b=pnmDVeaElZ+PPK9a9sOkJGfbnmO7eedHT/MRAckqu3OJ4NcI4t7u3s+LbpbnUWMHP9CWVrV1t/ntpOD7HRqHBfCGOO0610iiiZok2QkLbRQoOzVKMKBhYXhHqFwMeZ/5JNGpwjRFO8SH0VntJmiO5TuBzC4VOognuoVC/EG5h8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286402; c=relaxed/simple;
	bh=90/9cnKItG430AGUkRPDpZ5cBACW+HZtMzfVadftxAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WTp2PZsS99H8jq3r4W1g1Cdsk0HEqdJDhdTTkkKtdU3VW7ofY5uk+3KgCBvgtI7Ajb3ad79z25dI6NRShl4LORI2I34SYPDktGKkJsUWdl2S0AVFDSZFTtv4tQBjzLv7dxmAcRUAJHap1hTwrNaQF9H7AIGk9/jzNnkMzvJVf5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OxpfVcCZ; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OxpfVcCZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBYMgVCrmGBqPC8BICs2Jj8fnk5Fqf/xjjFxCLRWHY3jJgvQIUgyaAR5jNsY4CcUpRqgL8hG9pU+a9dV2vZWWz/EFjdPYXx5nbcACvSXsNwVVOcMK4MynBftBuY890ZBcyCzr2FvkRvIz5jH7TnCOEPB+BvhOC5p4U2McEN5gssH2ww6oxGW1p8GRL7OZTxK8B5QssN4iH7n0g/nVS8+6hoPaheVRSLhJ4tm4RAx8wZrBqLhkffoIrRKN/UJDWVrgUdLYYjwwy+PPMc++JacvKJKHS0lH1JoeWuN8f/WWSin/nR3nnyzfwfuCka09ljciiDCySfOPJCzMvWs9SreyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Brbu26+4ek8CUrY0G67d+Jc5p2DVgw/2F6CTQdxgOfc=;
 b=PN32BEotQZasH7k6gXRtL7Z7PCPafycMj/H/FJL1BYpEnaVrVXcE1PZzeq5eGnpCLlxXv6emFCQqf+r0yYwG29VoiA6OGdTNc5dGlwsST+2EFpkjv3QXSWqgT86ZLyrfI7kKoQAZt+4BMe5VhLFhwe0kOMAAPGfw76EIDzsJXju2m3nGcwUbejNtN8iWgkBgDyApWHAYhTFxpMf3IV0CDs1KfWXXZKGtukWQxBQr+6aVSVBOhl4TD+Mv+1hrW1yAzS7qEXQNaeHaNdsCXwnf48UwcJAw4K+AtKc+SDxzvknpKlQ/UAMG3I0upuBsTgtRD5RZKCPHxIkPAngueRWumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brbu26+4ek8CUrY0G67d+Jc5p2DVgw/2F6CTQdxgOfc=;
 b=OxpfVcCZ3T125T1vDPXNg5Zhun5dx7tMTYObbG/iO8ZpDV7ayhAPa2blaX0OutJLkz//d/j4TbV1uBNttm6MEIE6HJVDSJNX76doa9NfO6VwpoEQawrauClxqZ31ZTNOf72ocGNEDxAvkSu4w+TcXB3fPstj/9DZVbeGCAXq4wNIfvzuFbnb0w8gGYJomp43OdqLP9a5pCEBhc4goSaZjWReI/sky3Av5JsxD6L5C9ZXyrjfFoSO7XJv4F+FW5B405EXlk3VdyC8nXNyOyEPnD7xzuzj7tia7+YLe/bdrxQrYNzl9GL3Uoqgu6Pr76BTpSKMwMLrG0uqeeTLcwxiuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PAWPR10MB7176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 13:46:34 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 13:46:34 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [libevl][PATCH 2/4] evl-test: Measure worst case latencies
Date: Thu, 13 Jun 2024 15:45:55 +0200
Message-Id: <20240613134557.4013044-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PAWPR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: b2380bc5-d6e5-42dd-afcf-08dc8baf3d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fT20huMmDNxXwKnSts6qEw8C4ck3Tu2Y2VajCyGPkOthjPjwBAglLzQPRpN/?=
 =?us-ascii?Q?9rz4sYtycQBBdtKFwJMJDSeIX3QsIiIACZOLPOs4BK51jY6CiVhgzVavGb2r?=
 =?us-ascii?Q?Cgpakx4LnA0ZRh85GePRgahBdDfp0lzWC/xfqgyzfSZEdBReCDJ6Xyr+4Bqa?=
 =?us-ascii?Q?O4r091e5/LMqf8WnnyWVb7J5Dkt+VS71RQbKV3/7Yw2WB/WeIt7+Y27vPtiw?=
 =?us-ascii?Q?3wlVcrLd3nAjFgVgM5SisEPbI04UZ/Mf2XSyX7tHCFcH1lpoKZkq9bkiX2Uy?=
 =?us-ascii?Q?0lVERggWz50JptI/5uSJ3pa8JG/JUKjd7qFkdpn1TbCpwaUeVITItsicvLGG?=
 =?us-ascii?Q?AtwFaMiENxTkGn4PmAavqdwsaUEQ/qJ3Qs7NvF3qgKwyt85E7UaIsrnRpcFF?=
 =?us-ascii?Q?yb6YcJV/YXAgv91Z8FHzs/nvQRonWS1igwEDjdSpKYmgvvyXFtq2ylrqzIG6?=
 =?us-ascii?Q?Md3MxuEgEr3J1wtumpUbL+1VKk91q2+kBAdi/n+8v5e27IV3xvQ+0IQuflt2?=
 =?us-ascii?Q?QEaDERKAZyGiQy2WPttRuWFym59W1JMpsQXwObsfPIzaQEWh12mnjDk/AvUM?=
 =?us-ascii?Q?vNSkrUI8SB5THm6wB4hwtRwEfYpWPRqluvmOeCbfjGMmiJbloe1XywGxPda5?=
 =?us-ascii?Q?BfaU0ULaEM5ZLcZMwoHLWffN5dPcjxitGZ8s0Y8f/zEqCbLQALcpaHeL5gra?=
 =?us-ascii?Q?/XSFQ+svgeqvD1GZLuvghsAju68XxluZTYDFesRSEmRaCx7LiPruSWfFTXvB?=
 =?us-ascii?Q?/DZnW7jJmsbiPK9aHm5JHykGpxW2q/47D0d4vbOJRe0h8XTg8GwPmdF72rCl?=
 =?us-ascii?Q?hGjdhuuGDx0uNX/AOmz7nOIBz/DnUAVTs6qTGBZxfaavTfvCgMQHH1MM5uQH?=
 =?us-ascii?Q?kng21Skj0ODcg2h07SVezkQ3B6YD+/jJSHwlxtHKyNQSSsJSNNyG2gcC+jNh?=
 =?us-ascii?Q?Tqf1B88UIENk27t/rsjhT/Zm4ZLrcv/btj+XrVwtDPkrfMcJoEhlich8dn6O?=
 =?us-ascii?Q?6KhYIFmqvji/UO97RC+Q8ekvZrUjjtZ1M9QvdrOylBH8LJoK8rCflUOh74zq?=
 =?us-ascii?Q?HcRwoXNi3OZ7mnOON/joh1/9beMfwjikxMR/0WlEYJg3VnNZhkd3m6aX4Beq?=
 =?us-ascii?Q?BybSUFaVbxgSFm477VVENIAZY89U+Zzw+Lq6ZRPjsOPrdDM8BCmtO646jDjB?=
 =?us-ascii?Q?hndxJsN09LhcJll+EQS9YGhWaxlgvNkofNEPz0KA+4mTT4nlqwlliQMeBTXI?=
 =?us-ascii?Q?kiCdZFKYJjrayILldXxXLWivD4MgGqmbR1wcgLOVtdej4+9cSBt+nmCwFNXO?=
 =?us-ascii?Q?HqLKp53EFE5X9V1X6IOnAqfN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lI2Cg6R3RM8EJjCEVr/psMFcFFmLnMcRq0ZheM0t+aNSOEUaEnYj57S07eaG?=
 =?us-ascii?Q?VDZz8IAkMqgN7yJJJuUOiv59ujleRLZMjN0nAwvInM4JZ/3UyoAEkpzM8a8c?=
 =?us-ascii?Q?XHDxqMxiL6r+ptxU1BbNUdOgXTri+FaX5xPO1ShL/fFiDrxub/PZxUa3Lo7N?=
 =?us-ascii?Q?LOXhLExB4ZpPhJ+nmbVjY36AQeDSnuQ0ApYUaX+2Gc5QGmY4G0Dg96xk5CHU?=
 =?us-ascii?Q?Q/Ti7AkXuNU71cvcLIUyiuXs3huTzAtIH7shHnNkgAJ8Prqwm2pNmWsTrqxp?=
 =?us-ascii?Q?ZDwmNxfi7kQ+jeeWDqpTjyBwGAbxOJ90sMcAk1/0Gqi63SA1WH3O4Z6dW+Bp?=
 =?us-ascii?Q?5etODpLZ98wzYHQtn1w6eNqPMkNxHZT9kSsccrZ83fSBFX92V2pskBEBTKlL?=
 =?us-ascii?Q?LxG439WKYo1/vHfcz8kG6miNEtr5Yzn78E4N/UPxGE3dWSz60j0CSA5aeoFO?=
 =?us-ascii?Q?u3B7mLOnQygfIoW4MW//Nh9ug1KDdYN8yx+SRKdEydUkDaKiMfGsybC6wpcK?=
 =?us-ascii?Q?qcWsedh8LNFiParW0WhfAxYlTX1c74lMPiQzBUjwYuGkcnMuqdKjwncW0R5N?=
 =?us-ascii?Q?6CMylTwfm0xhqQl87FBMvsDdlJHmXPtIWZRMIzvPokOpc86X37Nk+GuHTmDp?=
 =?us-ascii?Q?eF3XMJhD9zhIFMwnJ1njDnnRT5lJ4nDxJ8PMv9LxicDv9g4B19ya/z2b8xfM?=
 =?us-ascii?Q?3MyA93KwYVNg4PJnO5nxdMZK0bH036Eb5FnRRT5VVUEw/eeGmdE7daKGaZ2k?=
 =?us-ascii?Q?4yTZ2AZYnHwMoRNO4r68YIrPtpihBt1reZMykRg1ckHkcr9QYqZZ2p8RaIdL?=
 =?us-ascii?Q?O53IjTYHNf9Vs2FaXbz9vTCGZDdar/HFCpFlkTCwfcYJPW0zggg/RUpXH0Fj?=
 =?us-ascii?Q?GUHZDtNqklsuqBCw7qODcM/XQoK+gjzpNMf9ilrRyDrFKdLalhgBNnfmIx89?=
 =?us-ascii?Q?P1LkJE7CxwOUB/fXu+D4PdqD1jjVNUVJ+KfcvNWIdTO3XzQV+voGAZlJLytK?=
 =?us-ascii?Q?w+spo/YwvGjEWuAxlHGf0gUSiM+XxjX/u2n/8nXP7qPlRXped8Oh0AUfSuMd?=
 =?us-ascii?Q?mkLfdzhD87PSwTBQajGfaoGzgMj5SlslXZ32a0X/nIFYHNrYp4UDEM5eQodG?=
 =?us-ascii?Q?cMeim71mtGYJrEHMzoi3W/ZiDsaUa4M0OjKHBQAc8p/e6KWkryIZYT8bBym6?=
 =?us-ascii?Q?AijruuqQcgG8QD3SzYbBDwu4VLAkZMJlJvJzGhWq/JjT8j+VHq0wjIgfOLhW?=
 =?us-ascii?Q?ner2+iY3f8gYK91F8sRqW4wHT7AnnZh2On8Olzo/W7ms21Cl0GUr08RGr2qj?=
 =?us-ascii?Q?xTRVX11aF9cC85cam2PkxtThf18V6PKq85ILDu+7YdMluhTn8RzmEEbt9MAV?=
 =?us-ascii?Q?DDJT6/CY6W6WHa9QJULv8g53LeZ5MvXdQAY8nq2WPiuP+mPvCQaxbwu6UAj0?=
 =?us-ascii?Q?/bc9vqoQZ9ItzKfj0MAieStx7XQ4vcL80MLZhiguqyWq6kw2jA0vSvHIXTcA?=
 =?us-ascii?Q?BAozX9jGlN50IayaU5ACQnAaHecq22ThlfY4ugP7KSdOQfy6CBC761ibjdxY?=
 =?us-ascii?Q?FeHAj3ITMze3UZmoxDDbm8J/Ht4L3HlCljgPnWtx3tJlXakIrdbjBQN6hDdA?=
 =?us-ascii?Q?enzuqu4SnqIJqr0yt/jsds/BtbNcycm7qgBhhyfv5jqlgOtJgDItBYJ7h+EP?=
 =?us-ascii?Q?o9WdsQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2380bc5-d6e5-42dd-afcf-08dc8baf3d4a
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:46:34.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R80P9o/upNoZ7SDAEcIpKiBFNrejuxmEfWh3iAOaeQHdN7ampRe1mY32dgOh4dO6yBKZkB9kibdwV6AQYq4DvyJVK6fYQ9CmElR1Nuezi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7176

Run latmus for 30 seconds after running the unittests to measure the
worst case latencies.

Allow to run with -u to solely run unittests.

Drop getopt to simplify argument parsing in the process.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 55 ++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/utils/evl-test b/utils/evl-test
index bc7440f..5c1c3da 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -7,44 +7,37 @@ if test \! -d $EVL_TESTDIR; then
 fi
 
 usage() {
-   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h] [test-list]"
+   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
 }
 
-args=$(getopt -n $(basename $0) 'h@klL' "$@")
-if [ $? -ne 0 ]; then
-   usage $0
-   exit 1
-fi
-
-help=false
 keep_going=false
 do_list=false
 full_path=false
+unittests_only=false
 
-set -- $args
-for opt
-do
-case "$opt" in
-   -k) keep_going=true;
-       shift;;
-   -h) help=true;
-       shift;;
-   -l) do_list=true;
-       shift;;
-   -L) full_path=true;
-       do_list=true;
-       shift;;
-   -@) echo "run the EVL tests"
-       exit 0;;
-   --) shift; break;;
+while :; do
+   case "$1" in
+      -k) keep_going=true
+          shift;;
+      -l) do_list=true
+          shift;;
+      -L) full_path=true
+          do_list=true
+          shift;;
+      -u) unittests_only=true
+          shift;;
+      -@) echo "run the EVL tests"
+          exit 0;;
+      --) shift
+          break;;
+      "") break;;
+      -h) usage $0
+          exit 0;;
+      *)  usage $0
+          exit 1;;
    esac
 done
 
-if test x$help = xtrue; then
-   usage $0
-   exit 0
-fi
-
 test_list=
 for t in "$@"; do
     test_list="$test_list $(eval echo $EVL_TESTDIR/$t)"
@@ -89,4 +82,8 @@ for t in $test_list; do
     fi
 done
 
+if test x$unittests_only = xfalse; then
+    latmus -T 30
+fi
+
 exit 0
-- 
2.40.1

