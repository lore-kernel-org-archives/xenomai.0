Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50058.outbound.protection.outlook.com [40.107.5.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065161C03
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 12:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmWAP7eTOBW/1ml5Vhb7XPlilKllTuXs1Wed4r+RFl5Hs4v5n/ylJzVU8wsbmSkicc1JZWyA2C3HDuYx5ux9txrh6U9MkLoWF9r3xZgfPH3m9v7naJZSgT/Y4OIx5zW7YlFadu9k42es/C0otMPDpOt04S7fQ4EPUEYPXR/z63Smb4cB9HMyp4qkW+xCU59iLp6qKSWQ1M1y8PHlErhzByC22qWVh7c3GOKufQEnNueUy+Xtbl51JbKal0ZYxsL+sTJI7EUAGLNpOEImBO819TD5Cv22cJCfe9oSOmNqczcUToY+F+osF4neXazfYYbYiqykjCumF5qhnRGRvV7atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TbvD3x9lXKfXNUpyfDsefrJZYjrlTHZKWMkXkiBY6w=;
 b=X10abyDewZkNmULuzsOAB+Ev50O1iCcXMp1BD4onIBJzz0QgU7LfWsIaSdpgID1p9aJ2r0i4ylOtsU2e73/RDIXTW6kRJroNm6i70KHrJz8m/kBP7slkPOtwQponGHgiAim84NWxWrq6wz888mPXQlgkeg62cJGy/SxrIJu6GVP116358rpbhdM4XypyMppwjkccOyRj5rrKwMYqIukAqjLWah16yT+PkvM7SvlSHKmeWIixcOuzC6+ZluEkaFCiRDrBhXemvi30b1Jc2BMFIWw/sVeRNyzr4/AW/YYgxx2gy6MNrLIemqfwV2ri7vSeqYNjMWonx/r7zsGxGb9kiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TbvD3x9lXKfXNUpyfDsefrJZYjrlTHZKWMkXkiBY6w=;
 b=hq18O3Tvwb0sZseFv8QeGDwwoJx1mDn2Y7zFUEd9alp8enYWJHXG62n5LkLmQJfKG6NncUeYPYM0GJ8ERgwAPKXCPpNbyo+XC7P2OA140aMUZMIuHpUd5xAxcZAKRIUrcB3t9vO4WfbhrCJLoF8QgdzHs8tg0laAzw072eJ/EuQ6wnf7Svf1xppSDdiyhUFW+CKCe8EMPo5MBi8eL1zOWiMjq2C6aVhq1+XGWqB+7sVjTnWzR6qDEGIsnfWPIOfsfwSp7aEouIPYKBr0U0OnwMytWMU9g8Y853Yddc4MmCNM/56yhZZFwMuE033qqT9nMT8rOhS25e/zC0TosaIGhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 12:25:11 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 12:25:11 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH v2 3/4] drivers/net/stack/ipv4/udp: Implement compat support for the udp driver
