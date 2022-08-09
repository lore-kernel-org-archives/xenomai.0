Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8F442C
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Xd/x9NAlRd1aV6cKncFCCHuJtevLnSECFXqNshH513QVYY3TBi7JMjKt7mLuf6J12nOWPO4natf31hH/ZzCiEJp+ketUMKECmETSoIAhj6EDbu/QY6O310R2DUbd7/V/YTWsmGLrk6eTqKsPfUREegBLB4U5fspP8SGzldAZJx2sp7HddRp8Z8CrJc6KovGjli557wY4qkKukgpU776pOcLQPLO4TxZfzATNueXycMF2KSbgfVpUsUHc1VOWRDhe3u5L9iCMkfXiuMPtoY4v8F8Osa6ePoA+B7fTxy/YGwJV5+GM1wY+AxkySRHRjD+jWUnYeSQMzPUbptGn1qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Tf1UvIxMUdbngTHtY+Az5Bt9OmyVJS8DrvHQXr4lxg=;
 b=EULkIlEPgSy0mOjCoJnmiIIhadN61s9ZO68I+z1iJx1LdCCbOvxdVWIfW/WyEAYPScrPTV295OYCJyck1Nwd6moPIuIglPQ+BEH3IQ/B2gnzbzbi+4KgMA+Se9LxLvLoRvNtkUBz6NTDRfY8FYytzh0+7fQyXERWQ+eJwFmztBODPsJHspA5Z7gA4v5xVnlCYUrKl94Er4wVX4DFp1nwBFqYvBKQYvcyyZoEq3DDJR4txuzD3Vw/u2knC1kWZ2DngtnfqGHyAylY2oqtpuXl7ph3FoP/3taR99TtmImtehALquYCBpalpufQUFXVn4iqSTJ/sp/jaI5C0RY7KT0h9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Tf1UvIxMUdbngTHtY+Az5Bt9OmyVJS8DrvHQXr4lxg=;
 b=FpD+Z5uLAgyJdaNP4NdhG0Onfj7v0tU0+mchY5aVwUwnJciNQIylmXV6vWOyF5EI0GVaI7mTnxo5HgHrK7lYuXC8o1l5/rXVaiGoYoj/DhOXporDfEdw0UMsE+B/1KeFS8wwNAqSRQgN0pQyHeHw58gEsa1KA91lMCgbnJ6EIsTgXXDh+1zA2ddiBWh0bVveeFbefS2L0RAFtF75g2PBLkj64kHxUF5wHWAX0aSNEdDfiGOl863GanR/7WIxXcMtq9MdU1cbyOf4Tk3LWOY6oQ8NngzU4aAvLWb6smtrpC5iUmtabAPCJPJHnzreuy/XhJhgiMB68Ouq/F5K1R0utg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:05 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:05 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 17/42] y2038: testsuite/smokey/y2038: Fix a very unlikely resource leak
