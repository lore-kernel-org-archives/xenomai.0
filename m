Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020101.outbound.protection.outlook.com [52.101.84.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA6391517
	for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.101
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114703; cv=fail; b=UNCDgRO9k8ZZDhCLsKNNNFVEYSgky+2K+NXdfy0jF1Ia8lLsRdPoPmmr6+ikv+L2dJYFCUZXDIP4FdmCVR8l5ZUELv4mtx6HGy+v5MR0mnTkhg36tGaIiZwJq5L7MIxoz8OVmTg7JuMkeMuimZnYuxyUDk+bydZcXIwqn0DVAOg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114703; c=relaxed/simple;
	bh=bNyL2HKlqfgouAAjtELK5Q4aAw2uLEjCqslcfff02Y4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SRljHqqjrOaB34VId8JHZvE92y8jydWD0CkJZwC/XOyrQ/suinbinqkyuYnrnlqUBMa6eIKJ/ZHtXfxFg1HVgiHsQM9I5bf8HT9x1G6z3aGyMjNLZDntmipk55BhqQQqTaPSrly62PMB/f7NmjyD/RbWQBLnnFkrwswiy30XU2g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecler.com; spf=pass smtp.mailfrom=ecler.com; dkim=pass (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b=ausMxRbK; dkim=fail (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b=FRS13U6p reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b="ausMxRbK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b="FRS13U6p"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EK+I3w62h+KMxeI7rqfRLCeG4txyvE8Ntt3wxp2GBGSwFA/ysIgzfY//Ths88JvQJkHG2ZQ5S+LbsjENJXXjkL+EYbO7rqBNZToUS8+/+7funQ5ZQFvasP7FDzzX0+hz94wJupmkZBMP7IpU+hseY4G85yQyXnZXy18X4J7CbSsxN2PlnMNCH0KNbQr9AVQCmCIBi3FTs39Rsg4LgeCRV+8u+b4N7CsccD4Wx0dmbJfz40Zg9Ug1vZeqzgQKH+1SVMxAnywBxgoA/uC1nZZ9ckDTNhl9rrV88SqmrxqX0zS75mScLMrThS1h6i/1wG1nJNFAru+j0eTgKXgQClStkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvvboWcwyOE8f3oL4uUYd3+xgJ+95fZxmP4Uxlnk/z4=;
 b=Us43meN8XJB2lpq/R7M1/yYVAsS/b7gYOGamMWXsTtAh6kIoysvreaBMKo75MRTfg22b9SIPCPEamf5nKOzuUBcVxtPE4+pnjeYgXnlFYvfj9GPJ+/BayJnL9+mbF6m0lEzmLSM0AcAGLURSxHlV/jvBD8wfiX9JVjInOliRHCuJb3Id6sLyIHvzijE3O0coPlBM6fxDk9unMOMFc6HoGFLPjv8nrkMEuhh1AkLarVx69Mt4s1S2IdJOXyJS04sI4FyFxkf0ewCs3c6zUCFZAWI1YCMUUxH0ihNaVDDu43lYpXy7BEGdPNDkKyqJdI6VeDtln+NMO+5uPIWOoTBLdw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.40.229.156) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=ecler.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=ecler.com; dkim=pass (signature was verified) header.d=ecler.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=ecler.com]
 dkim=[1,1,header.d=ecler.com] dmarc=[1,1,header.from=ecler.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvvboWcwyOE8f3oL4uUYd3+xgJ+95fZxmP4Uxlnk/z4=;
 b=ausMxRbKUUwN8dtI0oykZapM9ckRz94nvcppBy5j+4vo0rc8leViwRScGbIvIgCBcHBnhnf7wpOV9mQBuG52duhtROuWNOonQCsXpwTNEmIk/rBGJOWQJmAHjYGI7qkEdYMq53/IO5ilvKqQ0BMCPRyP/tc4kHmtGimOWS3Xe7mnl+PG1Xl8F+YnLIslIWUw2AZ5ukw42xVwYhU1Rsh44UQOzrkxyM1Pb4w6R0iC0Fv95aS13APsLxnLqpsu/qAZ0R9vveMSuxESdi+rw5+RnI/UqaNKOA0tDsLpdmhgUiGz/NDMJSD+Cad3JS6Nb3+rGFPCE+NhdbUQQsIJkCGVoQ==
Received: from DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) by AM0PR10MB3569.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:15a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 10:58:16 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::c8) by DUZPR01CA0264.outlook.office365.com
 (2603:10a6:10:4b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 10:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.40.229.156) smtp.mailfrom=ecler.com; dkim=pass (signature was verified)
 header.d=ecler.com;dmarc=pass action=none header.from=ecler.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 ecler.com discourages use of 104.40.229.156 as permitted sender)
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 25 Apr 2026 10:58:15 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.49) by
	 eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
	 ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Sat, 25 Apr 2026 10:58:16
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 5383203
X-ExclaimerImprintLatency: 984011
X-ExclaimerImprintAction: 566e214006b44b08b1791aaf10a631a7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfnTSzCL61GLuJjA+I7vRui59ETAhUAjiZtj5RJUkwgXDuzrPQdy0fCuN/1gTRRDm54791qt64Ur87nuZmZxVazyFMFlHKvC746QlthB46qAl7Vcj/tZugffkNhIiAVbggQAq/m+uP+q0SASK056A6jqk/cVK/3R7co/ScAjYnXAGnukgsmhDJZ+RLzz83WudItuotQM4z8ISOrgWKSSC6dTPXFDQs0Z72mpMP7oIlDYDizxk1YUbJI1WLABfQ+X2gZF+keZ7A9U3GZI2SkzP9xKGT+3KuXDPtd+NQ4B1GSUKVbrpICQ2CcD1/PYA5b7Js+xHTj5My2xxUZowDSebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhYYBchkJUPJefJ1I+MW7A/n0pM74Gn/PH2jrP9iZtI=;
 b=Zzzh+CFcVQlchvV2HoHbmI318tL0MAujDEIK2fGPO3St9AjY+X8D8nwmxUO0nR82h0GPBOXtmwxKYWo4AY8TTxmePn5lGRHdRgHasQvS22mY/eGeg1l8/8jCEEK/xrfTsXyjz0vy4pHmI7RbJgVs02xz7DlR5syhWawEVnGrQDcINMoinACZ8JayO56sdMz50xCPs/xfgofmGDoiIiVnctqGtM2nIARm9u+pHrHGAt2CFS7XFvqqGFBaqGtqWimulQCq+adkIXDfK+qX+3hHqZpYyMPnNnzNsSZJ2wxBqx352QPPEa4YrCz6KF6V2ggA3XnLshesUUs+cHz4c+95Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ecler.com; dmarc=pass action=none header.from=ecler.com;
 dkim=pass header.d=ecler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhYYBchkJUPJefJ1I+MW7A/n0pM74Gn/PH2jrP9iZtI=;
 b=FRS13U6p2oMWeWHzZ5tmmUlihBb5jc9RSb0sM8al2i3CUmzWUcipCOestyHh7gKe3YkYCNa8RQ58O9U0xZJzbj17UGU1mcxQY6bL0qO4GYIN2kZ4bbqvdo+QRCmm7ZzGzqIHgAkBLgP3FLfudtkPZ6In2zcQSQ3NtK75Wilmt0+KHzxALEgq5g47WW70zrpwlM1QKlZap1v/70jIWoby53KDX7s0JGV1m4LJFt90plw2pXMFEO7n3aFR+uV0+RAESmbW7C7QXGln/NXMPDiwKe5PE8DBEX5Xxf8heNKL3fIeu5v8bhOhweCiomozGJzO6MIS4YKYRoMzTBf/+RDlGg==
