Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233E442B
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTYgWAYQwYPO5Nmn/K2EJMWk2509vO8hVa9Lm+uGXVFXoYZvLwKFjnOkKC4BQd20/pOndfQ4N6NPNQY6+CAnMVEivQ4t03AIuiRfjEQagFD2Vev7NPDbiez8cCQqf1GQcU7HfN8ZOeD6SYj53Sr2wXIe8pCeyiQqZPfkqtOGTFNljBor1VHnMa73lmK3SK71q9Bb82dppVbpni5EotiXidPW5k4yy+cD/ZKWzfvMWnpGbrPZK9NQ7ql5T9M6hiBhdaHDsu+yFdJTJwtIrmTZpkaVpeLv9FCY1dmXwbYUzKoQF2FkqF03qiPPcSiZ4f5OkKq5cOgKfUpZCxCqVKUKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmW8Lrb0f+AqsOitHNeaw2xNVSQ9Q/QUz7mY92s07jA=;
 b=Gz7Dqlq2ZA1+tH4HV/fBO9QBH+qvvsqNoXAHNDX7gBgiu+14a+j1B50rnFS1Jw7hGEXH6xpCzBVkYhhb31Ga9qasXqqFK64RkJ0Jh/ddMlTNuIRDC2hFsyvey1e6dvLdTTcelMWhWFWpuXRO2e8MuvW/b2ogrI3ciCk3XVajBNAlNJUgUtQ20PcwPeRtm9CVw58ggD0DCuWna4dNKULe3JOLCGi69evOSEkwWx3Kxko0ZMajNv65zCR+JzqR8lYbbWSl9Km5uKi9QcM8+U+L3knA5nprzCHC8kXUMKXxz/FlJhWEbWD3piru9utNH8AZsugED1TwrgxMtCuH7FYuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmW8Lrb0f+AqsOitHNeaw2xNVSQ9Q/QUz7mY92s07jA=;
 b=RRNy15R4e375yE8mlWEtv66kgVF0AhGJbrrhTRbyVUmTzQ8ouUzMHmJJ5H4lG7/sjnxyFO+PtRNyVOBOScqmMIaJIyneGuqwlXi90n7QHSSdYdXQSJnJ4QR6bHniUn5f3fwAmJQoUDF1sGkepEt6JLRd7+lajD6h8ZckE3n6mhsAEGaSNTwwKEaPbI9/gKqEwWDZJKl0fEF6axaS9fdXHASXbgdFcfq9PBzn84l+UpLMZ+tDuKyEMgiYgPkHu9UCzLGYAuCH8TFKz7h75vCaf+m8cwcDTlEY/k5SpTHb3w5tygnaItlBYGJlhwJN876TErnYPtn//douMDmy2aHOig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:11 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:11 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 23/42] y2038: lib/cobalt: Dispatch timer_settime
