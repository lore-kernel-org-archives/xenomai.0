Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022137.outbound.protection.outlook.com [40.107.168.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328148A8DB
	for <xenomai@lists.linux.dev>; Wed, 19 Aug 2026 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157446; cv=fail; b=PAI/pYGjL1obhwbYfzmw5KH+g9q5KM1UcmIunX11SIDhoNojn5dIEzXSGKu+trv/ChcOvYra0O5dA0/iMIFGkfZfN1dBr7oWu/S11f9bJGEkELrFFiRGRYfPP2V8FXOFmLe/A77do0qWo6hic1mmxTNEabkpMQDETmoQ7SmlSHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157446; c=relaxed/simple;
	bh=5/xftijq25CtyuWVH3EYWFeVNtetbgUytWYgJkN67s8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gyceG/E11ODApUO9ftOdMNk9Q5TXfChlPWbnMMSSE4BYVzkLep34o7GZXpghibByLaDs2isZj11I3VOiG1HK9pKdZ+6rD9fWtfMq0Ca6lywwy65TRaAmxV3rI5uLHJodaEjn0a0VuqbvYto87Dst+d2vey0CEIhAe/imDA/x+Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=heig-vd.ch; spf=pass smtp.mailfrom=heig-vd.ch; dkim=pass (2048-bit key) header.d=heig-vd.ch header.i=@heig-vd.ch header.b=IHShNrpx; arc=fail smtp.client-ip=40.107.168.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=heig-vd.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heig-vd.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heig-vd.ch header.i=@heig-vd.ch header.b="IHShNrpx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBGnvYu9fTtdO6Zf3sa8Bf1vwbmom+gSJKtt0qqeYJ8qNbmf8OgcYBUjd1k3eLg91tm8jA6DLyTgOp5Nuc0qp6VN8VwzDalffJQGSGxXrMS+sLXB6bpxm5v3wi5Azq48lEEqm5laLRcDpd2AH7WvJjuuLcT3/nVqCcrTz7VlGmM7fUUGLfR2zdUbPep0UiEAK8C0nN7azPDOxKxcZ70GhjcUr7huFTQbhNSVr6ySEJBV5luUngRdudQV3vi9LNstsdqJsH9GB6xxNFav6J5I1AH375FOR4Ygoe2wp/YXoeu61F0WMmI4BdzDMYd/pFq9Zm68XxtGYQl7GeTfv7HtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsLktu0TPPXx6PJdAw3iq4cLn1LqsLG6TJjTFjTcKWs=;
 b=R63LTuh3dlRDBh/Kt5WgxbegYbeF1xf5NiGzkaTtz6aqF5FD+YrL0V4FkwIcCmyLcsh1EtVuU0ECW37UwsPwQtKXkVin8ICUZEgpkY/4yiI6ZhPnUHpXACN65RNhaiWyXqetUl3oKowSB07Uer75QAjUk8BPXeNqwDuZnkZd0Rbb2xeJhfsrtsGfQ6alhYiAk2ivtYBkxl3TzdMpDOnPMK5pBMZHYERN6ZFY68Ho//9qd6/a5BrYakB04gfvO917B+Qi9OeEmfXhCR1Ypr90aYN2hXSP8Pe6YjwgzJv3aqTW3tWb7w7+UXcAU2ZCM/Hwfwj3mH1PKXZdufp7VHfBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heig-vd.ch; dmarc=pass action=none header.from=heig-vd.ch;
 dkim=pass header.d=heig-vd.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heig-vd.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsLktu0TPPXx6PJdAw3iq4cLn1LqsLG6TJjTFjTcKWs=;
 b=IHShNrpxjv6JZDhncn46UjS0dNzhfhRem8kdpyxXnv8GVXi3cUcvDX7QSe7oZSH3r98qUKg1TPs7BZ15emr/vPe2kJmPEJGk6pgNeC+X40x4BMDZbTjaJXLd055r0NTMIghga7IZUuD6Phx3nXKoZjP90vHDAlPAmxJ1ljSnMVC1rNaCxrh8z0tykHPXR4yuSND4Bc6LvHlVYLHJhk7rSkr3f/IPkHsgr+ZQDU4gykV0lCBCkb0a3J4wVAoUC2iRLGpBMrh21P0fDx04jXhd/aCxSMQLh87P2UwQiTsm8h+D43fmQ7Cl6BzZCi1isQ0McXywopiqSGXMI1Qbhb0+/Q==
Received: from ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5b::14)
 by ZR0P278MB1630.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 16:37:20 +0000
