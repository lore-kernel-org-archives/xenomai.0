Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50120BE4E
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286400; cv=fail; b=XcJhhU7M4QbWgvHTyfn+PfUq0g4O0o0jKxRe4P0OV/U/HierXtMeFR9o0YzVhhBotnMRIA/ZO7EGBSiMfTDraovpnWeNl9U/Vl5qu/mrl4N6nQ9nZEW/BKE9gKx57h1qEkP5KAcCaGMg+9tnigvV+Mk0ZJwKIioovtMwnOt5Gqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286400; c=relaxed/simple;
	bh=KdMdNSzA/WbYpi+J1azktE1ijVRddvoSJGhnphr9TKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCEvwtobeZ3XGpGCcFFhw4L2JOgxbfe/roy3rrNFQSnNRZssM713slFmvHsEqJvg+v5JJFapRak6WwWlFVrcW3O27PhzNrIjbNJUfGpJHcDcNm/4+HLuMXxYf+qh7ZnVQqQZxxP7JUyYqcS5YB3qCGZ0M9YfOlRYOb3rTbmCXjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=n2zCB6gJ; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="n2zCB6gJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG9W+ST2q0l9ukvO4RmG8E7ML/4R7UhWJssIb2APodj9Sui9Ee2VgKBg01bzBcwEayjpZXE5w8p4sO3I497CVYiDT8zH2IWwfGRFn8bAT2ciNS5yG1KcDvlixtnC29cOX5iMxfLUJZmUp2oNRQxxcpLlvUC0xy3CYIKJ96296cW4RfqAlQvd/8iFE+LbkT1Cy5JX3pBZ53pY776GFU0hfb9M4MquXwB3iPyoG+tb6wSxyM5Lu39sBYc/RAOgkN8xlZlmP3MoBkEQb/7RaeA9kdceJ3E0wI8dTw1W/IH4ch4gtp2m2y+EC12IwchyzPgAOX1uoaXv284keoH6BVehwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7fo+pKj3ZrcsHdiEHD31r3Mvtf/T/MFviEXuqe+uSA=;
 b=ZWNpOpEQ9BhJiN3YnND9LzNuZrC1PwffvJXm0yvpGqAZJSTjFdj4MRy8KFcUSqhyHCGjQj3g5QzXNqj253xHzsCSe3SWaSBcon6hSrItcmARx1Okm5AoNZAL6QKV/jadp3C9YtDtr8jem9epSxmO+haKiMFRbRQFAPmBwRzQNMM4sIiuuqMw/d8L18HwJvlue2mYlFZm7rIkmxoMwZNonA97A0AHOl5cjYiL5EjyvNYf5QBRZguPlcwRFPrsImaAzJ9um9dhwa9tHeOpAOxMAZ/PUBBkcMp3R3nc7zQC9gmGjlHivMmHFgwaja4S+0i65AvMC//abJ25VZ3dCh/33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7fo+pKj3ZrcsHdiEHD31r3Mvtf/T/MFviEXuqe+uSA=;
 b=n2zCB6gJay3HDpikmBAW/eXXTs33LzYBkymWRksPoH0D+EcBodjWqB9eR9GGwqvh4EnPjwL+XbZVepBzuuGezZ8/Na6ZK5taaf8bWaStCU8pFbqJFydJIf9l3it0O943L+miSDz6wp6k9Qy2iQsoas0gnxy0DLk5+qz2u0HeRKyeGOm11ULSOlyHSUiHHXEqj7reuK4v10dobXhiydp0KUwWUSXLmoQ7sqPZiYqrbEgLum585LvwQTexaJPV4eHH11a1tIsDy93o41O0Maf+SVFusbbkSEizN6X1dlP3uUwHkTjjHEPtHtSqlcrVKbaRD9AdlLDsNj1hS4LQKBqCaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PAWPR10MB7176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 13:46:32 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 13:46:32 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [libevl][PATCH 1/4] Copy dohell from Xenomai 3
