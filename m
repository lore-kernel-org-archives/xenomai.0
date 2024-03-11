Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11014029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C938DEC
	for <xenomai@lists.linux.dev>; Mon, 11 Mar 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175975; cv=fail; b=XIErcdjoY7xhPZzG4udyoG2r7a+u3t4XlJWvxZvrAOBqIh71e6MOQvB0wwOCevlrtARDuM760fE8r9IkcG17J3ccqCrN5b8txcJzL7TM+ilgPRj/We5hEgZmm7Q5QaEmKGSPxwNX5Ub5OhWOZ1pKqAOmmvcJEce1Vyuq4pV+3d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175975; c=relaxed/simple;
	bh=CS5hkL4T94Gi2YVrO4RnvaJDchDf7Io4LwIqkcbSfQk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awyAtAd2If6EI5hCZ6XHmKpHGOSXzAXmY6N5hFiyCgR7hgUwGFJ3wJDKQDPHLrqv5P6iR4rbKTtPPd6EDoMcqqhSL6xSAeodiaEaopNNlWvkPTN7Okj3LhA5G8Kmx9pnFNKO0qLO7SY0OMg0WWrEzf5+DuozMTK35B70C2aC5dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mts.com; spf=pass smtp.mailfrom=mts.com; dkim=pass (2048-bit key) header.d=mts.com header.i=@mts.com header.b=o33VzZu5; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mts.com header.i=@mts.com header.b="o33VzZu5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYd3aMTU/Vlya6PVNaeucHdfPvjW1yLc/oeGJOSrMUKpX3a/aC4jIl1MMKp0MUq9s1mWD+z0sjV2BTXcKk9HC1fq1MXUylf7hjBPEqAcrJc8AHO++I2wtrfyioDknEdGWzKsqdiOxt6zYJq8oFR42Pq1BaKm+EpVt2n8TYHREUaHQlMplDggW5mn/bGzTAyE/iPCrdl7LmqmpMs0ezp3KpF475b6QGh+rPcYRbd5NjD+pzz01WKw8RtdpBiRGU3UdyhcPKapk+EibwIi4etwUjIpSIupC52Wg6DXqUEK/dg175LA3WuFQvrEU+BLURTGijuJ0W19fUoaQDD1qJxUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CS5hkL4T94Gi2YVrO4RnvaJDchDf7Io4LwIqkcbSfQk=;
 b=XU/UvqDTz1WP16xH+z0TQuxEotmIgcOA2+ElKm+04hKskEn7K49d68ZQBJqv0yk5vqPl/T+h0A8ZKmgiGwwOZalmgtyjBVIYoxo4WxLfIHfbSZ0ZtvYBoRd/LAk2hgpj+ZpFo96G/ZyZvNZUmuuEPs/HCLfviMh6AmVYpcklPs3buLV4TCMNXz+Iz7P34tiN0PB7YTKyszY727uWxB05EHueovLqq2uaBlefeYldMdZNO00bDXIj0ZdrP451hMHaa3FqVVP2EE3y8SWyNxtBCr7YY8kU/hXVSQ9tTVaAi90cMujkAgAnbX2ytkqfZWFkL/6UiKRLUkQ6OUWBh2RtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mts.com; dmarc=pass action=none header.from=mts.com; dkim=pass
 header.d=mts.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mts.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS5hkL4T94Gi2YVrO4RnvaJDchDf7Io4LwIqkcbSfQk=;
 b=o33VzZu5OnxVZChMHPTGOI5SgUxjcv3wySMqIB7TJNebAzy+BO+DC4ai3c9GUzfjVMvsGCZ7gZjUKuUoYYok/lSoL8tsM0ZhrDgrk1oMOLaL3QtqzSPzj4dnJ1LsNs0o9qxZuuc3WS+kFFxALdtQ5plhXubn9Hy7wacK5IXqTYRqdRDDz31fzA695hQyzx4O6rXwllz+RYoGWsQSYZUQZ7wQL+2YKTVpvolg0dvJcN3ZHmtmu8nqZ1u8uDU0Uq12QgXaflprq42awgcnLUidDehn8Kpk2VpHbqqRJsfjc5v0XltgzgmQbu6KoLa/vvDUeqBaMkkJ9t6E3JtpzKvryw==
