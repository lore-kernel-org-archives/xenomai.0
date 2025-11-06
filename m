Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5883126B0
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432726; cv=fail; b=R8t1VFvPQ7mTdqRmKz6k7EHAJ28BH94I9LLj+JH3AB1vvdnUYr8NhGceHFgE+UlM4vfUHtc01VgFnhhZOBDIfs7NShZeYfd/oEy30CqsZZOonuBNrS9SsV3GZZ+EludRbqEsDzrg7h7AhxiNa77WG39Gyc5g+4XxIHuiFCOJQMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432726; c=relaxed/simple;
	bh=3XpMROtlW7+u8Ecg5Ohtp+fblhtg76TJLD4GfWggwd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZCgRxWNDerbC6Q4Qya7YvBsDxJ0wDgYG2TkvrIccW/YdcFQsKMvVX3HcWAl9pcaV5vHAo8r/xxf5CuQGAidlUIXHJ05R0CC6yoXuLpgXp0Bm5uB1R+IMWyzNQkQxHhm1sI+e0nHRNQuL0We12cCz9e6IP6oTibX8KuDZeDRAzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Cw08RTkv; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Cw08RTkv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2rdk+e8IZZnSRYv3XkTqqkpgp9XU0JSeUv6d13F47s4gIB6D5XMHet+sQhNfZbqldKRv2TJUsRLRd3jEdHJJkUK2CCMubvd/Kk/kuR3D9ARqvEYhOdmxwZAqleUTbu/ivuGcNqoFQ0RBcOK1sZ0tCsheo3jo84iXFF2h9tbY3sln32i/03a+ukDxm33gi9HxmI9PWl/602vQn6M3ViP9v9tG8plU55BlBQPEryBbX5rLJsrnO0QjOMWLPRqyviug3ohcwpLY6LPrDmxaH9dLssnYJ21wut3qAcy4LeiB8DVmJl8gQiVW3cqmeGDOY3O4abgnJpmglw6wYvdCl0SDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuaVhMBwJ9g481V5G1iojLtt5K0x4MIzj0UKGcRQT+g=;
 b=eAlfEkN/2/wPB8t3WEuMYzfTAXz9+bAgr7uLcwbEEgGhySVsTkYCGdxwuh5GNyVbg//YMxH8xGS1b/6/p0UJYqsZy6PlqmP8QG5ual8HCT3fpCWAss4h6jQPduuRg+lz/EB2U5iTaVmeCqFQW8mYSNUjbOyvoTdpMJedwnFG/wvGoajgVq3DnPevzmSeLqW2e/3ytaBMgME5btEr/TZ3GnlzMZyoh5Zes4OvP5ON84/aUAwcHxC5Fs/oZfZF9Hi27CYsD35o/nNG/b7IcId4431jVbJQyuYG7YbH1vyrcDU8srFYHWtcn0QGgLdNEhBAD60On921Z35R7id+u1ueBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuaVhMBwJ9g481V5G1iojLtt5K0x4MIzj0UKGcRQT+g=;
 b=Cw08RTkvjnNYORhsVYSobAnZZTreIUm+qWgNXUiHP691xlpb5iXRRLloSh5HB3LWBVMaHkiuR6NReRGcr2PW8L3KpKcV21+qhGVCTevJeK45mj5oOPXbEpko/cg3HVJN87pISdYMwhW4ZzECrONcsdwooG6BLJwqYZa7x1VG4tqOsaqV1WgSvZu40uyHq+PWaBn2AdCpas/JUSszIN4VJZZI6y8WmyL568iq/lkEGSt3sI60lwze+BYOh9qRSZa01gb4G3muLLjZ9Gn7+8SVcHK4bu9ZEvcwnrgOopBC6x5y2H41bLEnXKf4zFwz/5wcSe5+2TblrSoNV9S1Z11AmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PA2PR10MB8819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 12:38:42 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:42 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 4/8] riscv: save program counter in arch_save_timer_regs()
