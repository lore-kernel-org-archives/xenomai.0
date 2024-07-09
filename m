Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DB153567
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514152; cv=fail; b=gru339QTROXnePUMk8aJs8brzP44pNRJzf8BMW/yKJleB6WVdBHAf6TE1w8SqrvLoziF6mHQRYGJt97aNhdwdPxILFMrx0WSJ/84ENhZIauUCDQkXTsT4S33PnSLfH/Oq5V6sNTvdTanT+wTPtcTU08q/alG//xNo9evhfX5gyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514152; c=relaxed/simple;
	bh=CNfw0h+duIKL9CondxshLLjedE6YfABGLok0kmh7Dds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJF9ObnKS4XSrUGwIs8w70/DXLYY1LKcPbIrHqc54PQ91Nm1sTtoMukMqn2iJGB89gcT2wzgjKSGwXMTR3pB5OKs55MmDscrHZFi4kEplzeip4k6IriXp54AM4W5XTyEmXiQzihq5j+KQpe0f4qIXMMy9iysGKxOqwGfOIdnaZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=L12HL6fw; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="L12HL6fw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNDSpEXba4dNKUY7kmmdRBFnVQq8vzkaByMiTTKquP5T2c7sLJ37IbwjTp8sIayaOAcV50AZfTa2YxRISVrr7ogws4AjE2bUNFCcGXj6bSGx59Vs/Swml8e6mtCODe+7Zi9poETONwB1eDs0JvfOYwvS3VIkVHMa95D2j+NZy1dVLzQRE/+2CGfU2M+SmAred9L/Zcjw6ogb9udCnYmaXezib5ERtoUfae/uvPVKCsjWI2+j0xQ7MSG4JzqMgp6iThDegZGNfcEdKEkaeoZQji33gdGwH0sZyQ+RMIHSgxxT4c+ZTD/OrwpaRcogHW5zAesFMmaG4xtJS0l6nPoGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaoTVMexwuVsDwq4fAhufJ/qgAXGO4hQbvMhXHPJaKM=;
 b=Z6+TbqDtymShpPwtyvqAg86IcLsG/Nrja6JAYBW4oN1WjS8vv1Xn2brY5Ceuvxg0rY2ZuJIIKNlZn/Ib8fAw7+Ss6DvpS3z8DEkOdeMVqXOIVAHAEbcKNE9n0K7rGAbasZWLEOomy5XmRfwtNZIhGb1sAnn98txhOuP4A1jotTVa+gUkab4YmQIKYJxMxQQZ/Qa3fGVwGtdFfjP3fm23jlL482CcILpBMvdxXETaABVw8VsyZTBR5hx4yFeqRNedI42mvKHmWkdu8pcaCTDPKkaSxUeWPNONPIuD1RQsu2uJ4lMWobwfG9g72PumRZRH+TWMBINJrN3+a0ddVg5oYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaoTVMexwuVsDwq4fAhufJ/qgAXGO4hQbvMhXHPJaKM=;
 b=L12HL6fwCSlfRPEwq+zK8A21tgoet2Dk/AIMMSEfAhfli2dfsGbplni9aLCo/s2n4Dc23dm/eK2xo/VRM4hz1hQDJup1OAdPuP9e3cpLupVsNVVEqN3woilRuKPvjJw4K9NQCEsQ+xQDfdz8l6XqpCN8d63HGom8csmfWUEGYH0lqafrEqVulPfifLOTbOdJoQHCoA011qNFEOnAIct0f0A+MITFNagmCuXhdkLlJIqhu+evWwm4Z40B6ClhmhA7f6byk0uyqSVNwuULujAQ8/9HVLdszTa9rNI1ScRjnh42zrcGzKVp51IB/P4MR6CSLcOh0exiKedHYRppCxpl4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB6436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:35:38 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:35:38 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 5/5] ci: Add latency treshold to longterm tests
