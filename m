Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4394428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsA8/lWxoOWw+nhAOmIPpj/wTBJzDuVjEoXl2NCELT5sWSeZXJkDl1P/zi35NjvzASI210Itamit64sJR09K62nO11njqcuI0p2Xj8FHZLLXxwUMq1ZFeZWJGv8/FXLADaDXOU/aTBKMMC30JMWgug3AudqjD9pj+MdecKHREIoc8X9pVFI/TR4Kye8LJGLEpwN0nS+CrQzOqUcljeoQdunP45yCD9+J8VJrdkWHsKUJW5dt1/EIHU55SEtUhNWRJti4I+6LnRp+LXYoCj/p7+dA/UaaOh6htr2qIS1J2VYlj94KujRJq2a1U2uDfNUcwIzGDAy0PzvjlsjXU6q7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYWdqV+0pbrxeXfLqJXoQlQqR9rvN92ZHseudUzIOyc=;
 b=N3WQnwTjbP9YjIIiSu34K/jMcrhC4D9bL45uaQ9LxdDELw8FA2O7g+RyAsdS6m3hI6oL2RZVP+dWpO44WnJVHGm/m+UAozLzqeu3js/hfpj2VfHCt2MPsXe8mo6cbCujHJNN6wVX7zICIXjLHw0aXv9Nzw2DM79ta/VzAuQoF8s+UR4SRbkXeQ6pflI6UQaSK2HNdBob2bS3iPs/glK3DrFQhJPjkz9AUgb0UfR/MO0cHlOMpsjmPhxk0b+o6ZQHMnqgR0zyIceton6Vuo/3cJkAp33B/3k3obOm1xkMwhdp6Qvygas/0CUy1Q8oFGTijbtS6tciMbJSxL4KBVCevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYWdqV+0pbrxeXfLqJXoQlQqR9rvN92ZHseudUzIOyc=;
 b=wAI6T8p+dF9pydQc0KlvyiuwO2nWV5QqaopUnE0uQ20ji5z0cyIP6Uevb5Vi+Xk+Ivh/1AiZAMarCRj8w8bpxVtQdEpE9YNLDDUCp62jStiIwbUDa7/uWAzyhSc8TL+1ZamKhMUhTtGjujkiUjAdie+ULGmiaodmjVZcilBpCJ0znO6S6JOAOgNXF4BzpW8MEhrxVFnhugHaiwQgE2DdDogmA7dsy3CwTk1OrBkV1ek9Mh0c0hfAZZPOHiM1iESVZY8Xx52CnKlSbc6MOsXQWeOik5hV+JQxYR+sxNku1QxNbYhmf7/64rZLLOhPm5X4jDO9SDTImigqsWR8uM+iSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:44:04 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:04 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 16/42] y2038: posix/mq: Harmonize mq_receive and mq_timedreceive
