Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2124.outbound.protection.outlook.com [40.107.8.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276E266BA
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 15:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdzpp+FSoxGxUUsQCnAHFVhLw19inuXNzf1ee1k0iqYu+6wgGrHBtmZTzB4Vh5vLXjWWWwqShU/NhvoGRxe6OLOdxpbk1pI+s8Pw7mizrcVX9L2Z2OhtCkXpqfGFmiFdUy61hexWDYkTCizx6MMsYYvq8HsUh3SkiGh5A7ONLCcvLFCtTS7+AI7XQ+2zmSQg4F7jVtLvkL2Dzaxc1BpstNijQN5SSVgAXpUPkDn7LzUI8hrJMK+xspxWXeSnQQueodJxnN5VFDBZLlM6jCLGXLvVOgmwaCHMD3TQZLP6mfnJwRSMxYkB0BkIw7vxUxAKa3WDDRT8XUJT0smYCaGntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHj2AC9DTxc44H+hVL7wb/qPxwytF7mMliHsFYrRoro=;
 b=nGAdpdqF6TlIBaX1zY5SPaeno0oz3USs3b6kcqk3KW+Ua6PxqKKrD8u003nl5OiP9GF7XLnWcRwQlr5/XfZcMu8CufJyZwBcCxRLJMkuPR/MOqyYYYSyEr9A6qiK/yIWw3oCt/38pW365JQJLY89zYe/SPm19BESPFoQdA4URynfmwneA90hmZzcUoHa1aPv6cl+zGYI1ZShRsnqbEodhm/JwGPibwP9lXFmkbsFFMUcJFmjVsPI7T60xrr1C93yMLb88pVAqnGcQlslD5IKa/k4gGoVcUvWbahc3qhb4GsPiTEKjy6uEzU15IlvZ5tVNN4iOajRfidODigoH84vyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ecler.com; dmarc=pass action=none header.from=ecler.com;
 dkim=pass header.d=ecler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHj2AC9DTxc44H+hVL7wb/qPxwytF7mMliHsFYrRoro=;
 b=Jj4v8DoQ0rdxg2+GcXTaxW1lfIk+EirKoK6V9AnXIz6jSsafmrIMJA+QpQthzAC26CgiZ+lYedyN5Uis6WSPE6UUA4SH4HgbiMB4bmGlE68W/bbp6FUdxcyL23JAB+4SX5lWroGTEDXiA6HfBGadQIvftewMBvnM2EkwvqwagJJgpA0tvHA1yzcWE6wcSgUhpugMi9NM1sbIHBbl28ERoEQqelb2dbbkFo4keeKaGxCSlosHVE3X5oXN/Bq6dCHoQdRN7jmuCQd47OvnZwpy1agZqvXSiWOHM+ZPEVLAhmjrgHYIZFRTjsy1ewTpkONRRemA9CCD6NRUgpKX3ttZ0A==
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17)
 by AS8PR10MB7449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 15:40:39 +0000
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::724b:81b0:1a33:23c8]) by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::724b:81b0:1a33:23c8%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 15:40:39 +0000
From: Jesus Villena <j.villena@ecler.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [EVL] Problems writing to physical memory with mmap on oob
 context
Thread-Topic: [EVL] Problems writing to physical memory with mmap on oob
 context
Thread-Index: AdnwZ6yKI9X5QCLEQ5i2sLHRmtbSswAHD/AAAAKbMhA=
Date: Tue, 26 Sep 2023 15:40:39 +0000
Message-ID:
 <DB8PR10MB3706B544A1AD8812E2ACA78BF9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
References:
 <DB8PR10MB370698CF0BAFEAE2198D24A3F9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
 <87sf71nf1h.fsf@xenomai.org>
