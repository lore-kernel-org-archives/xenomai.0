Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F130F92D
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959486; cv=fail; b=p2IBAIFAYLKWojQeqrPf0vMq8cLsCKZISsxHXLwADckwffcicFsgs5vFMJNpDpSR1QsdrwD8OlkEhi/dTMzULz/SlYesXUKtwcNplfEhH44FagyVpOIsCztZ6CXIj1wOHRVKpXYOvXjRuwBpUJXvV8caRFtaZTrtJiEJ83Bw034=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959486; c=relaxed/simple;
	bh=Ab1blifm7WKkUdTMxBcXlSoHY3H+78GBpCjpASj4xmA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J6VpRfBSs5NBdbhKGGsIwQiEBBQTqhnWETrUKAX1YtUiXO4o5StE5Qq/r3vNIMt3K78ui9HIR+1sefD63suNAKI5HcnYFZWhK1fMvB0suWIxNCqyOWhtUeZp4aAlyggPjxZoHLASAlTETj0VqMe4isiZv+qcmhHl+Pr+70C+e2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kbPCDAei; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kbPCDAei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5axbaLOcSMjMqc+QL7lRd+zsOqRVBntnzBpGTCdFDGoYplvXXWfdQECH8p0IpM04LBLz9NVbO3UqyiS8HwwIrmK/7ytfwspetU4+hLGVwYoGxS0ppikXNgIBCiuAu82tkXfDFqmnEcKnQjOh9iYOq8S/kYNTn37yw7zOmivL3uqFmWTUkfjX9Gt/hvffIUeQ0rHVdHtnFBxWb2haHI6DhhrmCw5x06iHzlCKHm0hD0T0r9Ih19pFjq77kR7oX1Qniv0MMz3Vbq3RRZkGnZKLA1tOWCahct+5UOb5yFb9FII/iVkFNhNfQT0TUlOEs7zUtb9Mnfk/EV4gY+ipFlMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKRks2ERitPktmAnjnXduHH6fK2UPNu1jVcOiI2v0No=;
 b=psRLRTPbYBLnlSQL8DNobJi4duEHAotnbjng4TNmYXO7uVEp2/gi+mhHCnP/6Indr14MJ+OsE2I8LwbA3g524VMmTTl9lQEiLTLoftAVCo9wXi4SbJr9dMt4Q6g+eIQTyssK2eFn85DE1h7Y/4mIE7IbHpjMXAbx1u2bPyLd6PB/6V9nEncMNlRTl1nm5keQKr7zzwd3RixdYpAHf1v/x4Tr7BUPCuwbdvirx1L2uGY0AeUNY9TQXa6fv39DsaEx/TRoG+T21sB0qxfA3JriNjnFNg8Lal4J2LJjb0yvNHHkptPkjGfNQeBGftVOm8sOJY98egoGDLF/x2bdXRa/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKRks2ERitPktmAnjnXduHH6fK2UPNu1jVcOiI2v0No=;
 b=kbPCDAei477LSzg2jRDsm33TFCUm0ExeODl44jPggQx0LjfBaHVOoB5xcA9t16iYG+sMckrguqQY0X+4JgxhMkXCuecF2OAQqyNgLu4dwuGQjjaTnMvEHc6CJefAYIenkHnLF7UHSIaz0hX/0T0kfWXGJvTML0taFcxHJAqsloCDnhJZf/T89LMA+iggX8xRv5c1z3XoH/UgFPfhBCbOQCPUnsb88T03hgtLWULdYZcn3pbvWvO/eCVZxdb9vOv+UKTBE7AFqVJuF2vTXPHBCbWaBnpRE7vgYDDafdCBZz9nkq7eFZlKGVmYKRLorEMdsJetRw4Tltay5TbSP/oDBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM0PR10MB3185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:187::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:18:01 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:18:01 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl] tests: skip clock-timer-periodic on virtual targets
