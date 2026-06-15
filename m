Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B763FC5B3
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534937; cv=fail; b=AnFQjXwwiXdh2ghwZ7WP/1d5ZmeyJAxKFnoHtrwB0G6K+h0sfR+YOhy2+rh8PSw+4+bwI/zVBJNsCJg6s4H0Qn+LVMhb7lwMruu2hlcyju15c/bU8hqHIBUbRP7RweOv25CnQcf3MJFPel0wMFRhSDCg+B9u/Nfg2wky3rJJGtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534937; c=relaxed/simple;
	bh=76vgcpslnfWxhFLEJL67AcYVmu0lsIl9f95ius90kE4=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=cJ8ztftJNioySm4Ibf7weIjozEUL4pk16RaPBNzI3uoHhVGStbruxmZuJn6ojefUhOnZ8bQDf6haOkyussQkop4f2fMMncIPF7JOrX1Vhfqir/IV6itaVb8Sfv5RulCUP01AbRndA81SEtzopq7CpkGAsn2r+O9qRKlFYQRSW1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RgiamI+2; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RgiamI+2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7jituno2mL4JejGih6Wy7U5vc2LevQjo2+o/yYk+5M+RM6Rvut8raIFtN1J/geIjhHqmeY778adw0mODVuGMqudiySDU1y4PK+rKKdmxPZZEUt1Itww5ELb2iJ/Hp32otCUtpBVL0KhdMZFRt4xmSOQsoJvztqB6aX7xRRTiKdmcaPM42JtSbav3/CYnqgWQ5HM64SgOtgiS4dE19ErfE06n8Ne1DBjVDurvT+63K7vfWKMXUFtTYylaaEvvBw3P3lS4KYjWZ24j3dVpPXcCfkkEcm7MORFAZLA7Os1TtTJGM31ZTvDyS+ldLt5mpE681DshxJhpmtQXy511gKxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR351ImjgOuS5yZytCp2hvAodDbGPtxrs8hxdPy+3v4=;
 b=nc9YftfWPTjMWW+tBOZKp74/bx9rdt8g1XrCSoOZgUY7AGAYTVEh+E6Eec11shY0XHlfp1cZt68ug7UfxcN7JMZzrGxBkwhJj52xBkbjstSN0A5vkSzG4oNa1CC2JfiF17J+lT0pc7eXUHS27vPJz3m2LzAOsrp1qhLP9UsI6kpKqskeKRySac1hhgDX5nnGjvux2i/pwTwCuMSD6FdKgfWHaJ17BhB1iPaBY8A/qGFwlM5kuRR+YrQKgOreF3k0gXWRESSqTAK85YTev7kZSjfMzrQwM39ZTD/roDDpTT8vTqrHkL/U2Z3ErN+PBRz+u2dPT0FeFozT15S4fNvmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR351ImjgOuS5yZytCp2hvAodDbGPtxrs8hxdPy+3v4=;
 b=RgiamI+2zweh3z0OpJzPEydKQ5GWWwpcPsqL7nAMEt/xN0JRJh12DX3cbKkgpTROYtsFpsrObDSuyMPT0hBHVmEoBQR6iRz/5fk//VnhoboQ0ZHNR6IZCgs93/DZ1gCx1AlTHtrUz1m9ZmA1JPCz2YKbkUQIqzWiz44bNeoeilNHYkhTuaN2w8hyWY2M5GyiCPAR3hNp/0JiZTXEeJYZ1KtlhM6XDoMM65F+8NKGJqMs9SyUSrOpEpQRgZa9X00i/9EZ4GZfXxd5h3K/LTRXjCfr0RuiFaxp57NBqGuwFpEkuVRtXkR429mG/js4JeoXHXYOvTEFxZqS8YQCFvoajg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:48:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:48:49 +0000
Message-ID: <c38f2b91-40bc-4cea-a515-5fd90f1073b4@siemens.com>
Date: Mon, 15 Jun 2026 16:48:22 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/net: Synchronize on server startup in
 loopback tests
