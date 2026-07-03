Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45A41735D
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092480; cv=fail; b=EKNGCEqmYwKNn31l6BahSn6nTIitWA4xBGdZDI1ovW8sIWMYFt8p7QcEUgVj9nIpSUpHKcq8IKSNSZsLgSr6rZIg89lBalkGZpb0p8TYP225BlOi5OK8YIWWIlaqnrVX+EM5rL8FTcjLlJQBG53QQhO7jEBNR6W/mVQcisAxZ0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092480; c=relaxed/simple;
	bh=ZFlG0X3CRNnksGFfFp5k8jC2mWy67cLGno0oaZfk1s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qa7Q8beMdwLnfdxNCx69Tvoz97OPtO8RnkrOuBA5c2727eAWbKlyNX3qWgcg3asF9AP9oLqlFbh8kvi4eYpqYM8z7ZZE/Ak9WG4WhO0qNkrwsbnHh7rmzYsk7fRAeBRn0SCRf+fZ5nMayDZBLZFZF/l1u2lTdgvMCFKgRSB996w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QIFHyOxS; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QIFHyOxS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izgszYW2Oo17P2O82YumOgYP5VHcr2PM5bFFUTm2JWrwUKMN7jh6qzFahvDJX30NXn1mM9b+MyFJg1ph0M0WjxQ1SD+OwMW7VWgEWxYWRVXqzbD7HT5RRXIFbSWw575kuyUkF9kbESNxPlgiZ7cx+rEtF9zEM3qF2rKvi02fP2P4p2hUFXH4ucRaE+IyjQZFUUuCmhfRyMUf8OCW1Aw3fWrO6APLxbfMO87BMdHhR6hisVFfp7FAB4LfpkNTKzF4I8M/ZhvF92kmok1pdWd9vi1MDguliPHeBhLtZUzhenuSZIdLb8y7GtnfDsH+vmzcgeGmjKnw4CHK9TbwLtnDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bBDo8Hl9Tn+8Cpx1m8KpIirlSMaYTkDydhBhr687xA=;
 b=IzyqPj8pRAtumZpcGh/kc9eaMUcF0aeEz86auBS8b0StuKntE+UH0V+wFU7d45PRfdPG7JI++IjRHMlhkkHfDRoMf8+qTEQ48UWAZhMV0NGs1vqUOK6hT3KhrDR6AkJ9c3cX4iVY0WSMX+EHnlXFSUCJzS4UVE2KHQ+dis8ZgDNt48zGOVHH4nNvpyqClw4udf4h8Gg9K1RnH9TMPwDLxv5guhX43qlrr+h1yp2699p56xFdewzDF9ZKFowS8/ovOrVVlLeZI/+Bbi6BHlTrxz01GYk/sPl8RBAioAMCOboHQRQCIhJk/CG1cwezW69wkzLbkLW3GMzz76ibffjtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bBDo8Hl9Tn+8Cpx1m8KpIirlSMaYTkDydhBhr687xA=;
 b=QIFHyOxSdDuf5RBvPxJNhSEM96CGSAz0B9gHdYAwxm/mJCFo58c9SQ7STp6EzYiOeJQd2xD7s8ChGJWKzow/d3jijU+DrWk+/SPbdOECVsNL23yZP/1nXnJILLMwtxSWfu5Jz/lGsVjYz67eZ5f7dMssfNzXS8iFQARZd+LX6nAxHuupRr9tvXWs9HilNr7OxexAzmtuQnZPaT3bwHHQhwe7YMBIHQxswDzoRafYhUHDnuhjqR44xO8NAl5phriZQucPY1qe+10RBO8G5gBXL35GpdD/bOYafU4DR7AiNpriEa6GctjybItCEngRihVHY3YlnGlObp15lwuVusa28g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:49 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:49 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 04/11] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Fri,  3 Jul 2026 17:27:31 +0200
