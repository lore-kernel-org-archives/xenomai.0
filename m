Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B13BFE29
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077998; cv=fail; b=U22G4bROcVQ96qhYBU3JWHIPNb3ygSpEDW3EjIYMNAvWDTmCnnpuF1DJJjlikelVClP3mzNwDlVQOrvq3qkzjuWggiTUH5upWh1GEysm7SGIRhrC0dwbseVbDTrtAjgB4zLr/nFAhngjDRn8zH89gaEfqiWkyPszG7uy94s+pbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077998; c=relaxed/simple;
	bh=D2uqWNIrD75++wB0O3osm6ZXzxgV5ThXdowZblnFOlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcGXwmXMjaQFTqB3EHtrv5k2Kf1jLJ4BFudAI9jQE+4qIlygk8/NHvl1luMrwmUQoDwnCoO8i5kpwwkKgTsc+RDd8kKm0VxOS3HDVcDyXuhVdQLHlhMnLG7FhuW/6p4UVrdN1pA6AHMFsJKAK5EZxOpHyJDZxtV1Q4ch4aYDb+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aSmLUHee; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aSmLUHee"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ub23VqnlXj9u5HQjEIZ69L5hT+KgXKa5Lv76DucVV+2DMIOc4BleRRU3wx0bQcj88D4L6NVfln6K/tlFtEDuEbhMKsP2AtxFIKk604MQQaylvSzr3EGfGZUFHdB7a71eRmqRB26F0B54FMern70oAfRTJ9PPNnx/3zz63nlXdZxXaZeMqlz7urii2GWGA1vNv6Zex1PfKVQfQbhwZCLjhvVhrqpGhDlUxrkSmGk4i5i1DpJP+httKuh9NGvMFzCWiRiQN5l0UL3ZSKtKqupzO8AiXIhCJeQhd97DzqI5eqkbxY4Y4rdqp7NYS7iaLPxQiOsKHhTKj4mdwzELe64Y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOlyXVBNdinyCCTDL7w+44bGGbKS293gxSK27sqzlZo=;
 b=ojEQLjOxs9i1TKhyHBrHYBxtxywCWo26ykauN5kj4QL6fpsu2IIbn59q5DIvwLawT4rW4k9zyMg7GfRC+Iar4e3MnkkHD6IcMXmNjlzGKpD4TXgCnvFqi7VFCcIwK9aDn6J21chBrvU9gxsfih93geQ3gTIYaODO1yrJN+s/qd4Afoy6TkdmSNq+F3JpZM4H1cdq+CrVLpgShFN9rVFlvt81ny8bUOi/f2Ra7CixpKXYO2rlcmasl6UvCvhSmMo7jgMmaUfr/+dLnN+f2wh5B4Txykg1UnJoxeQxSmYA33o29+zyA4LJal2v16aqv8p5p0eKdJMEbIC/PC8azCqr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOlyXVBNdinyCCTDL7w+44bGGbKS293gxSK27sqzlZo=;
 b=aSmLUHeetx2NeH8X984AI16A7hzT5LZdHYxRmbirpLfkIItAamEKntRvzTWqST/mja/My0N7B0oXWxWU8+apWBfrqCddaUb3USI+X2Dl9r5fZNiI1+leLzmRKENf6wwfHdj+gkufJ4Iqy0yNokiTTagcc+GXSlMGpm/wA6EYHieCdQJP5+Qx96fjHD7NVpV4rAkwlbPmSo4QEh0vzw4ks//MZyTyqbDx9/RdTjITyLRRiTnXel5Qt/IrlIBr16vDzwf2u1Luut2K34N8/UR/UZ66fjqWa8W0Nb2OHj0EjAiSJkKrUDWuvFX1xu5Kw4xc5F3rtW/Ffyhox15ITwGI/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB5641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:33:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:33:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v3 2/2] start-qemu: add support for riscv64 target