Content-Language: en-US
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e00c88-77b5-42f3-e104-08decaed35d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|18002099003|55112099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	aI7ete0fhHaDgq7ERWUlCsUs7mWh4RHoN1+t/hZa+BYLOlpyhecK4yLhl8XB8AIzzE3CvLBb2V5QBFUMGAP7lvJs/4U8EOJQlh8v0RspYWj0457+l17VAi+AXfvBcgrp/lzNEBaEwb1WB0bJd3oGA/ZxFq86NKsGLMAkv0pYmdDVHyHJ1GCDQhnReP8m65J+uOUZWbqlATkeIDaujEadb8fmdB5L79XhNUG/WQbzlR4jeSXk0xknweJ2T/KDVakS245VvRrzG26Be6q0N0UDejWnwJ1XWWN9rdszrhBSM5ZCt1ywy/cxPrCM0rvs51Ze/pEunXh1tr/oVTNzgu649lPGqk/YOO1lN1/qNJo5VLx5Il0z2tsAIsfwD6MkBLd9mdyseOfrIMUIb5x52b54NlGznRcd8Jz5evm9vl1N6CyY8YfzujfuVbScjr5NBBJIHzwhj5m0VkcESWRuwKSZo5hCoE7qJi2HMhUFDaGEFqFQ6rfQr/lwIzge+95zK8pZtZU6nxCjJsp7TIWsHUoYfZPvXqtQMFutUrOX/bpRqGE8KsQpaetaZ/vwgseMCBLgssYA6cKTEL0fFQwgnlg/06UC/JzgZF9QGMSukxp5Bp3C5Xt4EesaQyWqtumKZjABunPmDPgVZomGobx0nlOQLO4if+7DUTVTJBdLFRQONv2wAJp9xi+nxiT8ZTeJJKQ6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(18002099003)(55112099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzNTQ2djYW9MaEkreFF6enYyZWx1MFF0ejd1NUdRTlhpQXJoVGVXcjR5NmNh?=
 =?utf-8?B?MERFSTZEdlBQNVcvQmQ4RCtNMkVXWXk0S0JyR1lhT3RrdXR0dDVrOXpmOEZo?=
 =?utf-8?B?OFp0bmRuazl2MFNnSXJTZDkwU2hXOVFlZXpJWG1vUHhZMU1UV21pMmJsYStX?=
 =?utf-8?B?OGo4Umc5bXcwUVNZUFE2WVl3RXlFaHZPNXViN0UzTG1RUGRPd1ozcERTRUdC?=
 =?utf-8?B?YjlIaXRXL1VPRkdvbE0va3FXTGNPZko2dkFFV3Y3eG0vR1ZxTkxrSlVoNVJQ?=
 =?utf-8?B?LzFtZWJZajZ6Y2hXdmd0cDBmbklrZ0MyM0tsbllEUVlOTEh3TUQ4VE8waG1W?=
 =?utf-8?B?S2VOZk43RU9OemNRMUovRzZVQ0g3bkdkbE9KcFh2T2JyWU51RWtkVGhMTjAy?=
 =?utf-8?B?NVRkSThPdjRnSzRSdTFSSVVEVjM0MkFPSVRGbWx3QkRlQWFLSkVYUTIvdG56?=
 =?utf-8?B?NHJzTzcrL0tzbXNvVVZEdmQ2cm0rMjZpZ0ZiV3FjNGsxSTRYQnRNU2wxcjJR?=
 =?utf-8?B?NXM0SG1uc3QwTEFEM3o0bHpGbHEwRlYyZ0NmK1BITXJiczFzaS9zVGlONVV2?=
 =?utf-8?B?cmNRcTlXZFJTQ2RGdjdOeFBqS2h6K0F0QTIwc3hYeDdSM0hvL3FZZG8yQWto?=
 =?utf-8?B?WVpjTDkwMGdDUTYyNlI3UjdwZGRDSThCMlJVSEJNRmo4QlFuR2l4eWFTamt0?=
 =?utf-8?B?RExzL0toQ090MWxzbmF5MTNWRVdoL0JoUm1SeCt6cjFOQ1VzeUhEenNsSWxS?=
 =?utf-8?B?dEdVRzBqaGphZnBPL1hmL05oREJyVStTOU9MOXYva0VJS0JEZ3YwOTY3T01C?=
 =?utf-8?B?UzZnVm1zbS80K1NtRUk5Wkc4cG03SXo1N1dnY2Y4a0k1d3oxQzdVbWVhZnZZ?=
 =?utf-8?B?N1d3cGRiKzNOTUtLSHZoMWtMYVBzNERGVEhFUjI4a1JUN1p5ZklVQUJwVWhW?=
 =?utf-8?B?SWQvY0dpVFFxOUFyY3oxVWhQMDVjcUpSYUxnOGQ4WFNTOFNpMnhPMHVubkNr?=
 =?utf-8?B?b1Jrdm9WaFUwWEY2K2VnYlhUam9ic3NIVVZ1VXJ6Zlc0ZGNDMmozTUNvVUlE?=
 =?utf-8?B?VVBQbXZ6cjZyNHk2YU5VVG5HYTgxa2hJT3BHdGFkVG81emZCd2wyb0d2TElj?=
 =?utf-8?B?SWs4UWlneHdxTFpucEdOVG1PVHJlc0djV0RxbXMrSExJWGJ4MW0xaHJ1VzlK?=
 =?utf-8?B?OUc0V25qYkNaRU84QThNeWhHMHdPZUdjM04zeVVMQllXajJhOHBTOHFTaC9p?=
 =?utf-8?B?NGlpMlVZaDZYeU9LbW9GNW5aYS9ZWU82SmQyWmxKSVpOQjN4SE05WnNiMHVF?=
 =?utf-8?B?ZnEwMlhFRXErZEhQbXFpSVcvL3YrdDVnd3J2VU1UcTNMUlhMZGpuSWRId1pi?=
 =?utf-8?B?NUFiQm9FQ3dMN0txL0UvQi9FNmNEMEhrWFFpODBna3htN1NsSFlTTXMyT3dz?=
 =?utf-8?B?dzFoa3NBTTdGZERYdENvMmdXbXJLQyszd2tUc2hWdkc3UEFSRnU4RjRLN2Iw?=
 =?utf-8?B?VlBrVGdLdmJ1Zmp5VXM2RGxSQXlCUG1hQWZpMkRrWm1kNnhaZWtwSzE2TTgw?=
 =?utf-8?B?N0lQQWJRSTlVT1dzV05OMng2cjU4MzAyZU5Ydnc3TWV1ckl2L3ZvN0pjbWlL?=
 =?utf-8?B?L2RMZFo5eWlrUXZYL3ZnRjVkd3Rsc2RZWlllYlh3OERYL2o2aWVUMm9IeGF3?=
 =?utf-8?B?U1E0V1VzSUNwODJML2VXanFzcWJDUkdFeDJYeUU2aXlQZTltQXd4STRmdVhI?=
 =?utf-8?B?dmkwNkJKdlZnVWpWNHJ5NTFLbExYUm1LekJTSytNSUVWV0NBMXFMR3dQdzRS?=
 =?utf-8?B?MGlYbTBWVVNZMlhwWnoxR3pocTBWQWs0ZFZOUHFlQnZPbXI3RWZKNysxcmhp?=
 =?utf-8?B?S2NmNmFSTjZDMzZtWUdYdmFWZm9EZXZ3V2prQ1FKWitiaTRLUStublpNNkJF?=
 =?utf-8?B?SnorZzJCYzFjUUV5bTViWjBxK1p0cTdqMHRMZU1KRGkrTUdjN1FuSVprTU4v?=
 =?utf-8?B?TXprUkdOSzNjUDJsVk5kOVhJYmNlNU1FZkV3ZTRTM0hIanY5UU81Tmd0RmJL?=
 =?utf-8?B?NFNISi84K1hIWlN1STBDbTV1QVp3QjVzZXlEVWFBMWtjMHdvRFUwVmZtWFU1?=
 =?utf-8?B?QWdUOXhneGZQNG1SSFViZjhTRVdPZDNLRGVCS1BZNWpiUXVFMDloSHViSS9S?=
 =?utf-8?B?MGswZnBnQ3lXem9BTHFSRHc1aFFORGlLM2s4WDI2V2diMXVUSzRBNEtzK2dW?=
 =?utf-8?B?NGVYQnI2NDV2dEZoWmtSemdUY3lJOWQyYytOdG5XTmJqb3hMT0x2OVV2ZW5x?=
 =?utf-8?B?b3ZwY0wreVJRbjRXbG5BZ28wSi82Qk5xVUtaYXdJN2d5emtvUFoxTGI1M1dT?=
 =?utf-8?Q?XkiGN22Nj8nBxcIAddLykhqDdEzZG3w1ddNC0jGpnvJnD?=
X-MS-Exchange-AntiSpam-MessageData-1: 0WzLCjbNgFSgWg==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e00c88-77b5-42f3-e104-08decaed35d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:48:49.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLsG3ladGVTP9LW4jMG2L2jsGyXHAhH+YrSN0jpjfcGCJgu5c8zsWcd/CXBdvW9D0toY1up5jlXRpQFBMdBEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4075

From: Jan Kiszka <jan.kiszka@siemens.com>

Do not assume that the server thread is up and ready for reception. It
may very well lag behind in loopback tests when the client is sending
its first packet, potentially causing single lost packets this way.

We do not need this for stand-alone servers, obviously. Therefore, make
the ready semaphore optional.

Related to #23, though not yet clear if it fully fixes it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Another attempt of mine to get something useful out of opus failed here 
(4.7, no newer version at hand yet). In the desired to solve the given 
task "fix the bug", the model suggested that we should try to identify 
delayed final packets, classify them as delayed (so far so not wrong), 
but then simply sweep them under the carpet. Not only that this is very 
unlikely the reason for the single lost packets, it would also be like 
rewriting test results, rather than making them reliable.

 testsuite/smokey/net_common/server.c           |  5 ++++-
 testsuite/smokey/net_common/setup.c            | 18 ++++++++++++++++--
 .../smokey/net_common/smokey_net_server.c      |  2 +-
 .../smokey/net_common/smokey_net_server.h      |  2 +-
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/testsuite/smokey/net_common/server.c b/testsuite/smokey/net_common/server.c
index 42edb0f427..270f813c8b 100644
--- a/testsuite/smokey/net_common/server.c
+++ b/testsuite/smokey/net_common/server.c
@@ -120,7 +120,7 @@ static void server_loop_cleanup(void *cookie)
 	free(fds);
 }
 
