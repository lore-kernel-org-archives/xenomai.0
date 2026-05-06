Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021077.outbound.protection.outlook.com [52.101.65.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CA4A13A9
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084191; cv=fail; b=jatE1KywCfLF8KMsH4xDj5QKLnDqMMMMUGqrYDioPEvfh7LEP6eQR5l8vDXB93RYsObj9W0NGPjyJfywSl9arIYHl+EbyFN3P2tZ4vOo5sKi/ovwNk3t7PQ/USvYyDaBEcJCVGxaLWe+jbZKqpi0v0y5OXqeeX8oK/7eoAiQqfA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084191; c=relaxed/simple;
	bh=VUB4DHJMD8f5VhF/Gpti6H3tRPLxL1//0Y0g7G64M1o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nLxTsCBUH7HGFmmwrPKaCBQp/VZeJ9ign2Z/vuZv7wJBD7xoaLls9lYFlgolB1NzO3QAngg+VvNfo0hX86zkmKPUJ66kVeXajftgMxNH6MuktTb/Es54rLO/ByYInI2b2yDZXq0nkU1OFFMGDOTRDut9zSShik1zrM8UdbeV7jY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecler.com; spf=pass smtp.mailfrom=ecler.com; dkim=pass (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b=BJ5dobM+; dkim=fail (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b=I3ou9h9D reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b="BJ5dobM+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b="I3ou9h9D"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eXp8TmT+U7V28nntGDs76RbNgfupJevQxpauqDHpm2Nw08usF11/558YlmtfbdV/cP5qCcSkDLxHKe4P6jobh52fjKjWUrtxnlDA40+PeD48RWuo8eFpEpjPUhkDWn1TRrMcqWDQMwFGNCRRQoIpaKyYKBrBTNM4VFL95Mo4eqs1sTU1xR1q8RnaWCsm8yJ3u9bqjcHPgi/0/6UNsQhzT4P+OWnk3S3pLAI61QRA0BYCB9NGm8UQvpKSnX07SyKop3jCjpYhD87KAmnTlJa+P+k1gSgio9SZP41vgX3kouFXuk7sD+FdBTpzgX7Zc8bkFj8nm/4KO1htEOvCqZKK6w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7sO+nuVv6AvZbzih5geHCniqagLdUSe+uk8pj+bv6o=;
 b=Nsqrf7/by1HHWLVKP+7S5kzsj80qOqaD5Ll66vJ/564GNcA6TheeszPaxJrlPLoY6WdLFXEuXv0IGDk8v3Dt9gHypKeUCPRV2WycUuheQl5kyLbDwdkvHDRjDo/9VkQgpxvdbeg/OXn2nPht8kdV3nEoS/aLIJx3or/yMgUDd5KlzqntF0W+Trz4fHm2AEP99wCpS/1EaSeqMce2ZHFjc0gvabmbbYbgT3zMJuBdjOokfdKcKoTO8GhVK96dyEPH7s8k85Q+J2DCM51TBhvZzUV4emrA4XNYiuzrO7VlI+shps3ezSmZvCqw6+Lb8kDrmpS3MhG98tmoborq48HnRA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.169.0.179) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=ecler.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=ecler.com; dkim=pass (signature was verified) header.d=ecler.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=ecler.com]
 dkim=[1,1,header.d=ecler.com] dmarc=[1,1,header.from=ecler.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7sO+nuVv6AvZbzih5geHCniqagLdUSe+uk8pj+bv6o=;
 b=BJ5dobM+OHQiaqCFprwYWBeLcymGtv6KvGKdMMxVrhwGeOMQXR65Oy3XAIAV7mEI191tXq4inKfQub7HTxMhYSlXcoygtbz9jeo5D0C9eD4irBes2rrgoDW8BD9diwSGZosDFrbDpayfaygD7hD+i3W7anCneuOBvDHkcPv30rtf96f6mmvxAOQRPwepojMG6YZswTh2aX8h7z3JMu7hR3IUOdYYkK1HzAyxcKK6PDQObLYUJ84axA6qivqacpn7cJ48U9NgXGAkyxquE903/b2wPzYC7u3JGbdpwLvWnB7r49JveDOK4ft9j6poaBdSKE1YA678FwUV9lUNiRnm4A==
Received: from DUZPR01CA0147.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::29) by PAVPR10MB7188.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:312::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:16:12 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::6d) by DUZPR01CA0147.outlook.office365.com
 (2603:10a6:10:4bd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 16:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.169.0.179)
 smtp.mailfrom=ecler.com; dkim=pass (signature was verified)
 header.d=ecler.com;dmarc=pass action=none header.from=ecler.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 ecler.com discourages use of 52.169.0.179 as permitted sender)
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Wed, 6 May 2026 16:16:12 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.82) by
	 eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Wed, 6 May 2026 16:16:12
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 3394556
X-ExclaimerImprintLatency: 471497
X-ExclaimerImprintAction: 2004c9000c8a452d8ec18f54f72fb210
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQAwmdXQw+AXN6o9twHIHY/J2N41vp3AxdNVyRC5+xEnMvwNeIP/zQlZfNqeyJbnnf3Yw1fUIDCxWuttbhlsA5lxy6Hx+t7IDO8Ry+EC64sbGT649H6KgNwNmRM+LyqGzOWtxovga36IZmWr8KqrApLOeVeBFlYIiykxqtfjkWBcrRD8sbMqeZ/YoGw3B+bPnkdhfqztGFWzGORhzcCspX5UNaGKsI2/WptKuvJAWcrISJTIFEtr9+qCRZxCqXhWqNfqH4wxRlO2tS7CW9ZGA+BG8IyBBAUfCMAzZtTMm8G0hzpKg9wfIPFXoXLLe2yJcG89BF3L0hMUungDM1t0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPG8YEhFzC1ZwnpEjBTV4dhIgOEREUP4Hhl7PoqDj3g=;
 b=it4fPgvdCAxCRPr5052g1/ZZKnGg2y5XAFyLunYf1RGzXaRPNg0m/GqOTtnV60VBCQYx8kdWkcq0Bcp0QN/M0U9GUjnKH7YXcdTR/IRo/zGa56pvd3aHIqI3kxYIBoP7+JCH2CH1Ys8LiD0YqRW+da4/00ZvoBRN+pGUu5wLm+8zAg2RC1QYWlrALxkpd9gal06g40+r4hBzAxd9FepDoWKPuANptKZadNoDh+on884eiqIuhyuvVAdg7MCc8n2Sgqw4jpr0AFa4iCJU6LsHxkliywJdoTm+1rjG0rgKG9bPGDaIr+dUnLY33e1L9xOs9ogfvduoi61kh+atbBRpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ecler.com; dmarc=pass action=none header.from=ecler.com;
 dkim=pass header.d=ecler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPG8YEhFzC1ZwnpEjBTV4dhIgOEREUP4Hhl7PoqDj3g=;
 b=I3ou9h9DOzN6n4HqjuRO5OTDu8M3nH1hf/2L27PWP/ETMHM2/GqHS9AujlIwxjzt8pssu9EXWrzlHW7tm8iQIwWsgzzZWgxTdYzYU1cV10ZWFRNsynyv8ZAd8qVWQUSIXfajLw4sTSe5MMvAKTB0dX3eTiXeMbWs4sFE9jmy89aj4rnxGJWFF1Auh/XenYtFPKthadDrk0+k3uQJVM4fkroL1ID8XZ6ATTMCRzx9qEn0gcox37zp+0UMVAhsdNgyMPDEnzZbvTNFtosl9W7sqeQnYGDN31/zXy5UpzOHF8yxIM37Dsy1cqQzk7t+rwz/yf9hFdi0yYOkj0T/tPqaEg==
