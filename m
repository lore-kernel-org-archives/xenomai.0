Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233FA4428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpJupN4lq2pfLoBfKpO3wQrGQRctPmoMnfMdRQsfeVSMNidxXIETXYmWfNtgHOHXRMqkL3Wc5WZFT/HflgYszaBgQR4o4/bWVFvDQQllJ7nhaCw2UEDg2Ygwu/SXt7y/XHZh+CzyYuxilzW6cwQxcmINIUYHCSUi9NbkWiDhuSccEpRx2V/d/a3N9KzD2yLcadrQbP+fKGe97653BkxNevio/kZQ8iA+eRtbVmgkUEfLPPn6PUxeOn6bSBLAtpXa2WyyFxlRbOAmdvSzMMW1MrLWrHtP0hl40/9JyV3Cdr5ClmkRrClxx1FPPuUeY2aHilV/n6cDvi7wYdwBmkniiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVg+tgpD7WVYGzxMVb1/hicf+FyAxsswW2meVwcHiK4=;
 b=LDHxKjQcluI9vl7Jh/iZF1UFiWZbP/R4C02RYi8WSCtke+Kp4y2KMhnDwKYAm58QPfqPUYr7fI2I8cwvOLpdl18+AhxFZ+ZwcqzAxqxScwk/X7Dp0SoQHrUxIKC4RW5RaZDE8oR239CvV/3mDRLGdKl71U39KC6Zd/92sLAMwiibaWTtINhL2XsIQ4CjmYLrNXYJq6c9ebvK060wBxUjaehpMTY6+fYLRfbmkCfA+DMglYFJbdUYerH6dSQInGe30CXnd0rTqdP2Vmy8YcvrAiUuOn33yzz8dnLlQjANHHj53hlJ2QjsiaiTrXr44s4gtGC9TBhP90lwrDdr38Dg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVg+tgpD7WVYGzxMVb1/hicf+FyAxsswW2meVwcHiK4=;
 b=df9jkYAktI6WQuA8bVa8kG3Nyj4pdQIEu5cs7jCZfnzwJ/K/RLUVMHkvXJmfMZJSE+uqitQsuBiptClknKlA7Scqpw0+z5uZXlhhNyeroXqpFy4xxgnvXxRA6QvLFl3kemfibwA6yJKvtgEekZwMVn3XEkIR8J2Z3zHMheHBRpzg82+YA8iE0xXpVwKo3XQN0m5Dna/GtZ4ZRZ1r+ycaVOLn+3INJohOYWjwIfOXtqabIQZpFRw8pCImOH6bIYWtzvNhs9iDzrClPOe+FqZgiq3tKzKRFOZfCOtQ2zKQWZf+aW6ltGNqU0gOpws82NKS6izsMJjuSJynnzB10uB1Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:18 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:18 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 29/42] y2038: lib/cobalt: Dispatch timerfd_settime
