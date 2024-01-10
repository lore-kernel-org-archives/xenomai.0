Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970E4CE05
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Vwz/U9Bk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNbJ40eWiBXiyRqNZAD3Fxbl8umW2Y7L+7HaJY1fnCKze/SnwKbEwZuMAh5tUe02loVc9LsrrR/ItnW1QsH3lovY/kYY5LwcJ1eFtDceRBQ4oa1Efv5xEjWAJnOHFuQTMVSeEh5noA52t+Mai5BNDpayS3WC62VzAGyG19PpNKQ3zmXGqFKYIgrD4NaXSQXSDZJnkladiEqQxIgcaSEFESmfNjkB1v/JuCAZdX3MMJHT91cIP2jGu7LVb1wlmcMZVsQDudxF03xdA0Fo16k07iSOlZPCCtYCgG7s9T6a9tQcGJSQ424I+4dFlTcq+tHhdpkVHG4bbby+KIepsO2ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPHBa6NVQ1ls5XfElCJYH1zGet3tFdku3DpGImaJHXQ=;
 b=hXE6Mk/ZI1vRjkPdJp3y6kTtNPIQEuW9b+lWdrc7dzRjhJOX4UNYkM8YDzTSf7Fp359cDDRa7txGn2ON57cWz7H/e+pe0knKI0ZJ+scvgUY3dtMOx7Uh3G9zNwSl9xrO7R7qxO1NsuA77p+TE5sBqHB++sfhyXae1A8HterqyMvdw5La+aeHBGF9RcBj0kcGgFJ3r+lwefWksZwlhGEW9ZtqEKRscPUORW35E7DFxTRroWyn1QRoQOakG2AAN4HBIrnpV9z92i0PLFpaS4ZPxUcWmCpe+DvoMn4kT6j8q78I2Aj0vRhg0Pd0rL7moeUYkZgXFyhVN3cZrNrBjsgi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPHBa6NVQ1ls5XfElCJYH1zGet3tFdku3DpGImaJHXQ=;
 b=Vwz/U9BklsnVOEC+Fq6wGg6ccXgpzedErI4/QTevvdMgfSdbEajJS7Opi4yD+vXWlaqDxLYozlQwNemIvs3V7bke1rj4KVoYrfBedWNct4CWPYkM0unQIZ0rPMBC3anEWtlcktzMp6wg7eG13bohwjyzTRbmvTDjm8wwGHDb2/01fKclgdoeeallO3O/uZgOugiKXjn/hqGzd7xQ0M0ejeio5L2e9cs1hFcd3U6Rwpiw2VWMj7yfgH22yApEtO8maqQqulQid6By12ezd0DrBLbvoMJaI0PJsXCNDXUqSPNPvdXScNuMlV6D7Xv5gxKCQ8JZiqe/njW6ruzx8qf7ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 18:50:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 18:50:03 +0000
