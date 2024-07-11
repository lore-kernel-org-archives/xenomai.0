Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33479158A35
	for <xenomai@lists.linux.dev>; Thu, 11 Jul 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694642; cv=fail; b=RtNEiJFu9p0NFz5hDCpzjU2DgVXmU/MXuwoxzj5ZbkhHvMcD/Q14GN6xoxTWKlZ1IyJoqT3ufcyzW6MuIRChkgon3Tx8MdlPmwm5Bn+M2lq5IiYfxNctZFNyTd6luxVVMaNciZAMXwuUObSyLrLvnNRo3kWdHLJSrGPAVk6NG+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694642; c=relaxed/simple;
	bh=ZFIVinj5NJtPGjMNinpUAMuGk2tG2hSdYJXmyp+CaPA=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=cc5BxszLyGLYUNiJSmeE34juVRYs8vHP4MxsW/cYbTL9xnl4j5VAuGaL4ICMt/bddF7OeftvRwHWISIYQKIjxwe3r4R1RrvD6grXAEpTgv55xheWzdSVKUgWUCBh49vqUDklBYzCVNIQT+OXFQc65gUKxrUu/weOI8ND1i8vE0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SUCBpneH; arc=fail smtp.client-ip=40.107.247.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SUCBpneH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcNyJlXnDsVVBSdFOemKyXTxFgrJmRHgPJj2/6i9gs3MQ4DvGr84RorN+X3tk270tQthRGGDdQHhYTH3ROKKaNAh7TpT98w7mk2XGuPkMkX06Pe4l8NtrjLqWXM3H4lPC6bvpMyk4zpoeU3Q4i5H/rAWRXSM2dRC7D7p3KUu4IHO9qNs8awHpQ9k2Eo8R1eBEeKeqmdEFOcLNHCk8MX4maKNczGDf3pSCR9OCPja7pplg1yucGY/7LRK5yyQMQAjTwnSnnAYtBP8jO2Vo5/dufRCAom3W/G6NxbW7nbyzNhE79f8dMNIygBR61lClE7T5Enx2ligUzCTptsrchzjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUbKchxl8ifLoQCNPauqtYOEoFG7lztcGqDjPYkPsUI=;
 b=Y1s7AMhQ8JslEuYZAa/puuAQR+DRx3oEweVZ86teUTajshScwDh4xDcTef21ps4zVTexUkYKsbxpUFNSr3Fgo7dWOE7FX8adjluvndbbR7IswdMNeM92BsxWO4crt76m6jZ7qCjJvBpPuWPxK4bzYY2kX46o8eMHpb6NMq9yVFanbLPkGEso2mzmtTxj7nQaquYEsRrmUjbGEFh8YXwauIGmD9FHnFSJMbqzG+wiQa6bMeaXPPqPc3rmfbCJkgzythEuhw/GdC25Uy3nOH/B5B9G9+RHa8XKAVjtOkrHqOqsCcF+ndryLY7jesDa4oj3eXAXd/ZDEuep10B8LkgMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUbKchxl8ifLoQCNPauqtYOEoFG7lztcGqDjPYkPsUI=;
 b=SUCBpneH3hoq4nv/p/4Qqhb3WWbYuQmvdNQ/mQyHjX8qmGmbuwAn29G24sBzqC2DrhlUcZMA5v2BgWRGVHXi2okhvREC6twBsxYnIWd6j5XiS5jJl7V4QNtHJ2BI8Y2Jw1CftjsyJSVO8yJAwMQwD764rmD4bIZotSKOHIeV09Ocgu/CWpN6ncU41OPicV9r2E/gTzRLKxluzuT9ECdTV332M9UDNlMbrxzvc696n8JfiR291cEGASxTZiGaw52HJqzprjr2nK4tU+7nBca1M8mA4WqfkSJY2r+zaCwpKzrpe5sII+JierXUFf0R0Wyxi71Oub/Rps1SvC8UFW3/fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7298.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:606::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Thu, 11 Jul
 2024 10:43:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 10:43:55 +0000
