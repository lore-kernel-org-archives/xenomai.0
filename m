Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19E38E5C5
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012196; cv=fail; b=of5xN9bLUebJ8ye/+kCYfwcC2obwmqsmmcmld6oMzhnPnoO901+PAcSZEzgaUfNu/ASvDrRm28LBRLcnAEuH1diQi8cZOP+X6jDR7+4vwg/KjkmU9HoFoPx+qb6pq3vOFMUOqM7vPNIhumjHOvFwGLwnUmzMARsdSIskcMAKQ1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012196; c=relaxed/simple;
	bh=Zpiv3LiebO4dnUly/sXdwrXkVRG6PaZvwMIeTEirobg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EED2yreOEvP+CRCvDgDBgJUsEI3QViaKcnh2K6sKvv6T4HHhCcPujqLODjkEunC7GSAn0+BNlyyjhixmb5cnG28CC/qcf+2KiIa05mUi4huHX5bE0DdJiQArMB5RIFk5qMLuF5pyyvK0VjML8XbghNoGI2Ly8UUbPmuAJPn1VyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gIZquQkr; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gIZquQkr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tyw6PIGuAdPMAHT90tMlwMPfEPlAtHUxKgY/C4BiSgAK5SuQM/FcBplZGTajMYzC2Q7KP1EDj1xTkYSyTLmnVeu3Wz2L0Dzt76ukLNmJ/3sRw3UUnEruC73uaXLJCRCSvt7z9SQxenAfGKHBF3ej9bIvgPy5OUseJFCF8UoCfo3hfq6Wb6DYmzATE8Vn7yWp8ICVmTPyGlEt67l8NFnoFtFD+OX46nnlbmXFsdqw2i1nv9PI6YFUsLwV2IBWFvas72kud9V1zGR9Hfiz7svd5wKhE/MUuBtw5nPGW9AGU/+E0lcG5o/lApguSZxPXtVe/psP8dt1mA7qap+U5ChomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+9BvQ0QFd7rJiaMxW8GprZOGhGhTZajnWuGAroSxTc=;
 b=HCcmPiQdpSa3/71Y9TouY9D3AVbksyVt4crcHNrpRFN5bbhlvtiKT11Pbg57bVT9BfEgd/syp3KWCqIoWfzmpstFHqntqg7pSvWFM/I/I41UwPnWkLze0NCneDvKO4vA3Wm0n+Pmhb3YOFfMU29ZmfLFvlSuv73dbPHFK4mnDZb2FN+zZG7Wrsvj2YM2D0ncIkb80m5fJKXBUip5Clb0dQxbxhBzvucfj0yYiYHsC27OYOz0nw2wYEX4N5n/cxdRhx5FTi8C1pZ05eiD3mVkZdNWAEXwE6ctDrd4WMYuSFZYoWsTxyD9xnDpG2sjEgKN0kF/ilWl9EhDyoXrnw/ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+9BvQ0QFd7rJiaMxW8GprZOGhGhTZajnWuGAroSxTc=;
 b=gIZquQkrQSLDqaHhuxrn4CBzgk5hAb6gHQoiLn+85LFfg4px811+iJ6LObt0sPez17XX4YdsrrYhTBhODJ8HbK7BSxbvg1lMKBadSFR5W6NYlfn9i4k/83nlvGnERq6IdPewcD8P1BU7mET67Oe9pGUfZKsbrjEZdUsgptD/jHnH+KcLGFJuK5emQxiITRD0Cbsw96sNMphtnLeGhMZ4wXWW2zxFDSGt4izl5c17H6csTbHgmf7Zj7OR5gVnUxwQAbwfQlbbfMyf1DLnx6prEKUaSAOFCRIqWynblmcfjcgZcOW6Ev6vCnBCSw++gWXC+mkt+FIaDLt3RlkMDesr4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB8155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 20:16:26 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:16:26 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v3 2/4] ci: Fix deploy script to handle multiple DTB files
