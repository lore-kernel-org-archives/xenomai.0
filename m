Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2090.outbound.protection.outlook.com [40.107.247.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CB276028
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115687; cv=fail; b=HlbNm+WANMRXNziHgk+PmA/pz/BqNJJ+E3RNGid9o6oWpqE62+PAS1yKoAmsU7rddh07f84ZnJCmQhftnzP51lnGeJ7/V8gXyX9+zrk2b8okXG21oDmr42vi4ETl34zu7dcWqoP+depMGPYJS0BiJmJvwQ/ufTCNhpXW8wb+dXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115687; c=relaxed/simple;
	bh=Z2VvDd2efY4JTZw3Z5oAKrVDuJD8y5lu13SR9PWV/dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YrXEPHYdwna5v162HTJH/RULdDZwMN6DEYgiFr6dVegqyohztAlBZit+fT2cF037lxQeoARkimcV8tLQ6EeruS+lg4x1k+0seSf0T1rVcc43Qk4PSrOg0VuzozAdKOA6SgvOwSYd2GQ3KAOUu7Est4+Xl1AiHiVo0oUGKzc54Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=tdBrgUv2; arc=fail smtp.client-ip=40.107.247.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="tdBrgUv2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrSDyEf3obXvJewtpu7Mfn9mGXRBOxBfPu4+j1/Tp9wN7o3hIlEKqw1RS9mQ2C/m6oMg77YQPTB5CO9grfkAe71N2M5cjD0KqB4P296fjN2oPBJjQN44xB0ORZLnz9E/GrhjS7QYbOhZ0jPibaw64L4CqcgwegV+9Z0AD+ktQy2UcHS82A+p4cMashQWfWUkh2APEjYzKRaVPh/RGM2hLFyWe5BfkzB/m/5nNGALPmisOPZVZ1EkR9p7p4TTrV5l1S6dlwzz9Vf58OPpAznJOecRIOeDTKD4CyKdwI8j6NqiD2lAQZtKNIks1KhmxGE3uUdMa4JQmWFcSmFXmhSgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cApuOnjvY03wLYgIaEkFDoBdjn2D8ULp/FjcB2s2E+k=;
 b=f9aW0LI72JtdJ8PBgCEWuK1XyOF8IIVj/8zSAYr1n3H97MADTxsFrLnZ4jBL9KXoSJbIESurCqptemkyUnGBCQQaLsUPJzdVGmC+7ZTaK/f3Md+d6fUGHMFlZRDALf2LdL3Ux76hUd+h9hbRL5KZiq0hA+Yx7Pu5uFbvjOq8H/BXyBLtCNcni9XMuLmo3ClibBs7lV3qV6niI9VdMTuSHTFxgNTqGUD9hjrFoZpMbb5rreRz9ZAhWm0PgDyYatblCYwqkWdrK/r9Vng/YOP47hxPBLxqzFMaDkxaDgf8qf5WeJ/9ZHDYeYKUarPeilOiHT4HMQvATqGZJr4IY3aiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cApuOnjvY03wLYgIaEkFDoBdjn2D8ULp/FjcB2s2E+k=;
 b=tdBrgUv2EDQGd5Bbjpf5OHf4xE+C4cTxiqhgnW1HNM4Z/4mM+QjXHiJWFxZ448fePn4taIkWKsvdxPw+PA1nK/b31VkYeIvlDF5ZZNH8te8ActQXExFHuvND1t2p6/SuN1x5zosBoC+b2zS0cz6m4CyJVol9rP1PECb9Q5G7nfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by DU0PR08MB9026.eurprd08.prod.outlook.com (2603:10a6:10:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Tue, 8 Apr
 2025 12:34:38 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:34:38 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/5] arm: dovetail: Helper functions for signal frame setup and restore
Date: Tue,  8 Apr 2025 14:34:23 +0200
Message-ID: <20250408123423.627477-6-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|DU0PR08MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: b25c9848-a78c-4dd8-5eb8-08dd7699ba5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZTEdABZspUqh0ZGnmL2yH6iGzEOaw0Z2acfFKjTBmn9Wak/qSi6WHxthz9b+?=
 =?us-ascii?Q?ZU2P3O6gxJaUAsBo8Dm/UN73E/ZtCIGifIrccJmwyI7yKdmdWMqoPe6vl1XT?=
 =?us-ascii?Q?sDl2ATf5WFex42JG3tLG8sKxLu+H3QMC46086LqUAZgzeGt4O+5XPmeQTdl/?=
 =?us-ascii?Q?k8b1nElDr9RLgkYmFlWuyJD4qOaCkdZZlFrDp8EZ73XN9f0F7RixmFMIt2uO?=
 =?us-ascii?Q?m8g/Hmv2/Ft2lWcjII38BKlkMsSuGY9gVPmoBqso48y9coVrXm8N0RtU+p2t?=
 =?us-ascii?Q?ZOzVPHXhAHoJiaIJzrXGaLDWN79iH/NhbYpDMq8uBhoF2WJdUAX29IhOqGFB?=
 =?us-ascii?Q?juZzvQdVVXmenFGBGhyt5RvcO8P4WvdizGADqqwDyndR+cWpybQVJD+o63Z5?=
 =?us-ascii?Q?524GCo0J9BX8YbVJCwRKBGg1CW7fr7QFDg4Yn0jPiHDvbSuKpRTYRJVhf/uo?=
 =?us-ascii?Q?SdX2+SG7pprKdkk1GqFTxv3bm5VJZrCD/Bd2SDltF0TiZGEv9ifeta8Ojex3?=
 =?us-ascii?Q?WRrHNJg7I20t+ONmbSRySP7ZvNL9htqYjWsErgvyhSBgFkiCHR5StlCCQSXr?=
 =?us-ascii?Q?CO4Zysjurt4PQnkYD7ls4u9DlAtzHu12E94mLTpqAIEVlD239KhStUymF7ZW?=
 =?us-ascii?Q?fx0tkUjYif6t0A3JtHRETu7540rmoLWqRjOj1Stqr4NGJgloDGS9g4bUydhv?=
 =?us-ascii?Q?Asx7/e7efAISgCyNZ5OcqyWk2c51AZ3VxbGNGHs6V0nJJN0Bb7DSgBxdyWf8?=
 =?us-ascii?Q?l5vbEBA/WfbwLZ/d0NcMgwq5wO+U7g42YU8mL3P1WL01m6Bk9igAJJw+ouc/?=
 =?us-ascii?Q?F9360DXWXgcAyk3BjNfG3u/PPGVh2BGRb7QjcCBLHsqARkqgkxHAvuMdFs9U?=
 =?us-ascii?Q?qwA7qoAZs97mhHGVQgSf4SKjNJmlr0H6DVbGHMd2MUYgjhz+n8+0S2Z1o7ee?=
 =?us-ascii?Q?HefU5IY2Mdt+Hl1cf/Em50IOUPpUxyuOqMTRNBDDv7xBGEMBn+dOr+1WKiBr?=
 =?us-ascii?Q?POIdWfYQWo/7vjmbusGLyU7ADpM+Pd5S2tSZ3pKGL6fF1ujUO4xKJBY5kdG6?=
 =?us-ascii?Q?ezHjqKFDYZdFmnRSnnB6R3spsCY65x+Kk08u1wEmy9CCQfI2hdlA5alOHGy4?=
 =?us-ascii?Q?HIt7kWxa8xYcaii05WTXrUvYKUchmxXkdT64H9BrhW7P/Fm4rEOro4ivhBE0?=
 =?us-ascii?Q?j8or0//lnK8vSJWZ4x9U2b88Vs7jfjcK/LqzwtbT0GEPzWEiNvMTxub5xr62?=
 =?us-ascii?Q?ziNFHHxVdp7OmN+HwFgXAWNyT/pfjY3GgKXGCk/KseS4wnIsXBQzdkeH4uIh?=
 =?us-ascii?Q?Azh+kj5GK4ycfkSIHUxPk+Z73/NlspmLPMHHhiM/p6NqGrJKCDoOyTZ3d0pW?=
 =?us-ascii?Q?22s2ul5JiEAyfs08CbeHSlJxGQjg8WdJaAyDXQbCrvJR+LkYdt9cw1CldZOP?=
 =?us-ascii?Q?D3e1UrX2is1mRt6NttSqROdAzqePkmcc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUr6iU3qxz6UQUaRAhnbdoeXnT7YMU0lnuFXSKYTGiZAlNeosm/2/qRltJju?=
 =?us-ascii?Q?IkIhOBHD6ucSmlewKtZceBD10NhQzdGLnNnY2aNnbg416GKnEfDsppQdg6LB?=
 =?us-ascii?Q?8dkBHkaYiIKnDVEYeamTCpohh9ggLaBpNB5FrkMNszAH1Hbzk59esuWqaZqj?=
 =?us-ascii?Q?C2sn37o7GiXdAlugyndcnNBJZR6aiqvDJgX2D1VFiTLRZ+KL2mDRbQXHV6Mj?=
 =?us-ascii?Q?vZq/HCv+jFkhTz8WiU+4Viady8viGK2w74LCqSQWdwdepahcggTDQ166HHfZ?=
 =?us-ascii?Q?q/Caf/hB+XcBJWlzlg9V4g3t4jT3J3LZKNsA38v3DUYVMotw+Ws/Z8ulaV/l?=
 =?us-ascii?Q?S7ixJaIxMeOk5cLHlpdBZ2O8TG698lKK+QtniuhGBcF8gVleDu2ci6kQJtod?=
 =?us-ascii?Q?ykJQ6MDFsxZ13FBSv1KedB6s4kOYt+003X8vO6+PaznXb6fLxB9T/pLN9fyJ?=
 =?us-ascii?Q?wngP85+cQ7+Q6/N8TIIoiG+mTe/AB4VFl+08cgXSmLBXk3u8T/o/4P71Qi2a?=
 =?us-ascii?Q?EuDnHZVbb7Y12ZNAKvk4VlBQ39hKXUUOZscA/xsfTnBiM1ZF2rnpppI0iXf7?=
 =?us-ascii?Q?VJRC+2ZbdsntuwtHVCb6nXv5f3cJgFvV3R/2MY/JQRPaUI8hTmqef//lXzhp?=
 =?us-ascii?Q?ckUZlNw17hF+pfGG/bB4MyDicff0H6TT9SPcG8or/UUJ7ln9JizTUK+ywMsl?=
 =?us-ascii?Q?Wb3lkYiEhJ3Oo/rI/t6Tv5xFy716G61kVBQWQLdTZTAtkHROCCNyOJHb547V?=
 =?us-ascii?Q?PUVzAtJYILdhv35F6qddt4c8hlkBqpzwzswVOpGvzPKv/vn1MPM7EcX+ihq4?=
 =?us-ascii?Q?ewYhnrYaDMfFfv17IH/QDI7rbveCzWH1eDd4EO0ZqSUXADK44wjukrvDuCdy?=
 =?us-ascii?Q?hDKAIBgkGjYWiUykQVky8DJxPRWo9TK0HQXbxAP8csCUejNnFrCEquBRb3p7?=
 =?us-ascii?Q?pxOntmPBOyy+KpvPwvD9PIN6zDYYtkdZLpNQoysf8g9vDS++VgwaHxxt6GI4?=
 =?us-ascii?Q?Qp3Es+e1LnsRi9vfPfhDwvOBHrITMmvDvSMlRSH5/hFi9TwX2a6noD7NqKyf?=
 =?us-ascii?Q?IBMQon8C1X3lksN7JfCuJSSfPyi53CGbRaEka/cfRNQMasA7EYJy3cJzrG1a?=
 =?us-ascii?Q?YdfnWR2vqJ6qje10M5aaW9Bf1ZDGbVBxikTJa+E5lEe3Iuv3fmnq0FmQAlwd?=
 =?us-ascii?Q?ngw3dJboYknUuaAkX7GXT6PABtS5r/8B5MsXs1fdlD6nkt0va5P0mN0DanC7?=
 =?us-ascii?Q?Q8lDYuyAw/dQvrPmGsWH9iWGDseqpCShlhGleOlhmJoj5b88p6o2nKlILLzz?=
 =?us-ascii?Q?9ndXONSFNATMtiMpvB59Mfe78Ual1s9LfncBgrEZoO0Fs9GDvmhO84+9WVga?=
 =?us-ascii?Q?DlmEx8ArCX4hDCMFSuycNT8x435pzVRMEpo5GOMCvE8jJ2w1oMezNd71pT7z?=
 =?us-ascii?Q?t1EzaTHtQMLCPflBaCDUb+oF2tuCVCgqAKos0LbIzFW1mkH8+6qQKC+6RqkW?=
 =?us-ascii?Q?rZ68m/nQQr0mtdbQzYCReN/MdXGWKRnQwv8iCIUdWAvHfHI2tKTc4Jily6C1?=
 =?us-ascii?Q?sAA/KibGTONT3oH01ucy4psXZ3MgY8vrrdupb0psUTGtzgloH3L7DJZOdwDh?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: b25c9848-a78c-4dd8-5eb8-08dd7699ba5e
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:34:38.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ip6V0X4XtYgL5BPdrBLMv4R79ArfyC3uabqqFg1o0NdRd24UM2Wn2rapmxu0vXUuTv+cf/0srBEXWvzEUnUQ4VwTvg2GH6iK/SYbBguU5Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9026

From: Richard Weinberger <richard@nod.at>

This introduces an interface for handling signal frame setup and restoration,
enabling realtime aware signal support within Xenomai. The implementation uses
existing Linux signal setup functions to avoid code duplication.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm/kernel/signal.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 2631632090c0..27fcbf22336c 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -497,6 +497,56 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 	return err;
 }
 
+#ifdef CONFIG_DOVETAIL
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *oldset = sigmask_to_save();
+	int ret;
+
+	pagefault_disable();
+
+	ret = setup_rt_frame(ksig, oldset, regs);
+	ret |= !valid_user_regs(regs);
+
+	pagefault_enable();
+
+	return ret;
+}
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame;
+	int ret = -EFAULT;
+	int sig;
+
+	if (regs->ARM_sp & 7) {
+		goto out;
+	}
+
+	frame = (struct rt_sigframe __user *)regs->ARM_sp;
+
+	pagefault_disable();
+
+	if (!access_ok(frame, sizeof (*frame))) {
+		goto out_pfe;
+	}
+
+	if (restore_sigframe(regs, &frame->sig)) {
+		goto out_pfe;
+	}
+
+	if (copy_from_user(&sig, &frame->info.si_signo, sizeof(sig)))
+		goto out_pfe;
+
+	ret = sig;
+
+out_pfe:
+	pagefault_enable();
+out:
+	return ret;
+}
+#endif
+
 /*
  * OK, we're invoking a handler
  */	
-- 
2.48.1

