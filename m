Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2551885A2
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425163; cv=fail; b=BG69lG3dSGJfxfovonyu0ylGIbgbh8EvaKHM5KdErWGye3nr/5OrtILFqif2STsTQQmLZ83EKF6fTdnlDCyJeDOfs32QFyVhKEuQnc9F+Rv8WZVSJKZU/xFxRoPYNwO0RbK6wWa4jm64r8JBBVik/14AZi6lVZhLdQos814c0sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425163; c=relaxed/simple;
	bh=8mbVHcrJynwi16nl8AOeKWI4EzmKhGt5wSibrEdL9OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FxNZ12MCcQbQ1rnlNz6JRX94nqDUSifbTgeLaIUVMER7TCYVrnU7wFzDZGXYel3GcIo0q5BAxkDRbHoBnkcpaegT9w8uVZuVkaafGFQI3LHJdnGZfYtDYBbDL9aB6a6sO3C5TV9uE9OrfgpJGZyoRHKCWijBw3or9tAM1r/JNC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rv8ezOE1; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rv8ezOE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN+4V4jRns7PSJiRHurDMxtavWJeWTQcny+nSf7H79F7wQ/5D9wk9wxL4hzWvtsVbVjvgC0CryNaqFFZgYLq+a8BzIf2tbefOy8BP7k8q+F2neQu0Y0P46YTTABnbrp6+4JYccvnCEylFt6SStoWy0LLQLacL7jqHxk5H+prSZ1dmUexM0skdBd4oM5RILff7LY4JEoJoKksuSIhRD++/DPjzlKwQUkIEGVTrA4BOFBnlUxI6B7FQUxceyRpq+sYGSzHOcnWwFkIHIuuWez213MIn45LsoA0JU/JHHJKY99p3FBUWyN7a0TGwPTy+vQYBKhADyGmVgD/FdSWnoxCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q//u8GxVO+2JEXByImsA1RjU/nUMKwCRypVbgAzqvU=;
 b=ecYzsAonk5Esn2ooz/QaaiXMotdlubx/2puXt7MzWjV8Dh92il46vknlFPhDbMip9LWGeoet8se0VKqgZD1qnryr2jlzLWYpOge/QOJdWQYnW4SR6KG+jKMXSVJZPDlaC6ZPGQmTNRgorM+H+fPvht1oH0dVsoPPiLsqMlmm2vHfAeDdXUI6tsk55npM+ka7Y8629QvRjgZSp8C8fa+mEszmsTjuECG43cWtnIdfOfgqtMmmuIjbzxyVyqb2ZIMSqZfFg/Fmxya+RzeGCk9b5wTtFT/ugMWUGcVw/WRUl8GWNU5Bn9sgU0Wnr8Ymnmy8j9NM4wiWSeUIe7Ulo0p8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q//u8GxVO+2JEXByImsA1RjU/nUMKwCRypVbgAzqvU=;
 b=rv8ezOE17PRuxWffQ9GxLOy4n/g/seD5azphtWitPYUrOCBqdf+lF/KDv3f/Q3cxxk6WHyQHoFGIvXki/Gskuy6msvpnWXGACarALgqOtZcKxIeE9zCGn/3ihA824ZYX3nLop+6PBQ5y6MCyGO3Oax0agkhn/juDJy8jnISiW9iZ3czX+RQom+cVBkTgOxM25qRUoMR1TDs7CRqHNYotxT6MRLc8G8NY1Dr4Dpz13zhPladgb/CfnZxcRwoIX7MQY9yxh6GmtoOToxcJO/qAWUPizHoLwvpYyzk27q7/31sXfrzglCMbf/491n/FwbRCpVqx9MzzU92uQnQa37BjlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV2PR10MB6140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:79::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:59:16 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 14:59:16 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH] ci: Enable Extension of Test Timeout for Specific Targets