Date: Tue, 20 Sep 2022 14:25:02 +0200
Message-Id: <20220920122503.115682-4-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920122503.115682-1-florian.bezdeka@siemens.com>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0093.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::34) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: 9624b121-c11a-4650-25b0-08da9b032993
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XQGAI9ofvfqt9Lb/uBqchtgrOFLdwkiVKfV2w68k2Y8dk0EV/76ApAKgP6Wv6hFEaHCf0K8s4Z9Psaaif/699IMlL1BkkHpK/Qu6K46ysRDvW5cqH2wkAHGiRHAoGmV037OcSDER4WtuzBwoX5ZHXROdQdh++KpKtP+y00gJhst5jAlPHTzYOea4UQSlvEbcG+uLDKbqz2rxY/FJ/3rTtJQmIPX/sSCgP2x9118d8Ef9aw/PL8Mr3/K4eil58VnHvWx5LhqAq4fTwSoEfwa3uMOy2PwPyJzqRakPVR73F/WE8O97jII/43+zpWUeBN8JHu4OMFppg1ykJO7IChVwoAqHP4bJ2GPtbnIGSciqBgz40vBAV0uP0aLxX7d3g5TQxHc24b3pXZzM8nhC0LOaNI9p6Lexpyyq7+EXVTIxlinsHOzDZB0GABSo3N8/wbr+bM1rnTf7A2+3XyFBthzpRTyARm3OY/dwn4YtAKm9Sh0U/+oEjPJRq2Xl/Xs5jqIv5o/Aj4j/fIAyPweIv2yw4VJ3/YFHUS4B0l9OOn439Bf3Wlr/Qhx+qhH2it7655oculdcXQ+0T2wX0T7m6Q2tX0ZuAYBYrJMP1G4Iqe3Chfo01G8fp6nSKAZ6prkPjAZBYptPxmPs2c+LVo+g3gBXw3SFi0oGbA6JiG1R2cbKmxvpI5qPVFc1pNUk8L5OZhAu6IsBlMIxzJxFhIpjZFW6hA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(2906002)(82960400001)(6486002)(5660300002)(38100700002)(8936002)(478600001)(6666004)(6916009)(54906003)(316002)(86362001)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(6506007)(36756003)(83380400001)(2616005)(44832011)(1076003)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+f8CTJ0JGDRw5657kjK9z7pluI+wH0/GK+p0UVOLk7N6koojnHYpk7eXxTB?=
 =?us-ascii?Q?LFX0lJlDRFqXtllLO2GazbHJG3N7tSrKZkcaUI+gabmJubj+Q+MxDjiGC1Ib?=
 =?us-ascii?Q?DrKyl0P3Sexr/Yn7lI+I9eV1l54VxYbSyMvy36feGzyvPJe8zsw0BD0mUjaU?=
 =?us-ascii?Q?lgzqGgK4STU07xFvR3Q+lPEVaKc4WWcAapOnRdGDob4+v0JbmWXmbmkM9DRi?=
 =?us-ascii?Q?nOlbJdpO7IpnqCTtsyOQnBdpWGS7GpMBrslGcCDlaEWnhGZEQPonAAILdhL9?=
 =?us-ascii?Q?r2xOADI6kyEmnGTAxixBtbf3v9Licm8uDfh+Kw2se5YNA03SorIlmIKUHkxH?=
 =?us-ascii?Q?hvZiirjI8OW+sHc0GmkmM6s+ooKOsIsrxtfChhBFsbzTX41NOJ3x1pnq4nOm?=
 =?us-ascii?Q?Vz80HHpZZ/2Vkrdv/dAnUFZbin70Mb7KNeJlAXuX21iKRdwn+ljk8MZAntQc?=
 =?us-ascii?Q?lIz/JIldOEzyGr3Bk55AHxEAI12QyAEMj0DxP4VYIM3BZVebDjlG2DgXVNb/?=
 =?us-ascii?Q?pebKIqc/0G7Kk+90CJw76D77Tx0QISBP75G044bQNILALAsYWG4tkpdjAaxh?=
 =?us-ascii?Q?qiQ2ObL6E3Pe1gE9ncA/sQkPaAK3rfz0GvjbZXAK5q/EYFzWKr+zHgBtta07?=
 =?us-ascii?Q?0qJ377vGU0tzNOxMjUG/MYbHEuvoU/aW6TX3AZKPlksqCzzaRe+61iBovHLU?=
 =?us-ascii?Q?Lx8HUBAIF/7jgJwiwNO7bR7b2JxKHvwem1Kau84A1DfEZlf1+WwaYvXQ4VAy?=
 =?us-ascii?Q?0Hr3c6Gj1jNqryz+B9F4eE/Tc7NlTcxpYAS8zLd8/rU44ZDodem6xfpU2xcY?=
 =?us-ascii?Q?I+2aVkl0nhH+62gCHDP9rOHNQzaVVUGaVnwHey0D8XqsYw7XUar+SnokP4Rl?=
 =?us-ascii?Q?51wDdIvw6g4SkBmYSBDJdVWEUsrPrp65+rOO/+LJIr82F9XGcC+Xksy0pVRq?=
 =?us-ascii?Q?ORMHlGqVvbQE17MFRzcLWj1l8sGc1E8K6LuC/5TUCSoNjlDAKqxkPn+U+x19?=
 =?us-ascii?Q?dgzjO+c6uPCqaM4RKprTW9GE44YXnDKdCL+TQnwuNEEvsLcxbSuCzL6oKz6T?=
 =?us-ascii?Q?cgy8Z3xbU1acowK3U6RcL4xf4XkTdbyCxjlQH5n7ko7MEeXDDvmEPbNoNroT?=
 =?us-ascii?Q?7rs7wAbIVhOnUJlyRzsovuSC/C86UL3H/kNAHYLJ3oKpSq9w4JU3YhvBsAiG?=
 =?us-ascii?Q?yydn+iudBA5KdyckC9OKsmkXmH8+exLBmP22v6aH1rwq+aYeYq8mnjDw7Gv2?=
 =?us-ascii?Q?wkfYE+tG7N6uVXPCg4qRukwpcXvNJzG0u2qgPP2x5fkRU7pYNXNa8peJtuX1?=
 =?us-ascii?Q?jQQk2f8nWTHoHIJKrQx3fl+HMbSj4MhupOYvRZskecHQl10fH6G5lrIhBQip?=
 =?us-ascii?Q?oZ15vEamF47Hl/xpLyPdiX4xteAvROe6pUf+jqIULRDKqE0I5SwS/mem3Kyp?=
 =?us-ascii?Q?dvZ18uMfLivsgpAM2qKIouFL0EZiLHJIKcmtALdadkt4zQadNcqfxjsJSMkc?=
 =?us-ascii?Q?ZzHjqEFePwW8ikElB+IFhBpiwBipbjqVYo+gKORraZ+jm24/y4U0SHsHc7Nl?=
 =?us-ascii?Q?+g3/vqSv8ZpjDAenN8Xff/A0nTa2eU3d8JVlXi8ipL6BrQ/TGQSmTPc9gngz?=
 =?us-ascii?Q?JhKWFYywJ57ct87Efvckz/KmEZkZ1JS9SEZGeUSOyXefRf/arGoc3Hds5KRu?=
 =?us-ascii?Q?0mrqtg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9624b121-c11a-4650-25b0-08da9b032993
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:25:11.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7kkhkGJz0OYXqrsRZu75AzO4/d5A8OtVJ+U8PtTKEMjGutlYxQC0DheCan+pav4Gik3GPDq5AQvhGJQ0vtDoGHhra5wHGqtRXIIsGHD+Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611

