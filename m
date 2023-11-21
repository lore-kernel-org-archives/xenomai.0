Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3883B7BB
	for <xenomai@lists.linux.dev>; Tue, 21 Nov 2023 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PWwhNSDE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5PylzjXY2n73Ty7GvJmWa1gnt3S0dbODLBnGKre4Tcf8yBDWoQamKsFfety5oW4pHFsWANY6HgBhtRe2P+yo6vF5kxksb374QsqfusSb23rwhmb3efspDEZiRssXi0agvFLsbHKn3CTMMK9LpMHo38sszK5siArissYyVzMasGQdT0TRyhPSkT6c8LlJoBnye09v7JhpgWaI1sHXVTpP17aX8AszorV/hJdC7z0A/hAzHNLrItS0uit1ZEiGaxo06dAVBmCiAkyx5a2s+xnaQ7TJd6YiZy7uwUoa8SXtz4cCZvxreXGD3aETHM4tNqLRe1MtX0oSsAVCfA46kzVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd4BD+MrpagUVhxzmfDRajZbBSENgz9Bxp84BFptZr4=;
 b=YZ5e/6bD+GwYWzxgZPiN0HLoeyIgKupDkAq+vp79RazsIlB6xvBRteQPlFlFbDYWk2Sz35f6b4hX2oAs/JFbVwbxHe2FqgZ/0VtBOT1bymT82jJAc3W05R/qZqaMeiEksorRke7Nt0vXuEZr4w6BX+/HRBZ3m6M8mzPHLXO5CQW71uVG5hTOo08AjO86xvccdH7b0Ws6Q9NCExGlk5+gVzveselqmoLuZ+SIZHtoNZ5rtvkGBouumNnWwDmWztToUbDaCXDY2kb+gHXdsumCXJBDgbazFVtotM5QdSteJyH5Fh5aItcY9/IVzojgQTTArBYAvb9JQjBV9M5xjSiLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd4BD+MrpagUVhxzmfDRajZbBSENgz9Bxp84BFptZr4=;
 b=PWwhNSDEziTQ1E4iLTNItytL6MvLrgOsI1hPt1w/L3TyLx+3wcWsl3WEHwEvSPCQpYBnBrN5Z4dTBidFvRj6lWgWwZfY3oLf//EGfOGRXvqnx8kqc5/5GBT4ScBM0ZNy7ZoqqDvZEwZH4elC0TeDWu53apyb5BF3rj/J6j/MOQV5uBXS2s3v8mm5M3R2GsiJsUkVajzxNA5tEqXDPCUaud0rQVe7OUbUyh3LNGUSbPPSnU+AIVwRKZ+rhaNejC68n9qt/FrPnnkKyYYPCfPrT9/Ucf1GT1a6nswlWuojWv7ii8+Q9TS3s/FzgXFVO43t9eeVx/2Ax2bp1riNXkL54g==
Received: from DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::22)
 by DU0PR10MB6317.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 09:35:50 +0000
Received: from DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d1b:9079:4d83:2412]) by DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d1b:9079:4d83:2412%3]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 09:35:50 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: evl: Problems while trying to build up a debianization 2
Thread-Topic: evl: Problems while trying to build up a debianization 2
Thread-Index: AQHaHF3ZUo78hQzcVEWcjXs1yhNjzQ==
Date: Tue, 21 Nov 2023 09:35:50 +0000
Message-ID:
 <DU0PR10MB75546BED8CB2E8DE4763395E93BBA@DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-21T09:35:50.114Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB7554:EE_|DU0PR10MB6317:EE_