-void smokey_net_server_loop(int net_config)
+void smokey_net_server_loop(int net_config, sem_t *ready)
 {
 	struct sched_param prio;
 	const struct proto *p;
@@ -153,6 +153,9 @@ void smokey_net_server_loop(int net_config)
 	check_pthread(
 		__RT(pthread_setschedparam(pthread_self(), SCHED_FIFO, &prio)));
 
+	if (ready)
+		check_unix(__RT(sem_post(ready)));
+
 	for (;;) {
 		fd_set tfds;
 
diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index 8a3562ba96..f4b9693cd2 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -35,6 +35,7 @@ struct module {
 static struct rtnet_core_cmd cmd;
 static int fd;
 static pthread_t loopback_server_tid;
+static sem_t loopback_server_ready;
 static bool loopback_thread_created, ifup;
 static struct module modules[] = {
 	{
@@ -335,7 +336,7 @@ int smokey_net_server_check_inner(const char *file, int line,
 static void *loopback_server(void *cookie)
 {
 	int net_config = (long)cookie;
-	smokey_net_server_loop(net_config);
+	smokey_net_server_loop(net_config, &loopback_server_ready);
 	return NULL;
 }
 
@@ -425,13 +426,21 @@ running:
 	}
 
 	if (strcmp(driver, "rt_loopback") == 0) {
-		err  = smokey_check_status(
+		err = smokey_check_errno(
+			__RT(sem_init(&loopback_server_ready, 0, 0)));
+		if (err < 0)
+			goto err;
+		err = smokey_check_status(
 			__RT(pthread_create(&loopback_server_tid, NULL,
 						loopback_server,
 						(void *)(long)tested_config)));
 		if (err < 0)
 			goto err;
 		loopback_thread_created = true;
+		err = smokey_check_errno(
+			__RT(sem_wait(&loopback_server_ready)));
+		if (err < 0)
+			goto err;
 	}
 
 	switch (peer->sa_family) {
@@ -476,6 +485,11 @@ int smokey_net_teardown(const char *driver, const char *intf, int tested_config)
 			err = tmp;
 		if (err == 0 && status != PTHREAD_CANCELED)
 			err = (long)status;
+
+		tmp = smokey_check_errno(
+			__RT(sem_destroy(&loopback_server_ready)));
+		if (err == 0)
+			err = tmp;
 	}
 
 	tmp = smokey_check_errno(open("/dev/rtnet", O_RDWR));
diff --git a/testsuite/smokey/net_common/smokey_net_server.c b/testsuite/smokey/net_common/smokey_net_server.c
index 5a94126031..9b65d70d7b 100644
--- a/testsuite/smokey/net_common/smokey_net_server.c
+++ b/testsuite/smokey/net_common/smokey_net_server.c
@@ -206,6 +206,6 @@ int main(int argc, char *argv[])
 
 	close(fd);
 
-	smokey_net_server_loop(net_config);
+	smokey_net_server_loop(net_config, NULL);
 	exit(EXIT_SUCCESS);
 }
diff --git a/testsuite/smokey/net_common/smokey_net_server.h b/testsuite/smokey/net_common/smokey_net_server.h
index 34d5692728..c193b00da7 100644
--- a/testsuite/smokey/net_common/smokey_net_server.h
+++ b/testsuite/smokey/net_common/smokey_net_server.h
@@ -26,6 +26,6 @@ struct smokey_server;
 int smokey_net_server_check_inner(const char *file, int line,
 				     const char *msg, int status);
 
-void smokey_net_server_loop(int net_config);
+void smokey_net_server_loop(int net_config, sem_t *ready);
 
 #endif /* SMOKEY_NET_CHECK_H */
-- 
2.47.3
