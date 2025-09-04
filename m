Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F724B28
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975400; cv=fail; b=PfzO7wU5CVQ/7gVYKH5IWbIpSo3fn/w/oB+kXM9UB1spWNPF/7sn4BAhEIsxpPhbzijWEZ9ErQ1O2Vj+6Ag1XgkolVMYjIQBR6msUV5IsrYjyQeuUD1X/BNDR3pT5R+DZuzf0BonwalmG91XV+1+HOhlmtTCrxVCZcs0RRR8eZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975400; c=relaxed/simple;
	bh=Q6FPddDvkpI/3Cfgca2MUwHLrNgT3AmBtWk7YVewSLU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RVe3LjD4Dasz7ZVaBiGqEhxtl+I9yFwEtuC+VGIKDXBPReUYVRnRTLwAB6ClWY+VXjs62WiV1kibL3qfwEFYcYudmlwiXPrkA9sd6/cTmbbqHOIwpJHVLpSCNQ7Ee9ziXPujfspeClO8msycEJrTp+ezwpjIuYefp1AvUW6RsaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sOyaGEY3; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sOyaGEY3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuKRqE607zbDQvCPJ1lS37Av1C6v4YD9bCNHxl8bGf2ltF7piejR7H/R72ErD6OQI7oFXWcucto2vVp9THjh7/QH+PZ6C1Vb+nxTTvwuY+Whd0n3QmGYtw/V3e9ORNhWr8neSFLVQRZMOREf/M6G531ANnlupwoOfWZqg1IkY5V/FF5LrCxffnodq+r6Lsl0FVIuCJht85ntM97la/s+j0uQ6DOd12XNe1+iIvpzx350v4xQsir+CVjKCp+BSXpPww7NopoOicfzp3cYNAte/UWvHKrt/g7z8pO3KHX8mPgNCrGP5lNPnTBrVdJc1LSpC/YzJHvNDW/I7LuzkxUtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=158Yld3AWjig1YehnICcIaEMHR/x0EoRZ8IryNuBfY4=;
 b=Uw/jiSs8wWVIRlD/7hcqHRm980vHzDud+xOfNVjCizpGj2l6q5NA044vyRF0U5+WejiMGzNfK4M6C5cU4Tr0sZ5lXmCbnJXxwNZoCa2n4dSwgm/wB1OM6H10rrg+X7K3HUujt/43LPtfHVNh1Eg+36MRZ4yjh6hjusA2iFaA97kMfzM8yWSL8tSadtZny4swZCFgDhbrBWzhlV77kBzIFxiXTXKYJrV6jN2dof82+n7iljQF1XhMVGvlqu0zof+fo0xQv12Camqkw/6L7LsPRE5D/brSKSg1ghxhIUjpNeg+cv9Jr6UFDFzOZDdjIzQCTVArNjra3N6yXAxhm8mCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=158Yld3AWjig1YehnICcIaEMHR/x0EoRZ8IryNuBfY4=;
 b=sOyaGEY36h4sB86z7XgucTfNAxP6+ETuWSWkwpeXPH0RNqXEYa0QLrVxeJDlrkgY5R02ZkAXNoe5FuNK9dV+MuP610nYz+bm7tUkwJ2kxcQHJEcNmlJbx+Qv6yzbz2u8S47Nam+YNB2fxYTlplolQs6SBBiE0y7smDbZnJmyLlwsfRynA1lxt3LNlDyU7mTVxKk6ernRm/6MBu2FczkLokgV0AzZYthHYs868gFwL12HBjbgPWPWI/fT9tkzkScE/+Q+Lbd02H44otJqJOqFsJj1KpqCxLzq/1rjfGceEmFb2cOsd03Q6bMQJluh1362ORVwmKxS1cMONReSpMInhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS4PR10MB5920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Thu, 4 Sep
 2025 08:43:12 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 08:43:12 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH] ci: Retry LAVA boot action up to three times
