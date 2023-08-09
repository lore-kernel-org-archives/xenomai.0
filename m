Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4903B18AE5
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 13:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmefZy0Qt7JRO7u9xoHS5fc0ANmNNRL0Z0UyULYtMOQ3RJ+6BriQ9WirQfzZQ1+dmJ5hJvyhksMOHhUGqwat7MmwWSeyRZi9LbouZkn7Ndg5s5CE4nb66o8wTp3JPkxAfmI9mwJq5hIF/53J5sBom3QELvJmCX8dsjRta22NA0rvUejtzsQDCQ15y72C+RUagd5kSo77nnlRkKP6t/B+kEFie2M7RaAey051bq7u7eQu/obVJMKzLl9CbUCBzSKtTvLmJix0bbPlaPTx5SuKaVC3J1d3j8OSt+MVP8j9XH2auf5dhG6A0hsyDAOp2YRkL3wBpijMSP7Kg7OyHglaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgXenZYKMfc7XJhorczvi5al4fHe9dN55hJ2pwFTOHQ=;
 b=bVKZ3kkwYF0KGPLMzIe2H9ixxICT6kGx04bpvBk0gZ6ilCZbdLDt76Om8dX4Qjr81och+dVVDPmfkqwzC79HF+F00rNfzuvqN2dfqXinTRKpQUklQj4h8nRsZQYyCYj4+iD3NId5PcV2nLI4rikN1zGVZHQzFMSqbnNwTmmwi5F80J2LQS0PJVQgU3mu05IuwiJYkuTYXziOrIvAmze7podYXR8vqg5cMBsTbq8zkFHaExJlHnwTVSEqSklEob4OrXPolKLJujRAAmHDi0I+AGXVmEq8tem7v27BWt1sgoWNNPf9qBy1dJ+7v4bewbf0WIxjolskS0NWTDPfpi9mlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgXenZYKMfc7XJhorczvi5al4fHe9dN55hJ2pwFTOHQ=;
 b=laZa3KuP7hDgEIY/IPdlk3v/mMksmEPZLJbm63AHOK+pxnn0OgV5QOqEw0c0qnTozHs8e8heS1+beVlP0z6NKCVWzjU7aYsLfKOjzPoCUBfVBJlONdENGyrniIxjXxBmL5qA99+oggxUkmSFpZSoUJFyN58s1fuBOTDucDn5OA0HLOqSX5qtmPUJrNctZZ5eqCI74+dHBIkCbddOmWKnnlWEPUQC9aY6PA/CsDemzXy+ohhQwQSFpF5HNiHxFeDmN4NqEezqAYofmN4av2vBxFSRh6p8GbwQbCPMSQvp9xKBSPUxfLy2z1sGeaq2vesRjs9kLfBf3EoHAWsv0GSM9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:505::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 13:32:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 13:32:06 +0000
