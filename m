Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8D3BE64C
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078737; cv=fail; b=twUydTOo8v6Fsl0+d7ulnSTQLBIa4Y14clvgSIBVvrVoC3+C6fXEFvFVmo8HI/+LrbZvFyrrxf3HG4D3Auom+zKe8rOfHLEta5o9bYK2nrikpWNuBLDmO40rkd6cnnoaibBS3jRJtFUxvgoxLapu5eUEnokZzOxqQxnj0THKjPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078737; c=relaxed/simple;
	bh=RsPaPEWAlYFTpLZIZO60yGQ4ZXKLz6WFHssH7r2D/3Y=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=titG8kfPNHqPQRrtThDDR4R/g+AOSBr082HOY6B99phQTrdy3HswSr1AMOMfN9oJ7jScR2WkQQTbU/MQo9rDdfz2l3X0M4NjV3Kyhk6zoBKxPAh74+d8zWGuSkg2UEb7fOLtMC03KX5oED0XlKGjTLtlH/H8oRYPQ7MracPozWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ilqrO4cs; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ilqrO4cs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4zRs/UbxvlBDi5HJubYWTkrKFec6XARkJaxr8094SLLR9c7VoXw4vg0HPD47ZeOvdVeCgxF52ph55RkV/ztHmEXaECUiw/iIFcr5GEvB+fmlY6z5Y6VmKV7ST9o2Ui10e3qQFG7SEkopQijhIRFHVxaRfxGBwQPPDI6FW3mdTByeDNZFOEWGgbhViGe3c2HejOiRTqxrKETtWfTp3kQMfH+D612OZKHmweS4Hv0cb0LmAvE7nsVIasnAhtOZizp45G53smjq2LDaDcATjqeaxs/MRwv1KLGv5ShYhJo4hDiTb9k/hLghtmc42T815nrGVAS+0XdTKQbCutVr5aAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qocRxWshAV3x19FuOScSlyncbRGVSAs1+owEn54XEQ=;
 b=W2HvvM5/jDYvVb7biXV3CDm5dupIGkA3IUhknYmNocHRRWcPuJD4Ak3YEG3mpac9jJzdoZKysUl8t2a/nd2TJaZrZAoecFaBe7s8r+uBRn7qxsSpNUr45jRAi12zfYKMU27J4fAY24L2gp9TrnwgG9R0GSw2b022Is0TWsGekgru7+u15e5EBDGdH5WrsK73wqeYLp+N2kLBVkICZ60kadYYX+krxKeijS0E15Mt8BnmKWrROxbBlF2zYeGfaHeH582028fith0FBQhUt2DC74K5nIQ4NmAqgZXqcofeJ6fJCf4UGrBdlaIthMivzaojNVQa28ObEjrUdWmkZcT5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qocRxWshAV3x19FuOScSlyncbRGVSAs1+owEn54XEQ=;
 b=ilqrO4csIQ7mbf0RfvTanuEYqsMBKGG2bl8MEbWqQKehQ0GD2eM6A62bI/AtHyR0LMGtVUGzlawl75tRwOBBBVnIdUQFDIirM6fG/5U/6lFqEhAJuLaTogS9UNdZR2hMYQLiZfb9+NdtJ9rTLzWFJSsDU3paenyWOnDv2uX45zUJT1PgOSg0DfqsCb7OKrK4Q/WKdC7uQSR9XGTQtCn71o6Dtt0MddrBlLXXFlaHn4PvVb5MMJnix6hmZzPZdWXNlRmepbouzwYhSsxRgZqCyOh0tttWyOp5ncCPYcI0swYD2PKsoByFW54nNVnDg/wrGpuOEJgCFCuTAJRMAKt+4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7910.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 11:12:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 11:12:11 +0000