Date: Tue,  9 Aug 2022 15:43:07 +0200
Message-Id: <20220809134326.23688-24-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0373.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::8) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1322837d-f328-441b-61fa-08da7a0d3dc6
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uQdV+zuzx+MRvUsQOXBWpJskhVw75dU7zPIABh10o1P52bh0phAKLrwD/3xtY07FYw8hxVQuSTxkxiNCoyW8XXq4Sft5jtCU30BtgtvLFGkjcfRpY8k1kS4P0vLtv4kF6lUH1YhZb9IXNbWOenQAHhFXTVPDGCl8PcqcesPTcrDjiPw4gNduOlK3n2c+e7m+xrjReggu0zkCJgX5XuJs3pr7e5DTug9p3AZH6dW/ggdm88bi5+KeOhheIMkkjgQ0ko/a+n2qlTYcon6Kdor/1lAttSjYTO3pKEspUTbFBDvfmffUrVYcjCosgRQ98zdn+bry8rV9i5mGUgjFK9QFOsr5WI7ASLWXuwe26mgEtDTvNkFCDB5tOX56RU+i2M1s+FcYVbrO7vCkJBVIjk4WnGFBnrghxgYN2n9Uc8zP4/jQ6Fug90bQD4IyegVqkehjZ2LMt3i3pXUuFWuAV8vWNauHx0xs3WJXraxO/tIDxDqdysYriABsMnAinmxTMt0qIF8yYUZ09zXItBOzvLH+IqmLYu+f4R5b2xpxeF3t2MotcvTU1doZMqEOj8ZRwhPRNdo7XGtsUfc5NPfZHwxpIk0iaQ8Fzvjvdlgbu26eOd5P/9HXMlmB4e3KtVr0eVo//U/ml0OEbnZa+33eBSLDuiU1Mx9wJyE8Qkb6CBr/lCa96uc4qDS9Z0aV8ler32Cne3E9VcnUTLtoVL1HgS5RYfieBBiKSYXf1ZJMtxMJ22E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(4744005)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W47EPKSBBtlVGvtGstOQOHI2GO5EZpGZGWxwrbdBmlSVV+lUyUQ1mOn4OHkh?=
 =?us-ascii?Q?TTrV0UK1VMTJyzcJGRUB2hNXnrbyBIV+/nhcdIrF9Jjbboy5Jh7q0viu5r/P?=
 =?us-ascii?Q?LqHPtQzaeOBSGFUFLdJwcUiBvsYNEkjOz5zfAPmmV9PNLYSbzaz2SR/ojBgR?=
 =?us-ascii?Q?cFtQPaNH3TBRgwPm3/EOOExizor+9CdgpRbLG8lQaZZWPe3WZrIgvshZBsVr?=
 =?us-ascii?Q?82Ern3EWX/3pAP7p7VhftGcgh1jEyVuu++yc8NB5OrqQcn+tv7+z7mqdQSam?=
 =?us-ascii?Q?ecrGYbTgXKaCAI/3F3yiqrUjWlWm8hHE/9S9TdhfgN3kUYOqJXGai2WOVl52?=
 =?us-ascii?Q?suR7CEnbWJGV83g8kN8xz8myUKmEN9bf08Y0okC2vSyK1Kht81Rxn82RlN8r?=
 =?us-ascii?Q?caiul0f3w5EW9Cl5J4ZBalujGqRh7TKtrylapqbEGTjkVpFwzgG0PGTVrtSy?=
 =?us-ascii?Q?uzQWcnK04G47yb4puQOXjFMPJaeouBNZfwcXWSfNBZKeBgjh+tNYxpU2xNzO?=
 =?us-ascii?Q?tsWn1Eiw9BBG8JgTdGKU9oAP+1775Ltxn8CWKrSj/TYPt6HpCzixoSsfpGHP?=
 =?us-ascii?Q?+sCCWCleoBrVqNQEZXb9AClB+QYEDlrJZzSXhNd2xDqom3D8IcavnzOP1gmZ?=
 =?us-ascii?Q?JflQV64wfDYHy/cZaYgRNhUIkkxcsCBYyDg988GScm10F0KeLLcsgvkXD4cC?=
 =?us-ascii?Q?QRxWrOg8flXjOI0hxoruFyFF+VvbiXvQ3rZm9nHkiBTrYv1vta0Nv2kWUdzC?=
 =?us-ascii?Q?4s9aJPYr0kEVq4qj0nV1mPSFFc8m/yjp1j3n6McP/m8nAJpZzOF1xNGCRLod?=
 =?us-ascii?Q?63yclo1N/60pRstMY1PkuO2IKxTYYEkz5CcxjBKkzHNs7SeITX0CMSOYs7v7?=
 =?us-ascii?Q?63gZRK7NRZ4yIISmG5g7dSDvdKre2wohFYRTug/eroTuGYUOJYozYNMVZ/gC?=
 =?us-ascii?Q?3H29H2Yev8XNC8mg38JrAJEVErYSnTjUL6dZOnuW8k8luqbwy/TOyUL2/Pkg?=
 =?us-ascii?Q?/iIanoyuOnljj3MrIQ+YqvZkp2O3Z8dwB/9+CLpiiHqV+P43Z7ssO8i8TQUc?=
 =?us-ascii?Q?EUAqp+VlnansDb22hLwqtknDX6qCTPvvoVZnh4APfowXm9XsByL/8JJluVcn?=
 =?us-ascii?Q?3wF7UYHZQqz88ZIn1Z+g/y71GDORd/sqcf2oLVptu380u7oBFBXIc+u6sp8+?=
 =?us-ascii?Q?9sZJYwsgL6SnGe/IhPEQ+eWRmgx+olVNZkQtaDOLE1ggMfiw97fhQ1w/gVtu?=
 =?us-ascii?Q?mjuLVQ7a82iukXC0McSFYSPE+UwpXKhNQGKeAD4DuwjfFrV8vuAy6YuXgjUE?=
 =?us-ascii?Q?eqQBVBV5O6Bud/eA28f58Qf5cQVMf5UxK1F5OJc9zeGcPcsCDV5R2QRR4Zim?=
 =?us-ascii?Q?FPRa29saDCMiMWBbGS9qmxa7ILNBGMaQMmlFS+48s6zd5jFcib6Hkk1Q+WqE?=
 =?us-ascii?Q?cpqRfHX0wrSUUCOZCWHxIUXIS+jVKrrbofjaND1CEWxn1r0HieOmlONY0AQe?=
 =?us-ascii?Q?uDAd9NQ8g5OGgZzU8fSAOT19YVQqZNMf6dRH1mgZYJOWr4b6W0HIr02IRTaE?=
 =?us-ascii?Q?qcvzJY9TQ1gxjXMUuez+redE3caUDKySllrguOaMc6sw6OvcS1dQNn3VBb8G?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1322837d-f328-441b-61fa-08da7a0d3dc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:11.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZFwQ52a0iIQCuNfPKql6Wp5JDUe6rmJwNGqnC5SzzJSEZCBqiKtcGHAoV1B4Gw7V0f7loMLelPi4pkaslr99N65pddYXOAqTcPTyfiMvlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

If libc reports time64_t support, timer_settime is now dispatched
to the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index e3a1e88c2..4a57623c2 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -166,8 +166,13 @@ COBALT_IMPL(int, timer_settime, (timer_t timerid,
 {
 	int ret;
 
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_timer_settime, timerid,
-				flags, value, ovalue);
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_timer_settime64;
+#else
+	long sc_nr = sc_cobalt_timer_settime;
+#endif
+
+	ret = -XENOMAI_SYSCALL4(sc_nr, timerid, flags, value, ovalue);
 	if (ret == 0)
 		return 0;
 
-- 
2.37.1

