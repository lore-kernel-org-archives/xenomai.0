Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C091E764B
	for <xenomai@lists.linux.dev>; Wed,  2 Oct 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865626; cv=fail; b=Pxq7hb/Ibki5hSn1H3cE3YNBGUO6J2xtsYR7zYqnXv9l1FRcF3F4mCbhDK6pg2Y6iYwvUwPP9nLUDWDQQHsbQmiWEoRohZPA5zbDmtYgG0neObVERsIbfv6zcBlq8ax16fLPbPMmxNBCqLbN1Hba0VzF8UnYAHN3GmSoQrRV64M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865626; c=relaxed/simple;
	bh=XDoGnu4Rz2E9pPNz2zAYB/oa8ae/eNWRRhZW30MSeyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWl6hAyEkx9yEmxwhou8b7MLpH9gDirBDYB9A1zjkSDSoXlwpVYk4/P5KQ2le3l2eZiJcU004b1DU6PKPi0heBXazeQ7NZvDlsFiunEMGQkjDx3OTE8KIPAQnr6eDyFiAqxxkMzrTFapIIwWH7hgDerXQd/THtS95sgdhAVGfTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eq6UCfb/; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eq6UCfb/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M69qz4u8NG/XdojnntesWYU34FH125N035fT8b2PQ0y4JwGtPBuz80C2z54YDcppH0TP5ev3vo1GC51wf6FYLN87/jJgF3jBfhsGNkrFWRnFKhpHw5INka5LlmO0YFMAusK79uPYIjWZaPjd4ZGIdP5qpv7qRY+Psgjujv0cRUbRV15G7kGpyhZgVOK3aYGu4/T9INVuFljAdCFtnqmcENpdGfNU1OtKYFqDTjPiI2FGWMHtw6r/sofx6jsAK0sZGGnNhi0OAmvi7LzMyDzfksqiXj/JM/IfL6dnVbHj3gubj6kjOWC5nz+teIenf2/qheTtPERofcR5/nvIwM3/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVFQIrbh/w5yBMU2wf1sFljOotSFnUVQ5la5yeA/ctg=;
 b=viYTlJBz8c0T2uN9VW9rQSxxIStH/zw7u2TrnUh2HJCjSVoJJmH7qYxAiyRjJ8gYodzKLf670ZWgj26sCnMy4LkRX76XkE3Arkp29FwvBKnpDm17RAsh+ry4J9cQPbBmsQWjV4IWn/dM6uNWAfJeZBqPbAThiE07sx0GJVtAeLp1RLHDYVfNorRGg6wl+rYP7Kqvt3SfLaZYjVWBdoFHZthwQJaMWtSh2NV+jY8OcnQCYee3W2Zx9PNyyMDfoa0qLErLJT4IStwaH3cdH+4DjFlL7aukx05zNa858aleYVed4YRK9BqOFufSZ7KsgoU4/u1JpukMUadYk9y3oXc0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVFQIrbh/w5yBMU2wf1sFljOotSFnUVQ5la5yeA/ctg=;
 b=eq6UCfb/TFTsaRXnInGJqWXh801yY+QKu1ni/CAgGijQOaXGP+8jpFO6IYjpiM4+NQ6UH3GdGydcYUAX0vPJol131JnvFhcoZshkzUTw6enWenFdVItyfQNzS1pCsvjbt3FXmGE3VUGlR35eUOcL6EGKCVCk56+J9edSKYwZ6RHFW5OJguktwGaSFObJ71QPm9gMhXrzhzIOugRSUFv6OFcH34pRWZeaKtSfktFiTL66k36tUUg5hxDxKDKRttaG5Lhj/NTF/nPWslSfK+loMnEgSvPxD1D8SZ8h+N5zaG+ss4JUI6L3Q9rpPN8zCwiE/iNDZtiCCemwEHyU3NWNlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AM7PR10MB3908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 10:40:18 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 10:40:18 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 6.11 1/2] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Wed,  2 Oct 2024 12:40:06 +0200