Date: Mon, 13 Jul 2026 18:17:54 +0200
Message-ID: <20260713161754.73076-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM0PR10MB3185:EE_
X-MS-Office365-Filtering-Correlation-Id: 097ea060-ecd7-4a0a-bbc2-08dee0fa4f5d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|6133799003|55112099003|18002099003|56012099006|11063799006|20046099003;
X-Microsoft-Antispam-Message-Info:
	VER31HIvhnkMWvJFrnUzVGgv4Y0MRDBpVrWBA0yTI2aj0P5i3KzHpsHBzON1ikHPwpBbqjQlzcBkCyaoaIgTvFw423xEnnshRIxjDla143QpXt6AX79CiFhshpWGlqY8U7p6mBOvzRi+pu29fSZNvNnxTRNpXFV+3+WvPJuDte710hjpeDKuv01R71uTq+EvQtYnL64hsA5WbUb0iBYxzsfkr3OmRo/ht3DhaU85Mxoz3FA9+x1+zhr6pLhktxjwFvfGTR32MmnZsEs9f6M+2Q2A6YkCCD+Ak6WMyZR9v/G/vwcFKtVTc6FdSuZC7kjt6IEEFWZXjzPcxCreo2DX5hyjoaOTMEloAE+mNFaxGcocIWceEoJBHE3velCyjx9MokT2hpdprSJLUANHhI4ZVyzBJHgvtpoAb3tWLm/QRjwdGox1qw0E9MJV7G0jaT5R3HSu5lilK31NB3AGJdDvyOfJTc/x8sjJmewuh7qAE5ozk9XI3RWgqsFj/oQSLVH5z5zX6zrhxhI/i2IXsv520qYA4WlDs+HjuF47XmDUe/7EeToHgDHZ51xaIsB50MYPm7cVqM/83U/sKPLvhGx1RsbpWuqQVjrFR9z9nZ8OMQVw+UJBMgQ/Se1PU9GBRfmH6mzSNfjTrfjDmwb4qAfd/oVOcfBTTpEv4PqMyjXsFU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(6133799003)(55112099003)(18002099003)(56012099006)(11063799006)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VoBa60aEsTRicFmyGrwJuoTHakbUh/qlVgn71r48BEFQdTQAAsG/pUsHNgFb?=
 =?us-ascii?Q?92muIHd1PN1AH/M0jsX8qPfwk8+JZnOoJjtjgKyv4vT/h3X/5juI3cWaok9y?=
 =?us-ascii?Q?kfYnU4QipxBZ2TUoyPXeUOsoQ2HA3sawRUQ3PBUBOLUL/fkhfKPFi1kDgFiU?=
 =?us-ascii?Q?EmSOYYg1nfJsUlI3yjo1gr+F054GhvKALCtpn5qbQKcMEFv+FCZNHatk8LqK?=
 =?us-ascii?Q?bAGed6H1X8QpDK/+cGbLqDye4SiPI5lcvH9djgEYSu6FjesVRTX54HGPeeZn?=
 =?us-ascii?Q?azqJGktyIugjT6zMznuAi5xhWOgPtx8DnWXPUrbRx19WHTKKhYaByZraWEQA?=
 =?us-ascii?Q?jMqCpY8XdVHfAFf9h/vJPj8O3eTHduqbrOlj7Op2GfPBJW1YoyizxLb74E7q?=
 =?us-ascii?Q?vjxzoAfSi/HSJHwdGqp2DJQcUUCGbZi547BsJ+aHLqJRQiqsieTpYxy5GNPw?=
 =?us-ascii?Q?T9xB49DbO62TmurZCK6dDhtmrlMb5Bztl966n8mG7CCNhE8iMnluZOn9L6wy?=
 =?us-ascii?Q?uTPixU4d+OyMqd54x7hthFTDhSzljf5vQ32KXRlPx4Mp4OMnQC+vDSVGmcDR?=
 =?us-ascii?Q?YiJgWPFqk8uUWEUPJHSFrQjDIdSFbzl9ihlsRwiCZ6YJ4RDDokG9BwQ6cJqV?=
 =?us-ascii?Q?6uZtpxHO7hBvJCZGnYihw5sJOpJMVpJWI9Z/GFPWVx5xfwRSnnuE89K5ILKj?=
 =?us-ascii?Q?gQuemEdYDTbF7vkXfp4RGNu1w3cVTKoe5aE2tBkVwaOTnESpkimDerzPPh0D?=
 =?us-ascii?Q?Gw+RIpXt2VW+A0mUydQW042gMWf4tMwoUpzEh6UKDpLuOGeIOIDi6+S8vccw?=
 =?us-ascii?Q?Wevtu0bsprhrJjac/8FPDKbQKim4XMEKVV1O+HeHmeueUaiM5PQOr/YMKkQd?=
 =?us-ascii?Q?L+FBNxWu2z4f+HEDz+xEf5x1vXgEuLNKuFpiXRQoCnxU2gfbAw6kJjY2flEF?=
 =?us-ascii?Q?lLmJblk559kue5gAQSyMciisOtHTJe2xH1NePpkJggDin5Yah04LHvJ+Beu8?=
 =?us-ascii?Q?Hx3nL1EXI86wQ1FSrYijFUHfc2KIfAwO80q+znkx6vxvlrRZ/ryykA+bAeMX?=
 =?us-ascii?Q?cDOx9lQoJSWHdcK1FeEJXoJt4fFwtLCPLc0TSMl9LUjvhjXqwAqkLmQHuxzp?=
 =?us-ascii?Q?85SCL0c4v/NGF+z6X/xskWvXw0IZAUDuSBPXKm/YURGk2X2yDpRq/MdKu/RH?=
 =?us-ascii?Q?BHa4naic+rhDVcbdHZrRJS8JUtwzHUiVLhWt85XVJId7bMSEtjt/GnC4/PvK?=
 =?us-ascii?Q?nVBCIjxPUc+6mHs5nhWoJlYLwYxfl+LEdeapRSj4K4subuOVux/4CNqrw5Sd?=
 =?us-ascii?Q?gtbpupPrE1QrN/RY/oxKHVqoAoklRmZUyXbKT8/Ke7rrgSPUOSd9WUaIIDGa?=
 =?us-ascii?Q?KqifZ0qO/26JFVGAKdW/uyNRal6Irrx27mm7do5bH/yf0s6xO3VO3Il8JqiQ?=
 =?us-ascii?Q?V6OuDFnXPo8uiUUISkOc+V/Hy4qVCkZcZuJ7bV5mhw/cswuce/Z7VD+q8Z88?=
 =?us-ascii?Q?QH+0RAiv4AlIjiV3qVNwlvQVnCpBYrJs73cItqS6BmCSkGZ9ffKVFrWfDgew?=
 =?us-ascii?Q?EkDnv2VZ2AZC6bX02hDmrugkpms/16Dx4iwXJk2YHBeBTu+7X6mVeSOXR3bt?=
 =?us-ascii?Q?ZoT4pdkvRyxapsQcVGoczk0P0M9dYlT7z0Mtl7E+Cgv8CUR7/GEWHhcIGsYG?=
 =?us-ascii?Q?gyst/jNWzRFDEAJ5f0eziB2K5bzkgeKhSI2HZD2bo3hK7SVgOb5/lAYpgujI?=
 =?us-ascii?Q?JxuuPpprxeeBrpoKWRFojHVSbLdpFWJ6I2nUjMUia/N5Jyyb6rINmz0kMqix?=