Received: from AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:629::22)
 by DB5PR10MB7749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Sat, 25 Apr
 2026 10:58:13 +0000
Received: from AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c03:58fb:66f4:7121]) by AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c03:58fb:66f4:7121%5]) with mapi id 15.20.9846.016; Sat, 25 Apr 2026
 10:58:13 +0000
From: Jesus Villena <j.villena@ecler.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [EVL] element-visibility BROKEN
Thread-Topic: [EVL] element-visibility BROKEN
Thread-Index: AdzT0P3ZJTrKIN13RYmROlDmWMJ4BAAKmV66ACmEToA=
Date: Sat, 25 Apr 2026 10:58:13 +0000
Message-ID:
 <AS8PR10MB7731A9654F34FD23F029A58DF9282@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
References:
 <AS8PR10MB7731181CFB7CA13EB3A8C4F7F92B2@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
 <87fr4kqu4b.fsf@xenomai.org>
In-Reply-To: <87fr4kqu4b.fsf@xenomai.org>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ecler.com;
x-ms-traffictypediagnostic:
	AS8PR10MB7731:EE_|DB5PR10MB7749:EE_|DU2PEPF00028D10:EE_|AM0PR10MB3569:EE_
X-MS-Office365-Filtering-Correlation-Id: 8866d2b8-adab-4fbf-4611-08dea2b98d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|38070700021|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 fSAeAGyI2d+sK5Z50L8DQa5R26YRAzPUbWg1mVWKqkeBkiaEiZWRCf3ZAV9rbG8p7yKurQYhI8mPesqTF0XAV982gfHdbs/raKCJ9jNgXgYXEYspa553oYQvXGxl0+jBJuvumdzvQEsRF2DH4CfjXXBUabH/8eCZHThdDj2oW7+jOBO0vbW9ClwXuNxAjsFvLvy77jhR1uUIJTXpIXHZfR1ORBusc90FMQVl71QN+ediZaRsRCJWohv45G6KuSj6OHndnkFuYiNYQPkb3l4xKiSNbijjW1BHBsxgVK4ShRJLrMTbGTyKqGLs78V9YCwrSQNJfK09bM8rNuCtmgBvgw58HmBC82QhHsV2BcrMrC7lHG7bKYyNEjWc4GL1iyaCNzHSX/xoPUzm8+Q0cyX6HbPLxZyrZ+pwXGMW8V26MZkB+o4dYEhbX4EiKKy6yfj1hlnxyYNKqh/smM2lhpyQaYN/5IIHKFIyg3jxZXWCwm4mUSBCVAhkwRlhjP/S2V9Q/nAcalh9+lDlFsdRtDDntTsLoeEyd7y2L4hq3HJLj+pMiPxXCkYzHzlUCWChRJ37Gfe1OOAs70IihU+ieRwKpzjo4hFdhZvgqDv27GdOocgI287WNFsNqYc2SD88iI2qBY+WQjYic+V+N6Noo1rVE8Iu2VX8O2byh9GR5FOBHK8CRqZuyaiMMcXPo0c67s4vU1ePymqnMX7bZpY/aL+KTnUT0Ln+ntVqnnhwUSOMnRM34E7Jg08pDFDlQUiA6tqjqeUorXpqaGQbYYsC9qy6EmpSyvMbAs1xbsTgAg9TMNI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 ZKALdRF1kaQDKLELfNZndmRB6RBSpHsGO2M5BhU6gUG26szXP9fkTxXg7zFTH25oaQIb7fOE5XnW+xeQUsapwzEg83EOsqud6kTPhjnTlRqBRP59ABvyLcRIabWm4GBvCX/XVAC0SJIt4F/oYZIXDzJOmVuJRmHE+m57ahU2wc6TpwaFzfYxqxjA7QVo2+OM3xkfjPJxNikc1Ylwqmlpm9xi+TnYnhqFLWG1JZFq6TgPN7A5RijO6F5YEKbJRY7VD+YlgNWBJqfEIS/zm4IHIHhc2e+iW0D4Cpjn9c5OUJ08jJ1Lpkl39cEqrusgOnegWpU5qx8qcAlayQtzf9d9ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7749
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0fdf02cb-8fca-4a60-d729-08dea2b98c0b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|36860700016|376014|14060799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dSdR2e88oItc2tIgJt5739bSeUW69L3N/HVPGc+6ZPUfPkzsX7I1fs5t/JBFEo9ZpB/cGSLRwY/N0VwIfAsI48G0Von17/HvQ4Q76mCBRZe9hdSEWQq57Wl14KfcVCctFvBhpN0gfm3JBBxxGx1yUE5SA7G1wR0uO1isV7/4GUPFoHIQoni6SLqQTrTFeWoSJI/iqp8TUeknkSkVHhY5FVnghGLUac6Zx9tBKrelMvRhJK9OIfOiwb8djonf1b7k0N5dWNbYVgOD7XWu6Cg9LaZ++3HSfle/OSrrYbwkpcyNcmwmj3o5H5+XPGODC5cKzKAOUvTl9uKy0PFQVziAkgY9lUod/X8yzfoLrGodQJbX9st2A/fS954ZGO78AUmCie7AU+paOxglsKt15Ov3JIB/CO66UxD3teiPUk9QYDHyZaYF3axAc4XufcdOjxOigNKgVxgG+g34W4vDfuIvGGdAAZkWCCLuCixhH+7ptcnSxnv1UKwVqgSVtnTyFFd4RM8B6comwqkvc0Be+RkNfnxELrmw27jfQfq4kFO6xyhxn/CKt2NoN6p3iMWOF0WT7eqf5YVSBfqg+XDH6JBVv6N824DxXxBLfIZTeUWw3/BxSB9HcjuFshbIaU788PDWOmBd31igIHikM/iiQ++mROa6lba54T5FU3r2Vk99wNoFI6zn5yuLlJ9nCnAqMkE9MzyUaGCdKb8C4rensyVV9mPLA4KcBZQbBLXMkfjPCQUQBwnMqYSgjix5qym8dIAjdF0jY1N3rqj9aghQvlz8BA==
X-Forefront-Antispam-Report:
	CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(36860700016)(376014)(14060799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kGLm3bkJbCqN7RH/iwuAPPrN0xh7w1jgbuhzazjRb35QprBNsDR6E/LCeJosIjptmdlppatBWMsCE/8Os2oA/7AwypXBwKSYOaDv6lsCnKCpmQhqF/UjWzRueRRyWtbycyDL/5x19/fRiObRXCpFho9HjDd2E/eJTgX/O9On9aG001I8WEiODy3oEuGR0Hu5r0Uj4iPDUEe2+UOMWuZbkJObqOjEdygaACzAfGLtwxmcoSscpSnSv3glmOsroey4fxiPL11PIBHTIyGq7UCEtugYUdLPCrujVC0wvrzScYdU0xeuH6gByk84WSNFoA3onprFB7QRrgp6IDsBQfsXMzbKty0A2T4PHS2NmZdkxB0RWDoVWIuUFvVjAWMX99us6oxrqtVhuT6vZmaeyK22HhpFJeU+xF8BUh5Q6obH6mFkgSfRWZjHSYfL3WfsW/20
X-OriginatorOrg: ecler.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 10:58:15.9792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8866d2b8-adab-4fbf-4611-08dea2b98d9a
X-MS-Exchange-CrossTenant-Id: 6f9193a3-7ddb-4a6c-9664-df2759e0e5ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6f9193a3-7ddb-4a6c-9664-df2759e0e5ac;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3569

Sorry Philippe, but I have applied the commit #3ddfd3f and I still get diff=
erent errors with several consecutive executions of "evl test element-visib=
ility":

/ # evl test element-visibility
element-visibility: OK
/ # evl test element-visibility
../libevl-r56/tests/element-visibility.c:89: FAILED: evl_create_observable(=
(0 << 16), "%s", name) (=3DNo such file or directory)
** element-visibility: BROKEN
/ # evl test element-visibility
element-visibility: OK
/ # evl test element-visibility
element-visibility: OK
../libevl-r56/tests/element-visibility.c:50: FAILED: evl_create_sem(&sem, (=
-1), 0, (0 << 16), "%s", name) (=3DNo such file or directory)
** element-visibility: BROKEN
/ # evl test element-visibility
element-visibility: OK
/ # evl test element-visibility
element-visibility: OK
/ # evl test element-visibility
../libevl-r56/tests/element-visibility.c:89: FAILED: evl_create_observable(=
(0 << 16), "%s", name) (=3DNo such file or directory)
** element-visibility: BROKEN

--
Jesus.

> -----Mensaje original-----
> De: Philippe Gerum <rpm@xenomai.org>
> Enviado el: viernes, 24 de abril de 2026 17:02
> Para: Jesus Villena <j.villena@ecler.com>
> CC: xenomai@lists.linux.dev
> Asunto: Re: [EVL] element-visibility BROKEN
>
> Jesus Villena <j.villena@ecler.com> writes:
>
> > Hello,
> >
> > Trying to validate the latest evl linux kernel version 6.12 on a RPI CM=
4 based
> board (the v6.12.78-cip19-evl3-rebase) with the latest libevl revision (r=
56), I
> have found a test case with problems. Running the following command line:
> >
> >         evl test element-visibility
> >
> > The results are OK or BROKEN in an arbitrary way: sometimes it ends wit=
h
> OK:
> >
> >         element-visibility: OK
> >
> > other with FAILED:
> >
> >         ../libevl-r56/tests/element-visibility.c:60: FAILED:
> !element_is_public(path) (=3Dfalse)
> >         ** element-visibility: BROKEN
> >
> > Has someone discovered the cause of this wrong behavior?
>
> The test was wrong actually. Fixed in -next branch of libevl (commit #3dd=
fd3f).
>
> --
> Philippe.
Jesus Villena
Software Engineer
607198846       / 3025

[Ecler] <https://www.ecler.com>
Neec Audio Barcelona SL
Carrer dels Motors, 166-168
08038 Barcelona
ES
www.ecler.com <https://www.ecler.com/es/>

[Twitter] <https://twitter.com/eclerofficial> [Facebook]  <https://www.face=
book.com/ecler/> [LinkedIn]  <https://www.linkedin.com/company/ecler/> [You=
Tube]  <https://www.youtube.com/ECLER>    [Ecler Brochure ISE 2026]  <https=
://media.ecler.com/1768915806-ecler-brochure-ise-2026.pdf>
Your data processing is under the responsability of the company NEEC AUDIO =
BARCELONA, S.L. registered in Barcelona, Calle Motors 166-168, VAT number B=
-55210645, telephone number 93.223.84.00, and e-mail address information@ec=
ler.com. The aim of the data processing is to forward news bulletins and th=
ese data will be stored as long as unsubscribing from the newsletter is not=
 requested. The legal basis for the data processing is consent. Data will n=
ot be handed over to third parties with the exception of being authorized b=
y the person concerned or under legal requirement. You have the right to ob=
tain confirmation on whether data are being processed by NEEC AUDIO BARCELO=
NA, S.L. , as well as the access, amendment of incorrect data, or the reque=
st of deletion when, for instance, the data are no longer needed towards th=
e aim for which they were collected. Under certain circumstances, you will =
be able to request the restraint of data processing and data will only be s=
tored in order to lodge or argue a complaint. Under certain circumstances, =
you could object to your personal data processing and NEEC AUDIO BARCELONA,=
 S.L. shall cease to process them, unless there are legal and imperative re=
quirements or the lodge or arguing of prospective complaints. In addition, =
you can review our full Privacy Policy at https://www.ecler.com/en/privacy-=
policy/