Date: Thu, 22 Jan 2026 11:32:59 +0100
Message-ID: <20260122103259.423957-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122103259.423957-1-tobias.schaffner@siemens.com>
References: <20260122103259.423957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c08493-1c33-48ef-ccec-08de59a1a249
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wys01p8pF70Cwo0BB0NOpEK/ttZ3zIxJCtawFXTmj8HQOXm4s80Zg905a3J8?=
 =?us-ascii?Q?X9EEXLbJMmAOpVrcc2Xa1/yDOKOM129KAd0MdZiFt6K9/RP3sTEVO2m2wbcY?=
 =?us-ascii?Q?hUhDcyKiMBs8jggrumjrVEDmbW/BXLxOzzl2cD8b6QkhGwAeOigkgyJaRL2g?=
 =?us-ascii?Q?++Ni5R4AraxJNdNbh5QOy+0Tw9UobPtaO8wmHNHgR+BLLDA90HR+huoN9N0r?=
 =?us-ascii?Q?IvLk0qZX2RV+PpFXmLuKGMFv08JqD9B9J76VyhJdnrcZsvIE+JXXeGT8D4I2?=
 =?us-ascii?Q?9RjGlD92BWsphfVa8fq9K0kT/J4E7xeQOAiqLkcb9u/PJpoFezgqn3BbhL8H?=
 =?us-ascii?Q?sXYKF0M2ERh7qh8SJqqqAdIUY0lYZ5WRQ6pVTJD/5r49aNqxMQGGqLJV2qrw?=
 =?us-ascii?Q?SG1XGLgVJ8q42cwQ94peGSW2BzCSd0bwxICi0df/rGRSAbNRyguXaPGEC94w?=
 =?us-ascii?Q?jCj4idCI8VwvFOvcNRHTY1cZSMAOBly7VFCP0Izv30PMKgZAN+gKATL94bVH?=
 =?us-ascii?Q?fbvZ6vE/Tx7ftbtk4ThhZqFzGaiM/D3LBz6fzHOEwR39O9J7WFqXmJr+0ByT?=
 =?us-ascii?Q?r6xh5ZQ3jTK0o+afLBnAxDynbnOgfFRr7N8n9qPE3kwhR1X79PApoXBLPTWb?=
 =?us-ascii?Q?LqqQhq+69cOTmS40AmfrnbXXOhl8NYN7JhFaeWLG5TrqUhXT1dieiVXpB2ib?=
 =?us-ascii?Q?PmZLr9i5iYpyHqqPAq3DgVCX/NM2CQ62EJIwGlBegaWMVm8CcDNqcGCqeXaA?=
 =?us-ascii?Q?nrEwgcv1zrPLkE+2xpwaChP6HM1gz8XQRLM4/zpFZEg5S9gW8kGeaMSTcKhX?=
 =?us-ascii?Q?dzfNiyxsM9wSmzqvid3rKI3qT7ly3Iedk9Po0sHxh7bEUVS8eOaZls87jmGH?=
 =?us-ascii?Q?CLxHFCD+X2J0T4TV5IlVy7VUfEOq+fks0qz8zqg4w0+Wb9vQVfw52I+uHrji?=
 =?us-ascii?Q?o06s7hXsKek6mvRdtNSPi5dV6SzhLt2ZJTLimb+QrsPiAvDgS9HmKHuhdSQz?=
 =?us-ascii?Q?Lsuhp6UCBh1dMvlLv0Tnc7XSymS91LZ6dBRAeAZG2DnuUzH7LeO95s4s5Sko?=
 =?us-ascii?Q?YfxQ9dVpug5ne/48spONPxqMVNjN8F7EBjc8WrchhTT2Lw4s5vudVVXtqKiM?=
 =?us-ascii?Q?WleH4JwGunkVkXuZ+2D3u2oMWjqmVewarkazsTbGRTne3X0cFKMvna9kHAOg?=
 =?us-ascii?Q?5K5u7poO8Ep/yjjMShsl6XrCu4whU3AgA6P/YJ9uxLCkBg6N7IdYW1Wfi+rN?=
 =?us-ascii?Q?AdxXoBYISfSHCL0RN8e3jvzKd3yQthe22URU1SYIepHRcldcLrerprBnaAst?=
 =?us-ascii?Q?yJYYhwI99eyISMiW3oNJt3a78CbehvDn3f8SkNshVTaAUCuT8CBTBKbIY8F8?=
 =?us-ascii?Q?VoJx7H3S9IAO2g9Mynw97iNqXlyfem1yBWGx9WB7yQ2Vfw8xLo9G+v4I5Ub6?=
 =?us-ascii?Q?eHNP6PMpyr/OBqpvAe/GqZTgdY4FbRf+WvbYAMEPf28m7H+MYkad6XHvfJla?=
 =?us-ascii?Q?kta6zaERxDWA3SG6nvSEACmYv/H7lscKEOhRlCk/KWEXjAB6FmAIlqdVvodb?=
 =?us-ascii?Q?FLU7Qq2E+F1wjYKS5JQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ntGrIuGjtxUMgflgBpkTla5JlP0NKodr/KF1xk6vyjqzRAiVx+kt2ZNtoQFB?=
 =?us-ascii?Q?fMEttrQ9XlEMXLIC5gqLDBRDy+jVyyQ7uqbKkXkCybxq0jx0WiVc8fo9LHK4?=
 =?us-ascii?Q?k1/DCujuNC/pM2JtUCdl9rpwAzVBMTsCKu3jyftzpp4Bi0u8Jpw0TyUrjaPM?=
 =?us-ascii?Q?x4zjfcS3uqPbvMXF3OIxZv/yRlGPT8ovcHum5fq/4+JWulgNrEIPLPlV5/a/?=
 =?us-ascii?Q?60dD3eAItYC8rymgylH0Y+wBhyDOTQgLZBr6gjv8htTdGcP6RrNXtD9HlKUY?=
 =?us-ascii?Q?01J262Iq9J/7NdbXML2fHj5A+XHueBJ+IqqYMwQcW0G3Yn+ftJZZVK8WM9Xj?=
 =?us-ascii?Q?04I86Qn77IxRDO7+ggqSroCZ94cw6cBEtVI3eknu8jPRLubYvP+TGG2zUVbT?=
 =?us-ascii?Q?kaUwsDyD9udWGR/EkcfXto20Dc4q8bxqS9wTN6eM8TieWQoEzWAYdRniIJuG?=
 =?us-ascii?Q?FeIWqeSNzf9h9P9E6GoxF5BX7opiMrQVn7lyjEwXURVCV1pMtoQuP0FD6W1f?=
 =?us-ascii?Q?TxqDboGN7baFxoOFm4M7V/E18MKTzXh13TH7gzHmQqguASs+QxGMUDhFKDcD?=
 =?us-ascii?Q?xtFPT8DavVo8yLxXedRJWTdH0kU0BuV3/17YpZiszDmx9ceEzM100fzsxsZJ?=
 =?us-ascii?Q?VKpYFN/OohiCOnhuQMxtkJTWMZfdXOkt870J7xpTRji+PiAwqzKtjlnunqwl?=
 =?us-ascii?Q?aA5ObUswo93yoZ78sX9BC6O3yd/diym5MnHawo75jS2OiYXoly8r6/S0nAtZ?=
 =?us-ascii?Q?D0k4lE9e0sE58OnsjJGqKAgvQ5D/LZ2C6habAGavyeDjKvqkyvHYhvMjfIBl?=
 =?us-ascii?Q?XohZk704tFbx3szxRqCWgZum9SioEHfQlom3p+r0QAjN8qABNkw5C+e3R54i?=
 =?us-ascii?Q?V+IVnvRgnn2dFnQNabfhq0JfS+2yyINynFZC2RdgosMWZWbTQncwLXz0kmo/?=
 =?us-ascii?Q?N4w/7AkyETIfuMubXu+Yg+H1FxL9VzTJATYra00IiIo0BPvR5JqEd8ouIGVd?=
 =?us-ascii?Q?GprznrH2W+S++RB5VUoidrvZFXUSGQb9tnNBRinqx8GKyMAfe0zh0NAxgm5I?=
 =?us-ascii?Q?sfA+d+JcfCSV3abL8FWUAeMBLA8Z5EnDbbd0A2N+QLJ4+k/0lnKuWEqdXVwZ?=
 =?us-ascii?Q?qMbnIvsqcwTMiEKF+F1UpJzyN6l0+630aNpoRS4EDPwMC9d4MINLkbFuMpdP?=
 =?us-ascii?Q?V/4PDB24XQYniKCCLtMWv4O8G63V9pXnnMxhsbdaYKhP8CrhDyqIu/2GQVus?=
 =?us-ascii?Q?ULp2MigymnOg/71Rce+Y8BbXQMHv15ySway6ZaP+apL4HVvSBTXbEFz1/8yu?=
 =?us-ascii?Q?U0cwmE92jTz1+4z9W16+q6pSwYpWMwnAED3jb1+c2gQmoLEP5vBRNewIiqxq?=
 =?us-ascii?Q?g/QwQL6e6l2a1Gs6rquYYdw3QNzjnZX5wBNsE52rMEZgjKxLH1muIppkJY2w?=
 =?us-ascii?Q?bK5cwx7FPrn+cmZKOySe97H/N3/EtqNWoOVGEnmsczg0KnUcO+pcgjAJTbwl?=
 =?us-ascii?Q?mIZDo/LEqP0WPE0w3Cc5MhjlPhgE2/EfJ2MHBNJMBCpjWMqqxR3762ZtSxE9?=
 =?us-ascii?Q?NxV+O9q+bKTfaW0wQISCZU8EB7oBlJKioYg4zQjuKUo1RT4hYOtvzikxG9Ll?=
 =?us-ascii?Q?hSS30V36sTK5hM2+/RHOoajjAtzkBC2990oWcKvHHQJg3ZJjNC8mEbaA0Igz?=
 =?us-ascii?Q?k8Xj14jIjFnAjvNRqZxI71o9snqF1U7AkKsc4xB5KR3UvhP7XB+3bniXERMS?=
 =?us-ascii?Q?dX0ZU8z2/VnFEXqNpoNj2CwUtO5UvuE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c08493-1c33-48ef-ccec-08de59a1a249
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:33:08.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpV38kS8BqbKxSC8d9dlrtvQU9pF1IklhoGDcGvHkmWZDJk7dIJhxFFXws2Kh3/Vet78GJIrKFi9O0eRxTnrREO3NtfWIAv/S8/Ke8WIeF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5641

Extend the start-qemu.sh script to handle RISC-V guests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 start-qemu.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index 7b9fdb1..9e9bac8 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -32,6 +32,8 @@ else
 		arch=arm64
 	elif grep -s -q "TARGET_QEMU_ARM: true" .config.yaml; then
 		arch=arm
+	elif grep -s -q "TARGET_QEMU_RISCV64: true" .config.yaml; then
+		arch=riscv64
 	fi
 fi
 
@@ -78,6 +80,21 @@ case "$arch" in
 		KERNEL_CMDLINE=" \
 			root=/dev/vda rw"
 		;;
+	riscv64)
+		DISTRO_ARCH=riscv64
+		QEMU=qemu-system-riscv64
+		QEMU_EXTRA_ARGS=" \
+			-cpu rv64 \
+			-smp 4 \
+			-machine virt \
+			-device virtio-serial-device \
+			-device virtconsole,chardev=con -chardev vc,id=con \
+			-device virtio-blk-device,drive=disk \
+			-device virtio-net-device,netdev=net"
+		KERNEL_SUFFIX="vmlinux"
+		KERNEL_CMDLINE=" \
+			root=/dev/vda rw"
+		;;
 	""|--help)
 		usage
 		;;
-- 
2.43.0

