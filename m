Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1530E0F4
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077993; cv=fail; b=UaBQHwhjO+7yAsO6sw2Tuws5HI3yAMKsGR+XoRET5mWR3ul4L2vGpFFEMzo/sYxs4fj+JOqVcet28scRZdNg4NbuFNuQkdC1rNqakrvS0nYsr7qLtW1YmhkUzsRKrQkE38fSc6/HkX0HWamm+lwH9r0SqWDqkgd19NBV45P5vK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077993; c=relaxed/simple;
	bh=awI3zn3ivh5BT1ADLMLVnRmOAHPqYhXB4I1/r23Ojn0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rKF+8wXRbEFtx0Ny+AZcIu/DEYKo9qqQKkO2B0TQEQKrlC4AM/r7CuVwfCbNKUi2llQ8EkRnCqx+nrig5SEAJVCumCCejQA0Ls5AA1Dbn6w/8XnedO1aIuJXUuvvve4BybAupxBOk3YefHBHLGZ/daMsVZuy/rpE2+9Gbk6N12I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aTrw3iTs; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aTrw3iTs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUhdkr8ZBEsTaHfIq5TJaLilS6ouZ2TKLNtzoDFpBeXK2cAiRXMJsc56SNp3Dcis1b7W+pav1wQ3CCLjlZVFiZ7/KX3LutmaKmVd5aqIsaoLbzI8AUYdTEhXl4o32CZSiBboBGUk5L5m5OQThRlIQFti+rdm8o0WVsM24PKwcBodCL3rkS6GHCHVV61lGU4sjZRfXQUkwIu0jE13f+7vaXHIByeFZMcCceEkwV1ZZ7IrJ45eEsoMqmyw9n27B+uo5CKvKcW7be1YHlRmXBWQAJAUiTQIes5Qw+Z1MQEBCJEyuF+QYo9BGSo03/BHbXjdJl6moYkwcYmeQ86twJIpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8UHSiDBv9iOeoSOG/d+snYbMXDAOL4zM40tkKMm0J0=;
 b=QTBborrYPFabkCstb4YNolXivzwozd/hEzbwt/YzABLsGjxmzfECtqIyw5OqRLXRwzWsQg5fXhQ2sbev6AsXiU7DMIJRusUSSoQPxjaztr8CrnJLVWht5OqRTATixF6PgQsMj00h06UZ6HyCYmmftEGlxoYt564gjlXIoFym9XdftHSkD5Ynat5/30AUQ236faAH/Vg2qFEKAbjl14sZ4vMKV/dVYwaOgz43g1HZJiZxUh58kHBRq4Bh2+fGl7YK2oAahrN+dTn72tEr1zilcry4OEtHxkiUEzGW7W/BdYj7cP/yiKd4zUs/uPmrhYYrGnWFV01uTDhCFnTa5LRUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8UHSiDBv9iOeoSOG/d+snYbMXDAOL4zM40tkKMm0J0=;
 b=aTrw3iTsQBnuF3K9bNobuOOBIZ+dMRdFZ0KTchVehqY2Cm/K0yAxn9KIHWiRztMz064w9Sg6e2Ty++BuyGBL+/ay0b//rJJ9MTr4oU5kTtkqKI9zY3Vo6zpr8596V87vyWncQaThoRxWcITSWp9s3wYWYrpPXIEYgpCCO3RXM19BtRUsX+rSSIJLZdB/APHLjcdsbXX9Gx8N5CvJxnrKGtHTSExFHzWI6ydaxT2bgJl/ugu/Tq02Jj31lAx52KBFgLz6ZBBY1BeHbqTY2ylYpQ9pB/rfkX5AbWrEvwWAXObtnMllo4g79E1RK+UZTxRFyzH4Xx6/6mMj4UMkbYEgqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB5641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:33:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:33:06 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v3 0/2] Add RISC-V Architecture Support for EVL