X-MS-Exchange-AntiSpam-MessageData-1: jhLPVlVohrJ2R+Z0NsABLluWbjwaiunzI2g=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ea060-ecd7-4a0a-bbc2-08dee0fa4f5d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:18:01.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ss/BKp1dLJ54tNcVIxK51KwMsMHy/uDSDHTrJbAg87HLk7fGGi3nGAk8LGV55uOTg1Sac2TU8+LVW77lgLS+/yk8dCKIxuCf916lxb+ffk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3185

Even with the applied relaxation, the test still fails as soon as
stress is applied to the system. Skip the test on virtual targets
and tighten it again for all others.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tests/clock-timer-periodic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/clock-timer-periodic.c b/tests/clock-timer-periodic.c
index 2871a19..4c480c1 100644
--- a/tests/clock-timer-periodic.c
+++ b/tests/clock-timer-periodic.c
@@ -22,6 +22,15 @@ int main(int argc, char *argv[])
 	int tmfd, ret, n;
 	__u64 ticks;
 
+	/*
+	 * Skip on virtualized environments since the test relies on
+	 * timing guarantees that are not reliable under virtualization.
+	 */
+	if (running_on_vm()) {
+		emit_info("unchecked (vm)");
+		return EXIT_NO_STATUS;
+	}
+
 	param.sched_priority = 1;
 	__Texpr_assert(pthread_setschedparam(pthread_self(),
 				SCHED_FIFO, &param) == 0);
@@ -35,7 +44,7 @@ int main(int argc, char *argv[])
 	__Tcall_assert(ret, evl_read_clock(EVL_CLOCK_MONOTONIC, &now));
 	timespec_add_ns(&value.it_value, &now, 1000000000ULL);
 	value.it_interval.tv_sec = 0;
-	value.it_interval.tv_nsec = 10000000;
+	value.it_interval.tv_nsec = 5000000;
 	__Tcall_assert(ret, evl_set_timer(tmfd, &value, &ovalue));
 
 	for (n = 0; n < 200; n++) {
-- 
2.43.0

