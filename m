Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD5432E81
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558455; cv=fail; b=gP9hfu4q2Lpdb7NGjCOUyaErcqvRMC3pciHAB3kbxNPZVcoeU+YN2ewrSpDZaVEoo6+UClgHjIB/FihGqRH49bj3N4RyY40gotg0FYZxzv53Tv7VQwfog6C51DG+vBIcwGXj4Se4SiJ3YxOjYgikg6KlsQgWQTYtWjEn3pxlgT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558455; c=relaxed/simple;
	bh=JZBllUkQFKXvC1Yh3VTO+L0ldOYgGo8IFGnMXhjxVHg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pE5mSTUMet/hCTv1boe+2tSLa+ERnZl26WCXp3PX/Zz0pMtgLkF4CPjYdBTLY4O/fKH4boRoz44oadKeb18Ul1a5elTyXxN3m+nBQI9/1fSSIs/Iz6djvKicBgNorCHoA0okjonPDOcIKov8KXL7AzYF4jdLlnq4bxpOdWMkXhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DGSijhFC; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DGSijhFC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSTrWQLaGb3TlRDpSKJdxlMXd2FTk0BwniT2DDrpn5MVdhb+bouxqoz8awzMPBoGEB3G3OkrQ3ykh5Zy49Rulp9sW9G/1rS6E9RZ3BMvJ/ojnwIn5TtCrlDG+e6Yb7Z6bDIN1qaQnuo+rkZthWmwnwwTvwF+nBMB43pNrLfiSRjYMuNMlhKyFR+uSwTeI8cdktWVqEQpdK5R+vYbMYvbZOszTnA8Y54HC1xXQTk6JF7yIvVM9y0hKF73wNszg68KNrnkiYjQPs9PvmTbj2r+rWZRsZQJDJ2WJ6IB832ovHa2eTGaurX80sxsDm/cZoY6k3Hbg9YzjCZSwWHi5+AwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVbK6aYQFOrgaHCrK5GQKcV0GtIdxFd2y++FsSwx1z0=;
 b=v/nTy/5IV3xn+fsat0kZTLs45CeU9EY47eLg1Ba/HpNG2rjAd6uUfbpq0wW7NTndzjbT94WL0OGPdtv3Nc2/ySal6X8H3IV2UQ5HLd3swU8gOOxvaXl14BCiFWulQSwrgvOrsZjnetCon2WAxXNN3rKLnpYi7nnCm+36A0bEIbBBbh2di+SaM3MDjGls43XqY+3R9/3ekeFKjFA7rC3GHk5U+OR79oE1P5mjdHHMuO6yN5RxfgYRjc+oO4WDJ4jRF+TmHS1zmq4aaF4wNWBobeWvR8YYEER3YX6vW4A78pCfTdU9Tm3WfZqIxrJMR+8qz9Th5/TSVHy3D+YMwkN03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVbK6aYQFOrgaHCrK5GQKcV0GtIdxFd2y++FsSwx1z0=;
 b=DGSijhFCdaLUx4IN9uF2KXmn175AHbAqknW6NU/tL7BBrssmdpU1pr+wE6QdkAoWvVkGDM2644h/9GSYALV8Q5Xnqv7yzhjFDn2lFD0BT1HRGBgLC+W59/U/gv+tfS7Ef8+FqLdVEBvLSQCJZMCpPnruQoP8nGrjkzymr7BGGfzhluLwYwEyTKS6YCoIbJjGRCGtPM2EYeahHB5HKRUV+R1e+KxLksc+Cn8Xix8j2KaidIiPbAeats6EKHul+c19GfNAWaiOG8qU6qe+f7J0C1fx7qprhJU4E1QJRwSY6uw+009r4ZV+6tioca1sA0Wo9aSBeN4gYOK+jbDRULRQWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PRAPR10MB5201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:278::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:40:50 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 14:40:49 +0000
