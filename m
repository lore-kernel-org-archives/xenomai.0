Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2066.outbound.protection.outlook.com [40.92.42.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF65697
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 08:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfijVig8gK77QFwL9rLHejECSB07Iicr2YWqo4g6h3XP9j4GmtFj805roUDT1Jv5+rkziDBd5zv1yUj865rJrZl9EAwrEr3/NkSv0Pd+ueUkEKMRGH/KXMj/xhFFnpl4cAha+J/nzN+Vd+zM3GNmC/37C+CXBrOwjkON85qb/VbgWvALJdrOS4r95/8S53DS3B+FWq3DWtex41RnTeDLOIgJfSdoFQYZWKWoz7DcKnHC5JzYbjDTpNqu4JXiYjkoR/ctlQPq4uHkpJpPa3ceESYaLkCGdzDhBc59MIFktgRZjkV3YWbhWwhjfJJrQpVQDHMu6ky1OKZOiXtjHD/6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwHdlfEUghrbHX7UU5SmEa3CEwdzfYL86aO3U0/W7tI=;
 b=PMVuR2t3qM3M0K0Ued2mxWpEx4e+L+QBjndHUSsNRFy0zC+FY3zb7mM+/DTTiH2ruXBNN9/FGuhayWQWgj4tf/rL1D/+05PX+mSXqPljETH/LNlWADUbsgB9kpRpGYlJ3sZa7sPAzH9AU6JguQY0IhTwqQq5Q5+tlsaKAcRsyw3Q+3cIA4TbUwczBCXv9r5KHq/MUx/VQx6zVNfZ3buZ3ADUom3Q4H15b4Sw/2OV1OfFfjBMJ2oPW7M34lxPyLZ37UoTB+/3h7UP44JUwJ2Omrajy2EJkdR45MOU0hliooajMnRJSQc6UigvnUA1KvglQy/4dkYgztHfI/SlllORrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwHdlfEUghrbHX7UU5SmEa3CEwdzfYL86aO3U0/W7tI=;
 b=sW4gteFTphf1vR2Psso5ORprdf3rudS4jivYCXprVaxOJKPAi0nkjCuM4uV8C5tLf9e4yaojJZETEX4vGygjYkgIqgKux09lTSG/j9wrzjRQqtGYP88aWHpXYDeqML9yRMH7Tpb6d40H+ykfHNb74RgXDSdwJmne/akLK0Ck4tssLIIKAlb0iSZLaqAdiyNAfz/knNNPZvMZ/OnMeF2y0tE7ELycLne+T2mRD3ITsN1mImXXV3zxPNgop0RDqvizNp2fqKyRw6eUDPC4IYxfPYQeEZLA6Z4wFiyflF1TPDzYqOCWxwlyqJP6eUQHlW0+KUWr+7m/4d+z3cZBFZtkFw==
Received: from DM6PR14MB3871.namprd14.prod.outlook.com (2603:10b6:5:1b6::20)
 by CH3PR14MB7311.namprd14.prod.outlook.com (2603:10b6:610:161::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:32:18 +0000
Received: from DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a24d:c80e:726f:9848]) by DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a24d:c80e:726f:9848%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:32:18 +0000
From: yo sang <stlfatboy@hotmail.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: data modified by second NRT write with same memory location
Thread-Topic: data modified by second NRT write with same memory location
Thread-Index: AQHZxFkf5jzl3P6vkEqeVqOzGMy4Jq/Vsr6AgAB/3MCAAFGRYIAAGagAgAALu7A=
Date: Wed, 2 Aug 2023 08:32:18 +0000
Message-ID:
 <DM6PR14MB3871735C1528F455A73383ABA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
References:
 <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87pm46sm8y.fsf@xenomai.org>
 <DM6PR14MB38719B58539606FEA830CF9CA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB38714729ADDC7529E3268CCEA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87fs51evhn.fsf@xenomai.org>