Date: Fri, 23 Aug 2024 16:59:14 +0200
Message-Id: <20240823145914.3587235-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV2PR10MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbbc4b3-5e08-430f-08fd-08dcc38428a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qA20lm3b2D56dALNVlb/1c2J/hlEbi7PBKVZzSp0c0kROdQCzsUCZhENz5V3?=
 =?us-ascii?Q?WPgap1EZo9j3ezEp4cFj2WbUh2enFOPAeqCzR6PdT+hfECLSp3PhumHfT6Ot?=
 =?us-ascii?Q?ZNJXJMhzn3T8uNN5JkWl9cQIW85ylugJFKSA4f9IIGtHQXIsXrXtO51GKSG0?=
 =?us-ascii?Q?rMHNtC57RbmUPSELRVLni90j42ahRrWM2lJOKegXNjW2HyuANK2xGdCta2P/?=
 =?us-ascii?Q?L8nehSNxaKCStxAWZK/JSFNM/z+ZjH3umOJPCDOpKemyymljPRIRMHAplLc1?=
 =?us-ascii?Q?q1kA58XM/FBSK6wKgKUZ+yf/pidkoflKjwDOK2ha3tYnxfPq6cv0PD9WoYM1?=
 =?us-ascii?Q?m5Zbdm0Tmqu0AJspeuoJxIcBSCsc4Bo1NsXU+MO8qEjEuFeCBb9S0/mSR33i?=
 =?us-ascii?Q?f0lhMPkYpYvrsj32CNMLgEsirqEN7kNR+LKXJ8mFB3azijbL7grBl/MEEOqq?=
 =?us-ascii?Q?eZEn9/FL4m+2YoA3qT17OAxmVCVajDX1/klaPj3EFiDcR/8e5fEo+g3wN8H/?=
 =?us-ascii?Q?3iBi6mxEublnylVj/7UMtk/Y2ED4aX5Wfs9hK61iTGN4aTXZvdixhrhLeVTu?=
 =?us-ascii?Q?SEd3ElzeTbDjFj6VUoGTwzrfsnm+tkR2SzQzt5kaU+WUlOLy1PFH6M2E3tmi?=
 =?us-ascii?Q?WxsL/OOnKQhVpR1OucBnYQ9PeM7XzdDVPBshrVO4G2zxZu0EuCJ0SteBhdJl?=
 =?us-ascii?Q?fAIWa9ksnA3IzDttyQwE1tzRIwtZygqV2ORHWU4qViRIZ9LMOycz0PQiAPhq?=
 =?us-ascii?Q?vQjGg9F/qX1E7GrUhII+YLnnQ+rMBZIro1scFXSGaeTzRu74sAzg0/A7FPFQ?=
 =?us-ascii?Q?xHf/N7PghOxNuj+CXQaXcG3zuCA0EZ8853QXkhmnpDi7HaeL3/gY9xKMC1ia?=
 =?us-ascii?Q?tyuqhbCTGgEKpIiVAPjJBEQT3fx1Vvt0zDhblqWfXYgMnMIKg26UUld9LDzu?=
 =?us-ascii?Q?FMGjdG0Jdqk1hJaOlR6I6eXXkaebkv61rToTN//6a1JrMz8Feu7T5ZummMAi?=
 =?us-ascii?Q?+87TAhel9V4vh3+SNyWZac2jYejVH9bmbz/ccKEdu2si0/D/MoaY3ezZ3dyj?=
 =?us-ascii?Q?FpvW3MLgDntoMA6I7QVtpI/p5KK/F8rre30cKNBALub7H5ZG6Th73x/DQU1X?=
 =?us-ascii?Q?2Tc7apqc93B9hTUwU0OkthRCC0NGi0D9FA2xGScdQ82+NQHENuMnkq/fI/gi?=
 =?us-ascii?Q?q8+ktzWRTFLNK+HDDBCaHdsd+LAoOi6uZd9feJD6hEfoL7NaM33zzZzP6CPn?=
 =?us-ascii?Q?OIq4Lv3yzNMA9WEGGrAJk5upd4ZVE+M8UMNgaaJXrnLtGL+dJQMdgtcfEu7d?=
 =?us-ascii?Q?dOeV7hF46oJOf1ataQlCJtzcIOFMZjR5g3eLlTe5CpnWMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?niTTqOuEs/AiqSSs6kyFnWa8YAXI3C+Tvgz0UYH8UlwClEtuSTbtofgo/mUl?=
 =?us-ascii?Q?rQIyTBfQn8VMB4PwIQ4OpoBvwwzQB96d3tNjJMSdgdhqR0Bg3dlHjLXy8pmk?=
 =?us-ascii?Q?O6sAinhLSlBVZAUJp54rW1gWj3GD5VrfPcwuzXtuB/jpWbCLXlcwn/UJKV38?=
 =?us-ascii?Q?fnQvq1WKDWa9HAHG6RsV/FW03s5XX7rYg+k0gNXg8MDTVc/jJXKABiElM44Q?=
 =?us-ascii?Q?DukB4lVZ7XebP/CfZ0bCXKINYM6mSvcCP2aisScvMu9oD+qhDyajVsGDRG74?=
 =?us-ascii?Q?XWYvHylAzr+ZJmRsXg256gOfp/1YPdIVlHAan4RvgAiMqE+j75rNDdYRw0p4?=
 =?us-ascii?Q?xXnnYhBTW4ulnX5UDLn5lgQR8pm8RhVnDylOzMfiXHrUoET7jFAKbY6/Tq6A?=
 =?us-ascii?Q?CdW/af8c1va2PjDSCpKAcKJ0OQcAZ6Wmwy277s9H8JqZMVaeNRudNBi5Y7/Q?=
 =?us-ascii?Q?zVG3bl62X3cveQ73c66pJ5VPt8Dn1RmHkTL+P4AYi4v/8r4JS1zvXT9aWPGl?=
 =?us-ascii?Q?l+uhgq8+VFhfAaM9QJ/5xEHvzAc/guaWoWHOM+WZ1wNUf27XEhUZVn1ANLJF?=
 =?us-ascii?Q?AdHN1jvpOyJl0brCz6YGj0mHkbrFTLbGWTn0Op+TS55cX9gqqT4SdbCLqeG0?=
 =?us-ascii?Q?IygBkHjvNthUC0+FGb5IND+UpzCvm3iuSFOX0ShyWWu8l+PfUwaA44odObdJ?=
 =?us-ascii?Q?ryWv6LRz4iguqmzOEszH3VArNCGlQav6CY2EimCVhdiYPqIaAdH77huAvxRy?=
 =?us-ascii?Q?2NeyaQNZh9zryXKGEMsLCQMeQ+eGP4hEHfWcUSblfKltz3iXChmhvdNACyQQ?=
 =?us-ascii?Q?7XHT2pgaYk6PzyKtjJynIzd1rNN8vy2720mnG1rsQ4hwHLDyPC+eTiX0HzL/?=
 =?us-ascii?Q?onwexhpeJx1DDLqyAuXU+DsjeZHXOkF6JQ2ARBrBpgPqwA9lgJ7HeLzM0zaT?=
 =?us-ascii?Q?+jE1LaenZapzF21hEgXY4kpeUZyDKhv2lplk4QqXrvgzGe7IglQm9NBrC28+?=
 =?us-ascii?Q?elwTLXuSzLQiBzxgP+xjlqDgJGVShqfL5UDOWZwlajQnmJX/WNGx/izKYaOj?=
 =?us-ascii?Q?g8cinJi2AUo1k9Bl6JKbHtzVCIcgDTyai+PoUA6VgM6rCxjh+U23wdDF4P9A?=
 =?us-ascii?Q?acIWTG/iEpd3+9PdkXk4Bilg03xp1O1ZtB0Mnnk6zBPFEM4pxB1zS26m0sJF?=
 =?us-ascii?Q?SIpj1I0SYmK7C/yYgRB89+CVOmdH8PV4dnEZWe2Ipp4pdRe8/IoruBh2lUij?=
 =?us-ascii?Q?n3fBdNdjwp9NwDW+2TVY3vIyH3w4eAFVmcFBlVd/QRhr/Fb4pGd33vYhr/eb?=
 =?us-ascii?Q?O5u1+iDF6c/5sWWEZWM1j62ZY/duQ2ltFh5Y9ugC/I75Dfzl1GQxEtB0/QPD?=
 =?us-ascii?Q?zSSS33LZFuJIbwPm+iI5TNISMm7BPj+Nex5LZ0T9ACZ85VqBOeHFwCQjUnNz?=
 =?us-ascii?Q?E2fgDoKi98hLDTxF4llrHNc6folvOgH8lHv3mLLgGDddgpuyhtYPxq423P2G?=
 =?us-ascii?Q?wvSdYiu56PA8hew8cAXL0NZIPgrSHDJg5d1GVCQVxb7bJ04LE3ft7lfDcaF9?=
 =?us-ascii?Q?zSBZujbtcFP8wjPO0xHvE20faJztiwHwF/ulLhLevCaaP4aihLK7f2UPJuMy?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbbc4b3-5e08-430f-08fd-08dcc38428a4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:59:16.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7FjS3CJH6kd5s4mHGI6SYbW3Vxv/KhYRWtv45bAZKwAmEeCfk7NSUestaHqLKVd7jPI8YrPvHXpqwQSwD8zw4p09KQDq8VW7Ay78k8ZLzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6140