Date: Tue,  9 Aug 2022 15:43:13 +0200
Message-Id: <20220809134326.23688-30-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b21811e7-df9d-44ae-0ec9-08da7a0d41a2
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/mVR++DtnjsdbhYX0eu5U0l4KMwVqohKeZ7ALSl2mPgX51UsIW3OVPeZOEX7kFySGn1RljZy2pEW5kd4aCfxFvVFqP7eTIzwjQ8tLcy5XpT36j9MPi+DcDzQCMBz8NZmDYl6oXnXLLWj95PWOnsZWRMSUr9nQxMSveaRlsqni0ifRwFG4aTq2Ht9ibRrky9CsMCvc+QPivPSsFBtrjIg1dmberjVuQOLz5ibBN9LmeGAZFSkqgSb70TaYmM/I/nGmizuSvBy6aTftGQw9LyQdDyy3sJVxQ0Aj3cNMY05/dkIsbM4OwqOQDfFAdWbfNcIJEz6y5xQLysJCvb16PyLqhUPOWxgNkbpbIHy01Nnh2uUnh+WZ+IhKgMfdh+gKg4XajmXF6t1za8AsbppQ9r0opl9b9aj56ivU4d72KKw77BIj6ZhpwNeJ2wgh77hzOWaXSm/pZ1UxYuLWEl6Ce796mb/JobOcz6pamunB/m6tYLRtmpJcZ0l4OAZUs4gEkLWNwNc5WF/c7BdRdThI+dNJBjR3er8KMWyz6CHlRNnS49ryfH9U3danxiW9yL3cTqXKJ/aAHcRl248IRRuEi2gFV7Gp+70m2HKKLUws7TcPhrss2o1duXtJ7Ehk8397Q0pyqUa1gjdsEWs7mRbEOedMmei24ad6kvb+JO0EiWE1j7FNE7vBM5RFpf+6S4gyqvxA/zi+5aixIgIF6vM60T6MScKpssSPzppvSN0wRpNVVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ayrEsdX3dDedkLvjK1KZoBBIQzBz0V8pdHMLEbl7fWup9bNuprTVDA6rhhK9?=
 =?us-ascii?Q?TLQp7wXnFb9Bj4DnxXeEAlUzK9mwSaQPFq47gD7ciyRJjY9RbcSFeVp2BCVy?=
 =?us-ascii?Q?Snn8s7+ZWe+/eYl3NGKEfLL9T9E3xACVPalgpJWoDyVHigW/qu34mLRhacmn?=
 =?us-ascii?Q?GZO5aC46KqGfaizLfWMVDVzJmfHMQ6nJKOjawt8MRm5SyfiI8rO7y1RiDQCX?=
 =?us-ascii?Q?ibr/YZ7j01lmFBukkJDiHhMH/XERLIZ6Fe07WTui8CFSkvyEoXh9tzXD7Mv9?=
 =?us-ascii?Q?TzGVVyx4SFXcE9OGDJHOZOjx+AcwvxIWUPbQiehptskc1ISfsvkqyRzOTtJf?=
 =?us-ascii?Q?Xien9QnnszOqygQiZN2EcnTjHyfzAfVCGwTnCrr3gdEh3O5a+nVZ2KeukRQ5?=
 =?us-ascii?Q?SNKc3g9akG1LNcIf2WUOpHk5JC+NG87dm92ZBsAQOt0B9OWUBKMCQ8mldhyB?=
 =?us-ascii?Q?13yEWVnaPlNxJRU2W+BNomuAbYRPoS/5iVtqRGTuucjBNrOGTyUzU71i7Dqv?=
 =?us-ascii?Q?7lIDn7acJCaGg5xYg+gOaKOG4cknH5ELw6OolZEBFK0HnWiQL4GbfqlqffWF?=
 =?us-ascii?Q?0qKP63Ai6JpaNzRomf29NrSwxCjjrMpjRwb+PMSdAjQZsvTGPj5awVtmUVs3?=
 =?us-ascii?Q?HVsr4uuvKu5hxRr7DUaFxCV6qkWphRcG9t9r2r5+oljWc+yE3FhuyTVXHZAq?=
 =?us-ascii?Q?qKo1fbARQiQoGUKSn6D0xx5jd+rdxDu86OPt8dNgB2x7wmo+vBJzj0tOy0F0?=
 =?us-ascii?Q?Ykb4Zgy43uxFii3iXK/MyBp3Ej0duPRY8JssgZrdKpgrHbJzWjWJ6pDqMKs5?=
 =?us-ascii?Q?7qBocIgZsTnbIEZGHsEkZtTPHb3SVhS+GPACUuPLiALTIDPErnKVN+lqq+mN?=
 =?us-ascii?Q?DX7YToxPwO4E6MUQ5OWAeBONKyrQ24DrQPtv5V7ygG2TGNbauuYJjk5tiOF7?=
 =?us-ascii?Q?umx4fSu5HND0H021pD6XCe+HdEYL41l4R0IdjbjAWfNWItRj4Bzp9qiqKk4d?=
 =?us-ascii?Q?DqpBDmEKHAlTw4mZakdFZn0cBY9fwFr6GU/y1nPJe9D+H9BIXQRVpCemHujK?=
 =?us-ascii?Q?HzIOc7xZ4ZcNVb2ASs7IuIbwJZu943d2i8hDy+L9k44BxJlmmWHfr6ufW9u8?=
 =?us-ascii?Q?tCKNoeXINuiZgO+m05t0CY8KNyWZ3Yxyh1AZJG1wo/8t2fVxSWtF51xFHJni?=
 =?us-ascii?Q?J6UxSbeWw8OCZ+2G3iBIdz4wQ1itXT/rNDzH+qjQ9ZhvlgZCGfOdC80uevuz?=
 =?us-ascii?Q?wsliVg/zCfYNOzVDY3PaFwZfAhCzYb5vWA8Oqi4YtNKFP+EkHhYdNTfprrN/?=
 =?us-ascii?Q?tysL1+h5X85Dcx14j84F2yYoTE1jvtoZW7UU4hIStIMb1MPwYcQoHVC0WGsh?=
 =?us-ascii?Q?b2XWGZN7wtezGLDuZXQ1GwG7gCkCWoqKCA7TblKZ6Ckk1d2m0L2IFZ76HVyN?=
 =?us-ascii?Q?rtdVbvkpz3oS/Lio2l6ofNvJPTPZcF8mZ+GQPvVAtwdMhHVjptGqygjqNpU1?=
 =?us-ascii?Q?byfKeit9C3L0gwFxoFXKfW1pIhn1fXsDT+tD4eXI2qm8/Kzam1PWw1NGK0KC?=
 =?us-ascii?Q?1FbZ0KZFDrbE0MYPolqPKMF259iUyRMRNfKmRy3X4OiEUAqcuJ4K/MImMkze?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21811e7-df9d-44ae-0ec9-08da7a0d41a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:18.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTpMKWFRy6wMM5rhQ4wjdFvrVC09AQbAkY/lBVziMJI1E28FArUX8QE40s8hf/IIaa6xOGK08/+HMlWu3nd5lekCoQQ5S6RZfV13IU+1DFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

If libc reports time64_t support, timerfd_settime is now dispatched to
the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timerfd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index 417e3aad1..a564d5076 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -35,14 +35,19 @@ COBALT_IMPL(int, timerfd_create, (int clockid, int flags))
 	return fd;
 }
 
-COBALT_IMPL(int, timerfd_settime, (int fd, int flags,
-		const struct itimerspec *new_value,
-		struct itimerspec *old_value))
+COBALT_IMPL(int, timerfd_settime,
+	    (int fd, int flags, const struct itimerspec *new_value,
+	     struct itimerspec *old_value))
 {
 	int ret;
-	
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_timerfd_settime,
-				fd, flags, new_value, old_value);
+
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_timerfd_settime64;
+#else
+	long sc_nr = sc_cobalt_timerfd_settime;
+#endif
+
+	ret = -XENOMAI_SYSCALL4(sc_nr, fd, flags, new_value, old_value);
 	if (ret == 0)
 		return ret;
 	
-- 
2.37.1

