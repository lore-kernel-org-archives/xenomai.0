Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBCD41F7D3
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237162; cv=fail; b=EpWxjQj2XFHLAz4cNPawUW5j3PVi/VKfjbE9zS0om+6BHdSxdZyLGWnOATvhiDZ3UJlk41mGnadFZ+aoyZghtJfwVetKuyZn2RkCkJ6WdgO/Qv+koRC9au1ngY9cTooUl7z3PA/r8q2gWCkMAziq/t6CsnhTL6fh0gdrBazqqxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237162; c=relaxed/simple;
	bh=jOCc8hdvM2RI6q+llpHBeqbf5NnJxUeI2F//liAuZ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SN9VJ9TpclihLzx4ouYaxEs0JJGZ2pTpMgBcHlnKTTGH35koYnFjSIYGHs3nDv2xQ5RAdoj6P/ZCBpA3nexrwjM46Yr0SHHm8UHUCiaFgIuRa6rp7DXf5eGtzYBNw15pvBijq3ymPxzecj49ug/z43vnYH2yQbe2KxPf3yZFbj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lrozgrag; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lrozgrag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUzr1hW/ibNfy/LqbDB+YN132B42vAqzJRmgwGfl81Kw2SsXwwkvp0WD5ews2GG+wHYZITJqHf+RvUDNdSjD0gW9GpsyMJ9LPCR/hS29fMFz9YFuPlJbOqZwSheShRvcNhfUDYm3JvxkC0y6aUZOxvHB3kdW2pWxXpPn5FK0sc7Tdf6zOVy/mUV3H6YdXvu0mALM9CgTBreYmE6UasLG4v8BD84s37tW7o2bBN7d46LJlB21X+h1zR3f6K7iJ/qfNW22zChMBTNnXfgqLA5i+NjJmlzdvqSjnJ3oPSrODBhwzoEnhxyXVTTftG5QKDLoGgPPOHM2wLRR2mFY8B+neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtrtFvci6WP+JWacAh3BxRjDuRdBJyVwFTRL5MNLLTQ=;
 b=DyI+mi5ovjPzs1KkqocVAfefrgu/pPtz9SwOQL3cJE0ewnjfDoUTigFwZs8+D67+pXx63R53pDAJQxql9lzeDQORF4yxExUGR4m4DcRg4lvqlaxBXRonnKj7KPj+sHZ7efZJd5Vhfg1d1+g0HRrhnlkrSsCubpr+gEa81iam3w9gd6qZUdX4DwXtYBB9jM2Ym16J13dO1zY8bHSqYVBAzrBGDhe7TLTKqvqSoRGIu7k0ETeK32qEMACkCXBNaCY/LEcP1tVSqy4LVLUbBIP+IBrEalj09ND+B3d5eQ4WxeU1y2IWzvBKFBXujmRW7OxyHQ85I4GF6PWYwu74qzFFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtrtFvci6WP+JWacAh3BxRjDuRdBJyVwFTRL5MNLLTQ=;
 b=LrozgraggDMLXz/JT1wtBwDv3oPKRVTR+ZESZ/PXgmC0Z3rnyC2EcGnJmFzZvAChGSyXQR0GE/QdnqxlXDD7K6IjmP5MPorpcZ9bEVg+s9XLdhgqZUnNSEvZKe4/STpPdOWTfT/iBeppvekVXjhcSwZuWahulJlmR6wPuqdNytNALcyv8w017l7QPXLePh4NZZf3haze1BUCIEacIjOQgOjzNGqmnPvzP4w5UifiPdgwSmyk9laFR4ww4TNU4nRgBBv0BVV6xeEmRk1MyjNFQYuEcNrbvSwMikwtjDp422vMSsDpb3bT/kUUg4G+jyFpjTx5ykHHjS6J1McM8hyQ/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB8685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 11:12:32 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:32 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 04/11] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Tue, 28 Jul 2026 13:12:15 +0200
