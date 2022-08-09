Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C24442C
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrD/TrxOsO21FR/JLvb5nuYkkrkxP44+9SHuwU6ZNASDynuDRXpCD9Q0hEHGuBLmHWQv/wB3Y4WsIx1oUZkGRvHS4HUUydGq1ugHQ/tNeCbQXhpUzyOn9xpzXT5au50p9DAnUFQ8MvntYgnNwBc3Zd6Cv5SqMLGLTspyXc6A2fJh73FNjTfYPkKVo3BwfZD9F8bAHf9qATP6UWhm7fyUVIcZF9Ka8sOKU0ZmbhuXozXW4ciKkkHyVLAO8gTVvfDyMAj4PjgZ2KzsYro6c+mKeqYhmE5f+JdI1GyO/OLCv+Jo+AlSxhBPo74judmsJEzeDK7prD4uO3AZ7yOyVHOe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26QeZvbTdOZAjLAML7KRQ5LYGGuEgPpLkjjWO0nlsKE=;
 b=CodTN+tFJt/MwXUZuDs6ExesL/dG+S9g4uofb1CoKVEDHz1Tlr/5O+cbOql85sojuqJRJmlXuR7L3h8T++FARxnC4tZ1Fdh6vAcFTfX85PLOKhZguz74DJt7xWJZ0AxSbDCdrdjF8W/BMBVXq3DC3GpIkI4ZsxVIDaY+H8wuOebGZ867k/WSd2iHbswjr/JqiIYcU7qtbOKtXTXaqv85S8U+hL2P5YE2AwLzY+V20EKWI8L5Ao5daW9gY4dlMZ12blsrIfnb9k9vTgbyJfI3hl8yeEZrJ8aXj91iF2r9uuK47bbr+rZ+rtt1FjMgtKh+czk9QRYRR1t4yODDh/TR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26QeZvbTdOZAjLAML7KRQ5LYGGuEgPpLkjjWO0nlsKE=;
 b=MLYk3Ny6M0TzANCXDcVdQbBwq4lH8+ZT20RUdncQXvCeCdzSbLj9qz1mVV3dbAZUFoLLcn/A3PLhbrGZ9Hroj1hIgjSyOs2poFm/BrSLdydk2HQnji6UxgXmtpCbbo1lw5B3RRZJGJmbwDsZHBAp7+Qf3Hg4dniqCHHZf0HOB4n8qM4uRbJ9jX1+n355VLSL/TRtykZiUxuXUODW/2l4GllhsU0JU3gd9VqTAr2Z8ocOj+skA1jOe5P27z5nWgG4ldD4UYQAmPw+a3vf17/QerUO9sFtKP0Pocssa64hQ7zqDBeFzH28lQTU2lcAB1FHIgbCdj0u05y0I5TGAs0UPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:53 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:53 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 38/42] y2038: lib/cobalt: Switch vdso to gettime64