Date: Tue,  9 Aug 2022 15:43:00 +0200
Message-Id: <20220809134326.23688-17-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73389c42-c212-42be-8339-08da7a0d3984
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lhjbC8fuW4brhrzGI31xAWLeX4S40eDhNH2dlp9OAKAtqj/arAgm9xPTleZnbQvOezWmDdCygjr/IDY5InrvK0LcGkcEQnFvMqUajjo4FLODrF8HRu7DwyWAp+wiV4ox2u2Wgl7o9MTO/u6DdjW5v2pm6gI8ND973VhX2VbnQc+9WUoYEBVgw6tkC7pnj3XHPIITjlAt7XbhGQByhBL8WYIVSwI/8C9t9XrAC7Y6Tx+Ne6XsPykN5evTCDtfF/gZPJdTlaGAl/OG73SAffS6WAS4zk5YuskvII6kC5ECYTPNqFx7wpjcPiAM2GI2gOk9A6vwoWNVBxxwNwtt4NSMfedx2NSjI2EmH9mKkinsbmUk532cFjjKm/+Or+o2H+hHEiS7nVTn1QL0rIZkCZ5GwviPe3tMkfmoRJQ0eyB9UN/4SmXwmEBFmcigpkbBXU0CA4DTSq5re3qHyz205lN/olGGgnr0J2H246qMKQZdvTb0XS6iNnttxpCLvKa8VY0+cUKuqrYKKJN0ugp2nUi42DAtYxQQ9K60kcjz6W742HOmCqJv8fq4E3LMwxAYFApK9/YU9+5TCKoOt/M/EkVWSZeaNIfv4h07MduDcUKfUvO47k9APy1ldjuRw84flagD6WxXiMU5xVUQGbmIBZb07nZ+Ns6May28YVqugtOX8AcWpCWbvq1aub9kL9izWmijk66hOjRLPVg8Haj1pG9svb4oHW1bpzYkqM5ehDhJEoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(55236004)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RPJmnOYkXRP/ZH1U2B+g1y9Tpuyrdz3ef5K+tNh0i+8Us1hLXYAWYwq1GuFC?=
 =?us-ascii?Q?bXIcLW0/kQ5A4Jf6/h955wW8UHJgKJxhwh4ZPGifhQaWK5eyPXyxLQFgejuT?=
 =?us-ascii?Q?NBD8p5ksgzZte7GyY4M8KJUJAsGV+ADYt89DifJ2fWrS7DsJ1rD0Jpx1GsDI?=
 =?us-ascii?Q?onVpP4+7yZsyXkGhCBOHrT1uJhB+qLXs+FKIHjZJIsDJpqQx25tR8dZPZXP+?=
 =?us-ascii?Q?bGJbI/euT25aBdO0ss9/6DO9jy3ROT+rvIsBE5zbMztDBgolssQu//QkuPk8?=
 =?us-ascii?Q?mUDTBQe7rCMnmHLgPHrsbwodIvnN5IJEr/aY1NzqqKpvxbHV2QiIMtnbuJVv?=
 =?us-ascii?Q?xYDW34+voKImXSACst8xd2nV2skMCZj8M2G/uc820sTYS0HoA/ntlwJxYJpQ?=
 =?us-ascii?Q?MYQB06W86j0WPqjV4Ldtflwt4jUnh/bS9fM6fmphbO3+ZxJrVxQBbp8Yqjdt?=
 =?us-ascii?Q?jD4P1PC2bU+7YlhBcYJluK+QHKWQ6c+7B+UguBnSkG+pPrhjj1/yZN+GVebK?=
 =?us-ascii?Q?RZqerR2mPKbJk7oZZCbGfx/fmfgsoajOWGBP0iKAlelO+KRFEHb70dkxPDlt?=
 =?us-ascii?Q?UM0qn7DgqY/pz1KWX9dvK5q3wOoHFqf/FLXVjNc5orIQ+ck1BjAsZ+5xGLhF?=
 =?us-ascii?Q?zKdsYMOyiUAOKgBTi9Fav3yEG0oHArzFJ2DtyRLhC53Lp2Gk7HoU/9dOiAFX?=
 =?us-ascii?Q?odLPC/Yg5fEgBTXpHSDXW0sga0tDybdEu/7Sr0ojKXcw7Diq16YDmMqaYATo?=
 =?us-ascii?Q?ukOehGvdaoBIhf9+0kJV6M/eZwbczw5UkS5xZohVXnnNyptnrXugP5pKaPqu?=
 =?us-ascii?Q?Ri7y7ObX9nPlwvFbOKE0OtLXECy676KcRL7+CJUGtm2/kxTka3CE7UBMJGui?=
 =?us-ascii?Q?bscy8MRQqdJnC/4odabTle5JDainW09FlbtratOFhHvL0Qb6ZjmSGl9wHrWJ?=
 =?us-ascii?Q?Tennw3W8m18a2NzXlPU8sBTbmmF3B4MDMuoOo4o2GFM/oW/1loWs38DdO1/8?=
 =?us-ascii?Q?BYr0x9Yi63Ez6B98CBWPw212xXCtPQvzvrYEO58r+kaOgbIAYC+yATL6CGj5?=
 =?us-ascii?Q?Mp8A2i8CmgcXiPVw2T6D9tbZW7yozLxhmGCWfvkEPt7HghHe3oiTxoRkRq9T?=
 =?us-ascii?Q?x2pWIlYVzDGJ1zwuDwL2cudbm0Mx6FxTzOIvko22rc25QeRFDNqdfMn3hKVf?=
 =?us-ascii?Q?pIS88SrwBH0w2vR6mIZ+9ELv8x8VSIz1FHvCRpCV50waALf2ugmBf7uVHmK+?=
 =?us-ascii?Q?P9PsH1AhbWvqr/wDNBhqDHHWO1/rWneZpeBqfPCnyO+uy+kHvq2adTuq1tba?=
 =?us-ascii?Q?5jUUyYtSGVAkFUvGz8qvjMQsEOK9SXe1AygBBHu6K9NKkZ93PMnCgof1tad9?=
 =?us-ascii?Q?aUq1ZBSRqSCRN65VmZlWS3qrjnzAejmzT1zel2JntwR/CKbYeSB8oXNQeDgH?=
 =?us-ascii?Q?JEoAvi8jsFwoFW6I4H604qYSEIxQqWtgpc6gFFtB6p2JKrhor47pCPEPiakJ?=
 =?us-ascii?Q?kn2pJvMH/G4iBNvFYhywVMtIVACXNhVYUadwTQoDWVuHf24biym0NfH+lqLu?=
 =?us-ascii?Q?BO0iaMKP59hlpJUlfvfXfYLbebNIyDNKhqz8Lv4RS/1qvt2bPl2dgbhVHBYS?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73389c42-c212-42be-8339-08da7a0d3984
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:04.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOh4RR0P9IiPImC5zfPBhHUID3vGyjtxjwsbnsv1IgoGM+PMScjg5oUBV/iGTWfq2EweUmKhjKcsT49riesaAsgOH2EGeHnIVxZ9TQwpM4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