Message-ID: <20260703152738.129122-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 28642b56-8e8a-47d2-4030-08ded917a419
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	35XebiwkQyxR3JAXTJ9D4jDxw1DPsj7f3ax4Id2AoXxOeURWD75O2gVksgaWyj8TV8oATiVpU97cUrVK00dQo+8VwL0mPAGdBj9twN5uYnAMKlTSEJx55So0Adg2BFoAiVQplkq3THUA5XBiwtQ4p6Ee1NrBCjqcMDo3bfqOCXfl3Fi3rA+0KlBSXMP5iqIGn6hKaUnClZQfPU9vNpMk57JKHVi8dnNmxENAAtX0yv0kLXIWJzRtAFAegUSsyPppHA4KqV6enfbCWqembylG3E5mpqFmH/962o+X0ZQbcRy2+b/kw4nk+dBw6CgYH/iB/84Sm9FI9g3D7IAg8ImLo7MIjEMnR4xRQ8jP1npnzx4NxqmfOBuQ799kqy8EzgcpybY314soz/RLmw6S6RPuNrrjIkFn3DjwUohEi6rppPwt2haralPWFYug2c9nXIm0aDfPWuGwYpSG3DY5QP4CstU5rtgx82ESHuv7ESEr5mTUDJtKgZaS8IlkhF4GVsgBPlGpt/DUck68GWEtM97/dJHzjMHcXGoJRBRYM4R+8n2f72cTuVuqAp9rDNABuQSMpYrq8yiAsatoywXe2QHdoshDszlf8+0x34sd6f8kYPSeqMTiJ/4a4yeYSs/6lr+wRLN7Y8lozN5g8fMFhAb0uI2e7H+csOhYZ9YBGD4NFFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pb1SoRtNSxF7vHMjncfgvS1MlBzdmqGay8SBUM/wsUbl862qmOJjs+6KmLxR?=
 =?us-ascii?Q?GJ1VntbtKUZgOGdIWnU93w33JSDloDkn1rVFIAusge3eU/eu/ybusSj+Caqk?=
 =?us-ascii?Q?cufVAud37lAvQ7kzONXnNwxcMN6stOthyNM/nhbAgIALMWxFF4VC7PqQG2mR?=
 =?us-ascii?Q?DmHf6Z6POb8blfQMuMSvqB/HzcQ6Le0BKH1mmQn22WzBiUGMTY+eI6R5M7E0?=
 =?us-ascii?Q?6QHYJ8WDI6ZqrrwC7OvDcZX45j0ZvAdDXN5+sOc71ByhWNxxMeR1F4c7MuuM?=
 =?us-ascii?Q?fLt5DUI+cfnqtCUYMNXfydjv7ktG4LrBhRRxniV1YyvW/yet27dVpgs9WdRZ?=
 =?us-ascii?Q?V8mFoRwfTJH1bHGNE/ObR5pBIjmP9pm909zkPp7fnOpwRxp0uzrxr0tIsnDK?=
 =?us-ascii?Q?dbCDyuQai0F5Xb/Z0T7wfupDB4LZzzyV7oCwMHheGlD9fwh6hDQDmSqphmU4?=
 =?us-ascii?Q?lr6bNCL4BZ1FqX8x69fBGpD78mKUz2hVE0PwZKhmK5jvbLc9/kvYqSHgSyQW?=
 =?us-ascii?Q?BaHZs8dAdWiDak6k/S+EkDmQmYzoTqtPEh9tBm9mUYuW28f4zwPGvsEgDCeO?=
 =?us-ascii?Q?l6+thzUGGyglhxC7aCbDRO6N265ZBvQM1qkU8HMonj4LEwNZU9FTN2+K/wOY?=
 =?us-ascii?Q?1vY78P7ve0X4VqysTgNRMu+ORZFx752e8Lp2nZ0/oF+BVze0z+FKVqd+v0PB?=
 =?us-ascii?Q?BlsC+VcJZPlV932X/DPU2eMnftoGdk2cYLGNLJMfBQU772y5splfWBybZ+l5?=
 =?us-ascii?Q?UdIJLYD8a+E5lJN8BhJpkEpgrige6iqdPPMxKF/q7KEv1Wu6YfQUdGVyaAyu?=
 =?us-ascii?Q?HOPoP21sVN1fTJLNnj5Txa8tcBILJqvRZtMEgfx3SQ0//vaVUMorS/op4qmQ?=
 =?us-ascii?Q?oMw5YW38UQpvpm8DUHhSZjcWOjtHkmrNr1Q/KjHUXtbX2i65K05Va0TCrKBr?=
 =?us-ascii?Q?MjieyYlP+xvy+kZPgjPOcbzW5g9iqhJjLUevDl9XihyxS9GvIg0cNOQSLiC1?=
 =?us-ascii?Q?r99SmTf76oMXlX7fIC+fNKd6UXHiaqd2KSrckUOOU2VOR1wwyq45I4HgpSJr?=
 =?us-ascii?Q?t+fPKQNc5/TJW45Q2afveW3Qdmb6eRXWfb1LlbW1IFhicuRKsCQqj4+NKan+?=
 =?us-ascii?Q?4kITE9YMNCTbZcjCMZgXd37R5Mf3aHa2BGbUd5dew025giW6w12L06863E/9?=
 =?us-ascii?Q?5+fA394s5PGzDDLs9VmoozflpLNl2vc8lpeWZwLSHu7Ku3CBQ3JRXwo/nn9i?=
 =?us-ascii?Q?bdwxCj1evKURDx+RrP2aE9FyFvkLoffU8GsmLA05x9Wl9fWXyGHoX1g6eKTH?=
 =?us-ascii?Q?M2I5HYhDDCNZV1DvoaBi7iG83sD4zb6LvzYwW5uNmvRY3Rg8oJgybQVAeJ/v?=
 =?us-ascii?Q?dsrUVqNrBCrnOeqXwfzqirLn21eGKzYCPGyr6kfMs0zE06NfhhbzpPHRPxsK?=
 =?us-ascii?Q?QcyV7fGSO3ybK7vDltf6d7m7OpoT+EcAsezRbz84DzVJcMNgJrHqEGpvlf3+?=
 =?us-ascii?Q?+TfiDPI8N5Z6vJKX8f8sU/Rm41PPyG2rhqrvKiUdzp9SWjw7bnc7cdo4oxky?=
 =?us-ascii?Q?ulLWUJM897LaDkUEZjixtMZjgs9eP7M1w7pQMhlpuQxW/CxbnEAasB4MAacJ?=
 =?us-ascii?Q?/K1YXnGWvpXaINb8eDP8/hjOIkCFn0jootsGZX8zwwVRaWRec7ZWPFjwlLgo?=
 =?us-ascii?Q?pQ4drJYaide/702O5QKCGzXMfzaac7abeaSAYDvXqaBeaI6YRX5vcwn63WsL?=
 =?us-ascii?Q?D0VRJRgukzThBblT4zVuHSfBnTweWlHRI30pCkJPpdODD5Qce2zCMl6f6Jbw?=
X-MS-Exchange-AntiSpam-MessageData-1: /L29Bhgj/ZqfRo97xZ3skC01JYCS0UHX8fA=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28642b56-8e8a-47d2-4030-08ded917a419
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:49.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhRmaH5tIaqUrGIK9SbBrAkFyTVTaS6S9TnKa7MLA03NN7kNFKmVyPrRtlJ6EJcIPnk1Q9DdhYv8GecTCddVjco3TPB/q5y7FpU3HTbtnms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index fb8d1838609f..25de8929ea37 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -156,7 +156,8 @@ static const struct msi_domain_template aplic_msi_template = {
 		.irq_write_msi_msg	= aplic_msi_write_msg,
 		.flags			= IRQCHIP_SET_TYPE_MASKED |
 					  IRQCHIP_SKIP_SET_WAKE |
-					  IRQCHIP_MASK_ON_SUSPEND,
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 	},
 
 	.ops = {
-- 
2.43.0