x-ms-office365-filtering-correlation-id: 18987321-ae50-4d73-56b1-08dbea753fad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uzUVo0yztFfAqlFkBGIH2cqAOAVtWORKwyJUqhN1iG7lQEXv1BQyNU+qUb4K6lEv7oNLqFjR85zgdtZrMA/m6H9WVmliHJlAHwEVwQnoVqicet9G0RRCa1+OYdmsrvSz4KUuoCt24aiGrOmEk8G5P118i8JuTXqHCo4fpqEMIE1GaK8LB4oR/68Vl/SuaFSDV0xyMwwK5a07iD3ZDMYLAUznFS1x0v0sjrF+WRRhIa6jCpfn06K9SybgVvvDLtJHj403tDuzTVh4AMTW8aK3+PpMqIrpdxzC4NRBA0mMt9Q2oYRw6fJXQQHoduJEPNr3lJ3Xzjzki54amF5nwYT4c7hYLDARJinZzq2pN2NQOnSD9ILScRfHvJyoGIxDi333ddQ66fEyCw2IbAIs0K0an5hyIlzjeSWXEmgeyfRAhHPssJRdf9Rp0KDFcGo5HVjEzr0W6B/WUTu7MTMC0VCJ3UylSRTvx3MB8JiNE46I6T788/c+K/KosbPy6TqWtEa6JkDyDS2ErqvwFEOXbfqfYPQrkol4qFGUKzf/M8UmeU4ytExISopalzRsqRpvx8DG9rZo1SXj52mEqma0NvNiP+h4OutgKI5SHUudEIqT7CbgHD3yUZcrqx/KnvUMN5KI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(316002)(66556008)(64756008)(66476007)(110136005)(107886003)(26005)(41300700001)(66446008)(66946007)(76116006)(478600001)(91956017)(122000001)(71200400001)(6506007)(83380400001)(52536014)(7696005)(9686003)(55016003)(8936002)(8676002)(4326008)(2906002)(5660300002)(33656002)(38100700002)(38070700009)(86362001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XNg17FY6YSutUZghJbrTOUQWNFsMJof4VFW2wyXhrkR0kaXuCrszDGXgAl?=
 =?iso-8859-1?Q?Nb8+RMHAs1vyXMLRq/5sih3/6UTdVDr6HL++Nv1vchRblLPqk6hSheRcLN?=
 =?iso-8859-1?Q?9sU9bDZ35JbOpZCNrc3OeXQHMzf4ove+zAJaZCTCUMaSU+/ALGurRYpJh+?=
 =?iso-8859-1?Q?wX/uYaACvahatprwxnHhISYHVLIlmnUKCqVlfZ7dGkxZhzKizcVPWAxcj3?=
 =?iso-8859-1?Q?tDzGyKLt/u+cDruWIIY6h1BQ5OSxv07hCrP5w9fmaFY8NzZfKnW1gp3yJi?=
 =?iso-8859-1?Q?aMrNtmR681OkxKWHrpMTJbGf3UTtvwXQdpS9YuRA3o4Ukj4+KWx49RsO5O?=
 =?iso-8859-1?Q?ZdY9kkpp/66LfGyNPfdYplMetBoNIKgmwxLEtxSH2b6idFNio5lqsBbju2?=
 =?iso-8859-1?Q?DvqAfSRRuxqiTcW5SHd/CEq+FSYgu1AjK75O7wnXIxYij5iFRxkUcN0hvd?=
 =?iso-8859-1?Q?GtZpkjvVNHOZoEdfnhU6KnvsAuA5ozVtQoNPKqJHVQT7cu2IKgwqiYtllD?=
 =?iso-8859-1?Q?JcHWcmKRUAnPmc8xRd/0HL8mGfz0d9tYXT2seWJMjUrdF/yQUyoP7oHPXH?=
 =?iso-8859-1?Q?KX52ANeKHDeSP+ZkiTAmjhwIaiuSHzOSCgrEkvgJBiIDZJcoGa5RYes3Hc?=
 =?iso-8859-1?Q?JS7Azy29ty4bWSn4E42WV6g0yCOVzqWUzCQKK1Q+9vmSZww+jrfLQOw6Eh?=
 =?iso-8859-1?Q?zd2ruXQB4NzN6gl5jWY5AwNxaRFphdJZ0IUf5gamRXUZJu94RZPpRVM1/T?=
 =?iso-8859-1?Q?Je2d4Dsd75za8gnJ6EUwdkU+83b9huvsisSrV9imiBGKVo3g9E6p5JGTOk?=
 =?iso-8859-1?Q?zv51DXwY/hTzlWRlZYHcE/yWBLVV6kyqIfJZg/fxs3syMFKvUfBMHp/WBg?=
 =?iso-8859-1?Q?lw+ZUjLeYoqfok3HFjeP91fMpL6OdQefvFZwgPtQoL4S6VZv+n2ed22T0y?=
 =?iso-8859-1?Q?NBEgoS9bRLKUJVnNAQ7SflkJUnxQufm8lopdxvXHqUgW9ihYMy9+OKa5Fy?=
 =?iso-8859-1?Q?zmFk+JRXU7o5qZ7hu9EJCcXHPqeWVrhtEK34BKSOzunA8WfqJGO5Aj39Vd?=
 =?iso-8859-1?Q?obHYq87BH3xVmp0v0e/iLdpOedRmNfY78WIKgQ632V5/ksTqdFG22P3sd8?=
 =?iso-8859-1?Q?JecuqWHY37pB6EvNz+3uMn0xIXh6+zE+b997DKt3vFDFDY8Ux4kN/bhhzJ?=
 =?iso-8859-1?Q?A3hQNQE9Vzo9Mw1znCG1a/ofziqbBrxwiWjhUfA5lwC89onTgRYsKh9/wo?=
 =?iso-8859-1?Q?0bI5Y9/RWzwXffKJtmMVbzaRd7xOJOOn7JSylIkosjTM7ecnJIZhtOal04?=
 =?iso-8859-1?Q?4X54/QWhYqVwwrxs0DFcQwT1tAyRSx9YHBedzI+BmCDXjrE14Ssf0l9bDR?=
 =?iso-8859-1?Q?vxHQUJ2/qb09O4sOeBjJWTWRtkw7UhSPl9uXQOHfs70M5wMeLlxbxRO+zV?=
 =?iso-8859-1?Q?xEazKgS5Xoaf4pH3tewBr5KIOrQBYedOxWHXm17r4LLjltvAH4uQnCdmRo?=
 =?iso-8859-1?Q?2MCq3BnF1nLKGN4cYusT0oJafrnC4B0CWqAQd8msfw6RUChLjzecht3S+e?=
 =?iso-8859-1?Q?DcUl9F4UaLu0mT2VQifUCSS29NORH6MIUespZzPgJLLkWwgDQ930D8MTFy?=
 =?iso-8859-1?Q?gabOzr8AF2Iwv34kAYzpAP4PPuGHLUphN7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 18987321-ae50-4d73-56b1-08dbea753fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 09:35:50.2910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFsQY+3nc9H7LjzvNAgM0Al/VF/WBFeADRPS9jK0m8QLRKStSJq5raHamJmhw0KetGtzWBI3TJLB6sJwljbVyt29Uph9MqusPV03trB3DlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6317

Hi Philippe,=0A=
=A0=0A=
regarding the enabling of xenomai-images to generate images for EVL, there =
are still difficulties.=0A=
When using the linux-libc-dev package produced during the linux-evl build t=
o provide the kernel headers needed for the libevl build, the libevl build =
fails.=A0=0A=
=0A=
The setup-uapi.sh script throws an error because it is missing the path to =
asm/evl ("/usr/include/asm/evl is missing"). The other two paths /usr/inclu=
de/asm-generic and /usr/include/evl can be found.=0A=
=A0=0A=
In fact, the path /usr/include/asm/evl does not exist in the linux-libc-dev=
 package, instead only /usr/include/x86_64-linux-gnu/asm is present (Debian=
 multi-arch support).=0A=
=A0=0A=
The build works if I remove the $UAPI/asm/evl check completely. Then I get =
an image in which the evl testsuite runs successfully. Is this path still n=
eeded for other build scenarios? Do you have an idea how to solve this prob=
lem?=0A=
=A0=0A=
Linux-libc-dev package details, EVL (tmp-r0) vs general deb package (tmp-55=
):=0A=
$ diff -r tmp-r0 tmp-55 | rg tmp-r0 | rg ^Only=0A=
Only in tmp-r0/usr/include/asm-generic: dovetail.h=0A=
Only in tmp-r0/usr/include: drm=0A=
Only in tmp-r0/usr/include: evl=0A=
Only in tmp-r0/usr/include/linux: clocksource.h=0A=
Only in tmp-r0/usr/include: scsi=0A=
Only in tmp-r0/usr/include/x86_64-linux-gnu/asm: evl=0A=
=0A=
Best regards,=0A=
Clara=0A=
=0A=
=0A=
--=0A=
Siemens AG, Technology=0A=
Linux Expert Center=
