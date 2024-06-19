Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2104.outbound.protection.outlook.com [40.107.103.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389F14E2C9
	for <xenomai@lists.linux.dev>; Wed, 19 Jun 2024 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806397; cv=fail; b=F9BDc13L16LDlFYFu/1Puen0mrpWSnzVayFEP0AQIsWpQCSJS7rjuEIET+C0tL4dGK7DOx4I/uHzqs8pSsHfJsknGjBFBC2Etp56zF9qvf8ObIujdsPmyM1JoaQwlM5HKHXT9fgu9+kXFTlZJb7CYdHd/9nPwk+/Aar03GEXTAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806397; c=relaxed/simple;
	bh=kLecWHAtQJ0BbRFIURDe/AQBtVxGnxNVQS06NbsoMf8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C62LKsPCuvHv4h0PI/+/j0Js9dauHEN6x3rI0SPl6Cq69V7mGLmBqIQ3brMpbOzEr9vjdEAmIlUFfIcm6OHpCefRbD7oQNJwUX8oEsZV/E3EG7Qheyn92uTsPDX/Kypg/sbN5lFgcrIrR69Iwlgg26H17u5/YfDYshIUBfxDH64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com; spf=pass smtp.mailfrom=fareco.fayat.com; dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b=FHgtVycq; arc=fail smtp.client-ip=40.107.103.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b="FHgtVycq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beioYDylt+0Ah1YM57fTLgy5cCQciXxOIlpIKt3UxB64Kt9GhjnhHN6N4QSPqO4g6F9g/Rjvw3ctfrD4VRg/nqWHfHlKZBYWndFIl0HT1UjWUpqJtLibMALrtayi0nFIYOgqqlAbIIUl2w+eBNo5FOBh4iNVCrl1pPsnECRrpZY8xJd7nIpaqBP3r0RSWO2NZO3m8J71i9QHLfwQ+TqrRpX8eFBD156Ytrb53HoVKqbWWYsXcvKfxsh6v9bS51Hyz+PM6RB66MYKuj61pBoUE2c4c6XRWHjZ7vu5O5dM7hYNKVGctgCyg7/CKbMRrTLxsHRCxEGD86nt0aoLBMbHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLecWHAtQJ0BbRFIURDe/AQBtVxGnxNVQS06NbsoMf8=;
 b=oPhKnSaluWY/NTnHpesaaeNZ2wOuAFSmZ+U/JsGrsS2UAOMHkh4I6tpcfUHbPo5FR8Qgv0GIPxqWie2IT91i6mntUXm79ElAsPjPbNOXfVPGo8ZKxJd6RWAPhtNEq/vq5rwOnMyA3DEY5tWs6fZHPkKRfiBg2T2MQSmL/p/DdS7ZInxfES8UmkU0OK9V442oKynTO5qDEdukIFzUJckR6IKoIzpyNqQxgg0bspx/hDuC/z0FQYBm5dFx9B5USIgm3vMZGmCg6XtbcpJ0chlKELxbvCG7RAGW6Zj9oRTlp57keFxs5r1eFzUeRgs8fxXo1XSuOldugUlO3FeNVxOU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fareco.fayat.com; dmarc=pass action=none
 header.from=fareco.fayat.com; dkim=pass header.d=fareco.fayat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fareco.fayat.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLecWHAtQJ0BbRFIURDe/AQBtVxGnxNVQS06NbsoMf8=;
 b=FHgtVycqVjus1QO0wb9k6+QYD19ZZWw26VLjWeUgFZAhf2L2jbeIaVljww+qMrlqSB9iw9eI7hJu4W2x2Lm5HYC8Fe7DdqOKL/x+pTUaM6Vn6RsfN1ClFXNPfPH9qjkLOJzIDFrzheLANtzU5KwuxDPa641mXpsAM6/YDsZX3K12jQysDcNtPF/GgUii316wYPMhmzrpuP7ELzIYkloLxedF2Qa4XrOrtEerTzozoEoolVhKaD5MFr1fh0i94aHNqoxFWu6dv8JXbOLs2suppcbBOM0xrvl9vuYtK7NutgjyMLBse5dCiPQ0RZD78ey247lcpTkfN9JySM/9OPtgTQ==
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com (2603:10a6:20b:a4::24)
 by DB4PR05MB10511.eurprd05.prod.outlook.com (2603:10a6:10:3cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 14:13:12 +0000
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e]) by AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 14:13:12 +0000
From: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: EVL kernel config on x86 only for 64bits ?
Thread-Topic: EVL kernel config on x86 only for 64bits ?
Thread-Index: AdrCUq5QrjF0qMKbQKiFC8H04gzpIA==
Date: Wed, 19 Jun 2024 14:13:11 +0000
Message-ID:
 <AM6PR05MB602449A0F0A755F035EF66BEADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fareco.fayat.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR05MB6024:EE_|DB4PR05MB10511:EE_
