Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794388511;
	b=muT5AVh+ubm4gK1bp+Lj4IMtcKtObIJBT97z+NcFIR3dVxnB1aHSjeqS3j/GJ1a7auKN
	 xPY2UNWtQMnOP5qAxZ0QXQANF2sgM2/crylrr9litH694wHH2b0F/LznGGCRknIRgeLW0
	 Rvz6guAIyx1zxT6fA6iumdbuNpI208dFD0ZxnUZ1w7Cafs8MoGMnS7/8eg1ko4mq05l3K
	 0XfS04vgcxy+0C2Sjy++umYktKqQHFz0Xg7KIvevIHf5nDxDKV5SdzyXDg6+kUOV3+4c9
	 wD3G7BOv3XuYdYNNTKlw/Pefjme3yty22ENBApsprXveFs/AK4PIekOXfhPve0D53+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388511;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	bh=Eq9kQwUnfEtHt1wOUOkWSR+k6IK8NsJOW2WsuHDQPKI=;
	b=2WOSZV6auHl55/ehH2GboOC9cXWDijiKqbjWVvUjMipJ/xDL4bzy0mmCDKbG98WCN8T5
	 oLJY4eAeieV5RsXi2J3xnz8StAtgPgzW04jlqUjmAa/Mp3toiWeJ0qPCq6ulRyXr2P9pf
	 W5n65Gzfjtx9FROroTBCMJNwbGCeSNCpef87CctW4l8f1Ko1RdNZcmhnO6ojlSjTtFbDS
	 T8YnI9ryiCWLb37eQqym6r6gMSWz7hISNRMSYmkk/xcAVvMmwgwEQr0k2dyckRSX84ENM
	 PghpxcqtKXBfTPRHpX8nOcOeqfg6dOjv0emwB1CsC163GGP71aP7TM0OeRZtumc3qBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=FYUWv8TZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.4
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0A606A32A
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 09:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DB0A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=FYUWv8TZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZNDNDZ4qEstmxik8PT3TEM5TVgRnPzo5Dlfc0B+De5yl4bPLwXvHif6irUHXp4eGdKGetgPLvYrc8tyBwBs91ZkafvKvjQHuJ2c3CmVyPPUyaA68uUXKCea8puR4Ib5cRmYexf3sKtblprcQK834HqreNmRJcS7NMKQAih5ZnXorHdDf6iMtvG9HOKqYFytKXOUmNtlmmYmjQTuM3ZI6tnxt82p70bd8z5DFdNiLBxcd9KqKb+1tdVPai4+JRt85gvCMHxpOauoMqq+wsukUE4Mi8dfyev4dYRYaPcXp5hbqUpwlEldG1eya2vXui9N09duE4sDBzYleNrRgYpnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq9kQwUnfEtHt1wOUOkWSR+k6IK8NsJOW2WsuHDQPKI=;
 b=h8dr2XSBrJlbfBiQsUrPOvBMuiJiRTylAi1gW0hFpu26fz+OGox86q8wj+TibzH647oB5qIhoTEBA6HkOE9mTpPbVUx/9zNMMIcbMWPx8LkMbld57+1CiEbOSBWznczVPf63O0GG/TjYQjsizBsujzNCYqsKDUm5BBIuq3xXNBR3GteFIkNCUkFZlwLlJcJcUD/t+5RqqcirZNtZU7SH7hd9McpvDQwQd39uuVy4hr8E4xRReWHtoZK/+qnpIVNM+gg47CH/JVP0MT7ARmyPSDdIneQfrBGfIjEk49HiURon0CkOhMge9QJPiDCTJuuN8H/2AakT+LHWXKC2HuhfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq9kQwUnfEtHt1wOUOkWSR+k6IK8NsJOW2WsuHDQPKI=;
 b=FYUWv8TZTkYMC7aRUNdhZD4t8lCKtAWuNfrvYPKXnV3dbdO/S2VMs50inq4EtpLfcTLdyCOb70q1mBIDAE+T0aotxwf1ZfjWPdgKHkaYTslPkkJz0QSVlj5ml6gmf04gR+yBl602ubctRz1se/cRi1ggZvAsx9SWjdPqwrjp9BJVGO2zHgA4S5TWohLKqWDEQCS/DAsE3MiDhKg9Aqv1kbV0WD7dItS9a45NMuV/4KwcvJvV6OC/0NDrHKxKBQ8PzBiMMiW38lbkCuIDZZC5+QVqCX4elg/UIa3Qgz0r7xULNSCMzKWZnqFsCKzps6yGYF7KAE21pu8c2Yo8Yx4UEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV2PR10MB6526.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:15:05 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:15:05 +0000