Message-ID: <13d42c4f-ee14-4105-9fdb-ad371af50d41@siemens.com>
Date: Wed, 9 Aug 2023 15:32:04 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] debian: Enable lores clock by default
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d9ec30-80c7-480d-86da-08db98dd064a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r1r8Gv0PfEG62omzn1cCrCDwhUQ2JiVHJ1eqqzX8Zf76+IVAYccwLhFXxK9tNZvBAVcRIN2CmxjKE4NOatE0ihMXlBDfyw8vSqWvAMLHEuQCAf0NX50dAM1ylfEUkVSiSLH9qjXcwwtohRdeU7oHjp0tx55yQUwQcRVPJKcAuUW1GC8QT4MBSrvx4koLcVx5iQC/AKEhBn/YcTOYMLrBYsRgylXnzr/Irwe+Kw+wQCgLyvPvfJkWviXTE2w94+C3kh5J09SnaFwewV9VXenUBG6uIDujsDGt8stbUL5c2k1Lfszct0Yv1IGYkxhTiNWocdTluUcqxybG07VuEZfOOGg+WHwgET+oCQbTlbys8HE9S7V47s1EwV5on4xbFGPI06ffFnBc3sPDBKMjbObAAaiMCcPat3A1EOtwVLySKMK6x2RI99u+brNTn3xGcyePj178GA/9w8Bee0iFdHBoOlKJe+9DwMThU2xVLofDPaD688jcvc1VAmQGYyl735FyzyBAFoC/wakqq8SMEQ/g5i6bC2pzQluBD2JkWRN0GnZ7xO7h2cbiYeeK1K5ovWaPP1iWuTy/tqJF8d+kMGA4uQhOwVacSjDf7O7Zaeet/G6KwyU+vUS5JKyawZyKMpe15n1fie+SvuaFYVyBckhvCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(1800799006)(451199021)(186006)(8936002)(8676002)(5660300002)(44832011)(4326008)(316002)(41300700001)(86362001)(83380400001)(31696002)(6916009)(2906002)(4744005)(6486002)(107886003)(6512007)(2616005)(6506007)(26005)(36756003)(31686004)(66556008)(66946007)(66476007)(82960400001)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWZXeEhOemg2UXNSbnZnQ0hBdGVOS1BseiszZWRzRlBDbG1CcTRCZnFwQlVj?=
 =?utf-8?B?RnJLai9rUWprS1FCVmY1S1k4Vkpic2llSk1PeUFqcWZqRGJOeE4wYjYvdy9U?=
 =?utf-8?B?anJNVnV0RFZWbUhyQWxIOVpXUlpMMHBaWElVd2dmL21Fd2N0YkdRK3huYitz?=
 =?utf-8?B?d1Y1RmR5cDEzcU4wYkhHQ0E0bFMrZ3NWQXQxamhzZlhKSjM4QXBZU3JHaUJ6?=
 =?utf-8?B?QUEyR3IyR2pFeDB6QUhmR2kwSkNxc3JKTnVWaTFiM0lSOHppc3J5aHZmb0VR?=
 =?utf-8?B?RW9qVjRYcVE2cklVZW1DWUdTclNnbjNaakV5Y2x0dmdUMG90K2E3WG05R1Rq?=
 =?utf-8?B?UVp5ZWQ1UUl5YnRKeERWMkEvK1NNSVNndk5obVQ2VGV3bXBhdUYxZ1VuN1JB?=
 =?utf-8?B?NGJOQ0Z5K2FGT1RUSTdVNjNEc3FLcWVsUEpobExNbWFtQlNUKzN0ZjNRQ0Mw?=
 =?utf-8?B?KzhmQUxndUN3STdUaU1lMy9UdWJ1M2J5T2xCdEZ6YTFseGFXcDc2eVM3S2FN?=
 =?utf-8?B?cEJoazF6TWxCbXhoRUZqb1ZZWmRLNnlDcGZ5R0NSY2dCTE9RMWx1Q0JFbFZ6?=
 =?utf-8?B?ZlpndG50ZHFLZ3lHbTJEUmVzZ3F2cXN4OVFkejdianhKa2lMZEFzeHhNZ0hh?=
 =?utf-8?B?blJTR001eFZwMGhROFFRVlRaaVIwRGp0YmtuT0JMTDlJL0xTcXJpVWdSM2Fx?=
 =?utf-8?B?TUkyQU5RTjNVdjJPK043T09rbnpWcVN5bmhJTUpCbjFtU2RlcXpIcFpzV1Nr?=
 =?utf-8?B?cEZ4emtnM25lVHNBS0VDZVI5VFhkbk1rYkh2ZTNDbEZrTWVMSEJFdHQ1MzlL?=
 =?utf-8?B?bGRHVko5c3NKVlgwTCtweGIwUVNpeDlEOEFIVGFwS2owa2RwY0dVelBlclVa?=
 =?utf-8?B?dTNtSkVXNm0xK1ZKR0dFbmhqUjI2ZDAwSytsNDlzUENkckhuNTBXN1l0SlM5?=
 =?utf-8?B?RFA3ZUEyNEFETmpaU0FEQW9sVmN5Ni9oZUJpVFdDSC9reTRzQlBJRzlDSzB5?=
 =?utf-8?B?dE1YNG1GcmR0a1ZhTFlHSWJLOThZZXE4ZE1RSE40K2NQYzdnT05xRzdnS2NH?=
 =?utf-8?B?TUlFcThrQTFRTGVtZkpqM3B3MldxVVQ2dURMb2xVYkZhNFkrMmx3MituTzFu?=
 =?utf-8?B?T01pVFFETFJJQ0YwRDcwSDJiTm1rSytGQUlraUtlRmpuOVl4b0JQcVhWVUZs?=
 =?utf-8?B?ZU0xNDVqSE5waW5qQW9zSlh1N00wbS9Pd2dPVEFxV1BSbkRQVDRGdVVMckhB?=
 =?utf-8?B?eU5YRHcwYXV3emxuMkord2tHRkxPbHlKc1pZZ01BRHRZdTNtUFQvaGlRZnR0?=
 =?utf-8?B?ekcwWEdVRkFmSnlydm81R0orN2RTQzZiREZjdUxIWHVMUlVTeHQ3Mlk1aVB5?=
 =?utf-8?B?dDFDK2FVL1F6Z1ZabW42QUw5OGJ2VWxHbS9KNDZLbjd6bGdzZjNleHRPLzJu?=
 =?utf-8?B?YWlzVUFQWDFoc09HRVA1cEt1c1U1WWhNN0tDbW1KSTFqNEQrUEtUak0zQ0Q3?=
 =?utf-8?B?YVNxcThKUU05RGFKZnlrdE12S0FaaEJKMHordXBsTWhyZTN1OWF1MXladVlG?=
 =?utf-8?B?UVZrbyt2UWJnVU9pYm12TUxadUgrOUFJNzNTaGhFL1d0SXlHWmJhbUpsU1d6?=
 =?utf-8?B?MGZvcjg4NWVhaWQxc0drS2J3NzJmTGh0eCs4RzBLTmR3REdBMGdCeWI0djN0?=
 =?utf-8?B?MGVKdkx0VHQ5NFpLN2tzODEzWFZLSURNVk16N1R4Y0J2VzNhVzI2N1FYYi9C?=
 =?utf-8?B?NlBsT2YyREtDcmdLeE5qeTRyc1Q1dkt3ckNmWWRLK3VpTUJENVJlTkpmd0ty?=
 =?utf-8?B?YVRDVVB6aWFYVW4wZkFlTXFNdDUzU2VaNjBMai84Uzd2bWN2R1RHQTJva09w?=
 =?utf-8?B?VEVYYzRjNlU1L3hyZ1haVmNmY1p2elAxWFU0UXI1OWV4QzV3Y3FTSi9GOUlR?=
 =?utf-8?B?VDJEaTNsc3RXdDZTQlhTNFhHcWFOME0zWGdPVE14cGZTV3Z6NXpvYjNHTitH?=
 =?utf-8?B?YXd3ckVIdlFBZEMzdzZ0KzFKdTEvUFRyL1RJRnAwWGhHL2R4NzBhbzBtMk9h?=
 =?utf-8?B?VDUxcHExb0pGZGZsV2NOeEZsT1hHNGpCcFlYZUc5SHZlOXZLdFpMM2tXUmdY?=
 =?utf-8?B?czVWWGJ3ekE4TGZJTXBxQWMrNWdHUmpuQnBYUHloOFp4aUUrcWxLcGo3MnJB?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d9ec30-80c7-480d-86da-08db98dd064a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:32:06.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9k51Vtp5lVKDxdSW225Bc7pNx50GjUcqZPxb+5Y5mw75IMs6ISlwGNNLO9Zed+QIgfO4du6IPSOAb49l68L4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5798

From: Jan Kiszka <jan.kiszka@siemens.com>

Having the goal to be generically usable, the debian package should
enable also this feature so that pSOS and VxWorks libraries can be used.
It comes at the price of a slight overhead in time conversions for
hi-res interfaces such as cobalt and alchemy.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 debian/rules | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 7664bf21c1..8e984acdcc 100755
--- a/debian/rules
+++ b/debian/rules
@@ -19,7 +19,8 @@ CONFIG_OPTS = --prefix=/usr \
             --with-testdir=/usr/lib/xenomai/testsuite \
             --enable-lazy-setsched \
             --enable-debug=symbols \
-            --enable-dlopen-libs
+            --enable-dlopen-libs \
+            --enable-lores-clock
 
 ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
-- 
2.35.3
