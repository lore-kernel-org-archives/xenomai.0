Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50058.outbound.protection.outlook.com [40.107.5.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076411C03
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 12:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKKJKq3fVvUCharZWxg7hSod5Sc+K+mxlzAVmgQv/MAL474rZNXyCMJ6GZlrQyXmePlKpZQ1iEb5X+oU9DdFNoIJj9N2sP5qsYQLMD3dGZcnS9sa/A86P840GhPH0gTKvT+xnKIYEf1API2NNKm3MzXmx+FdjnHL541764tQeaDjMXCgSpj8n9ymL49XJPn0z7+vkVFPPhVSUICqd/10a5gRIUoxZSKU0pnyRhVgZAx0fMGgnDUNruyDlSBz3sQ26sUQnqeKJLyEo4MwBrea4KgUV2JbmVriAwjFxQt90R6eTS/eXh6sTnf6f+vXtoWWnZtvo3qG3o6dQq4QBRaNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyJmeUqRW+++uEHGmUQIipd1Jus5s60tGyHcbGVzrTg=;
 b=X36sQnA5XF6IJXGl4aWMFRgxNfuNyMUXBK1Uf0L9av31FKmdNqXOJf1TSKLyNd8l2taw/1M7FbcVU7UtpZjiQ3ejr0OeC46ja1onaVGCZAs0EvqmSo6UZmlC1+J+RmH7kmrCoiT+EXhcgavS7R1DhzR6tw4v+rOcL62uvLKbZjAJv2/vZ4zR/g8H6FZ64CPlqhdOf2Cv/spB416eJRUJuIfBk9+cgmu57CmzWMFBRncGZeKtTEb5r2NE5uaJFzZFC4i6566USBs1MiOhNhzm9EvyBdT+xjNPi5h05LRNto8mMK8DW0cMiV7aJfD0+wZb1w0Q39OcLws+fdJJ8lB1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyJmeUqRW+++uEHGmUQIipd1Jus5s60tGyHcbGVzrTg=;
 b=DkSDqx2ZBUIjqRlHrhcyv/LhsNRB9UR/bkBX95UZ6ZvhIMVjKh7fc3HCbCCL8ix3z41f8V9gNNahkmVxc/VT4+eX4/Fn4kULlZyjxTHE46HLkp54YMJ4u2z++niqMFZFrMJoFJBnsJpph01nTVqYgvHWPKHgNBOc8szjbwb6qch6JtDOQNhlOuNl6UsvDfpQhzevnvcar6NWcUZhse59WnL2kMIqvAn16y4LzwkDyu4dbVIjVvfkCadw0LCqd7/DwtwZzqoxIj8yEpVbc/MhO97CSRSjnRRBQx9SiqhRcjC32OyzZZvWeaIjPbKt2B2Bj4CVi5AQ9+l37xnluIWN6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 12:25:12 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 12:25:12 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 4/4] testsuite/smokey/y2038: Show sizeof(long) and sizeof(time_t) on startup
