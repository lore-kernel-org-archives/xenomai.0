Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023116.outbound.protection.outlook.com [40.107.159.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498E35A3BE
	for <xenomai@lists.linux.dev>; Fri, 24 Apr 2026 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024787; cv=fail; b=HCUdxj7AYwtr76hx5otPMC4RLhYzGa9OJ0dXBcvmsc4QaQe5Ex5RlZMCxF3EFfdPaVG5wzoB9qf7kI7YRitKgg8jPGdNmUNBuGgX/a7+p4BEuiDwESVbCx1K4Z6z5zAps5RnqTwKVasv4Pc/laGCVZaEigA6jjsABYEKxt9mGIg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024787; c=relaxed/simple;
	bh=TzNM+lN4N4hY8wiiPmlDr3auldKeqG3haHafT/8Di2c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r3+nl4jfA7YXEurl+86+dYT6mJTBY42pn5NgRPp0gjpRDyUzq4rrtr66iHvOAxwSlY+EzH3VTx3C6PmQNJ3tt+7SEoP4eSlfQip3TBBGs/rCSnlYP8Fsp7+lT+/K21nh6PooqydCZtarSf+/DV+teg9mKV9YEJ/VK58xBE2A76k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecler.com; spf=pass smtp.mailfrom=ecler.com; dkim=pass (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b=h7sWndtp; dkim=fail (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b=UaVAE/kr reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b="h7sWndtp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b="UaVAE/kr"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TUFaI/vFnj6XoBil0xEleCpWOVFFScF5je6SRVfL2/uDLnvrf0FgV7RD6EIhJp6MLVJ1BTNHxqcLZvTVoQd2DzZGu9194eHy74frUHMwBXq69+dzz+B23FhBimnHmjSvtPrWPpUxA1GMkv5rpqRP755mexlv5pG645OgXE+A7b/X7RY9Qq0IobZpEnzum021+VzvLDbkPl35QvRgWbLzmjcHY8Mldj1kHWHXGgBxB4Qz4VPmvYxQOtXbRTvQpJASKnY1wlLoXKWlcnhha+UXNxs6Clh6hyGefeQqnebcNiLUsANsrXhJ0YsAc8kHUrCB0a/NpgtZX2oJedIWs9zlPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s46HjEebC6MJRvTpujcFor4nOfN7dOLGhJdawBRnnXo=;
 b=JiWp0vAkkcM0BLVBiJXrGjwayMEeQAhfWQY5aD6CUuW70ly3muJwaH/W0EtrBCMof616MzuLFZSrxMRRE/bbJ7FDlsVT17ItpHKVoyQ9r5P7b2oF00smgGVPuoHTTAg5cfi3nRSMNbtCrgE6fnNq6+5A4+A1qHmIMiC1uTGjeRGvzoCiZuE1nSJGEz4isblZgccHC90m3Q0gDIp7Vu7/01vmi+uO4YKVS3UGHtUlT6dCEvN+lSMKA1EnCKVSt9EXf+gfcE7xkn+lyb2XL0BWC4n684jdL4yJIqNcIEJCLZiAHKZj6t50Vqbz1SZJgbWdKvDpstdpsODcx4V2E2M5TA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.40.229.156) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=ecler.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=ecler.com; dkim=pass (signature was verified) header.d=ecler.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=ecler.com]
 dkim=[1,1,header.d=ecler.com] dmarc=[1,1,header.from=ecler.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s46HjEebC6MJRvTpujcFor4nOfN7dOLGhJdawBRnnXo=;
 b=h7sWndtpp59njk+Si1OQpy0jikOpUnz4aXia0OU+ijSfJeUt6syih1g7bJGDv21sKmQlOvp6vKMqCThCmlMJarQpEIwACaDPqP+UsolD1Y5O3kp13pf+vwAht/ORd9Ccq9ZK6VIIMEaOdLkpKIT7LQcvHHknkzJNC9PpkhdHHNaUAp0yGtz7epW4GhtthiP0xCQ5tJxYX/xAaWdS0A+utW90hhP1qH0HWXUxqEXTEav/70u1CdBVCQsX1obZ9RJIPLgGb8e7pn81yFQbp3MzI2GKAm3rD4Bebvl+/XO6IfU6rmiWcAID/qTwgtYkh200N3wqMspmqGc+Ex6HlQW9nw==
Received: from AS9PR06CA0135.eurprd06.prod.outlook.com (2603:10a6:20b:467::22)
 by AS5PR10MB8101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:59:39 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:467:cafe::50) by AS9PR06CA0135.outlook.office365.com
 (2603:10a6:20b:467::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 09:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.40.229.156) smtp.mailfrom=ecler.com; dkim=pass (signature was verified)
 header.d=ecler.com;dmarc=pass action=none header.from=ecler.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 ecler.com discourages use of 104.40.229.156 as permitted sender)
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 09:59:38 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.87) by
	 eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
	 ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Fri, 24 Apr 2026 09:59:39
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 3068744
X-ExclaimerImprintLatency: 760240
X-ExclaimerImprintAction: 557e54c077af410fb3bad522a9611e4e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMgVIdNvxxCiWfI1wpS6iysxjjmoJgkP0aE4+V9WAlzPXKqNx9YYEAZYHGimw3paaauckljVQfalJgOk6tJDAFrV9PYCh4NFs6kDRaoqPO12fkrlqBWNnWtaZpycktJKim6/xf48DIsa2tDyebVCtYgqNitVnkN3C+Il/HOetosbq63j0HxRJsmxyAlKbzT1KVEANVyyH16Y1yiBWC9zsFflJ+Y1BwhV1hOD8ob40wpDfUX8bDq5TqHrnHXso5RH2EsI6y+V8P45bpDb76scItolC2g6Z/7asW4iqnd/qeZzbYKT1pyTAgWgCQ7rOPCOpNM31KHduTZGKEAeGmFv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crImr74oxjIBa0BM8A70Hxwj7oHfzPbZ4y0ld+NPga8=;
 b=slDX4MTlzRTfL1Nvm2b5uy06wrTpOlCte0U88CYVFlWIfmkSCYw20gAQ6v2FBwbIKlWTdFZDHeDwhW3ogaAJjMW3WDdclw7nzEqJc6AdCIx5NxRkTj9USVuPSaW04s3h+mWXf9kRVPcqB+wYvTd4ikFhtu85JmOqDb4M7KK6FQwsIRPclLTN8eV07VInsRvcaeMBFvgxl+rZ5Dm26KwVpXyfIqoq1Bw1H48GQg0DXNOTLzM6JDSL/J6jiVRsDOuj+ZckdWAnQ/a8y5USykupy4Eg/0Kky8sXo01uxEIYcqEopdHXznF5/4HKo6th+BMaPnrK6J0ZjM8ii5fiuqUSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ecler.com; dmarc=pass action=none header.from=ecler.com;
 dkim=pass header.d=ecler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crImr74oxjIBa0BM8A70Hxwj7oHfzPbZ4y0ld+NPga8=;
 b=UaVAE/krneK+2a5bPMrgw7nD2AG7jYVQZlkvju/JzS4/b3ZSldREl45jW1/kKXDuNspOlGtrCrHDMvS1y52Ofj+dMbuiUwBaKXnJoWTZVrAnisbZhL7AnY7aUMdqL7wE3UNyFGV7ijHJpz+A33UsPmF0jKsqPCP9F2WYmGMXCGCpfQoRDRQG7HQTIMGlDV9nNuqDAjBEbcxHeQ/mR/XY8pDAEjQsBduCtwed8dlwrzXBNMhah6k/K5g2MqnY/KSBckGfK/rEa5cxvluFanMJqLmaXyHDquVNQfLSXzDqBgQXZex/3xowryvQDUZM9eo1I+zZAgtfCq2bPpbb2Ow9SA==
