Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992FB21129A
	for <xenomai+owner@lists.linux.dev>; Tue, 20 May 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774657; cv=fail; b=CVsEyiM2Js9E7PneRPu9PqQfoFDOVFasdDX9Tz1i2dJeZqViQv6LESBjaFFF2Ng3o0KklVho5fgobixLhkhGWc5gNbZS+4U/Yy59DyKPIeJDiqJ+Dy/J/Xxesv4cbb0ff46u8wJqgU8bKxOO+ZewtOQuPZlPS7kxISpNVNp9Fk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774657; c=relaxed/simple;
	bh=q5CfUafcwKaHH36gJkaGip49hD+n9Bt2FL8kr8L/Hbg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B6fKu5AOYvyKGVkhGfr5Dr6y9L8pRzWoCKLnJK1FxJbgoNwAj6EhxerKdAxMsVGZq3hwZjiJh62x7XSNbR4p3IuYO0tz15HzQ22v0iNuN+0dXP1AAHKhcNJCxfB+fHBQYKLJMsNa3LESvPrgWsbqhbwVHVUeOvbzbZWWTOg22o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=ww77sYuD; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="ww77sYuD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz5VRuFgGKEHCOJHf30Xe5hdHsFDQdn89/hLG4zi+hgxcxzaeuaBRQNnTgoarAltd67SFhF4y+9EmPABZpeduS3w3FKKwcTzPnOvTaXT5Mvj8sjkQicumv+tvvZY9rbpBTTEfMX2oQs35XcrApoSL2bHPPKv6Z2ah4AxnoRXXcnaE2i08cnB9GK2vR8HMtHVuU8M4sOp+kEOfdVXmLfnMSgaQYvRC6/O0NfeJbqfbhzBC4GoqZhbW0lk//HBhxeJJl2aWWfGP8976OfG/QCXyqjodISGjiRj/TJLyeCUZf7VkXbZdszeQr6KaXvVDkVFoCUweXEtyvKs/M72oNLJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5CfUafcwKaHH36gJkaGip49hD+n9Bt2FL8kr8L/Hbg=;
 b=l3fU8iC0odLWcqGm7BNlOWTaSXw0ELB7fwSzxcDevHVsV0zJfKpWJ7GFPmcqH24RJuISTA3kVpeLZfibrigparIswwfXNVRXNs0inoT5Rq2MYw/jVRyr4vdM+PF7WWUHtyKn3klAh30el12HJ6X+8ladTtQynSc3GyBVoBM4CZR2OEHSQVvu97gtrnM4VT/ED14yWO6AgLva+TAROmabaZ6W8DEoNaUgZqjwQIvcP/m83tkyDNwMhqshfNhs3llHZoXs1bnMaxmOpJ/I83xyEVWVbqsB6fRZOqvgEf61mSpwCo4pmbCBbCF5i44AmEg7GuYjWDdbnrPHBXRvWnvEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5CfUafcwKaHH36gJkaGip49hD+n9Bt2FL8kr8L/Hbg=;
 b=ww77sYuDKZcAOQrq8uqGkjFF2keQ20wydEavxEmm31NHJA78FVHho6xTXTFS0lviOHclbP1LWH6bUh/2Jic6/6rNFYvIUGcPQhqx3knUQpzr5pVn82GVL/YkdOXy1YLgvUo8FX/7G2tFktocNKbroJT2KuEoqfjIYk9fkgsSS58=
