Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093DF1DE8AE
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939164; cv=fail; b=DQx5q1qUqweYE+0Jjjb8hsEDUeTAC27sULn0ywML2cKgSlmWCwRq5PKuwgzCzzV1hqm+X9p5RoPCk0kVjyWh6Mff5ERLffsGsa2WNkiQ0Wip+ssFVvj7NwFNIn/vQf/9NUafgqkAXQ/iy4S5009sP8BVfF5i/k9/T79XcayVW5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939164; c=relaxed/simple;
	bh=/4UZ6HBetyGObsVJaukLu+9Q0pJl2MzA6OrmkNO1B6c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PBcVsF37IdOpR1hHGwiS/K5WmkUXa2jGsFPOHuz8a8LRC6k1i0gV8cboWiZMWVzbegAYeFqTc7T2ydx/8rsBlvoMvXQTevneQ3J6dxf8jmGQV5xg8ZnTR9cxFI6pM83y2F9MiJisT8qg1Co4T8bw+OxwDeJWo6stXNeyxLOsscs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DbJchIL7; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DbJchIL7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0ZGt0bcMBfYfix80B6A6zO/ri5rlfBCht9MNJrE7I/4gAWWrUNcs1flxIj+BXd8UE9fZk5t7Su72mrh178aBXHel6iRqxXf1MqUw1vAP77E012QjJj9o8lKzBIdeXORvijbM/Vi+QRNCe+QtD4vMM5cyPvGgdrXgU/ArUV+IA8N+7BCNcU0+C6RXLApMjQ1YxDTnqFjtlnRpkzmadg4x0QrrP2tGtLJL+Lv/ZDShRbWoFFT+wf0jIPYgwDWRggsVkuMJGd2svLCvo0RwjoFbILNIAV4zdpE2tDRRrNl5YPBBTgdqwkMx8+wZn5K8osi5c4cJv4XHC1CHXPriLFB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psmIj7VKE7ex1ofl9CxnDMGidFuUK9KdzA4jkAqgJK0=;
 b=vAKfCdALJxIVTroHuLE+CCJ4dv8lJ8SoLUS79D+og7uirQqo4quNaNjZWdhvgvJ8K3SK3xbYAER+PBh3ojanxJpEiuMq+jw6tNWhDdNVGS5bEBGi58va9+QLNCYoQ32Ee+PO7Ftg8xPR7GANzMExitxoXyfP9x/ZwqTkkgmnqculfJYELK9R4noE5fDNfzCsWjq/FOfO3FIW5LdOr3FCpd/+5ghvZ4wHy+6dY4g3BvRibdUAIL+6ftus2CxM6VuoH/5p4GwKxYz3YW50lKpj3ohPJRS30Em/nAsu5NiJLf4YupmRoTf3hI/dzrbu3ULEE7rMTO5O5huLx7dVHoO75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psmIj7VKE7ex1ofl9CxnDMGidFuUK9KdzA4jkAqgJK0=;
 b=DbJchIL7OB1t0GayXgPn9FAA6VnShWMTuhD03WJsOoDXuM8lyVdTsK4ZSfXSatXOKEsYd+9camh6yDx5lyxfQrxXk0YxF2Im6L2QQvH/Yh4PPzt21Ugj3ZJjP9Wk+3xYtkSbCPQ6AD/bgxC5TdlSOGDEtgeYOlmjEVJAXvyKNWuRRRxLPT2E0+WTJhdPDauLZoeN7+ye3n9vbP0LMnnIR3Aw8K7lJGO7STZGcQa3PtmcuD1iirENX9hnjiI6Jfd/vyCSynlwU1npzAMFsF3fOdLvhrbvhuLWvME8RUOvXj9wa+21U8VydUKoReA8LoAgYg8SYc0YM4kKUCS20GRkOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB5931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 10:39:19 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:39:19 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl] latmus: allow to disable max latency abort with -A 0
