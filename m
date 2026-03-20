Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A536AB64
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041564; cv=fail; b=RWQxFgF7raMYWmHR3leEP4wKkxKHyeN9CTHr+sZhre0w8WHp1bvxziI6Szrjf+94NR2+snjQzmdf03UVaKpzGzJKHa7w8iq3ewQN6+ehmTQXQC3gZc7ZtFxmjHqSzz05EHVTgnmo7ZuN2VNZwCmfRI0//WdvxW+2RxdgUsyMpB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041564; c=relaxed/simple;
	bh=2Dmw1iXRRFQlZJZI9rUObc+ER3nQgkqzBHBJX8EuNC8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BN1T3ZpRyfarfbcZwlfFjMikLrzfHEAWoo19QHR2z5lLBo/IkIvBfvO2t9XP/2jQrn8wfqJq7VInGWLEHZ+J6JHu09EPrs5WPZpS4+o9RixCA1Fz3ISVnPOvvz4TgOE3yYSgIDE9MSF8BL8HkqJ2Vk1V19v+ZWzj0jphdiHzKuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=S5FLNDpu; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="S5FLNDpu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoh8mbSNYA6lhwsuFaZdBSaQy6N+wWxZ+r3GKJs1pBIhYFnRkh6rAEK4fYl68wFM1pb6lorMg4g18O0fPNHQp1X4FAsIEd3UJmtCd4HV/Ky7VYEIqw1UkKjbnnfh7fKW0z1hsN0EsNINDC2wbbpb+8M5qk4m1f5pdGpcAS0bWb2cSaPiP/ChyyRqNCgyacsxQlrEZXMxIG2WK++2QGy+NV2JIix0Yh/y1+Z20obyLqoa25CQHEJdjR1qh3DJml5JPHWJZKeGgf93pld+NS8QZTFRv+833kmRCs5Xf/4honZKwwoayqkfo+uAkDkCU6VeCTDNp4CIbz4ysIla1Rhjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjyugh3ZzTiZy64NEh3U5GVRw0WCAYhzVdOq573lNHY=;
 b=hcsbYOMyLVthppshxsLVIdKINbuJE7/GRseP8A/fKG8m6SrLopxyhTHb+/0HoU1IhiuTNcYBRuNKYkP817ZqC0wgTGW+hezE2nLbA1pwop8iE2rfbPfZO6oqW8ZltZkKUBC3I314Yct/x8Z02cGULW3GTZW1Q7vxTPQty5rMFo9k3CjLFXFqThlKX2gj9zzV9hhpxM4WNlGJxEQc6NNyQR1ZqtZYT1oCMWWw5yb4xju9A+G4mGdBOdk4jG8iPZrqs+HUO9wod/zGs+6+DdJX51PBY7j3c4I6hskajVzdTIliC+gNCM/trKrJO5kaIrWrM7rdj3/IoVAY1Qr3263eKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjyugh3ZzTiZy64NEh3U5GVRw0WCAYhzVdOq573lNHY=;
 b=S5FLNDpuucWG/Kk3POVi6O/ggh+0ax5c4HshTyF3EFCE2T08+E+I/RSvmg9D7RNHOETmoCGnJWqea/WaJCWlEsHZWxqfIKtc4hCvhb4U4o8MUQyFcI4UTlZH8FN/rKEUyNS8NKnY9Sm6Y9rKDNgGUnDYbRxgNr687q0sFgRb7nW+pdkvylQy6AHRTk+d1lkIEn13BjS3X/9TauGSfPOHWs9UjMOYZnGWeFbIhIBNjQFu5ATqgrnMWsX3+kbNcWS60yFCbo42JHkqU0sH7ZFxLeF0PTbFmfAyhqUszO3NOw9G9MLcitn9vYw72gGXy1Pb1KV39Cg2zPirZBetwFLLxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 21:19:19 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:19:18 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail] net: skbuff: add missing OOB stubs for !CONFIG_NET_OOB
