Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D94429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7/V/Nqtfqqjp8oBzu9dF67V9/Qxk3yQMGk1xS4IrwsL+soFN5E5plhOHyMIQouK1dN3GGZPJqGl3ZnulC8lAgVuk8bQND9cpKV/kYD6U+/9L7BG6/4XoCDv84GliESHG+RjzTG5FxTblq8wAxlov6hMhinRDcZkpwUPaA3FN03v8WTBLWVaY65V7oGEx5xNJYKqlIgyL8BgqJZs8eSSHZPeXcgfBObbOo8sh1c5mDSUqeINtec/2EH6afFW/fr8Lzj1PGdm26zw9LYU2nuuhbOAGw8dnZXN/MLZICBj92tHiDnFVY16BZ67ClVEB7pUsOYuZI/w6xIKSw/ZQMjG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbOJjvk8j7aXgejGHS1w/Rd1qmhydkO4GbkXu8sVTdQ=;
 b=aa13iJz+stKFB6Vbhde40bmpD5+J0SaZJn5e6UDDjIQ/rzFU866GuktYtMDC/ratdyvLdXaZGUbXpnmORYx4bSBHbwc/8Soee3TLjfmuAKv4I8ixPsuqViuvHvYm8/h4aESQBrJG6mb8BkKgwAGzX0KNMHYNwPp16JlXWHgZ6rfgWFPi0n/WZoybwxzYIV6IDhkkNgtu9e1NkWRneN1Hdm0xg9kXtINInqrRDKJk7BWKkTfh8skw/jKnZYPGj12KMLV46J2GnemA3Lsb30RCT2DzcQY9Nx60huycEAXYAMer0+kDxKu6xIajXMytWz2EabonOYgkFgZ0bDzp6IOAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbOJjvk8j7aXgejGHS1w/Rd1qmhydkO4GbkXu8sVTdQ=;
 b=QWdUM6SFMhVvrXQyGGsWKjuz0hDjMhu9M7bsPTT/6wEy0EKhwEW6slW94XMM71hwVLRVQz5dYvWVkQeM4Or8wOSTToRfbTBPbgeR1u3HJfTXtFFlAho8l29PVaKIt7VCJSm7e9RYGNQLOeRkjel4ZcsU+DAcXu4/q/3z2CRoN4dzyTfdLRMUfQQJiCQ83WbI3RbGfXP7FSBw5ee15XuWkJJbY24gSYldqS/CLisjak+smhU68+FlpIzJbalMWtvm2GFy2eE0N2FiaaVXsuALR7lDyxnyOKV/rcAYjxfE4mXg/avX2HLW09nTeAARsYR1i1eA10dBKmYE+r4P55yBqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:14 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:14 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 26/42] y2038: lib/cobalt: Dispatch timer_gettime
