Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D1337699
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607733; cv=fail; b=heGYx9r3N3bjAQfmf1BvWZis+IRhbbl10Mion5gob3agwzG/gSYdoR0kMgqdtPcYtUYW4flIsjf4WpKjzccF0XgC49JYLp8T/4UWAImtwDsp/ErsEYw3u4JPnzEF4YFLxXWi15/fDWcxJJnNisqsQ6bEXYimY4IpQvNK5enM1qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607733; c=relaxed/simple;
	bh=l6WYwJ76fQ5LSZ0sHXJjqafEmKz6gbIRK2DZuSz1n9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQZORrG6VMmr764PCwgqlCz+axy/LXh03I1IG43Shf4EcxnSqy8fAXe86BIfSCMNsSgVeyB9a8rO9uMeErd1XEyENSMLFo5qJZEEHfdushkC1DjgUUkoTVfPjmwc34jn0bCevrNyt9LN5yxcllTkC6QQxc5aJNyAq10kYBMH9t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yNRR0Ig/; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yNRR0Ig/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyvtMA/XJBcrFhct946GvIoIlJz5GPCyX6r+op60vQyF5KzBI5WJPpGUfaQPWtpDybDQhSZQUY+96pfxT1AZCboS326FcYoWDV7qO9KSit9ri/qW1vsYCuWLVTsKpYlrxX1wNmkkxf+NN2O72nV4O/Tapp2qxoCm5PLy/y74HXIQjhk8etcxLGeQLz+iP7TIkw3PlC0aJsuWOINiGpqbqcOJr65Qzoq/RBXjso+mt5PcfipEOCOFEXN0g3W+r2jqti10DatjC2OwpzhMmaLl4M74U/Df9YwnPX9+8DmpTgh/s7TTzBcO03sf/LAuyl4t2VzzrA5IoL7SNGxnayvJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qM0Mu1tSdZWh+olHowJQvBOiGSQix+kSPOFnc6kCH+U=;
 b=K8AhlpI6+8mB6xCCBPgvtFdLG1hsobzZDAi4mZlQh/Q3AF4zE5m7kzbnsS53KsCaN6scf7bvnc1guF8B4K38Tp9ibQ/2VnXbuOj1kXJGlmyln2CE/Xy7eTRywuW0A1rMZz6Jj4S6+bNRxXbTidgqhRvhKAvLmiKns+n/hbpjPS529W5qPf9fF+YzO2EzbP5zOMg280R19Rg0+LPKDW7H+85W/lZN3qNzo/fSUgPehinsnBIjFgZR9tZ76sUKYIiONw2/JhCuqN6ASCux1LY6z7ZbbsjxfOy/gsZ4Cf0gBAoORJKh5I/e6Cw0RmUZQE7X2aRTfiUKAAVkvitqHXjTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qM0Mu1tSdZWh+olHowJQvBOiGSQix+kSPOFnc6kCH+U=;
 b=yNRR0Ig/2duueAQj215+UyBKFrJdampW2BLo2vvTWrhzKqfHBBopf9YLssQGl2XGZ83BoSdr+/RapDZk1IDKg6efMUl+GJpMoiV4jgj/MSlY2jSEfzxs/b8yzE9q5c2Rh5iS5YwdGm6VDXlqTTyDNJe6tVLBk9MkOE5gJ/0R7vQGeDvSEwOr+fk6PPoi/a1uXlhbGiY8LN8sUBCMPfFUroVHMVpQEEBTyE98/viMlB8moHKkoU1EeGx4/osCxkMKIWAao3L7sdmOjOkvFm8+7Z5kMMBMdRIupVRcppLsqKHsmNrkK0OfI0UdMCrmbaKCs4BhILQhxzPhy2bVdBOPhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI0PR10MB8984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 14:35:26 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 14:35:26 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl v2 2/4] evl-test: improve help message with detailed usage information