Received: from ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM
 ([fe80::255b:c033:72ca:da2e]) by ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM
 ([fe80::255b:c033:72ca:da2e%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 16:37:20 +0000
From: Brunet Yorick <yorick.brunet@heig-vd.ch>
To: Xenomai <xenomai@lists.linux.dev>
Subject: revl + timer
Thread-Topic: revl + timer
Thread-Index: AQHdL/eyVjW5dOuYdkGTP4omKQ5xjg==
Date: Wed, 19 Aug 2026 16:37:20 +0000
Message-ID:
 <ZR1P278MB1040F902CEB569D53789E125D2A52@ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heig-vd.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR1P278MB1040:EE_|ZR0P278MB1630:EE_
x-ms-office365-filtering-correlation-id: 3b6c79e2-85c5-4a24-f767-08defe1023ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|786006|19092799006|1800799024|23010399003|376014|366016|18002099003|13003099007|38070700021|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 DqxbL4KodKLkjpztpr4isI3kHli/DUk5K9YAyYcn0bz1jXjIQzOWnxjYJ0PYMOX+n12UiOlurnhwupB0frxQIleRjJudIFkXgPiyiB9iCfyVdoIFpuEdjJOARh5VvY2tLmiJsCakkQeKX0o2s407URI6qjxzXscAeDOKcm3iAtjVR9GFMu7kA3HsaBAruXx7ozNIMw9tkp0onRlro2jyeI2Lh3lS6zER/0OvRCA7iP9L1Bo1t+8vXWsWOVsDNdMgI4b0gwcD+F7wjqxaxXuywFNJyinX7KGwmoS7KdV4d+WtsBlceaa00FxKoBVB/Ww34ZtRTMNw9+G5Oh92/1aFVT/ulCHwQTSLQ909KZSJ/W14KY9oxRVcfT3c0htTTiISWp+4T7W4GJjoG7+d7/1xlAYRzdW7AtSF5oZ0370zMMZxl6NJlrhX8p7fza+iKVYM+rZAUweoYe9/NEzaLEpgrpb4/6x0tVAIz9ue+JP7h6jDkSN1nHS9YIjntAwnw4x4iMfPgflvDp+Sn1fqBvQs8Uv6RMLXuB/y+AUniSlCxP+l1ws8NL3IHUeTO736ptOrlbiHTKyRg36Y9jeKzneRz0n6odubKdKWDHBuy9L9ul1Uv4AgR/yptjn2NPFn/9XnqWgiqMHvLQQE4jBqT/KjF2LAuHTFiPUVYwVQhPDFgbS+o2gwsNGPAX07GoLjxUFiAQDemeG7FTLVgefOleIePJ01A0Z7x62m2YR7p8e5rtk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(786006)(19092799006)(1800799024)(23010399003)(376014)(366016)(18002099003)(13003099007)(38070700021)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZRVYSvEgjEgwmUQLppxB6RdAsBZqe3NB2Eu28sMqF1RTruHIWYEYmHHEWYaF?=
 =?us-ascii?Q?FW2xg37wGSTBh68jncT8fK3GzuwsIUVZMRn8tPWnqFPzdRR9IhcIbvPLQWwx?=
 =?us-ascii?Q?x/4g4Jd+fJuCIBXAOk7lasK/425iallrpK+p1/e5mkhP8wy3i5n20itCPTYc?=
 =?us-ascii?Q?xE85Qw3bDb5uzOycCd1Mmt74Gt9HTho0yYQLvph5sROsbcUniX5YQ6rg2rRH?=
 =?us-ascii?Q?fDA/j4Qb0QQr/yeFdL7aydkO5qSlagqieyKrVnO88Wvx5i/+MZUBJHKRQxj+?=
 =?us-ascii?Q?fL/+1EdUWw9UnIyrji6uhYMA93snuvIivwz7BTb4Ojz4dEGbBI0pbWs0kpZF?=
 =?us-ascii?Q?I/bhKwT0prA+GU0Qotfarokbt33u8DmSX3SFrJY697pq2ll3+63dJRA/Bm0O?=
 =?us-ascii?Q?LnX2MNXEkfFYTAYlec3hkEwXSHxGnV9Sl0CBH4Gbs/lUaYk1y852vDRNTjTu?=
 =?us-ascii?Q?vKTKqzQE9QR7ERqjZXrH+w0MfWPCkW/LjN5+bVT0U+4awdpp+gTwQE2fL8ZH?=
 =?us-ascii?Q?6fkQXDHQ95EGvLkKBxP2CVdj5HAL9K5r6snLmf5bhpCMiE6H55/+zKr2R/+h?=
 =?us-ascii?Q?a9X5doLIW++7KS1TtlHzNYB/4190MsKqPrOTHdRIRpNnbyiuUXzvU8OK5mkH?=
 =?us-ascii?Q?2roauLQZxBVamto7tl4+5GIvo6972C0ehq/UhUhJUgEiGiV+mO5qJreOqMU4?=
 =?us-ascii?Q?AqJ9crG0YaYX676iBxoWmuNyTWIxwrxxCw4b/UzqHwiEtiH+xfOvVrpTDau4?=
 =?us-ascii?Q?Nwy3rto1usU8A9XJUK97BmQ3VffmVKZ1GHvPHjD1Rg4QOL8qhsW2VR/BcFtz?=
 =?us-ascii?Q?2IVKGIQ54g7KIk5BW9T8cUj9p/hOC6/2t3UEAvvJ9fggeP0dDdCHJU8Cton2?=
 =?us-ascii?Q?pYa7d6YqNcxfabfojAjjMODrJEYLnFzNdehC8QnemS+HjUOTaUnSWVpHPvqD?=
 =?us-ascii?Q?Jj9hbPDN2QtmW4PoRTwG6zoG3vwT9iCISShjLan4hDf+GbmNVh9wKZUnNHRC?=
 =?us-ascii?Q?10nz6U50KbCqxSuCZhA51E1Vl/45AiATYaNzC3T8aXLvQHpPDTK9xjTGbpa8?=
 =?us-ascii?Q?RTZBzZhlEcfAX5DKcY77PAJ3tXLcwaHXP47zbxHu0UFne6LYPj2w3Q4o6TEb?=
 =?us-ascii?Q?6VSiNt4tBneQ5T40wfn8q1TSt0fAf2C0gXEp13tmbMWCTcvFJ4Ys+XYGwGLN?=
 =?us-ascii?Q?+n4kX0NVTTRb3V0dpys5B9x2SBQDBLWRHaL1L2kFe2O7vJ33pPxEnNacMN0x?=
 =?us-ascii?Q?cYmRS3AXhoJ3XhsQSQc8BCn93EYKjVqttugdqfJ+n8D4lmJb+A3+Mx8lKy9M?=
 =?us-ascii?Q?05FZWjk9xD0irZY2nmSuUwZF9f1j2IJb4p2heOrwYOv6swIMcajuKJ47Miv9?=
 =?us-ascii?Q?OAic09t/DKMNOrhdnqTuDFjF/pZJk/mQfS9j1EV4tgzKVZlRdYvNmXBuNqUl?=
 =?us-ascii?Q?9+RBGusV2TsMYWocJYMXXq2nVgSGtkZAIv0W6d5bo4kuLcCrsZPbw5Dm+f6P?=
 =?us-ascii?Q?egQhqyWQ1rN/0NMv5rZ4nzDJiMYDPZMnCRQiOGKPFdpPouOUKnbFRrEqD9yM?=
 =?us-ascii?Q?Itla8onxV3X0R01eBLiY7o/uJ8ppULSrotyrbEs5ctUxFJaSXyOFPUsThJLu?=
 =?us-ascii?Q?IatJzuxFfT3y8fdgegdPZKMEMuMsxpRlC8IRw5T1UxWC45G5txF7o6sjUPM2?=
 =?us-ascii?Q?2VF2Kfj09BIX4RYRhvoU6skQm9RUPGPkDQvTMARL4Q8/ODw5omigbzR4nI/V?=
 =?us-ascii?Q?XtXgV0Ba6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: heig-vd.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR1P278MB1040.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6c79e2-85c5-4a24-f767-08defe1023ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 16:37:20.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a372f724-c0b2-4ea0-abfb-0eb8c6f84e40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIJuWmw15oln1ZQ5/UIGn36L0+4dnkSwzDXt6VZIjfV7H6ucpqgZsLTOD0wNfErty0f4tv3rP8/15mcxK+lhrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1630

Hello,=0A=
=0A=
I originally posted this question in the matrix channel but got no answer. =
I try with the mailing list.=0A=
=0A=
I have been using `libevl` for some time. I am now testing `revl` as I want=
 to move forward Rust.=0A=
=0A=
As a first step before going on the embedded board, I'm using "qemu virt64"=
.=0A=
=0A=
First, I noticed that https://gitlab.com/Xenomai/xenomai4/revl/-/blob/maste=
r/Cargo.toml?ref\_type=3Dheads doesn't refer a valid `evl-sys` as it points=
 to the main branch and not a tag. I had to clone `revl v0.6.2` and change =
manually Cargo.toml to=0A=
=0A=
```=0A=
-evl-sys =3D { version =3D "0.32", git =3D "https://gitlab.com/Xenomai/xeno=
mai4/evl-sys" }=0A=
+evl-sys =3D { tag =3D "v0.36.1", git =3D "https://gitlab.com/Xenomai/xenom=
ai4/evl-sys" }=0A=
```=0A=
(or v0.32.1)=0A=
=0A=
Then I tried to use the timer with=0A=
=0A=
```=0A=
let timer =3D timer::Timer::new(clock::STEADY_CLOCK).expect("[ERROR] timer =
create failed\n");=0A=
let now =3D clock::STEADY_CLOCK.now();=0A=
let period =3D Nanoseconds(1_000_000_000_u64);=0A=
let first_expiry =3D now + period;=0A=
timer.arm_periodic(first_expiry, period).expect("[ERROR] timer arm failed\n=
");=0A=
loop {=0A=
    match timer.wait() {=0A=
        [...]=0A=
    }=0A=
}=0A=
```=0A=
=0A=
or=0A=
=0A=
```=0A=
let timeout =3D clock::STEADY_CLOCK.now() + Seconds(1_u32);=0A=
assert!(clock::STEADY_CLOCK.sleep_until(timeout).is_ok());=0A=
```=0A=
=0A=
Both cases fail, either on the `timer.wait()` or `sleep_until()`.=0A=
=0A=
My system is composed of:=0A=
- uboot=0A=
- buildroot (I included the libevl r59, revl v0.6.2, and evl-sys v0.36.1 pa=
ckages but I'm not sure that it was necessary)=0A=
- linux-evl v6.18.29-evl2-rebase=0A=
=0A=
rustc 1.97.1 (8bab26f4f 2026-07-14)=0A=
=0A=
The Cargo.toml of my project is:=0A=
```=0A=
[package]=0A=
name =3D "evl-periodic_task-rs"=0A=
version =3D "0.1.0"=0A=
edition =3D "2024"=0A=
=0A=
[dependencies]=0A=
revl =3D { path =3D "../../../../revl" } <--- points to v0.6.2 with changes=
 presented above=0A=
libc =3D "0.2.189"=0A=
embedded-time =3D "0.12.1"=0A=
```=0A=
=0A=
Do you have any idea on the issue ?=0A=
How can I retrieve more logs from EVL?=0A=
=0A=
Thanks !=0A=
Yorick=