In-Reply-To: <87sf71nf1h.fsf@xenomai.org>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ecler.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3706:EE_|AS8PR10MB7449:EE_
x-ms-office365-filtering-correlation-id: b5585759-330a-4c9b-1247-08dbbea6ef46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 decCuKRLtlc48Gzz9NP1Abgzqp8hbLdAR5yoZ13CdEk1+NFvFwalm7IarwY265wohc+3Z1hSBC5viL/Ih3n1r6+HIWIbc+MULeTaGQooL4Lx/Zm3Ru4XVwTWlIuj9mjIw507GEO2wtcsYhy8dl/C9ZA1KaE0YRNZcL4giH2BFyi3aXH5P+q7zg9sarpPgpK1NSlH0Il6JEwGeDCxviPlu6Mq1lRxj6FCco7G/abf8v7tV87MWxgv98elvdKf8tjhnQHgdIK8FhRXEJGuH8Cv2nDYwFlXzGw5lZlzh1fR2nGVMxWoNrBtTniKNaUJjsBCcq9K8iiMiaKyYQLXURiz5qyweOfIFAoQ9B0QCDn/9jeoEYoRYaLsKB6gQ4In40JwIlHDHBvYh+Bf63eoEwGZ+iqWqPUclu5rJk1sJZ26NT1X+1FF1IW+z9X2SfRfJrawmsKf4Q3mSevV18zdmY0wl+QWsfihZ/SblNUgJ6GiZmIXELPnFAeracUKIZzV+HPFUXwjeIR0kIivcsvE7ja8Rlw75m77pf8pRfxWkdgeEDIUcEvHqwW3Tbb2oxyFru0j3OA0vZpmAR+GhEe/ZKciDSe2AFZjYhB90V2dwjbggg0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(39850400004)(136003)(230922051799003)(451199024)(186009)(1800799009)(71200400001)(83380400001)(2906002)(966005)(7696005)(6506007)(478600001)(8676002)(76116006)(26005)(5660300002)(52536014)(8936002)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(41300700001)(316002)(38100700002)(38070700005)(9686003)(122000001)(86362001)(33656002)(66899024)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FsZAmykFlGoSBeAim+1o9iXerxa+Aq/jjnZyMnmFFbGA98pL1V0HPOY+ovB1?=
 =?us-ascii?Q?QlsQGS6uygQDnYf3fKc4rLXasGjtsEXsS15YYwDB3wqcQJh7ZxWVRW4KSx38?=
 =?us-ascii?Q?WgS6dXQAcvQdcSsbyAYs+eSnZrxT9kQBbskCFeQa9h2Ui2Onj5I+7WCB0o8x?=
 =?us-ascii?Q?2jv9plp38ycyiXp9C/pZKBOiVUvqBtlA2V93zvZFyncLc9wCG5BiV3X+i4TB?=
 =?us-ascii?Q?ns3MN3QWpqhnGteHRqFwwvnJmWgKalWZW+2gLtIvU3EjzhXFR+sbPdIuHKrP?=
 =?us-ascii?Q?3+BC4PSzry76tSJhJ4AQt+GQw6BS2K5vMtQQSO5gMdspOjtnWIHAkpKFie7z?=
 =?us-ascii?Q?eTuaP+vdF1ideDYUnc5DvZ0jRn/xsXRkAX4dkfKYX0/UoNc0lknY6PyllL0w?=
 =?us-ascii?Q?iLLfSkqnf3Mme0aqtaJBnyWXEFz8WtfKk3nqLcySmDUSJwkMsBpQ/j21KDtL?=
 =?us-ascii?Q?ehVC7zz9cat1A8ILGXvVIRvNbkDTXDiFH215l6bt1yaGll/bAsw5BHTtCoBC?=
 =?us-ascii?Q?Es9ZBskQ9pmiGbgFt1SLlTllX1Ag8sXi5JYXc/qHwViDUgXrV3RJnJUqjV7Y?=
 =?us-ascii?Q?zdiHueUZtmmojFKirykkRgFEnKGuKHO+3odceBKX2eiy9zEuCSbTZFXAOK73?=
 =?us-ascii?Q?cKESVEBsUG63zP2k9VZHniWzDvPHODvEOkRDnHRgpI5JB6Iu/xMPVbznqf5T?=
 =?us-ascii?Q?HaIiEQoeDrtOmBIoU2pLKhfeIhhZark0mZQfqZZuxNKzpWKV+3e45yshmmrP?=
 =?us-ascii?Q?wdihz9lwHXKdEwEC/o2RERSyYP8FqMoCmiJSIHQHMWZxQ+/EtgBt0spHczI3?=
 =?us-ascii?Q?59mnJRq95wp7A4RNS4OjQrmykXfHTFpVrJASOsnlXBp3gism5YK0jbTBo8jO?=
 =?us-ascii?Q?X/z8DmPLVvXGIUDtD5ev/rLXQ5nrwtr9nlGuL58/uI8l0k411yTKu2ZkD5eL?=
 =?us-ascii?Q?AH51a+VM5+rGuPHV1Ghf5dZWuHV2tbKpyoyKe6e08Y8yMxXl4R+WEoIWD09a?=
 =?us-ascii?Q?TheNaxNCr6Zd11woiJNYH19v5dpX4twV23DHU2X+HK3AtX88ZoFwsglPCyqh?=
 =?us-ascii?Q?1Jvr2LMFa2Y5IpI4aYg7L/8wS4LWNcHtgF621IzmGD4GcNZQy8uKV6MEztR9?=
 =?us-ascii?Q?qQDx8ribBcXnYgtIh6BMwfpp96TvIbbZNbeuJPZ4kq0mJAirF4xoOuOH2rhl?=
 =?us-ascii?Q?07FBSAUJJ56dA47ddmie6quZEDGxy7EVqm5Cons2Vs25jGmuriWF2f9W0ldS?=
 =?us-ascii?Q?8196HCee/hsBKeP6EKr/jMME62EBrb1dFOQGPISBqhu49DXcNeJlFeHG1YbN?=
 =?us-ascii?Q?xIL+hkQ7+MpGLE1dJks/IV+2VZrObJXNQtQg8PSAkn+acV+ZlMI9qQJ8aqwF?=
 =?us-ascii?Q?EZQlC1tQ49kILTLoj1ZKyjGRhs7NdL4H/B6qtIRO0wLwyfjvm6VtcuAFYgFh?=
 =?us-ascii?Q?uUr3Z6iXNT8+lW+no3NDO6+rnku2msg4xqEGVPbopeBJ+CddCnZ062zucQp/?=
 =?us-ascii?Q?x4/A+Gx9A4q7OnukJnSnOX+OLiIFE/gHAV8Kgq7jQ134HHL5unLM3bLy0uU7?=
 =?us-ascii?Q?vbbBUFbz8i69FzuBTcO/cD0L7xZ0IkqwYwq2gUgU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: ecler.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5585759-330a-4c9b-1247-08dbbea6ef46
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 15:40:39.0912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f9193a3-7ddb-4a6c-9664-df2759e0e5ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2mRm2ZSkkHa+TE0LDED+3GvaXFhv/Oe56ADo7TBr/F2IHRbK+4eP+kIAzj1inJK7NzkWXguXnFdXPHwfryQ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7449

