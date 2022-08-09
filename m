Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C414429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCou1sexZPvFfzAC2nQbE8hvZCLh6I+J13SmcjfqIm9aMztoJcj50tXHWgqf1m+rGHnUlzJYI2Xro4KWe5hzBBvaaYZ4nyuwzfBxMjJ3KGAxPDGyqq70rI1TH9ZuKaz6pRg8hs7U6Hw5qgfxxAjJxAL2ShQNFubdNLvzHtDqU9hiJDUt7d1Rcx8sigm8YrPQXmG29/1Ku6sQL9QLoJAn/70awmyv8gQHsTOTi5eDjf0YgoomqM/+4DMe1wQ61INvshFcaW5h/KfuCTVwdjbUhi0PGCSrjFvJS0xVvYhpvIuKyNlPs1a+2AOh6Eai0SZ11jDaL8iNJ9skI69ZY2y8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXEtqc1RYUDcDcfR0ecHgCussUSri+HMo4+sV3Hj1ks=;
 b=W8iL6KX8DSmGOlyBM2sJ/J2aMAPdzpyDgkiRTLEe8vcU570Ofe/WnQtzoPSn8sPoTID17K+vyulZscd53XnWKSmNZ8PyPBe1ZhXQldFTRkhI1+Hokf8kdQptFhcM9z2rM73alWSU1YVMwQchhVImaGX+UuJuc67dCI/acj3qLAnNcTlsIaWlcH5tklUEKPD73D1K1+ywHMpThYGHZN/W8rGgmZyUg6TPNt1AmET911lsn+vH0X8lEiSqndQ4a0aeMwDMHW68F0BjRvTYBZ9lwQTUgolhh5ICSm3f88X/W1ABhsG4P/JyWsQSnIwpGhuDM2dUMT/y67JQafV5KbAHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXEtqc1RYUDcDcfR0ecHgCussUSri+HMo4+sV3Hj1ks=;
 b=tww89BNR84DKzo13ZJluM879wH5/KzPMUpKElv6vo0qxfaSIS1LQoHLozI4UfA7+lac/p4vGq27TYsmU4LFpUxb90sQjeXqQK7r5wmzhGJT8dWPUULcrTAG85wQXgtbIuAxqYcmtlnchwTK4jPHTLsULEDHL6lQFaOJFDMhuePCyVhN1sMudCDD/SD9wRhxcdz5qIsY7Dx+2V+wjPpcQ4B5+f5axpnPtLOr0BfOeiA6YjsXqk7A3J9zjVeYhhZ3Tr1G+dGq+uPe+aw0eyNh4PX+qrWHfd3P89Yy0Z1uOaY5uww8cj1Z9bE5kam/A5yY5DXIlFA2JrtX6Ip7wdTiRaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:54 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:54 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 39/42] rtnet: Enable compat ioctl interface