Date: Tue,  9 Jul 2024 10:35:24 +0200
Message-Id: <20240709083524.739194-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240709083524.739194-1-tobias.schaffner@siemens.com>
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: a08fe2f3-6a2b-4266-52c9-08dc9ff21c0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJfctmtp2I9Z4Z+s+doDOR80UcQC05sCI3w1gZ8tdUXwManDtw7p4TTFb/Mo?=
 =?us-ascii?Q?7RYUMVoMLmSoGbs9ecqhLUZPU4s3hF9YagTThyKgn+cshnR8sioLYcJAyOZd?=
 =?us-ascii?Q?gsFFVPtdasdEOUc8jQg0X/waDi0ad5+ZRFZ8JlO4BwGn12F8yrnEgS0nVljw?=
 =?us-ascii?Q?GSJfUwaCSKtOyKEvPeBftmkcBiVyR/e23VKwvVRJymqpyv9Oa9z3J8gnIjyZ?=
 =?us-ascii?Q?IndGUcTxotSE7q1Qn0SaXbFYacXEUwewCxsyb+CL0c+hDfRnEp30lhacwlUz?=
 =?us-ascii?Q?L5sNMtpknztDuWO4rCsM4brkGXabPsUt/lTSiJHf83NfIj5EzcEbT9f1zdag?=
 =?us-ascii?Q?NHlqy/ambzBO8plao3taFEXDcE+2AAueDZiEhT3O4aAgMg+HXlD1IF/QG0Em?=
 =?us-ascii?Q?dfJIeSky/5w14ZCjdghB1WGFcN56ixKcE3Hw0CinaGPbCLuic02VdV4tev1+?=
 =?us-ascii?Q?lQ9sifCPCgFZhx3m83RMvfp3wVMRWxPzc8WNq3JojgKDn+Hp+c110xMUqBck?=
 =?us-ascii?Q?8pj5Obf/39p8fPox7mBxCf6p4Mkd44zYOYdL8BLsKd+XGSWkZirSJTTM9x2b?=
 =?us-ascii?Q?nAZVgyLob2a0WUBGGlNn8xk0SNgyN37uHyzFJeqfYJNKOy9lEOu387MhzsNw?=
 =?us-ascii?Q?XT9yLg8Xgi/xK5dKgeRO4CpeaIVHcTzmd+43u5V0BmyPCebPPve6uGuH6qPu?=
 =?us-ascii?Q?ZDYwpV0FZo5WDfpNuJXuF1Hj28HfwrFCcaVfPlCUjB/AkC7t3qR3FgaJI/Hl?=
 =?us-ascii?Q?68iOA/ikH5f2QPRFGN/1FC3vmT9DA639kLcBu9BOZWnBXWx9mYckzpcHmZtg?=
 =?us-ascii?Q?wvyacr+PH9ofpnYsqB3ja6cXrvFxxLfEGBxxGHQE2KYNcq4XLskYzE4O9hEM?=
 =?us-ascii?Q?c0NJi8ou8CaSVxFuQEDw/3lFJDlZmNZ5sfUF7TjbEQyBJ8csH7AGlA3QryE0?=
 =?us-ascii?Q?aoDEXUnNJ74K86KLjwe22PtK4FIRjQFJorCcNjSGaW4900hHejELycGXaJRV?=
 =?us-ascii?Q?AElYSv+7InarUeFqVyBGVYykC+ZIp8XiSPwfgXZNM8Z+u5qZgt2xRQ/eYw/f?=
 =?us-ascii?Q?ThLPv+7K5SekJmoxBRqYiGdDIxS/29cGX6PzymmT7f4p9pipgj/Y9wef/6tK?=
 =?us-ascii?Q?5TJzes/HE1pj+GDO5IkPbn180EbimxtB/KCj4L2di4h6y6eMP4yglJXM5y18?=
 =?us-ascii?Q?8iC3D7SnHyiFx3JkrU+zdRvhHGXT1RrjDyEcGF6V4bsAsPjYoKCUyx3J4lq8?=
 =?us-ascii?Q?ILItbQzNy5AvXLzAIFCdNrXvWveXBYZIaw/7Sg+1fE6kTyfLXWj76PHj+ifB?=
 =?us-ascii?Q?Gqe0lDAS88Xvi1QzXc2TkK0CYXkB5+PUFqZB5uTRR0onVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5G7TvVftv+rNCBjZ32ARXYQZBArvUP1X/CDB9qDcLWYF6W90oRzKuOWzM5ow?=
 =?us-ascii?Q?sL62AN6ZA1PvUAkwMfW84jUt94/+bx4UwUi9s3OUMpE3zre+VDOyaifjhPFo?=
 =?us-ascii?Q?crss0tjM4aINFr9aCbfJrNs0039TRmBsQzLUW3mtHf6Olpp0qx0FYCOgxy79?=
 =?us-ascii?Q?PbZg4MQCjZVdauuobzdXonFEg/t043n7YgRkBEDy0pAOqlOD71eaGiDtA+oX?=
 =?us-ascii?Q?Jyzdv6Tc7173fc03dYf3wv1LEwpDuifzIMngW2yvNtft+lkPMI604UvbrrtO?=
 =?us-ascii?Q?nxn8It3EiKAj2oJ8QZmZo0rBTw+tbNiENEv2Gk26GPpiBl/i5tOlqyskzJGx?=
 =?us-ascii?Q?InR0v8lRUgpFnaOXemV2M+ag3YZxqr6pfOHg6CzzLPO22LCsI70X5gwXinQI?=
 =?us-ascii?Q?IOv7ZzzIR2RxwUVZAb2f48pfI7UxIkI3zFV8ESiCx1Dr/KdWApcMlOeqIEMR?=
 =?us-ascii?Q?AtHdQWSUqjdKUKU1gos0kkLvVdmmKGg7UuVQpZhMm6MdnYyWhsNgl2y8Yfq7?=
 =?us-ascii?Q?BFJXrsFo85leqTh5/roO/f3+ugk7ND2v0LPCAVE9bKIgBczfOQkzhIArfDOX?=
 =?us-ascii?Q?O/PsTFNjR5qFYQGk+9ybq+mIXSRjG7VUcoEoMndKwpTup1ugzf93blFGal92?=
 =?us-ascii?Q?+AUQDIA0SlAz0iYQFgGcEPEQwMV315VS6DeIdwfuD5xXTvLLJzNqQh8opdjK?=
 =?us-ascii?Q?FTwYqdcNrrdVW1lrU2ImeGxQmMFht1dpMeGafmTcSUabsYcvwgR0WHJH2xtY?=
 =?us-ascii?Q?gptfyWTLWs2Rn4fOG9W4Yi6GkwCcijZCcevbFOZTPI1NMeFlA1Lkm2DJzcXo?=
 =?us-ascii?Q?jPPL3SD0ho87tql69o4vtagOtupaAOjW2yVV+nFYC3ncU36v4jnBL2ZK3OXs?=
 =?us-ascii?Q?j7VnzFG4Fho7hTOx2vVTPaqTDu6/kpNEFKhS4T+ekM8aMe3Dk5zJqRfLmaF+?=
 =?us-ascii?Q?1ONnx9rpBKFMD9Hlr8WM80dQtcs3on9GrQqoraTAupO9MGEQnPEbLipSpMy1?=
 =?us-ascii?Q?LxL4K/7iO2NTWf9nafAGPCs+zOZSFJYi/9pTXxZ8ntoBrnCAKmohXLFK1z+E?=
 =?us-ascii?Q?EnHqYoHGRXaltI0HC9Vx+EjBnwLK5C6U73Jkk67Rnhq4/hVkvpttPdnIJD1z?=
 =?us-ascii?Q?3vcVyh39tzKy3Imu5xzClHGYK8Fb4NJSUB3vP+JaLnKMsOIQDPiU801sSZlp?=
 =?us-ascii?Q?4ImpGYW0KdD45upjHWmtRTCcWHkT4surusss7O/juAKC8yy/OIoyu6ot68jN?=
 =?us-ascii?Q?fhrliPcEsVE4XdOwq/iI1ttxp80oqwL0YKVJ5DHFuOWTzqUjfDjM9vxfvGRo?=
 =?us-ascii?Q?+GzvqovoW7gDyLgX7Rwb0oHJMyDOOin5iS9ZQltcdgWjEFCgE7Z1tX5E0V3U?=
 =?us-ascii?Q?VayGwEuEGVcCkBVJpCLcdxYLC//WzdHnpK90y3uauHBba9o3Osn8u8hyep/n?=
 =?us-ascii?Q?LFZDc7VSoqt2+DHeS6eBwWkyrFfD4RIrn3v+6SW7TUgQdCDLcvqFA6ndeCZU?=
 =?us-ascii?Q?YErq5hXMmHp7W08VUU9CuaIdWKpL4r3q4y6mJVMqS96z6dUFSpDP5PExNgYR?=
 =?us-ascii?Q?D3fhlFCBz5C0vMkO1v5M0x2v4kedKycxVBdtQ1MzyQM70fjZBneyT0lZHWF5?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08fe2f3-6a2b-4266-52c9-08dc9ff21c0f
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:35:38.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZDZsfhbcPuymLU/MA70MpvDWeugjU5e6B3VUPT3YhhzNQaE01/ImoRnPAmz/+9TLcIHhtVYY4zoEOKeIRqrPH/mjZqPYcPaEFK8NPbhHIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6436

