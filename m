Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF1429838
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999295; cv=fail; b=R757BVItXEEwfatiDKqEGcjWHWPDlVmAiunBRy79M0RH2mrgIRPDBn2LqIPAX7dwJpZ6g54FFtUn+izBSkbAei5jovR7bgCPstB9Lc6PYqCDhrfgsRDCGSQSeJ2lW+6xKomJOXQnM6HEa9b3TbSRyo0F5RWMEihr55hI7M+USZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999295; c=relaxed/simple;
	bh=fSk+dNPPE1Ew3LlLJ0jeWYXelc/ICgw/iUtUTgxCj+Q=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=eqGWEx6z3RH02sfxLdyrGGs6Ekg6gZruKNhw2GlrguXsaY0IzIq0uSx9klQIaUhj5iJ3NGtWJGcY2/2BlURULkCasfTzjFu+lEVcv106udoLC9o2mjR0swclCymvdXCpybWxVtLxwnvQFa+NKiSg+qqSlt7w9Fg2xT11bjAS6jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eChuh1x/; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eChuh1x/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ibm1QLeqtQLIgMOxFd9FA2ovSeAgr67luK0kqc0VWztwC32ShS8sHlBBha/9jYcti/yQcH5CJL/E7vB9bmtWTVO4j5d+ozchgi0YKCE4i1ower1myhHwc8bjJFrit46pWMXV++8tl3Ib3/DMMbGF22MVirGIoALCUP3CbUllfG2HIdvGB5hs5O5SV8uKoq5xy2V3R57tJzG/YY8TCAQpDGeSYo6zRnNrmYlUbdwZGHuEQYl4rZceDaL0fdNpp6TukvbI7p84/DItvmpxul8E2bXuxBWdygtV5yoxOmJw7Gli18cfx5boL5Hy5OzryqtPfj30b3K3m3hQExZ/B0/gUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymuz3aauxfKr2TpmOA8iwxdTk/xRlLXfzzRQMoxccp8=;
 b=pX26GR1s7gXQ20Ba7FdX9f3m4J9yQrIZIrNQj01/5vxoacbKow9uREnj9IMQNFKYsiAM2SXYCu9MOSgMvn/ujhdllscLhJz0MEq82Uek33pvBbPAliRcp9HCGZ8DyUER0G8JNpVMH1f19VWTTdMW9BeeliasEpwdi5GpjwyeBVl6m1KLrUbixHIDQdTnAI3jj2QQjJfToCq5gFSzvFyd9qHxlDM5OoYXvYpljHXV2KTRD4aQYD+XKspRQjhCOBh5AV7m09I9dh7az/xdxCVC+fpl37QFUHkiuWz/4dp+LKVGldVA42mOGc21aTr0uHWM7950cj1lGVAEsxxo4ff9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymuz3aauxfKr2TpmOA8iwxdTk/xRlLXfzzRQMoxccp8=;
 b=eChuh1x/iHZ6UWiEyzdXo+KF3j42JrVscUr4V6JQ7ahnYtosU32duXeI2oeRGkpFaMG/iFnrI3HvnFMSGM+0XauZguM+j4KUOAdo1k7J103dp2qiFI3e5xTwvEFF49jQR1i7an/0UErg9nNuG07UzjHYDM2ToW/NjwXbW7FCxboPv3AvLvJZTR79chT+8oWS/W7T+KnS6+9I4Aja/9q0RbTLUsaCczEcuztpdhOYVrhux9VVZbMOz5XUKcBFVlXvHR/XU6qui3S4+Ge25vDx8ldXP0+YpD+PXmaYXHic5hxvEFU7a///Zw43MsL4WXZBkmEhwic2+ZThcCAP0b61DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:41:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:41:30 +0000