Date: Thu, 22 Jan 2026 11:32:57 +0100
Message-ID: <20260122103259.423957-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: ae8bc7bd-2c09-477b-9084-08de59a1a15f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cZpWVDYNVP+9FYbH2wje1/grrgT3Tq7+OYTdR16wAcWjVuiJkH1vTSurg7xl?=
 =?us-ascii?Q?ceJpl8kKz2Z7l6tEboWWwvtOgya5IPnoM4JiZyWtI9JkMpVInvUFVI9AoWqt?=
 =?us-ascii?Q?qos+bRsQlSz7gDjY50Y3o5TFKx4Kpq1O5xSSzaG/HPqpL3mhQn9shl4QguOF?=
 =?us-ascii?Q?7c5uhLrwA3MPeoacGh7ABL4n9ZiE32cRY3C25wvN/utZ41Q+EZoh8v8rXLpP?=
 =?us-ascii?Q?qfLmdjQZ/uLaU7iRPy0SDwdI8uHnRFmE+ZXcthzxq7Y1nzyQL8T3GI3RbkOB?=
 =?us-ascii?Q?HLg12HyLscpejB7nR6Xxz199E8pOTi3q+GmDC3ah4ZzDbHWr+MWhMlFoITUj?=
 =?us-ascii?Q?KRL3k3lHTekRUWqBy6yXI0/lGxLy6bIGtTyiO1KzULZfR+eECmf4Vy6bJO90?=
 =?us-ascii?Q?R235ma15VvqG5oTamGJzJ2QCKXoGjpVs1O8qdkLjSpd763l9WlbE2nzdSF4E?=
 =?us-ascii?Q?a/wmUe312FZerssWPOfcv4ePyvcsSGTkK2LWMipXCqZrnrAoHM3EUrvs1Lm5?=
 =?us-ascii?Q?gz3R63/7wT0G5SQyXavEA0joMqqeDoemRFrX9SbsHc1BktmG3IpLz1N4+O5A?=
 =?us-ascii?Q?Ghkzi8p8XS41stfnmEDlHmWwTOhY+0mRrLkyc2xVTEeke0Ooa+Yxca5HLVCL?=
 =?us-ascii?Q?2tS1feBXCYHh63LXvWqumlwCWaGjeXP18s2wAaNyoFm92ZbYWUjrV48pZLj7?=
 =?us-ascii?Q?qN1ur2j+or16TQ9ceh2zElzdr6jrw1B2V0/KDkZ5pxa5C1xI8QuAkOJatFRi?=
 =?us-ascii?Q?bzlNptJ7Hi+EF8h2nQrPQxFKozUTx6x98lHWmL5cteN/BRBsUlyKOnEeiDci?=
 =?us-ascii?Q?qvtAQXG27lK+2IMwcv09SVWTrOdnEZhrJBaDk729wY49YQHEV4vq4appe6vY?=
 =?us-ascii?Q?y2auarHEUbbmZXdKQfNOFQR2SJWp0+u24W6Cs1xyQzNcsylAsyMP3IIC6aMu?=
 =?us-ascii?Q?+CXRxUKKuGHRt4M/e0cFGqivu0ExSdZ2jwRIUf9mlpzIM4NXMM65nIm2G+9S?=
 =?us-ascii?Q?xcXnDxWJ1v8KY+guGRdsXzfrCYpWij6kt5QIzwrnfuR5PGOmbyiGbc8XlMtF?=
 =?us-ascii?Q?M9s1XBQjLDZYfxzZA9XVEU33rxm19R7bL3zDCoOwfsF04z7hzgt5NFfzY4sn?=
 =?us-ascii?Q?CqvY5ZQcXk3G3wvz46lXUhp5PDrH6snqzQQJhrXrYth3TSVRRJ4VA/R6egr1?=
 =?us-ascii?Q?7Sy5vfe45u5Pnrragk4ypSOgL8SMhvbKZ01OtzpxFISXKh6tkuirluuqwmEZ?=
 =?us-ascii?Q?Ugt5lnlD1x7N4R/pGT2QZLarGnJJrkATrlEEW8Zt4WBef2wSoWm1f9/wrZ3J?=
 =?us-ascii?Q?I5xCWbZmbGeu6pB+62prhEh8sDf9KnzOF9fzNE9rhwrUmStCFpyZdlsxVizd?=
 =?us-ascii?Q?GoYvNrpPzg+MviQOkObSydQO3xaAU8TG7S5nSzwyfpRZ+9ueoEVQ6urf4YHY?=
 =?us-ascii?Q?0ZzhvACHl49ha45QWpbGkygmyKjd1X8ZAWYkIGo4tcRoW5cXUVV3fdjM2U8M?=
 =?us-ascii?Q?T3K6DDYtCGys4XURsd3X6GNQ/8txbJGB5u6ku+0ogjNoK/9+AB1OMpE2Kry8?=
 =?us-ascii?Q?kclx6aPaelAaKIKBR1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dpS3kHXAzI81HrrojxElTWPuaklhpoIsDemJbb5XYvHxyZk6vTEK0cT2jQO?=
 =?us-ascii?Q?v21ovQ03KbVEm2v+TtVyyyBwCwHsdewQFqlxfErJPWn9CG3oShXelq+MCvpJ?=
 =?us-ascii?Q?Y3UK8n0a33gfpGkO0X4wjK6ZdF6ZOUWUjP5JoaUasSl7KTPz2pyzAU1MU5te?=
 =?us-ascii?Q?PzdPB7gpWPw15mF8rfChYq3lWcVGh84cEaK0/Y6bHfCosDNsV2Xord2N2sW5?=
 =?us-ascii?Q?9fdRlmmDmLlvSqHpOTwCnfI+7FOQC+0d+n7hE6vanft5BwUm6L6Zgq6yqo+i?=
 =?us-ascii?Q?Tr81iN5o+JIAD/ru/fKAL3X7t5WnYTgXk2I8z0kZgUfqQf2ADBtrTtkursRG?=
 =?us-ascii?Q?ywlXsydLzSN/20gOTmR+Kt0GYH26quRVORfHeZWDPMtqNLA9KoRCgCKxbzhj?=
 =?us-ascii?Q?xoQo+mt10B5MBonGBtnCpTNiNa2G79SHqdw8qLNK+JpZC3LGith3wimdvmK/?=
 =?us-ascii?Q?PK0v+B+npT3Ta9fkocBHa7wk7LziUvnxZBx4Ch9wgtyHEKXvcojvLjjqMgPW?=
 =?us-ascii?Q?QCzcXDSS45V1nRv7h2OInamS7bAKwqWZw9qxsvsP6xVXDhP9PlMOAS23jBGR?=
 =?us-ascii?Q?d1yYRQpasGpoOHCJwzLN7if0yPu32+NxrQdSaPvp2cdJir4ZlBvm29PdNStJ?=
 =?us-ascii?Q?GIA0wadXgrPcj8+5nEp3XWZ35am7dLbMzqiIca/GGqZS1Bs5XlRSBXGTIQuN?=
 =?us-ascii?Q?ShZt0J53R5cbVYfNm7nrBySW/qKKbiPpnEaFesgKwxrtk6z5SoRezXDlkqtK?=
 =?us-ascii?Q?66hm1pmpSrSS5RSlGlqvhda6xJzzvaW0wGosFS6Fh2HBlsMNucpq00Adll37?=
 =?us-ascii?Q?ac2XpEchYKf51pAGDNgZbYbk91n885+RlE8NsapoVsnIQvTdC1+ozVhJ4A54?=
 =?us-ascii?Q?Nl34IXP4seojD4dHYuMxyjng2UTdYy7o8uiCZsgOs0A3YCmoapVb38rqFKA1?=
 =?us-ascii?Q?q+SxdmjWTrp4xQJovTRgxhiU92w8OBQEcuScyTN6WznfYgVx3QLE/4wRZAp4?=
 =?us-ascii?Q?n6d7uEt8UH68xwbddWM/BpxvWhGOSLvFBaBeU9ZgVxKydnadc6OjLPYi1UN+?=
 =?us-ascii?Q?FMMljr+HZJ6EdtTvWLNmouO4xlDz2nrLQ4kvntT5U7XURRiSR5IUAlNpkYQ7?=
 =?us-ascii?Q?NE1/WbECo5mHLSm7jgdRqLkEQjbM+iEp/Qcw0+d2NISZTx8GoqnZh511sfK1?=
 =?us-ascii?Q?b2HYVvEHVDCKrOSqB3I02BZ1xyD8EZP8CYzf4B+2WAe5rQGaHMqG/adRitkA?=
 =?us-ascii?Q?+19yyphOP3obhdDky9cfG4si5l2X0ftLnYnEvkLvGwKk1a8otAz5sYKzlLfr?=
 =?us-ascii?Q?TaQQ7JX2h3WJOMtsszF5Sy8BFPxsGm7+yRe8lVsZzAmq822uabbxiPCN3wzk?=
 =?us-ascii?Q?bG5JUQfrKIHzMDdbCe+ZEsgWMzr1F0kDUTMWTLKcBxezTmJaxt6YYhuTLMEw?=
 =?us-ascii?Q?odAfmV754pv1/K5vSONH7Y3MO3fKCsg/hLz4obJ8cLbysiJvDj0rzBgCBFq1?=
 =?us-ascii?Q?UU8d9dkVLTqtg0rxuhf8geggIiZJCymsAEVaCNeRrmWcKDs6eBY7MpvwUew0?=
 =?us-ascii?Q?/D3kZwzfSoLRgw+Wsl5wcvFMS/7mrXvhFD3Cgezs0epx0nwz9vJG/PRsF8TN?=
 =?us-ascii?Q?mMv3QXsdWO34kk3U/zZX+VV1qZK4DioLESnXzclDqdj6Od9J4uTFZPFMFqXP?=
 =?us-ascii?Q?jFjFduPXzeIqhbfaRpQHeYgB4kaiiGzLFZidulLEvkO3EzUAcr45ZL98jMkw?=
 =?us-ascii?Q?bsSCsLJzK2Pt1+l7NI+JuwuP7k1uQ/o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8bc7bd-2c09-477b-9084-08de59a1a15f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:33:06.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmB0Sac6cXR//SCQyGiZeSHTGV204ri8FRz1DXYOpLxfkC7HIYiExP/oSpO4ya2FapAyxSenW+nPl/vWvO7xI4Au9hfq3XXNOn14upTlrMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5641

