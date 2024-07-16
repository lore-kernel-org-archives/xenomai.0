Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4E1A2FCB
	for <xenomai@lists.linux.dev>; Tue, 16 Jul 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154819; cv=fail; b=Nk05tOwHruKTNl00yKsLPm85H0mW2hcItl5YLSMkFfKLKDupSQ9phLgJb60elyRh08hxoun9A8CN0m5c5+Q0ZhRct9bZbPhxiLvWtwYuWkLF0xxhp5ywbDTT3cVr0abH70IeI8bvum1Hl3u17JAc5ZMlV2D0d2PBKJnK+d02qCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154819; c=relaxed/simple;
	bh=YGMafSpuqULzJUY1G6U2j7SKZDR8Eym2U2U98er+eAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aa7VFRgR+Aro0MA5fdidqEGV80RZQZVdbaaNmX8qNd6CfiORKrtwvLkUProjDZuhQ+Z6PsMxEzBnWk1YyHCEDG7SlV3qjOLQHL5fnFoym6ZOZSHuw2EeXW/OlxwoT0V4tNNTfsrJVFrUd2g4BMotWSJqq0kYoMhhx1l/23gejr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=M46rIfZF; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="M46rIfZF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8SXTRRYq2IHBAqWIyjgqda9Ojb1gFt+BiY4NPgbbnBjlanmqSKalaIN4LQRIJ+nfaONIxjNHdf4XxuuChRcXRWwapfCCHY4g1ot+iuhR6Xd91pa1BO9Czy4V1hQfNh1BreXyg1fvIXyZ+SzBY6/aDobg7sa2b/l552maPerswMQg7U6YoymXTZyQGusBcWnSEMEe8TRacUL/IeRHCxUyKjdbkIjeM94UuiquWZzICAmpyeG4NNr1xTlDgFzVB1aiQ49UeJfW6g8INlQiiXvNRdIREJxJYyDN3/SZEtRHazH3+gEiedscXPi//i0SO+cS0ZKHuv39ba4W/svKe5P5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJaHyFsUZIlgZHf/pimAMzQ8i9cBact22QzEFxrDa7M=;
 b=TZc5GtsJRXJ3v4I6eFVD6asSaAeKVziNMLjh7j1eUtemdQZK+alfEdG7wrYic0fS+zZQfPNn2sK0F0PMRt74AovDwP8tJYPbC/2EJ+3sVCn8shST0xcokbJmCqzh+c5wgPG7O2Q0J6/6GWrnI6cs3nkX9MnXmsxQbVl5ipH64AERiVTPsZ2f762XUY1hfnsz1fGvIiONDcKbHDHP7gcNV1VHnXR9y1ARAPsSg3dHnlzogq0t7TlS7JYZvQjPtJulid0QGKbSmE7FFgoQ3RiXcesFElv4xn6/IjszvNePAqkMG+XTXdTMZBucrRH2x3t41adbeyTAQSmFovW0IJR1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJaHyFsUZIlgZHf/pimAMzQ8i9cBact22QzEFxrDa7M=;
 b=M46rIfZFDE54F1Ux0TEjEowsHYZ470OpwA7Q9hy/z74mGVKHErUSyPOETi/HoCnCdCdrUphXJzD0f/y/ncDs15gCo8DdcGIjQkXmkfx4UNNZETb2kLlzjWxMrORz+4LuTOsy6HSDRZFPmpZRvuyaIiUTPhpv5KpCEiPO8xNiL8vs/mxh09KzVopup8TCDX7fsQGPVYR8x2rxydz3o6yC1kCr1+6QlPl9R05o58UC3a2xBJy8YJM5hm7nkNnYBI+QoCAswW3ai5A4UicgA274wOOYiNgmtTn7PDSEXhOoM+nVn5ccuvQtBOYBv7yqefT5sSzdeapUD5PX7/ithtsVRw==
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
 18:33:31 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 1/5] ci: calculate test timeout based on test runtime
