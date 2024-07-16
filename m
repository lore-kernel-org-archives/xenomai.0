Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842D1A0AE0
	for <xenomai@lists.linux.dev>; Tue, 16 Jul 2024 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154816; cv=fail; b=aGGVMgccRrcfy4u8myQ++m36pPLUDTYeFLZujWY24L50Kt53UVbc/Vaa5pTT/8+Wui7MjFo1ZC85UsvyqOp8kUTLA0pFvpEcW9fgJH6nPee3/ZN6gqGr44ka9qOxbfMQC23OMUB6z37UKoXFVl/b+9qkzSSURMRblQB0o0trWvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154816; c=relaxed/simple;
	bh=SvJcqwSuVt4HU8XGhvTmBQDYIK4g3ab9EW427XwrBrM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UXaW3aBx9m3FMKbWDsb6SSchW3w/uXHwuHz6uWB4zpxFYGtC9qY7o8U2eIiVdJIn4EWBQYNjK/6cc4vWNWua8rQrDMZ84eaI2rUwFCHq7H6/RErezY8n91mcv4GvIpWcIif0WZUH4yQndzXvDidLm4CpVDsusozmzcIcXrCCL8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=w7xxuT3F; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="w7xxuT3F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LppgFspba84HpVcms6tWa5ysLziMLet2Z9g28whS9rfhb69lU7bb/FEBx7+KEzl3eFlvh7wX7bB0s/lZKsTK1ovjT1HLvIfHqJxVbyhb3MkRdDIjNNYotY+6b6qz/utVa9OqyODX8mW8UCT4+urX3J4BvuKrYvWycQTuAmPjWQiltKbp18xeJ18Ua9VgakZnOwhZ6djEvdT/NjbqKuUxDZTJWo+mTLUYT0lr6up9N1K8mWNwf1q9eEoVfwM+sMhH51iqPXH6+QLuETSwYaN/nEzBgHVZ1TDVCzFIBnL08I5zeHf1UELPnZZ9zvBcmk+C30ZQDcqGgMjXhcXdTYU1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIqTEtIuI3A2QSoimsCpjM9gVbOQS5WqBF22iv6YAC0=;
 b=RRflLq2QztBLkFZdjmsyBU5q0FoFWdXiPa+UEodz9xHbvvuPL1u1SXETI2bejMs/msEsbdbl1Zfnx8Uo/CNtNG2guX+cEHPPaXruIaQCG97YF+4s+qHPVqVwWsh1MHmPfjo68vrA5BklDj4sLjEPX+jGlXlxRWZUBAOG4N5MMUUm4NyjRuGObrl4ilbdXqCI8kizkMM53+hfAakmlmTZCfTwVZa0Ty8hJQTe8U2gyPMYw+11JC4D7fvwHUfw8EXWDnZUkmcI6RuTN5UGtSylQHqDIrHbdftn4n/ZTqpGrJeExXO4aQeVgHXSr1ZsdfQlkhzwxkWTFp5yfi0mnXnnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIqTEtIuI3A2QSoimsCpjM9gVbOQS5WqBF22iv6YAC0=;
 b=w7xxuT3FZ3kjLC4MgG70agJJdgVI2XQPTLeoWA8H9TjDS+L5ZJPp/0AYSx5mHSyk0bTntzmpL9GtNWPKl08iT81Yj7Af9W+X7hKhiU9vVjBnM3jAnDl/bwFFR4SVzPswciJS08CFWV+6hyFXf1Wf5pwny2ed870gKU8+hsjzXHXw016NvSx8+6r3YPIXSlmgEAuDHHriGtUOOjBiFEtrDuqifvuZDYPhe06/1WtnTu7gW8BIoaQ0Ltrci3hR3TpcBzDpuGRGbfpt73AI6tIs+Ql6SH4c6CQxaGY5rOKsLanxln1vugngcbrklk3p+1uI4PRIX6ynCqbwrKU+ZTm33g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by VI1PR10MB7829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 16 Jul
 2024 18:33:31 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:33:29 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH v2 0/5] ci: add long-term latency test for next