Message-ID: <57121d8e-9b1a-4536-b908-69d37b8aca89@siemens.com>
Date: Tue, 5 May 2026 18:41:29 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update kas to 5.2
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3938:EE_
X-MS-Office365-Filtering-Correlation-Id: dddfe406-cb1a-4665-4a15-08deaac528b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	/JFusmBwkekh+cZd1jBBK7A38wYw6WwjhDhBWqB6yzFW+JCbHRdBe2axRAPx0iXeOht5PgAh6OzLxRT+2miXnNkG04nJPzZe43XoqZsTKWpwq1SXBvJGJLdHdfVi2SlpgAnveB590o7cv4enzIFwzJLKRP+fkyxWHWDPtJ8ukNbZU+zqkCJcQ1Mx7dh7NmFw4a1M+g4MaviOdnUh0lj18jkqjrtWRhye66vy8Pxjns7P3YmPpjjbKboDyzPlLyUrFI6ZMq1CIPz0jq6NJciHUN2nNwvRHB13Uqqa9PqscxXApiHzU66CqvVtjll776Yk4w06wlhvw1YdCe8uuoRF5LMQ/57xVqfcXICn1m2G5fvyXEvTCZ5uKnaKX0fUm0x8WAkvLEBXhDw3eAmcGat8GosCvBFEPmLb/GhBuGZec46rsv080hNFtBPJSHiJhHjPOeEtztB4jauAKxPgcMiH2G8wJfvRokOYn1gcsig1KHyhHjmOAPR93bT+qQ7HnfMtGV0zP66bOvjtk0NTbsK2gmm/D5qvVgn4SRX2t2MCtaI4gmSCa0wKYSqPWMlVSAFoOPv84vOPWQA3iv1AbX49eAgVP8IVPqZIr2wFXcQs45Po6tlACfS6VzJO+YZpzC6LJKv7wsSfKaFDNvni9oXMRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHpQMzdWTGM4TGhWOEpGT3ZuNWVraXRJeURiUlBwQnJTeDNSY0NjUDJHRGxO?=
 =?utf-8?B?YmRrcHdrc25vRytQTzJlZnRBejN0cFpJSmtKV2JUUXZVRXpCaU9mVEx0QUU0?=
 =?utf-8?B?Q1Q1R2ltUkhpNENJSVB3VnR3aFVVZjNNZjEyVEFDdnhqMGZ2MENveDhyNzJ2?=
 =?utf-8?B?R2hWemhMT3hXT0g1dmN3VjU4bWc4cHB2MU5KOG9FRGU0a25vb0dyUmtPZFNq?=
 =?utf-8?B?NWwxVHJYYTFrb0FIb0xteEtPL0dELytDazZPRjUvTGRJcUd6Ym5sNHlsZldl?=
 =?utf-8?B?ejgzT0dNbDFGby9OV2hocHZPWXMzNCsrcmRZNld0Tk9JdUdHaE5ka0lKS3Jl?=
 =?utf-8?B?ZGNHL3k1elFwaEh3ODlOMjVBQS9Ua01FTXFSTUNXaC9uenRjVzZGYVpWS3F0?=
 =?utf-8?B?UW9HNmlXZW9Bbk93RXRia00zN1E0dEZLMGJ2ZW83SXZEZGh3SU9USGhYcUVz?=
 =?utf-8?B?U3l1VUZCbjJXcURLQ0dKQzB4b1ZzK2FjeVNLQXgxbU16NnROQXVlbFFBd0ZJ?=
 =?utf-8?B?TUJrODhlMVNFTTJUWTQ2eC9HSTFtRFRTaEZFOHFwbkRlZG1hMHpxR2JPem5w?=
 =?utf-8?B?dERjdGJtK0V4d29TVEhIbktIUXNHT1Z1Ukg5MTVxYVRzd3p0TDJuKzRDM0ky?=
 =?utf-8?B?Z1REVU1oeVJWTmNNNVZkZkZQOUJRK3VVQStpeXR5ejhQVUdjMWZqSHNzRm1s?=
 =?utf-8?B?ODFjZEM2LzlhUUl5RkQ2NytrbUI4K3JHY21IT09ZY0VkUUhZc0VxWFdkT0Ju?=
 =?utf-8?B?Ymlrc1RMVk1tbTNHYW1vMmxrQXp2dW1jS1pUMnp5bTBuS3pabU0xVTJqZ2FN?=
 =?utf-8?B?Z0VXUmptdUNzS3FpMXFYSlZmYy9aYy85TG9KeDZmK0FZUng4TEpEaVRUQjUv?=
 =?utf-8?B?eGhLUmltVGU3eml4NUdHQ1dzWXBtQk1Qek9RVHpLNFVBUWVCT3dFejArMGEw?=
 =?utf-8?B?RjNmTzZoeExZVlBuV2hpK0w3THp1RWQxVTBoWE0rNWRlT2xNaUY1aWJFbVdp?=
 =?utf-8?B?QnZGTjhBMmY3V2hPeHBsU1Z3eVBveFlndTdvYjdrdHdaRjV3MUJzVGdyK09N?=
 =?utf-8?B?V29mOUxiSWRHS0lBUlN3SVgzSDB6MnNieEpHaFJYQk0rdGhJNFVYMGlqRUIw?=
 =?utf-8?B?SHdnT1FwdUtnbjh6em5SQitaT3Ria3BmSHpwUTFTSVhIL3QyTGxBMURHYjB0?=
 =?utf-8?B?REIzTG1KVlByVTk5ZlZHNkxmZnIwOUhlWWNZdGl4djRGcExvbnNWTWREaFVr?=
 =?utf-8?B?c2swV0FyVnFPZk01QjNCeFpxemRjbDN1QlVWN0s2TnRxQWtQRXF4dzNuL0FM?=
 =?utf-8?B?Tmx1Z3A4MXljdmdXVithTjIzNS9yTTAvanNBWEZZaVN2TTJFeVVEZmRpZUFm?=
 =?utf-8?B?WUlYOVhvdjF3UzFKVHdqakJZM1AwY2xwNjVXR2taamFhUWxuaVIxb3JWaTBJ?=
 =?utf-8?B?Y2w0aHdoamtRNGphL1RXd0pUZWVHeVQxcTZjSWJwZ291dEpyN0UvOXhxSGxo?=
 =?utf-8?B?cjZ0NzlqNitkazRRU0NSbWlMdWJQUy9NZnljU2hxRE1EdnhtV3NMdStCNHBj?=
 =?utf-8?B?aDVwY1hITzR4am10SmZOME1TbnBxTG81Z21EVmNpMzlXay9naVRnNHJsbS9T?=
 =?utf-8?B?UDZOVnVUR1BnRXhoQ1lJQXhKclJ1ZDNqdTF2NjhwVTN2UFNoM21IQ0xoTFZB?=
 =?utf-8?B?VEk5NmVDZUx3Rkh0RzdQdjIrVWc5V3ZYb0xnTTBkYmwvWk1RRW45blpoeEQ4?=
 =?utf-8?B?dythenpsMXVPejNHSWc2czRRMWNkQ01QMHRVTXJyQzkxS1FYOWNMZ3ZOYVVB?=
 =?utf-8?B?Nzl4R0hZNzR3bU9XK2ZoemlUU0g5dEMvQ2Qzb1A5YU9zVzkxZ2d2aThGT3lR?=
 =?utf-8?B?cUZJeTk4bXd0SG1FWXpCNWdibWxtZlMzSXhCNkthV0cvNi9EQVdOZFVBdytu?=
 =?utf-8?B?djY2ZldBaVM4dUpzZ0xoUTV3eU5tUy9CTFliQWMzNFNhY1JxL1lLMnlWZWND?=
 =?utf-8?B?OUlrcDhocmh3WjhxUkUreUxGNlR1ckFUOUtKZU9qNityR2cyV3h6ZXNjWDM4?=
 =?utf-8?B?YVVuWVpHeCs1bDBlWVB6ZDVxdkRNT3pLUGhyUFZ4ZFozU09WWXlIQUJ2VEZw?=
 =?utf-8?B?YWNpWndYY3UxRmUrSVlTbmZ1bUxmRkZTOXhnc2NtYXk3OE1PdlplYmx3cmdq?=
 =?utf-8?B?c0swNnF6UWVET1ZWZkJTa3BhV29WRldqSE1NdCsxay9WUlVTNzh3VVZSbTJD?=
 =?utf-8?B?N0xqSmwwdEJNM1F5UGdTamFYMXNrNVVsZzU1NlM2Z3pHOE5TODJ1dUM1OE9D?=
 =?utf-8?B?a2tTRnpWUEdoZm1Kb0ZuWncwSGlZTkREQWdNOGlCY3FWREpBS3ZFZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddfe406-cb1a-4665-4a15-08deaac528b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:41:30.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qySuVe5X9nA5Xm9CxqJTlSJzLVh3XITqbm0xpNVP1GvSz/0EMVFkkZEjAzBdQxN9kZEXoKvNCGiMNM4MBsGc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3938

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop bookworm image pinning.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/lib/gitlab-ci-base.yml | 4 ++--
 kas-container             | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index d815474..1ca59ed 100644
