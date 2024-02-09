Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A64689
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479648; cv=fail; b=pKoW0lmyA42fQIN+JWVly07Xn4x2PHiDvX7Xr4hfiy52oRCyDrtF7PkkPon/xJrQN5gyDnO8CKQw5JR46I1Tf73LLT9STSLE/4HZ9pQgidrLnC/JUL47Me6LhwOKajf8uRvHzmva5sV9XsIEsQn6sP0896NiFvmL/w3aiHdyj6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479648; c=relaxed/simple;
	bh=0puPLZSw9CJp9FwSdJnfkzoUPaU8j0tIgDsD+LG754k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eqABAlvIQUK06eVPdaQLvOOEk/+Xkwhif5bSLsKchXH5cRBfEkyUzRTjk4egnHbBqZPbKWABDsQ9Q+UuwMHxoHvL1YH5u6O/atunzKcc0NBVx4t2b5F2cdivHv+K4Pd05sbZZlWLJK/OyyNrb0GqpwzRE0di1eZN8B592qFUrCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ePrmLJ9c; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ePrmLJ9c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQy4AbD9a63yWm+dga3DDYy/+FUhU0/9CURjT/BD9XaLJZDhPdjcuF5/ns7ZHxl7SrsMLIyCJKf716iXtTSGMtLfKIwnhl5P8oMA2RNNvfJRqHs54P8r9E8awp12LSg11IEO+yU49hlDBm2jexeQGE86VNIA0GLwqerI/r/7SMNs0RlxMLch0o/7VyKiBthuLQcQqu0ANr0gqMvRE62Ha00DdkX2Qyfjg8TIteMw6DlRkkva+gIboi7eBESFbmfSbdWHbma8zFbBo031HH6nBhDbBIwesNXmx2mugP72v767I0OTo6GBm4JLZ5j3vUpBDaIb8wxyAdbq2tLhdmMQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0puPLZSw9CJp9FwSdJnfkzoUPaU8j0tIgDsD+LG754k=;
 b=LbfAIBtNnQ2L+opn+TywYo58HO+8r5HWeMBuzZWnFdH1X55W7c+0fUqy8mC4ppReLvotWWzPDWqYTv8Ds9KbhfOfVoB9A3nnR4Idl+8NwqYyRjIb7G4DxQwiRKjoThfoOgpqZ69C9IMcyLIQ5EEJXZMv/rLeYh326SgpiF5wwIwhrvl66dKa5/0kCc/gs3LXodXOMQq+r+1aktd3eHvylf/mq2OSAnkCoagtgGfI6laeaCQ+K+pVlssFkgVEQG3lTuESj113BuSaEt2zNG9Ns3TE07PUVi0wHN6Do17+fE7XWYNnn7u5UVjuL5gJRUbUs71kC0d/x7MBfeScbfVwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0puPLZSw9CJp9FwSdJnfkzoUPaU8j0tIgDsD+LG754k=;
 b=ePrmLJ9cT/y/gZPZCk6tHL5VAU+YYABMTXQJ7+d+NzNPLUZyuszGkV2/XBMWHdFf75NJfwqBU31Rp1P3I8FjbkpfAJJjtMdXBNh+rUnvRHmHJ9nEQtLd0YFoLmktzD2Y1umfarYcrtlrRVYBpaOLbxW/qZVt1wDkWug+5UnKph26p8SoYX3vW3DdV7Tfc2QvXgcUwGO7zGjm3IssrEFCh/nvHyOtr4/hNVE0zYehMUEC6ULzy/pV9kd53zXp7JA1Omelk0R3qeCDc5pK3D8gZP/ABWgNC4/Jd92m3Hl1uKMKWz9SSf2WAx+ev4fanTkhh29wHLXO9Cx9J2/VqjTK1Q==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by AM0PR10MB3617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 9 Feb
 2024 11:54:00 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a2bd:dabe:eb07:3667]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a2bd:dabe:eb07:3667%2]) with mapi id 15.20.7228.029; Fri, 9 Feb 2024
 11:54:00 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "rpm@xenomai.org"
	<rpm@xenomai.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: RE: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
Thread-Topic: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
Thread-Index: AQHaTUxEavch/Cz+XkKxlKfvgVViibD+5CIAgAMSOBA=
Date: Fri, 9 Feb 2024 11:54:00 +0000
Message-ID:
 <AS5PR10MB8173CA6F0641BEC789CAF236934B2@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
 <CAFLxGvz4f2Lwv-+NF0sqF+MLTguqDX0YAFJuV7JQgMvf8y1f0A@mail.gmail.com>