Message-ID: <fb910f94-6719-462d-9be4-3be7f6755c4b@siemens.com>
Date: Thu, 11 Jul 2024 12:43:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] Account for close_fd renaming backport to 5.10.220
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 23286fcc-8c03-4ab6-b35d-08dca1965d12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q291c0RHSFBHNEdUM2N6cHhOeVN6eEhxMnZhMHg2Qm94WnhUY0tzTjBmdUsx?=
 =?utf-8?B?VzJDUUtoM2tHNzFzMWphbjM4Q1NpS2c3MzlxbjRGdExTWUlGRXp2LytDNUkr?=
 =?utf-8?B?b1p4TE04SGczdTJZdmtJL1hJOHhLUDE3WWJENm41STFSeUN0NU1lMkJUWisx?=
 =?utf-8?B?KzFHYU9DTHh5YWFVaXA3R0ZJUmZSOEJXY0JocWpleUdtL09TeU9PTmtTKzVH?=
 =?utf-8?B?R1Z0Qmo1SUlpZ3d0QUVTRE0xeDNiQTl6cEhJZUJLZWcwSXk0aHJaZDFsN1pn?=
 =?utf-8?B?NGtYci9RUVVnT3RXc3VVdkYyY0RRVEM2d1l2SHhCSjVNT21pZG9kOHBHa3Mx?=
 =?utf-8?B?MjF2bTB0VE1VYnFSS1VNdWNhY2VXU3dxVkprOEtJWTRWM0o3UGs0R0RjWmta?=
 =?utf-8?B?bklReUFUaVNheWFTbm1QdlBZRTdtQWJkN0VQOU1DMUoxZW1hcDdkQXJwdDkv?=
 =?utf-8?B?YWdxeUoreStKVCtlejhUQXlvZmROemxSRWRtUW1QT05pVzk4RnA3NGdGUUI2?=
 =?utf-8?B?VmgzNEJxUWJNY2NmUjkydCsvVy9oL2xwVjBHUksrWlNidFdPR2x2aUhaNXgz?=
 =?utf-8?B?bUNPOFA5OWxQRDdqOTJOTTZIZXFwWktUd3dhb1c5UlFxd0JPTVBiNVdQUXVP?=
 =?utf-8?B?VWdGZzlINXZvajFDelNmVHhtQmFhbElmS3ZFS0FKOUVyTGRrMHlJZzlSRGVi?=
 =?utf-8?B?cFlSN1hHL0lJcmJPZ29GVyt1LzZrQjdmdGpSby9wUVBoYnFDTEVsM0hQTjBu?=
 =?utf-8?B?a1hudDN2SDhpODlzdGg3WG5GYVJWT0pnNG0xbHhNODk2WUZ6SjJvTnNVL2xL?=
 =?utf-8?B?OUk4NzZIMy8xTG1vQ21XeW9pMHovNFpKUkY2dXBESk9RWWREZy9oSytVa2d5?=
 =?utf-8?B?WGE1RDdJQ0JnTGM5ZG0zaS9pbjdLMFQ1SEc3cWtqOGtlK0tqdXo5VE5sNDQ2?=
 =?utf-8?B?cFZrZ0sxTlZRTURXaDhVRWw0ZGxjS1BnS2tBWlRYaDRwaTltaUZTUHJCTktR?=
 =?utf-8?B?akVZOWpqK2ZlYVFVV0tpUVQxN2Q4NnQxR1NJMWdYLzlIRDlxMHkrWllzMXQx?=
 =?utf-8?B?UDJVZHJjY3d4RG5mN1g3UmY1SUZMU1dNN3ZPbEVRdDZQWWI1Um9OMDdxcnNi?=
 =?utf-8?B?QkRHdWk2VWdRT3V4SnJkZ1ZLc3VFK1BuMHdoR3Nvc3Z3VXZJTmtZK3RRREgz?=
 =?utf-8?B?b1FISGtScWNBb3ovRzhPMFRaSzZJVXYyMmppS0hjYTg4bFRRQmpGTUdVUVI5?=
 =?utf-8?B?VEdES24velV5WnN2Umt4QXA1VjFFZ1BZMUt0blBEQWJrNUlva1JjOTZJZG0z?=
 =?utf-8?B?MGd1UlUyMndPY1RnTGV5THBaNW0yZFZMZk5KR1hJRnVyaWxFek1SU0xORFcz?=
 =?utf-8?B?T3lHQkRINTFSMk1RMkxKQ1ZXWUc0dU93MzlHWWpqRzQ4dXd5ZEcyV2t2VW9V?=
 =?utf-8?B?b2lUZDNQU0xjSE5PUUhLNlFnOUJ3b29VUythTG9Ialh4MFhMQ3FZQkxOdUhO?=
 =?utf-8?B?WkdQc3A4dWxEbFNFdndyZUtKcDJJVzRpUmowbVBITGN3QTVBT3NUVTBUdE0z?=
 =?utf-8?B?RnNPTXJKWnBmVHpSM3RtckYwL2xtMGpqTmM2b1RCc3dabTBVYy9ZblNYNG1w?=
 =?utf-8?B?Q1ZpOE9CR1lIUFBqMjZiVnBvakJJUmxNZnpkQ0RsVjhVM2V4OHc0WlhDRXM5?=
 =?utf-8?B?RGhibnJjdHgzRWlVa2dZUFdPZkhWUzhKMGErL1hqMDIxaEMxVUZwZE5ibGty?=
 =?utf-8?B?TWt3T2ROQVFFUG5HSjU3RXZ4R1c5SGNXQzJEVHJReVF4SGx4M1hESFBLeWZZ?=
 =?utf-8?B?Y2VaTzRvcXFRak9vR0k5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnVrT1ZmRVFWYkY5cVNlR0kweWpHUlFUUERPelhOZkdON0FKaXlHblZMVVVw?=
 =?utf-8?B?WE4rRWpsRmVRN1J3TjdYY3R1NDY5YkI3czRKK01MVzBSRnNHbnU1Mkx3clJ5?=
 =?utf-8?B?emR6Rk5TNlZENUJPK0NOeEh1L095RGs2WnlXKzJnV2tQcnZ6THFnQlRHVkpi?=
 =?utf-8?B?RWZpMzRBWVZoTXV1enUySEJiVFIzSUQwNHpralZwV3RNdnJUNVNTSE1KSHh2?=
 =?utf-8?B?ZnQ0RVo4QzlJaUhBaFZzWHo1eXhqeXBSMVFHT1BOT0JjSzhJaUNBcFJXK2lQ?=
 =?utf-8?B?SXBwNGFGK3NZK09nMHNteXBQOTE5ckQ5RkM2WlFRd1pRMk5pWC9ia0VkME8w?=
 =?utf-8?B?UTBIaEFPM0FxL0JlMi9VL0hPVldQaVlwUzNQUDdESjNnYlZ2eXdKbW9BeVNt?=
 =?utf-8?B?cFhVQngwN0R2Y3pVUUVJdlNTamNtUmRBa2pyWWNabk9JVXJoeXF2ZmR0eDJu?=
 =?utf-8?B?d1UwSWsyTUM5R29TZWdIaWlaRHB4cjY5OXBlbG1UZXpTc21DQzRhbWdzSDRo?=
 =?utf-8?B?VXFIWjNOK1E2WHNGTzkxckg3UENPOHN3VU1GdTBvS2NXVUZHejFsa2ZtYVNT?=
 =?utf-8?B?MmJ3K2NOUmRxUTFTR1R5dTNQbWhIUGxzeEtKNU1IS2lwSFN1a0xPTkhTV0Mx?=
 =?utf-8?B?R0VUckFWSVkwSGU2WmNxYUozWTcvSVYyMHB0Y09tRk1VcngxOWJ2ME5VdEdq?=
 =?utf-8?B?aU1kcU5pSGJOZENMenZ2NU1WeVU0aXdYVEhOdUREdEFVNER2WGRqeWZQaGts?=
 =?utf-8?B?Qjh0a0Y1V1JqbXFuQkVmYjRXWWNVSHFZNEhBekpRSm9xOGowZFp4YVFicURL?=
 =?utf-8?B?aERGN0RPNTB2TEI2aDNHRCtOTzNOQ3M3V2NUa0c4LzdMTW9rUzdGOVFybEFs?=
 =?utf-8?B?NGU2TnhZdlFpaUNLR2RFcDFMMnYvd1hrOXNpMmFtdUkxMkdQZDVWQzFPUzVh?=
 =?utf-8?B?aVpEaGV5RjNtTGFBRUpCTmFYZHhBb2tyVWMzU0x3M0dyMko4ZzF2YWRaWDlS?=
 =?utf-8?B?UlN3U2lkOWp4Wi9FbllVTFNGRXNqYnU3WDVMY0lFL3ZmZFdGd0JFcGROOG9R?=
 =?utf-8?B?OXFqNXpqY3hGcHB6UXczbmd4eEhQZEQ5d0ZZM1Q5THFOenJtSkh3bVArcmQx?=
 =?utf-8?B?WjlvSGVmdXZjNURjcXlubFhRZnB6WFhhcHpUYndNNC9iZytLelVuMWlpa3Bx?=
 =?utf-8?B?R0YzOTNqa0FUUElkS0dzNjU4MXA2cmF0enFpQzVIN2dWYUNaYWhVNUF2bU40?=
 =?utf-8?B?aEovaXIxK2E5V1ZldHZjVEZLWEJiSUpwOFZrSTFJVEF6WlJDMXNSa0c1cE5l?=
 =?utf-8?B?M3dxVU0ydkt1a3BhRlg0cTE4TkJNZXdOWG1EMFh2RXMycnpla3czMXpCeElw?=
 =?utf-8?B?SThVN2dLUjVWdjdhbklJZmhxRzdNS0hDMXd5TG9TN25hQkNwTUo3bkNKWm1G?=
 =?utf-8?B?R0FybWJ3cUZlMnJUWkVsUEJRM0hUSXJVWVdLWkhOKytrSnhpZk80Vzl2dU8w?=
 =?utf-8?B?cmVjSVJnN2RaK3JwRWhrejdic3g1L2lKWld6ZVkzSVQzOTVwZkhTOVJjbjRu?=
 =?utf-8?B?VHM4V2VMSjljL29meVhWZXZFUUJsRWFNU3hlaC9NK2RDSzB1RWkvb0NUV0tS?=
 =?utf-8?B?MU04aXEwZklaUWgvelZEMGNyRDY3OVlxMHI4RTdaMkQ3UnJVL0VzWFd2QnBS?=
 =?utf-8?B?RXFuWE43RXpEYnZubHhmdWpLRDl4V29XMGxDTUxFRHFaaEpEdWdqdkRuTjd4?=
 =?utf-8?B?R2t0d3UxODNKK05wcG1oK2NpWWErYlhNNmt5T3NlZzBCODVRMHV4TnQ4ZFlK?=
 =?utf-8?B?TExyYmFPVzVuNXJTTVAvNHRxemtUaEZ2UnRtNmNNamVBOFh1VGxYMVRiM05J?=
 =?utf-8?B?aVAwWE05aS90UjZ4MDJGZ2dNMTV5TTRlbTZTd0lvemJEL21rZ3FQSGdwVEVF?=
 =?utf-8?B?c2VwM0tKS28zK0V1dHh0QUswQ2hsR2xqejAwTW02T1hlWVNBaVdINlFIaFdO?=
 =?utf-8?B?UmRialNuQlFUd1ZHSFoxbUNkSUNlU2JxN3ZEaDBQelpLam9lcnYrbWwyRjBn?=
 =?utf-8?B?M2JOa0U5aURqUmR6MUZWT1A4aXVKRDVoeXg1R0tCR1Jleld3UTBDbTRzNVdN?=
 =?utf-8?B?YnJRaXdVcVFCVEtoczhIeDVzYW4zT05kSlIxeG5MajJ0dkNmVzhIZ1lGb0Mw?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23286fcc-8c03-4ab6-b35d-08dca1965d12
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:43:55.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0WYUqETxtC+C03stjT1VWT2WWjW1DxiSHyKwV+6JceWGPnpbXDSTP77w34KFXEsP6oCfzfNBy7cl9S3DiKuUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7298

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 9316c35d8b..ce995d2cf1 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -50,7 +50,9 @@
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,14,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,14,0) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,220))
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
-- 
2.43.0