Received: from DB6PR03MB2888.eurprd03.prod.outlook.com (2603:10a6:6:36::25) by
 AS8PR03MB6888.eurprd03.prod.outlook.com (2603:10a6:20b:294::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.31; Tue, 20 May 2025 20:57:32 +0000
Received: from DB6PR03MB2888.eurprd03.prod.outlook.com
 ([fe80::192a:52a1:cd30:67ff]) by DB6PR03MB2888.eurprd03.prod.outlook.com
 ([fe80::192a:52a1:cd30:67ff%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 20:57:32 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: "xenomai+owner@lists.linux.dev" <xenomai+owner@lists.linux.dev>,
	"xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Problem during Building EVL
Thread-Topic: Problem during Building EVL
Thread-Index: AQHbycnOr4O9OLHC50OBiAZEdEdVhw==
Date: Tue, 20 May 2025 20:57:32 +0000
Message-ID:
 <DB6PR03MB2888B94A5AF1E5A82DD985368B9FA@DB6PR03MB2888.eurprd03.prod.outlook.com>
References: <1747773370-2401-mlmmj-02a615cf@lists.linux.dev>
In-Reply-To: <1747773370-2401-mlmmj-02a615cf@lists.linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ActionId=57443b5a-f6e7-40a2-a614-42e3ad4fd5a8;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ContentBits=0;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Enabled=true;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Method=Standard;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Name=Internal;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SetDate=2025-05-20T20:56:01Z;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SiteId=a1ae89fb-21b9-40bf-9d82-a10ae85a2407;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=festo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR03MB2888:EE_|AS8PR03MB6888:EE_
x-ms-office365-filtering-correlation-id: bd435e51-d665-466d-be13-08dd97e0f095
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z+SM9VjCbE6IDvI0YiSUd0MBO5vk1MiBP4BmwrrTrsXssa4ZXW53A/Lf3lNp?=
 =?us-ascii?Q?ak1RHKXP2EcRT/74rFNwK135x2RCTHRjgJQgGo/g+Op4XbTBO2WHg/zHGX1G?=
 =?us-ascii?Q?m0EFQFIJpNubFDsRFpwQgVZo4YQfOojX8s+5A9Jw97hzMsgUGs7rBbyOy7tj?=
 =?us-ascii?Q?hd2ynurwpXYWL0SNr9bat+oF91RksNcplts/oS7xJ9zTWSYGeuw0hBsu7i5B?=
 =?us-ascii?Q?+rF266LRsiazqdHsF3wC0VgjYZfHGr+5q5Iji3p6Vp9XlAzIUqw8rk7SlLa9?=
 =?us-ascii?Q?jN28/RGqoZP4zDY9XEi06J+PiYZnjAP686zZSx3dgM1z7x3vuQJxIXJl44BK?=
 =?us-ascii?Q?MUhTR6kZc3KWL6qc812ESfzb1RZRxO0Riw/iqhgZvTy3vn5YuLgOwfAW+5UK?=
 =?us-ascii?Q?bjxI308Rt+PTsuqSDR5+m6DhwnyeDLlKqBjbKxfHVPNX0VRQ+RIUSclMP+Q3?=
 =?us-ascii?Q?06s+HvV0Que0Y64TQ1TI7cmH1vieakMnrrZ/bzBvFrkh7YvkalzUTPxpcJm2?=
 =?us-ascii?Q?nI3unyZjiJqpKwmEfvevLmF0evdoV6K3modhRDZT+Bm+FrhEvV82dcKUeFPQ?=
 =?us-ascii?Q?bJdlL+ClYS+djvNNh/G2PgEtVNt8ms9YY8jO++B3E05gQBmucL20Q4hvBf4r?=
 =?us-ascii?Q?lLfNSntbBBUGFq9rPQTWdc279iRoEdtPj5bjZW0sQhKCr0lq3n13jX+uQ3hg?=
 =?us-ascii?Q?uJ24scC+Ub/W+cgC1ZKTNJNa8UmAN7FlPvldb/h2wJny83cU5uvjoM6Us1o+?=
 =?us-ascii?Q?MvfZTVyreQvRE33S98tKTwXjcuX3yk78vlCzqhbzG8L9JTWh5SfE1CDQPAOZ?=
 =?us-ascii?Q?ff81x/pkeKxce6U53GUlrst4/ZpihxFNw3gjUC5AU6yUETQfxXKUwYMvfIoA?=
 =?us-ascii?Q?h1VroGpdkG73j2q1bbWw4ZDNCuyU05QC6ZE3ZFbjocpTqgFKBNr6CQqAH5f+?=
 =?us-ascii?Q?sOIpVWvWVyBMO13JBkIWn24Y+WiN5a8qPL5ED9vPjhB2inLrZq9tDIY+CXlE?=
 =?us-ascii?Q?DKWeqvsF84ADLBL2FQHXZnTQkv9s8irF5D7m9HcMg1beqEEDqW3URcGnRJPC?=
 =?us-ascii?Q?DYqG7/AdUqI0ArfSMDP5tFEmkOquTU22BQRI8MGNBsvlTHXL5g7JMl+i7oer?=
 =?us-ascii?Q?q9Fcd/N2BZYZgoYTjPodSr6G7WpgRXZmEsrcG/eDYuuZTl2RF1e7y0kA4B1O?=
 =?us-ascii?Q?7evCrwIQ8vCphN0iWN/ek+PkgAfL1PeLlrdBbUqh01Rj4LOQb7bCAam47i4a?=
 =?us-ascii?Q?iNtUZ6MaFFh/2eN3E0H87Q4GM1KQpm6uhI63DOCCmmHrzS1g+aIE195SdvHZ?=
 =?us-ascii?Q?lxUr3C+dyA7MP77jkCmKhVJcOoR5Atd+/dhyWZgE122ElhpqRXvLXx4rLI2Z?=
 =?us-ascii?Q?cnDozG36NHXHBpOWGEXrMGbfg/G5ftczcBkQcLor0tyE6cdb60VMIJyzmXLB?=
 =?us-ascii?Q?DrBikwGJw3U0uXUgnLkOaKucN4da+Nb7sOINapOss9p7QRpWF7pz9A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB2888.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tdpZ3GOmuPPlJXisuAJm0t4+a37/Uus+fZxUS+IFclvdBl7UZ5uOVz1xmPqM?=
 =?us-ascii?Q?OmHQwX3iUX5cE/hHcpSzsOI7kuBXejZ+jBg2wR9z1bHR3r5XEKChngnUiRvc?=
 =?us-ascii?Q?PSVH8+vHcEssgMMQESEcno0a9Fj1ZLe0RodccU0fOGT1bCHe7xQww+wGu9nP?=
 =?us-ascii?Q?AwQq5v90qYeRt+a945AJIooyMfyfE46rx//Q2gJvOlf1vWahiV9p9MUicGz8?=
 =?us-ascii?Q?YLdFNt0crcHnUdtBGugC0WCsqIRXekSTqorPp5LMoxVEOolMF/63ZfylxKY3?=
 =?us-ascii?Q?IC4gfJ1rWIZpeNMoPNfrhqi41ALjzUn5sCTIZwCwMeQhNwO8o2nqSMP1Nlxc?=
 =?us-ascii?Q?bHXZHWjR0kM2Acr8QXR4Taif3cmZzdeG7yA2OARQ4eKaMMvpi3ACRAG6vcyR?=
 =?us-ascii?Q?ZUOQo++zOj59xICoSKZXxdgi5/vU0pkio3CDXiaaWGOWOXLGCT/kzSwox0+L?=
 =?us-ascii?Q?FpFbPlqVuQYQnZ29fhV8FoXJw52I1Of088kZcWcMD+pLV619t1m/r9s5Hvh9?=
 =?us-ascii?Q?Qk9hmGVKahBB3goqAYCkzGmi/GyHCh95cFRBRA1BLOMit/G9c6WnTVfDLLCP?=
 =?us-ascii?Q?PdteDmxzyPakEyFnvSxjoUL6x7zM4QDKnXYhue5IGDFrmclj72N8pN5VocqI?=
 =?us-ascii?Q?Y80aLWDt8zcpsAyr+ScoxTZXCMFFvNwtizu+bWhKbfUiC8fsmi/ni+51AGch?=
 =?us-ascii?Q?tT3XapzU5A4hKmnFKCKC9B8Ee+Oz6yWU3Jvi623NsH+C1Jm/Ec2TCfu93p27?=
 =?us-ascii?Q?RGH4tba9h6DnBCZ6dfmTm0TbKduxGn5N8ZKqcDXToPI0oy03+1WSFC75dVPw?=
 =?us-ascii?Q?m6ZBD2ENVnLk6xSNaU4uF7fs9BmTg8NDnLLbW9LakPSbu9JmWJWT8fgqcDG0?=
 =?us-ascii?Q?k54YWn1B4g5R3rxWk4PggFed2uPaF/mlI2nDPrY2H5FKXIiyydp0WnRF6olx?=
 =?us-ascii?Q?hhXIwpDlNCf5QgBjgHysjoobpgrX3zxumL5rL+zAisf7o/9jmut2Q29IcUX3?=
 =?us-ascii?Q?VoL3GMbSRj4Ie2Osyzf9SX+CUl3FJTX4QUXHwqa/GeZlO/0Nm9eTE72WnVYs?=
 =?us-ascii?Q?WqcGxjHEjgjKkCJQllt4OYQm38V1OvGSI5YNarHPgukd5oamd0diywICgSOv?=
 =?us-ascii?Q?aca1XooMSNKzXfRhjWSd00IPbTJA7TeXmLXet/tZktL9nNRCKWV3ZwEX3Xu5?=
 =?us-ascii?Q?djD6WZpmbs8jkjeC8wuIKKQdgzMaq0XUoQsuyOQFZiNWR3+EQ09JDQTNYixV?=
 =?us-ascii?Q?TvBT/AIHY5wdH6yJp2p64qqWDgnvYgkRVEkt82HR5U+faL7n8oI1H4QsPRZD?=
 =?us-ascii?Q?g3icvu8/gQneL8oUlBuF1HACokzPpc+5MIJjVcYc6IMx2dIJqmEIYwVV5DdW?=
 =?us-ascii?Q?a1Y5kBdg6p3b6CJ53u8LXdwMU0WdqeHqjxsu8SIBfb2G00/oHqX1sOfqB5m3?=
 =?us-ascii?Q?yOOhnJjRFExxmVrGdvNxGd0nliQlZqe5Aw1/jioqyYdexiaWetYAhA0Tw8Jv?=
 =?us-ascii?Q?CcpH2WX+uKhuYP4y/Wk5Dd3iKMAYjxkxg6CtI05+shrbb/rqrg0wc4f6Q8im?=
 =?us-ascii?Q?ZR84/dBqDUu+ZOKlMhY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: festo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB2888.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd435e51-d665-466d-be13-08dd97e0f095
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 20:57:32.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPOfU6fuGv5RCjGp6IeeLYvbtmbZYYbNxHUPbkxp/sRIgh49VeDGee8hOw/R47/SNqQ1rGJDQ6wkXABJP7zNXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6888

Dear developers,
I am working on a project which control our motor driver using Linux system=
. This will require a real time system, so I decide to use Xenomai4. I can'=
t find the "Enable the EVL core" option on configuration. I can't find the =
CONFIG_EVL_LATMUS and CONFIG_EVL_HECTIC enabled either.I am using a ubuntu =
22.04 system with 6.6.0-060600-generic kernel. I downloaded v6.6.y-evl-reba=
se for this process. What is the new prerequisites? Please advise. Thank yo=
u in advance.=20
Best Regards,
Nick Xie