x-ms-office365-filtering-correlation-id: 513a0ba9-e5d7-4b7a-aa9f-08dc9069f417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ba05yFzu2BwPLOutVK3/4gA9DDf4tWSXxTu20yVj60m1oQNTmMx8/wB2Oj9z?=
 =?us-ascii?Q?9TIQzlcSxkMTifPn6oa09uVhGn5MkzaPAspkDH7gamCshtAi0mee0UBUmKk+?=
 =?us-ascii?Q?Cg64jigmRHZKIJkez4lgr118u20rG1JGp6kDqX4u9W1yWiYGu6wIFvTaFI6P?=
 =?us-ascii?Q?mMs7P9MRdKhl30+zLku+5V1ZCLxE7Nl5yeU2lKz5xne63aZf4we+JWFddm+Y?=
 =?us-ascii?Q?S3wlxv3G+Xvlirl/ldQeGjXT4O1/fpVqb3CCK3fC7/pXKL9JWkYjuyOwY5cw?=
 =?us-ascii?Q?8H99gWMOcFY1kCNmusZS8mPvpfPX8lCunGrhVgv7QGU8UgClkzELtaa0XOsL?=
 =?us-ascii?Q?5Hl3+Z2RQELZvBqQXKUCFUxXyUxlZ/em1e5ePULknF9XS5n7CdjZ9oBSx5nM?=
 =?us-ascii?Q?NFcv3t5IgDSTHQ82VnDOp3pKbWmv0w/wtxRoNhh+wmxZXf3vkeR4okSLxcnc?=
 =?us-ascii?Q?7FEF1H7qF74VP/dx/QrvFtwi2tVd/LGo1K8EBcRYHhM6xc8m50Ik30OSTNE/?=
 =?us-ascii?Q?Y/dyka/ybvg/A3iByiWJZBANHT3WDr5kmlqgBkAKahkrjhhnsSxcVk51OCNi?=
 =?us-ascii?Q?A7d4Nv1A+1xVLOodsaKiMs0j/Xh62Mb7Fo6O7ZaXx/psM0spiKCiMaKfBiMn?=
 =?us-ascii?Q?S6UwmgU4h5gh8FIBjPV100qA+FjQL4HA7SGC73UXqGUzycQpdJkha8+K5Hvk?=
 =?us-ascii?Q?cw5I/oXWM0hW8ZtTV9uhmtM+RsAHQecX7/AYK4pyITZxxv1F1iCcN6z09XtM?=
 =?us-ascii?Q?JDvb7e+9VIUUxk4D+fzMZs9xYxlOaScO6/e6H5nvV+12K4YBcPufV+htmazI?=
 =?us-ascii?Q?ovhxQf2sZOJmoT7aE8ym51J0Rr2th4kzcpvoV8UDWbz81W0iml64xrDZ90WM?=
 =?us-ascii?Q?dbjR0wZodYzFhgrOC2XsiL22JG59N5JbR16RW+ctkzM+Y/8I1zSV1HTkcQWC?=
 =?us-ascii?Q?Vzuks8sh7Ohs9d+BSAJ/H4PKH/vhHX4n6Rhgvta31ExvpJd/5Z+Hntf/51ZW?=
 =?us-ascii?Q?QlQOyQjfSeWICsRlyjCipoWuxHO2l1AzntBXT5v8ah6uNSVgNBlE9j+7VFUW?=
 =?us-ascii?Q?oCnHVNcSws8u/flSt4PhzOdFt3GB261fc4uiZk80shEc50sROrV2p+roWPEj?=
 =?us-ascii?Q?5a69Y2Nxd+uj+hz4fDPURytTasJTZ9OVdcMBT8FCK0D67QpxuY/Im/eHwy7E?=
 =?us-ascii?Q?BUAEngE+Mh2dy8OQdlVbtjqegb+td8PKIkRPzE+EFuugPscb4mCQ2h3+cv4T?=
 =?us-ascii?Q?LqnR1ka+R24fFPWAAnZYtsmhF2p1IMEiPhytFBWqzkBB3Z6ghFi3g1FJPKZI?=
 =?us-ascii?Q?5ixSOd5feOklMF9pZO5tzMBj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6024.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zcCiAnZZL3W40+VnhxKEG23XZricB3efilW6bP+jUK6dda/07zmXyrxINLMb?=
 =?us-ascii?Q?/x4nNlk6mPVErs1OhmqrRdqtyLq4K4CRarwghAd1C8e9YdN47T8hGTwvNnr1?=
 =?us-ascii?Q?NaiD+hNFg1TZhdvC7cAplAzf6n/hEXbpzE8fAY9RY68W7dGq+Uwo4g2E8M2/?=
 =?us-ascii?Q?LHCS37koLNY+NrbiaKX/RjOU7aPhmcNki1Yq3YqOaBa6uMOi9DA8Z5k52ph4?=
 =?us-ascii?Q?pYxGITt2Er3xo5wa9L6/KtVPzd3sEKJ/I/c9QDXuVr0S+s9ZCyILawg5P3DP?=
 =?us-ascii?Q?LAt7Lyu0TTPSdIQLe2K5ialjhSqAGeT7aIV04bSOe2rA5HPBDmr8tfOU+84u?=
 =?us-ascii?Q?hDrceU+A4ZI7r8zkFjkXw260en4yzG06UYuKv5LPaNeEi815Lht8De1jkCkZ?=
 =?us-ascii?Q?/toWJ/AsdqhazDHnb82ia5OW0TPbREMutjdw05TdU2UMFBcbwoFdD/7M9Cfd?=
 =?us-ascii?Q?Pn3DinsswmeIbcXCZRmBTqgRCjSIZ6iTfgNYafJA6waVddEDqIrPy8zyOGx1?=
 =?us-ascii?Q?1FjnYNt1ehi3B2Njht6ShRY266+fHJVcmHd5SNfFl8ryEY7gyHrf1SHFrapd?=
 =?us-ascii?Q?g8pPTRMyCBCVOuUJeKLGsxcQPIoT7vYictmlcMp3A24uoA5f5LRBfOTFMHrT?=
 =?us-ascii?Q?1xlLi15A5r/h6rxMKk+RRn5H/Hyq1EThDc/BPEhDdCmMqpL7zLvA6NhNb980?=
 =?us-ascii?Q?Ah6tyJ3OjJdFdIgRyNgabkzbdVhY5Zmu3fS3UJqxX6HsfB0nwS91UpWNjLdP?=
 =?us-ascii?Q?s4IYwyy44W4p7KIY4mT6vfAgqFXPqFearBSyadvRI+LwJf0QcZYYwNFr00D7?=
 =?us-ascii?Q?JHyrwiKfiGf6i93JbaQ9nIjjc13zzPrMN9K3RU4p2Q2+DL3VCQUZLMm/pFs7?=
 =?us-ascii?Q?S3z9ohdEtEm6JDPX7EazUwcA4cXJAtBF3ri+twvUbhPgEwhWL1DA4Xhav2CA?=
 =?us-ascii?Q?eK90BdPB4LHuPr4yphW4XvskElcZ55MJVYJUxn3fkye8ANDxflG8dr9zRAy0?=
 =?us-ascii?Q?I4w+Qv6xtXIGhtJyclMxMeDIvjdLu9HsRSrAUa+lYSKEBptN6zR6nYUlMAoT?=
 =?us-ascii?Q?G3lEzvvb7LdOEUeDz4sUzh4bUAgk3dAKNBqFC/6r0l7BS+ksXJgIhBTFonEN?=
 =?us-ascii?Q?71c2nAYoYnz4YGRDo4CToS/hmKlobhzbfEXUK1v+A688uIALAL6WeWtmkTZ2?=
 =?us-ascii?Q?mnUq1yZrpv1zR0YbywL2njQwgM9kYxuIIrkHKQg4WojglASwXP0lBL9u3y/D?=
 =?us-ascii?Q?h/+d4/FZu9alSJC+Pyg00btHrHCks8fEDJwQXS/JJyu6Noz7TItQ9Mq/HQwX?=
 =?us-ascii?Q?AaNO4166ZZMrYFuoExfqmNkXgvWM194FG47Jj1GKol5wby92oOE+HyIDKXPL?=
 =?us-ascii?Q?Pn1gDKaq6sGazzNf9VKgsAPhjF5zZxgh1TyRQmEQ5IwW6IdpKV3hKrq/bE4k?=
 =?us-ascii?Q?ocYeIeFKkEDu8vg9ZkrEjA4eHyqsHylA18qO/iDG3wnTnLWxKaQbUwddop9F?=
 =?us-ascii?Q?wQ9pIwQfC7lb6zWj0GSmEWfPTnoCoosoY/3Ygz4XOBGJ4eyGAnbwFrGtKRvb?=
 =?us-ascii?Q?StvEOGiFH24Fj2kIdXYV2mZZkGsjfd6CIrUIcKU1wxP7qJHjbNpQEORm6Poh?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: fareco.fayat.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6024.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513a0ba9-e5d7-4b7a-aa9f-08dc9069f417
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 14:13:12.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75428ef7-843d-4df6-9a8e-20c93eb7b405
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgieHWzKwhv0PvLVkZ+na7COStRfYgvFJI+94PKZJxLNfsdeTpZvBur53rhdl2zVUav9/KaWgwsrzRk8W3tV9CIET9CT4Dcl2f6R8Bhyepw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR05MB10511

Hello,

It took me some time in kernel config for x86 to discover that the EVL_CONF=
IG menu is hidden if < 64-bit kernel > is not checked.
Is EVL for Xenomai 4 on x86 not compatible with 32 bits processors ? And Xe=
nomai 3 would be the only choice available.
If it is the case, it should be precised at https://v4.xenomai.org/ports/ f=
or x86.

Thanks in advance,
Marc.