Date: Fri, 20 Mar 2026 22:19:11 +0100
Message-ID: <20260320211911.2151219-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 2848281f-4343-43b4-92e9-08de86c65905
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GtsRkIno6/XMB4UyD65ZIj1rQhpmUGhDiA693VUbJhI/VWjVKLjvC9XKrPjh3GVeCpOVMseqc6Y8zXNe/viHDUX8lv8/u73/NGKc45FMp7+70r6qk6d9z6dvcu8LXa6I1Kj1MFssSua8EIX8AnJMLNd1kFCuwITUJCwnbYdOxWLp0bwhXNkPQRMpNNTLXGP5ca+j2qXHtzF/uQoL3TOWTyHhhFPgW15ZH1r8GLySrPbGPcUk7+qezainsOW2HCWMsFaqG2xQa8wK4Cokr5pNu25mnxGZrJXtfRYA0bbnqlaYNIGPIlZ5qUFlMEuQzfrlRmIbGCtvSuCPM3mEhfrGZ3YT7BKSrytorrgO2KGRk1kpYHWXZul99Z4kGB+CcxzCzO8B11SDYCoyYLESdcFvmxfHqbc0bn0ZUFMfLYZlk+Tmf47Ky3lpZQMbQvuvrLLd7pk29JeijpiwWtehiHJqPboquSLDhu5qUea0Na8/alM03XYOnLfnLxiTPiSaEiEoGSe2+eyT72tIn6ZIeuEbSqkoEBsK9C8y/hToWt0ZJpJ/h6cavI2cnxUUZ42MdZC9b6OXqH1ZbNNP7t2IVzGiQwbJW2gXPhz9IXq0Px9CQGu64oTR+rbFR4g8z6D+nvc7L2dsL20xQBIx75q8lmclszfwfMq/BpR9R1+eYkVkG1AFi4fHonbH8VHmUqqW98D5WHVu78lo9LAY3WkcWxQrU88XfzgJWShNmyJq5+wyktc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yiyD0a+ExX80sKWsuttjDzibcscUyl6rkamEBKEKck9OLr/B8bF5IH6d1sK9?=
 =?us-ascii?Q?bCIQZuOePkk29Kb60LdGMVzekxG30FT/fEyXI5Tv0KWhKbMmgaXhusSc6AO2?=
 =?us-ascii?Q?UbC0PSE2gCz6uV4zUNPhlxZPPFB5JpcCtg439Lq/mxdVusKfesSYxdrzU9Nf?=
 =?us-ascii?Q?qHwF/08Kzk9pwB5BzwdULPC8kGAW5EXxLNN1+lWcPykfxwr6ykdetKlpEOqc?=
 =?us-ascii?Q?zTeiS19iYabFooUrKtupaF8FssqxlPdgyIFPBMOs4KskYPlOSrO4eFBnvV9u?=
 =?us-ascii?Q?fJZM7AMwNlzUBZylIt6mdXRqNxJdtCpO41M64nEW9m8wqQ+xzoCpYejnXyiK?=
 =?us-ascii?Q?s099GqKeoUwrhIxvm8nR022jebapXbfVxlMfQIROfuLXjsIaPilmR43NXvLK?=
 =?us-ascii?Q?ft9kC0UlxvfUgA7QBEX69/4ACSXOlX+ACP0XqFCiLTfhl+k8U/tPUHwjK8sp?=
 =?us-ascii?Q?2CIcuypnnQ5IBgPqUQZT4Dm9NdXQo18pMoHzlyhO6Thj002CDCb4rQBsieEL?=
 =?us-ascii?Q?0T4wtvS4ia41YxlLWupxVhokNmDYd39zioWYe5N3n0DklWf6JTr5WyL4GH0l?=
 =?us-ascii?Q?i+Ii8ghE8inGfr07HtNcNMSwA0whuTONtUVp+aXrQ2Ex9g6eCpRt4+pwm1NK?=
 =?us-ascii?Q?GJwjpoSTuOKy9iJgV36nTE1ZAWlX6RR9AtICyzbpaJdkRneuqvQBJXi/6ml+?=
 =?us-ascii?Q?UA5mlscCzwgvy3yoKncWFlNgCwzC36SR1gwqjeQjMvQAGlbWFynFHd5FcXsF?=
 =?us-ascii?Q?wdFRMRvnC5MtzU30qY3PMec5slUgRuc7M1wTtjB8qlQmd2kYP4vguVkLUsb1?=
 =?us-ascii?Q?o0icrLs4u2ceszYP9Em07v92oKqflk2IOJB5VWol3zLyEQYdf4ypPbcLSpHP?=
 =?us-ascii?Q?6XtJmLpnUX/UZiBrkEdMIUJeJbhQH2O6UwpbqIY1IMLnQHezDVpGQ5uwR22r?=
 =?us-ascii?Q?AKOaG4MeuvxyPvsBgvyImJniWL3nEU9AYAh58g4lk+SXy3c8HFvvhqc2JfGr?=
 =?us-ascii?Q?RcdDV5r6ROkW4Iujfvmssx/NEcZjeLngdy+IxHqOV8EN7VCKGRYxC9p9ktYS?=
 =?us-ascii?Q?DnHnBjLskH5TQx79Z6ENDhyR1lJz5kr9md/4PW7Q8MBaLW77d4Dh7JsGZjzc?=
 =?us-ascii?Q?eE6Wf9xvI/AAocJqKT7W1uu5wvhqApjY6TUDe4IpT9/60abFxfjXfFIncOBe?=
 =?us-ascii?Q?0U/JHCBdsK5DG6TQ2y+z64peNspCQ2uc9qs1tjTzvDEe3NAbhdOxD6XARGhP?=
 =?us-ascii?Q?/iqG2WMwqN7bMpS7UcKy52NqLPL5q1G6tTWkUwHmeP1GH9QUsd9KjMUvafKi?=
 =?us-ascii?Q?ZmhrqCnj10RhQmkGGUg96BQe1HMvb5v7vjYo2wl4L+TlyAL4IMRzBhChPClT?=
 =?us-ascii?Q?Fmf6gw7YB84rtf8yPq54ghLlnyCu61lzrXuTlT/GVi3F8V0mFc/29a5c1pUg?=
 =?us-ascii?Q?1aVi/T9VIfXiH+z86FEkfQ9fK+c2gPNhLpBlphduLHg2OJB6baSUUsuwHtTV?=
 =?us-ascii?Q?U4+7p2De0R3UDznow8RW0EmA1vlUezo2EZoMbUyb9ohb4DagMyNkK46YOc35?=
 =?us-ascii?Q?cy25n5XlNJb/voC4ELOgvzcCmqNOyjo1XTMmX4igoi5BdNBgIPIiHW3TG5Ki?=
 =?us-ascii?Q?isFvPLtBm9yv4ug16F9c0ZYVOI7rQf77/W/SOwbPTJzRheLcajSpKM+Bg8aJ?=
 =?us-ascii?Q?11jR1v/m6DrcJzTbSmsxxBEd3Fsg/lXgL1BD/VgjDMHf2y+sewYUY9CIkehR?=
 =?us-ascii?Q?/g/MQ6Mw+Z90QimhM4OXDmImghljltQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2848281f-4343-43b4-92e9-08de86c65905
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:19:18.9222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mErPLMluQUAmGnrlxPUPAQ5mgYWGBOhbuLwnuEky5Wuv6raNNOd9lAwyJINVueo2hFC+LkVvc91VnrB8I+klZuHLSrl9XjhmQ+/DDOrMqQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7432

skbuff.c calls skb_mark_oob() and variants behind runtime running_oob()
checks but these are only implemented in the CONFIG_NET_OOB section.

Add the missing stubs to the !CONFIG_NET_OOB section.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/skbuff.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 73dd4a58d181..1278d0a58677 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5630,6 +5630,22 @@ static inline struct sk_buff *get_oob_skb(void)
 	return __get_oob_skb();
 }
 
+static inline void skb_mark_oob(struct sk_buff *skb)
+{
+}
+
+static inline void skb_mark_oob_released(struct sk_buff *skb)
+{
+}
+
+static inline void skb_mark_oob_timestamped(struct sk_buff *skb)
+{
+}
+
+static inline void skb_mark_oob_managed(struct sk_buff *skb)
+{
+}
+
 #endif	/* !CONFIG_NET_OOB */
 
 #endif	/* __KERNEL__ */
-- 
2.43.0