Date: Tue, 16 Jul 2024 20:33:22 +0200
Message-Id: <20240716183326.1432379-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
References: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|VI1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: a5bb991f-acab-41c2-fc03-08dca5c5cab9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bcwfux5ZCa/UqKHh/6vVsG6LjRZoPaA616BedLKzX5OTI16cnj6LgC1fqjOa?=
 =?us-ascii?Q?V9ffjCLPN3J10lbjvOCYLDkLgiqMEnw52aj1lT17Vp/lbBdCD0uUpU0Hi/ec?=
 =?us-ascii?Q?dLX4ANEX1RgGk75hkJbOLFJywIFye8OOSfkjL54Ss8Ch4pdbxBjUHOAjIuqP?=
 =?us-ascii?Q?/sKxHI4BJsXUT9Tvuf4rQ27CCKWQqSwYff2puqcEzJtKdLKUC6vPcQr4OClg?=
 =?us-ascii?Q?+VLnxkKPuYAa5QatQ7887Fmw/Hcs4U4BXAHyFQMudvLP7vlYwuJuHf+2Brm6?=
 =?us-ascii?Q?gT+9aaN2AomAJY9yGmGI5dI3q74sAIu8h9S0mmWUIdeeNLOh48hMAkVJmnyI?=
 =?us-ascii?Q?C7M7FCemhAof5XaPQlRRXJrVbJ8w4AoRz4+BwEzYRZWSfABKMt4XTFXHyAVX?=
 =?us-ascii?Q?dZvF5aDmkrulm8fzMk4YEnZE3urNXCiZKJs1q57y45CyZ5bta4Fo0aaib7lp?=
 =?us-ascii?Q?Sp2g0GX0ygWfgjBjVjksMFQcKGGHvYVwu6wHVOD8UFTN35aFIaEqv+WhHRGb?=
 =?us-ascii?Q?9NUnf7IBG4RLU2eQGXw08pefsTxWlwq+LKbA8i0H7UmvPE3D37pxnZwxsaSO?=
 =?us-ascii?Q?xc6nj/xT7tSEzFFNi79EjyaGt381xViw14yooQ1iwYalRxW8QMNuO+gczcaP?=
 =?us-ascii?Q?UyCRTILWqbXBsCNk3LA5Jl3SuMWT9AGfDlhj2WZwQyOdHEvktiEE15XCrZON?=
 =?us-ascii?Q?iPrEPF9MWsDZZLAKr6jJQEyxxI5s/3bmi9vOjAxmxyG98faDt+LNTICZdVS1?=
 =?us-ascii?Q?h+aioBE1Gu83RD9iyJ/+rW3TJxlhEELV2mwNGAZyl4GjUJwVpOYYYDJAV/k/?=
 =?us-ascii?Q?NFBprWIaPzd93YGvPCiKKvH+BkeAQylwXgFmqQ+/d13dEuVJtZoajdACziqb?=
 =?us-ascii?Q?B9s/5BcKu822HJsXlXMpJ3kful8jZCFhfvT+AXCaLayIt+8/x75D+EquuaEy?=
 =?us-ascii?Q?Soz8gO/ZXmlLWCMd8zqWqdTYb4ulKzzg1PGpVJmewawgHyvdRfGlozLPQG7Z?=
 =?us-ascii?Q?clkBTDzXo8Jy/ezIHQKiqa4vASyGA8qxRjjwGTpc5FR7DAsfQLaErIlYPDnQ?=
 =?us-ascii?Q?/4uax+oqKlVDzZvwS5OSrC56R41fSPwjz2zmbIPXL8nimVBpcTb8A4NaTpC1?=
 =?us-ascii?Q?v9i4k35L8PzAcVmCRmyB0XfHZE0z3GGzq994WEujg8p+ehCNVhA20VWr9aRC?=
 =?us-ascii?Q?Ox2AyMjxiwsHAhAopuBJCi+MpJRvrnlVyNqnKg5dHA94PRggjfgKbBrE4ttj?=
 =?us-ascii?Q?lzgF4GI97sWnIR7XecKX8mSVg1UhDwayQpPH5K22tkNXW365P8vktIb+sNvt?=
 =?us-ascii?Q?7JE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LKb/1V5jnV45/8pvH4zQzgeNp37OyKpo1N9xuV8aXh33n+9x1U0fN0zEj5zb?=
 =?us-ascii?Q?iNvcjGQaWK7N0TsIY8u4Wm7oCcNVeIUuLzb8Q76/gav1bqsDcDgvC86wbwus?=
 =?us-ascii?Q?IZfb9WqpI29wc0euL30sfaYa+7/gWhvKmWKdUdcKix9WnBahhSw2txl3zfZT?=
 =?us-ascii?Q?v7Ivj9ZEXDclAD8i5CswoTtSFzRu5QWg6Q+cz9k60w32dTTvjel3S1e82s2g?=
 =?us-ascii?Q?gagCmK4YV3mbdEx2LB4/IGbS9DYHR9kutDjlxXb+m72hGHcrSLlCYYMSdrt3?=
 =?us-ascii?Q?pwPL0eMuka25i8+lpvxyRwT+hgzTJGp4orelFgkkP6rf4nDG5FH8xkyFhUR4?=
 =?us-ascii?Q?3uV17w7au4Immpqy4+h6QXg2HWh9pJoFEb1fOp2oYnrgvgCSvf4zbnq517l/?=
 =?us-ascii?Q?g6KdeuggfCyjj2YDeX7O07ZMl6LA0nJHtNfatyeagL9yNWmqoGqy0ZReu4AW?=
 =?us-ascii?Q?XewwXosa9pVn18C1zLHB45kZyUZG4bhy7wz7uTpidneVnghE5axblW0k2TtH?=
 =?us-ascii?Q?SGaUSlXRdzht5NCcSapASugEjhecgWts/mLoTCn+6pzJWBA2ZTQ9WDgyOQlF?=
 =?us-ascii?Q?hKktKUvwU/U+B9aOdBw5gXkghiurx8m0wTWMHdkj/gB/0TCd500rDbZ/JkzS?=
 =?us-ascii?Q?JS6PQ1DR9heLVKLQrNEuA+O/Ws09N3iz832ISYPYxNXlej3qTwA8On/lcuVF?=
 =?us-ascii?Q?JOIcDavl6VXi3rTqjnwgjryZEnyrbKGmQzZpQoGqBUUGAWcrXWGsJHXAH/lS?=
 =?us-ascii?Q?q6w2NlAuNrgZkfo8eex1tdYqDsQk/+c7Zxow8218cOQkWAbIhcMtO22KVzdA?=
 =?us-ascii?Q?+wC9c71JB1iTsKZw8ruvaXxQO/GAUB4IZiJQ6Zr8xWqaBEqn3IKIMutF9jul?=
 =?us-ascii?Q?bhQVnbXqiGE4/PZMWS6pVTc4Bo6Qp8pgJuPOSRPY595f8U1aZvdaEkY56cZO?=
 =?us-ascii?Q?OWsPmzeIiVbarg5T/tC2qx4E5BuahFr81YmI+LqMbJ0+WqC2/AVox2CSsimY?=
 =?us-ascii?Q?zmGVb1NSmJFlE53vuBYGQpTrGL3YPNJWtFyjHGkaDhE+TO4CLbN2YBVaXGuJ?=
 =?us-ascii?Q?f5vQ3gtaXxdX0I1Qm/SXPJSZoxtzi8cWgMPo+7ifK+OHqPQtJuXS/Nc5EF/L?=
 =?us-ascii?Q?PjuCOlKy5jLIV7pTXKI5qstG6L4KnoqHwf+OmgxhS18ZvazKDzis2lZddeg+?=
 =?us-ascii?Q?fYwp/oPboygOLXZedEXx46r+GRxhfoArPgAVBp7yVWZOwMZ6SlFOxYvALazi?=
 =?us-ascii?Q?LrUrUphg1sG748w4P/pmAP7lupzrlHBKMWK2+Popw/zk1YmaTayodIa/KfZS?=
 =?us-ascii?Q?w7E8lWY/9m2Ztc9+DgbU4l/NJ5vdHy2cEjTJ15Kh8byPH5CUQA2piRSnE+Jd?=
 =?us-ascii?Q?e/LQMVa7loxpoNZSmADfu35k4W5LwbvW3WTKWrB0f32wx5KvvrmKJDOCSQEF?=
 =?us-ascii?Q?EFP5T0wTYDEzDpYCCsPAnLrsdCPv6DIjlM2YOsqNdOKRK/dZUGYRP9GKUUNv?=
 =?us-ascii?Q?H52oha31JMby9ui+ma1cOJJ3OwCxhQ3gccTEkvt3r0oulC/rIM+/g0non/Ii?=
 =?us-ascii?Q?WT3ClwYjEKTwvHjYxZmeh9axGGg8wnQ7KSsrIVblqujU6QWyVcBowfgM/GWC?=
 =?us-ascii?Q?3YLSxhuGQijGJuj5ajrJ8bd1roA6cHA80PT8/gfMLvT3l+EX2rde3ZLreCdN?=
 =?us-ascii?Q?JvYi/g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bb991f-acab-41c2-fc03-08dca5c5cab9
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:33:30.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /s1+aSyphV79t1kSIC9qEkRGVNovYM8PcRhqhU0sGcXUT/HYyHRr4U/gfw+/T9Mct+r4pojm9vEkxcJW+6rUhcw7r1ihyza4OcC+fMoh2ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7829

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