Received: from AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:629::22)
 by DB9PR10MB5186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:325::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:16:10 +0000
Received: from AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c03:58fb:66f4:7121]) by AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c03:58fb:66f4:7121%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:16:10 +0000
From: Jesus Villena <j.villena@ecler.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: EVL: CLOCK_MONOTONIC_RAW
Thread-Topic: EVL: CLOCK_MONOTONIC_RAW
Thread-Index: Adzdb9dcm3O2GDHvTKejs4CItyOK7w==
Date: Wed, 6 May 2026 16:16:10 +0000
Message-ID:
 <AS8PR10MB773133A184BDFE3CC57D8DA1F93F2@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ecler.com;
x-ms-traffictypediagnostic:
	AS8PR10MB7731:EE_|DB9PR10MB5186:EE_|DB1PEPF00039230:EE_|PAVPR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab1e2c1-6d52-4aef-d99f-08deab8aca6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 1/Bw7z7W+s+WBWuS583xPIZFnRd/OwrTXWNMRh7o27bGDBKjhjVBhbxq5S7xNDuVI4rqSdt3XYpQjCRgjeIJpbwoR1+vsQNOpuM3WT/4W0jggFYn+1mH+sDuLZGQVc6XIBXJvjNft5aX3fABrd/UYg8249jDPS89u4pNKMa8bOsCF70sPrOIurk4yvm0ttcpjeZy7evFnrYWXidkx9HHdS7QiwlXDySmFI0OhQleLXIXDXb9emE4I3SkdR2mQBkpbgywoX+PyU4aWi9y76BLaqOq0S8fpodowdMBKHRoKiyw6X0MQLAkSUHlMcU21pHgfAv22O3vLOK8EyIQ6yqWZB/LXnHpv1CW6Lrgl8BqKy6ZB1qi/TXSf40OgTAOLp8pdyh5N5YfQhbK/eBf0+hP6rX4+mH52YfGutWVDw9Pnbq8f0JGwvimp3AykcGDUHKg5wcPmUvjMTEXqeq+1x600xYvya5ZCuF9qQnIQWbwRZweJuLdPHBAV+8JEbvdoRCH3Zw4PdoTZ11L5/8P2d0XZgSk5Azx2R6NSDHxYVl35JAx5Ekqzf9WNBlMONGy1vew+7oPNIgk12DJwXopazuECziplggZad9bohdXQUmK3hEpqchugQRkSAtaoPi4duFaM48pOylGlby2n5k2d4p8VOLGVlWUU2Wm4f9IVLdcDrF34nZ+hfjKf3Wph6g0mt0gHVkHqMpcv2LUoaEDvmlBPPhP+kSAm8ro8LNWubLdg3ojeo8tYm+jk6gsUAqi671d
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 Va9XCfgAY72q5siHSoPZEmIXEGtP0DLCexoHqL0SuGduPRlUL1t+kMCPvdCoF738jm0tA3u7l2kwwnGtQGIt8flZYjjysb5VOjcnPNbcS6/qkGaRISdH2N7tmVXPRXucApJmYcvk95OWfsYbjWDdKA4TnBrbRUtIB/y52D82NzVCV8AZfdOaY8nQ3t1e8H6SxTFPZjc+uFWSoZHVZ0no5N1HfCw3o1Aa+y2SylFfAIp0nYNd1if6lCnSupa7eGJMsYLjPJP5QJBL2IWu6v/2Rk70KRpHbbIdPAjyXHA3+iFzNWgm8B59Y2UygHqQDO+hvbIQSSEFd9kh4A1KM5hq+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5186
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ceca7fe8-a1a6-4dd0-a40b-08deab8ac92d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|14060799003|1800799024|35042699022|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QxoR8mPqk+Sr13s3KiGsCW8utKYNPd/tTVqU6oyJiDgVQfMXZfpfYJvhcygJn+OuyiEu550H8WnlKQ5xit6HuBSGmpz8xF016X2Ev0QqUj2Ht6MQg6X+7H28Gp1ZlSGFfsq0ylJnAYdCgG2Dewj0x1ul6G6I9k+PHkYMYgg/qiHeqMzu+V37i2BAiXqsnXhjsiGTBOsJ5fGuFU5ba8v5I0EprDPMWE05oegKI4PbKxJdO/emVByoNNKFY3o2PcBCEfgPXWIkn+TnanH57xvi3YI5ygrCXWCfygdIQV5TWzUF6OzmxSWmadM22n6z3rygbPY5NFa1E9uXIbVVCNbNHjHxzHFRc0owSMvPTgFtWrwZ0JC6VWST8gDN5WcoIO9Kk3x8cmzvBb/Jwlg62546ky9YW9yqf1ARaxHo9PVFSmi82Ai1OL88ZTFBTjWYxNLgIKwRY2VMtAEiicB+wLYMaRKFKZOxyx8VOKRUX5IfB/nqzA+uHZo5Vlqshr4AiL1izKCyjN8h3uMcYxpFlf8ffbR530GAl3XpVz3GkPDfwe/owWXQmvTgZcuAfhwM0bPSW7boGi6htCH3RxWg7vKWzuIu3b1PtQfoIqlosrS3Sr/OgRP+yZJQ+M/vA74wZftGKkolM72vYUTrUHCu1En1+dmeXQ3euDqYSvyyNLjQ1xoQaNgNH3+vEZ3cdQdbDVBgSVoftz5k6LLFOLxKH5lvMHXHLpyqv17wKs9YF359zkI=
X-Forefront-Antispam-Report:
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(14060799003)(1800799024)(35042699022)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z/CdZ2NcR4Z/B+rzC6dVseeAUUHWbICkQFFID42mmmZmUpkv1+uRm27Zw8n1TH1c7u06ae9MrMy4Nl6alfVhi78RMeUq/LEIzv3SOpIvDA9G5MosHjtkRMD27En4yCkiaHtsbdHQaCNckOEytYOsW1unFV1aEjHQwdTuFJJoM79/jgmXLGDbghyFy8qy8dC9amGqtDvegEj+qs2FdMCza/Nk8kXqTgBQahfTHlxdbeNokX2q7m2FigLM3Z65y4f5soVPZFr5Z24U51OZqg5307kOeKLXk3LAsDMQzxI80AniddNvRPbdPi45gVaCKqxW8hdfBKTrdtUO/97aVctVHXizZ9yGZae0F6LH7lrHNiXtIUqW81qScYcP32xjmocJOXSDPpMpR4zG4SQ+QARM5au3ZH9iDTfLuN+LNDjXc9YeFJ2SEWV28wn0bT/HiK4w
X-OriginatorOrg: ecler.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:16:12.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab1e2c1-6d52-4aef-d99f-08deab8aca6c
X-MS-Exchange-CrossTenant-Id: 6f9193a3-7ddb-4a6c-9664-df2759e0e5ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6f9193a3-7ddb-4a6c-9664-df2759e0e5ac;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7188

