Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390553AE1B4
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538041; cv=fail; b=ApgJSyhLas0UMQxRxzJpBtsHu+q/GKH7GBtozZQ5a1b3eDsaR8/QyCHr0JFrjU1PdD8UHbN/qWAfOEwVf7Ep5/XfcRN2pnU/1+LA+jpQ+RBsczQhnZYfJnKN1K2298trbhap6NuiSrng/urGWP3Wqe0nqcl88NJ7/12fOOMzBIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538041; c=relaxed/simple;
	bh=lCpaUSlML3USiqJaT98akdDYYAYuLrgf4+CyKho1eio=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f+T++wEnncLpMv5QBtLOaNx4wBr8oVQ6/uIxtc64w+axjxatGbr5ruiU/idWjuHcekWQQ2WEf8vsHnGTleGclUBnysr8UwgRFGj5EoP5l5Yiqm1/lj1WUHcaU5ivRNeHUvtS22c16iGCw++I1h9O3TbskUVExXEoAVTWygP0zJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GRiGWjpW; arc=fail smtp.client-ip=52.101.72.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GRiGWjpW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Adf77mJ6cAxoDNfI48emi2IzL8uPVeguFHgYa20NRkRHa9PHto9CtTdKzVy/UnShBykaLQy0KaYAu/ot7D6i4e3msZMmfKsqh0/3MivrW/7I7VLBXlcsq3X35OgiwO22mhiU0HnY8cAh8A2KE9U2D5njai53rp1wyjXd9LEARemdPCoH2RU3vZuddQmUavZbw8OvfYMHFdVNBr+uJ93Dc8cwAElApvpz10Oqo0OhXvRIzD1vy+0gGtA0p5lgUYEom24IuttcMCEa8yclQ2bV9+7FVIkVk/OtwcHjjAZnWW16abFFkyqCTzMGqqKygXqhgR7eY+tDCl+qrVkU0j9F+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWb7xumNPeJB8nQvE553jh8X28OE93tYptjalNgxhss=;
 b=j7aSOjxNcP0+RKSC2GdpgNRrWutUS8dWJv6zO8CfFLq5rpkeJNh1jQjkwwDfxZxRZme0hy63NPtnse9GsYqa4ohNIP0fRW/XS0iuAqslDRNnlgrRi2rFAh+cdJRUNASyOWwjzenIG8ZrwD2VOIzquyzaXb2CL2sSd41FXY+es18M6L7JlFbGzVmY24BEiXwocBoc6NuIBx0FrZjUeJDv8LRasQZGjeTSfInXja6dtsbRK+gh1v6OPN8JEq3ID+Z6nqVtJD5fzAD3gvf4/PGeyvcPZ/jjM99Dnd0/cXef7kKgOdllXzzy+i3HipC1qzHCaxiH58cC5ghJiXnTH9BJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWb7xumNPeJB8nQvE553jh8X28OE93tYptjalNgxhss=;
 b=GRiGWjpWW6toHtxFFeCpE/KPc8cXVtAwZs5TTtB66Ggq4PqNkESEQQUDcdjA8kpGFNFncR46caaFPPNyfgOHit7rUgnyI6EgNO5TO3T2O0KT8zXEZ4x1flefLuBB3zSnWZOY7k1pIzuc5rQbfu1J+sMcYaQcozQdswfZr1tAfXQ8XqF2ODmySdGSb1epvxqwTyStRp50voalqvbyQPbIv0ZvYgRS7ORo2MN1/WlKmytLvLjGrQYc7E3pjKcyNBsaPFDmMT5kJv/KN1YU6gMHPxtbLvpIU0uurSF5gGrGUPTyNbWL1MKR7z/ToiL+iKqx0686uNXFuoJePMA1GuBXoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:07:17 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Fri, 4 Sep 2026
 16:07:17 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] linux-xenomai: drop the custom riscv branch override