Date: Thu, 13 Jun 2024 15:45:54 +0200
Message-Id: <20240613134557.4013044-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PAWPR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: ae098b40-6c40-465b-a01a-08dc8baf3c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0IK//37A9E2Z2t+ckda/duILI38vqm7ZCPEA360d8MzvU0FZPclq2orF5Ek?=
 =?us-ascii?Q?KT5a079KhakTB3X7pRgLNpsFLvEVd12Iy+gPmnXyxSZgFP8kYU0ZUkhK+sIm?=
 =?us-ascii?Q?e2ntR5sAImzRSOG95cNNC+TXEYhnQfrXfEO3decJ2aTmTAQi2f3FfP2mrAC3?=
 =?us-ascii?Q?8r9wYnCxz662VkFRgF5XRn99fuUAWWt78g5r7+OVUv33bwDuLFhJJOGNfGjM?=
 =?us-ascii?Q?a3o+GJBjIxNUqNkcNTypBdemENfpzmqfVFVHL5UU1ukQppCgwcj/avKnBzcL?=
 =?us-ascii?Q?OdgEwHApzBorut6P01g0FgyKI18YiPH0tcdOwXs3VYjej055WPLnGYgbP5GS?=
 =?us-ascii?Q?0rkAk4p+LW+MrVZIinr7UmsT3tU4FplncDtssF/1h4fA8d6Rwbl/IQ02zoO9?=
 =?us-ascii?Q?VFPy24u2N1bofqYC1fIecOxqZ6b0w6TdgdaHrM6gJCLdh2+cxloiPERl1xl0?=
 =?us-ascii?Q?mnJ97h06fSrA/yb482qW7bhSnoQpoSD6ZKAi5TPv5NkCamm71zSnlUOyIdFd?=
 =?us-ascii?Q?2f+Rm0PE13SYRKKXAC2i9Vn2VLFNCfKYAQr7d3iwUag9zP25RwIcxblO+UWK?=
 =?us-ascii?Q?mZAYeiyynRdK0PFaEpAdnqhINShuCuMYIt7091EKMGMdkucZ7guUuo0VdwdV?=
 =?us-ascii?Q?w6M/4i5BNBx6Z2PFXhGVmXgA4Z0aGbNgOB0iSLUK86sJ66fMsdNG7YRaFqpG?=
 =?us-ascii?Q?vGV/Ln8vik800t+O5JdoUGUFnNfAPJSSboWVz/avUz7Nc8PzIS8TD9T7xUdF?=
 =?us-ascii?Q?uPdlhmTIrrb6b/1uRqDSLw1ueXvM0UbhwJ8d5QX7sB63CSkjye740V/MoSty?=
 =?us-ascii?Q?wVmYf+IWshoX2o7U5cZQ8x1NnvHjAZfGkuuG33QwQtGLWk1yEUlK6AXUCuU1?=
 =?us-ascii?Q?QFzOGZ6M0I0w7Q4iXLNkJxbJTZY6m5Nut4bqHo1JyuO1FvWlnf9MmUTaG4Ek?=
 =?us-ascii?Q?LPdB6/+Lnf+znGSq/pHPTtm6JRIo3j6Ru0tQa4jujauQnQTvSfrw7nQ74K0T?=
 =?us-ascii?Q?zrJhypYkZyeF8mpYo+75R8DvMO2YPvoS3Le3L51HmCp7epTvBT0n5y0ZSGfV?=
 =?us-ascii?Q?5stdr+nK1BjLBHDfoiYz+N5gWtyAi94OlU+2gxPSb5tP2lwtcBSTaoyMlxVj?=
 =?us-ascii?Q?qbxJaE2Iw+SSfeVkqzCUiDeoL+uGsohR13MPriJvVIcFevocfn4nfppjasuQ?=
 =?us-ascii?Q?s526BVgmavvc3J5sMMjBP+kMRowv4gqcgsOtDbm40O6YrpMgIPCxDZxibLoE?=
 =?us-ascii?Q?xwJqIjVcVLhnnS3ft/vu4jeZRfKaMe2oWBJyGW21cv1mmes95gBXb4r3g3Oa?=
 =?us-ascii?Q?RbcZqp9W/QaRraeGxEy3enTT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8xnV7CAzUmaT2AMptHOoLU738SvnrCn5vIHfm5pCEfKK981jxzmYY3da6oUr?=
 =?us-ascii?Q?sNJ0ZNqnQ7qZP2VKVSCeNtwLR+R0OscjfvcKGqoXXRaLu6dhjOVMSOQdYCgL?=
 =?us-ascii?Q?nNesz09zz+Ry63sQUqIadBzqJ5nWHlfsSPq52rNQGbDJSizdUMkwYc/zqU/m?=
 =?us-ascii?Q?3uijEiQQB8ggswnfvcqogc13qhPOgkJNY5EZKd9qgTns3RfrfdoI2+RN0n6n?=
 =?us-ascii?Q?wEUbVI/H7dvHn8LW4N2rBWOTxo3zum13jXvnR3Ny7rXhI6vKxcvOeTzeXVkm?=
 =?us-ascii?Q?1qUoQPJEX4UrWndBSMAsraPPfW4BC3nW2buc2in2rxhkZUWA1AomHRpySmXk?=
 =?us-ascii?Q?xNRUvXwDN1BonAZqdCcYhaCham3VP8HbrA96pu8jzPL/gDMatSYq7/nP5azu?=
 =?us-ascii?Q?hHqUmipJdrq108IbGI9QaP2oHIsIoNVT7MczIBCSkMWyi3P97xVv8Di75vQQ?=
 =?us-ascii?Q?c9LASANePjrZZPSR3iD0CNX5xezBUtOGUn/uSjXMq9kaWJtRs3DmxXhhnveS?=
 =?us-ascii?Q?Oh21AAAgvGdZWwOjOTMeUhGrb1LYS1P/HCfRttmcKeeawO4NYPUAlsmuqeox?=
 =?us-ascii?Q?iUjk1EzTxPvtSeiT2Yi2spbLOCa/J/HfailIHFScrKAuW4BFa7FcPmO/lZH1?=
 =?us-ascii?Q?KPnTTNChyv4W23ZVtG4sWyjCSEocNVx4EMGCNLDlsQg/eaaaNbPgSeGr5tAb?=
 =?us-ascii?Q?R645T+iCYPC7SNDzzJuFagYLSO0ml4+v2kGpXy95HEuNTDXqNq8jK8ANh0br?=
 =?us-ascii?Q?BzVUr6ZiCuHKzFWdAp3UBBU1bzrl92abXVF1mz79K5flUKaLKrnOW6+3ClzW?=
 =?us-ascii?Q?phjh6RH9uKK+QZoH9RX02y7e5S4nZQR3PvP6XIJcoE4iWTvG0iy5p+Crw3tr?=
 =?us-ascii?Q?+cnDhPjjNk5KLJhlE8dQOviynxKWp/cqPc4LwoSp73F9KtbMe9SZMX4qrtPu?=
 =?us-ascii?Q?dynmOx3z6uoI3E1178BQCwm5k9rv8glUqM1bYQPcVz/FtVRawi7DH6GvttrK?=
 =?us-ascii?Q?WzzjqofFWN0pOycqOXhdr+8Qc0HWuhlKeYRULNFub2cvat6C0QdH6ww94eVw?=
 =?us-ascii?Q?rjaz7ht8xZeMqn+LAAoPJBsriXKrdFPyWyFuYsOT/YQknXgaCBoSe6ezk7St?=
 =?us-ascii?Q?s5qrHmMrmgdKKLh3ooFCiRfbwri4WcYNqw6CsUJXDBtFSLyRy/vFD7XFhbAi?=
 =?us-ascii?Q?CnY4kYFE/rb1uZRM7HfrFblW3jboHgdnVUi6QntOyOdK8q82WCPv7428D522?=
 =?us-ascii?Q?fIR7oyhOWGtmXnXVoeoWmCnFXGGvnHAGr04LLf6Zg0aAENETZVGnhISzgCFo?=
 =?us-ascii?Q?l4hEFMUBVL+WfmBVoQSKU6OsylgKTJw+cnzojf9EhedrOVO5y+98AQw+cSuJ?=
 =?us-ascii?Q?MhAYVrgMTZEgsXwf60qM5rwxcTQpyBXJ+MoWK2s2RfZ5A9K+SS3RrjpBgLVH?=
 =?us-ascii?Q?EJBt7lg105P8clBEAli77ZOuCuwWW/dIpHs+B0yFwK/BDSrB+kzzHLH9kgkV?=
 =?us-ascii?Q?yTROF37CylMvwQvFdPc7uBv0z8XnkJ4GYwph5S4KL3QZ7Dmir27DBohyHFV9?=
 =?us-ascii?Q?1yQrmJKLfGEJqH3SyqVcdSdci83IIzy9eT45qMGBMR4lK2/thiIR+LGRpQkI?=
 =?us-ascii?Q?kpRF1XSx4z6dctW43ZZLmBGf7Zqvgi+mf17t4GXd2FlCzjcVD8J2nhbKckTs?=
 =?us-ascii?Q?Hk+Row=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae098b40-6c40-465b-a01a-08dc8baf3c5d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:46:32.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUF2K16Muved0q7lv9hTG0chJcCP8R/yIunEcfh62lJhSy97SM6a5l/+FfQJjfgk+aRwR34K3MqIiL1kneY+g1Km6jWyORFjP7OsAgpziqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7176

