Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC341898EE
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432401; cv=fail; b=rwn4J7SSuZQr6MAvzRZwblCmNZO/J3ISh1oArvsr5mgiCjXPkTRCZqRjRwPUxMSVlLEPFyF9E36qi6SHhC2I+Pjcz/ev6/BOsIeSQ03ouDXuOKFdjOpM8FN9363n3pg6CNeDvpJF6zF5SMxHR8xVDIySn3/XJGW6V3tkIb3S3GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432401; c=relaxed/simple;
	bh=dFYdBpYn8aWcZVjABSOFLSgG+WotbwyAYFKds1kJvB0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ublt9QBOaIH7wPMgcR2JvqtjqMsBFNQ1nRYZDKxupbK9fFvBsXhH6uF+JUV2eNe2DtbHC/+iIVy0dk3cnDqJGcrPS1NzqlRww2zl4xjzNV2jzUFVVVvHMfecVZQi1FyPRbkKVExi/tVCGwPUKaTmUuN19JujIJC1MYuyOHFwC9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jkBXC/rv; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jkBXC/rv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOm5/7AFkhZMhQIyS3fO9ahITJlTM7fI4tGZYMvXB9GrH1FzS28Hc3UAd6Ssb746y2VFoafqxbqq7tHCsDMwPQWLyMMTYzqGZPWBjv2w2OmJvbwhO31eH8vrWa2BR1Y3+jelyL1REndm4ewmpvdiDfcFnlpjvtnNn1oYVw19D4aRriEX2VhyK7CXOPpu6kj9SPI+Kz5CNi9v/8Jt7Y5TPOt1AMYUQmO4G3eSaUg6wG2zdbro1dVVlMFTivWYoabrRwx62Cn8pS0ba9f6ZJ7XIXk6QumKS8kI7YJ5pUMpqvuLN0gX8/7H3XcBOUS4nKn+y4tWgnx2MuYPj96z29hEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA13B7AhvlJFNMVJBozmBGpo/WNd8vH1Y/R9fLHueBI=;
 b=t8QmgsAJLc11zUoh+VN1dpHJGxACud9FY6TfJPfhTxwyB5IOr8jUQcVet+wSZnZdYj6odrbsFogZJPkGVlFfgCDJ1BgceNglX38WzXnrVVbuJ4mm8TsEKecCPeh7N9dkl0lKvWnvMYBMenI/B4MCNHqhlrDtisj7qIpKCX7vPiBHq8EjMTu8dlI7od+BIMz8b4Uvai4Jzlj1++LXxhKT3tYlC80J//7XlB6t/KwtzFoJrISHQ4+n6CazEQv/YIisU2AOidiLQ3M1syUAazzvgplOPxix9YnBr/hF9NvfRP1ZS+6qLPngfdvDu/ovsDXNLAQM0avg/3WyZeV+6qVTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA13B7AhvlJFNMVJBozmBGpo/WNd8vH1Y/R9fLHueBI=;
 b=jkBXC/rvY4wvpPGoRX9OHB+fUyBb+Li1L83xxfiL5Ba0/3t8Ga3pQ3X5EwFKoKHTHH41pYn1XvBuxSqcUTfqleiEy7Me6wNqWI/7qzmk/uY3FeKGTJKR6h0LkqwlabtgbHq/H2CagJIy5rHE/sOfJq9VDQ9rY/c0lhQWYabGuD4aM5iU3XHIWrH4tp/QaaTA30/eTi684GCJl7exaXiEzEJ+mPYerge1AATXq95mR+9fGJwiWgZWVm+SU+NcaUOyYuFOAnKZAEV1efVlkkrrlOzCN/7TSAKZ54DCPnTfZJAo9Qp8DlJex0yoDuSBXgvS8xa7/1C0s6uAA5EG6CI6Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GVXPR10MB8274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 16:59:53 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 16:59:52 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH v2] ci: Enable Extension of Test Timeout for Specific Targets