Date: Mon, 13 Jul 2026 12:39:11 +0200
Message-ID: <20260713103911.34666-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a90c762-ca23-4161-8dab-08dee0cafe6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	9Osvpjt35DlXskgRCkerkeFEiyn8pDFSqrSMvvpMSui6vl0m4rA1At1pCra5APsM+ZeY4ly3uI7y7k02LAs7DYNFArtT0FhE1w/0F4zM3hrb+DmHYPLhsZKR1XS8gaAe6dkNL4DK1/dVYffsbtP7Mi99ydm6wm6PmYrhspwvBJnrAoP4j4LYmFXRq4lKK6fK/ewlg8x3QUkXXqLUBAE8/yFe5XOqlyPQxz1a6YBNCbA2XspDJnL7uwfsfNHIVlkV/I7NNkgDo4s8RUJDqeUf8Gn8yYQ4AR6SX9DRXacEh0cJ0prDASVLvSR2Vt3OwxN1J1dUM632Hm+z6rCvLyG4lZ/OV9axfm+njg5CgJNGsshFnvuJiz29oFYSf7kcazli0UIjIOSBMhBIuzZEA1GwRqAHhmTy/i+UuZUIdIQKmXDXD51mpVoESgIBrBzQvQTn+OGleBH6+zrGmXVij1G7WQRvH23JW0dVgK4pWb9ceTx7mFs5zVKtfsylrX/k6tzdOsIkEy2CfGs6vSkHsG5hiXRcXboHKcB498ZdC4MlaYaDtAEObP2E73w7CO780DvR+4FNWcsoW+KaEDOID049BmKWMVgJZVfSVHgW9D2mG9pQzqKvJh6/gPjIc5y0zaokiuFJTiHVsePSgYJvLcm9g0Hi4hym+uX50l2OA6oCPWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYyXelV/L4KcJreluy/ITwA3rROF2pZjX23y8oN+H4P9cc1XDRFK9iFf+uIo?=
 =?us-ascii?Q?LLWzm9dU13C4VxDZkEB1Aeg6m2kkb9sy1DtgEBtKvDg3WBAeIDudWts59nAI?=
 =?us-ascii?Q?ZsT5ObTdo+u8bf/3WD8vPTrWTy3cPq25CzeSOwMYiwTEvmk0MUVXVIYJg5FO?=
 =?us-ascii?Q?s5oU6REFkmWadtRSrlRfjmHCSchJ+L8GXnSIKhol7hgsFwMcOZegOJy/cA1l?=
 =?us-ascii?Q?GeiyzDsNrj45NcJl4Hq6slYxvRLSsORaQplQ/wPg/e1K2SIphUy8K0+SEgrI?=
 =?us-ascii?Q?ASLgjv/pH4VtJTxodXZZlakNVXqQ6vjx+LlG4rCeDNHEPHikhFvFSwo3ErT2?=
 =?us-ascii?Q?LybGyOoauMCXbWhkUqSbpIqXlxR63DqVAZ3oFrCRc3x7G2r3PGDAVxiJW9PY?=
 =?us-ascii?Q?U8YSKONB+kYp6M1DAoKWrUnIW85/iB66OSVeUAHVDs6sD883UScvlELjwlRj?=
 =?us-ascii?Q?fhihHnw8uS14MapoTnl6dM070a/w0h0gTMEOY+l0V+aEsLEnde3oJZnPsF43?=
 =?us-ascii?Q?j97m+6DgHAmMZ4RGuAHVyZ/DQzXPdDkLS1G4lsb8u/jRI++izofEItra5L4u?=
 =?us-ascii?Q?zwZjOd9RKQiqo1UQHdonuCvRyOY25nCUUEfW8Yx7XOKTR5pWBUQKbM6U517p?=
 =?us-ascii?Q?f395t+kTD2JBLCsHbixxA0k2bslD9iND5zYItbgeG6iZxPDPg9z86TTfOeQm?=
 =?us-ascii?Q?Ek2flNoETpzWKbeNTFsZGo/tOP6MewyyY+iKuPP5kQVn7t1ipcYoem/E09cm?=
 =?us-ascii?Q?cQ58wox53dHEOCTSxmmoMFtdH7zmDst+rlNTaXQ9s10EPyQZIrLC43oZ2OsQ?=
 =?us-ascii?Q?S3gjsM19Zhj6UZx0X7vqaEQxRgIVRPZMO/TQ4Z1SKyn7hcVPpQKqg+u6drWR?=
 =?us-ascii?Q?aNQljr/Xi8OSN8HcJLZb1jlb19pdVFJE3U2LCjE7sALmSMp1MZTJ+RBd3YXI?=
 =?us-ascii?Q?qazo+Q0V7mr/hI6x0BJVhu1cbfDWB7c/W+MEBVAKAiOZ3XsBzFMUeAMsM1jj?=
 =?us-ascii?Q?IzvUlSMpKv3h9214PY4aiElPp6HS3+smk6YP72JOWtRbt8RL0lb5dBqRMhQa?=
 =?us-ascii?Q?4MbA0I8BD53CKnjdBPRgTBKY0v4ll0TCth35nInepBlHrrTdAuO3uABJ3oUz?=
 =?us-ascii?Q?xuq6n9vj7aqsFKvSGA4WXMEyiYgY1Nz1wonDxXUFgdvHQS7efXlhmsrsO8KN?=
 =?us-ascii?Q?W8JeNsz3/MZnjaXfWU6k9sIFl6lNMjXy4yB2PL8SNKtKqQHgf9ktcR10/DCP?=
 =?us-ascii?Q?uOcq1SSKGdA68VDE/ShEIz/qfCNjtsQTdvdEkh7AV9w2bY4wIn1eX25mmXvQ?=
 =?us-ascii?Q?jW2rJi94n6s02iOOgdEKyWuoelVsZ2WTePGBGeKk4m0WvoejXG9AAU5ZoMix?=
 =?us-ascii?Q?u6b41xfSRAwkV3oI+SNLHTyZMJA54Khrw7tGgMwA/AgjuMuHWNvcx7hi76k0?=
 =?us-ascii?Q?wknz1ANah41n9LYWFTGXZErFRruG+q8bm2GrKmshf/FIKLm3/6umsDYRhpgD?=
 =?us-ascii?Q?zR8WJgDiCCf0ZcY5CSkF91DM1kq7kNyMQLpPpysY9qoPP8Vi4w96AF83/q/3?=
 =?us-ascii?Q?2l5Xsmk6+YM3nXNjNvtmPAGO0icWmpP8XFbG3SH5U6DOICufFvXVGx970oMH?=
 =?us-ascii?Q?fF6xZS8jodlwbrzxRmZgQHpP6/CgK8JYs4BWpfKQCA26jZhwxunq+a/pBY0I?=
 =?us-ascii?Q?v1m7DVjCvmX84jIbYR0bE0C6D5ydY6LzpGvDsyAqcXGFc8PtXMfyVgMlg2E8?=
 =?us-ascii?Q?+qP6uRy5JiEoD8SDRLvDGvZXjPtRywI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a90c762-ca23-4161-8dab-08dee0cafe6b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:39:19.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMaqB7M925YaRNTiID0OUL3upQBVN0Bzzi/AvXy6z7EQIW2EmmL/NmX9pukNSNtJ0JUoNQA57zY38JYt0m5+gSo1H5NgVKYLELvaK8YMDX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5931