Date: Tue,  9 Aug 2022 15:43:23 +0200
Message-Id: <20220809134326.23688-40-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0023.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::28) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f8e33b-3d1c-43e2-ba25-08da7a0d479a
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	95M58XwYOEXVHrFDzHkck6kSYMStSks5e56S1xMPbJAijCAwJ6IxAXReQ3PlQKYnEwdSr9tLQFwEfvHWIxQfVrrZ1RgokS/LyyQ+YmQffvNOk1SLt7RaH7CGrs8g9TbZ1E0tHew71B9oGTPUOUOFUeh8vhbTL6fyJMmLJ0s5AJJ5Cv1K3KRvb/Xp3a62mxZqwqTAoFA68/NKGwi7Mf8012dIiWsqmwjswR8C1poPRJOzy0A3Bypeipm9gOrZOuZSVem1Yw8iUid1dEL98DjO/r7ArjpyJphTZqhso96a9QzNuGbHScq8QzzX9EHL6Ks4tChuIWXRdKD926v5B/UMiCDxUol6lxKb2fPoSO1EGIDRBWaWOuFuI8xd+9yKrKVhHL/dGr9IuA/n3P+9DJGjd1m+ecnVaP5vAkJqWp5SOLFRhgClMtAZO9fqClsDbB/0mxGrB9tZ0fzu63/CF2iWUYUlgJruAvVvr+hRqoUFcSY71dJJkS3c9q0TSaQuUsljgzEoQBRcnagCJgmvz2Cm5lCC4vxBk3DMbUE/ykyNxa04d1rf/+Zxjh+hwD2QDun9gX0Ys7HPXh2iHQBb5sm5s6besv/aGWApWNKkuj3QxoYlbEb19Adj12gKeCtspx8wBquOfQSL7LsJ4xt0odxAaFhQUzH89f8YHMMiG7kzbWW4XiGR7sW2n8X9tN1U7NPvDD+/sasQeOLO7i5PSqBbi601PrbkXFQnVGNkq3jFDPg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(2616005)(186003)(107886003)(4744005)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sDZYUS3JlLvuIS9Pz8jqNwd3WPmEgoNfrT+/+a741MhaSEnTHbvL+I1PNrD8?=
 =?us-ascii?Q?0A7/a+/oLrPodQ8y8GQElVhoRjubHJMaeuJomo0py95ZF0ckVpCTgbTlk0Dr?=
 =?us-ascii?Q?9PEu7ndI5gfIpwXygGXSWnFLUJELMCJXiRexHLMC0V7qmLPDZvqBT6xiMFTr?=
 =?us-ascii?Q?kN/bfeEEp7GTXbnXNDGXO+DYMgGxkRj0cM6/XZe3yA/R08saHB0NjZrwIKCc?=
 =?us-ascii?Q?6k2cflEUPRY/98Cs32Bg5lZLU5mjY7oWLerMpCE2bTGbQERdBve9lo6D2pl/?=
 =?us-ascii?Q?teHNLNlHtwYmdTUvZpvkinJQYKFxVRUF9l851X4EPtfU1TeScHb96ZpGt+XP?=
 =?us-ascii?Q?vv8SwJvWhFjP4i5vbBEW1dR3HjCkusWlD+OjHdgnQWo2y1KqsOOxooD/OsSB?=
 =?us-ascii?Q?nnlocSDKiNkpz7hh1vMGWFsU2cP69ksDQRw4N9gaMG8Lw5t9pdPzgwGXSmSd?=
 =?us-ascii?Q?qrACtls+EGU56aMRbRQYx1OcyqYYQ717fTKCsOWQ/eMzHs71h5ra19nQvOti?=
 =?us-ascii?Q?TxsBIRgQhej2R5ak3clUWpFx8sA3QX35Ebt1K110vCFubh3ivwr5e3GlYOL9?=
 =?us-ascii?Q?h/R/raIpdkDe/weg0ZbqbLdKzrmKgh6OirMtt9jusZdea+Xf3+l+U1deV+01?=
 =?us-ascii?Q?mPlQ/w7sjGTRSHIckfFyYW+Zq1SZfsQALYEE962ovyaj+ck0zJZhE5jcNmP1?=
 =?us-ascii?Q?EzgnfG+cJu/Ez9dNaraweovuDlPsuluA2QYdIq+Z7THHS3Glhan5yeUEPSMe?=
 =?us-ascii?Q?/HjXPzh1yZJQInzBQdToDUrClPkGAmCPtSyhJNzJ5wzE+k2N7kvmwBJyuCjF?=
 =?us-ascii?Q?Xab6yglRZHTW9uCgQxyUHQlMeGDxam/nAFSPzy+lwcw/jzjqlonsLDa0t5j0?=
 =?us-ascii?Q?UIhHi/cpeWsP3fO4H9GsQeO2BnNQrQcXA+KplnLrMDoIfmIUoSRoLH79fyvm?=
 =?us-ascii?Q?kzqdvunZePu6mZ35ccH/R5cnfKQjYyHkWrseSQUfqS9BuyLXu2dl7/d77k4u?=
 =?us-ascii?Q?BvhCGzhVVQ/J1FkQQ4j0MxVgEMg6nPtP/5gSSAoGj8gAxZGR2lLhl/gyAxYh?=
 =?us-ascii?Q?wWAuzWvNDhqGnz6APGcx+x9W9ycHEZVm65SiGvQuZIkWxGJGTr3AwJE+BtSd?=
 =?us-ascii?Q?HhT6aYyHbB1sLo4ANTTYuapq+TBDsDL42QJFCJ3PFmHUjWS0hluQ06G1e1/B?=
 =?us-ascii?Q?mGKRIgV8kseyiRL0optBKUtW29WC6wV3J6f97wZcHTBmUMbfA13eZ7tFyhNw?=
 =?us-ascii?Q?wyWFSp+kDKU8exfrT4v8aVtRl3bSXaG1Z1pO7AE3l0GibMTPhhvOKBcnvoV/?=
 =?us-ascii?Q?NGIwCar/eXyItIHxI+EL2+MRqXt1xpEWyzYTZlKMe+1v4qQ7AbIhH5qJMsTV?=
 =?us-ascii?Q?FUnHLFb/KjVx7ghkeGvxlu1WKce9tvISx5+B6eE7gCtQuA3W2EoWNNhera1e?=
 =?us-ascii?Q?n7E5sggHnoDtt1MB9XENfYSBn7Nufbtkk/S6eO1F13b3tFaGxQ06badv+/N5?=
 =?us-ascii?Q?eHKrrg/D1erSr8engtMGZIqqDPFA8xqB/zS5tLVcq8lmoHdIdw8DoP1gjKh1?=
 =?us-ascii?Q?3z9TFiK8JbdwhZy2zfEc1XdjBPaHmHq73aaiiSCatQQOP68zhCb1ObmMWRN/?=
 =?us-ascii?Q?CgAIHI2AS3yYK5n9P47z5qs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f8e33b-3d1c-43e2-ba25-08da7a0d479a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:28.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu0K8AvfRj5Kzh+Nk+aQ+3FQRNtaCv7WFXjYmXGtSDMWmYMCbuMY8OabeEUN9ntJag2U6GJDG6mlFvcIHZW8H9lcN3D0LfZ0uF+2PJ42RZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

Running rtnet for compat applications failed because the compat ioctl
interface was not activated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/rtnet_chrdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/stack/rtnet_chrdev.c b/kernel/drivers/net/stack/rtnet_chrdev.c
index 9457661a1..fa859c3bc 100644
--- a/kernel/drivers/net/stack/rtnet_chrdev.c
+++ b/kernel/drivers/net/stack/rtnet_chrdev.c
@@ -195,6 +195,7 @@ void rtnet_unregister_ioctls(struct rtnet_ioctls *ioctls)
 static struct file_operations rtnet_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = rtnet_ioctl,
+	.compat_ioctl = rtnet_ioctl,
 };
 
 static struct miscdevice rtnet_chr_misc_dev = {
-- 
2.37.1