The rtnet interface was lacking compat support for the following ioctl
commands:
  - _RTIOC_BIND
  - _RTIOC_CONNECT

This patch is heavily inspired by Konstantin's proposal but migrated
to some rtnet APIs that allow us to stay away from
  #ifdef CONFIG_XENO_ARCH_SYS3264
sections.

Reported-by: Konstantin Smola <ksmola51@gmail.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 5977a3bc2..777c8a27a 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -31,6 +31,7 @@
 #include <linux/tcp.h>
 #include <linux/list.h>
 
+#include <rtdm/compat.h>
 #include <rtskb.h>
 #include <rtnet_internal.h>
 #include <rtnet_checksum.h>
@@ -355,25 +356,27 @@ void rt_udp_close(struct rtdm_fd *fd)
 int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
-	const struct _rtdm_setsockaddr_args *setaddr;
-	struct _rtdm_setsockaddr_args _setaddr;
+	struct _rtdm_setsockaddr_args args;
+	bool do_bind = false;
+	int ret;
 
 	/* fast path for common socket IOCTLs */
 	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
 		return rt_socket_common_ioctl(fd, request, arg);
 
 	switch (request) {
-	case _RTIOC_BIND:
-	case _RTIOC_CONNECT:
-		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
-		if (IS_ERR(setaddr))
-			return PTR_ERR(setaddr);
-		if (request == _RTIOC_BIND)
-			return rt_udp_bind(fd, sock, setaddr->addr,
-					   setaddr->addrlen);
-
-		return rt_udp_connect(fd, sock, setaddr->addr,
-				      setaddr->addrlen);
+	COMPAT_CASE(_RTIOC_BIND):
+		do_bind = true;
+		fallthrough;
+	COMPAT_CASE(_RTIOC_CONNECT):
+		ret = rtdm_fd_get_setsockaddr_args(fd, &args, arg);
+		if (ret)
+			return ret;
+
+		if (do_bind)
+			return rt_udp_bind(fd, sock, args.addr, args.addrlen);
+
+		return rt_udp_connect(fd, sock, args.addr, args.addrlen);
 
 	default:
 		return rt_ip_ioctl(fd, request, arg);
-- 
2.37.3

