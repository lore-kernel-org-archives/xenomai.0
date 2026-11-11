Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794414714;
	b=jpWaWE5YYG8tfivUIBOVYoRkVbyLqkztXIFh7M1fftbWcbBSGXwtEa/XCo2l1EvMVzSn
	 mhhD3MGtKySZycr9RmjpN7DEb+Ij+3JQvcn0RO7j7FmoZxe+JXcuo0t+Vx6rvtnOn8Lip
	 P8YC17r+Zhm6KEKOy1VYYZ7D1UED8zObl+B4gZqR6yV1X1jA84USdXhHguXvEvqDmpo7H
	 tLlc7vs/s7vMvlaWyIKrKnvb6bo2L7OhgBYKq9y+TdQKfpWdoPoV4whb2xlDb3KGWT3M3
	 qq+LSMT1+wdSbyAMNoEqsChfX+lcilzFmTUrmmLupA9P4j55tTOJ7Hl71Ywe45S/rPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414714;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Cc:Autocrypt:Content-Type:
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
	bh=Gq62nSLzLP0fZ/xG/L6G/SCwD0v5+Ssk7Io+A4qGS5w=;
	b=v/DHBqp5RVLe5JwA2/p562k6M+OcXkfMACalXLho+y9z2X5FeXQ/oqdD8WeHXd7yzN/t
	 l9WGpSVF8nCcxKe/pqtBX0GUaSJatRVUz00hfh8fvNY3vP03R5N5m6TPg5SzOXwhlcarI
	 hQPiuzoUtM+vTxLVE6EwCI381j1MjCDVyglwq24jkUtAerf2E50krYgYspmM5DEu9GT/N
	 baVMu7ryAAved4gT1+seTh2NiB23zF2HzzpX4O8eSq9tY0JV2jLWEEPw1sOnykyBpi2km
	 01g/J/0pd6F7dF75CpJW8iG9hZfu8RiFZUWM07DhlblgD4bOUYp3tqFywjt6H7hTQYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yyi2hyiX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.22
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE7606A32A
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 16:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DE7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yyi2hyiX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGW21LTYm5i5Bz2VpYaMWNQQJjdi2AkdVfRvAWjCpootYLk1E5pNyT9ApwWrpqCCZuTHEpLnXzcvxv6qqYilOqeqIc50s7QZch6hJt+mFjKqNJHHRh90ocPBs4RJbIc8eXJ7rhNwJg50CyNaQmcVQX+w0hsxkwAmpIzQTahIOpbt2ugL6s5Sihv/nFusCjqJNEz0BQJnQDdwAR2ZmCUuirnw2Gw2IEI8ZMEA+A6cjhelbVHpawjLrcGy4rw4ltSZcn6s39d/8Tq4Lgs6llnL/tCo7+kni+iMhgauc5EBdCHs/1JMzHK6gOAhfDudyVZD90dpmugJKnt5YtGU5zT1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq62nSLzLP0fZ/xG/L6G/SCwD0v5+Ssk7Io+A4qGS5w=;
 b=H0lk3HhPNfZJckNyDWIgJ6ZXkEvYnnAABJCSx/Rec+RKyIaKZIptK2FlOjnPpD6vbp6m3MgfBW2R8nR2Gq6MereKjFcDG4rfr0k12NrCbbh19lwpNSE02NtyOUthQ1jdj/eD+42bOerS+0JeAuWoN74yeQcMQi/ydaBLpQOj6TqnJbyRkDRs3P8liNbwd4y2R4JPbDqM2TFdJQfJX0GXTpDJl0nUW+WwpzWpO5O3v91RA8rG5neJ674EJVk5rAbG43+zAWbEeejbXIYD/XhvpI9OCiHWsDZV2lZJJwB/qxBXIkMRAAqGcmCPbJKL7Pp+tgdvtK9cE876D37WlHExNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq62nSLzLP0fZ/xG/L6G/SCwD0v5+Ssk7Io+A4qGS5w=;
 b=yyi2hyiXxLZflaQNwxvuWMvLoteXqgMHK/RKq4tf80Dmoqcd551Hk8QBoFR+G7V5S6ZWizlZ2Olx0fn4RgbGs96xwnveNkNlYVTkHhG7bAgsrN30Jxt5sNaSrOc8asJC5g6362Z1iQeqsxHf+cW6AqiiIeA+Ff7H4pBvWSMMjzxqxtHsUkEkxCtaI8aQjwmMlJSMO2GiwDY+PoXeJ1cY/6Hp1O4AIgiB763IF0ivPJB+KHSgtKE2n0ISb6IhtQyG3INhSC/kR1qvkVRtjD4RJxB9i0mLGqo5uOh+zzVsmdwWSe5mB3cdFZp2PS8T/k6oKu9zZDWLb3Iek0oychfDNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB6569.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3d6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:31:50 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:31:49 +0000