Received: from DM6PR04MB5386.namprd04.prod.outlook.com (2603:10b6:5:106::27)
 by CYYPR04MB8908.namprd04.prod.outlook.com (2603:10b6:930:bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:52:51 +0000
Received: from DM6PR04MB5386.namprd04.prod.outlook.com
 ([fe80::3b5c:ebf8:2564:a39c]) by DM6PR04MB5386.namprd04.prod.outlook.com
 ([fe80::3b5c:ebf8:2564:a39c%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 16:52:50 +0000
From: "Rosenow, James" <jim.rosenow@mts.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Hang at "loading initial ramdisk ..." on Generation 11 CPU, Gen
 9, 7, and 6 work.
Thread-Topic: Hang at "loading initial ramdisk ..." on Generation 11 CPU, Gen
 9, 7, and 6 work.
Thread-Index: Adpz0VUl1sKmb9j9QoWV24Wq8Vg5UwAAnQbQAAAO4vA=
Date: Mon, 11 Mar 2024 16:52:50 +0000
Message-ID:
 <DM6PR04MB53864A2698B4F2147B79413CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
References:
 <DM6PR04MB538655375C57CF07EDDE5089E2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB538673AA2E912100093BBA7CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB538673AA2E912100093BBA7CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mts.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB5386:EE_|CYYPR04MB8908:EE_
x-ms-office365-filtering-correlation-id: a08df663-80b7-4170-c2bb-08dc41ebb005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OKKvuocbrSmfx8MwNgIUGES5BKuk71ob3Z2gOChHCXrtJRAHRlrVz8lfxvyQneVV4b/TMR+MKyHKegpWxazU4vOAQqwRkewyiZxDt8N1dO6sRZT4iomgDekY5JcbIu9RF4gsNrJK6p7f6WQqZ1/eWufOtgmXcVg8RzWhAGLi1+9IjNBTBMRkDckjXWEQZIeYdl4/CmpeBTM3I3l7RPTsFMdEiLZgNxHxLAEGzVraPAZUcjAi+g7yfdk5J9MJcDGM5SM3BSujvAvW1DPAUqhkcaMJp4CPHSiW326/EUWebciBBY9GU43n3uonBScQkfYNbVcv/lmfdij7gPRv0Pq+kRfw4HR/bYUXchq62EkL9XWB8cUPnxcxkzmTl33OBymnZfT1EV+/cw6ziaqWia2k3yz3fJ5Mm8lAXVXxwRB6F+/H+Rg3tzgc9PJv8doWFROYgemvKZM1layJTIjK83snM3PHl12+iGzZlE/H5s8oqwOQdrcXAYa0qJFwtCSV3XMGXCRkzlssMRLfci73BiWZDFLUjLtmlJJcegWg6ujhgNRt8uTSSAZmGc4xUgPV1/CczeyQZYB8xG9JRfhjW8wg1x65yex9HIExwF9244NkSqeY64UecLDUBtEwPBJt8yEcABbuLCF4QS2G4R0PEcjMrfrCk3bdtGLQojUcBQHf0oyZqqiTGP9PQezsf0DCFmoAz5It97xS8pMM1IOurQsR21u/P2SWEMxuhlobMbxGfbg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB5386.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tTQGIG0KeO2pRcEgK4EgUVpHPL2IL86qvFjCoRjVd7YZXEXAr1CgQHP0ce?=
 =?iso-8859-1?Q?UhuWi5Wq9ZCT3JVrUbwW2Da/PykWAiiZQySd5wm2WeGAPvx7hs+LHaQMfV?=
 =?iso-8859-1?Q?dgXW8/rpIxt3IGgIao9zGaVgM8VaO+hfIYoOFUj33rp/Qz1mqcZKAy7c2j?=
 =?iso-8859-1?Q?oDSBYk/75CQy9C+1BSwl0xk3VUZXrwWgI2QLJvBK2HQr4f2lBZuytOIYM/?=
 =?iso-8859-1?Q?A2CatmZRO6Y916nd1tMDz+oAx9WP7CWXEoNsDh2JThTSKRAIymMPsvK3wx?=
 =?iso-8859-1?Q?gHbQ72p3GCaDa+ZU55pFS8CFRdsbI3fI5ZhZNj3g/QqgekEoNObdQQ6MAW?=
 =?iso-8859-1?Q?w/BbeyE8OXC9Nk0V99NvFADykEvK7E8aQpK4W/5cZ2lVk9nRWRvMRJElCr?=
 =?iso-8859-1?Q?kVqZSqoMp8ljrKGpM2FCsnklAz/C4thqt06RDLUhQC6Etc3bxXZqAnm770?=
 =?iso-8859-1?Q?vbWWC2WX6GWMJfmjSMKAVo5LOVbjUcnUd1gISNa6oo+VOrQxm6Rkdd9AAE?=
 =?iso-8859-1?Q?zVsXnG2bQXobLL31jtGyItnw3/qMqi1TMI6ODoH04NvQWsYQHs+mx4Dt08?=
 =?iso-8859-1?Q?WSVYEhkn3ItRdqPO48FPSJoNUNdcSIUd9CDPf8oLv194XTJ8HEIQXWay5h?=
 =?iso-8859-1?Q?zPfJFTjS3LbY29vizy1OWx48cGxBd12uZNiGGEND8sYOpF02z3Cgp5FECA?=
 =?iso-8859-1?Q?NeNIpsNioTjaYcOf4k8UZMAEQti3CgVQy6g5bSLf/NbVxXgfPZuhXVTyxe?=
 =?iso-8859-1?Q?ELGKXmuxoj7GN86YwgCVmj5TRHPpS8beSId9uZa/5Fp7l85+HU7E4NoURa?=
 =?iso-8859-1?Q?/VzPKjVsLl9g+qkdy22q38FJjamh8zQ5v9oEuihTiBUOe5y9Cy83i18UTA?=
 =?iso-8859-1?Q?LmIowp6DGkhw4hCKVzTjuTWy4Xd1gYfS0ev4W7vPvyTXf5QOkRqVyNwxyr?=
 =?iso-8859-1?Q?bYz57c2FRw3oIeChVy1zbRofWUNeUOqkHY5iBqh51XDHMN1IEH/EirkIk5?=
 =?iso-8859-1?Q?PyAP0wfKkDDmXJQCDyUp9jtBIMwP/24YfVC2PvtIXSjwttMvyyMrzpbzjF?=
 =?iso-8859-1?Q?QJU0X7BshR3E9xs8RPO89fmtgPq87QImwq0fixODn/dpkAZlGGDqWV3wVU?=
 =?iso-8859-1?Q?zcwWGMcIAbu6Gw/BXu6ECpQDqHux8sxUH6qjyR6r1zRZEAz7k3z6G8cP2z?=
 =?iso-8859-1?Q?WgcQ/GN5g667yxBORBdx4Uh6ceL0aUnpiw52Ntrmn2FUnIsdAOyb9iP+3A?=
 =?iso-8859-1?Q?Guirl9rjbFNwVweNXhVUhmaItVPkdTC++XfzwuEXYa5zDq8OFhsTniMzfa?=
 =?iso-8859-1?Q?ltrXIZR1jreMnpdXLGjSTlUczxl34Z63UC+0odBdbZHUqUuKq48Q6mte3B?=
 =?iso-8859-1?Q?6ibb89aN+z+G/kbZF0uBHjbZVGigit73ky6gXEcXXvkGNQw+c1mgmN/wWj?=
 =?iso-8859-1?Q?DnJ4BLWJL6vg5cF5vYtjT0vLUS0e6RhVNeWCnbBCZgcDz8Wfw49r4Wr6Q9?=
 =?iso-8859-1?Q?aifAvfO8fbkFUdqV7zbGkFz3bIKbZ/sciVqyz5GkE3NS7hzGrTKC05EJAR?=
 =?iso-8859-1?Q?7XWVxGWRGUOpDBFWPE/bZJp52bfG9wyYvajnMmmAiBCj3/A8Rdl6qH2eq1?=
 =?iso-8859-1?Q?w32nK9Meq6vdUSvoud3wr6SQD7TrGa7uAS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: mts.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5386.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08df663-80b7-4170-c2bb-08dc41ebb005
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 16:52:50.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7fa3ed9f-fff9-4884-a6e2-8dd98886b775
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hUdnvRC6DoX+NTZ9thVb39+0wXovgMSWqed05YxIJgWyuxRftoMf/vJ9uax1NVz+g+9sbqKQzH63U5pLtbaug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8908

We have a COM express carrier with an on-board SSD.=A0 The SSD has Ubuntu 2=
2.04 installed on it, on top of that, I've installed the latest Xenomai (ma=
ster) alongside the 'v6.5-dovetail-rebase' kernel from the linux-dovetail r=
epository .=A0 Given that our board supports COM Express, we can easily swa=
p between various processors and have been doing so looking for the best pr=
ice/performance ratio and of course, low latency.=A0

I have two modules that I am currently testing, an i3-11100HE and an i7-985=
0HL.=A0 Since the SSD is on the base board, I'm running the exact same vers=
ion of Ubuntu, kernel and root file system regardless of the installed proc=
essor board.

The gen9 processor boots and runs the Xenomai kernel without any trouble at=
 all.=A0 I'm having SMI issues but that is another subject.=A0 When I put t=
he gen11 board on the carrier, it hangs at 'loading initial ramdisk .'.=A0 =
It is noteworthy that if I interrupt grub and select the stock 6.5.x Ubuntu=
 kernel on either, both gen 11 and gen 9 boot and run fine.=A0 I've verifie=
d the Xenomai kernel runs fine on generation 7 and 6 CPU's as well.

I've searched the web for possible reasons why Linux would hang at that poi=
nt; for Linux in general, it is a common thing and I've tried many, many of=
 the solutions that others have found to work, all to no avail.=A0 I do not=
 know how to get additional information on what is hanging as there is real=
ly no context from which to proceed.

I'm looking for suggestions on next steps to root cause this hang.

Thanks and regards,
Jim

