Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568119A
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212680; cv=fail; b=Aa86ZiNosz0IQMUKaEMJ9HNgVOYfPwc/iUdn5ynxRmwITUq5hLbOQf4cqnG6GidXHk5asfCYSdr8vvKWwsJ9bT6uuT5h0iK7b+s3mVkvZ/157Wurt/gWDy76MZ3sQ/Q6JMIXiktCta7XOTPkZ3qwPprGgaeHDsPhSOBIvJye9eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212680; c=relaxed/simple;
	bh=e2KVDkDDDQ4NvlMMxAr8toNQTJCv/lcv73Dz3D8jlLc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SWtjore6WICmKc2JoX0Xtmi9+azAydzd3cWVygq+OArYNWA0IlUiozjgxU3XYk9ggtzPxGlQC7moy/YQpJbHjCgulwdnbIM9cNZnCwuMKEKn+jPQgVxLBIoaQwvNeoqsqoAG8sW54P5dFr5F/szIVxcvsYwm/jFCbI0H7F/jpyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gj6jp9T0; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gj6jp9T0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKwmPsDcTTsIqsk2BHIJC8wzRu89F3W356fndzZVeoM30DHdgGmKHfEU2HGixeibOjMGo52ErRrqcaIDII2tBUWj1YoUYdC1SYQLjCouQtiqPLIZ8abiCQWGr6cIPfj577QPKoTbplvg6koMoAEDCFVJICvbLiRe+/S+oAAhUjjFser6oiUOPVhfeVt5RcEGvQHa09Zwo7nT3TtnRS3TZCML8s7f+q/N9PqBYD7NeL8bxYrznxYdfTHWYHqxSqg7Z8qJph7/eX9OAYosb96HfR/2rE/71fxWAw+YqQ8PYYPT7KlGRjQsMVzfFH1RoSidp4XmOcirqppZqyBsSGIV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epNWi9JLIroPmV2BWDAfKuDzAjCP8FfJRYiT+4RGPpM=;
 b=NX4/rj3izFvfX6nPNUXIEkXfTtvbk7/OXWz8zY0vk/Yf1E9mouL1P1VdYSfC6/hFCgmigJLhYlHF7Ezmm5utuF3o9+Vy7/YGV60VTGTQlwtan4KTKn2vr9WrRK0ToFXIMsUHC3S5Dwz4aOVMBvuXWsEs4vmDYNHqzjmkT9M/lU5Np5cLGiHwbnGoCSZi/GCjmKLAzODNJtYdw+VNMVRdwAjEh0xfKoPN/cTpY/tLnVL9XwKjweyvTdHiBoc+cc1vT/h1ia2R2OVyrhG+lzIrwvi8R1iTzy7eMNoNGrtTzKyuJuJMnRa8mHNexon/enBeOL6CyGnnvBt9lU2NKJe8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epNWi9JLIroPmV2BWDAfKuDzAjCP8FfJRYiT+4RGPpM=;
 b=gj6jp9T00ipktZOfPGHOq8eMuSxxzmHk5puiG/6xFWHzQUKU2v/vWTyZpGKXeSYblhOqGnk+tjOcJ8MllxaZsbV/6KxSDLpBksV+S0XI9MzzdHV2zzVv6pUTRJ1UEBl9X3VOQufjOitb4UxMfsrEbcopgLvRAoLLqQxOtb+8ZnandLyKw2D6A+Xz9rpbTBrnoY6MkUiOU0q42UIAvgl8tf8M+2U7JiwMDzTExZUEMSI2KgsOgPIV4ZEiY1ImLFmEyG6S1fsR5J0oUY9NHay2tkmmEPZ1o+imPiB0KS4LNVBj+zOsWa/NV7Xc351bArjB1dZKTPHtpLOOIEZ34HblwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 10:37:54 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:37:54 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH v3 0/5] ci: add long-term latency test for next
