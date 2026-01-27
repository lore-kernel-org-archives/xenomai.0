Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847336E492
	for <xenomai@lists.linux.dev>; Tue, 27 Jan 2026 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542900; cv=fail; b=k2f264pg4+FlubH9boNwzdyNGlf0grfk6ETz7BI84TWw9aLnuS2Kh0ruyA35yqzoMsb4yMdHs2JVAM43YtHfomhUVO2AXkHFmd1/Fdy8uoEYvcEOzF9aPcw9SiZWP8D2SdUUe9MJuGtagJDkSgnCXG45n1Z0JWdzWUg9lJGWpb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542900; c=relaxed/simple;
	bh=xvGo+1E0T9+CDGmeWbkHFUSkJUDCnlv4bGUDaXIoPWo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LEw4Z/4Y1bz4EDs3fjf1LSZtDIVp7M5U5QrnANzrHIGM6oKQtnXNl9kXu3+roaHcTBf/EEHgl6SbHxp5fjhLqtsCSMu1mZo33i81UBj0PHBaFs9gWbD6Fs3HbwF2dMKAJrQ3NH8Me1i3h0SU5YeCywXb/5humSS6My5rIOTEkMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zlU5+ozP; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zlU5+ozP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koXdnYJ/gSQQvIc5ZQK5ZC4yE6od0D2jM91XDZKYVjac6xOg/eF0YKn7EFW55kUiTJmuUCJNZHGyKWe2V3LWbhbAQXSEk2C6GdUu9/VHjvRNUtW/Zrs8wPTP9FkJHbPwfkhuv31ztMhxrQy8Be/TJVqBQ1/kOkc51BLi5o4n5RLrp8etxHGEcwwDkPP8+jEFUvVZu0qSDqLWY6VtKIc8qC4PuzzBC1oZ3uFEDk0zKOTnf3CXZOslgCGPKiTOn3UYfuGXfrOqGBrO9NbOJTrC+ikC6KOWfYPSB/pucFMa+YnnAdX+x88XXrdRu6Ok3I1ftmuNshl1VtjAdEJoZSY2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmwmdhYUk7EDm2ICgdqq841Tj9LZT0gOj1Naj4Qkwg0=;
 b=LNvGyb0H9L+V0NC8WOb5yLTr9soVLY1ejyWLvlqhE57q2kBhi+zOtzf40nBQSRwllTKqGybAX5wq6ozHjmL71WJTepnx3xWVqPzK4jlwMTngLrSYNSCahxJaGzze3gldaS4xDqltdGvQ2NV3wP/duxTt655BllGUZNOw/Ica4RmN+7+bCtJ2GLJ/WVvwkjaiJxxJHPX++U/fREZp+jFWBZqS0wGM3sKZoUvwlZlgJ6YPKG2hev8vtVRrlOSdntecf2FuT+ueiHOZB/ZXFj+FbZveQqQo40g4wrcSU34ymrAhN4p+vmqB4+zQUFI0bYjLlqO9PARz8/TbmGxxh47VAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmwmdhYUk7EDm2ICgdqq841Tj9LZT0gOj1Naj4Qkwg0=;
 b=zlU5+ozPA4sCeTZHuDMeyDHsiOtrzD+NoTxfQfPV22gCoxgU8JvBXwK2m9SJ4mfCm2yslyKxrCojYiOQh0mHPjhKpbXp99KQyfDK2yLELWzKirFK7AdnE5IJGUY+8qZGtLLsOq+VeYsfqxmiAFkTSaaWBnZexOB1X+6xQwrAoAEmt8eXTvk4H9v+TerDIePl9mpYuu5+Cawi92npxXQmXTNmHXlcwP5036JPtPt4LEEyWIowkikSyJ4SHk1sSdrAbr6RkHPI5E7ztCPwz0Kaf6FdJZo6LQXufASB8CRnUj4Ki8Gfovg9Z5+B4YPr9CnSdfvvko2hj2/d3UPmdjE1kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB8PR10MB3515.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 19:41:33 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 19:41:33 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] libevl: exclude the ptrace-sync test from stripping