In-Reply-To: <87fs51evhn.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [UQTlY3xdub9e9lqb6g3itLR+smoZcxm9]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR14MB3871:EE_|CH3PR14MB7311:EE_
x-ms-office365-filtering-correlation-id: e0bff5b4-c7f1-4395-e30b-08db9332fb89
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6ArS5qlSS3pxpigB8FpLtF0fLszeCmguZaB3A5zEsI5EdzWQMyv9UoguxhhkMv+ltw327HwlJC3bzm8An81Cqq12kWV+7odyJkEvoZr1Xiq2jx3/cF5BFcSpyFNeMDJVpwmAPQbkHiaCf3mIg0qlreEysZktoyCy0oxzS8eAQe7XmM4NN4jhCLrr9qhjdoLI/LdelmRZ/DBWAOrBU7TavWthcsw2UK+kBYMOGYjMc6HUf7+r7a2sZzbjpItoH1ALZ/UASgZ0svISd4kXi1XxZXWKvy231qlzpcDqkF3W3G0djQv8APlCBIhH9gkxZGS4fa3kSDMEvV83NvxGyIETMp7ka5xIREPZc3eIzrtC4p/l+skt81e1GumvAKjcrwx4DLMR212ud8sOwBWrSkieUmy/z5SkzDeDnwApmQosQdvRzHk1xZ2p8Ef1Az7IS20wqa7ncFS5936e6j0AXhUzlCi5KAdK1jcenCiEv56ipVejvsFkcyIAx4iprXqjkCfze1JrQQK3ntRptctfxJdR3SHRH/eUlnjUC4edO8+0b8cE7bBy6R9kNBf83cIorUsW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w2thLTM9ejmyYvsgBdEjILd7x6lAVFSlB5RFe0kZTUyQNDkyls2MgJHQSvfT?=
 =?us-ascii?Q?/iSyDdAHV32BJmh2ReJqfvLQ3u27esb3wqAZCy8glngI1LuXDxTwkphsaln4?=
 =?us-ascii?Q?yn9+Vvab30nHig98JufVi5dHDDoj+e/vhsAlLp9lrE4ZwWbVdfClOal5kkx/?=
 =?us-ascii?Q?/iP/n63MasHcG1z4rlYcZNw3sPdvZ6qJhsDqnNPiKpJD3xw1t2lVXyI15dyi?=
 =?us-ascii?Q?d8MojFE3w+n7PdNEeAZBSJQlCPJI8b9w8C9hp1ivNV2YAZGCtTWbVVVqV64c?=
 =?us-ascii?Q?dELtaQFMYnvrel6Y+tTiXrGFso48tqiEHpLGBsHVMsD1pmci/vvreK7myepm?=
 =?us-ascii?Q?NkBALnXHoXEOlI/+eYMpvKMmZLWd/GePf/IS3Xo0BN+berBZq9o+sd6F6Wfx?=
 =?us-ascii?Q?XpjooW861bhIMqzBzSrHZtwSPTjljtc1N2lrK3FBxrbvDmeas+4RScVUWgUY?=
 =?us-ascii?Q?9McSZCHgdRQqhzqAZVvFSuBCDVP4bEpw6XxVkw2IqGjERe9tTydWozPaKsE2?=
 =?us-ascii?Q?B2ToE8H1nWQnO2Xn6SYNBj+nm3KX9MGEIUcOkJK3QNpJymeceGxLvNYWXhPH?=
 =?us-ascii?Q?NdlvBY1gh9WRrw/EvNrwntnsc5ZtvkY4PlmepZK+yVYfQCwNzS9J2LaKXsrM?=
 =?us-ascii?Q?Vtr+1nIaBmOkWl7hckJyooUH5vfQxjE6mKQDiJYyyv41JtjDoApX1yTS8TNo?=
 =?us-ascii?Q?+TOqWFrRbQ2uWMrOuz//YsfwcgQEHubGfnnDwIihv/FzlyYa3wIN2pSBt9T0?=
 =?us-ascii?Q?9QJsDy1Qz8rywEm2i5jvH1zqQT6cTkrWc4aNHQK8ubrHTISP3cYiezKn9WsA?=
 =?us-ascii?Q?nMfL33H3ZxUE7yg3LTWrn8yv3MLWoN3ivnptndC88wJ+gjuQLlZZu5Ipkqsr?=
 =?us-ascii?Q?YkUgjjEkGARXEl1Rw3UKVyDBrJf3N5SfS+EpLermXUjaQUCHC7PV4DRsq5wf?=
 =?us-ascii?Q?HT82L3/X8ODlAjKMI97y5JAVnk6GIqVFciIEpbqoXCgPgg4e15D53CAW/53t?=
 =?us-ascii?Q?2M+GtYlTklS0KoefnNfcr/e9NKKlCf1QTvcHsUz+IOfztZ94EF1j3TxbKx8c?=
 =?us-ascii?Q?lLFBmMuECf9WeAsxxn9kU4krFU68NosP4KLkgwCz1tsrppyjoJVKBPZbiHft?=
 =?us-ascii?Q?Wq/gxUzMSAXKrKgSqDgTzooGnR/ETpXPuBCixDKxYpIiJ+PrkBzGGGurBMi4?=
 =?us-ascii?Q?Vr3MVtpGXqpBsWqRPWJ50GshoIyWjuKaNErrmA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-cd57b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR14MB3871.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bff5b4-c7f1-4395-e30b-08db9332fb89
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 08:32:18.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR14MB7311