Message-ID: <ca829aa7-2caf-493e-be78-e5a97e624e0e@siemens.com>
Date: Wed, 11 Nov 2026 17:31:48 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail 7.3][PATCH] arm: dovetail: Deduplicate dovetail fault stubs
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0130.eurprd05.prod.outlook.com
 (2603:10a6:20b:497::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: fc49814d-c808-448d-3c22-08df40114936
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261102123227099003|11063799006|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|56012099006|261022105027099003|261026140227099003|55112099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	E80L7LNXdWWbfkquSEudjUBjXKL1MtPCCKobkKCi1J+B/6Suub2nDNko6ida9X9YBvY/AIlR4n+nUHzRGkCTirNZ/yj+TiScd3d6KSo5yZo3rf9s+yDtujyL9wF7N/Gz3FM5XFyksPF53N8eF4nms7h79kZ/Idh/fFfQB/6Qt9vAa7igVftCJavy7+YBKl3i4tEyAP+G2fHocnGgLo9UBKOCdmML99aHDqbl4o/LQngUBAEa5hIjk3i9KLRWToR0wh9rRs3nq0f9lSawJ3b6oDjlNy0qbWnaN6YByWC/uL5ZWWbfeGn+LB7jVgvVOIKSWoZwFrzN/nZ9hCxWmsSBJkiaEyW1LER8FgWHHFwJSdu1g3hxCmdk+qEksbjZzjJOMLmpQLRSiGxXea0Jm7UsojzKLZqD36ONpdMbn0rix2sjrQrqLNZyGhTLn+iO+uj7+nmuD2aVIistlVT64Kq5ea9YYUO7obHMFAn8xDqEVD3Oh2EQ/v2DBghmNIXL2b1KCk1Is2G3Cs+OF9p7E7Atbece6ac2NOkomXOmutv+E+bQtxVw3PBPhe67NH5VbBhxzmZevIyu8mQP+a8uqOfh90Sb0HcAzinX4irdhCx9zPKJC+QemN7WfKjxkD9H/K3sZBdUZ3WzXLlUiY4OPCMYMw+2K5+WSM7YBHeLSb1sE48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261102123227099003)(11063799006)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(56012099006)(261022105027099003)(261026140227099003)(55112099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1VoTUZMZkRvUVNKM3lBVWJkT0ZqaWVsejk2aURacnNoQk8rRkVsOG45YU11?=
 =?utf-8?B?NGM2bmFzM3JJa1BLUmhFcW10SlBGM1lQRitHNlNpUUFjaXdRbGdvVVM0Sk04?=
 =?utf-8?B?ZFVCR0E2WmNNZXo5RXZCMXVJWjhvZDk1d0MrQm5mR3U3MGxldlZRejhrbGFl?=
 =?utf-8?B?VXIwQlRoQk5hSEM0bWxjaFRwNnFBQjhsTTQ5Sk9nSGVuWHJUMXBaUHlLY2hk?=
 =?utf-8?B?cnVmQm5GSXk4aWZTMFZPRGhXUjU1OVZpMS9rQytHN1dESkRPMjBQaDV4bzZr?=
 =?utf-8?B?OVlQUjM5OFlkRlVjam1FMDNhMG9peEJkZ0c0MVNCVzNVYWdLN2tmRWU1eFR4?=
 =?utf-8?B?aEg4akxhQmp1N2pYdDZHR0NCWEhNR2FwVmZpblVGYVl1RlhneXQ1a3lQczVU?=
 =?utf-8?B?cHphT1Y1M1BaZmx3eDIwVVpLOVdzTENFckN2VGtIR0tiTVFMVmJGSCs3QVds?=
 =?utf-8?B?NFBTNXlPSzFIWm82UWFCM2o4V0RWZ1h4VUtIbktPZVdPMzdJdittUXNFY0pp?=
 =?utf-8?B?VVdrcjRiVjlFcC8zY0NBeDdnbi9JOWRqbGtKdkhhRURHekFsUXNDV1pUdUdi?=
 =?utf-8?B?NmRwdzVYOGx6S0gybktUQTZ6Nmt6TnVBT0xhYkUvL3A5aVpnZlVHV3NqRENu?=
 =?utf-8?B?ZExzd3liVnpUSVdicFBDWEtibVYveWorMXNrU2R0QmtuV3RUTXZhdlNCTVJo?=
 =?utf-8?B?L2hRMUxrQk8zRWFWQ1AwRFB5NzFUeUhlODN5OFVvL3hLckxmcVEwNjZVYlRD?=
 =?utf-8?B?UWNSbjk1MXBMWkFBM3RtODJqUHMrM1RCbGpWMHN3SjErRHpOdmt6aXU5WDl3?=
 =?utf-8?B?Y3JjUDF2ZitNR3JjYmN0SmdvZVFTTEdVM25wWUlnWHNLRmhxaGN2bmxjT0VF?=
 =?utf-8?B?LzI2bnRkNUMyR3RmWlBvV2lKVWxZYVNlSU5mUEZvUVZkYkoxVlQ2RFY2WGdN?=
 =?utf-8?B?NXBDS3ZYdkhxbjlYd1BxQm9MWDVzOWltMGtVTlFwbHFEdEd0cUNKL0d0eWZX?=
 =?utf-8?B?RHJuVnA0cXowWExqaE9tY3h1SytZYXVNWTlnSzFZTktYSjBsdVY1NFVJR20x?=
 =?utf-8?B?WTcyYXVNOUlDbml5b0NKT3lKRURzZS9zc01sTE9ianhGU0pYTWdyMDdoZkhL?=
 =?utf-8?B?aXdESUdPMmlTS1VNMnZlOXU2WHFENFJJRVlKdHR1UkttSWxSMnNadHNjcFhz?=
 =?utf-8?B?c1MvRFlkb1JHdEhacHlkQ3B3L0Y0aUxEaVIycjRuQ0hjL2lYQzR4L2F1Z3Az?=
 =?utf-8?B?enduRFd4ZDZnRk5wUlJHTzR4dzQ2WS9RbFd1U2FlMTAxSmRqSDFMNm1TMWdV?=
 =?utf-8?B?eDhvbmdIaTFDQWlFNUxHa2NRa1oxL25zME1lRzJBN3BmSWRHTnhLM2dIWWxP?=
 =?utf-8?B?WFFIREhIZVZwQ09Td2FyeGtManBXRUNkWXZUQXpybzRHUk1hazJBT2VQbGdp?=
 =?utf-8?B?UXUva0tyT29uYjFaUFRKclJoOVRaMWhKSXo5VHUwUlRadGNhQWdsb0JQeFFV?=
 =?utf-8?B?OWN3Wm1DWHIyVVA5bUowelVMOEtWQ1FsOHR4WmorSHc3dTREdEdnQWczaGpO?=
 =?utf-8?B?MHhkOXRVbnhmNGh4aDNWK093aTZCYTJkdVFkU09wa2t5TXJ2TDAvb3dhMElZ?=
 =?utf-8?B?OHNLenBqYjR0R1I3YmdDTjQzanJTQ1VVd0lmZGp6RmQwK295Y1lYd3NTejcv?=
 =?utf-8?B?cjUwMDE3WTF6eEVQU0tUSlFjL2JlY09vVXR5NDhvTU9wK1JrUE9XWUUyaGFm?=
 =?utf-8?B?alVKSUxiaWpHSDlySWFKaTJ2NU1lclY1cExTSzZaKzNZb0VVcjREemV5YzFV?=
 =?utf-8?B?Y3JkbXVsNlJINXZBVUNEdzZWcmwrOWtKR3ZDYU5TZ2tlTU1Fa1FpajZyQVZr?=
 =?utf-8?B?MnJacXk5V0FtYklFaXNkbnpBZldGZjhidE8yalR5aCs1RGtkWjlpOURkUms1?=
 =?utf-8?B?dWJDYTVTaStoaWZicGRHeitiNG04QU9WWjRWYjJhUWVFYXBVY2VvRTVkRjFm?=
 =?utf-8?B?aytuS1cxTDhoZDBya0REL0MvOWZPWTdZUUFyR2RzZmhyOTZkNXR5cDFrTUxT?=
 =?utf-8?B?T2N2ZTdSUkVzaFh3QlRzSWxKL2Y0eVFPRmtoZWRaU1RXMXFIMERiK00rbGU5?=
 =?utf-8?B?S2JFUW83blQ0cTRoUTBnM2pPTlRsREtYb2paTWl2S2M2amV3cittTnBiSk51?=
 =?utf-8?B?TVFIS3hUbW42WGlDUlZnb3dZeFZqei9LeWs1QnhGRXluNzlGcXpuTHFZL1lJ?=
 =?utf-8?B?KzNtcWdrckVkOEtISVh1MzNyOHV5VnR4Nk1pSitEZjJPSGtjMjc3NEt0cmtu?=
 =?utf-8?B?MFFGd3JNd2VRWi9uekE3VmtuWXFHS0g5TGNsTTFqQTEvWTNlbTRPUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc49814d-c808-448d-3c22-08df40114936
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:31:49.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgntQ1j/pIUJOvxMec1fNzJo3re+lfL+wzNcXEem+K1LpXaSFyFf2wPbknJ0FrId+CjpK0qGP8VGrrsx5fSfbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6569

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

BTW, the backport of these to <7.3 went wrong, or 7.3 was fixed up 
without fixing older kernels.

 arch/arm/include/asm/trap_entry.h | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/trap_entry.h b/arch/arm/include/asm/trap_entry.h
index 2af401098cec4..a332f90d8843d 100644
--- a/arch/arm/include/asm/trap_entry.h
+++ b/arch/arm/include/asm/trap_entry.h
@@ -5,8 +5,7 @@
 #include <asm/dovetail.h>
 #include <asm/trace/exceptions.h>
 
-#ifdef CONFIG_MMU
-#ifdef CONFIG_IRQ_PIPELINE
+#if defined(CONFIG_MMU) && defined(CONFIG_IRQ_PIPELINE)
 
 #include <linux/irqstage.h>
 
@@ -55,7 +54,7 @@ static inline void dovetail_fault_exit(int exception, struct pt_regs *regs,
 	hard_local_irq_restore(flags);
 }
 
-#else /* !CONFIG_IRQ_PIPELINE */
+#else /* !CONFIG_MMU || !CONFIG_IRQ_PIPELINE */
 
 static inline unsigned long dovetail_fault_entry(int exception,
 						 struct pt_regs *regs)
@@ -72,24 +71,6 @@ static inline void dovetail_fault_exit(int exception, struct pt_regs *regs,
 	(void)regs;
 	(void)combo;
 }
-#endif /* !CONFIG_IRQ_PIPELINE */
-
-#else /* CONFIG_MMU */
-static inline unsigned long dovetail_fault_entry(int exception,
-						 struct pt_regs *regs)
-{
-	(void)(exception);
-	(void)(regs);
-	return 0;
-}
-
-static inline void dovetail_fault_exit(int exception, struct pt_regs *regs,
-				       unsigned long combo)
-{
-	(void)exception;
-	(void)regs;
-	(void)combo;
-}
-#endif /* !CONFIG_MMU */
+#endif /* !CONFIG_MMU || !CONFIG_IRQ_PIPELINE */
 
 #endif
-- 
2.47.3