Hello,

I have some problems with audio synchronization algorithms running in a rea=
l-time EVL thread when using NTP at the same time in other inband threads, =
because they use an EVL_CLOCK_MONOTONIC clock to measure time differences a=
nd to implement internal time corrections (in nanoseconds resolution).

I think the reason is because EVL_CLOCK_MONOTONIC is based in the CLOCK_MON=
OTONIC linux clock (ktime_get() kernel call), and it's known that it suffer=
s from NTP frequency adjustments:

        CLOCK_MONOTONIC never experiences discontinuities due to NTP time a=
djustments, but it does change in frequency as NTP learns what error exists=
 between the local oscillator and the upstream servers.

In Linux, typical audio synchronization algorithms recommend to use the CLO=
CK_MONOTONIC_RAW instead (ktime_get_raw() kernel call):

        CLOCK_MONOTONIC_RAW is simply the local oscillator, not disciplined=
 by NTP. This could be very useful if you want to implement some other time=
 synchronization algorithm against a clock which is not fighting you due to=
 NTP.

However, EVL doesn't have an EVL_CLOCK_MONOTONIC_RAW clock available in an =
out-of-band context.

Could you please add a new EVL_CLOCK_MONOTONIC_RAW to EVL in order to get t=
he correct behavior on these scenarios?

