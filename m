Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F16A4A
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 16:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mprwUZFNozDNAjtUBe/5YgC4lB3kBdegoC/LV50ZI4uNIRzV5M1cP9a5pikkI4BSFZ1yxHfIs/oQ8Pl0HzlGgIU2WbxBP9aeu8cxzC/9Ba6FZnRChJK2Uhp5/2ZEPpJq69jb8JcX6zNitI5VP5mGZGcmOC8GqIR1wnoT6krMmDND6d5zHuFH29NwxkqgOQePPi5RHxzVy1lfqCPJjTGctnqCmOtUtEs5US0Ppp0iIcdat7axwqogwbx26efoYyhpzc8qFVt14DjPDtT3H0MvVnB1/TQ8fQfS4d9pmu1uCchZUOZ5sC6nwche/YSl7v7IdqUmGLyAwyCjBH3PCbReMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11C3YD3Pl3UMwNOi5XLJVDpIe45IWnAcZ2basf2rbcM=;
 b=k1uveFyUTCZoT4aJv6koYZ2pqNIjq2L8CU8GEHH5wDM6bHT+C1/Gjvx175F5SmXrb7XeSs4KwjeYR02gi3k6X79AmQw4h4zQDlS77kNV4FORKBJrbbbJiUXNymd2TLt8TIQmlOFc8WFq/URrzkDYJbe4uDE50tlnU0E7x9hXr7ToWSbhLZGMxj6fBzOQ4n+HG8shTm22/SXGttpWnmAPPHolNunvve1SCP1V19dP26tj+lqJ3onvvMv1803CmdJNiQ0+J4dCiZAv2Q0GEiEeeqPt9qlfG5CFuywYvN6u2+SUfYa4p2H4MmX/XTKD+SQ+SNlt5N90a1pKnCK1z6RquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11C3YD3Pl3UMwNOi5XLJVDpIe45IWnAcZ2basf2rbcM=;
 b=fUxIzmi7kdhO5XFA/b3WbznJxNJWVYW/80FI4ACf970H8Y8MKVhvUpT+d7LGNsmq/PaIDfB6K71YhZE696lNTE4Yk2BXPgy51uMVFfrjODdT+Dh7lEGQeB5cb+InKth76ph2fvL1ToSnMm2fGh/EyvqjikWpdVhpkjz7ID0R21u1JMgX1ynHxfgNBeWEENBRAI0PgC/Ypa4W/KevyEHQdvRCGkdnHAtnKFwpZcdgHqiO4QsnGBvd2NCspbPw6RZ760KwTpTv6ivPmeKWuB/l3Lfof5vkNE7Ys+bRt6KDK/r4B68aad71CFeX5xs35wCYdrbSwJgZbxSCS1mFGBU0QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:57:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:57:52 +0000
