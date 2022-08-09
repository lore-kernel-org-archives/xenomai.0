Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72614429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7bMLr5r4EbspmGrT/7Fs/l7wwClyeX7Ty5SBqg4USdAe3IP5xzgz1NA/vN7h2g6Qaa9gct1Od5CNeuw1mDlOWFm6tmHzFhim2/POUOIZ5g1270HE3m2CV7VwJI615tDRgKyWKdKXKvtztf6Ab5YWgconOOHHlR+EYtqndWQgBxeKFItd6J4h4YwysSuABwwNI7U+O56kctOQPnfOSLJAUYN2sodzIV4HlL/aTxmEKeknMTs/8uUVDDj3RSQ6VM5jdtwwplCjVCIpp8TGwy/FbcC2sEnSEGzTCX49i9UZaiAILi/f56rqJhpXPJsvrEoM3psMTyU0UUMUuZoXrSUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEN958R6dyJCEeYZXFlsxTquTCkm7+CJTykE3YtPZT8=;
 b=YL4syF1uzxrT4mddbbFZXo0xsDMYuoDyT8jBDgPEKewyGiBPYL17KtTF7dYfDlgyRg39hqhS6FjMmUdhWHjn0A49/3IuoJCZQQi3IaHx2T7YI2PQjuJ0Iey1o2hDQ1I7K5FdRF44zi9yAFpJd4PvAkGHXvw/MweMKQ4s2HvwwzsmT7I+xfNqycyiA2Ki3Jl3ULTZ6N0jLA/Lhq8ff05X9Zk91aNno6biDpjjjTzryXTd6I93EpxH6A9XTaIbcSkpLgK0Bm+1pgT/+7dVF3Z1pPzu+4AwjU2v74TZN11Fs0pk0GOFppf+URfeBVH/8h4YzYwknzX04A5bqh8niDsaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEN958R6dyJCEeYZXFlsxTquTCkm7+CJTykE3YtPZT8=;
 b=qIKHHTJGSatt/jpFOtGTt8Z3+INBYsZ84tXujbaSFnno8lL3ZLzbT8XFWIzZ6wwcg2L2yb0HvDGElHHXOE1TwqrIhP4WM2XuVc5TdnkOyzPaNWtSjJ20FmYJfgV0VTUAElDrl2ZFWarmyjhRGJsB7y8QbSRCe5jYHytBaIVZdzArKPMssCTpy/BBOwxJl2ZQGWOwm8it50hbDe2L/BvKJr5iIC3zT8loeT1RYfsWl0bvPMVcah1KLexCKMgnHoSln8O6xsJAozfSlILTgKdHXvfnopCi1idGIHOiKU887BRr1hCnSRBKf4SWiGdTAFobgQykJupbU9g+HiVNcjbN3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:50 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:50 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 32/42] y2038: lib/cobalt: Dispatch timerfd_gettime