Best regard

---
Jesus.

Jesus Villena
Software Engineer
607198846       / 3025

[Ecler] <https://www.ecler.com>
Neec Audio Barcelona SL
Carrer dels Motors, 166-168
08038 Barcelona
ES
www.ecler.com <https://www.ecler.com/es/>

[Twitter] <https://twitter.com/eclerofficial> [Facebook]  <https://www.face=
book.com/ecler/> [LinkedIn]  <https://www.linkedin.com/company/ecler/> [You=
Tube]  <https://www.youtube.com/ECLER>    [Ecler Brochure ISE 2026]  <https=
://media.ecler.com/1768915806-ecler-brochure-ise-2026.pdf>
Your data processing is under the responsability of the company NEEC AUDIO =
BARCELONA, S.L. registered in Barcelona, Calle Motors 166-168, VAT number B=
-55210645, telephone number 93.223.84.00, and e-mail address information@ec=
ler.com. The aim of the data processing is to forward news bulletins and th=
ese data will be stored as long as unsubscribing from the newsletter is not=
 requested. The legal basis for the data processing is consent. Data will n=
ot be handed over to third parties with the exception of being authorized b=
y the person concerned or under legal requirement. You have the right to ob=
tain confirmation on whether data are being processed by NEEC AUDIO BARCELO=
NA, S.L. , as well as the access, amendment of incorrect data, or the reque=
st of deletion when, for instance, the data are no longer needed towards th=
e aim for which they were collected. Under certain circumstances, you will =
be able to request the restraint of data processing and data will only be s=
tored in order to lodge or argue a complaint. Under certain circumstances, =
you could object to your personal data processing and NEEC AUDIO BARCELONA,=
 S.L. shall cease to process them, unless there are legal and imperative re=
quirements or the lodge or arguing of prospective complaints. In addition, =
you can review our full Privacy Policy at https://www.ecler.com/en/privacy-=
policy/
