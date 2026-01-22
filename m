Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568A3F076C
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077411; cv=fail; b=kagYO8snonEMQ8vcdhNk+jqhJ1tIq0L8V6lyuPKPU7W4/UWtPo2flJHoClgrZkMvahdRtxLiW8nsFXmBU3G8My7eHlKTRHPWMZ+tv7uZD2RdjZcmQNz1sGkbWNIUOgUvgdS+wVFfjrbYJJif9DCiCjcJdpPXZbkEeTY0hmLO6ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077411; c=relaxed/simple;
	bh=jOCc8hdvM2RI6q+llpHBeqbf5NnJxUeI2F//liAuZ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d10G3iSi7k5+Ov/eF6xdtWDUKkyNO2/LmfBDraNHW9HhvGBjMas0nmH79Hlg20NvbDIOkOjFX50zUvTUgv6X3Iz+I0qT3+RZSOH6ZPY6uMlNUFw+XdDmSbwzq0N1JSX2Lf1k7jSFskCMZmm28GtKpJ0KHY2CuyVAMMq9KMJslsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kzFOo8q1; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kzFOo8q1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbMsgEvda7IaLLGTMdZQDSdldfCp5QvgqFXbakTcSiEkfQY8uHMQeuDJhuwb7FheteXiTvbyyCedE3ispIfCMg/qnFNzPgazenSVflcCqH2TPV8RltA/Ck6G4p8Dfwdg5c0CryF/SQhhzRYl+vPPUBVL4yzFQ6/W5JgH+1eCwofgjmCqUVzxcwK+894+Yhg7j5MjojA598ALLOEiKxDL/Kp08jZirBD2EaSUJM+rHB8LlhSa1Acw5CpuzvyU/h90jo8V7na1BFpDGnemVTNHKCU8YSaf8alMilRscbl1/RcSSUfISZ4h0owNtBx77rAB9SY/VKq9N8KJ7coCMx5TSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtrtFvci6WP+JWacAh3BxRjDuRdBJyVwFTRL5MNLLTQ=;
 b=M1krBQYUU65cca+NY+afYVDg3h41qjRbEr53LupViJ4tp6S4kYRcOZcl9WtwVwnR9vy1a5gtZc/wa0OpXSdErt6utRKBtkw3V9t6qHJ+Pu8FIIgrwwmuR0lYd69MRIXvLh+hp5CQa4YoaDmpqgz4pQBZhZ9Wy09htRBsShEI1spjbAY1Hh2S2BvSVfftAbtJedmiBMLU4S2E7iJDtFnSOZd2eXc+EOiMFhO0K+OysB0TEBpT6chDTB5OIb4GTRi9sVqL9ztV3D34cChbOBsZdi+B9ak/4XMQpxtAstAsXOlxUELz9pNOhRft85ww58WR5Dp2fo+lmaPILKnc8Uvz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtrtFvci6WP+JWacAh3BxRjDuRdBJyVwFTRL5MNLLTQ=;
 b=kzFOo8q1hMhpsRQp7VlO5VmYqJf9Wh1bt8fTuE9D/ZLT8Ink4reJ2aZIxEC7fpLxCCb1fjO8m1aoMhQhtlAfe2XWO6DKI2ztk+0eqww/1cXQFKpYF2Nv+Ytz5PN32PxuccL1Gf2Q7cqaqCPBD5tH/zk2G7D0oeVoFNp1KXd4sYD4i/4Osf+fbGl/bMrzvkM1uka0dRevLF8DwGK7jStP3z1v1tw+eeGZmJPddVoQvZdJVQRmf5yMJrJ+XKQDOS62hHp69tT+xyKoou9B27+UdmFAPg23a3ZMrdU0sKFOOhT6KBoSO0uhktly1vxPrusGRa2+mwUxMMYmzXeiX/dSlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 05/12] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Thu, 22 Jan 2026 11:22:57 +0100