Message-ID: <20241002104007.991278-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002104007.991278-1-tobias.schaffner@siemens.com>
References: <20241002104007.991278-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AM7PR10MB3908:EE_
X-MS-Office365-Filtering-Correlation-Id: 991f4512-1b1c-4d8b-2693-08dce2ce9be8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?boipb+ydLZ7i7Li7ozNsf1fDGrxM+6TdscZsocfkE2o7IM9UxYQhJbS91jn8?=
 =?us-ascii?Q?+VJnCF0e8fWLdqZtoDeEm4/vABN28t/poVwpWCDWMZwp8GKUXGfjeyKdjGil?=
 =?us-ascii?Q?00XIYfGHVKZezsXLHXXu4XtP92gMZlOaEq91sAnCvBLeBiNEveq3GySb4kc0?=
 =?us-ascii?Q?2Mlxps7m2LAS9f+NFGt3PCOw9Ejq6YxP5cJuj0e6GyC+leFvSXctvqd3FeXc?=
 =?us-ascii?Q?7r/k3taFxoHXZBUW4TRzQ2qfUVfgHV55IG7kbUqNQO4dlHqH4f88uMcMRD2J?=
 =?us-ascii?Q?u2isCwxIp9v0G0dkBkBoF/w1BVLuxg+dNrxVLChwxfYoIuupBEf9zfbgj/gB?=
 =?us-ascii?Q?utAyvRjEPaMv+uXxfAJMWVgo9VfFH5Rxgu9xJVYRzKQtDRGH0RcEegLj5U/s?=
 =?us-ascii?Q?ZhbJzU044FROjJkJCVYBJ2oWAQKxVx9xZT+DDcFmivl5GukDI8uNgQ1wTysc?=
 =?us-ascii?Q?7H7ZAdbkYlx6bjCbqCIC5B04/w+Ds7LxiQM8Npz6Co/wIiZ4a3PlvF8RmnUc?=
 =?us-ascii?Q?FYt56SJeM1vyEBuZwmYmVsFxxrDhbS24nKskWvJqL1xZiKi8iz+1Gx0hWxJ2?=
 =?us-ascii?Q?1yV6InUJalovxrc8UGQNs7rJZKLeLOezIP564VvrRmp8TUpvvQ2Jgz0VndCa?=
 =?us-ascii?Q?rgr5KfIoWzOlkeuacqi+L28kfrYKOR4EFZLOYuuhGMfQDeGcFx5V3g1PQp7p?=
 =?us-ascii?Q?gp2lrFjPtSjAuV5clZgkSzjXppvObysDnyFOUPOYSOBku4g9XcxWrntk7/cq?=
 =?us-ascii?Q?yQP6U4N8mWkr3eJR8x9EQ12q4QNbP8chURnLZFCESckSuRL40GKFRZ9P+n9f?=
 =?us-ascii?Q?R2brD4oUf9fH0z+Mxa+Y6dJTwNrqRliRNVLI+aiSQSMV3HFu9Ua8Dn5tRAGi?=
 =?us-ascii?Q?IvpfgG0u2bOGIIVxwAd7GEuw7WMAPhwRM3+Z3QxT9FK+z90xMrMgtEvAu/s+?=
 =?us-ascii?Q?U+e4cdA+a+1bdaXYJ5XX+TASszBhjcttg2ipdJZvFvtvNGI+LHZxauJgM3aA?=
 =?us-ascii?Q?p34/2KZsi6mR0IPt1nXsar+cUgo39QAo7VTFcj8HUQNIfAi1O47nZwG3DTs7?=
 =?us-ascii?Q?vtExNxsmPBl6N8dXFcw7WDTI4zi0ObjMRJMlhJ48h9KRoTg7cWudX3G1aq4V?=
 =?us-ascii?Q?Oyq5de2l0XvhdyP8H+dFCBmcf2OfjL7L2NCDNk6m2e0I00jXqVkUqZrjZG+Y?=
 =?us-ascii?Q?tgDDrUbuimGhllUljFeGkVtxf0QDBgVsS/lpPSiWq8Ff8P4zNANJLJFWJ+hs?=
 =?us-ascii?Q?02kh9+7cZpScwJkiIaGJAVQl/KHeYsUOIFPwqu1unw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7R+ydjFETFA+mxkIN7sPTX9ISN3FvUIXm5B9oILJ9hd+Q7QNgVQJWBqKqkpc?=
 =?us-ascii?Q?hboe9xFD340AysaphgNDPIjiSRyw4y5RLVz62rIa3lUuwYPFqhox2w4EG3e+?=
 =?us-ascii?Q?q9Sc9xDADszqr+K4xuhLOC3o5pTIK88aUyI02qhU7E4KbNM8kRrlqE8LOE9c?=
 =?us-ascii?Q?yvmRquxf+GMo6hcxKe/+qXQhw1uS4Wl0Xte3Hx74NVEyOOUYZp//KTp2j16E?=
 =?us-ascii?Q?ajQ5S/dtc6qKZ9TLrYObE505pWAeltT0kJfvYyqGsHU6IwGVb5pnSF1WWgoG?=
 =?us-ascii?Q?3Y81WDDp7JF2spIWSNm/Lw6qirTYjlsMRADMIP9O7Qb7UhYi/G7FL4FdqSK7?=
 =?us-ascii?Q?d9hAgAt3jN9PtBJBGEo+Upzh4jPFdRAnoS6TuYH4OtDiI3URc1majaIKK6li?=
 =?us-ascii?Q?9jXBnA9xgtd50sijFtalYJT1/vG0sTmZnJBofkKF2cnI4iMdLqrCYogJhylx?=
 =?us-ascii?Q?1Eilib1jwTT5R8ZdUbB2pCqEWLiPAT6t8eMKSDowmYdJ1eKB3yotpvjpsKEk?=
 =?us-ascii?Q?WC8IG263KeIlJPc3YHOTBRsXNUw1nJlWRHMVlmWu19B3liBKGuDNFljijVvv?=
 =?us-ascii?Q?vh+SPIeGIP1eKqAoPfRLWwnzYGIB8J9hZ/XgM3yF5Gt8AxD0wIxfhK6Q08Zf?=
 =?us-ascii?Q?vSX/LjAoqcqRB0B4iGs0B35daDyXRfWOCMUTzmA578AW7IMBsyoaf6WUwQ3P?=
 =?us-ascii?Q?fcVrZpqxM0p2fLJsXJxTsukgcalBtYlq51ah3tXTI1M7Xu59mT3Y4U+11DBY?=
 =?us-ascii?Q?yuP22+8Vs5asfa6BmxRJx8YcaWGGIT6p8Dy/g5ROA6Rp29055mkdlckYUCmx?=
 =?us-ascii?Q?7AueEMDFrmdtSo4zjy34uUL+Lb+VKnd0wXIiPud58RHX0U1Zenupj0HIMmAi?=
 =?us-ascii?Q?n5m8p3zro2XBnoLHqnbCQy9hygwEbrhfbM4FNCe8lb77Qrwzua50KIVT2QBv?=
 =?us-ascii?Q?nkqkvxT63EY4oeOlGMoe/l07DCjDmtf9d7SULMURqmgrIywu7NBzlOxQw+Dg?=
 =?us-ascii?Q?VzvOa2qvORTUh1O5xAXG8Fa4NoDpu6pMHLc8NlaoCKfulDjzmGtFisjuKt2A?=
 =?us-ascii?Q?U4IiS8mh6mbIeK3WKcvi84GZ9MMsa99fK63fyCgq5OvbLuwviB/IrGDlRwCs?=
 =?us-ascii?Q?LhCqDOJTaFXnHrdhx+wKqij/EHTyWcCNVQPyvr0P/jCD69mLHXFRFLdCzgVW?=
 =?us-ascii?Q?cfThjA6/Wt7LK1AKDxE3IuDcKDMlEF69hc8xp0owxV62f6+z4gm7lnals+4e?=
 =?us-ascii?Q?2x12O6Tqd0cCm1B46iHW/qKT88dzqNkyM2vZKTcgpejuuqbDo11AIXNMxvZ2?=
 =?us-ascii?Q?g6TLDPbor0lhZ3nfE5bKRwaBZ0HL32mHsr83WYHk3zT9Vt6ONcnQr8WhxZ24?=
 =?us-ascii?Q?qc3A8NiPZytNXLrDQqDvxBAPs0DhsXLYzaQpM9jSXXpYTlxJ24Ge2hSZmDxe?=
 =?us-ascii?Q?08qRsM9cWND2uFCaABlGTFHvgnBRLiJXyO1/4dBbuDNss76p7Qux23O/mD+o?=
 =?us-ascii?Q?Z+/uu1nAWgjYpcd/IhJUjj9IwuAScdA+Yl/wkGp6+ToCV2DNdbvFPn9Z8abY?=
 =?us-ascii?Q?42hx6X4eefTyJJ0HcJZCepC8eMX7Fwb83Qw2AwyWBe9ZgUtaaNcOwv0tu2m1?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991f4512-1b1c-4d8b-2693-08dce2ce9be8
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:40:18.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otEWWPWeWR0ij1nY2fg8oDC3wXUVi6/gs4sXGaPhn/aMIDBrqf6gD354fdM7/7Tw6R4/uSSEcr71gDbqE2dDxWjVuBbaWuYuMxiIMrwjqwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3908

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/clocksource/timer-riscv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..2f014b1c745f 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -70,7 +70,8 @@ static int riscv_clock_shutdown(struct clock_event_device *evt)
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PIPELINE,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
 	.set_state_shutdown	= riscv_clock_shutdown,
@@ -143,7 +144,7 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
 
 	riscv_clock_event_stop();
-	evdev->event_handler(evdev);
+	clockevents_handle_event(evdev);
 
 	return IRQ_HANDLED;
 }
@@ -175,9 +176,9 @@ static int __init riscv_timer_init_common(void)
 
 	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
-	error = request_percpu_irq(riscv_clock_event_irq,
-				    riscv_timer_interrupt,
-				    "riscv-timer", &riscv_clock_event);
+	error = __request_percpu_irq(riscv_clock_event_irq,
+				     riscv_timer_interrupt, IRQF_TIMER,
+				     "riscv-timer", &riscv_clock_event);
 	if (error) {
 		pr_err("registering percpu irq failed [%d]\n", error);
 		return error;
-- 
2.43.0