Date: Tue,  9 Aug 2022 15:43:22 +0200
Message-Id: <20220809134326.23688-39-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0532.eurprd06.prod.outlook.com
 (2603:10a6:20b:49d::31) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27862f0a-f3ff-4e7f-1951-08da7a0d46ef
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0VcD6eCLswfKTWDpPkLS+K10MNKnInNnnkD0I/qvpnmHcgULAic8NJTyYPOwUGOUk2UbpJj55mkauAlsKS1IVLUTanENG+gJTdd94b2K0OMhu91DtG05DTwIXRUUYuaxyDqLoUkNWJTi27KGu5w6PSH1/DV2R7JuucXY/XRTE1GttUS96uYG9AlhXFnvTPpmhgff9/cr+GCa1Q49KQBpJHFLvS9DFqIbLk1xzrSFnjHvDS5wGujJUCDM/94S0mGKE5CHVz8hpV6AqcB4esh+HIJ2G/nXKM4UD0im3Wh97FWv1r42FK9lW4B3Z2zBy1dJT9S/JQ/QCws1dj1YFO7WrvkHfyt5w2v5EBX7hF1dVkzoSrETVLS0Q91GgJasQu2clnupnlr+4QoGnK+WRtnyy3A9O9TazlB+w+UmY15tDTPIRuUq2vvCeTo8v4CGCD3rb1fdwSCP0YY9ZKhlKrCFNAAX4FqDAtg/vljIa/hIFE+JVsORyD8LqnU5Szh7tJ5EMUloBMb/KFe6M/2b/StV0it3wTLKpmyM5SIrjg0uLRAB0aD8P9D9ODH7+rSzOXF12mHkbPhHoC9gKA8lyAPm4wx3NUL3v6jlq2hrSekMmIWm6Yju5FXtadxOUkhezsaKqcXgJyY8Bm6UAICNrYiN7imaM7YbPFNfuRTECFp90sUL+ymFw0vavoZGxnD3KU+iUjoyRjG8GscKIiWrBB0uWoebmzdMrCBlzN1Yvws8+Lk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(55236004)(2616005)(186003)(107886003)(4744005)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PzO7+7zghxqh1uGHwzEhkX6ekUJg2GBQ4FUEUM+erUQHRwSxy/ER9VR1IXdB?=
 =?us-ascii?Q?ijLIyQ0i7G1beiy4qmA4xUuoVvTkCR++PCRLSsjz4Eo8/gfucMtmSPQ+5BE9?=
 =?us-ascii?Q?Z9fxGFGiNC2615yaJox3C5zEyehlNrF0Am+dwW1BcO+7FKhcryyGvat6xNcx?=
 =?us-ascii?Q?tzl1UnX3tinYp29HaN0EmV5CxEDtrFwMkCHuwCn0COHNCZnrnPiuIujYUdTD?=
 =?us-ascii?Q?OxtjLeBwDtme/J1tLtXEzZERJALUcABUZEXT8BO5QY3Su3BIIBJgiUwk+DdQ?=
 =?us-ascii?Q?1yEONmNbXZHW4onuTp0pV7bSJ+3/ljCh2qnQEgs+K3XxSB1GW8q83Eo7sNfE?=
 =?us-ascii?Q?ricOqjOKFEzWPKuXcqKuksn3ZRTk45kfcP8HIVVtxwmdYdQZ/xZ5Td4uvfom?=
 =?us-ascii?Q?EO3kEM7x0Npauhyq5lto31D8GnAcBz8N7tG6XrYukvpqnDXadb4zMjGBKmEU?=
 =?us-ascii?Q?nIAt3WKnSEOOdo4q1/8w3BCUHEhgDhtYd31/evw3V/tHN+pGN2u9E3Jw9fPc?=
 =?us-ascii?Q?CflnGx+8axfYAYcdkZ7WQiKf4Ln/NIldwv8YqzHaTYlnEnk1LNVgwUHdHxCJ?=
 =?us-ascii?Q?rVVaV6uae+V27vQOlLbtO3RHZgLFhA+KoXVn9U5jYFT18cU/sf9NZJc7Fxnn?=
 =?us-ascii?Q?NSUZeLFzLtQbzh98Xy16CxFCZXgjapogG6U0MDigZPY01PzlATB/szUWFAQ/?=
 =?us-ascii?Q?fn14dbFANcDq7QowhNRxgjS6FVX1TIkoRUBLa0ZqImNufxMmg+d22BmGLBWF?=
 =?us-ascii?Q?NgwUEgJ/VNcLg6TalCOPjEmZwGYfhycSH8vyQ40vXA0JGz1mC7EcfJVuSVYa?=
 =?us-ascii?Q?jPF1U0mh7iV+eUeAJkSirFdxmzsLEeVDGs0DS7vYxIVOfoWR2ml9CgHzsMue?=
 =?us-ascii?Q?bkg6iTneIXoHVDB6r+5Rf28xDIgt+VGuh4FYLLmXvhb6WMTd5vycikljGuDc?=
 =?us-ascii?Q?EFcClnfW31+C/Rvjl28T6bKcPPoHrqvOEM9Q4Jp+w8mw5J+H1pLCg3dJRKXv?=
 =?us-ascii?Q?JyEaH2TjeOEO7v9sqhADHANebCpcnifoFU7MymF7+EaU8cusH8bbrYtz8E4a?=
 =?us-ascii?Q?TjVruVCDrbYtgs6FUNbEWpnvogTD8IXaZOU2UbmBakLGOTw/ZyWiwbhMhzrT?=
 =?us-ascii?Q?2cM7gZIvJcuJxbypk7elMXWPtv6q035psg7t1eZtPyCT4NKh2PkAqGCzVg95?=
 =?us-ascii?Q?QAtXygl87+fniRI0Wc7BeiQ36CeL7gGpihpLPwFZhUdUo76jsVz0JmInlqtG?=
 =?us-ascii?Q?S+MTgfyeLAbpCRIDR2YtAO5rPN+JjPwS/gE8y8CiL1PdwuGQYy5rhmXCi/ba?=
 =?us-ascii?Q?0Jjvt/V3w8Ns0aQV9N+BUwHgAOuaGTB07C/T+koDCm04YcEBGW4ANgTvq/Xt?=
 =?us-ascii?Q?eDoFXHzgTBQPD4FgWES2QtiGLKKlDQSIttLqEtxS1AyJCeW0BOM3h7OYHYPK?=
 =?us-ascii?Q?lBfIy0zH0ZwWCs/039YVA/6MtN14jJ/ISb9EDt/0exwHEPh8lZmPONmdWvdx?=
 =?us-ascii?Q?A9rh2/+ZIbHrRVx0SFRUOf+fe0DSxoVD9V5YEr2JYJ2BMult/omS1nLIXT71?=
 =?us-ascii?Q?RSn+ure+70S9POafPfBHpe3a9VWrMVNMFh6pVkqEW4zkWSdaeEddhAa8GMyL?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27862f0a-f3ff-4e7f-1951-08da7a0d46ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:27.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRHXwLgmluA8fO+OOcyBnSUM+cYNX4tQtmGLPMz57x9eNZhoH+cMJ94it2zH87pM8tx3STVW6koTns8luZzszzTxMqrf5h2rth4ezaSxGsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

In case y2038 support was requested we have to switch to the gettime64
variant of the vdso interface.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/arch/x86/include/asm/xenomai/time.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/time.h b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
index 693be8736..18eb76697 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
@@ -11,6 +11,11 @@
 #define _LIB_COBALT_X86_TIME_H
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
+
+#ifdef __USE_TIME_BITS64
+#define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
+#else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
+#endif
 
 #endif /* !_LIB_COBALT_X86_TIME_H */
-- 
2.37.1