Date: Thu,  6 Nov 2025 13:38:18 +0100
Message-ID: <20251106123822.1160385-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
References: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:610:118::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PA2PR10MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: fe861d33-9d80-4a0e-b417-08de1d316b36
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/93ir2flgVEAro0GGWyU3iZtOFgO3xgWvKNxP3tq/fGFIw3Y2Xb6OU70do1?=
 =?us-ascii?Q?qaYjwJmSUAH+bc8PoU7WSZm2jIoZl3UbC0j/IgmYibCBp5WM23cfVEQq6BJ+?=
 =?us-ascii?Q?Z5RWgw9Q42ebgWFXzY/ADl2CaASi7/hubYqIn6qfFgVdQyIY+9/B+XEuc5lm?=
 =?us-ascii?Q?wExQ+GOImrz9zdNCGO6Re/r5dx+4j6XQRlNMKnFQSb3snpcKxh9698eUmYNk?=
 =?us-ascii?Q?ejZm2Vw5nAncQ3Wi4mQ6sZrcrwfovn0RlHPSSGwln/ZPCo++thTdHmOmEz9s?=
 =?us-ascii?Q?VnOy0uCy8ANVxkj1oeqT7JsL9hfFcEpC9UNRl7p8yewnAKd2A0FbNBI7lejx?=
 =?us-ascii?Q?k+OJlQDR6NsDhUIEgTkpy6oF/J/satRdIMcUdyHUUocVSrCWIMg6PnqNJFNk?=
 =?us-ascii?Q?3Hl5oMc+SrrrYXoPdghohg8m20aJd/zchGe44cQBLKLU60L0Yz59SbK4z1zy?=
 =?us-ascii?Q?YvXnHTbC3bOlDSQDk9mvheiGxiyG+9J9ocLMWsNARmN5dh24OsFu8fU0EQDh?=
 =?us-ascii?Q?VKvMHwWrn3hzJLXAw9za+8eTzpIiN7dzFp8Lljnhgp2zg6nvuTZYH6W0c0IF?=
 =?us-ascii?Q?OMT7pVKviz7pwN7/uA7i0/B86PTA8qFhphxgkzu+/FvNZTkNbyKOr9U8Kepf?=
 =?us-ascii?Q?SMQ8FYxTNh27Grm1ueiqbb22t31Jrd4hMiJtIlR1IAvowdlHhoCfkVI+wf+P?=
 =?us-ascii?Q?grFl9lLrrJf43ruKRmFFW1mR4Qex0kN0ByiWcY30VtXt9GpK8XAo8IFcOzXs?=
 =?us-ascii?Q?/zYRZQGl3mhowkQ4yp0CNsGPelsvkEpyE3d61Md0Wesqlw9f1g+0iyJNDVkT?=
 =?us-ascii?Q?txhUO5IXXB2muLgBm6EhL9RmhX+tcXKu/gcqyz+rckhcTAmVvhlJrRO1owxB?=
 =?us-ascii?Q?Ot+5+cq+O+xJ6TT8sQJ7nt59WmudCIT2b1HB+/e18oT31XNUasR3HJENxtca?=
 =?us-ascii?Q?KywzT70+PQhC8UlsO3XgyP3pB7LsRlSV4ArBU8I3Ak9nkIyqxqboBTXKLIow?=
 =?us-ascii?Q?fwCVWn6Zc7KbZucgJtS2X9iFG9Z6keRHZdeH7tITTEnXwihLXHXtUrDOsKxf?=
 =?us-ascii?Q?W7NuTL1YLhnH97J22CYw2Kl4oDeIlgdY86EbGoLRkl4fm4y2PDJhnAmDuAL0?=
 =?us-ascii?Q?cfxCpd3eSQER0rU9dp41uzgVpHdDS8eClcCE9EAqxqDT7t8+nwYurYb0Ce1U?=
 =?us-ascii?Q?tALe4TnYVB66qNBooIAxQEJVizTkfxC462sW2zOT3aGYnMMYGHscN7JI5m4W?=
 =?us-ascii?Q?ENMqJTtnwE4AW2hqEZIbikIupAHooqHfaZzLCBJPQglHBBO+CQm3vy3lykus?=
 =?us-ascii?Q?rwYfLJqRIJCT9hPpzSihtY/7RJSYw3PbCSbKerQ6He5DWBhm9a8ZXMFa32Vp?=
 =?us-ascii?Q?Kjz0NAznlC2mR8hgihNuEmn3/okbscQFyC444zLG4/GcIwM+ClM8kSInX56l?=
 =?us-ascii?Q?5vcsLj1hd3nCgS6QI12c8E00q1HI9fCk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lO+RBMydWDrz39V3byvcTmcFUZ8ihKSsTiVlUhdR8N1cqVqoIrBz/feFJeeb?=
 =?us-ascii?Q?PYGkpESvFci3tuu8Dy7jvDoc+qdoaVy4JL/hk4CwheIJumDPUBzL0mtIf2EL?=
 =?us-ascii?Q?1H4uJbDFy7ITLFs41Ioa/032Ai0hm7f1uBf/Kpc8eEnHgcR4sHZrpcL+UBX3?=
 =?us-ascii?Q?O6R9rSJM2TyIy6T7p4wL1IVlWKobJNbftbT4c+2zzU6+4ZE+dBDWz7J09M+i?=
 =?us-ascii?Q?lAW1muAENbqlWcfvSfRCjil9g/Z39q0i2vQSAVahk6HjeXuaXWFLpv/+GXg8?=
 =?us-ascii?Q?wCNOEHS6Jc/n7fbI194Q8c4msFZmgR5ZTlgMp1zpl6XBF5rfYAFEWrOuwOtW?=
 =?us-ascii?Q?pKdGuiXvISvVTZiYg0s1+6fVTPRnE1N38xKXat9+8ZOG+GKzimrJzlWIoiNm?=
 =?us-ascii?Q?K0EMguS1mFe2WuPbbosWUMfKWZMtXv4BQlMnQnb/x2dw2oDwaWacegOQQZGZ?=
 =?us-ascii?Q?JRB0d8UfMB3qEC/0xOjg7YVjZteCBEuMHryd+pnRzEgrc94bKrUxvuxTUnb/?=
 =?us-ascii?Q?6JgceQHgpcYLJkbleAehB7EBfAbRydjej6PCJf8ROiKODxV9MmG51l6o6y1z?=
 =?us-ascii?Q?HXnk2dgvvOfaJ4gK37kX5r/6VrfoSm4ZQdciZ7YfA/vCU3sgKzbu7ttx+MhU?=
 =?us-ascii?Q?ky+SQL8tQZFxdqMZQ6FJb5kyosKecF6yRpms/mwC0OWS7sE0RyqtqPxRiRVo?=
 =?us-ascii?Q?mqX9NP9/M34aFAlpAHtLu0hl03YApstkJTYyIAYA8ud93dgGQNyLVqwnS9Re?=
 =?us-ascii?Q?O/AOjPbO0wIpvwi4VYfg0mXlCJP8BJCLI7fyh28uaUijyudxX3+1KpXnLkic?=
 =?us-ascii?Q?Gk8sXiC0otBV6ymkrA5Y434WJNiDRfWvZTdHKyDOYT1POfQLdsGPWkYF8XA0?=
 =?us-ascii?Q?dwmcMW/F54lldsgYy5CxpRvOnAS8NgcUeJ1uzsQE3lVoNk0qIcAKJGmjaEvK?=
 =?us-ascii?Q?q02lNYNLf65E/YHkcB66kfLV8LBJay7MhAEnt+uytek+b2IokwrYN/rrlRke?=
 =?us-ascii?Q?YhsHxhX2QTn7qxX0fe05QVnpoWga3BnzUsZNJQhtbLcxdNp9pCDFFHWGkfyD?=
 =?us-ascii?Q?aeb9sOrmT2yTErEuJ7lE1FbZ5CdC5f0hAWWc7DMYCUTWAEXqcVPxu5l9UEB+?=
 =?us-ascii?Q?QZPR4Lsimtc5rM2n8oODg3xKEQeC0bMxZFl+KDD1O4q11oV1P6HT5tu0Hmbr?=
 =?us-ascii?Q?8XWliyxE3C0HCKw/bcPT0pGAPBgGEnREyYMH1RLKIyBNzPooJyksGczZxyXy?=
 =?us-ascii?Q?a/WulnqoeqeHepDzGldTr4w4nRpJD2p01RRFNmOkD846Cu6fOAJ6IgCg4+zk?=
 =?us-ascii?Q?OWtOCrnnBnichGRFGkEDj9H8c97zVy8+KrGIxfzDq+gbDNjZGs3MyX7ZPt91?=
 =?us-ascii?Q?2Qgu14ASiOIIRPW/BbtTJbSXI0delUzBN91ch80jQvBqPP6C78/JlnncLzRB?=
 =?us-ascii?Q?GzSPyANKfUyzGFOHkPIpqPqNr0xHl+pNLnzrfm0LifhFQxFcIqMIBYBPbAIr?=
 =?us-ascii?Q?zmIXryoH275doHX52UpfSoVPBuRj98DH7r6iFraAz1yA8fhGmS5jwtn1OVE1?=
 =?us-ascii?Q?s57n8cgQw58HGuZlOWM8uYkLGmru6xpH3r3EaDULSy+KVJSWxZkryAq0wNvp?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe861d33-9d80-4a0e-b417-08de1d316b36
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:42.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUEbEv6Ly0samKzm9uzDnaWvfjXyq6GqD4oCG0Muct3D9IJu61YFXy8L9vVwV0NdUM2RGGMPdipooFCybXVyKLMXVnfedkQfTYOlgMWKwRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8819

Extend arch_save_timer_regs() to also save the EPC (program counter)
from the source pt_regs.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irq_pipeline.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
index 030823745787..c479ec44b3a5 100644
--- a/arch/riscv/include/asm/irq_pipeline.h
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -88,6 +88,7 @@ static inline
 void arch_save_timer_regs(struct pt_regs *dst, struct pt_regs *src)
 {
 	dst->status = src->status;
+	dst->epc = src->epc;
 }
 
 #else /* !CONFIG_IRQ_PIPELINE */
-- 
2.43.0