Date: Tue, 16 Jul 2024 20:33:21 +0200
Message-Id: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|VI1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b23a2c-83b7-4962-47e4-08dca5c5c9ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dv04T/hbNuTA9dsR5Fzl/72IXASbJSZ4emm9hoe42lBeX2KpyEvNWD2YwxB8?=
 =?us-ascii?Q?iVBPIttvldD5gUH+YC1IO+ZKY8LV9n59WA912o0X0oFXPFhSm40jC1Ed1wTb?=
 =?us-ascii?Q?iVHkSvatyv1qNGwAxYysqtWg+FX+Mx87eA5zy45lmi2FTPQfTelP0KfFLUmy?=
 =?us-ascii?Q?K5Y/OrziMQ/hAFxk2diuHNMDiGcRTEFVP81OdWEX/PWu1c9YuQQh36TS0RXa?=
 =?us-ascii?Q?mzoqRJybRFkcRQt+csD5tW2G8smEA6deV29f7ummpJoOVznYfS78cbjzt2IG?=
 =?us-ascii?Q?86WD7YjXk0teHCzPCYMEPc2EJNBCt5hadhF7ISXiIGnWWJGxw9b3vy1tfZYc?=
 =?us-ascii?Q?bSrRxSneTxJTAXTUVFzbRxhl9osu6zTUOq3yfwTeUwTRWpRc0Xd6xbox7KJx?=
 =?us-ascii?Q?di/KRyhTWtJNIo6DBS7rkoqt9ldlEvyXIQG0bq2gySBhkySdN2A1mDyRltPn?=
 =?us-ascii?Q?pBOKewqhVhZjoIIufoItK4E187w220y7QRDOGHAi6C2mFOSTgUX/FNW0Xxu3?=
 =?us-ascii?Q?7tGpiSmPXx17sgqEPvzrJU6emcnCYk3Bo8OdmCXyr/670eEtg8iPPeT+dgs2?=
 =?us-ascii?Q?JPPxCQEO4JojcNIfPm68Qb40xntuPcJTR5Ri0ZUMQp30QnCLrFrva4eU6n2Q?=
 =?us-ascii?Q?G5aRfZuGtb/MsvL8ZJOm4ltLdK0Vi+xp1DRv2z5cFbFCjXCM90v4slWdZBC9?=
 =?us-ascii?Q?eC2z4e/86CmH2NAnEezlVOHcxW7wHAEOx3gToSwHoaBjQpSUNRZRbStVlolJ?=
 =?us-ascii?Q?zP4sniv2PTyse5jMn9w/GbtzYvTxCz4U4+d8+rM7UxMnurIedw0odqFt/wdt?=
 =?us-ascii?Q?cwNAaE572uEy/KLvulmNTDAUyvCoA8GFwTXWaOq1C8XrS1NZ5M7rZrgJtNc/?=
 =?us-ascii?Q?ucomN3C0/gU2VSvvTdMMwG4kJDuBj85LHI2JjyYkrqbnWUIimcht3tSVbuMt?=
 =?us-ascii?Q?BmhBphd1BbSmfoZHDWt9+VqkU0q0PCcXsm4PCcoil8ifymJxX0QzqaQxP3Nc?=
 =?us-ascii?Q?W/pcvaQWFzY7unv3ZxH2lJmVH7+CLCdYqWRew9bLwomQl0j4856hx7unGqBi?=
 =?us-ascii?Q?gCMpE0crBefi89L5FYTr38dC94wKpoxvpMm+Txapvo84XOZvvXW6Y3/uDsfz?=
 =?us-ascii?Q?o/7OzpJJu7M2x+5UTukoTAQbWJeFmkOY4RBl7++AiW6Kmhem+cCn5+vuhU3E?=
 =?us-ascii?Q?39uPCMtfZyP2s4+TeHX7cOx6vG7kO+Eu4Xx4mXexl13MwLScHHSl4mixw/Ia?=
 =?us-ascii?Q?M4uOdashydfAjDsbkyMhPKfJ9IrW8pkzDD+YgGsOYzo5dJeLQpTt4bNvG25X?=
 =?us-ascii?Q?KMokRwi/hG1hJhMghNzUhsp+8rLDo/IcF4h254R/esDA5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IgXvzsHbqI5UIJfki3Vpgwz0GKb8hSlEFb+7/dZF1FdCYKStwZCYcEukjUNl?=
 =?us-ascii?Q?7vH4am/AU568DqxIfMitvJ9SethB5+ZAVGFCfqZOf+hk3Ymc4A+1f5LTtjEi?=
 =?us-ascii?Q?TbJCiBMptRAMm3o1xVmuegAC4rK1T2niC6sftNDDWqQa00YpF3E1MDt2Bbw+?=
 =?us-ascii?Q?M6rGQv7ZVX8O1viRkko4QtCtGdAq/PwJS2JJHk7ub5ZJKqjVb85gD00yEhbc?=
 =?us-ascii?Q?CtSVlKzTPb0fxmaSoRzA7H1sV0Xip8yqmI1/I4V5/k61xcXGdgI+39YB2y9T?=
 =?us-ascii?Q?Fj9VrpCxni9KyGVFlumZk9Gu4ZlC2BJVuWxFR/FSdUcn3V67GEyU1wgPKH9r?=
 =?us-ascii?Q?0K52q2QJfd/VNb7eGLEYCN5o7udEk1dPMMLSgXT5yopBPrINUPW/0j/AKr2/?=
 =?us-ascii?Q?4SE/5Xrk3Qm/2Q2iwxtEonLFMm7PX3hZeeqsW04/pksZy68u/DMW9DprK5aZ?=
 =?us-ascii?Q?bZGi/sxtJ0nJEIoj/pLwf5UIVTQTWLodJQaa+W33OgguwPpU5Fr7m2cbBnQx?=
 =?us-ascii?Q?j94DWluyu0vZIU5m55zbddPSbfadoH8yA0xo9LkuJATIuvrA0Rw3+7RvOuw5?=
 =?us-ascii?Q?B2D0pvOcUAtYp+M+aDY5Jh5IOETkm8fdxDfr3zgeNCWfrXP2Le+WVKIxKLnd?=
 =?us-ascii?Q?pjUQGW0O8hZgovrIKeFFe4/FvCBT6/64a+0kOi4oK4hGZVZ0nPRYxZjf2/sS?=
 =?us-ascii?Q?tMbFhoiOHiwEx5G7VfWdl90sQYdSQ2jpywJdHUqhbN1wwBukXnMa7Fd4CzDV?=
 =?us-ascii?Q?oAqjPn2d6mEe8RRzFtNISXJjQ92aTY2lX1KYakkRw/3mFNfGTmv2LBL1KFgU?=
 =?us-ascii?Q?+14NlhVEm4K5tU3HC7j459yespWfum0pHCI2mCkkX6dW7UtSwGgT/GexyftS?=
 =?us-ascii?Q?6ywqZ2+DRL6x3pKXyMtls0LBB5Jdbc7iewklnlNM8b8EXoQAaGNOdBFzmWjO?=
 =?us-ascii?Q?kBu9s3Es8qPjes5kVKYPN63PJ1nErHlDNTJ3DTz4LOg90CxanbG78/KWjiDq?=
 =?us-ascii?Q?+rthQz4A6pOT0qzISW8uV6mxKzvzZ2sIKkyc7qUkm4g5A/FLi5nL6lRyd1PU?=
 =?us-ascii?Q?ZYRITLkSQtoWp/JyFMMkWz8Il6onifU0FKv0Rs/w+BiPuuEHc9FuGM6yaE+3?=
 =?us-ascii?Q?qQJubgGRLnvmZLLwDc2XEkNlVYOBEkuPWfitIJi2GCD9J8/xnzzRaUDgWi3b?=
 =?us-ascii?Q?0gPKTjSiQFUIYueMjjXfLuc6uZMEYuyYOoM/ghKu71Vu52VtyCf+rcqR/acs?=
 =?us-ascii?Q?9ruUOZdiAwoGIByr50jjhsIbIH9xIGWjHqPrSYncW+pca842y7lpyRpGvUt5?=
 =?us-ascii?Q?4/7zwDrEd+bufH8mDikFH3rouC5TCBjv7FA5enQ24JNZXUv9P7g58bITBtdg?=
 =?us-ascii?Q?k7GdVg2TyxfapDG77+tXPpOqWDmdM2K3wOynJibSQ+Cw0UQcDyY9VCkg5M0q?=
 =?us-ascii?Q?tFlZJdqri4HuOWCPrWbzmyD0UOD8qSe5m/YzsNMKR5QZSEGLkK0ihMxmbqnu?=
 =?us-ascii?Q?DKna2GEgRG5y8Wf1Q2fYpuO9zpcm85fbsHUW8r4M9O1xeA5xqdI3KFtWvVTv?=
 =?us-ascii?Q?FuYekk+LMcm/beNOrHvwAdb2F1/+6oNrjTNbdKjM3jjqMrkiCbwbtgBCIOUv?=
 =?us-ascii?Q?L0w/V4MNKKprpALFohey+oNjzKuOwk39hMPmuOL7cKlzjDJaqzW9FtCBUNNZ?=
 =?us-ascii?Q?HKEgjQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b23a2c-83b7-4962-47e4-08dca5c5c9ca
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:33:29.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlPzl3oJJX7ykaT7BTs9NNNlspDzliMQuIQY05aoS8UjLxS+BzxcKZoPyR7rlXWn6W0aB+mekEgbYAzWT6F49t3AHLxRYuAGzC6Q0vLe8S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7829