Message-ID: <20260728111222.2699158-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
References: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad21808-6a70-4aee-516c-08deec991df5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+Mbgd90viO47a+xYfgxqbypnHoqmQoKrqGiDUmCttj+s0wlMvYMFN1bHhLs+RECo7pJB5XVzWRpVK0xN+4zYh2P8foX7xpbdB14Gtxhy4S6PMZtWbzZ/7bPDyPDlw3/MApIFfxJa4B7TIwzvR/b1Qk9H2RT6HX6w17PhxtisXonARctZ2uMEFe1rYZavJbEEA9No4khrxpLieYIXjTrpM9bT0RfRFEMMUU2srYdcfx3WiyqmIh/HGFlVqn3Vx6ZkFroaSk8L6RsRXcF4yZjPJimXYl07uUu24gjdyRDlpuJb2pcni7SgAWVi02Unjz5lvPeDjGmg8BZbrn/nRupeOsIO9D4KJPvsQ0lhMZ6rIKxmVe/jpuC48BvzOyXpcVPv/KBtKntfLyW5KwoNOEpRJ4firjgOBgMxqMWCZ+QGKIHfTVrf42378vcCp+ZI6RNa+nFkaXx+6ZoudhebbZ0k8peFp2yUTo1M0y4s1W1vOw/O9j6KKQRhB7jEZjzZepbmOQzno8AK0XXxP+JoeNt8t08/3yMNue0d/pzuOZmuG8o45LG3SVUy/gVt/fB/eBMRiz4/PpuGkTWYonfcKNvnNEhtE6GfOsLA7GSBuHvf1Z/zofiEn6G3MRca+HOleQ5sdrzSsUDU36pXr+fMic/Gk/T7Qo08AjwZsmiZIbY4iw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?osWH0Ry8yTgjt4qqiugqCL2zWjlE1kv9deV/JuxjFOrhmS1pVBgjunSwekNv?=
 =?us-ascii?Q?EeqiDd8BXrKiL3NdkqhIiL1kCfHVD2Y33wc2t50t79lDVtX63wg3h/Mvn/fE?=
 =?us-ascii?Q?EEcgWZUdRhG7C1EQYTS76PSmotJeh2Ry9VeEB3QKZzrLYuPKl4xp0uK4ltgN?=
 =?us-ascii?Q?gTbTQOPuKPcijrhqerympUaPTW3wMbkTfgxlwrLIg1xDtnMSUsFJouPTUMwf?=
 =?us-ascii?Q?EOGB2BPMU2hjpUopeeHqkZpDd0keB2o2YM/59d3gxcEFbhB+hHZguvZoUBY+?=
 =?us-ascii?Q?WDgXbZP5Bcju4xAUVQTXabrhmBEABr6mFlZDtq3eh7WFaZlbI8s/V4ewJ1Et?=
 =?us-ascii?Q?Lh36rk8gToy9R7L1NVuPTOYEaY6O7Pvvj9nUiekserx/VcxhNLvjw1ZdmyNF?=
 =?us-ascii?Q?/qxSZ1h+uP1d3U6vGtAUeaErf39wJSVHzK3A6hHuSugrSNldFmnG9DV79rqG?=
 =?us-ascii?Q?U7LQoZAIi8luAe6C8p5Xs6NTIHgK5afoJeT9CcisRXSmmEWXBFvBXuysCqAm?=
 =?us-ascii?Q?cFtbikvfMUQv+xNGXMUJYtHaP8nouu8QccLqouZMkPNFpO+UiWBXyLXJeY7E?=
 =?us-ascii?Q?u1bIDOlZpVHkk+8gh2MlDDtMxEE1HrXg7bDxvjdP3cbM6+xT8Gf9erReHnzV?=
 =?us-ascii?Q?sMWS/v6R5oaW+jUdpfX4ZIxCpqaEEMbBFpZkcqTAen7YtFJB9b2n1lfwPLL5?=
 =?us-ascii?Q?WwtzZjRAYkHOXpMKJQfZyDaFvBCB7PJaRMfblHpTBfVlT4p/t105ye27rFso?=
 =?us-ascii?Q?bde8FZovA5m5pcx5jGDOPCcP6Yf/KsNsdSQqlCzLXKhVGQXe3Ngt5Lbo9tRJ?=
 =?us-ascii?Q?H/zaZQ977UrXo+ECJ23yBQHgo6jokX15UxCjGhS9Yv1GOyDaiqmMdpG2HefW?=
 =?us-ascii?Q?eEh5qZEApjNAqyK69QxD1tj4b8CaLY4MQChm2jmHTqdDmwSJFLKlHnBGeHoF?=
 =?us-ascii?Q?byIcLkOr3Q6RDXW0U9jKrOlZd6Mf4tYN/8GAwJKTXfQE/+haNFaoLvrrDTEg?=
 =?us-ascii?Q?V2ZsD0x7RKJathdtljTUE7+qGWjMS1tFuc2asgoPl4PAP07B9cwgcPhLFXm8?=
 =?us-ascii?Q?d/cURxJ4Q6mwEOlkjk+Z2LSoSDEO0nxFXOoeHaPjcLOrwJ2SBxsUKmjLGOBs?=
 =?us-ascii?Q?fP+2pkk8w3muBEP26h9GVtgUnKsyWAbV/e1rqNWEGLVGe+QSFNb78trKg4+f?=
 =?us-ascii?Q?Dk1sjFB0ubTbAz5eSSgLVtW4STu1hcaUhMVwWilooM6obALvTlBwASZBUb5Y?=
 =?us-ascii?Q?2ES+OPB8gh0Kdbi3Oug/9iDHiDhaqs/TZjWrSxhBiwvoBx5JB1MIcvxpYN0a?=
 =?us-ascii?Q?GfE8Dl7coSvxPw9n/3xOEColrjK0bUvbG4bTJTvq9gtfsOBxG5unarbcnMDd?=
 =?us-ascii?Q?x/hxIlYuCjyjp2jxpFCdHeS1t7MTk2Ce4di6oIPz4yNiQj4rw3ZymOZWdopq?=
 =?us-ascii?Q?exobUaQXpa3mCzLYxFwFVAMfDV1DS/DMhMi591a4na46WYqqf/3/LVmvRZgf?=
 =?us-ascii?Q?rETXvJuKexCmkPoUV0+kny4PbVxag+nhYoAsxFKhBgau1tSveEFLKBXvW7R/?=
 =?us-ascii?Q?ZOLR1pod9wyQn6qiZEEU+m+xqS7bB0dquSZ7SbvYi1qnS44h/H7juCRn+QWi?=
 =?us-ascii?Q?Q1TANKJFPbp8FHwaLzhJiqIoUIqzDQkL8GWpzldTOykIasTKirpfSNcpGRim?=
 =?us-ascii?Q?qVLzAKo7yHzDOAOi3vmhvm7vdcpMKHhag7VbrJrExyIxmm/1EWmssEe7nml+?=
 =?us-ascii?Q?zGNJIRHyQLTuSNts8DEX9hkeCwV2gew=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad21808-6a70-4aee-516c-08deec991df5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:31.2051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3b8S2iuQa+c7qvYc6WNOTVeLdfHI/9rWg6286x9KFF2JuWU8US3mCU040NnokGtmCZ7rbJeQ/RiiElafql+ODAQY0Sj6p9ESsePgq3ZqGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8685

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
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