Date: Thu,  9 Jul 2026 16:35:14 +0200
Message-ID: <20260709143516.395611-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709143516.395611-1-tobias.schaffner@siemens.com>
References: <20260709143516.395611-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI0PR10MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: de7f0297-6025-40cc-f6ba-08deddc750ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|18002099003|11063799006|56012099006|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kjiuXd3WDr/KwfEGtNV9gAXLvfMJ4TntQ57oXexOwffaETeX21N+EsnwtDQBtp1Kw7MRM2uLhXilBUAzUtQrCriMBMlOL0VVGAHyikpvZTRUDDRMfsQacDRt5SAcPJ/zrQs5bI1hs8DoG3rabG/gcTmTmIGR1teMJPvx0Is1AYE+Z2GWF5NXEfAKrnKH7hMB0IXB7AA06bgxvNDXHlc6GBWG7JhP4T7V2q45s+rALUkf8sHODfJK516x16M7zMvGVuk3wcEDSoGsGtKV/8O+0ABoN/a/mkoBF1kYahUbFuBrAPfa0vs9LoWWiI4WRqqBsUnNM0rVCxY6ldsP1shnQz885LiHUu9uHTQrVVUsJnPvwjytfGlocsHgqWR2WpkGaPnBGg0XY3Dw3RQKOWpsB10IHuGYVUDcaqoEayvnUJu2LuNoxVLoTT4riENpcGknWZ3xX2s32e0KXATQsRdifY9lQ/wSDnq4XxpcG5HqLqIYx/d6W0/vSlJ6dPS435SCxOzgb5aMOR7A4f1l5exTDH37JrD0EeGBFhY/IuA4dMxLUCbr3wGoa4K9/JyuSB7q3MFaross9rRXWsx7IHTKDTZLKtkK4WP/jEPBfFnG++nYsiZj5V48UJQ0QE+1dqXJC1tsO8p/QU6tPklUJCG4aH5V0RvcxBcQhTc8TaN9tCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(18002099003)(11063799006)(56012099006)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xXN2KmUM9XxNoUnyiVErsRI/YUNPWcyw/Gdi7bjN/jJJppeBcP77njRFsNyr?=
 =?us-ascii?Q?srzXGNdSgV2HpE8fdDC+Lu6rgc4yi5KlJogOT5NavpSRWw199IQ8tWsUPd/U?=
 =?us-ascii?Q?YUrkOnUg5lY38g+h5iMCNfUylELE4+t4qgSlakb3MhY+3kOLQQh63py5D/Ks?=
 =?us-ascii?Q?lQ+bU4AInzfVBki1ewLFlCq/bJN+83AcUw9VbQsh9spMWDiL5A4R4eWh7xXx?=
 =?us-ascii?Q?8Ackcrb8lP0L3Qc3jY16w4UgucqoT89qpZGZ7O7PLPiGKzfd+xB1cCcBQ0tt?=
 =?us-ascii?Q?VCNT1edR9Ppyx4rHFBXJ0E/Wg5avZ8ALGbra7z5SaIqdXxX4GChHQpFSZXx4?=
 =?us-ascii?Q?dntmi6+7LhOai2zgyR8D1/lacUvBNsyO6XpoHSoyLB2p6f0D5E6MPlVz78Jw?=
 =?us-ascii?Q?oveDsiDZNAK8gowKX+vOGqVogK7SO67NuLwzDg2ccG4bwIebSMzUbr67S1Xr?=
 =?us-ascii?Q?cNQgO8HXJZNnmQC5Iifxn3O19UuN0NJQiK6uxgtliZ6BddQTRTzy1YtjexuC?=
 =?us-ascii?Q?OnweGr15ypHYupvyma77aouotMY9HOzcuDVW9TwFDtzatslifih3Oq6PgpZ5?=
 =?us-ascii?Q?ZfTb5xFjISG71VjAE9QIViMGys5merlRmUkB+k/z8yv7agaz3BzfgEIwvRhO?=
 =?us-ascii?Q?gKkzwyv00n067jFbUPkfsOhLe1p8x00m9skMWd9lPjpd+NZHQYq7uzW+emMB?=
 =?us-ascii?Q?W7Hex6MG5VXS1uvfuSq+jOVtw5cEEztqNWVTA8e9hTIU6QNnKKylyd+VskOq?=
 =?us-ascii?Q?zs2rv0vgP4R1O6ugdRpU5XU08SP+bcHtANne942ofLGK16CydMgx4+/xjONr?=
 =?us-ascii?Q?Nqi8NT/pBzj1NRfxytFAB5eBDf/+a3RG6HwCoMMLYBy8u1PxfvYaLev2ZGCM?=
 =?us-ascii?Q?decmGB26L3UvkpOOQfyh+EPkx/gqh+NV+CAB+fFNejCvRrmo/QIWX99R2BpO?=
 =?us-ascii?Q?23dngouHFGojr5MRV0r0gerjJDPvyctfrcwh8wlKSDW1d1319z2kkXsjBmQ9?=
 =?us-ascii?Q?VIq7pxxtDuCSy0y0YfeuLGzVQ+DIrzXvieiccdfcN1moA6VifJmFftHVktFA?=
 =?us-ascii?Q?/jlI9n4xYyh7o3qJ6vCikjBgdxe5hj3Vmz0qC0oXkWaGyY67iFIsV1ZYlipr?=
 =?us-ascii?Q?X/6M6uBzU7ED40Qrc1j+eVoD7vW97E0WVAB0pjKSuk4RHr6Swl0yzJZcZLQf?=
 =?us-ascii?Q?d3qheOaqbCmeAhORXjVN3W4P4txoKXfy0PZJiX6jE8OG12D2dxaou0UkhqEE?=
 =?us-ascii?Q?pvW4SNg1sanZx9cd0x0XB3anwEUDUSSnNRBUXXr9bVsqsri57VOjNlmezK3d?=
 =?us-ascii?Q?sHFqUF3KwjwoRYoZSb164YamVjp+hB6LVR9vsxqjkGMXEOT9lwcG4kqAn7nu?=
 =?us-ascii?Q?ODtrnC0mBpTE2dxwCs6kW0LX0GPZYiVnmv9BCgGSieeAQNTEv1QyqjJKxPG3?=
 =?us-ascii?Q?flEhBD41Zr/403JKhW2qOabtx5OucTFou1XKZPVuAMhWM5+lrKGmlRzaC8LS?=
 =?us-ascii?Q?w8OKoKj8Fk/8di1HwaxeurKS8GhccVBmgRza37gCq09KQTrnddM4xw8QhHQf?=
 =?us-ascii?Q?3jYcr1YPjlJSOekkrkiItT8gzumjW3xQ8zWavtn1Qj5o8BRty7y4UgA2peYu?=
 =?us-ascii?Q?KkfojZMiIMpaBaHcSjfb5SCG7Jd79d6uQkjsOfXz9+ljkJKuYHmyMDbe1NQQ?=
 =?us-ascii?Q?n4Bag+5lLECjhhsKf7YXebGfC33YBK6ecUJunD4purBYu2h7Ssx8CfgI68hi?=
 =?us-ascii?Q?khsmoQN1EKtsM9H5K+igxPKKWwNjDo8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7f0297-6025-40cc-f6ba-08deddc750ee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:35:26.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeXtZgTKis5pWc/+G3lTwc2JZhPG2AuFAcPpiCJ+dQ9WNuD/gLhXTQhkU8yjopFJM8LKS69ohlWtcd1CuMLphAdMBbjkkLz5Jd6OR1M6GGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8984

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/utils/evl-test b/utils/evl-test
index f6bd82f..aa8e314 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -7,7 +7,32 @@ if test \! -d $EVL_TESTDIR; then
 fi
 
 usage() {
-   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h][--stress-cmd cmd][--stress-out file] [test-list]"
+   cat >&2 <<EOF
+usage: $(basename $1) [options] [test-list]
+
+Run EVL test suite or specific tests from the test directory.
+
+Options:
+  -l                    list available tests
+  -L                    list available tests with full paths
+  -k                    keep going after test failures
+  -r                    repeat tests continuously until interrupted
+  --stress-cmd <cmd>    run stress command during the test session (quote if multiple arguments)
+  --stress-out <file>   redirect stress command output (default: /dev/null)
+  -h                    display this help message
+  --                    pass remaining arguments to test programs
+
+Arguments:
+  test-list             one or more test names to run (default: all tests)
+
+Environment Variables:
+  EVL_TESTDIR           directory containing test binaries
+
+Examples:
+  $(basename $1)                                   # run all tests
+  $(basename $1) --stress-cmd "stress-ng --cpu 4"  # run tests under stress-ng CPU stress
+  $(basename $1) -- --verbose                      # pass --verbose to all tests
+EOF
 }
 
 help=false
-- 
2.43.0