These patches add the necessary changes to build EVL for the RISC-V
architecture and to boot the image in QEMU.

The patch set is intended for developers who want to experiment with
the current state of the RISC-V port.

Until the RISC-V port of EVL is fully integrated, custom branches with
the EVL and libevl RISC-V ports need to be used.

Changes since v1:
- Do not provide a custom config and let isar fall back to the riscv defconfig
  with the xenomai-images debug and evl config snippets applied.
- Use depends on in Kconfig to filter allowed configurations.

Changes since v2:
- Use a head based EVL kernel branch.
- Adjust the kernel branch in the existing recipes instead of creating
  custom recipes.

Tobias Schaffner (2):
  riscv64: Add support for RISC-V architecture
  start-qemu: add support for riscv64 target

 Kconfig                                         | 14 ++++++++++++++
 conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
 conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
 kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
 recipes-kernel/linux/linux-xenomai-4_latest.bb  |  3 ++-
 recipes-xenomai/libevl/libevl_master.bb         |  5 ++++-
 start-qemu.sh                                   | 17 +++++++++++++++++
 7 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 conf/machine/qemu-riscv64.conf
 create mode 100644 conf/multiconfig/qemu-riscv64-xenomai-demo.conf
 create mode 100644 kas/board/qemu-riscv64.yaml

-- 
2.43.0