Message-ID: <2a30aada-ea67-4cb3-974f-a06e79a72d37@siemens.com>
Date: Mon, 13 Apr 2026 13:12:07 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 7.0, 6.18] net: dovetail: Fix wrongly merged comments
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:208:239::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d6d9ce-213b-45b3-6952-08de994d822e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	CKV8gtmdYTOFBixG+/TlKawqVZrgGrPL+tIP65/5LnRPRuoLDDYkMJ4arw6tJaBCg1LSLjx8JAT8jxmK8TmsvpWKx1XEpkaV//y2Vsj+BcJqj7dxVtCqgWQx3pd9rwQE/xyYhqbjMmtMwHJvi9v31ggxagcyRVpX7qmCMQ+8Ok1silp4S6vCNORD+MLbRtsQEs2xOu+5ENdlQUTXiOO31pMhBh7vtEGNX5uw7v8MXNkgbYI4SMqHMLncVht+3KW8Vm8E50z9eu2ymSwjDsnjtV/d4nU4jXk8Vru5FSqCVCcR7sifhOP+ZO2/nIgsUAdfQs4pa5m41jHxRmIG3ixrKMQWsI7+OfYGnEal1s8L5QXevhPzgbY+vvEMqOxjZFK2iQYAAnX9585zAqBCzBz5BooSSl4fZ/Xrk7L5cisXJxVeCxcUmeWJWht5TFe9WaChJ2d01p8Dnsz5klfljHVdpY1DYQf7xhJVymEPPvliVefdecu8WBKatXvYlzHaP9pf23F3iVvpieIVf8Tk5T5Yu+92K1KLpa7rewyjF7sUPGn/RRZAM3t13sjmgAexydv0Ay+Obp5x9a0UGhB3QCmpHrSjN5yVkq+66gs5lZZXi+KfFT9WRoZlb+YD8v1q0m1qa8PeP6jYR6pHn2+/+0wSwCm7YlzxZKIaWvh0F0u5S8xa0AQk2gvc9brGLjniIeXjHuvEzsRBNH6cYZ6AfDOdp4fkMb60ikr6R37o5Gt2fBA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Smo3UU9iN2prRDA2R21wRFZGQ3NqT3o0cURBR0lCeC8zbVB6dE5YdW1pWE5Z?=
 =?utf-8?B?bm5zQVFkYUp4Z2VJUjlpQWw4TnMvSEo2ZG5QUlFmQnkvOTlqTVRXeFVGcHpH?=
 =?utf-8?B?QWh3QVBMSGFGMGJwU0U0QlJxcFArd2lVWlVhSUtHVlRpcDQxeXY2eDdGamRm?=
 =?utf-8?B?TU5XNEl2WW9BUkwveTdQMUc0VWJ5VXBIeEFRYnE3Z3R1aWpzdTZzVXVmcFpl?=
 =?utf-8?B?NFJUN1U3NU1wUjlsTWVNMnVoV1pkaFQ1bVZTcjMrcFJ1d2Nzam9mYUt2VHJP?=
 =?utf-8?B?NURZdDJBNWJEOExCQ2k5K3NzUHpEZWN2Wm1SbllZRmtBQzA4L0d4cjJZOTdT?=
 =?utf-8?B?c0w0cFE4Q2lZb3lTN3RwSHhwVFl3d0xkcW9lNGxpNTVIbW9VcWpuNEFHZlE2?=
 =?utf-8?B?NGY2TUJObXdvbzlNblA5MjNjWUlnQ3VOZEd3ZHpxMVlYWGF6bTI3Y2hrKzJX?=
 =?utf-8?B?ektHWndYRGxDdmtFS2N5N3hSaWpFa3U5WG9nclJaWGZzS3N0ZU4wWUlVcTA4?=
 =?utf-8?B?MnRIc3NHVzNVbHhnSVQ5Nnl4NlVsdEt3TG9yeTV6RngxUjQvTis0cFN5dWFv?=
 =?utf-8?B?eXQ1dmdwVlFZcitoWlBxR2dMUndFMEEwUWx0VXBPMmViaTlMRFZNWXp3QmJK?=
 =?utf-8?B?UVRwZHZLbVE0VWFTaEFicjRxM242SG4yWVpNemI4Um5WUVBtYVQxdjJaOHhN?=
 =?utf-8?B?M1ZMalJpZkpMMDUvc2FSNUpqYXFHNVdPQTVicXZQS1dtck0zMmRjalhyVDZw?=
 =?utf-8?B?U0NRcnVFbEtVcE9RNmtDcGNDQXVNQzJ2aFRXclN5K201ZVo4MDVUN3UrVXBW?=
 =?utf-8?B?SEpTRlc2c1hTMjRZUEVqR05vd3F3UWtLQ3o5WEduUURrWXhsencrVEI1dU8x?=
 =?utf-8?B?NmZYaTRFQnhlbWV2U01JYzJDeTlTODBBYXNmUlFwNEtpZnFZdTZwRVhsSVgw?=
 =?utf-8?B?WnRLYjBVeDc5U2kwc1JmMUFqcXZYemVZa1MzM0hXVHA3K2xYbHpadHFMbkhu?=
 =?utf-8?B?UjR6SHQyZ2dqeHRwUkdCSC84WjVzYktzRnNuUnlya0ZBc1hJWCsxTkRQcnhP?=
 =?utf-8?B?VXlmRko4YU80WWhCQUlUQVUzaUJXWDJOOVRQRG0vWThlRjJGcHNvdnFtM25N?=
 =?utf-8?B?YjM4NXpiWkVkNFQ5UXhtMndyWDRPNXJkanFJN1FEbHBZYkpkWDgyejZha2NM?=
 =?utf-8?B?Q0kvWWRHdWVUeEdPaXJkaHl2VVdlY3Z4UVBVaHdWSUZTOWZFYnRhaGx0Rlln?=
 =?utf-8?B?ZktqT0hmeHhrSVM1UXBFeGhHMmVEUjlIMW5SRVNpWUZwQVowTS9uMisycDRt?=
 =?utf-8?B?cXZaSnBReDZLK2pNejVKcU5RQ3ZMeEVPQlFwdGxkUWhoa1lxdEd4aDdob0po?=
 =?utf-8?B?RU1tRi9udWFwRW95TFBkTTVwaUpXSC92R2dKSkNpSnY3MlB6TkxDME5ZTSto?=
 =?utf-8?B?TG5uNEVUVHpsR0Y1UEZPMUYyckZwdERJKzdoOS93R1lsMVFDZ0RCNU1sYmU0?=
 =?utf-8?B?bU5tNm9UaENBVkw4QzIzWXpQREg5OVVab0t2bGlvZzBSa3dGWGpmTVAxci9Y?=
 =?utf-8?B?NlFRK0lkblFTUWl1bVdyWnREblJGMnZleHNKOFRnZGVTcy94ak41dGpEd1Z3?=
 =?utf-8?B?VVBscjNMWmtVdnJLRlovbWIxTEp3aHZ2WFFpZWYxMEkvMlZpTytNL00yODZj?=
 =?utf-8?B?TDltTW45STZ5R3dZTy9LeHVHWUJaQVVtUGdLbGVJODBNTGhScnl4THYrV0pR?=
 =?utf-8?B?Z1A5ZGVJZzJYenQybEQ0NTAvYjdFVGVvVEpMVGcrWStFMjUrKzRFV3JmdWQ2?=
 =?utf-8?B?K3RGZFdqZDhZbjBJM1ZxSGU0QjhwTVMvd2JmL3laYVIxQjgrQ1pJNFFIaXdl?=
 =?utf-8?B?WHc0N1IydGltZTROVlc1VXgxVzZYV2pFWGNQT2RDajNpSmloQWZXNG1XcG5U?=
 =?utf-8?B?a3ZxWWhjaGs0alA1MVF1cmlaNVZ0YXNwbWl2Q3Mvejh4bjFncjlNMWtVM045?=
 =?utf-8?B?aWtZTnAyUzBZN3RSckZodWkreTV6bGRCSmlqdGpVZ2M2dTRyUllUMFdHSnJG?=
 =?utf-8?B?elpWUmswcE1LbldNM2wyL0sweWowU1Uva3NyYUExdUd5QnBBZisvQ2VGeHJy?=
 =?utf-8?B?R3R3UHBXRG1xY0ZsbTY4S3paek1icDgyV2Uwd1NCZEtNd3JDMFV6OGZ5Y0tl?=
 =?utf-8?B?cGNOQjAzUG9Jc1p2cG13RGtSajNjWXhSVlhrNS9MRVNlRUdyUU1VMHBLWmVI?=
 =?utf-8?B?bkl6cnpjWlFITm1ISFNKT0RDRkpvTTdvSnpsRGdhS3ZIS1IxRE5LaHFwSDRs?=
 =?utf-8?B?YWlEdERGbWhiVXZkbEpRaElsSm5qUmdKTElZaFN3bW9reTU4NEVDcGhnSG1y?=
 =?utf-8?Q?VwPZGP1vAfyhn6Jg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d6d9ce-213b-45b3-6952-08de994d822e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 11:12:11.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlGTfLIFBQgsQ/uyCbXyXBMckD6ds+MeZqTx5nwSNqgRMZli29FF9Qx5J3UYfaBBMIV4ivK/4JnyNm9ZzeQSmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7910

From: Jan Kiszka <jan.kiszka@siemens.com>

No functional changes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/netdevice.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2285dec50589b..b59673d4f3fda 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5001,18 +5001,16 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
-	/* Pairs with READ_ONCE() in netif_tx_owned() */
 	netif_tx_unlock_oob(txq);
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+	/* Pairs with READ_ONCE() in netif_tx_owned() */
 	WRITE_ONCE(txq->xmit_lock_owner, -1);
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
-	/* Pairs with READ_ONCE() in netif_tx_owned() */
 	netif_tx_unlock_oob(txq);
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+	/* Pairs with READ_ONCE() in netif_tx_owned() */
 	WRITE_ONCE(txq->xmit_lock_owner, -1);
 	spin_unlock_bh(&txq->_xmit_lock);
 }
-- 
2.47.3