Message-ID: <20260122102304.421957-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122102304.421957-1-tobias.schaffner@siemens.com>
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e149a0-29ec-4429-810b-08de59a04072
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KM3Lf5mdjcAv057McsZaLb3OH90volOkq4JNHcI6UYgKIBrEp+Umqur9zc/M?=
 =?us-ascii?Q?A8EbLWm8yIX80QjI6gX8X8kNSmNWFcnctxaCnrRFjkIkiEBswDqJMkPiIxys?=
 =?us-ascii?Q?jF4BAkUgnmcGplFqRJN/8WBSLoV+c34sQ7+QhKK/uCyTr5xHW7zjVyQionJM?=
 =?us-ascii?Q?4yp6/iEx6EWVxyCw4pFNLowmQwrv2JtXUN1f3mrbJGh+T7fKRmQ58keZJmL0?=
 =?us-ascii?Q?R3cU8dhglS/cr8zOnro1yTGVGbQlYs22a6bPWBWJ5aWi6DZbZvs+e2GHHoUn?=
 =?us-ascii?Q?g3kObTUnHigLXKryeXoW1i//o0xLXIY4gAi7+WkwpjSUOQFdSWmsY4fC29Jk?=
 =?us-ascii?Q?ol0trE0+pQzKk61U5mXBHjoF4u2LtwxjA65nmaGFRXF3skFBtwa3DwMJLNAc?=
 =?us-ascii?Q?9ZcCgfC3u7sOmEpk+WGMI/fRoKXMgw0ftX0W5inPucr+ADpQtrFs/LsYIxjd?=
 =?us-ascii?Q?J20M1GO+Em8c29N/eDlMPiEmPwr8/d2pn7vx1ZOqiVVqnT6gJtSp0ZY7CXNa?=
 =?us-ascii?Q?g8HXP6mcS60Ys+f1k+GMwsIrk2wXcxhkwYRCbrltJr2rK8DHcNAfo/zR/Fhc?=
 =?us-ascii?Q?FVDoeWVcZzHYweq6MA+0gEG9yu0T/QKTnivFB9FaKbsAA8b+lmJU7bhzz7g8?=
 =?us-ascii?Q?LL43Q6c2D+mdFwcBvHIy1Lie7tudTOGD3l7bVyYhctk+NyRlaM5vMXLExd1/?=
 =?us-ascii?Q?EKkEXqv54GxzydNBiHaDvGhIUKZJxr1b+EPvhNjIHV310VO4Ch9dYzDyACod?=
 =?us-ascii?Q?SL+UYDHGCK4bzUICvA/QH0D7FgHczePGcAIn9kpFzft9WXQlBIlL3fQAsgUz?=
 =?us-ascii?Q?2ju8JDENZmpMGtsYElQcNiJzp3cLhe+wfxI99zV1J6XUb66VFiln13BmwN+n?=
 =?us-ascii?Q?ZSPTsxm9+v0e9G9GH/Njp7ZklOCyAMlAIY+vOkTJ3SIZxwveRZdTBPsMrz+W?=
 =?us-ascii?Q?9o0AoDBXsY8OWjnxWDeKbjThPRcMn8L2guiN2HmLbyNCvP5vf7Zvk2CEMoiy?=
 =?us-ascii?Q?TwnsK4PpXlF9DcJrI+o7Zu6h/73b1gk+SgoL8c4BJeG0RhOv4XWuDWQ7qDG6?=
 =?us-ascii?Q?UItrF1UURyrh16DqRjzzGSO1WYSsI+uu3fpelBJKatVxYZGOLDhyJ+T1YhBE?=
 =?us-ascii?Q?yHQadg8Jv2TaNVyUCNdXyMpGhgxKYBa8qtUaLDFWubskbixEA4WIqHwRlAyS?=
 =?us-ascii?Q?Xok6MkZIEQeBiRlJtys3if87ZwwehBV4+l1hHMnXxD4j3C0TewY4qNQQ7v4V?=
 =?us-ascii?Q?Di1dTooPbQFn6fJcYb0qRJrxEI7eB/GfQAfw+7PwDcnKHYgCukWyo5pm5rBP?=
 =?us-ascii?Q?cmMPdNM9dNEybem6zxmgyDmysep3q+MB3xEfSHsdR7odd/9KU/gHsbjkM/3v?=
 =?us-ascii?Q?zKDhvMB6vgo9L72O64xaBqG1U+GwqWTLOyvb5tcGD98SK+Aqu7bfOnH7tXPN?=
 =?us-ascii?Q?26wyTv895PuGmzM7fd4GXQI6+kWL96Lj4IpsWM8sIQr7RFdmWWqNVsVk+OD1?=
 =?us-ascii?Q?pQI454JIyPwWVchXSKOJG8sErefMaVzSnMEEbKtXArYlcMqTWvpXeKxFf00D?=
 =?us-ascii?Q?/d892Jew4c5TLHBlm3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7zLeF8HhP38Mi18A2+XlQu1JFTV8O28vebMR3arvZdAWg2RsOEvusRqT3yWS?=
 =?us-ascii?Q?uH04T4zwKdYb1fNEpRq65CHOWxTeF4G0ciFRdSDqgFtiQ082mT39ambJibBH?=
 =?us-ascii?Q?g+YXfaJql/0WWkgIWBE2AeRzq6yNWcbVA7+JUb7Kf5gvHn6X9rTwyLZc3R8O?=
 =?us-ascii?Q?lbCW17ppswqLRppX0BbEJJlDV9w9+fVaCNPNDsFbOPts4E/ehuDsRzPpQ3QK?=
 =?us-ascii?Q?S5gluGp1qYpjAUuiWJDgga+C73WHIKi/TP+iXJ491Hq2F+lm4I/6DAaxYhGq?=
 =?us-ascii?Q?18kl74WNhrxOfqXsCyvWLYqlzFNSDd5lrKtjKsdpqySOyZ44XFgGRArWRyl/?=
 =?us-ascii?Q?6QIVzm19RRyrlDoyBfaw7HVxZcfnnyfj760F4bOr/LBBQx/AJ8vFi9CjTQfQ?=
 =?us-ascii?Q?Y+jrdC3GCwxumf5nRfAs+UbgPg2RLWbwQslfa8/j9KhTHVMCKKO4fvqdOIyH?=
 =?us-ascii?Q?n3/ipiQn6XvIFse0lMWhFXpFAMN5rrjGinJ9PcTJXBIFW4HCk3tknYdj8EID?=
 =?us-ascii?Q?j32bac5HSHWgfBGPUtQuzqv8+F4F9Cllwa3hAw9VhBo4xMS+XcgHF2EZs+9K?=
 =?us-ascii?Q?si26uligjvvxEFJPhsqzODHj9dkz/3DtSQyuIb0GttNAdQFo0VPVZ4sS2m1l?=
 =?us-ascii?Q?K2bh+WN0HaJPLXuHplZWlKoPe9UN27z5YnB3e2e6L+ofbroxj/WeZfVZi8hH?=
 =?us-ascii?Q?LxoB2dwnllluRuTPJJIlW5ZBpWW723aHvwJI3/n3jAR2uI7PqLsECDw6udei?=
 =?us-ascii?Q?O5rF+TAAXHHTmOqW3PIQH2BjeE7IIhdxiRGcNyuKY3PtPrz4ZSF+muDeNyrn?=
 =?us-ascii?Q?6lWML2kkRhmxU/c7R7+/tARvkbCDquL8fgC3L8h99E/YsaKSudAsdoyltfwB?=
 =?us-ascii?Q?iOjZUiPuXwLAAes1JEVk7pODg5/YdwL+T2RtTkKLJKq6CLvEWDXsoK3Knobr?=
 =?us-ascii?Q?yOP+wXuT/bVodQt+HDVAKWAH9Z2V4fTg1SIIdL2XcZGFOa4OMTl1Hupko6PT?=
 =?us-ascii?Q?/e2/4Y8k0Dz2GZvBvRN3WWmTGnkobmj+hrKEF/ALHBYzWI3/7HqjFRXP2v8u?=
 =?us-ascii?Q?EjTw1H4Lp+T84levaTzXVCo//ylU0p13Edrfgu3HqtUew+rAHjvD3jd9BHXI?=
 =?us-ascii?Q?WdWv8FnzqFqHudaWla74mWe13c/iMyeTPAWsRF4pL2rjKVNw4iDzrlQtTr8b?=
 =?us-ascii?Q?cVqqWzK1tc3tYGJV6/05HSqR1R+Ybytyx+1B3CK1BrLkbW8t3607khzGHBGh?=
 =?us-ascii?Q?NMb+asy/l+sd03mbYu1RWkSLJTL82ySbw4mUOV+W1S7TSykF8f6Q5J4ozvP5?=
 =?us-ascii?Q?q9YG86W7EiXtqMaXuMxji2vfSM66Kzheq0r3SlVNtSm+affa94JWu4kPkFAi?=
 =?us-ascii?Q?rV3DcciVOddrKVj/BpfwdbOS/OsCL6QfgepfgWt2taXgfb71nG6FVoTIQUKS?=
 =?us-ascii?Q?55MbmVg1WReOR6cxdZlCfv02vvRLuZQEJJZ9SyK17hZ/fjiuJsmj5JNW7Mz5?=
 =?us-ascii?Q?8wvWjPPxokiBSKNeX3hHADEVm6+aQ3qpsmq/OlmRuMs7+T9omxqn32sYJyxQ?=
 =?us-ascii?Q?ruIijDe0HZKUkxE9jJdSJ8dq8jvdej0aCcSouGy4unFPgwsJvO9oOFu8nmRl?=
 =?us-ascii?Q?sjJeTASuaJxgGq7+dACfby9DCoai57p0jMVzo+U01GGO9VbnpmlCkdneATBs?=
 =?us-ascii?Q?kXzjH1cNHB68IKrVzVB4Vs4X1OYiNCE3iiNZsfmgFbK32UzL3Hehu3bgNXFm?=
 =?us-ascii?Q?LIhyDIAxgVPOritummuzFV/RTP0CxeA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e149a0-29ec-4429-810b-08de59a04072
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:14.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlQjO8qglYzFYVm8r5oTrifXBQSN4ygb0MTMqIC9GRQtpy2V4Nm+GgX3VZ69ruFRscGPllpafs6mGyrtnZDn1BCUy7pLTJREblD+NUss+to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

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