Date: Fri, 23 Aug 2024 18:59:49 +0200
Message-Id: <20240823165949.3707881-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GVXPR10MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7d23ee-e975-4adb-6a7d-08dcc3950147
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0T76y6G9U4HcPQ8OigwB8kTRqX9YD6QsYOnwvNiCTnT1zhAis8zyMfBQAkh8?=
 =?us-ascii?Q?F8euuG/dnKoAGWC/Ga4ZVnxiQrwa/0KAhhKfOkVS+lIZOObh194VXKxqr3av?=
 =?us-ascii?Q?d3stEvlrmxFgnHHXvWnjYe5BJO1ohjF9XLKTUJdOj1Z9fQ4XAkYEnKB7k7uG?=
 =?us-ascii?Q?su9dp/1IVehJsexXyiIL/tRcC8YHGK6svw/VPuC/lX2wfj2cU+KJF/8WUM7u?=
 =?us-ascii?Q?S9Vgu1Wkb9TpLnARD6RAi/zn+u/simOia3WyRnJAzs6L00ahiNkj5s4u+89b?=
 =?us-ascii?Q?mD5oNVyo428YqOJBo5HHrl4EA9zImkYOVg6mgShdCtxeuop+jse41KdsnH9e?=
 =?us-ascii?Q?9YCH+NiPz7poESxBX7AJhv4muhLtFuuOLaowhRAa1s1Gcm8oOyZrtXsFwEpK?=
 =?us-ascii?Q?eF1RKNm+qq0dqde2Vp39uy8QCypHCjJkAHv9y9ka8tgD9Ltvji9YCjierJP3?=
 =?us-ascii?Q?Wb+vBDSYQ3pJwyEekKwcdVI7lOGlNSvgsMruEWJqBU2l34FfGaBKhCQHuHwd?=
 =?us-ascii?Q?/3EMjrW8yvG5wlxRHz1Yf6/w3BVTKa4tbMol+5ZpNn9IMSX8p7cjxWOELFrv?=
 =?us-ascii?Q?xuoRPL+EPoIyyB3GWG6xz925lXrezXjDIcs4KocU13CjZZ6lw6Q2+rqXGtKm?=
 =?us-ascii?Q?yGz75lzWtA+XVL1AB1d3R72UpdoHlPfQfAZpZTjPXBHQlm3gujAqzWWJikL5?=
 =?us-ascii?Q?njUtkjikJJyDrPPAuN6go4eChEcJhTRX+B7vny1NMGoq9ZhNk25fQUH67kjh?=
 =?us-ascii?Q?ypvQCOGXSjf6PKnNm7yVQQEh8I3BAg7+ueBLTIrhLAdV/xH7dpedeXfjsOa3?=
 =?us-ascii?Q?zLwAh2t9RjSreI+lbfKHAxqyHXrBWmoaNTvTeEGFDHXSlW+mrNtz3MVQDPfl?=
 =?us-ascii?Q?xZHwHjZy1s41IuyXRiwGNqPivwry2jsJQXA9KnzbLPUFu2idUKbRCLHOCx7J?=
 =?us-ascii?Q?qGK7aM79qI6WhVQpcV++M4CnNzkJzj/v9gP3vihAaauSlWSJB3wjkvHvX89N?=
 =?us-ascii?Q?QIIumOy5+978EuPnxTpZAGBzaxIreSmUoRixgWqf1AeAQFCAXdl1xlpPQgHg?=
 =?us-ascii?Q?+xsr1OTbDokaNdg8OVSchovoOrx+MZ+8U15sMo05idxhb+Dpk1DxLbyjghs9?=
 =?us-ascii?Q?RQc/m6WPoxZ6suRPV0r2TXqT/bW6sqr4JruvDzBqjuQSnVJ5KK1+F+ImgHfH?=
 =?us-ascii?Q?J82lomXrmaJ/v6Did9FmWc54sM7LETyiiajELRKoi3MF06U019yqlMszvoQr?=
 =?us-ascii?Q?E8NYcwMgxBOMHZQPwH3KtRIuAHruJegVwD9WvYvGEMRxhDSfOS84FZFJ9NBv?=
 =?us-ascii?Q?AfC2EIyRF9R5SY6vl18i/DPf1t5tqdZ5+YqbT5FCbimrOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nfNOueuBPI5jUuk4p/usaL9BBoGzec++VlGor2PsZAIqRtCfxWc57rUA33lV?=
 =?us-ascii?Q?Qp5NVqjZnHv1aHzpPVnbDQOXbgqPc/b0xkLA7fVtD+IDtj9o4U8IKBP+qn0x?=
 =?us-ascii?Q?FsUl0ydeppkKCefbGAs0/OU5yxSTAnJoLy3ZVvdEKBxrDRMPPiUI79ZANACl?=
 =?us-ascii?Q?LAdj/9WZeWvZsNR3fKWZgSi0/l3wAdr7Aqqr5GDoX2JmEpFl/of6+lomORbZ?=
 =?us-ascii?Q?iJakIkru2NH23P3iOZ/BZKYXgCFdEjC/U7hJBwkurJe46iays2XnQvI94Frj?=
 =?us-ascii?Q?4dmIHJhvllPzfh9MJgqX5xL+jjpHZNfzr+8Jw6/2U9GbMo8SlJ7pby4MLWlW?=
 =?us-ascii?Q?uRernZ9a+2y6t4x9rxlNZU1vXBTClgD3yGLLwQg8qXslsvCCZSkfWFLJbDj8?=
 =?us-ascii?Q?tAEGgJAE+xT8uDSuvuMB4Juf+/Jeg0W8pGyZf0yXkYurcRGE7rjAaQ1TDI5a?=
 =?us-ascii?Q?0+Uk6x84tjoRP1cuUVkICefOO4M0SLSqmutfWDXscIBYpAuqhDm8cUOQU/6F?=
 =?us-ascii?Q?+vZGlDiCYq1KUHawZY8KcJsNxDOu6JMlXbGoxcREc6YBaxHxl6gC367PrjRJ?=
 =?us-ascii?Q?I/e6nnF8atTo7e/UfQYe6ea7jRfrwq0lYEajRdpS6Tlr3NIwkTMwRzV5RzeH?=
 =?us-ascii?Q?tXFbyLCeL9ntMeIA6nc8+hFGpDZi3j7RB6oM88M20Jzs2MoGOarFxbCfTHdU?=
 =?us-ascii?Q?KREP8s+zfrJyqd0KBAd64ClPWceZtDOfuNXUo59JML3D1aCC4SSYaunR920W?=
 =?us-ascii?Q?bPGaG1BljcknVM8EaGtSsStfn3GXVDR1bu/UeXUMWo76CaT6JIwm4PxFXPuO?=
 =?us-ascii?Q?X5OGe94oM+ZEmcmjRG+lu48jTQO9TEXbRotjlO3zIkiozSaFjfe/JvpIvZGl?=
 =?us-ascii?Q?j1hcB73qKz8RWZhxpq8LEt8eonYxUtIb5Rfbj/LUOxPmzw1qBqkpPTab511u?=
 =?us-ascii?Q?K/9K2N+YWD72iMaNnGKeijLtWujHIbLe6OkWdoTdqHqVs+ARV82RAU8KUrp9?=
 =?us-ascii?Q?pVbRFpriPOB6qFJA0WdErMIV/fXZxDNonIGNg3m2viZ8BoEVTDpkH6hyN80W?=
 =?us-ascii?Q?fNKwFtAKmE+iVIJDVtru+joTbBr4+TojOHbXWr1H3jtK+TiiwPDRp7jcSGgh?=
 =?us-ascii?Q?t5oIacX8fjhc1krSmQ1zzfbnU12LqqDpkHcoBv45K0ZnwRDBM1C89XCX1WFg?=
 =?us-ascii?Q?4aiJAIQBn7tNI8K3eTDi21ra/IkAQ9vKCCfR0bUCIe9h9RJH453inWTRTvBI?=
 =?us-ascii?Q?VMbwulLOxTSZ4eIwHktjnk6ggnP/I2RWxj12AF7b7P6muLX7aLdjaSSKZU2A?=
 =?us-ascii?Q?4eIL7G+UdUTtuYS8AHnOWppr4NLCYDXm27ln54u3Z8d+t5ZuuLkaUxUsKa/K?=
 =?us-ascii?Q?jRo8SU9zqug3cOcEaeDpcYskUwz+ppRsoytzxnHxYKPH4SOscCHtZk/CSX6l?=
 =?us-ascii?Q?VzGhTTSW9K50Wq1C0n2P4OTl18/zK3uToMaRw68qt4crU2cGFxHCDstslFS/?=
 =?us-ascii?Q?MGc5+kdYxeRjAAhDfFaQrGUcNFJITLr1wVZD33XQ1zRbwg6wYZRyClnjaIP+?=
 =?us-ascii?Q?96JuBGd5mNvPy7JK2dElpdzo9SeAK0R9WieKgacBKbGLVRh8QinaXGiksGi8?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7d23ee-e975-4adb-6a7d-08dcc3950147
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:59:51.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbC9MtEXG7TfCeDPuccjcu9wrHOBvygo2y8IIU+xmcEa7e6Krf9Spxef4n9uAdCpCzErHzQTZ5SPlrTvZUEghhSoEDGrbCfFGqNdLbRYsig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8274

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
index bd300df..ea66b06 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -22,6 +22,7 @@ variables:
   ISAR_DISTRIBUTION: xenomai-demo
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   TEST_RUNTIME_SECONDS: 300
+  ADDITIONAL_TEST_TIMEOUT_MINUTES: 10
   TEST_MAXIMUM_LATENCY: 0
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
   SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
@@ -114,6 +115,7 @@ default:
   extends: .test
   variables:
     ADDITIONAL_XENO_TEST_ARGS: "--vm"
+    ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
   rules:
     - if: '$LAVA_TESTS_ENABLED != "true"'
       when: never
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 97061cd..0971385 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -38,7 +38,7 @@ lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}"
 DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
 export DEPLOY_URL
 
-TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + 10))
+TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + ADDITIONAL_TEST_TIMEOUT_MINUTES))
 export TEST_TIMEOUT_MINUTES
 
 echo "Deploy artifacts from '${artifact_url}'"
-- 
2.40.1