Add the latency treshold patch to next builds as long as it is not
merged. Use the new treshold option in longterm tests to guarantee a
worst case latency of 100us.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/xenomai_3_next_long_term.yml               |  2 +-
 ...tency-treshold-option-to-latency-tes.patch | 76 +++++++++++++++++++
 recipes-xenomai/xenomai/xenomai_master.bb     |  3 +-
 3 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100644 recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch

diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index 0edaca5..d5a93a7 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -17,5 +17,5 @@ variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.6"
-  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 3600' -- -T 3600"
+  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 3600' -- -T 3600 -m 100"
   TEST_TIMEOUT_MINUTES: 80
diff --git a/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
new file mode 100644
index 0000000..6adb7d8
--- /dev/null
+++ b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
@@ -0,0 +1,76 @@
+From 032a29ccb649cc2d076f14e7769bdee8eba8ecfe Mon Sep 17 00:00:00 2001
+From: Tobias Schaffner <tobias.schaffner@siemens.com>
+Date: Fri, 21 Jun 2024 09:35:08 +0200
+Subject: [PATCH] testsuite: add latency treshold option to latency test
+
+Add an -m option that allows to set a maximum latency treshhold to the
+latency test.
+
+If the option is used, the test will fail if the maximum measured
+latency is larger than the treshold passed in microseconds.
+
+This is mainly implemented for CI long term latency tests to
+automatically let the pipeline fail if the measured latency is higher
+than expected.
+
+Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
+---
+ testsuite/latency/latency.c | 14 +++++++++++++-
+ 1 file changed, 13 insertions(+), 1 deletion(-)
+
+diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
+index 7856b48b8..52e315d9d 100644
+--- a/testsuite/latency/latency.c
++++ b/testsuite/latency/latency.c
+@@ -89,6 +89,7 @@ int32_t *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;
+ char *do_gnuplot = NULL;
+ int do_histogram = 0, do_stats = 0, finished = 0;
+ int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */
++int max_latency_treshold = 0;	/* default = 0 (diabled), -m <max> (in us) to override */
+ 
+ #define need_histo() (do_histogram || do_stats || do_gnuplot)
+ 
+@@ -536,6 +537,12 @@ static void cleanup(void)
+ 	if (histogram_min)
+ 		free(histogram_min);
+ 
++	if (max_latency_treshold > 0 && (double)gmaxjitter / 1000 > max_latency_treshold) {
++		printf("\nMaximum latency exceeded: %11.3f > %d\n",
++		       (double)gmaxjitter / 1000, max_latency_treshold);
++		exit(1);
++	}
++
+ 	exit(0);
+ }
+ 
+@@ -614,6 +621,7 @@ void application_usage(void)
+ 		"-c <cpu>                        pin measuring task down to given CPU\n"
+ 		"-P <priority>                   task priority (test mode 0 and 1 only)\n"
+ 		"-b                              break upon mode switch\n"
++		"-m <max>                        fail if the maximum latency is larger than max\n"
+ 		);
+ }
+ 
+@@ -648,7 +656,7 @@ int main(int argc, char *const *argv)
+ 	cpu_set_t cpus;
+ 	sigset_t mask;
+ 
+-	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
++	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:bm:")) != EOF)
+ 		switch (c) {
+ 		case 'g':
+ 			do_gnuplot = strdup(optarg);
+@@ -722,6 +730,10 @@ int main(int argc, char *const *argv)
+ 			stop_upon_switch = 1;
+ 			break;
+ 
++		case 'm':
++			max_latency_treshold = atoi(optarg);
++			break;
++
+ 		default:
+ 			xenomai_usage();
+ 			exit(2);
+-- 
+2.40.1
+
diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
index a2e8802..07a63ec 100644
--- a/recipes-xenomai/xenomai/xenomai_master.bb
+++ b/recipes-xenomai/xenomai/xenomai_master.bb
@@ -15,7 +15,8 @@ require xenomai.inc
 CHANGELOG_V = "9999-${PV}"
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV} \
+    file://0001-testsuite-add-latency-treshold-option-to-latency-tes.patch"
 SRCREV = "${AUTOREV}"
 
 S = "${WORKDIR}/git"
-- 
2.40.1