Message-ID: <ef94e84c-a031-6df7-454f-8053bbb1611d@siemens.com>
Date: Wed, 4 Jan 2023 17:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Switch to native trigger
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cc7269-d936-4061-ce54-08daee74d18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bR6rDqe03egQzQqIHzW11bEsPaEGOD8nMewLaC9oiE/YrMsujTgIQHP8gr4V94kQJd/aXEstdbHM9MXtS6qQyup+MRQuRk4XK8MupXD4jd24qXmjIQsg9JoCs83+TQzpDSrgKtA9ZCSSxjTxMDuwAgMVA8u5kyOMVuUcqVKsVaaGhmwdCgOc4TKpKnkV44yLnxinnkO6erVfcAx+fAfPLH+8fWmNvd++P50YZspYc4RfBgMoDk7+xL5ov8YoOdzUiuZ0Ea7L0xvf5RzwbAwDADxoj8jAkymjuZD0uYODA99kA3TXJOgsOpch+pqk1hyZTRfzZG3ZR6azLWRbr/qrQqMg+Ul23MNHSOTRfWx6bLxojev33LmxOIB5rkYaLXJKt1jM0F/BAxu8mVKo7Dm4QAxxAybxdAwq8Yd3xNyA0SCjxdnyExxg8BHXyqoJ1LyTW2g+OHEwqQffo/R3140zz9HGT82HuH4r641EfxOfPCZIIc6qWLk/2wGDEjTHEJ6G1Fe60GIdkxiXHxYrDlaDjdb62wthUgPX06I8skSkCnPhUNauOnPoiz8j6ZC2FY+BwU8WAABcWSLVkbzMJWfdRbzeRL4Jn8a26iLq61Ou+zwAQBnYSRBNM+sVVUQqylE65TntJSHxRVpaa0bsYngY4vSsitwzTVYxEgSJYP90oI5hwhVwzM00i6xYHfI3myKrEw1URvxxhSZlLbNL7GHOI2xnNYWgv6gTAuPczjceV5qoZ0ziF9+coF8LRAuVqQrm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(2616005)(83380400001)(31696002)(86362001)(38100700002)(82960400001)(36756003)(66476007)(316002)(2906002)(41300700001)(44832011)(66946007)(66556008)(8936002)(8676002)(966005)(26005)(186003)(31686004)(6486002)(6512007)(478600001)(6666004)(6916009)(5660300002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cExtcXpqSkhGdlNhNE9EL2ZwUVJWVHJsY3lndVRCV0duTDdWR0U4aXRNc2cy?=
 =?utf-8?B?eTFOUFAyNjlwZGZ3Z1hRc1RYTDZMN2FkUk1Pd2c5U0RYT1pUQTZ2QTNabTJV?=
 =?utf-8?B?V3FrMjBENnd5aTIzc2xyaEU5QmRiWHYwT044Y3NPQU1acy9OcDRzc1VyVnA2?=
 =?utf-8?B?eGFhMjJpMDdPd1lKWERzY0tHNzhkell1UHhKcmZXVFFDUmlnRXdUN1FSWVd6?=
 =?utf-8?B?N2lKTmZkWjRtZlpWS1lHa0xIb0d0UUI0NHZvRUtXbHBFNHg5SWZLZ21MR1p5?=
 =?utf-8?B?RFE2eDJPYkFWdXpxUVJKd09HNkQwajlaN2lBU0N2cWhyRG5sOThMckp6NStn?=
 =?utf-8?B?QWE2bmt3KzNKUmNDZG5KV1BaMW9aOVdYQUh5RzRDd2NsWWlsRG9OcFBVOU9G?=
 =?utf-8?B?enByd3NBQlVPdWdESFVDZFIyMXZ2MUhpTzdWVW1lT0lZREU5U1ZTQ2x2Sjl3?=
 =?utf-8?B?TEVwbkZpMWxjN0diN21RZ0d6V0pud0I5RkxKZHdYdDFma1ZCRzlIbm9jY005?=
 =?utf-8?B?bWNDeTJ0SzQ4eFJFWWgzdXVFSWhsL1ZHT21zQmE4QVM2bmFUc2p6WkJLam5M?=
 =?utf-8?B?Y3k4dXNVOHVyWmdRQXhsdWs3NGxXOTNaWlcyTEpOeWRZdHNuZ3M3S3JoTzJX?=
 =?utf-8?B?QkJWVVpMV3dnRjA0SGFxTjZ5aDNWdHI5cWJ3U216Zy80OERDemVLMzFRNnVO?=
 =?utf-8?B?SWEwaXUzTTdWaERpWVJrN0tvd010QTNkLzcyWlJhOHJvWVIzQ2xka0FpNEM0?=
 =?utf-8?B?SEEzeGxiQjloVTlLbEZ0aHRyTUYyb2tUZ2U2Z09RZ0RuNUgrY0R2SlVXbFNu?=
 =?utf-8?B?NFlrMXNKMWFmd29CdThVZ2YzMGZqSzdZMEVHc0VGQnRSTnNEbno1OHQwQ21O?=
 =?utf-8?B?RGpCT29mTjVhNE9KRUE0NDJTZnFKUmJ2K0lMcmg5NHF4S3I2Q2h2eTZvUnJs?=
 =?utf-8?B?ZUFWcTEwMTBldE9HVTJGQXRmbFd4bjV6bzUyNVFidXFzOXYxaDhwRFdRWmUx?=
 =?utf-8?B?K3A4cDJsbGl5RStkMlI5WGhEVGpzaUx4cG9iR0ozbHpUN1JlNE1NRWNJYmY4?=
 =?utf-8?B?eUY2RFRKWldJNGduay9ORGRCOWVKUWxxR016Z2ZseHZOYnYyTkY0UnRKcWs4?=
 =?utf-8?B?R284K2NiZndLRUc1c2ZtcmRMcTRneWg2MW44ZktiQWVPdHhTRmFzNVVNK3lW?=
 =?utf-8?B?NVNnVytsb0tvLzM0cVBMNS9TTGhudlBMK00vMVp4QWpjbURyKzhaS3VIamVj?=
 =?utf-8?B?YjVNdU9SZ0FCRlNxRmgxM09QdVFreGtPSHpCMVk3dUtyVlRkV2hvUDd0VFBQ?=
 =?utf-8?B?a3hCaStrTFQ5K01RTWZUODdPdGcyZ29rbmJGVEdMaHdQY21Oak1ST0VDM0tk?=
 =?utf-8?B?WnNiR29QQUVkZ2FUL09VekVwRjJlUjIrcTdqZStTR0ZEYXRWZkZqSHQ4ZHhv?=
 =?utf-8?B?RnV1N3ova2p5djNiMTVJZUI3SDZ2WGI5d1VVZW84bmxGQ2ZDOW5vUi93U2VZ?=
 =?utf-8?B?UG1EaGI2eTNUV2RzMTl2UTVSZkZGKzBNQWRnRVRCWU9QbEUyRDV1NzYzZFNW?=
 =?utf-8?B?NTFzbnpLaXE0VTN3Wm14M09DVC9VVkxOWnpJVHQvSDcrdllKZzFMN2daMzJK?=
 =?utf-8?B?M3krU2I3QklUYzJXQkZWTVhKa0lSWDRoSmNrV0tPeldJcGMycXZHMk9xQk5I?=
 =?utf-8?B?QTVtZTJqRlVqMEtHQTNjK1I1Q25vUXhTdVgzWEQwMXpLOWdxVHQ3YVdqcTlO?=
 =?utf-8?B?bnBJQWFnQVVJdWNxNFZSZWMzamtSM0ZaN0dleE5KUzVVeDY1Z21hSldOSFJa?=
 =?utf-8?B?UzRFMDU3YTdTU3F2aEwzU0NzRHd6OEIrR0laQWN0cE1nR2hjY25YY2ZYSnNF?=
 =?utf-8?B?aFV0NWV0TjRJWTJyUmlWWmtkYi91QVh2aWRCempGS0JNU016K1RJd0xLRFgy?=
 =?utf-8?B?bnhQWUd0OC9GVjJ5ekxydW04N0ZINVcrNTJmYjFtZXJZOXNrb05QZCtTQ2U1?=
 =?utf-8?B?SVNpTmJWdjhkdVVlTHdFL2ZTamRXbGh1UjhxR0srRXlzVlJoRHNLVEVrY1FM?=
 =?utf-8?B?TnpYWU9qbUhEeTBqdFAwY3VWN3JhdXp3OXZ4ZGx6a0hKc1gzcGVPN3Nxa2kr?=
 =?utf-8?B?dUY0Z1pNY083Mm5lV1VnWGJUZ1B0eTl0L1Q4Njlyb0FRWnBmUkIvSldwTll1?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cc7269-d936-4061-ce54-08daee74d18a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:57:52.6435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxzwBYkf+rU642a8EQpJFLwiLms3g2Z4ojB4E+UBIjtr7YWEN+2BVxsXiYvB7BHz9RsANA91M+14Dy4NwUv73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5517

From: Jan Kiszka <jan.kiszka@siemens.com>

Now that we are running both pipelines on the same server, we can also
make use of native gitlab-ci trigger mechanism. This both obsoletes the
need to configure a token and avoids starting a real job on a real
runner, just for calling curl.

This also improves the visualization of the two related pipelines in the
gitlab UI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4d207dbd61..620f8c54bc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -257,11 +257,9 @@ i386-userland:
 
 trigger-xenomai-images:
   stage: test
-  image: curlimages/curl
-  script:
-    - curl -X POST -F "token=${XENOMAI_IMAGES_TOKEN}"
-           -F "ref=${XENOMAI_IMAGES_BRANCH}"
-           -F "variables[ONLY_RUN]=${CI_COMMIT_BRANCH}"
-           https://source.denx.de/api/v4/projects/479/trigger/pipeline
+  variables:
+    ONLY_RUN: ${CI_COMMIT_BRANCH}
+  trigger:
+    project: xenomai/xenomai-images
   rules:
-    - if: '$XENOMAI_IMAGES_TOKEN != "" && ($CI_COMMIT_BRANCH == "next" || $CI_COMMIT_BRANCH =~ /stable\/.*/)'
+    - if: '$CI_COMMIT_BRANCH == "next" || $CI_COMMIT_BRANCH =~ /stable\/.*/'
-- 
2.35.3