Date: Thu,  4 Sep 2025 10:43:07 +0200
Message-ID: <20250904084307.1090704-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS4PR10MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 78da97c8-bd5b-4976-527b-08ddeb8f14f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MyH1JrVeKwBH41JmvkVXDagRynIYC+KLhD+eY9K7AXHc23Ej6O40sZU1HZbR?=
 =?us-ascii?Q?7j8I1I8AgcTG6a+IeaG87qQuCiOJtM7ZNf/MOxfuw69Alou7U0vJSLxnJJl8?=
 =?us-ascii?Q?qS9d0vh3+ffvNRNcVFVh1uTRY2iNZQysbxZ9ClbMKQV7IBLICxYb5/2oMrWQ?=
 =?us-ascii?Q?VEF1eczVt+Ix6WlH/hKwqsDJt9IG5K3mKWpMaRsnNHcJEITrLZU/QzBRL1WB?=
 =?us-ascii?Q?3dJYUWPaUtQFld/zQVijxhtNB5TIIJly0IykLzX0MqrpKvu0lBTbeoD1CNua?=
 =?us-ascii?Q?2pVJQB2Nb+qZSJKkgtrQ3x8ImJCxPz5eYVY9VoNtlitC1jAxJnkH9XIhfb9R?=
 =?us-ascii?Q?PNNLfYI+jF7NKeKRSdPJhGnBTwEaRvZWxL/YyN9/9WPDujtbPOVxO0P7fxPf?=
 =?us-ascii?Q?uQB16XUdiIAzhmVi6i2uxqy70YKiFmk7sGn6lUjN0+WQl7HzC4Foifsff2QL?=
 =?us-ascii?Q?TVj2R2ZLCXkxDhZ30IYgTxovRsAKd7GRTVlf4sn53dyECURoIGIUpjA7BEL8?=
 =?us-ascii?Q?T3yns+/sTEtvVAvFxyLujbMqiuDDlmI6drBIoNIczjwGvOE6KqnI0k35X11l?=
 =?us-ascii?Q?Qehm0+tqGWzMVZk2pLj/5EeCC5oBS/rpNubC/iFn+L+0JcDNPFnBAZAy3vZY?=
 =?us-ascii?Q?p3OoZCJjLLt9aZj3SRiR0S0gXJXY3OHnNKgCl+OaU0wyD9TnB9cOyPJ3xKTU?=
 =?us-ascii?Q?3eCxFKlI6llyA6YcTd7YVXyf1Hoiybpz8nKk+UJqovaioDrKbA+WJxZqkaZR?=
 =?us-ascii?Q?AlIFu9YjspS4SUXMVJqMG1YPdwUFSPS8btKVjx0lFkfMGbSvfQszfesg8NAa?=
 =?us-ascii?Q?ZumA5dCWSSmyuZweBJWrxBnPIzx8dq4zXbCk216Yrk9hKbMaVXhCwegEt8W7?=
 =?us-ascii?Q?IWcSbosk9lzg0w1+OvqiziqoOL0d2KWI/Bu8ra0R96KVwDC6tnY1bHn4CS/f?=
 =?us-ascii?Q?0Kakv1poINHCH2gSJa/EvQI9jn/vRryEREVExc7rPBLcQ87B/YCe2VpZZeni?=
 =?us-ascii?Q?m/weu6PA0jKxjIDslyX5XLoW1dizJhZBB5xFIIfE0fooww0RLguZbuuBf6VM?=
 =?us-ascii?Q?+fJbhX4GK0AS+nKn9jk4m9k/3QQ3ji5VzGlVf4Rvd4d96LnsBiaPyXduzIut?=
 =?us-ascii?Q?qeA7uUwQessKhD1aylbJtC3zuSC8rhmiKtFDm1RS3VIBsuaDAO2FMhlxnsWc?=
 =?us-ascii?Q?Jgf6H03kMw5mCInV2Z1QfPDdNnoUyl7Etl7VH8CeEvwskBrtnhFunqK8jWGn?=
 =?us-ascii?Q?NDcWELRQXM/wK3tQkVbvZXUxE5kUPXiE/RUDh/Vn6iW01qdpcyrhJXcjNCYx?=
 =?us-ascii?Q?gr69RmGe1hYkiLaDq3VgAt5M29R/eWJav4ot6p3HcnQlFzsAebl34oeogxGq?=
 =?us-ascii?Q?eDAuhTJYbKOpH/IyOrvLuBNf2dWmmwCxYkLTYh2P4K/PGuTH0OUS1G/aqPty?=
 =?us-ascii?Q?E+o/MNQwZSY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMP0XgfWPd2VVZ2jPufAKZU4kTqdPmdsClvoBhYB5Y6tuEF1MWtGMUz/9Yw1?=
 =?us-ascii?Q?D+RVebADNRxmuP1yIiy1MYIiDrkkS/j8Jpm9kNfAb1SMpflW7eLqgDXKNplF?=
 =?us-ascii?Q?wR+oTdcMAG9RnGK4Eu8XaEmmBtGLKid+NnI2llouPkX5yS2stuMkceskNmOZ?=
 =?us-ascii?Q?yvdRxctuifOz4goiW0Z0IvD/eoVxYTzf38Yo9SIG5VySF2dxy/JXrJOPBK2z?=
 =?us-ascii?Q?zWsGOjAuxzWIJr0UvALRJ/CABpwVBJgHEeF05ThLdmb0fKJ05BxRg1d2CocC?=
 =?us-ascii?Q?PBbiunOL5vKtxnABr5W6hW6NDCeGew1+NEHg/SQDjYxFQX7dWGIfragS1SvE?=
 =?us-ascii?Q?OGoJd63bo9A9+tTfK5URWUrN2HnBC0ER2AQmVw+2qw9eLLMUZVanTgtqjLDZ?=
 =?us-ascii?Q?o/ltlfOuN8M+6FYE98BFd/0Hh+jGTzMlMUvdUqwk0qnYHXt1N3xmsMcIuGl2?=
 =?us-ascii?Q?Luuk6sAM9DnGD1/yeeHyuQfqVLhR0+8hY4hewy6Z/qWxPX4detxKZyLtRER9?=
 =?us-ascii?Q?j1/Tvqn6TM9GVR4jKj1ZTvQgf7o52mtrnTZElbZG0DYA2bwlSicAyJo8QhLc?=
 =?us-ascii?Q?a0rqvPC4GGLnhS0pGxT/2ph8ppRmbGM6nXXdbJT/4ZNq4YzSWqnt3qw2stz+?=
 =?us-ascii?Q?vGuptHusCZbPl30Beu3YQO0DqoM5zMvEy25rUlZDYHR/dos51g5zVxq/Zk8R?=
 =?us-ascii?Q?8OVHv49NknsFArLVwx0cTLRaZBxmT1D3GDHQKCYkf9Vq4aMz2rspYwVnSH8B?=
 =?us-ascii?Q?ylRpazJB/ndfcA0vJZNYCHRJIxzPmfaG8whHyVQwd+F2XD3dsCT1yzlYUY5I?=
 =?us-ascii?Q?gOEbr/Tn6a6lmK+ySe00+IBmuk1yylsJye1PY1Ul162fDO+Ehzjnjzt3AGzf?=
 =?us-ascii?Q?zQFHciEeFAjEw7Ar2r18WMFSQctw3w2zSBfCUOWI/ICPRXL624CLDBZy+6UC?=
 =?us-ascii?Q?le3mhZ0wH/gGuDHuV34R035vISVZtxYgRuJS5eOOg4mSfouh0P2/o4altHYr?=
 =?us-ascii?Q?g4E1AO9UReBDxZgUjQFMzQ/vsw0PEqgHdqr9S0yweBZdM3piRuY/pDXXvylQ?=
 =?us-ascii?Q?YWiihj7HBChl5oXznbZwika/VQHvL2yfWdey246veuNSqufiJy86e5Ka0ECJ?=
 =?us-ascii?Q?WcTCfnWuYdRQR74+D7QXQvgY8B7o6p2CiX9eYXChirEKHK2XN01M3+LaTiXC?=
 =?us-ascii?Q?zPxwFD1dbmmpNbimqKHE6rLRdAV0I1pqDVKaqv8//sM75wkVVACcrNQY14IH?=
 =?us-ascii?Q?NV2oFT70IcF1hoPR2KHcMpcofGiaAcs/sjxA+RUKc1k3Lmyruu8Q4yB9nEpA?=
 =?us-ascii?Q?VH7GFIAz4sDWM85xJQpPVztD7AQ9VLKQ6p+EoSJgxIGhuRQLdNV7y1cd1Q/h?=
 =?us-ascii?Q?UTUo3SS10waSIdYn0vLuGeCmDAvxDntUE7Px5S9fLAduwzAlHKcJXocdnpMH?=
 =?us-ascii?Q?4Td2Npz5s8pvLLCd898qCj2KWka1JAUM/vvhQ9c8cVPT2tbwDf/617yvwtYn?=
 =?us-ascii?Q?7hXU21pUKbR/3XzlERrCighAEZoOVj4jQNcJ6nrpyhohyYCQrvYwILePYX96?=
 =?us-ascii?Q?+EoRVpWHcMAsrPlRsByEfMKacPLJ2rJQUPSCuj8qrPVJSrpKdnbogHO9YzoU?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78da97c8-bd5b-4976-527b-08ddeb8f14f6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:43:12.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90qmxxfCKcKcm/nZrCVyb6+lBs8+syDRJmbc+O2rXImTBrQWVTaI+vIAZJ53oP582AKvXTVXve+LXZ+XgY57UyPV5PSYzSFHYTQRHMlNB18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5920

Increase test robustness by retrying the LAVA boot action up to three
times on failure. Failures are detected via server-side error message
matching. This logic will be refined in the designated repository.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tests/jobs/xenomai-beagle-bone-black.yml | 1 +
 tests/jobs/xenomai-hikey.yml             | 1 +
 tests/jobs/xenomai-rpi4.yml              | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index 8e47dd6..b7a95bc 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -41,6 +41,7 @@ actions:
       compression: gz
 # BOOT_BLOCK
 - boot:
+    failure_retry: 3
     timeout:
       minutes: 5
     method: u-boot
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index aaf8949..27beb07 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -40,6 +40,7 @@ actions:
       compression: gz
 #  BOOT_BLOCK
 - boot:
+    failure_retry: 3
     timeout:
       minutes: 5
     method: u-boot
diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
index 50ff9ee..4074825 100644
--- a/tests/jobs/xenomai-rpi4.yml
+++ b/tests/jobs/xenomai-rpi4.yml
@@ -40,6 +40,7 @@ actions:
       compression: gz
 #  BOOT_BLOCK
 - boot:
+    failure_retry: 3
     timeout:
       minutes: 5
     method: u-boot
-- 
2.43.0