Dohell is used as the default load generator in Xenomai 3. Add it to
libevl to be able to stress the system while testing evl.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/dohell      | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 utils/meson.build |  1 +
 2 files changed, 98 insertions(+)
 create mode 100755 utils/dohell

diff --git a/utils/dohell b/utils/dohell
new file mode 100755
index 0000000..ea84d4c
--- /dev/null
+++ b/utils/dohell
@@ -0,0 +1,97 @@
+#! /bin/sh
+
+usage() {
+    cat <<EOF
+$0 [ -b path ] [ -s server ] [ -p port ] [ -m mntpoint ] [ -l path | seconds ]
+
+Generate load, using an assorted set of commands and optionnaly:
+- hackbench if the path to the hackbench binary is specified with -b;
+- nc to send TCP data to "server" port "port" if -s is specified (if -p
+is not specified, the port 9, aka discard is used);
+- dd to write data under "mntpoint" if -m is specified.
+
+during the runtime of the LTP test if the path to the LTP installation
+directory is specifed with -l or during "seconds" seconds.
+EOF
+}
+
+port=9
+while [ $# -gt 0 ]; do
+    case $1 in
+	-h|--help) usage
+	    exit 0;;
+	-b) shift; hackbench="$1"; shift
+	    ;;
+	-s) shift; server="$1"; shift
+	    ;;
+	-p) shift; port="$1"; shift
+	    ;;
+	-m) shift; mntpoint="$1"; shift
+	    ;;
+	-l) shift; ltpdir="$1"; shift
+	    ;;
+	-*) usage
+	    exit 1;;
+	*) break;;
+    esac
+done
+
+if [ -z "$ltpdir" -a $# -ne 1 ]; then
+    usage
+    exit 1
+fi
+
+pids=""
+
+if [ -n "$server" ]; then
+    if type nc > /dev/null 2>&1; then
+	nc=nc
+    elif type netcat > /dev/null 2>&1; then
+	nc=netcat
+    else
+	echo netcat or nc not found
+	exit 1
+    fi
+
+    seq 1 399999 > /tmp/netcat.data
+    ( while :; do cat /tmp/netcat.data; sleep 15; done | $nc $server $port ) &
+    pids="$!"
+fi
+
+if [ -n "$mntpoint" ]; then
+    while :; do dd if=/dev/zero of=$mntpoint/bigfile bs=1024000 count=100; sync; done &
+    pids="$pids $!"
+fi
+
+if [ -n "$hackbench" ]; then
+    while :; do $hackbench 1; done &
+    pids="$pids $!"
+fi
+
+while :; do cat /proc/interrupts; done > /dev/null 2>&1 &
+pids="$pids $!"
+
+while :; do ps w; done > /dev/null 2>&1 &
+pids="$pids $!"
+
+dd if=/dev/zero of=/dev/null &
+pids="$pids $!"
+
+while :; do ls -lR / > /dev/null 2>&1; done &
+pids="$pids $!"
+
+test -e /proc/sys/kernel/hung_task_timeout_secs && \
+echo 0 > /proc/sys/kernel/hung_task_timeout_secs
+
+if [ -n "$ltpdir" ]; then
+    cd "$ltpdir" && ./runalltests.sh
+    cd "$ltpdir" && ./runalltests.sh
+else
+    sleep $1
+fi
+
+kill $pids > /dev/null 2>&1
+sleep 5
+killall -KILL cat $nc dd hackbench ls ps > /dev/null 2>&1
+killall -KILL `basename $0` sleep > /dev/null 2>&1
+
diff --git a/utils/meson.build b/utils/meson.build
index 59d818a..17d91cc 100644
--- a/utils/meson.build
+++ b/utils/meson.build
@@ -21,6 +21,7 @@ executable('evl-check',
 )
 
 helper_scripts = [
+	'dohell',
 	'evl-gdb',
 	'evl-help',
 	'evl-start',
-- 
2.40.1