Received: from AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:629::22)
 by PAWPR10MB7674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 09:59:36 +0000
Received: from AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c03:58fb:66f4:7121]) by AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c03:58fb:66f4:7121%5]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 09:59:36 +0000
From: Jesus Villena <j.villena@ecler.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [EVL] element-visibility BROKEN
Thread-Topic: [EVL] element-visibility BROKEN
Thread-Index: AdzT0P3ZJTrKIN13RYmROlDmWMJ4BA==
Date: Fri, 24 Apr 2026 09:59:36 +0000
Message-ID:
 <AS8PR10MB7731181CFB7CA13EB3A8C4F7F92B2@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ecler.com;
x-ms-traffictypediagnostic:
	AS8PR10MB7731:EE_|PAWPR10MB7674:EE_|AM4PEPF00027A6A:EE_|AS5PR10MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 2167a2c3-e104-4f24-8502-08dea1e832dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 Yy3NTK2qGBwGWL8MpizCUNB3pASRuTkF59QxfTdBkYS3WYgBNFJVMmudf5OeMAU0SZcb/KcJQVTcXqqL73Ejv+5wzkpNDy7nvbSL6rcaNOcSfcdFbukmpWD33g65nE9C9aV9d+gVdMxmOYrFurka7lcMPAfdM3qnJg+2qyTS+R3im9Shn4da3LVQ+aUQ4lcp0GzkBGj+yC7Z+3BBcGHFEDdV9F4qbF7/oZ2hdbINaFwp4+XpEq81a2XqleRC4An9lbOBagSrRV3mJiubg/i52Vp+f6UFHFco5A7zWjkObzIzyOwif+pYUaV9npUg87uTuxQtbv1bsSNVCv0ESGT6TJ9SgCw7oruUFd3MrEmObb59XGBdADBemljqE3cTyfrWaqRtzxr6qGHuG4+W0c0neLik0+RqMwTv5EqaBN83mq7PJ0QMJHoY2rPPiPDJHdLiy/zRdchqnregIbv+6QgNCZx4dFkEGsyR6fbvumjYbrc78aP0ACG5vcUhxboMeg9JxPm9oVauTBOS5jN17R/7ktvu/zJAp4Gwp/ct2EgdAV0YzynsBOuBmWM6YLKfEeSjdU9H2J1xMOpAyzIEtiQlpYNus8ruke4OTU2kD70kqCDDRjHf1QTCJ8mEHirDEpFgmhXWts9r1pQrHGl6gtoNWsjIdcRI/hL/BUjIwCPBzzcLM+6XoSWYd6Fl89c73A7fY31VLfPAi49hp0IxiROCBFfI61p5Yp/1bUsTIT5MS4I4TX7rnNENTCAIUjFioAiZMs2nG3YSq1A4dh5Y+HzgtSS1E/mti8usAr2v4Gn4tPg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 FZB+xSmsRw+5H8AdnhBTn5j6/y4dTqOr21Yf1jEaP5FUwKGBUoUCjY6X/kmXEMHUdc3Bwp0RGZ4x5GzQKof6jSJVpWfw2uHugy068GPmjDYiFf6o+g1v+b1uHW4dAO74T+opJj+mcHl9YhMBaSjvR2YTunzCNmWCewKYfKpv4BQco4DMpNlAoEk6AT5P9WrFJgqxCTyRGmTggekZRRKJYZd+UoejApE+9Qn8n7cdmvpyn7fc7V3HC1mKxXxHrV91D0HQlwEByi0ob6Bb+/s9qLs2epRgTmEmu/UlLbAb4B1cS95sLb+gElJzlS6igs4hohfjw144086jjrEwP8PTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7674
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a3892a7b-3205-4685-1dd6-08dea1e83141
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|35042699022|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/2pFjHE+pAX0QixvJa9b/VHXdleZ4hI6njj2Y3f13Jd+JN2cXMnJIM5O8QGViXCyX6B1TzQUAHB91plkUdGlG1KV5FkpUUewWKjzgGMLIOA56qXvfneN8dtSxMP5ZVev+sbbAdAg6IRYqZbJlIx+bpLBM/ZPczJF42Py1b+L3aEQq+/WKyahKARvwuZ+ZAd7YSeVV7mnQwJc9mJH4npd43eKvsoQGhmw/PUAfqDd48KyGMxDTFGbqhIH8Gw7BzE8IotX7UXzjLPIxyc2WXAM7oOOMmTzJEYgfXGUCxu4k8wkC6vrClEACzmFWaZDr+eYZeL4ghXW2sHVAf+outNZC5MEpEwz0PuGf0Fnf/elvCaPMBBMUd6tU/jj+hN2H1gH+wKf6Uq060CZP7DkyWpavfBeNWiZ7zUszD6pwrlQfjxrb87rv2YchFUu3i7CLZWRw7S45yy1HvNn0vvcJ3EuUzA9ZyL9wKe0SJe2JOQMF6EOu8vlUPNZZbh0brC+44wfgWPpjD4y7ab1nUaJqaCYYfgL5QMx3UvalBYNPcXnbgWVMT56s/OBiAe9Qo1nHNjxwEDDejwaQ68ytlwbX6POQg0OPP/F0D8p9+9XLrMm2S2qjnEwkoDa2KUWBckytfXzPLMf9jwf+C8JCtxWNj+mVXiRri06Y1LBZrFtNX5qEJor+LQ25cI29r2z6om/HRxBg4rhZ0zEyuczbhEY5Il26VqXVuKB4hLjIcVWTM9atu+zV/il2UhAU4w4N3SaY9qDwPJyTchS3E+luBVSBMwNHg==
X-Forefront-Antispam-Report:
	CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(35042699022)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KrMqqdK2yvyNDDAqNwf+b17QSPiaPMbLhoBYQjpi9OpXIDWIvZMs/sFTATjo2igQ3yUxHX3XqgxEXw2pwrJQpPeOaGHib42vqPwchMXK0Azy+ilbNa2derEu056kvaV0SpIj2ICSjR3MlB1SeL7ynTT4OtJrpeCufn8S166yyEkyFN5FaM8Jo25UkAToAE17XT3dimcIRcqty2oYOW1RmWuxIhUINAhC5hthZSCxsbiHoGnLKv7wnwW7qQTrTZdtde5gcQSkLXuyNucravHopSEnf7/pPEMV1dTAPtbIun9Rn6f5Lg7pRJ6BqNMsvWE/voNzTpwdF8wiINwxIMXexwLoO1/scg3s9GpDF9pz9ZDE1c4+CWlndUVZQwdobvZ11uKZukGG+kraeDAXVYpmfPfGhiRs4VdzYkr/1WTIX0XaF5lJhkvwuFaRO6nGFGmn
X-OriginatorOrg: ecler.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:59:38.9869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2167a2c3-e104-4f24-8502-08dea1e832dd
X-MS-Exchange-CrossTenant-Id: 6f9193a3-7ddb-4a6c-9664-df2759e0e5ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6f9193a3-7ddb-4a6c-9664-df2759e0e5ac;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8101

Hello,

Trying to validate the latest evl linux kernel version 6.12 on a RPI CM4 ba=
sed board (the v6.12.78-cip19-evl3-rebase) with the latest libevl revision =
(r56), I have found a test case with problems. Running the following comman=
d line:

        evl test element-visibility

The results are OK or BROKEN in an arbitrary way: sometimes it ends with OK=
:

        element-visibility: OK

other with FAILED:

        ../libevl-r56/tests/element-visibility.c:60: FAILED: !element_is_pu=
blic(path) (=3Dfalse)
        ** element-visibility: BROKEN

Has someone discovered the cause of this wrong behavior?

Regards.

Jesus Villena

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