Date: Tue,  5 May 2026 22:16:15 +0200
Message-ID: <20260505201617.148513-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505201617.148513-1-tobias.schaffner@siemens.com>
References: <20260505201617.148513-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 79254640-8a84-41d5-702c-08deaae32f72
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	UTxsStgIMGjR6EFo5FSKGK3jmyL2iC+WcasiVG/wTQS5pF5RXNf3Xc7GB+kI9QmrYOC31zO0wdFevGveWh85fdD08tYp/WEPuiBpIP1cgxg6bGgJSzDsNgZNjn34p2vwTGgHZvJR6YNQSZEd8KFWnh/temEPf7pKF0302jYoIno7wEMMV/uuA3axgorJl6BqtRF/R2WmclZnpKMuG7B0TK3dvhDVdbBJ2kbJRrKjoqFDBJ+jSlVMkM4e4SNxNrMmwKKPxLbtCPvSX3SV985BkVDupw4DCPdORZvnZvaEgybYLnqMgovvDx4IeXh5/ItH1rsLsoaALo7L2Zj1Mg50aBKWEZ2NagaYay1CO5qNB8DFB0wCBsHTdnLosfhqKRwMDonS5ee4Hh4DLtS4W4m4o7RFrWBCULRqFAUVGkUKZx8ICwcf4MtRFfAXV9kPSpdskISHJQDcN4o/cftAjcCIPTkUqttasvs7dqWSLdBl2ZQAMvbSp9Db9sFiuIDpUi5MHt87xiZ+C/zhhblgLzIccwMCitFloHN9qgx7Awrb03S6MgohXW7Xe9sZ0Ext7zOuO8hJP62yAtTPKokqC5/Pp+cxFXhRqAUDqUbttInoOMDXRZpwM/elrMG3trBcLCCcRLHZKiuejbDKjkHhAKwsDksGlN5ve9jtIc8zCatSW4cps/B9bew3ONVIiGlXAK+u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wf3ZwiewL9igPN6Kaj0vAHsOq4jHpXTgEV5iXcOIYFmiTXCTWX76qBbcGUgE?=
 =?us-ascii?Q?7QwSVZLI3enNz0OONZXGaJsbdlnpdV+zmNklis/JECKTdSZDWp3PET+/H0/J?=
 =?us-ascii?Q?l2oQJtnz3w/Fr0vJrasgg5tW7PWg9GmJY44y4hDrzarXdkiu2B63LMjlZL1h?=
 =?us-ascii?Q?j3PMY+dy5H35ileSo1skbZ/KBh2ZuFyxG4pId6ZXBlqnyOEDYAHc8su1tEII?=
 =?us-ascii?Q?ZWJqqSoahJbf3Rn8SGUPkyI1RaV9hMRuFDwlFgLIODEn27jE4O7cTMX6ao35?=
 =?us-ascii?Q?LgyVZeB+4+MPn0KiNYKwDUcnh6plE578LO0YFdS6UoTY0rP4KDNTID3toxDw?=
 =?us-ascii?Q?WhGq2an4maryTw+OeNmZwJ/o4NrQ1+smcuNH55KPGIxC6P7LCoD2fAL0bi4n?=
 =?us-ascii?Q?c3Zqbn+fzlh2CvndXvoyykSy3FZ5bsdUfI+cHZWsu4EPvwr89fUCB+me2fAd?=
 =?us-ascii?Q?k1n/yb0CUg80hN0fDcvAmarHihyy7vjw8whMa9cbvBKJTRPfFJJLA/6NjTEd?=
 =?us-ascii?Q?u2XDddmvuTbHP3fviKtGKBD6IT7eXXVFwvjUHJ4W9OVpmmSeBp06Z02bRpT5?=
 =?us-ascii?Q?Y5o+jYtkXNo72l47I8gw5UMsCd9CHD3sHSAh35uIBgqxoM1dE+1olgGsa6n3?=
 =?us-ascii?Q?wQ4OU+QJeCqDxp6OVIpwAOuFJ76haO7+c3hb/EwoWSPcuUdZIzo+XnDlxABE?=
 =?us-ascii?Q?U17jS3woMa9l4FaRJLbu/nEvjm44zKBM1BV8kT7sq2jFTe1Hut9sZvhnAeP8?=
 =?us-ascii?Q?No+9ZbMa0wETZJGQhMrqJM03ZwSuegysFV1sjxGvD8sv+wByOXYdxxiPj85r?=
 =?us-ascii?Q?v4uHsebuMD+XexsVuZ4wvTw0ukaXMNfuMXdS2KlaIqK7MkYKl2uJWzc/0Xm1?=
 =?us-ascii?Q?7FwdRw61hYOu9aAd+5QTt/cmBkQTDFLExWsZIyLzd4yUKN0R3mPwqsV8APsR?=
 =?us-ascii?Q?F7BjIT2scja/wFGDUKeYh3bKYvp3P+qIjLYQ9x7F2Nb3I31xFtp4epA9bBvP?=
 =?us-ascii?Q?nsigEoZ74JTFZDgt+cZuPxYTTFB60sRVWXqF/fIkHWNDFBZXDpR7XXiboC8R?=
 =?us-ascii?Q?3w0cQsc1hoU/p5h8Nv2viiw062n7NF/J8Lk08pmMms5+IJyB12i7kBmHOfqY?=
 =?us-ascii?Q?xm9dOzPg3nkuTNgCkLqO8gdgKpbCL/6kRdJdgJVbhrjf+j6W9kdjaR26LqEq?=
 =?us-ascii?Q?VTBk79yxWqLAkRc4KTvqjVKlnbLISsQcjbR7JJTP7Qf3S+ko+wKAdKLVf/D9?=
 =?us-ascii?Q?oYCZ/AqFWJZa4OhhIU6qsOk4mbxXgWKBZ2TdgANLiF7GrvEGI+hkUqvxLvF9?=
 =?us-ascii?Q?2YCUPlMq7sf561/roIMxTVhsI/BsNlYYJUOnhjod+Ab9MaAprZoBtnyzdbIT?=
 =?us-ascii?Q?7lN6ILyPZYqQIB9qj+fgQ0GseYYKrqiyU1mD97BPDaahT9Znl8tj3snPMjxN?=
 =?us-ascii?Q?Ein+8xsVAPjxoWnVKUhTlzIUaYYcOCloefIVI08Ebv6ahmuBo4K1YJGo0ACR?=
 =?us-ascii?Q?NVbr1S+eRejVqBUbJiuzAcTM3UxG/lnva2bz9AEVHCDPGaZ5xp5ASjMmaLfj?=
 =?us-ascii?Q?Fj8TrkEiPqPDxY9XdkurPRF9JpQfsZvbpPfcoHaaSO1pNescOWk5T1J5zlEc?=
 =?us-ascii?Q?M/iNujrpJRrgKykIg3gUuB610XvxDcyiLwHS9qEu/Xwc8j9aXbt4qcyPx1xi?=
 =?us-ascii?Q?HofLmYKw8NviCxKoWHGZVAP9KHHdUR2OVnD2Kpmj8z93n01w4O2/7MBf1+XD?=
 =?us-ascii?Q?aL4R9AQb/Gml/7UP5Vj2EUtcXiV2FpE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79254640-8a84-41d5-702c-08deaae32f72
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:16:26.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghBcvqkyySUXT1A4KuMkhylqQTNXE6zEwy4kC7sFF12YTIWdThtxsO8ymdHzwUKZrSVqrlunyxhA61T/fEqDcCeyH1WQR0vFbFZzfdlemr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8155

Loop over DTB files individually instead of treating them as one path.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 scripts/deploy_to_aws.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 2e0ee41..6c9d8dd 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -53,7 +53,8 @@ image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
 aws s3 cp "${image}" "${deploy_dir}/$(basename "${image}")"
 
 # DTB
-dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
-if [ -n "${dtb}" ] ; then
-    aws s3 cp  "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
-fi
+for dtb in "${images_dir}/${target}/"*.dtb ; do
+    if [ -f "${dtb}" ]; then
+        aws s3 cp "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
+    fi
+done
-- 
2.43.0