Add a long-term latency test that on physical targets namely the rpi4
and the beagle bone black. The test will run for 60 minutes and fail if
a worst-case latency of 150us is exceeded.

The long-term tests are only run on scheduled pipelines. Therefore a
scheduled pipeline has to be created in the xenomai-images project to
enable the tests. Running the tests at night is recommended as the run
will block the hardware targets for the test duration.

This series was testet in our internal CI.

The custom xenomai patch can be dropped as soon as it is merged into
next.

Changes since v1:
 * Test runtime is configurable using the TEST_RUNTIME_SECONDS variable
 * Test timeout is calculated based on the test runtime
 * Configurable maximum latency threshold per board
 * Use lava-test-raise if xeno-test fails to make the whole job fail

Tobias Schaffner (5):
  ci: calculate test timeout based on test runtime
  ci: Add a long term latency test
  ci: Add variable for additional xeno-test args
  ci: Add latency threshold to longterm tests
  ci: let the lava job fail if xeno-test fails

 .gitlab-ci.yml                                | 10 ++-
 ci/gitlab-ci-base.yml                         |  7 +-
 ci/kernel_6_6_physical.yml                    |  2 +
 ci/xenomai_3_next_long_term.yml               | 21 +++++
 ...tency-treshold-option-to-latency-tes.patch | 76 +++++++++++++++++++
 recipes-xenomai/xenomai/xenomai_master.bb     |  3 +-
 scripts/run-lava-tests.sh                     |  3 +
 tests/jobs/xenomai-beagle-bone-black.yml      |  2 +-
 tests/jobs/xenomai-hikey.yml                  |  2 +-
 tests/jobs/xenomai-qemu-amd64.yml             |  2 +-
 tests/jobs/xenomai-qemu-arm64.yml             |  2 +-
 tests/jobs/xenomai-qemu-armhf.yml             |  2 +-
 tests/jobs/xenomai-rpi4.yml                   |  2 +-
 tests/jobs/xenomai-x86-64-efi.yml             |  2 +-
 14 files changed, 125 insertions(+), 11 deletions(-)
 create mode 100644 ci/xenomai_3_next_long_term.yml
 create mode 100644 recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch

-- 
2.40.1