Introduce the ADDITIONAL_TEST_TIMEOUT_MINUTES variable, which can be
utilized to extend the test timeout by a specified number of minutes.

Use this for QEMU targets that occasionally require extended durations
for their memory tests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml     | 2 ++
 scripts/run-lava-tests.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index bd300df..2936f18 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -22,6 +22,7 @@ variables:
   ISAR_DISTRIBUTION: xenomai-demo
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   TEST_RUNTIME_SECONDS: 300
+  ADDITIONAL_TEST_TIMEOUT_MINUTES: 0
   TEST_MAXIMUM_LATENCY: 0
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
   SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
@@ -114,6 +115,7 @@ default:
   extends: .test
   variables:
     ADDITIONAL_XENO_TEST_ARGS: "--vm"
+    ADDITIONAL_TEST_TIMEOUT_MINUTES: 15
   rules:
     - if: '$LAVA_TESTS_ENABLED != "true"'
       when: never
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 97061cd..3ac1be2 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -38,7 +38,7 @@ lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}"
 DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
 export DEPLOY_URL
 
-TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + 10))
+TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + 10 + ADDITIONAL_TEST_TIMEOUT_MINUTES))
 export TEST_TIMEOUT_MINUTES
 
 echo "Deploy artifacts from '${artifact_url}'"
-- 
2.40.1