--- a/ci/lib/gitlab-ci-base.yml
+++ b/ci/lib/gitlab-ci-base.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2025
+# Copyright (c) Siemens AG, 2019 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -30,7 +30,7 @@ variables:
   SSTATE_MAX_AGE: 14d
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:5.1-debian-bookworm
+  image: ghcr.io/siemens/kas/kas-isar:5.2
 
 .sstate-prepare:
   script:
diff --git a/kas-container b/kas-container
index b46682e..993f0bb 100755
--- a/kas-container
+++ b/kas-container
@@ -27,9 +27,9 @@
 
 set -e
 
-KAS_CONTAINER_SCRIPT_VERSION="5.1"
+KAS_CONTAINER_SCRIPT_VERSION="5.2"
 KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
-KAS_CONTAINER_IMAGE_DISTRO_DEFAULT="debian-bookworm"
+KAS_CONTAINER_IMAGE_DISTRO_DEFAULT=""
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 KAS_CONTAINER_SELF_NAME="$(basename "$0")"
@@ -80,6 +80,8 @@ usage()
 		    "container.\n"
 	printf "%b" "--ssh-agent\t\tForward ssh-agent socket to the container.\n"
 	printf "%b" "--aws-dir\t\tDirectory containing AWScli configuration.\n"
+	printf "%b" "\t\t\tAvoid \$HOME/.aws unless you fully trust the " \
+		    "container.\n"
 	printf "%b" "--git-credential-store\tFile path to the git credential " \
 		    "store\n"
 	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
-- 
2.47.3