Date: Fri,  4 Sep 2026 18:07:10 +0200
Message-ID: <20260904160710.1502327-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c44287-9700-4dd4-580e-08df0a9e974d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|1800799024|10067099003|3023799007|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	ovHbPre4HikS/Ivp60Ey7juEgwCQ0xkGglXDzlaquzMLIyDvTjMR7dTS+DVomy+/d1QmdgFRGOmI/xg91sbhg9v2OBB9vsQzL2/lJCGwZT9m8+E3qvGHwUyRlDrfqXfQef6ndN6Z0OOUecCChpMVBR2GmZ0m5ztwUPws2ZwtX7X1mOZzEt1DHu5mq+HWFXOtrEDThBhhLq7tawx8fim99r5V+n3leI+XpCZ3O/7C3uiJTkVbAdLulSScvzzU19bGFy6UEiDZJthhNoXyA0O1LmVsG4jt05HQqX05Mq6isMmtvPd2qxFMoaFbn9gcCnQtXX5Wnu30GdAAiOa33KC2zbWCCOCB+V5tuOZrQe1oU0lSeQTcNAmCJxAu+WETUP9DJKIqj6OuTrcMC3HNL2LUixppZdTk8jCt/rXE40raPb1r1F7OcFCSeMyTQb+Y9v26ewEb6g2UwK7NdfUctftzJctubhPbVpSuvdjtgrtMQkb+fAla1mnxr47uVTbN+Y+e88rSRnSn+22/xvuwB7dJ9ncTaIwWmScvBojyHGohzJdVIl0EXqHQA9MbgeoSn+3F3ETRaitpiIgVFE5w5m0ybLmKJBVAtX7YFEqLYTI59YnVSY9nuwUZcFaC3DQvm7l6wJ5CvKNnW0QX8TS6+CJMINTholxRxaiqos5AlqOSrBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(1800799024)(10067099003)(3023799007)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n3+WdTlkcRtxG9zHBhRJ4tpm3SQ782UxdFuO9qlcyznHG6wVd1D6YoWf+54w?=
 =?us-ascii?Q?Q5sMrkwGl7TERQfDfo2rjPIP2rfUqVZEDqFWaOVc+zL2lGX++d/SHeuY+Pkd?=
 =?us-ascii?Q?hqvnExWblIVJvsXXvylV3r93yPvuRlISbkcdSaUUkzLyoaWZdumllHijrxKJ?=
 =?us-ascii?Q?+Esp4G11Ah6/kVrX47f0etfzvG2PpmpWD5LSv8ReqzDBCxo3rO4Ulc8pWdvk?=
 =?us-ascii?Q?76VX263wL3CNNXLPPvtzO50mDcDxhxQGzsIH+C6ve3BaB9uuzs86gT67LNtD?=
 =?us-ascii?Q?qZjjsCSWZaFCl/nqtZsjtdtjhsUEhcQg8fyHJ62oeqTEiD8PX4iPz/08lSOS?=
 =?us-ascii?Q?16sQAm/0b+AwY/hbyrdaIG+5VZmagmXG75BV9ZfxosAOIXigVeg+ouvFblOv?=
 =?us-ascii?Q?UZgWU4A7DO4Ol7sCWglbmrv7rWz83VFc06lFOwbT08w++U8g7UTJ5OodQSx5?=
 =?us-ascii?Q?IZkapro3fK/kHxQC6xNK8y/ejwLuf/jWy1G0hngG9wunk+T4J8+zuDO0HQ6N?=
 =?us-ascii?Q?JuoDz13jkdVJ186JGXSDzAVO7rAXqTXiaUlvgda7FeNUBdbRu5A+43hGOjz4?=
 =?us-ascii?Q?s5W1bI/2qX9h6I9ANOwR2CfLoSZyZPlmV1jHsJ5XGq18c2SRcMNy4ZQGh7K3?=
 =?us-ascii?Q?ld/JryFuw5wyhatt6+1JXp27sFV3xKfwLmAr8X/TIGY42FhbpTGI3tIuB0qz?=
 =?us-ascii?Q?tZtRJFITTIhzl4BgNqgH8KAe4AWpwLxOexLKGRZC6Rg5Qrz3z/ttU5zPG3/L?=
 =?us-ascii?Q?eCiDwujBB+5naUTjyT4NT2nI4fyO7yt7fWack89Yx+Ef9B4wSqLW6KhjKLCG?=
 =?us-ascii?Q?6J0qq6cMSF/dgIW03IvIkz+BSo22RPloTVA26q0WCr0Qs5aw9p+Gjy31hPQe?=
 =?us-ascii?Q?6h73vqH3gjRyeJKJBsfqd1Rn4kDqIjsdH3lUQ1eV9wImMZq6/b50M3ddDU7t?=
 =?us-ascii?Q?AH1WHrpn/Jpg7uki/exOfeXq/bhjhRsR8IUt2cYYDTvIUpMgOUC6x08LwkL1?=
 =?us-ascii?Q?miqGpDGLjwqHwQ5MCsVzXZZCtybhGdBcXRr7VcFw8bJWjWVm4VjwchkdqruD?=
 =?us-ascii?Q?M+0uobPE0P6NnjUcfGbaXzZR+JmMx3CyhcL1ziK64LmyBq5FAbvsyvFHQ0tF?=
 =?us-ascii?Q?6fFvLcHHPo7M7xqlWReP51EtLXzUfM9ddqMJAw9IqFKwVrZk+HSaCm38+w2Y?=
 =?us-ascii?Q?NTvjZ0jVwu26yvqT/JQuZbHrcg7Nw4fFcLA1aWGfPdeMajKdzSRDeHrAraOm?=
 =?us-ascii?Q?UttuFcxrukb9VSLxvHfDaydwroUsIcgEdArjR11LTxnwD2q7uygxEGvkBDMh?=
 =?us-ascii?Q?yeQIIsqdoFfusQ1c9oAWmpr739Fi/CmqMUZZGN9Hd9TjxSqyXfkjHAp0NjwU?=
 =?us-ascii?Q?B1LRkwa9WXXGcYvC70GmzVlmECZtYO+kwlUgsYIDoerl8PsSJyt3UoWf9DuA?=
 =?us-ascii?Q?obewQRD65WbxdNXnr3JFTp6ezX7fTUMRwxgx7udxZ/xCTY+mFDxkhXHGMsem?=
 =?us-ascii?Q?gPdv8ladfbPZTJeNsA+l8ZZAEW/V8JsxOjLhzIf+1SMrG8YZC2b3bXW8aL+r?=
 =?us-ascii?Q?YhT6DskbpNZE/0eSXkUwwo/ZRp3Xu/IMC9uvEGLWKo1Yw7itG2UAc8XiNfhB?=
 =?us-ascii?Q?n2kfYATI53jRBFj55FwYCIc9+Lo+aCvcXoHtWHClVUWDpZKEbGd8kWRIOOV6?=
 =?us-ascii?Q?kYkqYMoZ1h77ZAHGovTis0+9QFtMCKzZFOOWceGsPUWb43NP4gzzEFgEHKda?=
 =?us-ascii?Q?uZJJMH1VbdlZ6w4Qnn+htW6TafOW7fJ5EcjIxlnC3I1yWT3wBMt429L82m84?=
X-MS-Exchange-AntiSpam-MessageData-1: kzxmRPnwpRPhkVvowDFS0dVU7raGA3pJHGU=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c44287-9700-4dd4-580e-08df0a9e974d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:07:17.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPNtvHUEFDXji8UKNBMfOvYdvgCyy5bh9UgsiTTrHXsHJekkg7+b1YtZWxp3tGF2BcXLchhFfITrtMneLkGatHCVDDQKA6u20gUn2OA7XQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6914

RISC-V support has now been merged into next/v7.2-evl-rebase, which
will be autoselected from now on.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-4_latest.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index 345809e..e0f743b 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -34,7 +34,6 @@ GIT_BRANCH = "${@ \
     'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
     else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
-GIT_BRANCH:riscv64 = "wip/evl-riscv"
 
 SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
-- 
2.43.0

