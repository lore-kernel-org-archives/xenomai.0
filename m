Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334284;
	b=GVlJcwUa5WdLZOP2duqut4YwySLtkhYG1fRyvZ+YgipFmNMnoCUr56Po7CXhuqYgAYBl
	 2F0gyslKrVJfOYHxJY6bNh8D+zqWrD0zSYT/pxMGLnTNk1khJ+hY8ZVYieulg/lZe7TaR
	 30paUnZZX36JOCRD/oN6FqiZyKD+1Vdpcz2Ab/syUO1WVl4j7DQw76cak52qY5k7HvqiP
	 K1AAyhU7oCzKwee2VVUWkbxocO5nw4MuhY16g56JrYzoPZWVj2x2tqYi6fzYB71ZHwZI6
	 q05mRJ8V1F2esmETzSRbPOd54UqBZ6aAnhyNTH27vfxEZ2H/mlddRw2jSOS+qjUC87w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334284;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EeFsrzJEaWeUS0la3lcKogQY2Y02olG7s0Qe/37lrbo=;
	b=BpdrK+oFvYSgj92qS9y/NXVDlGC7QIS6nmSbjOiMnXr5/190xJBZ96T+1592cqdiMfaM
	 p+uCNj3PaHghKyWHY7mXSaOWTXJ4WHysciDa/uOY37zljZbd53FIz7DrZcZF2AMnyx/ON
	 R+VhJXSxRNvECatknJ5mi2tWO1RUmXLHQ+4wsOXHRkHqvQXy+14USdn0Z0A7RD6PCXcFS
	 PNtvhkivtW+KzO6iLqDojwEwObzHs+K/h1ZHJsNNXhVcFv4hwORKSBkZkMMZxfmUJb5/I
	 cOKBDwnI55G4uRwQqH+omcxKtRLNMEKGPD3gQeKlAc5TQk2IfGBOfcQrEG6eqymAWZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jNswNDtE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.67
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D3606A31C
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 236D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jNswNDtE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLFee+fDng7dr5IJnYBzGc7UQnGwhKQrEndbBju5BuNbrepiJ6YFxXjF9jsk+Gl7EEsdhCop7h0zQ+9QeJoBnEmub28gqGW6Dw1EERsRakZDMOll2yx30iEX/r1QOyKPom8kXBM9R78gwgbxG2TtpYYny7f14XfLk8enWqirn8E7urEORPug26hmFr2XBjLHCnPgCLUH7OkjWRbIXQCnlcKr+lXwpQZ/UXQY4b/hjJgZmWDBA/hTesQi8mQMd0V35j0aa2UI+dB4IhxebnA0RWdcM2ViMEC95xmrr7i2knbRDKe1TTTw8Y6ZTE4jsghzSHWzz5n6YHJbE5g6ne3c/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeFsrzJEaWeUS0la3lcKogQY2Y02olG7s0Qe/37lrbo=;
 b=k+uJ60VnTqL7ym66pjaPh7ldko1N0kKLNIdLWg7GvEn8TNf6TTOWU9BH8z7sTpCwnAqLPZS3mwyEaAWAfzlhdyUENkEIiT9Bxy7AqW6PhYBGZMSLIS/b5EErCU6UPIW4RTded9pR0jIw770hrU+f74LBwxIKJ1pKOLq0P9fIW6uOuHwPJRkMZsa847wVB5ngYzl8qJerPSCYiWPOwEhm/CYESi0TcytD44DRK+Yzvgt8x42ikvhIKXZ3VMgELVQI0cGFuTEXfYQSiLXzWPox+Hpz8Ia7wC6tIxvgMu8Cy3kWgx9v87gd88PE/kFE4HnKQ0zKzvm0yMzL0ZGjDl6A7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeFsrzJEaWeUS0la3lcKogQY2Y02olG7s0Qe/37lrbo=;
 b=jNswNDtEOo0tr9D8wS5/uApSD2pv6efdnh35ly8K0PL/k05taEefnct8HDYzyjlIakuVgAmy+uQBlkdv8boZiEgzMW3n32VTkJ0JCRedELG5vROUZXpRBwQKuVbBQDwzkZ6OEovnLrPEvN0PvGAuWyFzbc3FpOf9MWbviWJE3efWLye3in2xHj6Uhug19q487ud2mlRvLuDuYMKflpfr8Q5248iEF43/7gZZaXWGL11pwKuI+k/keXEUunx7UtA+NfiRrmM2VUleeYnGO+2aBsYlUgVh9tXsSFXOmzf7eVJl+8ALYD1raMn1DAmB/Mj5YnUoI5MniT+vc9V3e1KYew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:781::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:11:21 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:11:21 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH evl] evl/thread: fix lost kick of a thread running on a remote CPU