Date: Tue, 27 Jan 2026 20:41:25 +0100
Message-ID: <20260127194125.103127-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB8PR10MB3515:EE_
X-MS-Office365-Filtering-Correlation-Id: 1318a405-1894-4219-5748-08de5ddc1336
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+CRPfd5BbCpWmjTmoUow9E3tpcjZy2MIEOecFSBN+k8JFTXHm7aLXnfU5sC4?=
 =?us-ascii?Q?j5JnSZ9WlqOiwypcs1+x8BE+33y7wyPyvL1wqesEKDty2FVzIFOXFETCkhVX?=
 =?us-ascii?Q?aPk8F0kYBddCrCE3zRB+Qt/Enmb22UAUKjn4Z1ywuS39y+iXJjlHzLNQJpsi?=
 =?us-ascii?Q?bnktAF66mQARJyDmqKnXWKA3bwSWuLfIjJxg2IYOSLBYhODrg+PmuBlN1MAR?=
 =?us-ascii?Q?wKDrVXw3NjcL6kq1SxMc9M/TGqS7C5Fujxq8u16MJCIqy++fg+KqxMWHkIGz?=
 =?us-ascii?Q?ofza1hkURJsmc/WneKGLYUqwYJp9/+OD/P7vkuHOYLnD4AnbWwGIc3u87RLG?=
 =?us-ascii?Q?+KEQCK41ctUaITrv4QRbjk+hVjlvxstfYg5+L2OIQX77w3J6u5a6a1wzjRVN?=
 =?us-ascii?Q?eDSjJsYWv4N5xFb35F7Ikm6Z+VEp3/RybEZkkV0I2axDICoPhB2f5+Pxtp++?=
 =?us-ascii?Q?UfeQ5bS2VCx3FlDY77GbnHN3t7oigIbDc3ycYVM9+4P2lZbhJFWXBrRbPLW+?=
 =?us-ascii?Q?E7QpNrdwZpVNT/1zy0qMlJLLgxPx/BrXu/Uu37qXql8ItqxXxtFZDFUoJytZ?=
 =?us-ascii?Q?ibg9lAckBKDgpXxcWhYPtgD6RZOKG3zbkPCcZsVoxv0BdJedWGplyaGDJtGv?=
 =?us-ascii?Q?JLDDrrS7W+nP96IeqX+T6SPS5o1OW8jmXCHcz+BMJImnrU24AzptLhLDraxZ?=
 =?us-ascii?Q?YuduGby0p7kM3422mQs8Msa7g8EzSmMNWXi7JZTHy8aR9Gia9NiY4T+qp7H4?=
 =?us-ascii?Q?qViVwZmw6vQmS2MolZ4QLFSP9M82T3OycHEYD60XN4OWlByXpcSpUOE9fkZO?=
 =?us-ascii?Q?Luza+WO1hG0xA//EnvQ95sF5FNz+mLzKF2/7E5mfgZqg3YAAzvVQBV/vLJN2?=
 =?us-ascii?Q?JMem4L6QwZYJAkzHxgvhrCM5gueoIAM1Oel9jhUWyV6NW9CES2FO0rLnI+eK?=
 =?us-ascii?Q?6XE8kNhf6oCkfQqfEqZZbXBJCxMpSRGQFnsevP7yxhWPSM4EZyxSOZiNlUjt?=
 =?us-ascii?Q?5ezfbxkJ92rbibKhU3fNm8JM1ipHedyfoJzln0xg3gi5LdE7ylrV0rWp6YyC?=
 =?us-ascii?Q?VuAbJRr3iGc4hPPXDKt/ou2mEEQX7MEHAvijPxd3/43pT69bKZABBC7f+IwP?=
 =?us-ascii?Q?bGWLmLeP/fQPUaCZomBMKM/KqI5yts+xLJ5AE6M5PltuGPsQBttp4/kLuuK6?=
 =?us-ascii?Q?0CslRYRsg5Q3ZLxPNGQpoU0N2zF9QTYoYiTqxd7oiTa1r2VG7+4akz3elpj2?=
 =?us-ascii?Q?IoKvLNgyu2BnVrAyl8mmz0w3kkSFEswObG8NvOx3aXt85HeBFhs9KO1k29I5?=
 =?us-ascii?Q?faMKrDSxV8T7zVoqy3R0UTpszxSaWez2HaJVeoGpBi+NUYTEnCkV5N012o8b?=
 =?us-ascii?Q?WOnZr3wROP2ynY9hvtmNyrhGAtWourJc+aExH1XXAAMSTo/KKvojLlzelQ++?=
 =?us-ascii?Q?Y9hTdasktWquaD08z7PeAi54TMIjl3jHnHd358OoC4nUWypnGflNhOzT4TIq?=
 =?us-ascii?Q?NYUrSZZLfLKQkaIrrRlfoiIsNy2VSbOqr8f5rQ9PZcGV58Uvj5+AOMgY0qpA?=
 =?us-ascii?Q?X2NfFmrM06EeTPR5KxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfpjW7qZAJ/k9bFiBAoN5O29f/agM/bZNYQvjg6pV5DX3yKVWO8n295fIAK3?=
 =?us-ascii?Q?cAuNdqmLFTdNFMCe4jabQObDSS4SdujPZj/2crvbQjbDzUt9OycJXsl2ii64?=
 =?us-ascii?Q?2DuTQQJVyfsRupuc7ovtnI4HtuANY9iOOxasFNTJNltNGTYTqKpo1tziKl13?=
 =?us-ascii?Q?x4YOuhLqjiRRW7PJg21lgib+y4LWHrLwyXDeLIGwYhgOFBYD5WW98QfWTMXm?=
 =?us-ascii?Q?db/vbTtqlOez6s/RzNHqXCIynyQg83F50C5zyGLhLH11bN/iitXMLBTHaYdO?=
 =?us-ascii?Q?b1BtifhSbA9fcdfS6f0aWxFnJIDz/QS8bf92uLM1TQ2ozZ/3jj/WC6s++rYM?=
 =?us-ascii?Q?/cQSsoeyEAd1+AlZ9lJQvflsVQrLfpUo5NWOKnmqR9x62OkUBvxPabRRnvl7?=
 =?us-ascii?Q?QwQGpFqEnfmnGnlCWSh3LSk2HV7VXh7VLTomHTnTmU6wh9q1VWuTQwz/0jMY?=
 =?us-ascii?Q?v2bKlN27qPc6dzCzzVzC4XwIjOeKvmIJk8iIp4ck7aU3airGTbg1Bwc2IIJZ?=
 =?us-ascii?Q?2wDFSLVkGgVa6AdwAvHw1AHlO0xDFJv9HH5uQS8LTJxRXc4EMOUf3JQuxRF8?=
 =?us-ascii?Q?RxQN04GX1jTM+qvBD3d8yiHqYNIvRPYlh8Ogn2xvO6yWYXSZ2SqNvTMSn9Fu?=
 =?us-ascii?Q?dVnu6DWBOy/0qwq2oBimPh3QTD29gCMwWOkoPpH4JBk+GMctzSBo35hDOEb3?=
 =?us-ascii?Q?BDKe48Gx19O55BBweD9kwGt06b4Xns6PXohDCJvs1desCL9x5FISUqM9Y0/i?=
 =?us-ascii?Q?N2abDcn1g+nv2cMqVKHOb0n+j+p9zgfPY4zJD+KcLlIv26Z2z1g7WtGyjZMS?=
 =?us-ascii?Q?uGXcL32imUW7s04/d3hu/yPCnwowwaJk8tv1jkoQ5ahUG+fcJ9s+1blsYeVt?=
 =?us-ascii?Q?Byn1RtBsk68Knu1nZRXidh1QfFwmjqpeibhzFSvSlGac4uY2HBEx5KyFhXqe?=
 =?us-ascii?Q?lfAHbCQMnPE/czoZenZ15pAKqHMb/OEVqWaMznpmtoTtBg/KcvOXown6MLM1?=
 =?us-ascii?Q?OAakKhjZ4BSzGo0j78uHcQAjiSqUYC6q7eZkWNen6BpEpBLZR8xykdbO6OA4?=
 =?us-ascii?Q?J6tbBkLczXHJxITF890D75l4jOkpPxKAbkuqRWL3YvSHSbvfj3WD3h3MiRgW?=
 =?us-ascii?Q?lxUtKXlakqcuep07VXHE71DoCDIK1Xwpc7mTb+1DWNd0LAas16pdgKj0qELp?=
 =?us-ascii?Q?oapeCImood53/rSO6zXte7BXblOw1+aiqFXSDG7PJyFjAxh0Q9KqxpJH3PyU?=
 =?us-ascii?Q?gjNl7q9gBc35m1nSwihzkyYxhMqCI8Bvf42UXtQ6mar9/YHkoakQXPaing96?=
 =?us-ascii?Q?3ysy2s/iydJdO1HzZadRVUCRepaIFzzGvQTp7B3cKlHQbN3GWTBwdzVwA9H4?=
 =?us-ascii?Q?lndmoIUX6scZ3beuH3KBYBvHiBzds8VAmekBW4Vg7XYcBj58WJhC3MRR58vg?=
 =?us-ascii?Q?rHrTKEEFD77JgHZC76Ip6i9WNdGX8Sh4FF8kRh+EkuELUkccLqy3q+zFsvm3?=
 =?us-ascii?Q?Z36pvYLN+Le6Om3Vn/uzKoE7t0OLcPTOqKmMNUaxsMBrdfIQw6SQbl7Epk2G?=
 =?us-ascii?Q?WWV17cvElG/4FE1UqAbSmpoV86EV4epn0dDP/IS0QFEbqcEvMHqkRFd5h3j4?=
 =?us-ascii?Q?W/UdmoR3HCkLDkJTBXgPXL1Xmngu0yOTxgM8dkiWinniBE23/jdCm/tPCGrf?=
 =?us-ascii?Q?ArszEF2wuVbB0FTtneFtUrY80UwtNStbzBpnhxg04jBVoc86jCXi/5UAWw1V?=
 =?us-ascii?Q?nFQ+9wm2JCNq0LdCgQxUGr2R8a5v734=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1318a405-1894-4219-5748-08de5ddc1336
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:41:33.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Pgmy1gBPI4x7W0Hs10s3t1foZ28pwXrCkAklkGa5d3tlyKpL5HJmw+OEbrUWVeSqeNmN63pYMZyYuBpoPRjOr1mejj7yoi8fiA7M/7R9NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3515

