Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2134.outbound.protection.outlook.com [40.107.103.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C78F5B
	for <xenomai@lists.linux.dev>; Mon,  7 Jul 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899652; cv=fail; b=j4wCYpbwhv+704Mon8WssITwPa65C7rjXcFBIJjrYPv/33I3svG/+fmdmP38t3BytvsRyGRndzEuCxgXesCRoZ8UpgzbD+HjjuzgGlKeduc3Qdb+NP6otS108Rz8K74eDFAfBx7G32+HLiG9P6SXWAw/DYeAKb+Vbb7S1JqzpNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899652; c=relaxed/simple;
	bh=ej+DCVjKJEGf1iBUpHuNCnRNo+z1FmAo5zCNWWjOISY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gJ5cTjd/UstxGiYqgtEpuvXpI7SduhSG24C39z/mvuX5QMG9QMjfkaQwTc+fhiRozBVDwe402I8dTX3wSO3wd3kgy1O2twF+4RRfxZZLVM7BDVCrMCbIspAbSRUxx/PNnLN2tMNf9qHViCwB6SUCUTJNYtx0yn2znv5uyJrLRyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=smaract.com; spf=pass smtp.mailfrom=smaract.com; dkim=pass (2048-bit key) header.d=smaract.com header.i=@smaract.com header.b=B4jC0nKF; arc=fail smtp.client-ip=40.107.103.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=smaract.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smaract.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smaract.com header.i=@smaract.com header.b="B4jC0nKF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXjs2N7e/pFZDkPFvliyvoXXsREiIWAEVw5+m4bV1UWUQ7K4wZk6lMUURPmw8FPIajUrBHxe4cXqqcVgbmHNb0v4VIcngBcXxVt86f9cNwNN3HIX5MQ3KxzabDg5vGdW26vlaLaejld07OrGfL9MyKgezkqTlxnwBCGtkCayLQOUW//3Vez+OYfXXc4YCuJ1Zgg06ctQXyej93iloKXSRA8/Y3Iw2zVfoKmB2i/wBURjYRjmKWFvHAtbcHhFwCy1JD+USsdXZGrZ8kAIAM+EzzBcZA6G40MaXMVCsarZYPRrtDPbq3+JtE40UEL+mwiL+t2cs48GxjBFuWXAJWFYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBRnJT7D6N6OWVGMmVK6n7RaybY23W0BR9zPHpa+Gg0=;
 b=FsCgbcvkTmzgcbCtRaYQlsMj/mL1nV5zSp44ES+dMS8PmoZvyspmSpdirmHYO6LXCsZ7jEOjJ8lZdrs4tXTgaUaToSuDxvDsAM3XeNfS4hdeafSIfv/SXG+eJcv6rzW4JWjEgZPkLoYyqFylXEOqNqAY3RDQT6Loz9cqgrqT8gLJ1f3J3Bid3fnVeDda0IUzEaheaEwnBP6yMJ6Sle3yuWI5weV78CDKrHG3iJL9cXUs1IwD6fDFKy+YP9eyEIGIrJ3NDedRkFrmzCFBgLSFGqhb0ApQB8mJwNLos8M6gwa8o0MMWCshUQ8vQ9F3gJsgH0kpyOw4pq85A2lwYoBjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smaract.com; dmarc=pass action=none header.from=smaract.com;
 dkim=pass header.d=smaract.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smaract.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBRnJT7D6N6OWVGMmVK6n7RaybY23W0BR9zPHpa+Gg0=;
 b=B4jC0nKFv3NuxqqNzWS/GNs5uaQCCgaKiW+BDFScmkAQiHQrvIYqFg+wN+V+Q3uj89k1fM4vj7gCv2j2qK1Cp4dJ4Qcbox5rva+sUTd+fWzJC5EkDurtu+8KPeEhKUv1PDVm9VNDosY2EWkTh+QJm+xLJ3vPHNjtadNnBmAmAYGaW9yeN0v1PK9NKzMSul8cIH0tG2/BhEqpGe4qrH+cuafHZ2grQetoZnVPquNCwiRkhl1z4RMgRmBemgBQJEFR5TrmaNI1bM6xsaTU4yOWdDe6AIect5mmJZDuAENC/KI6JEfhw/gSxS0g2FVRQ4LOTI+++eQtN9683DANVYpKSA==
Received: from VI1P194MB2193.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:1c6::20)
 by AS2P194MB2023.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:5e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 14:47:26 +0000