Date: Tue,  9 Aug 2022 15:43:16 +0200
Message-Id: <20220809134326.23688-33-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::18) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d71c3a0c-a8c8-4f1c-570a-08da7a0d434f
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h7H0M+g0R2gMVMdyOjz74VYUVisX3GyYarlNlL5jigAmZ8SUIAhPNY4wEkoQlJjM4eM7yi8Pme1iFE3wJLF9RbrgPB/D4lyajtCUJZsyudlCDT0IpDbKx19aRatq2H+u2Oti63caQPV6uZjh8I6VzBg6PPjvA6TsoLEAfXU9aAh14XS7L3TPj3DZAiZF0vUtBcBjDtebG2iu/QX97RwYsRrcLbxznaUixODHcNZFgmdDqZLuPyPZB2vMeYs7OmjC5OJ/Gf5dJV+XVsklTU6MrLNdhrUP4WS/tBBcT1mBHaCV1VVsv18AJKn4p+DrpyPn4AVfHdExXGYgezqd1ZdGesaXDtMRFf1sx98jPdv9HqTSdOojxBcOwfJoPyKyAQgQ2bXCWSEJqwb0mLCa0MU+o1BVSPGYxwDKzJes799odBcpDMlTQgi2r/LEWixsiIlWrxImMXBcaKLdZtxsl2w+8vkT0KQ4Me5cSBxk9R5plYfsk/V334So9c58n/YA9lT41eeH07O9C++/xHNrW0xQpsCn9UjkO+nbjAUlcFAj+RwNK/vmRgeAwQyert62TIhOmldC01jUTYKbpHi7DZCCcNiAaMwHDXDEw6uV+cO8ZMVRK7OIGgG7SgtIG57/rhcpAbYk4BzJnohCR+IhO5p0S9uQSXfojuv0CHpFZJqs6BXIKUP1zfID8oAX+w9P0eMEok8KZzIAAxZhBkfGDmO0paYfA/GbMO8tvgI0j/hXNdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(55236004)(2616005)(186003)(107886003)(4744005)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pcjg/JFYc1RiT4sH6bqEprvIAxg5LtQiRiLo/FoTOBDuojx9ffOQaEROvXt3?=
 =?us-ascii?Q?ce1340zhwYFk+8YSTPZV/JfOrwSYBnhozwT+PxniDjY0GIyeKg5SEjl0GSIQ?=
 =?us-ascii?Q?HYwaMo2eonru6n/Sk9gzStHhFkqsByY0VyAOADnIJmkkUJbPxu8VHLLUXBH5?=
 =?us-ascii?Q?G89EXG9k4lcI6vIHfOWJTBpp7/nQuT2BcRh9oSYFg74EekUmVeXDmgCxqfgM?=
 =?us-ascii?Q?FPQlYcwnr7C8sNC9X7d3t6l82zndLLOH63O53CHvnQP/uM396PAXV8CZSRFH?=
 =?us-ascii?Q?AewrswwiNVyqJTjN2x+M0osu0KjILSz0Zq+WdQ2+z0U1bVf5oiW31jdF8adB?=
 =?us-ascii?Q?3kqKp7+nKruJcuTMds/LNx8sEpHBTj+V1g0o7y5D7ePYyv2Jl65iS4ycIoRx?=
 =?us-ascii?Q?8Et0V2/T2/bxVIYPfX9PCGzHCbL25nvZXe/Kj7aM+cL9pMu3KMHujHlLwIE0?=
 =?us-ascii?Q?nPL5Hvt3wjXZaExSlAEUxQFNhMQtFJkhr4glu6+g8MXJcrtxd5gvwgPBxFn3?=
 =?us-ascii?Q?tbfCQTXhf0WybcAJMKGhFc/d5IZ22M1YwLkTNDe6JsjOjzX+wbVug6oQFnzU?=
 =?us-ascii?Q?/f8yZpIvAcllqXR0S+lCXQgC56Ob+prrWMdF2iCiOdnpUURYwxxt4UIgUQWG?=
 =?us-ascii?Q?SyJoan0gX75gpgO6wh3XwfrvA3MJy2hGGGFUIhB/GxH5JtjNadTznY71LYzA?=
 =?us-ascii?Q?86h+8f5mylflvnBGNUT4vMb3/eE345cUdG9As0Kxl/Jnjw0I2P+DE9n2ZNXP?=
 =?us-ascii?Q?g9ly8IB7hUgOSPU8hVe3aiDbyy1fE9siPJWJbMrvlsA0wmzl7AS6SkbKL1tI?=
 =?us-ascii?Q?crgcOPTAsT5uFZCcAt5uHINGQAJubHQBknDMohtfk5vnIkwQZBCHYU4D/xIV?=
 =?us-ascii?Q?ZvHwERgK4N2VliBISqHRVJvT2LxVcgkEBSZhKfeH9VfeWygeLRmKv83C5IBf?=
 =?us-ascii?Q?cNVilVg1VwpQdhCiWOW3r5oa1WLHFIUSxFg6PhDztfNIoyHA+Cx4ACThb0G3?=
 =?us-ascii?Q?psDuZY3HWc96xinoi84GjQEkmj9B5hrgVgzT/jbhgCdlL4S5njd0EZrsFYfn?=
 =?us-ascii?Q?sfzTfHIsDnmt92IYQmfzp7bJdy3oaHrW445PyBAcasyiDitH/qgGOI+IKAY3?=
 =?us-ascii?Q?LdITKwi+YdMVhnjvGADY3B7ZIp92La9eEnHIfVH5TaHn6s7XFNV4/KFSf5FK?=
 =?us-ascii?Q?8Ai/Libem5YotdQJ9vEjOuFbtEw2n0WPnRGTaqG1UZAYEuBe0iG6DEJKZzW/?=
 =?us-ascii?Q?2i5zbJTRTeT9rbjwvuT+1yr0MbAqVrWGdGITOGu8pfrDtjvPybxZqDMjO6EI?=
 =?us-ascii?Q?d5hmoDuEqDNkOvetyL/qO8gUildCF7UggHnkpCkrJjAvYTisKwcLI8bBL0kK?=
 =?us-ascii?Q?riZ6UMl4vyFjo2+zcDrt6Tx3FoalLIMSHn1NcQU15nI9lEfQla2yML+o7ssu?=
 =?us-ascii?Q?uMZ2+D2wgeNEZ2r6f+7DpDyoY0zX0PHiuYtbiXt45yxKMXHu+F4suSRSLBRb?=
 =?us-ascii?Q?VbX3hR6lERvhFaMQy7DRsPOjpiTezoJi5iDwxNvkN/QYhf4lXlJ+BSTxkJzj?=
 =?us-ascii?Q?ExbP9WcyD3njMc7ZWtwbo99cju1J3NzGyRv4IA0+5A0TgSFQXWGQcHnGxVyA?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71c3a0c-a8c8-4f1c-570a-08da7a0d434f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:20.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsMEPi3ZB5QiPeQ0sdMxD7NXQL7N1yR87vnLCgS2AviVduc+ShGK35oJcBsM6Scqa5mloazitzKOZfbQi4CJgVPQmjYN2S5PyWETemBW7Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

If libc reports time64_t support, timerfd_gettime is now dispatched to
the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timerfd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index a564d5076..c0e64929a 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -58,8 +58,14 @@ COBALT_IMPL(int, timerfd_settime,
 COBALT_IMPL(int, timerfd_gettime, (int fd, struct itimerspec *curr_value))
 {
 	int ret;
-	
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_timerfd_gettime, fd, curr_value);
+
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_timerfd_gettime64;
+#else
+	long sc_nr = sc_cobalt_timerfd_gettime;
+#endif
+
+	ret = -XENOMAI_SYSCALL2(sc_nr, fd, curr_value);
 	if (ret == 0)
 		return ret;
 	
-- 
2.37.1