Let both callers of the cobalt_mq_timedcreceive service care about
y2038 safety. The old code was correct but confusing. The mq_receive
service is not y2038 affected because it does not forward a timeout,
but it still calls the same service.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/mq.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 88a74095b..365a28e7a 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -414,6 +414,19 @@ COBALT_IMPL(int, mq_timedsend, (mqd_t q,
 	return -1;
 }
 
+static inline int __do_mq_timedreceive(mqd_t q, char *buffer, ssize_t *len,
+				       unsigned int *prio,
+				       const struct timespec *timeout)
+{
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_mq_timedreceive64;
+#else
+	long sc_nr = sc_cobalt_mq_timedreceive;
+#endif
+
+	return XENOMAI_SYSCALL5(sc_nr, q, buffer, len, prio, timeout);
+}
+
 /**
  * Receive a message from a message queue.
  *
@@ -461,8 +474,7 @@ COBALT_IMPL(ssize_t, mq_receive, (mqd_t q, char *buffer, size_t len, unsigned *p
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedreceive,
-			       q, buffer, &rlen, prio, NULL);
+	err = __do_mq_timedreceive(q, buffer, &rlen, prio, NULL);
 
 	pthread_setcanceltype(oldtype, NULL);
 
@@ -526,13 +538,7 @@ COBALT_IMPL(ssize_t, mq_timedreceive, (mqd_t q,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-#ifdef __USE_TIME_BITS64
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedreceive64,
-			       q, buffer, &rlen, prio, timeout);
-#else
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedreceive,
-			       q, buffer, &rlen, prio, timeout);
-#endif
+	err = __do_mq_timedreceive(q, buffer, &rlen, prio, timeout);
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.37.1

