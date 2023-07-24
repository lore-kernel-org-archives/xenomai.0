Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499D1C32
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 07:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6bcb+UzVb3ErP5vRkqV+OdCCUBrI5PHz6ASnRmwu//xLnZwILFmHvsMyygrwTbkfN03STE5TMNp8PfCMmervAM3B+AjAn3UkVIeeLOc65zcCe2E6gPTztHnm/lUgdHwLhd3WjEyVM6JXNELPli+V3kj3ektipZ47ZdxBLYJTNUz8G8RX4uWULcWc8d0DJC0jIwvqhvuI3patFPqqwy5LCe9IkTve91UFzz/1ls6X+00kPt9Yx4GVeA2hdCBPl813DUnwEcFe11m3+Cvs1+nwVF/VtrF9e08D+SzQqZ8VBHEaeSerSF6X/9WmHG2wT4UY+WWZtXNyr8Xta/4V8Ov3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfeuaoU7GTCbcl60CqnyXOK24PyeO94E4fo/WUUuFBk=;
 b=VUYV/wAe3tKSPyCtheCqMw8CfzmCwRo1tD8GWVOMinqW30nmxJmuEFdbHnioIEITCiZhM8DdnONCdYbUOHmSbmditsBfY7i5uvr9VIpWQhZiMPOvaejEmi3KHNuiVC5vhtOb7/nNj6u0xzrxoVCl+ACzuhydeohGngO1cHlXW2KmdFX6pkcH6ErLcF1zY5j0FCprE2M90mDDqN/HwFYbVg/R4qe3biHOjmy0u4d7hUNWu/xNnTQIXRQetDBoteLL0L+N19nZkbTbHXrXPGHE4UBusoQI8jEABR0NGneIDtpSyxaUCR4MZybbr39Vh1r0gPXD//ZrnTM0fnh7LK6gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfeuaoU7GTCbcl60CqnyXOK24PyeO94E4fo/WUUuFBk=;
 b=DkltigzPfZbmxhT6NIwbHIUAtIvSOipmnZwUf4wB55qhhSuJ8XB9zE0qKPRKz8MAzawDprdOllhQqV5DSieng8sWTC9FcVTiX5V1OWsnR+pE0QMZJsRm5Wv+iIb9xM3fq4HeE2UiFk7nO7nbo6uWxGwILK893xgIalym55yNix3fd5uwrqHVtofJu4s9xxDp1dhS3hp8ZcPntDt5XtAlVNpt+H3yObekrF71PdQrPPaoDggBcMnd2cjE+DgtYO4Cl0GBz1cJHkvElICTdKpk48oZ0fWYDqBt3w8pry91CxK2DaYSAk0CgXm33h6XIzYdDp1ETStkM9VWwctcnM2kCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 07:40:40 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83e0:fdfd:2432:226a]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83e0:fdfd:2432:226a%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 07:40:40 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 2/2] customizations: Install systemd-resolved as DNS resolver
