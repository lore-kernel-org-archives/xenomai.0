Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4BF14B07B
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212688; cv=fail; b=rhQEEeJN6euTT0SMx4cCs/5ItTzkgWQHzgyj9UpwGvRx0sZ6P4Y6t5zdhNFJz0YcmP8998k3YpXNtCI0T0TX8YKa/Y7OuZC/XOQV1JuNTAkilRcorPfyGw8kXZtusAmoBHrFjmYZjbgA/GAsof7DPWWspIaLcCUzJ+nkBSs2hZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212688; c=relaxed/simple;
	bh=YGMafSpuqULzJUY1G6U2j7SKZDR8Eym2U2U98er+eAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cMavJAJd+KOwG8tJpksup5txXoiJnLd63J2NsHC4MbPd3HY3/3mYmofBRkQUhEfmWFlMoKYRmosaTA4z4WnyAHeuaJYi4Z5vTDMknOWw9UMchsuJLK2RKuGg3dA3OPkp7/A3UXto6Ea+D2ytho5l04vHDAPUC+KoJgPvv840hr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RTS/H+n4; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RTS/H+n4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs1f/rp84y10O+D/Z8kqxQsWXba60kqpeoTqmNes8mNtdmjYNvrE6WEbzlAS2V+eq8FKUd7MF9tE4upklUAoIFa7ZNMCqRkHZ5AlyC8ZonvfAuIjNcsJlyrk6I7sONWZLv9t8DHKTnxMT4wUdZLmVKjX13rA3Au6RQL07dVPp9SiyLK4i/x0Pw+d9Vkxcv+fbDHj7KFVEGiKwJLGD3yenLT/uZ5vVSPM22X+RH8AWMWOWg+olx3W7kzm1jgjvzoS13AIF+t7Y5IlQkiL6cnCrtN78SDlEFLOZjAr1Z6qcNvPwFNRMeeLod/Gl3PyDg+h1TfbbE8PBR8+NB81UBAY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJaHyFsUZIlgZHf/pimAMzQ8i9cBact22QzEFxrDa7M=;
 b=CHV4EBxiS48Zw9bKCJ4W0nMTdvxmfUvqY3Jo6mFs17d9qd0zjGNzg0RlEZNyrdM8eJ8m/pi3DkZw3EzR/BiYaj95OYPkK5uPOwIrpPyTWLEwJuJgWQCU2HrFWP4Ce/Dd6bnotfl7pEtHRSQb0AoHC/1MB/Rm+nHnaPc/+GWrsuXd1BqT+cQ2pvFZi2ZwobRoQIYrGET2W2E1dc12RZbGZ/icAQOspp6EsRMmNgBFR07WQDAe9eU5z/E57uI521OtW1e+7lkw2EE4sC2Pu4UWMvAr5Xk4Vj4pTYoOO8bTnCa5nYUYaJpjFmsTFMaNiUo7DlsPFFWCMI/lM1zdDuAtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJaHyFsUZIlgZHf/pimAMzQ8i9cBact22QzEFxrDa7M=;
 b=RTS/H+n4f24zPbDL5jpmZPqaeLzM5HNRYsGPG1O8HGQ1oxe9MdACDwiPhcLSgcb3M3S/z5BeR42c/osqQWf9B9oj9cspHDyUA6wvSWhv90rMepXF+veuCmCzDXPDSuJvjSI+lZCGAiPMIpIAvW3BuTtoaHIpKS0dP6sXGQK46oFrqPOlENERZU4z3Cav1yhoU5c0Yezxc/M6OU25Q3dKkfcZcqONdoTTPFwOXfjPYw2McTx0WKV1GpNQjuS5PeqXRw1XefjMMejjj9Fp9dmevLI97lY/CCjJP5cyhT6Ap+LH/AYALSkx1rpIuH5fiwmx6sWu5WPQInZrxjmcQJ0nEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 10:38:02 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:38:02 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v3 2/5] ci: calculate test timeout based on test runtime