Accept -A 0 to explicitly disable the abort, matching the existing
default-disabled semantics. This makes it easier to always pass -A
in CI with a single sane default.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 latmus/latmus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/latmus/latmus.c b/latmus/latmus.c
index 772cd9f..1bf1f95 100644
--- a/latmus/latmus.c
+++ b/latmus/latmus.c
@@ -571,7 +571,7 @@ static void usage(void)
         fprintf(stderr, "-r --reset                 reset core timer gravity to factory default\n");
         fprintf(stderr, "-b --background            run in the background (daemon mode)\n");
         fprintf(stderr, "-K --keep-going            keep going on unexpected switch to in-band mode\n");
-        fprintf(stderr, "-A --max-abort=<us>        abort if maximum latency exceeds threshold\n");
+        fprintf(stderr, "-A --max-abort=<us>        abort if maximum latency exceeds threshold, 0 = disabled [=0]\n");
         fprintf(stderr, "-T --timeout=<t>[dhms]     stop measurement after <t> [d(ays)|h(ours)|m(inutes)|s(econds)]\n");
         fprintf(stderr, "-v --verbose[=level]       set verbosity level [=1]\n");
         fprintf(stderr, "-q --quiet                 quiet mode (i.e. --verbose=0)\n");
@@ -669,7 +669,7 @@ int main(int argc, char *const argv[])
 			break;
 		case 'A':
 			abort_threshold = atoi(optarg) * 1000; /* ns */
-			if (abort_threshold <= 0)
+			if (abort_threshold < 0)
 				error(1, EINVAL, "invalid timeout");
 			break;
 		case 'T':
-- 
2.43.0