In-Reply-To:
 <CAFLxGvz4f2Lwv-+NF0sqF+MLTguqDX0YAFJuV7JQgMvf8y1f0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=435530ac-2eca-4901-972b-86361c3506c3;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-02-09T11:09:39Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|AM0PR10MB3617:EE_
x-ms-office365-filtering-correlation-id: f60a9d44-eb09-4274-c6b2-08dc2965cdeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SOjYuiF9FnSRzmPBshoAFkG55ytpBJ2ka+rdBaYFGq8DLMN7itzjrJrk+OfTanCh8VP1eIMVl5cTZoxUCDkVpkM/Dd82G9L5wgTeF1xf/xpuKcDgn1vIu7R99rJ7fbaPj2FaQF6rsN/2RoSisOCO6IqRnymrzzENQ1EduTQEaHMK4GGhMMY3q2i1I+se4EuJyefNUKpotTbFkiBAC3fWUVuon0LLV2MslvLYAA9bK3jfZlcpLQVRv6uhkLBKyhF0QscjhygzFkRxBcZunFyCalSkm00gUrTPpcH0H3aqsRPoyt6VJcxMpsKa4cjRp3+xYMnhx9U5dVdon4q5OGDKmky5BkXZsgj7LDWKMJB2dRCrvgc5exonoBivLA7JZMMFB1oUo12jRj+aArfjIk5fUWWq63T8GihOFG7b69iQah2AZ4X7+IT2fNiwPakmntRxIwlyqlnPch/9hCkMKSTytpeeOoLz+y3j3tCD2eKQe8KGI8I/LQgrxUop8pzeB9RImEW72+PpaXZ4oA8+OP1LNEQUGy61y82jnhdQYH/auMkaRIC8D0krE0UHel4qGcrysxYRpzjhcrkQm62hFA1PbplKmMaex48xNwoyJUX2/Qg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(38100700002)(38070700009)(7696005)(122000001)(86362001)(6506007)(71200400001)(53546011)(33656002)(9686003)(41300700001)(107886003)(82960400001)(966005)(83380400001)(316002)(478600001)(76116006)(66556008)(8936002)(66476007)(66946007)(55016003)(6916009)(54906003)(5660300002)(8676002)(64756008)(4326008)(52536014)(66446008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eG1JTXRxbXNPTGJZRGlGL1krelc0Q291L0FSbzdidVRCaHNHMTR4WHNPTmRo?=
 =?utf-8?B?ZjYvSld2SWdXbTlqbG1DM2pJL1pNSS9uN05tRmtMT0NTYWVDUzlybHV4WmNx?=
 =?utf-8?B?MTJZcE9QQWxDeVA2d3lnSEFuS3J4ODJMWk02TzVEc3JDSXJRSUk1anBncU1s?=
 =?utf-8?B?cGJJSTY0b1FNazRnSUxxMllpSDd4d0sraXVjKzFzNnpLd2NuRlBQeG0xaVBh?=
 =?utf-8?B?UWY0L3U0WjBTQkhQYnRmL3pEZU9oU25sVHZOeGtjV3JJU0IzRUxLWkJBZ2Vm?=
 =?utf-8?B?TVVBWHNhbExlMUlnTDI2bERtcEtPWEhUWXZ4Q2QxcEJGUjBwTGZQWFNobEZN?=
 =?utf-8?B?aVpiWXE0SzByYXdwellzdXBnWUhnV3ptakY5UXdyQ0hMVnpPMjNnNXlTYU53?=
 =?utf-8?B?Z0QxV01XQnFITWYzRG5OcFZ0cUQzbDNXS2pRdzVNY2JJRmhrMSs3RWRDRU1G?=
 =?utf-8?B?N3BSMEN3akdvdmd5aDJicUlLczYwS0lEY2VaWDBwYWE3S0JXYUxUUFoydlhU?=
 =?utf-8?B?WWJqN20yc1VpMUVMRldMUU84blV6WklraUszOTJiOWZJMDcwNnJ2ZS83dlhr?=
 =?utf-8?B?dGduTWEvL0xRWkN4cTRRelBxM1JVRHZYNXgwL1JjY01WakhNL2wzY3hyK2Fk?=
 =?utf-8?B?RU1rSUxhbjU0a1pCajl1WENFckxJOGxlMVlsRkRuZnRxcE1qZVY5NjhTY3U2?=
 =?utf-8?B?NkpISHdqRGFwWXhFdWFYbjNMU3EzYW8yVTA1anZLVDRJWkhkeDZlVnF2VTd0?=
 =?utf-8?B?NDlxQzIyems1VTQzQ2M5QTJJbU01aWw5T0dERCtTZGk3cElYajRXVGorL3cw?=
 =?utf-8?B?YWZ1VmdUQWJ2cC9BR1B3VHhwUzU2T3Y1SWpyN2V5U005SllucUpxZ0U2clpt?=
 =?utf-8?B?REx1T2ZzbEMwME1nTzd6SGltTnlqN1pFR1RLNUxjeUJlbmFCUmUwR1ZocHh5?=
 =?utf-8?B?VU5hSEJ4R3BsMHNhN0pkUUVFeXpTcm5DbnlDZUFlZ1hJZ09sMVNDQlo3Mnhl?=
 =?utf-8?B?YlpaYnI0elAxMk9lMjhOTGF4andvN1JGNWc4dTlrYXppeDdRVzNUd01IWG1n?=
 =?utf-8?B?UEdIVXE3aU1KS2Uwell5SEFnekZCYUZ3UjJqMVEvNHdrSmc1akhnWnQ3S1Q2?=
 =?utf-8?B?QlJVZDdwL2hIZEpuMFpsY3k4cFVJYnVHelR1cXVUbWVhQmhDSmlFS2pWaUpB?=
 =?utf-8?B?cjZYdy96dTlJRERqcThNanV1aEtUZzRrSFBJemplalBHcEZuMWJodVd4QnR6?=
 =?utf-8?B?T1p6Q0tvMHV2SUFrU2poYjZ0NmlFWER2ZFh0aHRaN1FVZ3pyelBuMVU2czEr?=
 =?utf-8?B?OUxEdStLdUFySkVaZDU0emxPOTVRa1EwZUljVVBvWXNBNDRNeEN2dEVOVXdq?=
 =?utf-8?B?RDlUUm8wV2I4Z3Eyc09PMFc0eGhXSkx3U0J1YlFDL0JPUmNGdjJLazc2bUpM?=
 =?utf-8?B?YW8yNWZxUFJENE5zaFNibzVyTjc1N1FsVHRqcnhjVmdTWEJ1MFora3cvVllh?=
 =?utf-8?B?NkdBQWZCWm5PRUhOOFV5QmhUc0hPQUFRMS9rSEk4a29hb2s2S2RQd1RLMjQr?=
 =?utf-8?B?OUluY3dibSszMzdHdkdKeHE1WE1HbzhBcFV2ekVSKzl0b2E4K1Y5R2JyYjJx?=
 =?utf-8?B?ZnlVWDM5YUZhcUNLYTNZNHp2K2FSV2o4R0g4ZGtaTUk2WG9uSEsyUUF4am1F?=
 =?utf-8?B?QXlPZitxQjVtbENNU2tYOTdyZ2lUKzV6bGE3Z1BrbEQyTEhYdEhCWEZxWHpu?=
 =?utf-8?B?WXVzMFJEaGt3OXQ3OE1OQ0NNdkU4OWVweUdjT0x2L092VFM2S1U4YXB1RXhM?=
 =?utf-8?B?NjlkNzF0OHJVNlljNVJwUGUwc0tSWnlFSG1KODU0VEFCNVA0Y0tpMVUrbGto?=
 =?utf-8?B?VnVTaWVOMzljNmZBeXV6Vk5HNFR3bWlKdjNLSlpKWmtSd1lSbEY4bWNjUzds?=
 =?utf-8?B?UEdrbkFyT2t2WDg3ay96NnY3QlQ0anQzQUpCYk8rd3VndlhnWEwvZWtKeGpM?=
 =?utf-8?B?bWZNcXhVQUtRK0phdDV1NG5taXBkekxPNkl0alFrTEUvT2NpUmJBK3F4WjdF?=
 =?utf-8?B?aXJQWWR0YkFUZkNNU1lMQlhBMFVxTFgvcHorczgwUm5jSDkxY2twMlVHMXJz?=
 =?utf-8?B?ZktxbG1lcmR3VGFTWkhrNWZaU1ljbWU5aDRMUmpndlJlejNYRm11aTZLQzhv?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f60a9d44-eb09-4274-c6b2-08dc2965cdeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 11:54:00.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Vy8h1BhgN7WFhD8M5HIOLG90bjBCUX/oGzRRAZIBmGJK+SFB58z2RqdpjCAM9GeodiAvaFXq3novurGYa2EhOHtcJPCU+NtCCDvr9cxfzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3617

WWVzLiBZb3UgY2FuIGZpbmQgdjEgb24gaHR0cHM6Ly9naXRsYWIuY29tL1hlbm9tYWkveGVub21h
aS1oYWNrZXItc3BhY2UgYnJhbmNoIGNsYXJhL2FybS1jb21wYXQtMjMxMiBhbmQgdjIgb24gdGhl
IGJyYW5jaCBjbGFyYS9hcm0tY29tcGF0Lg0KDQpCZXN0LA0KQ2xhcmENCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmQud2Vp
bmJlcmdlckBnbWFpbC5jb20+DQo+IFNlbnQ6IE1pdHR3b2NoLCA3LiBGZWJydWFyIDIwMjQgMTM6
MTYNCj4gVG86IEtvd2Fsc2t5LCBDbGFyYSAoVCBDRUQgT0VTLURFKSA8Y2xhcmEua293YWxza3lA
c2llbWVucy5jb20+DQo+IENjOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldjsgcnBtQHhlbm9tYWku
b3JnOyBLaXN6a2EsIEphbiAoVCBDRUQpDQo+IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYxIDAvN10gQWRkIDMyLWJpdCBjb21wYXQgc3VwcG9ydCBmb3Ig
YXJtNjQgdG8geGVub21haQ0KPiANCj4gT24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgNjo1NeKAr1BN
IENsYXJhIEtvd2Fsc2t5DQo+IDxjbGFyYS5rb3dhbHNreUBzaWVtZW5zLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBIaSBhbGwsDQo+ID4NCj4gPiB0aGlzIHNlcmllcyBhZGRzIHRoZSAzMi1iaXQgY29t
cGF0IHN1cHBvcnQgZm9yIGFybTY0IHRvIHhlbm9tYWkgMy4NCj4gPiBJdCBhbGxvd3MgdXMgdG8g
cnVuIGFybShoZikgYXBwbGljYXRpb25zIG9uIGFybTY0IGtlcm5lbHMuDQo+ID4NCj4gPiBCZXN0
IHJlZ2FyZHMsDQo+ID4gQ2xhcmEgS293YWxza3kNCj4gPg0KPiA+IENsYXJhIEtvd2Fsc2t5ICg3
KToNCj4gPiAgIGNvbXBhdCBzdXBwb3J0OiBjb2JhbHQ6IE1vdmUgMzItYml0IGNvbXBhdCBmaWxl
cyB0byBnZW5lcmljDQo+ID4gICBjb21wYXQgc3VwcG9ydDogY29iYWx0L2FybTogUmVmYWN0b3Ig
cmVnaXN0ZXJzDQo+ID4gICBjb21wYXQgc3VwcG9ydDogY29iYWx0L2FybTY0OiBBZGQgY29tcGF0
IHN1cHBvcnQgYW5kIGNsZWFuLXVwDQo+ID4gICBjb21wYXQgc3VwcG9ydDogY29iYWx0L2FybTY0
OiBVcGRhdGUgQUJJIHJldmlzaW9uIGxldmVsDQo+ID4gICBjb21wYXQgc3VwcG9ydDogY29iYWx0
L3Bvc2l4L3N5c2NhbGw6IFVzZSBzeXNjYWxsX2dldF9hcmd1bWVudHMoKQ0KPiA+ICAgY29tcGF0
IHN1cHBvcnQ6IGxpYi9jb2JhbHQ6IEZpeCBWRlAgZGV0ZWN0aW9uIGZvciBhcm0gb24gYXJtNjQN
Cj4gPiAgIGNvbXBhdCBzdXBwb3J0OiBjb2JhbHQvYXJtNjQ6IEVuYWJsZSBjb21wYXQgc3VwcG9y
dCBmb3IgYXJtNjQNCj4gDQo+IEJUVzogRG8geW91IGhhdmUgYSBwdWJsaWMgZ2l0IHRyZWUgd2l0
aCB0aGVzZSBjaGFuZ2VzPw0K