Message-ID: <3a6f9b1e-dbab-4aad-be69-3fdb30be8545@siemens.com>
Date: Wed, 11 Nov 2026 10:15:05 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail 7.3][PATCH] net: dovetail: Pick up lost return code of
 packet_do_bind_unlocked
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV2PR10MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df18bfe-5b0d-4d0a-08e7-08df3fd44663
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|5023799004|11063799006|56012099006|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261102123227099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7CvMDggFHFQxhvaDkiWtlP32f1BFVO/zPQ0s3nUrHoz1xPbQXPcSc5jW4yjJx8hmxAs0DQCiHuXyS6fuUhvCNXTWNx4wODhpbmyTB6hUMyxZSSbo98XdAQh5snUi1N04PLxoHeEgGfBushTbJJk+cGYPQNMUgD+VUYum8D6AIG8t/iG0RyvC7sbivlyR54XDk6E877zPbvNcDkE0W94Cld1vEDnKA3k2QoIiklnjqV/z3qjGAV/vMbvHcvtGfSnK75w/02jAwrRhMYJcifrsedaOwP5u7vn3gB/akj8BrWpPghtXoB61aqDFmEgyXu/hwqVdQloCwOAVTc3kkbdfKuehjhgvUdHgLzb4YZCFQN0aVIestUO5QhjiVhpPsI9ePkqYKyrECfskuF14m++H7e53GMJ7husCY9+P5awmg+RyNI2hzt+LBzJEFsgcLkdY/7LiAf+pFa4zQKRQwkreI+kfkFVTR6yO4LSQWlqCYjeyuwHyfYpHo42EXAnC3wlvBpTIiWvV7maBjM4oN7d38+EhJjHk/HsygK/Aoja+NHefL/oTfLjB4b9/+L954Os3EfacT1iTv5+xR/ERgVkNI+Kul05r7xd/QaEYBtTQoXGllSPBnVByM0Nz17XKiVgimdEcOoMDeTOPJHaBNYBmEwLmdJeJz1Tib4i48XRb8zg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261102123227099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0VIOE41MVIvWndZM3BMS0R6dmdTMTdISzFRZVNFMUdUS2hwL1ZFV1JrZCtq?=
 =?utf-8?B?MWFlNFBQOW53azFQNlNRSzJDRWVkYWhIVy9LNkZBeENwYmV2S2lhUTNWN1dI?=
 =?utf-8?B?UnREeFRPZy9kbndwaTE1ZnFLVnZYZ1NrS2RJMmdoWEhXYUNTOTBtMWxxVDZO?=
 =?utf-8?B?UE1uR2hxdVpPQXg2dE5FMDM0bWdJemhaVHc4ZTZhYXFrc1RHVzJzdXFqSXFr?=
 =?utf-8?B?TmZtQzFRYTJsN29GT09xK0x3amkrRGpOL25adUlraUJmTW9vVnRwQllERVd4?=
 =?utf-8?B?T3lwUzdLTTk5bGpaZmN3RVJrdVk1UEFXRnlLMkkybWI3Q28xRlJvc3VQd0JW?=
 =?utf-8?B?VlVTSEt5OGh0K1gzanFjNWNncnJNcjBZc1dwRXlBWDhPSy9WSm9YUWZSVWty?=
 =?utf-8?B?U2dOWFQyNm9ONXl0SkxyR0UzczZkWTZ0TmdtTDMvelJzWnhKblliTEhSNkY2?=
 =?utf-8?B?b3A4QzFncVRvb0xXUUZhdHM4ajRLS1k2dG1JNENOUXg4Z1RlbGorWGtLcUEz?=
 =?utf-8?B?S2FZVFVCTnlZSlI1TzQ4UFZxZ1BsQ25MclB5VnB6VlN2eElFVkIzRnJ2RE80?=
 =?utf-8?B?Zm1NdGN2d3FzaXRnSmFmWW5LRmR5Q0VHUjY3a0YzV29TVENVOVBVZTl0eXVp?=
 =?utf-8?B?NW1YQVF5WjgwQ1Fmd2k2NmZpRXpkQ1l6TGcya1l5OXB5eXZhRENwQ3JHZG1N?=
 =?utf-8?B?VTV6ZkdYUVVoMTd5RkVWSWgyMjg3TXEwdkJ2Y0djcm55U3pkUDdlMDB0Nkp6?=
 =?utf-8?B?M0RNODFvQUhCeS9hc1ZEKzFHTVAwci9tRklZa29tT1B2WldlMXdIbHMvZVNR?=
 =?utf-8?B?eGwxTGNCc09CUGhoK2RWRlJKd3VjQkRPQkk4dVkxVjBuRkt2K2lYajNOVUZp?=
 =?utf-8?B?OStYQUlUZHNCYUdXbVR1eHNvZ1E0Yi9sZDB3c0c5d0JjbHI4amZrb3VFM0t6?=
 =?utf-8?B?L2krN2s0eEVubFFzcUxianYrb0tYTjNyN3RnZUNoZGR3MmFKUERhRWhyK3Y3?=
 =?utf-8?B?TmlsYjlQTkJTYWhtY1c0RG91UlBGRDVWcnlINEVEK3N3ZC9NWXVqWEJUT0dM?=
 =?utf-8?B?a2RBYjN3TFJJNk9QNkpnZm5BOHZ5UG5hT3BCSFNZQituTlVCUWpnQnpZY1lj?=
 =?utf-8?B?MVNibkRxVmpjLzhkcDVjMjhHV0pwaEZlNkZlVytRMFIxTWJDRUZGb3Y3SS9l?=
 =?utf-8?B?YSt1UVZJWTJCRWYvUE9QbktnT0RoRkVjZ0tHL1hnSnNBZm53VHZhOFJ0VEQy?=
 =?utf-8?B?ZXZtaHVnM2g3UDZ5V2pWUEhpKy9lc25FYTc1MndmY0JQWWZQMi91Rm1peUF5?=
 =?utf-8?B?UGlPWjFhT05KeUsyUDdaYWZwakRRb05aRTJwYk40bitzVGtFalFDZXo5K2FU?=
 =?utf-8?B?aEowSXQ1bGhqNExJdW5JZE1jVk8veVZMRUdpUm9kdndXNVFOblBOaStkN2c4?=
 =?utf-8?B?dnVpMHNka2k2OTlCTkNDNGRrZnREZkZ3by9ueFYrQzNrT0hYenFVaFNwOGMz?=
 =?utf-8?B?ejdoejNhSTF1UnUySXYva2hodW11Nm1SOUNWNmZOdnh0aW9qT1h5b25zdTg3?=
 =?utf-8?B?bFM4bGtQRGMvOGJ4Vnh3a2V2RUtaTHZlbkhjRmt6eWE2dmxTWXJuNnp3ek1T?=
 =?utf-8?B?dXo0MjFvc0pUekhQKzZHSy9xWGxUaXg5MkhyOUN5aENXSms3QTA4SVB4UWJ5?=
 =?utf-8?B?MXVneEhYSVFjUHJqK2NJWlJPS0hvMnZrU0VDZEpMazZrNVF5VWxtWnZNckxD?=
 =?utf-8?B?L2VXeXZ5Y0VPMTNPM1pEdzhNbVJVMHRkTVpVY2JpWjlFT1VDRGhLN251NWRj?=
 =?utf-8?B?YnNXa0RwWTZzM0o0VDdjS2huRlFFV3pPUlptOUQ4TW1EM1ltNG8za2pjL21w?=
 =?utf-8?B?RzZnck8zT1lSbFA3MzVoQjFaR0piemhtanRsNFJRWFFieEp6MDdtSzJ0QlZY?=
 =?utf-8?B?c0wzQlJQd0F2d1BCUnNLb2o4T0p1WUlzUS9pK25jZ3RiK0RUdEIveEZPdU1T?=
 =?utf-8?B?UkZRTU5rVThEdmVxSmMrNFVCemVqcDltSU9QbFJFQ0JyT3g2Y3FnRkFZMlor?=
 =?utf-8?B?YkpUZWlJMUZNV0RJZkxOZW1oTnhuTnR5djlwRExTUTFHOFo3UlVTWVdSb3VQ?=
 =?utf-8?B?eDFZRGNjYVVLVVZ3MURvZGNnVHd6eU5GQU41NWRQYXJFeFF3U0pudC8reHE4?=
 =?utf-8?B?Uk9BZlg1cTBOV1dROGhkNUxjUWRUTnlETVI5WDNYNkFXVmhrRFJmdUF4L2Nx?=
 =?utf-8?B?N2xzNzlIY0JxMis3QXBmWGVOSTRBbjF4S3BOem9FS2xjTUFNR2Fud1UzUG1S?=
 =?utf-8?B?cjg1UjFzOUhBcFloUzdOYmh3YnF1ZXhhUkROMWJMNkpZeWl0ZWNEdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df18bfe-5b0d-4d0a-08e7-08df3fd44663
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:15:05.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q37jqAnvxyfG6DEOQKi7tw++SDXVFb9CqQjgKYXdHG//4UnC3jkjwgA51wNeHD45xSClgyZtfW4IzrxOD1gCwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6526

From: Jan Kiszka <jan.kiszka@siemens.com>

Results in missed errors and uninitialized usage of ret, thus random
behavior.

Reported-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Apparently a regression of the 6.19 forward port.

 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 6ebeb3f1f5811..53b1c35423699 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3371,7 +3371,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr_unsized *uaddr,
 	name[sizeof(sa->sa_data)] = 0;
 
 	lock_sock(sk);
-	packet_do_bind_unlocked(sk, name, 0, 0);
+	ret = packet_do_bind_unlocked(sk, name, 0, 0);
 	if (!ret && sock_oob_capable(sk->sk_socket))
 		ret = sock_oob_bind(sk, uaddr, addr_len);
 	release_sock(sk);
-- 
2.47.3