Date: Wed, 17 Jul 2024 12:37:45 +0200
Message-Id: <20240717103748.161788-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240717103748.161788-1-tobias.schaffner@siemens.com>
References: <20240717103748.161788-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:610:57::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d21f6a-0d3f-46ed-70dc-08dca64c8898
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48cbXBx55/mCRG2QquuJeWsHvd4/eMtcMkPfoLgyUipb3TAW5ZgOReF8eupa?=
 =?us-ascii?Q?F3TPfApVDvUwBZKRm5J1qTuzBxZbus77qkvAHhhTCe8Q/UwICBZ1/YEBxDGF?=
 =?us-ascii?Q?OG/9H5b9z9EUKthV13IBJpN3VpKLWXDU9Ah+iI9n54qm2ZDnkLDGmMCiq/zj?=
 =?us-ascii?Q?YqQHrjFgHo/bVJU8uR8kDXUMeICKgwog8znVMcYlIdtCcxk3IlKaUfkQ+Znq?=
 =?us-ascii?Q?KPjWF4VBl29ozfToMAsWk8ByUocqI/qtxeAgfmqboU10xCs2USuL3DUyzE3y?=
 =?us-ascii?Q?63irgdxe4/lzGvYkmdRTVH+IhhEbvO6gDPZ5u2c4lfl10BN/UDYqhmFQ9A/h?=
 =?us-ascii?Q?URLNrCAK6Exw9A28Kdxj3KZTFRaHsa8963uiG8oacImg+0xMkmqtnRv6lgL0?=
 =?us-ascii?Q?2iBS8udHBCKwIgEm/DDklXG1wYvCshnTmO9VTmbVetPH3IrLd34EfORI34cu?=
 =?us-ascii?Q?T+CDOImHE31USI5909TUiBY/GXv6N8D31zZpiZgvIXSf52+S4l8WIGbgrUUh?=
 =?us-ascii?Q?Df1dLZKkzb/XRCD46cgB0dyIZIsMRdY4TrCBO6TGp9T50b1B83BUIG5VYAr6?=
 =?us-ascii?Q?Xqql4ZRw1OTHapITpBik7EN/pOS5vZBP/E+atv9MinlEyRS+cjy/qi7n5Gbv?=
 =?us-ascii?Q?ajaT3VZkR4RzmAj4afJLFaeby2RxHPNUsDO1aNRRkH6XXAVeMQ1ixfwZQ119?=
 =?us-ascii?Q?CAm2LWqCZkTelRGFQKdKnFVmyUBi8nMjievtptHK3WFgkuuUyKa9zucUotx8?=
 =?us-ascii?Q?VAQhPn4d7UI7SSYpq5LC2hMsp0ppiBxuWXWnpclIpkaYZa0bLIha5o83AcYh?=
 =?us-ascii?Q?4ZzWglg6PT7m4KJEfET9MXtfjfOON93ED/U4EuIBzJaGxvYJj8q7KPMly961?=
 =?us-ascii?Q?XosUVgP7DbMjSV82JVZ+TVN0mBuFYIsaw7K5CVXraoj/sjvvkrYcZQAZIFrQ?=
 =?us-ascii?Q?cfQFAHTpClLroNJ+ZIj91f3YekTFm9eIPjaL/921fF+zNA+6i+0dR5P0c4HO?=
 =?us-ascii?Q?JW93aeArEJ+Izb+xUk6svoXU3KkUs8EqbG20O116g4pKwnz7WAC95CKsKfSm?=
 =?us-ascii?Q?+fxTKxoWosPnPJygo19n+lHjVl4lt+Vzz1zhfUAcx2Zjp6tkFkEi6lsJwAlY?=
 =?us-ascii?Q?26nn12EAG3pWhPjFfFoRtTwp2mukP7Z/teHkcUS7OZY5SvXyz2D0ild92AX0?=
 =?us-ascii?Q?g3GZrJXmSo5rCW/DIlOf0JU8SiU0iammDQ4PapjohEi6AZ7RVWmEm8ahyWmf?=
 =?us-ascii?Q?k3tRK6DSzO1KoER/umW7AxLbjbJBEh8MBzcrtuutopqij3tf97gjB8RwoPk+?=
 =?us-ascii?Q?r8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9rLSJW2MKnxPW1oIY6nDauX2Ovrli4qWYV8LzBHTtxAJXVzIFFmt56IZizW?=
 =?us-ascii?Q?y+fycwxKRS3PGrgb/cfBtk38BdS+Rvg12PV3mkROj+gTNpdwvMN5V8YEDuVg?=
 =?us-ascii?Q?jYGoTIlFHow989OfaD3pOx99Ffgh1GVSzIyLO9HO0VzRma+H/rVk2GfMiD8G?=
 =?us-ascii?Q?UXfIMKHkYSgGYPwRXcoUvdIE00zZySv8mmTQWD0/hNqAYjdOeqdxI2wrz4B/?=
 =?us-ascii?Q?Xk3pk81ZuW9dW2rXlo7u5G4PisTZVayeA+5yJghYY7+YVEq11lTpDxJ2BpFk?=
 =?us-ascii?Q?z68BFST5OAPmZZC2D/etGzJQkjBdeHlr6H9OLEgdScwdpuE3XCcdsThg+5QB?=
 =?us-ascii?Q?qsbMlEnV/0O5CO0HS+I/ytkd/1cUWI6a8K7EmfOn9541o6Dn17ayiA4gqpEt?=
 =?us-ascii?Q?PFKZQ6moLI+n/w92iYwYfLVMuPYHrrKYUYD8zzRsFP9ybwK8PxEpTzJmUyJJ?=
 =?us-ascii?Q?VW2o5X6njDhWrcv60ns3p9ZrP+BH67BOJxX70TGVKDoOcNl4hNUHRDmhx6Yg?=
 =?us-ascii?Q?h4IfvmWEtIlrSQgxnM03cvukU4PhY6IdhF7nEYpqQwF1evAkZhJhsGnOzzxw?=
 =?us-ascii?Q?fofYM15rmmV1XLwwhb0Hrf9nAZmxDodXe9MsILeRYL6a79tIj6cZ5xGxz7jx?=
 =?us-ascii?Q?PycdtjeR4Pf9ByyNugpJT/xA+LPEvFjYBfoGpl/qKCvLlcMBwHAtsPOtqhH6?=
 =?us-ascii?Q?5QjYlgtZC5KwXhoZzojxCpzL2AlbiYdFhYqlOHCaodG8+7fPFwTJJcxLvIDJ?=
 =?us-ascii?Q?4ldVwBoovNKbbNB3srdepMfxBEci9f2Bk89+aoqRSiqI8Qwa2Fw6lOmgAeEd?=
 =?us-ascii?Q?+RgesoJaVhVly58H/7RqF/qULTLzXAAUDE7t4LHmia3Oxa7/zZlCA60f4+tL?=
 =?us-ascii?Q?ZirCdKFuj/Qses96FmERmMxqHvqYWpF79/XGIwy1KB9kX4RXhvDuXBrqxGKV?=
 =?us-ascii?Q?vZTCtKRiKME2ZnR60A07iXlNCJzmv5WvibRhAsnm5kASjkDqQJhtwBlHt8Dt?=
 =?us-ascii?Q?ElxdJq33e+SiW6/0Nijfmqj1t718j20XZ8Q8D/UHdA/DlJeC3TqII4P2g1Bd?=
 =?us-ascii?Q?AohlCMNHXwnERTsgtd2cl2x8CsgxJqlBOu3CXYNchMsh9cG82w2o0Aup3w6G?=
 =?us-ascii?Q?UDwWqPancb8c6VuR5RI5ZU2ithKKSNlxbs6NfN3rQj1YPooT/QRBdvKBtqJL?=
 =?us-ascii?Q?esjKDaxCQgXSLfdPwonLoMgO7Kq+2aKmbUEvgKjEzICnzZUK9nYgN9U809Pj?=
 =?us-ascii?Q?FF+cqp3KDFj3WlfLV5sir11ZHohpb7uTfJIVsoclEOJ8WuB30wYbCPsoOke4?=
 =?us-ascii?Q?uUs5mfry2yWu/XhcwF+v26LOaziSn9kmZItAkd320ujvxhcljds89t9YhfaA?=
 =?us-ascii?Q?gQEEODGBBG/DIQKe7VrwHzqEANopJ6mdH7G11bZC5c7hGdejuebN6WBQ2dFm?=
 =?us-ascii?Q?o9tIERc8PaignNgdMaeFJ5x5eEc7lu26VZXsbVoy69qApN8nkdE+r6vKlAql?=
 =?us-ascii?Q?PMB8U81bdGMzrbeAIiBBNm6SZSM16fSA60Q32PDzHnL34Xiwy6ta+HvTj4qG?=
 =?us-ascii?Q?cfpzhWq8NNvhuZeU4oDDa9xfpRbqRDIFtyQGPNeIVgTV2GkSdR+zXlbbMRx4?=
 =?us-ascii?Q?+18xyjr8tDZKLUtkxXOOCRA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d21f6a-0d3f-46ed-70dc-08dca64c8898
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:38:02.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfzqVVfDQdjjSJamAPGq9uszYVp1UEDNQ5iZSrijtHXAp9puUa9xTxFIacRYa53xIlM7qZdS22QzeaEUsD0fzAThY0jIKUZ3i971D7MnXOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6439

Create a variable that defines the runtime of the tests. Use this
variable to calculate the timeout by adding additional 10 minutes.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml     | 4 ++--
 scripts/run-lava-tests.sh | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 1160039..be1972b 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -21,8 +21,8 @@ variables:
   ISAR_IMAGE: demo-image
   ISAR_DISTRIBUTION: xenomai-demo
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
-  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 300'"
-  TEST_TIMEOUT_MINUTES: 30
+  TEST_RUNTIME_SECONDS: 300
+  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}'"
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:4.0
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index d478a11..97061cd 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -38,6 +38,9 @@ lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}"
 DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
 export DEPLOY_URL
 
+TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + 10))
+export TEST_TIMEOUT_MINUTES
+
 echo "Deploy artifacts from '${artifact_url}'"
 
 tmp_dir=$(mktemp -d)
-- 
2.40.1