Date: Mon, 24 Jul 2023 09:40:35 +0200
Message-ID: <20230724074035.81965-2-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724074035.81965-1-florian.bezdeka@siemens.com>
References: <20230724074035.81965-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|AM7PR10MB3175:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b90d8b-05e4-46ac-2c6b-08db8c19474f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1gk81pffb4jsrf5gc0AbnvaDh4+dkvZfA2V+Qmt4Wc3IUFxnUc5Pyc3CUUP41k0oPD0/Y1QfFfVtesXuyLxNAM26uFNC2xPVxGeF8jK5wKPhW0tVe80+7q3/HAEOTCWtHe8f+LbGJ4yX6j7c4BMvKSG/tozrXnixfgQCeisRpbHqOBf0iC7yJEDfJB7YhAc0buom/XsRUnYgZQRo3aWeecemYgS0Da1kIs5OgU1qyY8Ihs5JPXML60R0Erj4OVKysp167+mqeborMbHXUgr04E12RNgV3xVUmHUJCA/oFKHLX4izIWMa+4JTbHC47Dh9lzId55wVQRQdTm3fj5WWTP6iAjY0590XLuDiHfmM8ic39BwxZHp/cUjKc8Huq5RKdXVDw1xl0d10/qv5zkplD9phhv2oKKy6mM5Z4oVK6Ns9ZHNEPqZMDrdruq5LiYPbInM+cLc8or0lOSvM3BxzYIw1PsQ0TOb3yarW8bi04sPlpDSuDMfbPBTRK4hpwkihNtdRWPRl/joNCEyGYtVoC/Sk0iXHEmVd+F9P0hZJ2e3BX4oTOTR8KDonYRFTnqi+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(6506007)(1076003)(186003)(36756003)(5660300002)(44832011)(8936002)(8676002)(4744005)(2906002)(38100700002)(107886003)(82960400001)(86362001)(6666004)(6486002)(6512007)(66476007)(66556008)(66946007)(83380400001)(478600001)(41300700001)(2616005)(4326008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nOeT0BeJ/BA6/03aX0wsQvcbUqjUXtQfSebq7YfoZM3FN8oPHFOXvhZFtA4z?=
 =?us-ascii?Q?dmv5sTcCZUUBL8ZEokHVx6X2oMNrHG56zJeEyl5HrNv8M+aRnknJ66O8zXKR?=
 =?us-ascii?Q?Sliaj7oIQc03jNo4HqwHQ919bRiIwBdE6FGIl9EkpUETrjw4mOr+xzRoIH8m?=
 =?us-ascii?Q?b1NLyjOlspZyb58nJwjH7VCPbsRrGxS2FrOkQuQd4Lo8PXnmgblyw5f4AdnE?=
 =?us-ascii?Q?C1RJBt7qhR+bceFMXq3R+O+MOvhUUt/gRXDviJTvJc7E1o/zEDLsdh34Ea7k?=
 =?us-ascii?Q?HvECC7q+6HLU5NtY6Prb6Y+GrvY1opXn2y4IIh9u2YR6z3/t17q42DhNmeNC?=
 =?us-ascii?Q?J/r896uJ73dToHyOAuTEpzMcIrEQ38J00sL3AEbU8y+MZdAb52n9nN2sVfe9?=
 =?us-ascii?Q?6N++ICbLHXwB3L3zj1qZVYmE/+SQM2QlmXvG6anmt182eZEi7gDrAUQh7dqK?=
 =?us-ascii?Q?gW0E7XnbCfPsg5KJaV7U9ZgbE32/2z7qJICOWxEgiDi74HcDNveYKColmkD1?=
 =?us-ascii?Q?4NVW+0y/SQV2Oys9KKWmt0wHqgnctSdMeE3HPEuRhtSrDdBVTQEUfWlEuPDT?=
 =?us-ascii?Q?PTfjXMxhxtPEI+db/dlJ/3+DMCIzZHfqA9T+0juFTcfa0OhhfeaUwoocVqjd?=
 =?us-ascii?Q?81CtvanAsNvzySI0nTc9/CBHhu3rp0t7bQ1GgU61cYH48koyWapOb9PjKwNo?=
 =?us-ascii?Q?HfcUoZ3VuuY62tXQ4PRJGUZB69lmFQ92u1+szTlBqEhDxkafpRPOvlERpaEB?=
 =?us-ascii?Q?GB4KVaQAP2bCEnf9JobCLhtGI/hFObbuwH64xhW2t1ObmRVSlJJ1pRT7bMf6?=
 =?us-ascii?Q?dG8Lla8GuFR567B4xwHBlFaFCf4B+dfSaSHLBCUtpcJaD+C7XJ9RT9ZQnGbC?=
 =?us-ascii?Q?mssd568QKd3JysjuJwndzTXb/W3kPrmoKTGp+Jz3DBkocAr8jVWynxrdaQwi?=
 =?us-ascii?Q?A7pR97N0vd17zI3G9Wr9i9i6V4G1YXbgc/2THqM6cDdgrJaMR26AXKL4ouvh?=
 =?us-ascii?Q?psbG/Bt1RDX7rFKVhAaUU/5POFxa8uVG2gvmUSq5B96fZVWdeHr6y9wXV+Up?=
 =?us-ascii?Q?uE1WK9nYyCIGhLg1J47+kuFs34qk7/qOzvcTTMph9CfLodOfHv9jkfa1im6E?=
 =?us-ascii?Q?Sr6EQU3+kxyBSEnpFBjqM4/EgSTo0i69dOnARUg/KzfOd2tTYTAm+CRgp7Xj?=
 =?us-ascii?Q?Nqqv9micHxjyYQwfVfU+3F7fmQNWFsUhnP8+NxJ+R7jj8jqSjj7nqP0LwYtO?=
 =?us-ascii?Q?lbvSqb+xEmC5allzG0CPlXbOcX8qAPB6MbF58XtKoKUy1d3HYMHFF5uizvBO?=
 =?us-ascii?Q?4XKfi6xNaWLi6HWpHbisalD+oYpBIbkDv/jX0OrH7DR6q7IIbDj/fcXXizqT?=
 =?us-ascii?Q?v9wIB+MLGmmiGAdqm1cBNqhPNyAJw2XiJkEUrYXupyBHMLeQ9/55QiJ8Rw+L?=
 =?us-ascii?Q?H4yG2cDi3ReHh3/Fe6OhaWSl6IuydguEZfGR5+/IGauIhaXURMgyqNS4Vkvl?=
 =?us-ascii?Q?qMnvJ4cs1xqY/ynMo9ioeEgQ6N9fV98sjPrjwpYhEvSWXHYmoVBlUcTjwGQc?=
 =?us-ascii?Q?kTcE9SoeiFBC2AQMYAkEk5SbWXQQRqPYCM4kqrIWqSIvNSOMmxRNxPSj8IBI?=
 =?us-ascii?Q?I3m9OlPUq6h39/z2iKY8HzsyQNoiBVdoklV3eGKTJd14z93Z4ReZNy+vDNUa?=
 =?us-ascii?Q?pFleXw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b90d8b-05e4-46ac-2c6b-08db8c19474f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:40:40.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uR5osA1AvbFQPNFjcoCd3QAlAxNHJPWpzwH8460Tqg4PApqXkzf5XPMK2gUMmtXkFqTRfXU5OuT3Wk2OnfL4ADqNhEPg3vHoVJ5a99FahMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3175

The DHCP part of our network configuration was working but DNS was
unusable due to missing systemd-resolved.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-core/customizations/customizations.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index f86bf68..fb79a8f 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -18,7 +18,7 @@ SRC_URI = " \
     file://primary.network \
     file://99-silent-printk.conf"
 
-DEBIAN_DEPENDS = "openssh-server"
+DEBIAN_DEPENDS = "openssh-server, systemd-resolved"
 
 do_install() {
 	install -d ${D}/etc/systemd/network
-- 
2.41.0