Message-ID: <c7f52464-e9bc-4824-9cb2-bd5d0260f0da@siemens.com>
Date: Mon, 20 Jul 2026 16:40:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add support for gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0415.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PRAPR10MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: f10e31fe-ba3d-4312-aad7-08dee66ce413
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|55112099003|18002099003|3023799007|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ssfn5OtckWjNZLrGhrHUlGszux3g57bJaq0FAiWPDyfpyUaNGWGV+XCkNZQutfhVQNWHeeeRX0fhh99L1GQP5A4tIaZFoAkXuEaHtYZwBSa0/e4LWWM7owSWoSJMSaoHEOZH+Q8kZ10TeOSuMJ2EJJZXvdo34WM7w8Mgzkll5SEc8X5bQK5G+ReIX3bz6sohSSGTcdl2C+K27TFzKYzn8+oxjjW2xIyxoegHIAzYjQp3r3JOG1tPNKBcdItzdRlz0G7V3d6ugQDKhTqTzcq/xRzhS2P/LkGM+xulq7VPR/yUhnNRezNqXzjJDL2zXzdZMzS4cWrudxmqmzeJAhEzdi8VXgpGsh3WCW/0bkpJwM58whLblXX0AgMNLrWNAI7BGnUgC1Ro9aGvnn0bJnLQ4tb/sva9Tz0qIj7d1UbyXXUKWZ3f1HpUyLFtprfP4zk8r87vacTLQF/6qtn/gEnrgRs+LWNyPMktksUfA0VYPSattiqgrjizgesENm4ASnoRqeILkzW3Ml3FEPhNn10mENn4j/FDzDndmVxXn4W83w+DOvh4HTP+6UhEm/iFQtZCk3e1cna9z9NX1LPMiTyHXVz/LFjDGrncTRaRD76VasU0WJZFRZn4IKEWVaf9l+9KDf8i1qSzh+1N0B5sEosqWIeZnirJKPPEUQErEwGBF7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(55112099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU1OR3d0dEhwME9yaFIvUTNNWSs3ckpYRnpXbUJaTlFqZllIZUxnaE5lZFZy?=
 =?utf-8?B?aFJ3MVhVVTNOT0V0RXRRbEtvMHFUNEtPdWNkbWdoaDduZ0h6Q0UrOFB2YmM0?=
 =?utf-8?B?dWpwR1Faak55NmZOeGZZemp0aWJVcm85MVBYR2dQNjNMUGo3Qkk2RS8rNlFK?=
 =?utf-8?B?UlJNaDlsR1l4dFptUDhIV1U0OU4wcGl2YjVZdDcrRjRNTFh2a2hnRWVhMjgz?=
 =?utf-8?B?SDlLZERWRUVrMXA0aDhiS01Ma1VEbHZ5NEtHakZLRkZpa3BtQ0tYYUJaeVZF?=
 =?utf-8?B?TFduWStTUHJ1NmJoMktrWkoyMm1RWHV0c3E5SXpZQ1haazZKWDlwWlcvTTB4?=
 =?utf-8?B?QlZta3ZWd0VnQ2RsMTBONW1CTjNNcTAwYTBOb3cxdEFMVUNDZ3V0TjQ4Wm5V?=
 =?utf-8?B?ZjZ6d1RLcHp6YnVHNmQ1R3NNenBHVWlkOWs1eVJjRG4xd0YveUx4MUJXMkow?=
 =?utf-8?B?ZFB1UjBGL0hnTzRlQzFZWUgyZit3OUtmWWQvbHFzNzNCaUZ2WjBWdmFrbkZZ?=
 =?utf-8?B?Zk0vZGJVcW9OV1BDeXJCZzR2ek1idUgvcTZuWXdhcGdnNFVSekJXSGpHb0RP?=
 =?utf-8?B?bHRnbVM0TWJsbmJLTmY4V0l4VnJMcVpUZGpSOU92QzdjOFAyY2hzNm1CNDZj?=
 =?utf-8?B?L1B3SUNLSlZEYlBYVjZlR1R0ZHF6eTgvNS9pbDRkbFI1K28zVVNBb1FOSHc2?=
 =?utf-8?B?Snd3WUFDUlRjalR0TEZuYTdzeDg0Mlo2MWl3bGxocmU5OFgxYXhRcGZ1NW9C?=
 =?utf-8?B?UlZjMmg3eXNhaWEraVllRWpFR3ByL1pSajZ1d3lhQVhTUUUyOTAxWVJUZ2xo?=
 =?utf-8?B?dE8za3VRMk1KNzdpT21GOThmeTlHNzFodGM2VUEyTXJ0N3BzaVFiZncwa1hC?=
 =?utf-8?B?Zk55Vm1kVjFFZmRNcHhDeGlDNjZvTzVPTXpBNWNZWTBTYWlJakxOYnMwOE1L?=
 =?utf-8?B?ZGFtejFBM0ZldkRaMlJEMUJiYVJ6OE1oZWxiaEhlSDdIeENtaFN1YllPdVpw?=
 =?utf-8?B?VFE0N3VQelorcjVVNE9MWHhzd1k4Y3VKTFk3YjNRa0hPRVVEY2F2WFJCZjhL?=
 =?utf-8?B?eWdTMGVpZkhiYmVRM0JxZnNMYStOQU44RTBUS0RQTlJkdGlnZnJFTWJsMzZk?=
 =?utf-8?B?K1MrWmFsbHBzS0xzeFA5Rm40akxVZGFiV0oxbTRHQ1picjllT1h3RW5sdkpX?=
 =?utf-8?B?cUNRWGNJc1loc1gzM29iWUJkY2lKWnJwek55SitNU3I1cFJCaVFQbm1rTi9P?=
 =?utf-8?B?Y2t3TGxJYkdHQVhKL2lsQ1lwZ3FlWDdJZmxXVGluN2liZUdQNisyREZFbEF1?=
 =?utf-8?B?d0phVElvM2FoYXJQR1JldkNBelhJOEJVKytvN29pOWVNdzBuYnE3UzVVMTdq?=
 =?utf-8?B?VU5aS3lQcysrVTA0cFlkTXRyd3pJNnJTZUVtTU1LSjlrZ1R1d0Y4am5pTW5P?=
 =?utf-8?B?NXJRdElKMjZzU1pzMXBDeUwvR1FHOWVDaWo4ZEJXZzFScUE3Uk0vMzhITGNU?=
 =?utf-8?B?Y2tsVDdQSGJsaGtyMFRNYmdINW9JOGluZ1hYSVF4ZG9ZS2o0eHF1L1ZycFFU?=
 =?utf-8?B?ZjN0d2xpSjcveGQxWG5TTFEzS1RRU1FPWE5Da1BhdjZSbk1qZE5Fd0ZQR1FW?=
 =?utf-8?B?TjR1MjU3YXQ5SnRreWFreUQwY2VEczd0MDUxNTNydVFrejhOZmFOQkp0WVlF?=
 =?utf-8?B?bDd3RVlYWDQ5eGtMaWh5Y3dzd2paMWgrVWp2UFQxY1o1SUxDeGJ4OWo0a1RJ?=
 =?utf-8?B?M3FvQjdYN3VTTndLd0d5cHpCcnhSOUZLWml0cGR2ZUpRZDZrSy9CSmozV1ly?=
 =?utf-8?B?ZFM2TDlXTTRJUlZmZHZqcmI0UjVxT3lBUENTUTdDdEJHUlFsMWJXV1UreSt5?=
 =?utf-8?B?TkZxaHg5am5YS2drU1o2eVRVTTNiMnZJanVHcW9zQXh0YTRrYk03MDc0MUhI?=
 =?utf-8?B?aXdGdFBHTEJuYnNDbFB2NlJaNWZaa3JQMlhsc010ZjF3V3BYNUFSYUx6L3U1?=
 =?utf-8?B?NW1nUzEvYmJhKzhxdHZhY3c3c1dvb0tpVUw0SW8vYzdCTFJMckZPcDY4U2pJ?=
 =?utf-8?B?T25zVWNiRnA1b05UcWYrM0ptc0lXQ01COElRT0dFQkpoeTdsOEo2KzV2Mytk?=
 =?utf-8?B?TFh5U0d3LzlDTVJ3UWQ2L1V3V1c0VHdiVFRMMmdvbUhSTFh6YmdzSG1YYzV2?=
 =?utf-8?B?NTBqYkRpd0JaandJZDhqdkM3M2J6alhiRTZIemQzbkxPdHVIYld1ZTFzUVBN?=
 =?utf-8?B?M3Q5RmllekZjOXgzNVlBbU5KekhWMG9McTBYbVQxbk9zNVM5YUZKSytkYUJF?=
 =?utf-8?B?Q1lMWU9IbWNMeWJRVG9OSWw4SVFmYlZwYVJ4cGNvTGZ5T0pnbisrZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10e31fe-ba3d-4312-aad7-08dee66ce413
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:40:49.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xlJkJJsrWa49GmYb9gm2meJ55NekYWJ+TAXwHTVgqjO0asReacxjWTHnULxshNakByRLOAioFB391GQ/e5J4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5201

On 17.07.26 09:45, Florian Bezdeka wrote:
> Hi all,
> 
> Trying to compile the codebase with gcc 16 revealed some minor issues /
> compile failures. Fixing them up was quite easy, so here we go.
> 
> gcc 16 is the default compiler on Fefora 44 and available as package
> for Debian 14 (forky).
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Changes in v3:
> - Rebased on current next
> - Patch 4: Enable psos test at smokey level
> - Patch 4: Increase busy waiting interval to 2ms
> - Link to v2: https://lore.kernel.org/r/20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com
> 
> Changes in v2:
>   - Reworked patches 3 and 4, removed / migrated busy loops
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (4):
>       utils/autotune: Fix compile error seen with gcc 16
>       testsuite/smokey/sched-tp: Fix compile error seen with gcc 16
>       testsuite/smokey/vxworktests: Fix compile error seen with gcc 16
>       testsuite/smokey/psostests: Fix compile error seen with gcc 16
> 
>  testsuite/smokey/psostests/psostests.c | 4 +---
>  testsuite/smokey/psostests/rn-1.c      | 7 +++----
>  testsuite/smokey/psostests/task-2.c    | 5 ++---
>  testsuite/smokey/sched-tp/sched-tp.c   | 2 +-
>  testsuite/smokey/vxworkstests/task-2.c | 4 +---
>  utils/autotune/autotune.c              | 4 +---
>  6 files changed, 9 insertions(+), 17 deletions(-)
> ---
> base-commit: 48934c3fed790f8603eaaf0d4fa1ce92d27552f4
> change-id: 20260508-wip-flo-gcc-16-6291fb97b9a1
> 
> Best regards,

Thanks, patches 1 and 2 already applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