Message-ID: <54eff002-bf44-4987-bab5-aa35edc0cf60@siemens.com>
Date: Wed, 10 Jan 2024 19:50:01 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] ci: Introduce download cache
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bb02c0-d31d-4fda-876a-08dc120cf488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7y8hJMb7jyP/dP53mm8L/RS8WkKNPjjdV1VG2ixScfj0iFIV+CdpLsCSalebUqERmT8+PACPcvRpCCimQUU5/MRXBC/4Fq9qB5JoQ1hMTe9JOwAjQS7bUprCsRu3MZDAqKDrmCDwGgS/vwOSjx5mWY8IdOmU2UghO3M5Oz1tO/I0hPLXwg7D4rCa5Xravq9UOrqzEpBg8JwUZiZQk0zXcJuCxUYA9K0m0WynGksIiSXv2sCV4kvhB8fplmrZHGIjpD9bNoHWDJy7xEWEOgEXS21Q5PBpMTAlsA260IoAKK5r7618MjAO04znO0G6Skbx+c5DhDsV95I/PaXy66bxdanEMWlf8BwMPKYFyBqT5XF6cWDJxMqOHURmAk7ocpXAqGPyADclW5dJkTsXXsj+5t+Km+Gx/j/Z05YNqig+iyGdjN7346uCPNPuNMaHk5Qz8L3IjeFjUhmFdJqcECZaK5nUKjPgoJN1onqbffH9NrYlGywHQiFDAEcu0dLRLXFn4C3N9/iCJDUl2HeKx8Nfky4MUvyTJoDad/8Cdm1mGboodmRsQY5tQhVerxEB/5VC3DMmr0HFAWiUSNzMOATeqAJ7MP7SUASj/9rmt3x6pFjo3HpqTSFw6kPJAB4Zv27DvvXXQKeSXG9gl6YpefJOfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(31686004)(6486002)(38100700002)(26005)(2616005)(41300700001)(6506007)(478600001)(8936002)(8676002)(82960400001)(6512007)(66556008)(66476007)(66946007)(6916009)(316002)(44832011)(5660300002)(30864003)(2906002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmZRY1VTa3AyMEQxcGdJQXpZN29TTHZxYXdtMnh2cmY3YVNwYlRmTjJCdU5R?=
 =?utf-8?B?WjMvdVF3K2FKVkxITXFrOHNjS0x5UXA3TGNXRVRkOXJ6UWZjM3U4UGJnT3ZK?=
 =?utf-8?B?QkpFUjN5WGRCUW16eEFPOTZYNmE4NTJXTU9FVHlUbVB4R092czh3VmNEVlVQ?=
 =?utf-8?B?ODdyOVFRQW1GbDNRY01yMVBROEhZa1MzdnJNeXc3VEx4TjRBQk9NY1BqZCtV?=
 =?utf-8?B?RGZQcnhUZmYvbjZGcnJaNUdsb0NlMnpOb05nUlRidWEzSXhwUEYzS3ptTTd3?=
 =?utf-8?B?azN0WTVDRmlZMDZobm51eUJBT2xuQ1B6RXVBWUNZYkhaSm0vRVcxSUVjdDdF?=
 =?utf-8?B?UXUxTVMzaHVEWlVaSy8rZ1FseExLU3U1YUNndHBtUUduM0trUW9JZFVxNEdB?=
 =?utf-8?B?eElseThQM2pwbmViUDFMeENrSkhaVXk2U0lTZ29LY2RlSndDVjlpdGFHMDZs?=
 =?utf-8?B?cEo5QVJkR0VvWTZ6T2wrUkdsTU1zZEVONU9LbU5PSm1maDBnQUVOVXlwNTRy?=
 =?utf-8?B?RWxPSmlQeEFld2duZDhTQk5lckJ1TnlqbXVIU2d1RWxLNHIrNm53c0xic0Qy?=
 =?utf-8?B?QTZEUndrRFJKd2pObm1yOEtnaEtqeU1tdFBCc2FWMFpVRG9SaHZuZkdFaG5E?=
 =?utf-8?B?Sk5aVFdaTXliT0R0V3VZUXZZR1R1NkRpcGU4Z1EyTlZldFp5MmMvZTV5NE53?=
 =?utf-8?B?aVFSY3Jic2NSbEdHcCtaM1hZK0ROak1lNnpFVDZ4dENBbjdud1lNZXAvRVJM?=
 =?utf-8?B?QlRrUmEyamY0T1dPc1BTM0pZT0F3RjZkVHlBNERLbEZVak5RQVZMd01Qb2M0?=
 =?utf-8?B?OTZXUXZraUZxd1B0RUZyeUZ6Q2NDL2I3aFBVK1FRRGNmQjBoSzlUNXJiOE02?=
 =?utf-8?B?L1NTN3cxSldnMG9WR2tGbG41NSt5bHhTT2tEcVRNSFl2NURtTzIyQnY1aHZn?=
 =?utf-8?B?RFZlelhJNHNkS0k2czVYeVpvQm4yNXgwZUJjSml3eHVldVhrRVF2b2ZRNUp3?=
 =?utf-8?B?VkQ1c1pPUXJGUTdWZnlVWU11QjByY3ZYU2pNZTB3a0FLMUE2SXpneUlSMm9R?=
 =?utf-8?B?djlhK0VEcGZOZWlVeGhVSHcwTFZ5VUpSc3hmN0E3VTY0VmwyQlYrZHRpVllx?=
 =?utf-8?B?RlB6eVppaVhuUjlrTkZWSWk3RTd6b05mZTNYTWh2Z2oyN0NHSGU1eTErWTlV?=
 =?utf-8?B?blBjcnNVYnc4SndPRlhDWmNXWjB5M0c1MXpzaER0TlRyREhQU0tOcDlqTTEw?=
 =?utf-8?B?ek9vZktOTE1Qbjkyd2o2NjFuWDA1cjBMSXNKdnJQQjY5Z2kwYTg2d04wa3RX?=
 =?utf-8?B?cm5LRnV5QTNxMDc3cDhPRlozOGE1MVJrOWZGTnpobGNUSFdIbU9EVFBEMU0z?=
 =?utf-8?B?bk5YOTlheXlLcHg3MmZHUm4vc0lVeGo3cDVibU9UNlZRVHdrUCt6dXJGelpx?=
 =?utf-8?B?MjB2U0d2cGFCVDRXVXZxc2Z2aWZGb0pkUCtXc2UrZkV6WXVpZE8vOW9zL3VQ?=
 =?utf-8?B?Q2FvYS9OKzhHN085OUZvZmswL3ZlRDZ5WThCRzBtNFdZWjd5NjUxMVpGVUpj?=
 =?utf-8?B?UmVURjVIRDZXdUdydlF5bjBlT0pJWWRtZmYvSGJ5VE1Ga2N6OHRMVGxvRzdV?=
 =?utf-8?B?SDhaYnllelYrMkRGeWJzbERrZ1B5bmFyQkRDUWw3T3RSQnB4ZUg0TmF5S1NS?=
 =?utf-8?B?TS9abzBnZUhrSzVic2t0YUtGVzZPNW5qZ1ZWUzN0YUpTTHpMMURZRE1TRE9M?=
 =?utf-8?B?SGJoT2gyMmc5c0tEblFIa3JONUFLa1pUZmVYQUREZk9kYjY1MjZyZXJadFRm?=
 =?utf-8?B?K3U3Mm85NFgvTE9XZzZOMXNFdDlLZTdCdDQ4NmozbWRvcnFHaVpFd3psbkc5?=
 =?utf-8?B?akRUM0kzNzBmSXVtQzV3ZVVuMS9rbGdNc3VXWm8zSGpjMmsvbFVEemRwNFE0?=
 =?utf-8?B?b2tuSDZkMUV0UVN3THdUaVdiWFJOQjNUSHV2UVZVNWh3WWsrU1kxZGdVMUpJ?=
 =?utf-8?B?VS9MUksvbUFVQnNDemtyZTBXQ09RL0Y1U3NQcGdrOHdGQUFReW8xWFNua09i?=
 =?utf-8?B?Y2JFdTRxVGhhbHNqSStDSkg4dC80Rm9lNm8ya0EwcFlwY3I0RWJJNGZxREto?=
 =?utf-8?B?cEl1TlJ4c2ROSEZkNjA4ekVPaXhhdWNrNE9CRFI0c09xTmlReWt3ZXc0dzVG?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bb02c0-d31d-4fda-876a-08dc120cf488
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 18:50:03.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj0FC9gxgJNCsg0W+cCVQIld8wRKmdCp+F0tbgcyPVLA/UVuiydRsNqUOZzDglI81sHMU5XQMR5UHID2llPYDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7691

From: Jan Kiszka <jan.kiszka@siemens.com>

Sharing needs some tuning because some jobs would otherwise kick out
non-common artifacts of others when uploading their caches. Introduce
appropriate keys to make sure that Debian architecture and kernel tree
as in line.

Still, this may need some regular maintenance later on, so also add size
statistics after each build and keep an eye on it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml | 11 +++++++++++
 ci/kernel_4_19.yml    |  6 ++++++
 ci/kernel_5_10.yml    |  6 ++++++
 ci/kernel_5_15.yml    |  6 ++++++
 ci/kernel_5_4.yml     |  6 ++++++
 ci/kernel_6_1.yml     |  6 ++++++
 ci/kernel_6_6.yml     |  6 ++++++
 ci/xenomai_3_0_x.yml  |  1 +
 ci/xenomai_4_next.yml |  1 +
 9 files changed, 49 insertions(+)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 8f36ece..c7a1571 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -42,7 +42,12 @@ default:
   script:
     - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
+    - du -sh build/downloads/deb build/downloads/git build/downloads
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
+  cache:
+    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
+    paths:
+      - build/downloads
 
 .build-qemu:
   extends: .build
@@ -79,6 +84,7 @@ default:
   extends: .build-qemu
   variables:
     TARGET: qemu-amd64
+    CACHE_ARCH: amd64
 
 .lava-test:qemu-amd64:
   extends: .test-qemu
@@ -89,6 +95,7 @@ default:
   extends: .build-qemu
   variables:
     TARGET: qemu-armhf
+    CACHE_ARCH: armhf
 
 .lava-test:qemu-armhf:
   extends: .test-qemu
@@ -99,6 +106,7 @@ default:
   extends: .build-qemu
   variables:
     TARGET: qemu-arm64
+    CACHE_ARCH: arm64
 
 .lava-test:qemu-arm64:
   extends: .test-qemu
@@ -109,6 +117,7 @@ default:
   extends: .build
   variables:
     TARGET: hikey
+    CACHE_ARCH: arm64
 
 .lava-test:hikey:
   extends: .test
@@ -120,6 +129,7 @@ default:
   extends: .build
   variables:
     TARGET: beagle-bone-black
+    CACHE_ARCH: armhf
 
 .lava-test:beagle-bone-black:
   extends: .test
@@ -131,6 +141,7 @@ default:
   extends: .build
   variables:
     TARGET: x86-64-efi
+    CACHE_ARCH: amd64
 
 .lava-test:x86-64-efi:
   extends: .test
diff --git a/ci/kernel_4_19.yml b/ci/kernel_4_19.yml
index c55b26a..98ecedf 100644
--- a/ci/kernel_4_19.yml
+++ b/ci/kernel_4_19.yml
@@ -14,6 +14,7 @@ build-4.19:qemu-amd64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     KERNEL_VERSION: "4.19"
+    CACHE_KERNEL: ipipe-x86
 
 lava-test-4.19:qemu-amd64:
   needs: [ "build-4.19:qemu-amd64" ]
@@ -26,6 +27,7 @@ build-4.19:qemu-armhf:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     KERNEL_VERSION: "4.19"
+    CACHE_KERNEL: ipipe-arm
 
 lava-test-4.19:qemu-armhf:
   needs: [ "build-4.19:qemu-armhf" ]
@@ -38,6 +40,7 @@ build-4.19:qemu-arm64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     KERNEL_VERSION: "4.19"
+    CACHE_KERNEL: ipipe-arm64
 
 lava-test-4.19:qemu-arm64:
   needs: [ "build-4.19:qemu-arm64" ]
@@ -50,6 +53,7 @@ build-4.19:hikey:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     KERNEL_VERSION: "4.19"
+    CACHE_KERNEL: ipipe-arm64
 
 lava-test-4.19:hikey:
   needs: [ "build-4.19:hikey" ]
@@ -62,6 +66,7 @@ build-4.19:beagle-bone-black:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     KERNEL_VERSION: "4.19"
+    CACHE_KERNEL: ipipe-arm
 
 lava-test-4.19:beagle-bone-black:
   needs: [ "build-4.19:beagle-bone-black" ]
@@ -74,6 +79,7 @@ build-4.19:x86-64-efi:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-4.19.yml"
     KERNEL_VERSION: "4.19"
+    CACHE_KERNEL: ipipe-x86
 
 lava-test-4.19:x86-64-efi:
   needs: [ "build-4.19:x86-64-efi" ]
diff --git a/ci/kernel_5_10.yml b/ci/kernel_5_10.yml
index 1c30617..44cd6d6 100644
--- a/ci/kernel_5_10.yml
+++ b/ci/kernel_5_10.yml
@@ -14,6 +14,7 @@ build-5.10:qemu-amd64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
     KERNEL_VERSION: "5.10"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.10:qemu-amd64:
   needs: [ "build-5.10:qemu-amd64" ]
@@ -26,6 +27,7 @@ build-5.10:qemu-armhf:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
     KERNEL_VERSION: "5.10"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.10:qemu-armhf:
   needs: [ "build-5.10:qemu-armhf" ]
@@ -38,6 +40,7 @@ build-5.10:qemu-arm64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
     KERNEL_VERSION: "5.10"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.10:qemu-arm64:
   needs: [ "build-5.10:qemu-arm64" ]
@@ -50,6 +53,7 @@ build-5.10:hikey:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
     KERNEL_VERSION: "5.10"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.10:hikey:
   needs: [ "build-5.10:hikey" ]
@@ -62,6 +66,7 @@ build-5.10:beagle-bone-black:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
     KERNEL_VERSION: "5.10"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.10:beagle-bone-black:
   needs: [ "build-5.10:beagle-bone-black" ]
@@ -74,6 +79,7 @@ build-5.10:x86-64-efi:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
     KERNEL_VERSION: "5.10"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.10:x86-64-efi:
   needs: [ "build-5.10:x86-64-efi" ]
diff --git a/ci/kernel_5_15.yml b/ci/kernel_5_15.yml
index f8c3e4b..52710fd 100644
--- a/ci/kernel_5_15.yml
+++ b/ci/kernel_5_15.yml
@@ -14,6 +14,7 @@ build-5.15:qemu-amd64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
     KERNEL_VERSION: "5.15"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.15:qemu-amd64:
   needs: [ "build-5.15:qemu-amd64" ]
@@ -26,6 +27,7 @@ build-5.15:qemu-armhf:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
     KERNEL_VERSION: "5.15"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.15:qemu-armhf:
   needs: [ "build-5.15:qemu-armhf" ]
@@ -38,6 +40,7 @@ build-5.15:qemu-arm64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
     KERNEL_VERSION: "5.15"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.15:qemu-arm64:
   needs: [ "build-5.15:qemu-arm64" ]
@@ -50,6 +53,7 @@ build-5.15:hikey:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
     KERNEL_VERSION: "5.15"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.15:hikey:
   needs: [ "build-5.15:hikey" ]
@@ -62,6 +66,7 @@ build-5.15:beagle-bone-black:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
     KERNEL_VERSION: "5.15"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.15:beagle-bone-black:
   needs: [ "build-5.15:beagle-bone-black" ]
@@ -74,6 +79,7 @@ build-5.15:x86-64-efi:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
     KERNEL_VERSION: "5.15"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.15:x86-64-efi:
   needs: [ "build-5.15:x86-64-efi" ]
diff --git a/ci/kernel_5_4.yml b/ci/kernel_5_4.yml
index f80b653..4727178 100644
--- a/ci/kernel_5_4.yml
+++ b/ci/kernel_5_4.yml
@@ -14,6 +14,7 @@ build-5.4:qemu-amd64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     KERNEL_VERSION: "5.4"
+    CACHE_KERNEL: ipipe-x86
 
 lava-test-5.4:qemu-amd64:
   needs: [ "build-5.4:qemu-amd64" ]
@@ -26,6 +27,7 @@ build-5.4:qemu-armhf:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     KERNEL_VERSION: "5.4"
+    CACHE_KERNEL: ipipe-arm
 
 lava-test-5.4:qemu-armhf:
   needs: [ "build-5.4:qemu-armhf" ]
@@ -38,6 +40,7 @@ build-5.4:qemu-arm64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     KERNEL_VERSION: "5.4"
+    CACHE_KERNEL: ipipe-arm64
 
 lava-test-5.4:qemu-arm64:
   needs: [ "build-5.4:qemu-arm64" ]
@@ -50,6 +53,7 @@ build-5.4:hikey:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     KERNEL_VERSION: "5.4"
+    CACHE_KERNEL: ipipe-arm64
 
 lava-test-5.4:hikey:
   needs: [ "build-5.4:hikey" ]
@@ -62,6 +66,7 @@ build-5.4:beagle-bone-black:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     KERNEL_VERSION: "5.4"
+    CACHE_KERNEL: ipipe-arm
 
 lava-test-5.4:beagle-bone-black:
   needs: [ "build-5.4:beagle-bone-black" ]
@@ -74,6 +79,7 @@ build-5.4:x86-64-efi:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.4.yml"
     KERNEL_VERSION: "5.4"
+    CACHE_KERNEL: ipipe-x86
 
 lava-test-5.4:x86-64-efi:
   needs: [ "build-5.4:x86-64-efi" ]
diff --git a/ci/kernel_6_1.yml b/ci/kernel_6_1.yml
index 233b64e..1c6a6d7 100644
--- a/ci/kernel_6_1.yml
+++ b/ci/kernel_6_1.yml
@@ -14,6 +14,7 @@ build-6.1:qemu-amd64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
     KERNEL_VERSION: "6.1"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.1:qemu-amd64:
   needs: [ "build-6.1:qemu-amd64" ]
@@ -26,6 +27,7 @@ build-6.1:qemu-armhf:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
     KERNEL_VERSION: "6.1"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.1:qemu-armhf:
   needs: [ "build-6.1:qemu-armhf" ]
@@ -38,6 +40,7 @@ build-6.1:qemu-arm64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
     KERNEL_VERSION: "6.1"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.1:qemu-arm64:
   needs: [ "build-6.1:qemu-arm64" ]
@@ -50,6 +53,7 @@ build-6.1:hikey:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
     KERNEL_VERSION: "6.1"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.1:hikey:
   needs: [ "build-6.1:hikey" ]
@@ -62,6 +66,7 @@ build-6.1:beagle-bone-black:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
     KERNEL_VERSION: "6.1"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.1:beagle-bone-black:
   needs: [ "build-6.1:beagle-bone-black" ]
@@ -74,6 +79,7 @@ build-6.1:x86-64-efi:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
     KERNEL_VERSION: "6.1"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.1:x86-64-efi:
   needs: [ "build-6.1:x86-64-efi" ]
diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
index 74b3410..f13d28d 100644
--- a/ci/kernel_6_6.yml
+++ b/ci/kernel_6_6.yml
@@ -14,6 +14,7 @@ build-6.6:qemu-amd64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
     KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.6:qemu-amd64:
   needs: [ "build-6.6:qemu-amd64" ]
@@ -26,6 +27,7 @@ build-6.6:qemu-armhf:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
     KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.6:qemu-armhf:
   needs: [ "build-6.6:qemu-armhf" ]
@@ -38,6 +40,7 @@ build-6.6:qemu-arm64:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
     KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.6:qemu-arm64:
   needs: [ "build-6.6:qemu-arm64" ]
@@ -50,6 +53,7 @@ build-6.6:hikey:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
     KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.6:hikey:
   needs: [ "build-6.6:hikey" ]
@@ -62,6 +66,7 @@ build-6.6:beagle-bone-black:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
     KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.6:beagle-bone-black:
   needs: [ "build-6.6:beagle-bone-black" ]
@@ -74,6 +79,7 @@ build-6.6:x86-64-efi:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
     KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
 
 lava-test-6.6:x86-64-efi:
   needs: [ "build-6.6:x86-64-efi" ]
diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
index 5d3ddee..0212414 100644
--- a/ci/xenomai_3_0_x.yml
+++ b/ci/xenomai_3_0_x.yml
@@ -17,6 +17,7 @@ variables:
   LINUX_BUILD_OPTION: ":opt-linux-latest-4.4.yml"
   XENOMAI_VERSION: "3.0.x"
   KERNEL_VERSION: "4.4"
+  CACHE_KERNEL: ipipe
 
 build-4.4:beagle-bone-black:
   extends: .build:beagle-bone-black
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 226c72f..4df6699 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -19,3 +19,4 @@ variables:
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.6"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
+  CACHE_KERNEL: evl
-- 
2.35.3