Thanks for the reply.

I still have several doubts:
1. it's very common to delete data right after calling write(). Data should=
 be completely copied to ensure a successful write() call.=20

2. The fd opened for nrt is blocking by default. If I'm using un-blocking w=
ay of write(), it's reasonable to maintain several distinct RTMem instances=
 at write end.

3. If I modify the RTMem class as below, the result is correct then:

class RTMem
{
 public:
 	RTMem() {}

 	RTMem(const char* data, int size, RTMemType type) {
 		//Data =3D Buf;
 		memcpy(Data, data, size);
 		Size =3D size;
 		Type =3D type;
 	}

 	int			Size{};
 	RTMemType	Type{};
 	//char*		Data{};=09
 	char		Data[256]{};

 };

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Wednesday, August 2, 2023 3:31 PM
To: yo sang <stlfatboy@hotmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: data modified by second NRT write with same memory location


yo sang <stlfatboy@hotmail.com> writes:

> class RTMem
> {
> public:
> 	RTMem() {}
>
> 	RTMem(const char* data, int size, RTMemType type) {
> 		Data =3D Buf;
> 		memcpy(Data, data, size);
> 		Size =3D size;
> 		Type =3D type;
> 	}
>
> 	int			Size{};
> 	RTMemType	Type{};
> 	char*		Data{};=09
> 	char		Buf[256]{};
>
> };

<snip>

> static void *realtime_thread(void *arg)  {
>    struct timespec ts;
>    int ret;
>    RTMem buf;
>    for (;;) {
>        ret =3D recvfrom(s, &buf, sizeof(buf), 0, NULL, 0);
>        if (ret <=3D 0)
>			fail("recvfrom");
>        printf("   =3D> %s \n", buf.Data);

<snip>

>
>     RTMem data("data1", 6, RTMEM_1);
>     ret =3D write(fd, &data, sizeof(data));
>     if (ret !=3D sizeof(data))
>         fail("write");
>     memcpy(data.Data, "datadata", 9);
>     data.Size =3D 9;
>     data.Type =3D RTMEM_2;
>     ret =3D write(fd, &data, sizeof(data));
>     if (ret !=3D sizeof(data))
>         fail("write");

This example code is broken, badly. Please consider what the reader thread =
actually reads, which is definitely not a value, but a descriptor containin=
g a pointer to some value, which the writer thread will overwrite before re=
altime_thread() runs. Which explains the outcome.

At the very least, you should have a distinct RTMem instance to feed each w=
rite() with. This said, since XDDP is by design an inter-stage, inter-proce=
ss IPC, passing process-private pointers in messages looks wrong in the fir=
st place.

--
Philippe.