Date: Tue,  9 Aug 2022 15:43:01 +0200
Message-Id: <20220809134326.23688-18-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9695486-a148-47ed-0f19-08da7a0d3a22
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ohwFbd/bWTvV1Pum//K/WuNeay4xtMiNIetc8Cxqago189B2GQdMMEU4vCTGHpKI+gYRalBtalxjbxPvwRWdKF3xzNjf/LePOgfiLcyDNoD1W1xc5IcySxsc6X5/TukxK8Y/WGV2YmROJH4E9+ngTcwp47NJfmELBmXq0Jqg+/uB3GRdJCG8Iz28zYi6ArK7ov/wjtioHI2n9AfWtGwW9vqPxmMPXb0FoaXhoLww33mQO90fKgTprVN4a4z29yDoUUK4ycHIhmWwiHq9GtoVh2VLuFMIIY/FycMDMDxX+Cz2KhQL9nogtEKHKtq9FvKNxgN+vuifPheTBc70UowHOTgoG0NhjRDlC98IQ7aUeMfGuwLwqxjku/ktjUFxKD9W4oNzfXtOaQEcVyPP+6VeQHNPCTS3M0mrINC6QOwNNe97++Ymp7sa7QihjAGBMhFCMi7l+7FQmgDoGD6ta4xL0AyIUgQcs0OVe2yxAIagbn/ku7L+Ai5F2AOoaJ1wR+mBOAx4X2IYMgs9w1bRMvA+8R2/UuLfvLq9VY6CKSllSCHMkezAGf0vQa7UqtUrNUk2BIqE2jWZUkxUmTbdWTE0HIDlP7eedc6ZQfvdLGrgRISXOqmJ/kIqUfQl8WS1KZxtfGa+tA+BYe0mcOSeHufKywXJmD97uSIPhqmAHYayg2yOOFjPuRimjTB5emBnt7KqrUFYqxPEgelWFjukSZtCHX64FiGNeY32dTSgLo5U43I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O3OebBJX6XcACN7EtbBeYnKSrYfPXbd/XaZ2h5Qi1fIFU29uAu9Nf9tYGTHK?=
 =?us-ascii?Q?1NVwfd/9rY+1oSxTZc7+os3tAgvDJN2sqSmPXeSJpI5z8VW86iK68Tn56mDx?=
 =?us-ascii?Q?wXzZkA+f4gkOJQOHpyJWbZhLWDNigDdcNr1tcUSoZukUTqgvZxkB8XJupTZ7?=
 =?us-ascii?Q?Oms07DskxNO584tgQ1o/LIysP1M9bMQJOa0azdZ8az1Tmh5jO+ZvFM6k0C0G?=
 =?us-ascii?Q?HJ0CHGlycXyiPLu9o3RZc4ETy+V4pBaO00+a/gJYKhNUk/7xpbKAjgvoo4VO?=
 =?us-ascii?Q?4riG3atNIDITVdZVbCRa5hZ8yNILPKmsQEWO4A3j/vM3puFpwucwPZP63Rr1?=
 =?us-ascii?Q?XPYsDpyGz6Fjp30UxEXYnj1cRS3a0zmdCpx6PNHYFYaAdC3wRFlcUO+CY1cC?=
 =?us-ascii?Q?KxASnZMX0LS2vdEDWB+7ACScallM2p/OBbtCdVoF+wGPKnrKid97yCkYnBxi?=
 =?us-ascii?Q?FouFSdAAqq0nZwWB3ZXGR4DsaGLdLWexfeqjbxkyC9y8/nNkAo7nn0xy2QPR?=
 =?us-ascii?Q?e8bNn6EevKJ4KGC6YcxUxmgO92RqR5Y7WorR8SdmjB2htrA5C3HUSNfEIFDL?=
 =?us-ascii?Q?59pkv3mkI8TpaBCSi9NizpSBiXojKwLAs0SQG32iRCFYZWAZyFBD64cS4Ppa?=
 =?us-ascii?Q?yUOsikQRftRTRpYbbT8ZUF4NtOIjDq8Hqncjc7cQWjtWfWA9BxRFsOkgxZh5?=
 =?us-ascii?Q?96Zvf8ZFpjCEJiXbf/6oG7aqpMGHcTFso3jBpzR7x1ptneJGjo0pQ4uTkmUB?=
 =?us-ascii?Q?xvULjThIfxbIGGR4lc4JBkBUV9HxjrqTcUSOKaxwX0DFEs/8Phd6wFhIOFEG?=
 =?us-ascii?Q?rvmthl/d5HJWlHTBMeNa3Wv01LWITrQxhdLYkIilroZg2tFpZnu9myGRCR6j?=
 =?us-ascii?Q?ekV9JvLyCUc76P/x8s77DPk46aOme9c4H9AUxAd3CaSYjwBLSGMAwCWb8KrF?=
 =?us-ascii?Q?rb6O5K3ii+GIQtatZumYLaL3XDNmPQ94gGXuLIMggKAbj+Zg8OJjkVB9qm+y?=
 =?us-ascii?Q?DMmMaEebvk39X4rrDImScSqbqXRRL1CO38wDSCRGP1z14nMJWV9jMQEa0aIw?=
 =?us-ascii?Q?OxAAh2+e0Kk4zgewvapCLvmYPv8DAr06m5WoshV2tBWiYA6/DwAelAOe2mKb?=
 =?us-ascii?Q?ee5KvMfFUbsMDC7n41A+X3qFqDvCjM3IQljJ6hHezxBpwjyzBK2HXU1uQWQx?=
 =?us-ascii?Q?0GNokGvQ+FuN0J9NVX7lMIlhfOoIoahGdCl/J8q6lyOuMY852GIgZ9cnAXv7?=
 =?us-ascii?Q?7HjRvHG2ecLyb7phpcgpIxlhXOnqBHdNWgtSsjYgMvUZgAHZ44oxJMi7U05b?=
 =?us-ascii?Q?95hZQv/FFofkGZvZFNGy6VQKcinPiqlvLdzqjRP+p0hC9YCfYycFMxQ86qNF?=
 =?us-ascii?Q?R/tU4VrUcJ6myDweUXrW1Rd7Ai22UKJgNMXZ25M6ahE9YlAEnb4I1YCa3EQO?=
 =?us-ascii?Q?K4yOJeQUwQmA8btvWT1IouyoXgsWKIFYiHVKPZ74yBM5OUgas6lsjQ+Ej476?=
 =?us-ascii?Q?eploOCc3w4bu5H6fJ4KrJBbNdhnV5nz+4FbkXy1Jwf92ZUdo8AquotTLS3KJ?=
 =?us-ascii?Q?HWXpIWq/uhuaZV0o4cFi+8RrhoPSF6RDeHlf32VwodOi3JyYXOG0g9/cfCJE?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9695486-a148-47ed-0f19-08da7a0d3a22
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:05.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQaHiLqjmqiraid5qJuJEnuK2uLAda8fUcVcV3FLI3sH5jHwOnQsuk8T/Fd2mocCMswGv7cXgHTGX+Zd4AVFV/0d5RPHClKnyrQsP2+aqW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

In case we had no kernel support for the cond_wait_prologue64 service
we would leak some thread resources. Fixed now.

While at it: Adding the "64" suffix to the test name. All other tests
have it as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 2f4041e51..6fcb97cac 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1117,7 +1117,7 @@ out:
 	return ret;
 }
 
-static int test_sc_cobalt_cond_wait_prologue(void)
+static int test_sc_cobalt_cond_wait_prologue64(void)
 {
 	int ret = 0;
 	int err = 0;
@@ -1142,7 +1142,8 @@ static int test_sc_cobalt_cond_wait_prologue(void)
 	if (ret == -ENOSYS) {
 		smokey_note(
 			"cond_wait_prologue64: skipped. (no kernel support)");
-		return 0; // Not implemented, nothing to test, success
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
 	}
 	if (!smokey_assert(ret == -EINVAL))
 		return ret ? ret : -EINVAL;
@@ -1293,7 +1294,7 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
-	ret = test_sc_cobalt_cond_wait_prologue();
+	ret = test_sc_cobalt_cond_wait_prologue64();
 	if (ret)
 		return ret;
 
-- 
2.37.1