Date: Wed, 17 Jul 2024 12:37:43 +0200
Message-Id: <20240717103748.161788-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:610:54::30) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d09560-447b-4b3f-6e37-08dca64c83e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQUuyOfZln6/cdlpsMd0yhTmX1F/f3RV8Maks4Oh2UrwjnFacQ6C6AP/vkHg?=
 =?us-ascii?Q?zKt10JKdIJN6Nq0C5otyP7dcSr89y8BSu8e4mu5VGnwqqSm7i5w0o5LB1beW?=
 =?us-ascii?Q?4qYtdd8LEvFQDihX2cF4rS4X5hsldSZFrAeuVd/T32sHFszYiRjiuPOaOwlq?=
 =?us-ascii?Q?u9gI+8esYMV1tyYgSDXWaYnUIucjwf2cM6HpL4DrwYk5i8Qvy19n8cmKOi9a?=
 =?us-ascii?Q?ZK3ZKeHivFEaU7TUPLh+Zsb0ylLNr5sm31tzqYjXZW4RnZ2X7vC/iH9LrbOE?=
 =?us-ascii?Q?loenkUBtQc8GVsIthjWu7Z+b8Lvd2IJa2LCsUkHRzb61irZ+UMQpgDlwPxw4?=
 =?us-ascii?Q?pEoUOZSeFwC9jyuXcwcGWeOx0fagykZmBaMfRUKdxFqCMNLXvKYCmWY3ndme?=
 =?us-ascii?Q?9nuGw6/w0ex6iCJqJkH6tIB/EmV3fD1Dt+UXBtSfDoQWVePf/uYhHeZohDU+?=
 =?us-ascii?Q?f5Q51EPM0pDdfj6oEmfM8tlFThLzKdsW2Njy7eHU0ZoKZny94QlQlOIK1bPv?=
 =?us-ascii?Q?aLxqQzhW9iJpJ38c9eoGVDypEyWrC//UbUj74hN+HD9hxbSjk+ok9ib3NqAi?=
 =?us-ascii?Q?NhnguSp5EIAXdH2QRi2UhusGxChKGinqtNSR8ltTamMKuaoksya1x7KImZ/v?=
 =?us-ascii?Q?YQJZGZiBTkt/EY3JnEcTiFVQKnJTnVZAZfOQKzDlqDxYyGraZ32H2HP8in01?=
 =?us-ascii?Q?ZJ4oOgp4uD37mE3adOTWVBJsh4HGRiDhaSDPTv92jBAs90eDk2tfXPscPxrU?=
 =?us-ascii?Q?Y/EvT9HcQoLkAVTAeyMuOgALi3EzAiOZTbAtM2+hlw9F77xGJ3J8I+H/PNky?=
 =?us-ascii?Q?mYkjUna1nlikpoM8YVyuki3zOHzBfCbFg5JedBC4nZCDFyN0zg8K5QyeJs3f?=
 =?us-ascii?Q?xq11CuUryOPMeczHBDVAf/jJ32mc82aOmPuFHSIvyfV7jvQDEovtv4ft8UvR?=
 =?us-ascii?Q?B/P0LpyO7snwwVe+CLVAf48LwKG/LB+XbOMdx1Iu+COSrXjeUzJMoTJR85OR?=
 =?us-ascii?Q?93iW3AyCFjszc4ouPHWCy3CT10La2mbNJUNNnXUHL3G0flJbaFZ5AdiHj/Qp?=
 =?us-ascii?Q?k4FwIAZPdEgLzBdQNJZzmDDDFc5NF5zm6FLNLN3K8jwq5adthe+fQOHjWXip?=
 =?us-ascii?Q?xsPs/xWLbZpNTuOTbv7wuZujODjgkA05TS8O+E0C4G9mN1wjZu0qOBkm3o+t?=
 =?us-ascii?Q?TBVR88g1V1pGaRVPeqhSBMHq9ldbxipmKH+D2PGh3K59Ve4coLJYYHaX5miP?=
 =?us-ascii?Q?k22Udg03nDBXeaoGOfSPXHb2MUjEoug1T4yJJRhPWWBNuvmATzdKY8gZOmoT?=
 =?us-ascii?Q?XTnUPP1oPXlr3ZaQtt1meCR2On3GyhzN0KaHfu9Fsb3WgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K1fx4eUbM4rcLgpcSa/ObetSyumHQjEBz/lT7fEmjcKZmL2oC7IC3cX2b6oc?=
 =?us-ascii?Q?x5yk0RzJDrZQ5Zpgl6psk4mUKeO5UB4cwqR4vDJH1DeIteO7N77G8UiOBpaJ?=
 =?us-ascii?Q?Rkg4TdzDN56fUXazJHm+HFESj0ki+IeuOm21nI/fDWt0yfqQ+6hln5uaIVth?=
 =?us-ascii?Q?lh5ACwXgieHXnd3FLVC8/m5wxqsBM7TjhQTylTl0z85QPfkVG3sv1TVNq1Ss?=
 =?us-ascii?Q?Sm2Qa4rLprtTVngKJvnBhvoV1emUf6NaMyosp9PqSvnP/PQYMGncHk0KP67V?=
 =?us-ascii?Q?Av5FTvKuhtvYfYhV1JmxW4JS2ktGf9KfBiVvg7PXBrkaPjbztsr5IBOAEKtM?=
 =?us-ascii?Q?Xv1hpVCG2wS3LTwDvprnv5jsONBci9aejLSLQJHmrrxDsEtphGa0SnNtQaWF?=
 =?us-ascii?Q?zKNRggpVriTTvNFi6vciQaL851qsUunhc3Ko7ulOdrBnhXv1riq4gKSybNUI?=
 =?us-ascii?Q?QR6uYH8x0qIP2u90KWfARxgj9DZN90B+jBgaT71XCKG7to5UHGrhmQmOE9EL?=
 =?us-ascii?Q?682EoCXzAOWwKTaYjQNccicPGUbKiF8+d8qtHiT6uKmx2/2LID+n+Cr7Fjp2?=
 =?us-ascii?Q?Qy/KGNnmcBTM6FY0rV/LhxmaOV9vqC1Ek152tLKBI+RCB/5HgRdgRN6jb6t2?=
 =?us-ascii?Q?94h2JySzRgGGi/eAfr+xTtQWoxL3wBkYsk3Lo67MozIsoXxnmFQgIduQeuxp?=
 =?us-ascii?Q?z9XXp9FtSVCRIppJJSau/lhYqYFi71xwhId6bc/E2TNSCzqOXynlB9sKdCsI?=
 =?us-ascii?Q?gzXPZn1PMfj15ng09LNri4Fb84ht6CDshacS+X/wg6GtEjxn5uu9Cy9zxpc9?=
 =?us-ascii?Q?1WuyEz1kCyQtGqz1zfPtmeakpQQEG1z1I0dJsEXf8J4Yykc67Wv/CwFF/owp?=
 =?us-ascii?Q?EN0APuFxJ6yQppeTjAQRi8UaWISy++rbJC09fqOE+oGss3ruB1UhR2d4RpWc?=
 =?us-ascii?Q?Kbpt3LQvgxNxyF/QaqVf1k7WkbiyW2RNdOK4JcuvIx+JUJEuXCIzS44cNagv?=
 =?us-ascii?Q?RtrGgqLRwefjPbw8WUB1dVy2ao6MEqB8dGStPDAAo1Mn0uZwOIvuXX8ZmpxE?=
 =?us-ascii?Q?RbUUaIjYCFCA9AGgmsKaw4ptsfuPDzd+Kh0xQAolykAPKS3GwxnZIOvehqLu?=
 =?us-ascii?Q?mzySgyRQyrKLtaLJbco5x+iO4uXcoCIiTOVo2oDbPUIsOMf4Q+tNCgB6au20?=
 =?us-ascii?Q?DMrwukXylTsvnwLpIad/Te5ffxI1HwEHhx0hiLoqVX/RWhqFTxuVcnipd4Km?=
 =?us-ascii?Q?5eozNIHMkP3MkGjsFkSWmcrOiURzertac4HLaRA3VoAT19nezDMY3/SyS4cn?=
 =?us-ascii?Q?HzcJsiUvDGPp/azv1Pom+T1xnK3aShyRG+kxXPS1ALuf4n/j0K+7zRpPHpxi?=
 =?us-ascii?Q?AFqo9l4smsd2dxs+9bcDMVRdF/titFwj9AnpSt9ZdcSEu+kAiKOcUVbMCCDW?=
 =?us-ascii?Q?8y7T03UYJUj4G/xbQt0aDXSBQr6KA9HFQYwTcZjCLgGiLWMAZhuCaek681/5?=
 =?us-ascii?Q?qD3KiJqR01wwaTZXGPFj/WqxtrVNSLlwiNcI49LbNYufcWPVE+UeXYo4fFBW?=
 =?us-ascii?Q?TiQjtZ1pq865ETNLzSkj16cRxguT6sQtQIbsfPKzfEVwIiWQg/pYU8chQcyd?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d09560-447b-4b3f-6e37-08dca64c83e1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:37:54.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IA2GxPHlJXwV3DgGHJrCeWSUl4namabRT92BGResnV/1iHvIrsaSgQBRO0spn21zRAVREHcxefp7uwcrv4HPAfH/WYQE9ogDweYtiXV1mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6439