Received: from VI1P194MB2193.EURP194.PROD.OUTLOOK.COM
 ([fe80::e25c:93cf:6187:adf0]) by VI1P194MB2193.EURP194.PROD.OUTLOOK.COM
 ([fe80::e25c:93cf:6187:adf0%7]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 14:47:26 +0000
From: Sebastian von Ohr <vonohr@smaract.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Clarification of 'unrestricted' context tag
Thread-Topic: Clarification of 'unrestricted' context tag
Thread-Index: AdvvScZn/RmoH+6AQfelASttZyBaMA==
Date: Mon, 7 Jul 2025 14:47:25 +0000
Message-ID:
 <VI1P194MB21935AEB04E94F01CDD24FDBCC4FA@VI1P194MB2193.EURP194.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=smaract.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P194MB2193:EE_|AS2P194MB2023:EE_
x-ms-office365-filtering-correlation-id: e11bbfcd-ebab-4c71-9337-08ddbd653079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3i8Nnvys+fqJb5wcLcB+FmZ5On5XTO0d5ijgiHtQ3M6FpiHpHhGNyw3Rq1W/?=
 =?us-ascii?Q?G/PIkBaYmZxbe4mng80f4xgWm6BQJ/h7EH8WxQMHgOlQKM65LK60ugq+lm4Y?=
 =?us-ascii?Q?CHTYbgyWjxqvDv5gFcUWUcUqZln2ZBfvlbcz3G4C9RyjUwvzLW2XbqZqethn?=
 =?us-ascii?Q?T42Hs7MeuUxLZ34618UmukcS47qE9IeAwYyJV+IRjagdvz1U7u23FK1J8epL?=
 =?us-ascii?Q?Qb2I20omF/OsiKRLukqxr08Z6VbQBPoFBhu1YTuWLY2ub2vzr4JyfkV5/ua4?=
 =?us-ascii?Q?olnf8prvWhqBs/rqx8nQx9aCYQpn1yHktnkVMGTRnF2FGSMdsUMAxpha9uDX?=
 =?us-ascii?Q?wMe90t7weiow/zUYyPgKKJaETiCGGabRJbajoN6h52K2h3DYAePkaTMNDslj?=
 =?us-ascii?Q?SfJSuNLSMAiFlgVtUta/hkduhTkYJcb2ZMbF7pBHNUzovZmsXkMMh1IU0mPy?=
 =?us-ascii?Q?dnXFkQ+FmTumVg2MyRylYwYznUlMe4b53oDc1QuFx33AdjVyGiqlHI6Jrkkg?=
 =?us-ascii?Q?fDcUu5I+SsdIQolhGKqFjCUYRpYGek/jtBfjzyl1FZ9lpaGdVgkckoM7eWHn?=
 =?us-ascii?Q?UrbtXnRN1WJSpPeM8y577103eJG6btgDzrLILFqIaMFe/x71tW19Bq1x3lst?=
 =?us-ascii?Q?uN+Z0RnmTmp/XbcgDDJds4c8iHI8D1xFw6Hlg1cl+uXiK4vbJ38Uz6AGXeXp?=
 =?us-ascii?Q?yUz2VfsB8U/ez0DIBkP7LtHKtZRpnwC5m0Hp6Fmpa7powCLFa6k/unfsUqjX?=
 =?us-ascii?Q?qwiZmp3j6WgIlD8U3Q0vZPVjRgZW5MAsrrOMEFOGyExSnHHnj+Wed1fX1Ug8?=
 =?us-ascii?Q?8suJIf1aBEo1MAKuZE83QVyFGbhiZpz0Og1TYXzF3J2OXWHq3KVFZ6fhPO/6?=
 =?us-ascii?Q?L4wYxRMXtxkdHEeCUwly+nofXsSi9HS9sazpQ4iQJmM+AIrl/Okz26g0lzoz?=
 =?us-ascii?Q?tIWU5iPCS3KEbtEQXZ8T1En85OQVgf9UuwfVUVGK/GD6tPpJmCucWb59eDAF?=
 =?us-ascii?Q?TDalNhA43Zjxh0waxN5sF2ghCsCtPkP+EPzSa+cr/db/x6dZJsPvAB6mPxow?=
 =?us-ascii?Q?KUfRSYUzHNxhJmujP46DDoc1nw2xUcsabTTkrdeMoBsko0Le2+gZmAd5nUOt?=
 =?us-ascii?Q?kIg48AGetZdT6fIFpXDTbcRKfnhgApyeIlIje/mbRjGRZFq7kl5nMRDj641n?=
 =?us-ascii?Q?P7UmDhBpzbvEc7qMo/ahoqnsJwbjn52Jws99tryDNavAiIxP69dTJMVs4PbR?=
 =?us-ascii?Q?VdF7ZF9uM3X6FfGoLFf3QryWcOOZLiNoxsbeuOoX7IIH/yQEHaVj12Fv+yWC?=
 =?us-ascii?Q?ZkVAXWHRk7x3Xcg6XLz5+O7AafHlELk4wEFPHplfCyRwWkwO5NjYxPp8dWPp?=
 =?us-ascii?Q?R18/qjFmBsh4+fF634FMUbOWDndz/nlCutsV6RUEJ+LW3GAQa0tNVRNl7G92?=
 =?us-ascii?Q?hBXBi1pO7c7i95u9M36Xx8AhNangPF4llkGdXD0aN7ACOfNA/vVdOQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P194MB2193.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GkRTsFPv+oIKBc1Rueq5xrqAe2QZC2ARlhs+YdUOhTHqEtbDNW4Q7HrzgS/L?=
 =?us-ascii?Q?RT7O2TbzOUvX5IP8Dtd7jDka+Qn+BPZOt8vxkIlneyp4yLrjawNsNzSSTBAT?=
 =?us-ascii?Q?VxMsaCA0wGdGEk1hKy1aVa5IkPrUCzl63UhxNCNQwVuM5Q2lVSEE/fcYJccx?=
 =?us-ascii?Q?SWWKQyxkYkJ1pwQ3L/+qIJPn8hLoZXpSgIkloWGz9BOAxrH5N8BALJodiRqb?=
 =?us-ascii?Q?nLCDe3D8KPvPw6hrUwZGbTkrfqXz7wKB88wuL3V3TifEI0MY3nPFT/P9xn6p?=
 =?us-ascii?Q?+R9/N2U79r/ryZ1guE8jHSsBGqGpFkWhnYZ5jWFNGSNtKcwvBEDKVA7Yy0L1?=
 =?us-ascii?Q?ZxQ4n/SDWdXBPaS9yaFCBpgN4gJNli7wKhjhCbMp6kqJvEeYyA2U6dvX1cdp?=
 =?us-ascii?Q?1sZCuE/lJrLjSaqt7Tr/lSQtSc74T+pp0XoIZd8tSAjcVuC57GyEoV+IJdd3?=
 =?us-ascii?Q?p0dar6dZ+HElrXKOqu9cnYLZfpmi6eGPBXXMbD6V8DLUGcwYC4LAKk+nA3FK?=
 =?us-ascii?Q?0sK0tXh2+Pdw6jXrofD9tl2yhO+EoDjYMHsSTsd9zcvQMyFnvKnir/T+6ta0?=
 =?us-ascii?Q?kS5VXfuKVjTGO8Q3lbmvuSt8mTqtZP1ernm7cHb5byA6F+hZr6FCf+Ndb04Q?=
 =?us-ascii?Q?3u+bBvewT3UOj96BPsOwrdV0ezoMG9jAbelKEfQltnqeTS8bbhNn/6K7j2To?=
 =?us-ascii?Q?Yr8Vtw5vUErGpv0rpzUkWhkBTOHzq5ukWmJQeqbxL8TGhjHQkHQ1QqdbON1Y?=
 =?us-ascii?Q?5Svg2svuTBsZCl/i6E9Ec3rsk/uBhSHoOo8N3GLWSnCPc7FZUm7vhqxjKjf9?=
 =?us-ascii?Q?WE4VC2nVHu25GKWwlq6QjQF1UwSPMKyu/pBnAYaT+fXsddAASFaDVRvAkBjP?=
 =?us-ascii?Q?VgIYKXzWGGAAnfBq5OyJ/sjo6bmx4ODkufbpgrOQx1JZeioWatVShyf/RCzC?=
 =?us-ascii?Q?9/EyT45CUQP9AybuTZ4pghWTsyEX7pgB2XT+jvC82TMcqcK+IrsPwsQ1fHK0?=
 =?us-ascii?Q?BFf93XtIf+LXEVIJrsU4C7a8KJH5bDkqb3ejA/F2tAyW3Mana96JHuY/kLgE?=
 =?us-ascii?Q?RAHjGtq1SGHqhiKW9AWqd0TRaa5TcVDEsxNIsdP3UdzrFLM1B4nDMSQjKlWp?=
 =?us-ascii?Q?nkqEpQrysFZdQB5f9+kxRo6N4I5CKwyuau8pJrTH6X8Kammt6L6YL6K43y5j?=
 =?us-ascii?Q?LK/9+e0G4T64HWUP6F8Sw+L+KnESHZ0o0YhUNF0BIm2jEgSRZBPZknImW20F?=
 =?us-ascii?Q?gyDgBzQ2nWxqed6H8QdYSNnOWc8M6Ww0CD0cGywZsinPjD4O4JhguQDLj/RA?=
 =?us-ascii?Q?aQSXJOAkAQYYpasFkQU87Uv+yWFXqNUR/fviclzIca48ekKRtrdlZrR7twX5?=
 =?us-ascii?Q?3MzLq6N82gymUsz0y88MWztvaV0698VbQeizrlG6phBCAj0h8H2l7R60AzMj?=
 =?us-ascii?Q?96Evca9V9GgAA0304yfICyJ7OAFUHJIl/4w2/JsJOP0Ba7r89W75uBR95JeI?=
 =?us-ascii?Q?8WNmhI93hQDot2nfGDH9ilYPf9BU96TpNJk9YorlvB1KvMOfO/CVj9HjJ49h?=
 =?us-ascii?Q?HkQBrAeAUTkgGFV6JMI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: smaract.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P194MB2193.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e11bbfcd-ebab-4c71-9337-08ddbd653079
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 14:47:25.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: abfe28f1-8ffb-432d-8223-7f36166f96f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elfn5rBP4UpBhWgMlfvo11VLTMRwzcxSHbcSZ7EmIzOfUWJhDiNLoqquZd/qmOukP+sqt49veuZduejRNFbGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P194MB2023

I'm developing an application with the Alchemy skin (without the POSIX skin=
). The documentation nicely lists tags for each function under which contex=
t the function may be called. E.g., the message queue services lists severa=
l functions (rt_queue_alloc, rt_queue_send, ...) with the tag 'unrestricted=
'. According to the list of context tags 'unrestricted' means:
	May be called from any context previously described