Date: Tue,  9 Aug 2022 15:43:10 +0200
Message-Id: <20220809134326.23688-27-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c848a351-1a1c-4506-ad0e-08da7a0d3faf
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nxJR8iOV9gz6Sng31OPLxx1sC+B8tl4kamimYToZDOAGfPvDvW1tenqOJ41Nk1N5Nlg46Uvmti8I3F9MPLk+09v4cjxg3hsQ/FTKb4JAsB+mkavh5zf95zIQfEephRYduvPfDDZ3wuogUz6MY7NZMQ4PzbVYR2z9g4RfeAEt0MrVXDFxw7ATDP2eqhVUeBSY0ceomvVSDUfGD93M4rZDDhpBqA8rwVJ1n08Z/2p4kfiLzffnwN7OOTG64soiFNHd9UM0+LtqzAhfKzhrQKtV0PZv/oJlxrMD5ejk3y+E59xJppuOp9uq+Gz+9M8Y6rJY287J/mZUoJCyO2Cw2U7MXhqLkMeN4BpeX8SXNrV6VMas4X+lQw+qyxtDQwRuyuAOND+unOlCdbw8LSZbbKscQv9Opkkmb2dbA5ITurSl/EArfYiodsBYMrBK+PskIi8bJgTjY8IMhg401Ywdqocf7drqajl4VVRfgxAOwsZ7ssUaw0+h5apk2NrKup4WRl+bR1Q1dAQKGuS29yLz3E440y0y3NzoeoZPJTsEuh340cCzbE0jDeuKRLKfb89sarVwDbFdo+q8MUdb51jSmSLugcP6jjoq946liHn9gmMfAcAUgpFXYH9kMaFojJov4bSC/qqLH/wPPH7s+8Yjj8mgh5fJQLKs4+APLzAKpVr56plqmulC9kwtp6LOFKYouM9QqSHRpZblSk2x0Ie/UPj4BVMrD6H/D8B2rkMihxzYc34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(4744005)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWzWGC1sYwYL2/M04MkHUQAhqyY5kAi+jnJmuj9XZvoKgSca/OXzy/dmxI+c?=
 =?us-ascii?Q?m3wfsIZ9VvthNfkXamPwueRxKP1VL1Kzavk1nZ57nlXCmoTQh5AI6lKpgf2n?=
 =?us-ascii?Q?aISNkoVtP876RgVkXCWp4ndWF4iVXa4WEXao5k4lAJZHFOFDX+I77HX+Tw84?=
 =?us-ascii?Q?O6+h3OmgcXgwAwW83ufOX5R5ElMv/ogK+U347CmPnxvlWmcNqRGypStoRLm5?=
 =?us-ascii?Q?ZUlqcqeocXVSmkjyKXPzP0fxNdshEp9frEs4X/a3y2xL58n0p4/LpNJlTtQP?=
 =?us-ascii?Q?LAPcNsTMEX/kaPm1WkNbk+PPDUBnZUsqDK1Q8vEDQALq4SbcKwjfx3Wn1AFl?=
 =?us-ascii?Q?/vK9xgXg+hhFaFgDX8NaG/KtbVw4gfgHvXCJ7wYHFnqcgSSsjMBeaGHu94sa?=
 =?us-ascii?Q?gZl7exnuLZFs+nHtVHZWzNz7mHutasWQh2g0p2gQnhsFpwJDHPhdfeFvvCQY?=
 =?us-ascii?Q?TzRjNH5ZsO7uI3ktcSb6wxdl8NhWeOpR0UQjPsBeTEeHKZxH3CXMjuf9anQe?=
 =?us-ascii?Q?NLm9dNvrxwA+KS09RkF/R9EttlQcxOHkiGYxip4MxhqjdA+SLbt+uGb3oBqJ?=
 =?us-ascii?Q?K2KWSDj5JIEBesTN4IDKxqr3suaTkz2L3VeASOTHjZR/hyutdjgjUxR48uia?=
 =?us-ascii?Q?VlT2Jex8pg+5TrmcfG/WuGMWcV4CAYQ7WxXjQx9blI9pxZwrNXhIvDjdH1DR?=
 =?us-ascii?Q?p0X4UcyrYIaNo17K2o/y1kjVUzECwvo3s/gHB+tyzZMK8NRQwyL231Dc/503?=
 =?us-ascii?Q?XFTrx59j7536EspHoMfHovx+wPKgjXX53EVy9G36y7rYsHwezVcsvf+GSa++?=
 =?us-ascii?Q?b0GMufmDYUckZSX/+rDQjZqjDZFnbGiKnDTuJ/sYQG4x32d7SZ03rQf/czNH?=
 =?us-ascii?Q?pReuUPV3ngUX0MycdBC/HoAOHtF4e6QL1oNyxMlPAa+qgNdaP3vWiVdfCVbn?=
 =?us-ascii?Q?YAlRdtkZu+fn8S7Y/0BFT3/9sH2CwviNCZRI6ZCyvc0+jVqDX5+5NT+ZeeR2?=
 =?us-ascii?Q?Imo8URaTVei3TfEpyIaJSr1q+2cViLhiOyd0p5/P/IMQg64MF7WQ61aOKhXg?=
 =?us-ascii?Q?+vDFbBZHnhtNuVov3BLCOXo2F7Yi2yq7EnOQS95dUhMyr0GHFHFfxqDTO0Xt?=
 =?us-ascii?Q?9nYJCY2Ej6/GAs3MdEu+EzMyBCO1tDxPaf8bHf/IobHBpgexsWjvWQDZEymt?=
 =?us-ascii?Q?VgrTmFlL8Mb5LUmmhXKEJmqE46/Ka9VACfE5Dq0y013flqeTQvHU1NzEEk0e?=
 =?us-ascii?Q?RgRFnEfcWCBND/EzcI+WKqchYXIO6S0WgmftMH5SqoQWcle13bTrFsocx34j?=
 =?us-ascii?Q?ZFM6yBirGueYmeB2Hh7GHJe7SUM0L8bfmhJF2vLrkWTJbsQ02rEPJZsedFIc?=
 =?us-ascii?Q?8bPa9fzhe6cF0zgBnCfxafH9N8yEjzC6HxBQDw9rF/TxMw64tPqcPdgahl2z?=
 =?us-ascii?Q?yt926f4VE7eQKPdvLOtOVt9z7D2Q/YSmuMvE7gHKQ2PNu7SItsJsyMP61828?=
 =?us-ascii?Q?83v36Pi02oUkt/eQNzx1y/3jvDT565MeI/xN/dcpYnMoxD8japX86kDsoHCM?=
 =?us-ascii?Q?cAv5JXPvW+VF7N/5PyZ547RJ8/rE7c+0kt8WIivuy3f8VR3nUwkugeEgvpG5?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c848a351-1a1c-4506-ad0e-08da7a0d3faf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:14.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3mBkJ5CMZqoGODY9L3AOhll8jW5tr6zDkeTCCZRE0CLK8fxGR917jO0iwcKHTQaeIrkRABuzm+kyLG/uyguY5mDBOiV3md+gOosWlc8g4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

If glibc reports time64_t support, timer_gettime is now dispatched
to the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index 4a57623c2..d8955832e 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -214,7 +214,13 @@ COBALT_IMPL(int, timer_gettime, (timer_t timerid, struct itimerspec *value))
 {
 	int ret;
 
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_timer_gettime, timerid, value);
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_timer_gettime64;
+#else
+	long sc_nr = sc_cobalt_timer_gettime;
+#endif
+
+	ret = -XENOMAI_SYSCALL2(sc_nr, timerid, value);
 	if (ret == 0)
 		return 0;
 
-- 
2.37.1