Add a long-term latency test that only runs on physical targets namely
the rpi4 and the beagle bone black. The test will run for 60 minutes
and fail if a worst-case latency of 150us is exceeded.

The long-term tests are only run on scheduled pipelines. Therefore a
scheduled pipeline has to be created in the xenomai-images project to
enable the tests. Running the tests at night is recommended as the run
will block the hardware targets for the test duration.

This series was testet in our internal CI.

Changes since v1:
 * Test runtime is configurable using the TEST_RUNTIME_SECONDS variable
 * Test timeout is calculated based on the test runtime
 * Configurable maximum latency threshold per board
 * Use lava-test-raise if xeno-test fails to make the whole job fail

Changes since v2:
 * Move xeno-test job failing fix to front of patch series
 * Remove custom xenomai latency-test patch as it's already merged
 * Run default pipeline on every event except 'schedule'

Tobias Schaffner (5):
  ci: let the lava job fail if xeno-test fails
  ci: calculate test timeout based on test runtime
  ci: Add a long term latency test
  ci: Add variable for additional xeno-test args
  ci: Add latency threshold to longterm tests

 .gitlab-ci.yml                           | 10 +++++++++-
 ci/gitlab-ci-base.yml                    |  7 +++++--
 ci/kernel_6_6_physical.yml               |  2 ++
 ci/xenomai_3_next_long_term.yml          | 21 +++++++++++++++++++++
 scripts/run-lava-tests.sh                |  3 +++
 tests/jobs/xenomai-beagle-bone-black.yml |  2 +-
 tests/jobs/xenomai-hikey.yml             |  2 +-
 tests/jobs/xenomai-qemu-amd64.yml        |  2 +-
 tests/jobs/xenomai-qemu-arm64.yml        |  2 +-
 tests/jobs/xenomai-qemu-armhf.yml        |  2 +-
 tests/jobs/xenomai-rpi4.yml              |  2 +-
 tests/jobs/xenomai-x86-64-efi.yml        |  2 +-
 12 files changed, 47 insertions(+), 10 deletions(-)
 create mode 100644 ci/xenomai_3_next_long_term.yml

-- 
2.40.1