Only exclude the ptrace-sync test binary from stripping instead of
loading the symbol package.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-xenomai/libevl/files/debian/control.tmpl | 2 +-
 recipes-xenomai/libevl/files/debian/rules        | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
index 89c871a..93caffe 100644
--- a/recipes-xenomai/libevl/files/debian/control.tmpl
+++ b/recipes-xenomai/libevl/files/debian/control.tmpl
@@ -13,4 +13,4 @@ Depends: ${shlibs:Depends}
 Package: libevl-test
 Architecture: ${DISTRO_ARCH}
 Description: ${DESCRIPTION} - test suite
-Depends: libevl, libevl-test-dbgsym, gdb, ${shlibs:Depends}
+Depends: libevl, gdb, ${shlibs:Depends}
diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
index 07c28b9..a704dff 100755
--- a/recipes-xenomai/libevl/files/debian/rules
+++ b/recipes-xenomai/libevl/files/debian/rules
@@ -15,5 +15,8 @@ override_dh_fixperms:
 override_dh_auto_configure:
 	dh_auto_configure -- -Duapi=$(UAPI) -Dinstall-uapi=false
 
+override_dh_strip:
+	dh_strip -Xptrace-sync
+
 %:
 	dh $@ --buildsystem=meson
-- 
2.43.0