Date: Tue, 20 Sep 2022 14:25:03 +0200
Message-Id: <20220920122503.115682-5-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920122503.115682-1-florian.bezdeka@siemens.com>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0098.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::39) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: f47b31b8-5ae3-414a-fc24-08da9b032a51
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hOaFOQGy+dZDDZk4uQFiSv8ABcWE08tDBqcIRfnoALmVCzNdq5gYoN7y3pDScZCFEYd3wtLO/7FZvZHl8S/Azj70Z6pY7W+8sF4cGUM0ftEMmgLq3dBTQ17Vh9ya6Fzg1tksO4uEkMuSjniLu4roCNmGkb3LWfxfmL+UPVBXK8yks9KzQGncXbprDweMkjkNjQ+loaOTe9s1pkf7kURHB63TRymWKZ0ViCm2x3DRZPjyhG5EB7q/TTIjqb2IEmE3C03HPu8WUJWxM4faiSlK0S/cHKsYjnQQlMYhNiwiEWIW3ubxc3FmmuzUJKA4OUdHJJ/k7p2ZyWJKLXWxvHet16DJcp3aWygRUEiL4Nvf4pavRZ9FJ1Th2oxoFkkd691CwANfjsOYAR+Gt3PZ3uU7gsllNAxGL5l0dXAH5pqEc7uVmT/Ncm8mbGlVYITJv54g1HsNf//jm3MSSxTVjKr/Zjx0H/Z8V/iPzt3uOh7ZIVjUiYgB5DsxOi68mXxkKIBRqi1pGeYrObkJ5ayhWdZGI+hudl4RmgXy/BNT+DPoOKQzJQjIUaJCyNPnYV1fhzIX4bp/IDvVv3qEn5fzRbU3mwX1qL1ppDq0wNXrwnhuDZq4hBaD/QduY4r/ZGa5coDfWXvOWW+BdtxijnOPkot+sjMqhfVCw1qCEjp3p2ZT2LH1zKMg5MGInq8O4kciiM761YwoGqF4/hxm1hYW/qYOrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(2906002)(82960400001)(6486002)(5660300002)(38100700002)(8936002)(478600001)(107886003)(6666004)(6916009)(316002)(86362001)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(6506007)(36756003)(83380400001)(2616005)(44832011)(1076003)(186003)(4744005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6UhPihzvNmdcOgTjeu67cTSmxg5r7QaRTjWBV2BZvNrMDEux/Xjdfn30a3Ul?=
 =?us-ascii?Q?iNRUb0E9gYPYa28NvKuJx+QOFLSCpLDUowkVtQsG/+uMFK1WdaxSEKYfF3aM?=
 =?us-ascii?Q?8VlCRu+dmfTsYQMXMBHN9QSrxT9ogX87opLbEcBzi98aU8o6Q8Q4gP7G2gU7?=
 =?us-ascii?Q?HkFodZUpZrqOFwvzrNDSgnLQrO5io8QFXABPKjc2VGqn/clSQUEdRUDbJ5k/?=
 =?us-ascii?Q?ijqVlN0gHRBYXuGMaPvcteqttfmt2z7weVgYAt+K+jxNqZ+HTxObZX9E2kL6?=
 =?us-ascii?Q?46L/L56C3H9ZpmU+Rw2TMgIX7+EryqQdamfFtyXx1af88jv1XokHrQYaYoBn?=
 =?us-ascii?Q?7jayrQ9CQty14gWMdEJ6C5CYNq1CKjYb9DuE0ph0OM4XHlzSUDi6RqSi3gC5?=
 =?us-ascii?Q?sgywQia42i6EAvuNeZV/AF6vaLrDanvJWbsdSlinKiOd2SKAT5F1/9/oip3J?=
 =?us-ascii?Q?DrMnyFE3JJkZBDxGD+7KiSP6T6F1SlirCe4q5NAuH4nV9bneUyWxO1aX3TiS?=
 =?us-ascii?Q?LaHsexnZR4vMQmoxM3PMMRtKHvS4hOxSL/1YBII6coQtpTbsop6WF8KSNA2r?=
 =?us-ascii?Q?tYNdX4mBs8uZxrEtc1mUTaE/AMxlxZJildCm9UllfEk0OeWS66sT8prZYn80?=
 =?us-ascii?Q?y6Ot3sjHNMsc6dEcBSqBgDXR0wotk5MO5nFWpk5IC4YLWIBDul4LydoD8yi/?=
 =?us-ascii?Q?8/AuJ+5g/HL2tNt7EkH2VJVCPGdmsXBA2NMjlMX2vp7n+ysmDszFuRNfZbjR?=
 =?us-ascii?Q?tWKygo7sFdor75QBaiIumQf/qFbXUankFS+BIgXNuG/2q7MA51v7S4cjQKE4?=
 =?us-ascii?Q?i75TiaymlvLiXjCQxt0XbKkG1EGx0NNyaN55xa6q9nYgwczxKHYoNS9HFyKg?=
 =?us-ascii?Q?Dq4DZKxwXlyrKbEIihgfGqRGXPfISx9O9K4ORPE0eX6XFpXJ9YxoF3Vtcdly?=
 =?us-ascii?Q?eMXZyijDXc8SWdet4/y3MJPNvJs4BYEBOsWNHQlkz/SDZLU3RT3GPROm17TO?=
 =?us-ascii?Q?0nO+i08G6YfLJcaW8oYXqyvtbCzrQpyJzsu4Laaq0YrwA3QvWAuAAqJsVs8/?=
 =?us-ascii?Q?VkXYNYDyiO9/SO0TTBY7jp1GnKCvcnZxR+E/vLnKBojPB8cjjbFHok2L5YnM?=
 =?us-ascii?Q?U24gPTBcVT6jhkHHX6eGnsazyon4TyInAEw6y2NiH5gcGOJ9EGAF0oNz6/QT?=
 =?us-ascii?Q?q5HSgmRSbN7kR6BG5bb29aC2O6ox6sWTVfMeoibIcJSOK/Uf/sLBcz4hzw6i?=
 =?us-ascii?Q?K5RLFwyOF7wLSuBwH5cY6DHBmQDuYKpFmVeQrMAMkdMvKOPw7VtaZyUr+OCC?=
 =?us-ascii?Q?Rd9uqfdhUGfLrBl5SxMrIvu2r8+S3GUYrMJzFurOz3apvSH34SFI4edWtuKn?=
 =?us-ascii?Q?N6ptzVIKLMnCdLsZ1LCRQIrlBT7Bqw/DoY3KK+ttVp/fE3eSuCgf8313VpVX?=
 =?us-ascii?Q?2SfGnOD0z936OstlZ5T21uGy0lbnzJW34jraZ3/ldObjZxf62kwhO9IutYyh?=
 =?us-ascii?Q?yG3dRtxarOXpW4Hm8cA/aOJ64Cr5LQctwGctwK2+r9fGNRENOO+NeJBqA2al?=
 =?us-ascii?Q?wAuq2rrlH9LQu7Imu6JjQsRcSPub+yW4fHYp5Zn9jeHu1oxyYTdKw9QGXIWB?=
 =?us-ascii?Q?rcwsYE+kQ889GIY7IgUomN2FMpHpp8dlqrYMBkm+HVVbXAa0v4Z43kri4f1D?=
 =?us-ascii?Q?T32Y7w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47b31b8-5ae3-414a-fc24-08da9b032a51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:25:12.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEDmKSIsVDqijIzh/SzCRxiLxBDaLEwyJ9LvIwBIB2NdqfHa/eBnZWToSR7fJBi1wIfkeLoQ+pMR5OpRO7GhdcSVtpKnCQMqXDvZ3qUb8aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611

This helps to identify if the testsuite was run in compat mode and if
y2038 support has been requested. Useful when looking at CI logs and
trying to understand the runtime conditions that caused a failure.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 2f4041e51..b1abec260 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1237,6 +1237,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
 
+	smokey_note("y2038: sizeof(long) = %zu, sizeof(time_t) = %zu",
+		    sizeof(long), sizeof(time_t));
+
 	ret = check_kernel_version();
 	if (ret)
 		return (ret < 0) ? ret : 0; /* skip if no y2038 safe kernel */
-- 
2.37.3