The previously described contexts include 'pthread-only', so I expect the f=
unctions tagged with 'unrestricted' can be called from regular POSIX thread=
s, which have not been shadowed.

In practice however these functions do not seem to work when called from a =
regular POSIX thread. See the following minimal example:

#include <alchemy/queue.h>

#include <iostream>
#include <thread>
#include <cstring>

using namespace std;

int main() {
    RT_QUEUE queue;
    int res =3D rt_queue_create(&queue, "test_queue", 1024, Q_UNLIMITED, Q_=
FIFO);
    if(res < 0) {
        cout << "Failed to create queue: " << strerror(-res) << endl;
        return EXIT_FAILURE;
    }

    std::thread t{[&] {
        void* buffer =3D rt_queue_alloc(&queue, sizeof(int));
        if(!buffer)
            cout << "Failed to allocate buffer" << endl;
    }};
    t.join();
}

When compiled with
	$CXX $(xeno-config --alchemy --cflags) $(xeno-config --alchemy --ldflags) =
alloc.cpp
the allocation in the newly created thread fails, while it is successful wh=
en moved outside the main thread. The main thread is of course turned into =
a Xenomai thread during initialization. Similar rt_queue_send fails with -E=
INVAL. Also, rt_queue_read with TM_NONBLOCK fails with -EINVAL. Is this sup=
posed to work, or is it my misunderstanding of the documentation?

I'm running Xenomai v3.3.1 with the Linux Dovetail 6.1.123 kernel.

Regards
Sebastian von Ohr