Date: Tue, 10 Nov 2026 19:11:30 +0100
Message-ID: <20261110181130.633632-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AMCPR10MB992240:EE_
X-MS-Office365-Filtering-Correlation-Id: c34713be-481d-4563-d62c-08df3f5605d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261021123027099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SQ50p0QPW3dqT2m86cjmk480/ktjPd0F5IzRx7B8cLhXfbq6MyQqpyyUYzeDTja04Pry1V+c5nd+rpUu93pqD5eV56ZZzNsAbQ0rZ/ozAETIG4SQgI5OSETW+YPaeutBJz3G7Be1jVLoSouuLtVHfYbX9tYJouFIrsYyEUMjD4boI0+06wLUShXefe9+DhOTHexQMn7KcHyqpy5elAt9IDg+Ztc1hXwnrxRj+oVG686lmQlca2/4PcYkGnqTYYeZ4t2rCJIozh13YRQVcwS0C2+j0Wa8z0wvLsn2SG2mCgOh2XOCeNGFkkeOo+XUTotO/ZkF5/iVbXf+LCGS/rQPAV3ZC7heeT+3uJDl5/X+SN7u7uk9vSzsX40xOGEMBcUFa15tXwQOwKKqZWr5d6fUs6+53JVYL0nUhCQDS41PeZGv2lOm+PgXjoYfEHvxHTUAnkPPxAF87U8A/hJPNpVqdbMaMHr3AplmlBktxHlNTLb0bf6LRqRMJX5aUi5Qe/EJBRWpTwH5gND8uQb+sJjIlK/zU6J1fUCMCKhs8jglT1Jt+/LIaMK6F7T7EnwQuGqW04gK/+V7Ise2iEM9rv5eBs7IOP0tnOew0pWzx1190R9Go5grGTuvQbAd7+nDq+qPBVxz+KPNX5MB0sTuNm4DPWZULisj8xetnE/b3SKJc/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021123027099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQqZhpSb2AGSRgmeociRNyehMxiRy+p64POa+uchxoVneC6PxqZVM25neWgG?=
 =?us-ascii?Q?+cvV5mGPAcC+mmdeW1j1eEfHvb+nClib6sC9to161WIpy+XyUwitiokUFIOD?=
 =?us-ascii?Q?/EWjIf7hgK7NDKi5JFp4fAuEyQ7GUKQZjGNbV79GL/JLzh3m8APIzcizlHwK?=
 =?us-ascii?Q?JydBBYQYyk6PczoEzhouxtUf7Ylryj9mY1aGCoEJWhy2CuaOVuwWKracEY29?=
 =?us-ascii?Q?I7GSOBeylZpnY2uNXsbh68Kb9YXkBR8n5DexNqLwrn9qIfgba9k7EYwdsQwc?=
 =?us-ascii?Q?bJpgD2/sKDLB2GB4yZICqj5CrXHh5VKO+0q6tMogcVDDj35xeb729OneapMk?=
 =?us-ascii?Q?fPze7XcfNB1tCNG29H8nIIhPbEmpiwUzK29T3Si+GE8KKUh3WoA6t0M71W03?=
 =?us-ascii?Q?i1vZr5cBVMl8KgzhmJDy5+GYyvJMIoBvxICNVWGSsx5uuJGM2GJwuiog0RZP?=
 =?us-ascii?Q?1rLJwcWEa+sYO+Gy4XjE8KPTYHtE70qFTO2QLCg4oMunyehY+YX8MtPhLChM?=
 =?us-ascii?Q?cUFZLARWMF2kb0Op3j/A/tcQVXNa4pDW7ka8DyJyJJ1Yj/aNPbcV1B4yQNdC?=
 =?us-ascii?Q?x0zuc09OW/sFq+8sj+77Zs+flJEiFlv4dWcTMmXhSPDEr04Z1wMEb+fX4vEU?=
 =?us-ascii?Q?ye3+CHpheisa9hTMkIUVOd3ciBgoLhICBVIyS512YbX3DdhKH+XMZJsDx6RI?=
 =?us-ascii?Q?xdyar7SQrvoucN6LbpbCuHsyeAWjPb2ezNrCC9YZIQ36hFJBa9HSYjC1t+8V?=
 =?us-ascii?Q?8i2sGAitfCt3SNee12AMAIBdU7g4BnjmTfG4evns5U4V2+oewCTZ8aYVPk3L?=
 =?us-ascii?Q?RpDXampvcr0Ce9hV/rs+QJPfU58a7GMudjN6Wq//8xAX8FOIRJRAbb0L1uNR?=
 =?us-ascii?Q?hPrg43isa+xv174T8OzHGxbLPLfXXjwRg9vkuk4NQR0fuy/UcBc7AVSjYjHp?=
 =?us-ascii?Q?h1zPxKLXuz18hrrT1r6IC1SbbULIGLlbBWC5cWUwb00XKLKJY+huaj+h4oO/?=
 =?us-ascii?Q?IZ6qz76/rEiuinrp/q0TiNBRUKq5mQxGouZT5pAQXMPXKmtP5Q9Jlw5BmYKD?=
 =?us-ascii?Q?6nZVwLsPY7ChZ5nTivl9YJInnYJbQvMQYUq8/MBWHAhKK5V1LIY4JcH082A+?=
 =?us-ascii?Q?a76398TcRSNtfpSncsHX+/5AIqDpMB8ctNyo+NijPiP7a+WLgb/PA0B1f9NY?=
 =?us-ascii?Q?1cyeZ4vL05e50Mws1HGfhs+VOM68pcBMtLp0qSBKY8L++yluiZ39TUkyabOs?=
 =?us-ascii?Q?nZpfnnUHNb/wImexfqmFsdl46sG4UKvkeGXk3635MDAZ0wdF9a7FTwUFyiy9?=
 =?us-ascii?Q?uiuTFnjPTFKvT6V/7xsHZ+tjIReemRwj4uypFSsZOI1e2eMlwNm+515IxOh2?=
 =?us-ascii?Q?JBWR3H+0Mblr1n4gckDEhYd0bkUU9qs87JgZ2GD7hXpcmeGe0ccIyr8ggN1Z?=
 =?us-ascii?Q?vryDSgjhPYGn6FM2hdGRwaIzpTCImK72Ph5rqJ4+u6ohrnldoMS3pYHmer4j?=
 =?us-ascii?Q?NaIOCaBuJVxrBYkrjh67nyk+3OwKcthg1dkUD1bN0rSgLZpm1yPHUL4iLvn/?=
 =?us-ascii?Q?322KeST7ERKkP9X/fxlGGkztYILswmG53SHtak0liXLnS3JvtJ3dKlxvj9BX?=
 =?us-ascii?Q?ncZNxeHA9Yi1k8xNVFQxz8Tynq57fyVftle9bjA+EDGHjJF8qwndj4gPizHl?=
 =?us-ascii?Q?5qFhjKNSnjyKvoP20e9L4RAE2iAanS6F54bgdE45cVjOaPpZlWFdwrNGSCHc?=
 =?us-ascii?Q?EOM/e9a7v2svCBGFkFWTQkRgbM0lmxQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34713be-481d-4563-d62c-08df3f5605d8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:11:20.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK43nDnEsFgEDQGCRVx007CkxJXlmHRVtOkkxSHXaDAB9h45uW5lSst2I9GGPqcCqv2YpcoeavSkBHBkJ7N6ZENUTBd9MQqz5ZiFQuKWHk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992240

evl_kick_thread() skips the mayday if the kicked thread is current on
its own runqueue instead of the local one. A thread running out-of-band
on another CPU is therefore never kicked and keeps running with a
pending signal.

Check against the local runqueue again.

Fixes: fecf5883ecd3 ("evl/sched: get rid of this_evl_rq_thread()")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 kernel/evl/thread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/evl/thread.c b/kernel/evl/thread.c
index 2aa07b494d40..94d073a1b7e7 100644
--- a/kernel/evl/thread.c
+++ b/kernel/evl/thread.c
@@ -1323,7 +1323,7 @@ void evl_kick_thread(struct evl_thread *thread)
 	 * stage demotion took place.
 	 */
 	if (thread->state & EVL_T_USER) {
-		if (rq->curr != thread)
+		if (this_evl_rq()->curr != thread)
 			dovetail_send_mayday(p);
 
 		if (thread->state & EVL_THREAD_LAZY_MASK)

base-commit: a3ad77d7ba3eac8a73f64026272747c01dd84fc6
-- 
2.53.0