Thanks Philippe,

I have already tried the custom driver solution you mention, mapping the sh=
ared memory in kernel with ioremap, and adding read and write handlers inst=
ead of mapping the memory to userland, and it works, but I would prefer to =
do a proper mmap to access to the memory in a transparent way.

Following your comments, I will try to debug the issue in order to see wher=
e is the problem.

Regards.

Jesus Villena


> -----Mensaje original-----
> De: Philippe Gerum <rpm@xenomai.org>
> Enviado el: martes, 26 de septiembre de 2023 16:16
> Para: Jesus Villena <j.villena@ecler.com>
> CC: xenomai@lists.linux.dev
> Asunto: Re: [EVL] Problems writing to physical memory with mmap on oob
> context
>=20
>=20
> Jesus Villena <j.villena@ecler.com> writes:
>=20
> > Hello,
> >
> > We are using an ARM64 based platform which includes a small Cortex M4
> processor to run some algorithms, and both subsystems use an internal sha=
red
> SRAM memory to implement the inter-processor communication.
> >
> > In mainline Linux, we open a "/dev/mem" file in the ARM64 core to get a=
ccess
> to physical memory, and mmap the shared area to read and write directly t=
o the
> SRAM from userland.
> >
> > With EVL, it doesn't work: after opening the file and doing mmap, we ca=
ll
> evl_attach_self to switch to the oob context, and then, reading on the sh=
ared
> area works, but writing aborts the program with the message:
> >
> > EVL: evl_test switching in-band [pid=3D363, excpt=3D0, user_pc=3D0x404b=
5c]
> > oop...
> > CPU time limit exceeded
> >
> > I don't understand why EVL is switching to in-band context.
> >
> > Do you know where is the problem? Why does reading work but writing
> doesn't?
> >
>=20
> Looking at the output you get, it most likely behaves the same and does w=
ork in
> both cases, w/ and w/o EVL involved. In both cases you receive a so-calle=
d
> major fault when writing to this area: the only difference is that EVL re=
ports
> such kind of event which requires heavyweight fixups when running oob by
> sending a SIGXCPU signal. You definitely want to read this doc [1] about =
these
> notifications.
>=20
> Those major faults cannot be handled directly from the oob stage, so EVL
> downgrades the thread issuing the write access request to in-band context=
 first,
> then notifies the issuer about it via SIGXCPU. You could disable this sig=
nal by
> clearing the EVL_T_HMSIG flag for that thread using evl_set_thread_mode()=
, or
> set a dummy handler for this signal. But that would obviously only paper =
over
> the problem, which is that the MMU wants some help from the kernel for
> dealing with this write access in particular.
>=20
> If not already set, you may want to turn CONFIG_STRICT_DEVMEM on, checkin=
g
> whether mmap() still succeeds or fails with EPERM. That would give you a =
first
> hint about how the kernel views this SRAM range, i.e. dev exclusive or ot=
her. In
> any case, figuring out why the CPU traps for that access may require some
> debug work with the kernel code (I would start looking at
> arch/arm64/mm/fault.c, do_page_fault() typically). You may also want to
> include the KERN_ALERT log level in the console output, in order to get a
> number of low-level memory management traces on arm64.
>=20
> PS: Since /dev/mem is a liability when it comes to security, you may want=
 to
> write your own (small) driver only for the purpose of creating memory
> mappings specifically from the SRAM to your application, disabling /dev/m=
em
> entirely next. EVL would still have no part in this.
>=20
> [1] https://v4.xenomai.org/core/user-api/thread/#hm-notification-methods
>=20
> --
> Philippe.
