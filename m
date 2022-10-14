Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2057.outbound.protection.outlook.com [40.107.135.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D720F8
	for <xenomai@lists.linux.dev>; Fri, 14 Oct 2022 12:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1XurQucwfhX2QGbBJHzwLz9pE679NlTmysBGMHWF+Zi5sxemPGyfjHd0Lb9dX9vh7fSzL0o91EvaVDk/E7vzqmYqLqj0fMxKa4NrqukM9DIKaSTZIHme4Xa63rL4Sebu3X4ks2uO3qFf3JxmLlyeWnMJxwedhagRhi4rksGDVuLAGmHuR7H5q3c7VHJp6ARpPpfOMPrXFj3kw6+m044ATkM6sBU828eomQP+E8SR7yG76Rt7CscBPScShnSbDKt2zlX2BsgjsQC1qP3HerUfE3d/V9ddx7b5teKbH4fMl+DVA54Ax3XF2KASZfE227PiHapJQLS6Z7KqBS1rUzS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4ZiQoRo4kylohNsMyE1fUIjnI2WhZ2Mn7GsrMxGxGI=;
 b=VJOL9mW1o8zKn/tPL0wB2GvKGmacwBS7/3JnahU560rJxqEcHQhuF02ZOkyDLFNNdnfgUyg7rOdyIInx439mSbii66Vj9qW/euPDOVH1eAB43dhDuAv20U76dV4Nf/f7UauOec6JWiT+ZZG78C+tkqQfjZ231Jer1ngfwsAp38G1LoRSUyKES4N3HfW3/VUgL8jbyiYyshubW3ielP/swHeemr6FRf4Q9FInBsMCBYxHIvWzDHoeMIS+u+TpvV0YGm0PixCLig8YtUJ0/waFnUhaiOgvoanIFTEJaGmDlKVVtasiKnLUVGN/muftBPhphJCpA7KNA8ya6+X9XiF/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zwickroell.com; dmarc=pass action=none
 header.from=zwickroell.com; dkim=pass header.d=zwickroell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zwickroell.onmicrosoft.com; s=selector2-zwickroell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4ZiQoRo4kylohNsMyE1fUIjnI2WhZ2Mn7GsrMxGxGI=;
 b=AMYmYmif6OOZZDE1T239XmeLaV0oaOwr8JjuGrTIIixj6qjHSKj8sti744ScHQzu0ctM1vy+/CiQvnOu1bPVcPKffY4XZXBWvVd2+aBisVZztK6YYa0ZoMxYStjPgJ8534YKTE4UoyF8nwfh/z71uqvzhAb6DcpYp0tRc40ahJk=
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:63::8) by
 BE1P281MB2853.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:49::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.8; Fri, 14 Oct 2022 12:49:29 +0000
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ebc0:18f:11d9:51a8]) by FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ebc0:18f:11d9:51a8%5]) with mapi id 15.20.5746.008; Fri, 14 Oct 2022
 12:49:29 +0000
From: "Heber, Stefan" <Stefan.Heber@zwickroell.com>
To: "Zhang, Qiang1" <qiang1.zhang@intel.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>
CC: "Wang, Rick Y" <rick.y.wang@intel.com>, "Chen, Hongzhan"
	<hongzhan.chen@intel.com>
Subject: RE: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Thread-Topic: Memory corruptions upon strcpy and similar when being
 interrupted by scheduler
Thread-Index: Adjfx7M3PckxyrdzSbOwkv1vwf5Nfw==
Date: Fri, 14 Oct 2022 12:49:28 +0000
Message-ID:
 <FR2P281MB2654CD4536C1F2D3592D874EFC249@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zwickroell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2654:EE_|BE1P281MB2853:EE_
x-ms-office365-filtering-correlation-id: 456f407f-e53d-4714-af88-08daade28878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 14t+qobToXrLUodY627k5xa6t5jLORepN3CgIx54LgCEyg/kQ46aF+itsHxCmbKo0HYfMUuVH4zaKroEJ3Oc0gDP78jHS3X9s8rzOnCnPIDmdM6CWup8AbC9sVXZ+N8mDbOxWZMt1L1jNJv1SyBxabsmy8oEWFV/Zxu+WVIsuO87c4UM0tm43s4qH8Cm60ZuxGOU2R5UCXBN4iRsniYlBP3qGr7LvjIuSIYX9tNgXfwUhJi3PKWwHkMD/dOTguwjwGo9Qe/7G1rjbbdgkENTGDLdgPLcotPm3pBy0YoJ7pSghbYOJ62usrDjytKMzaxAaUnMFUElhxrxgAQlcEgqqHWXIKP1wkHfmvia7PBOnl1GylZ/KyH/q92Bf39HUx+DAtWVpG9KcAP5J7+g6GJKadIhzzXwSO0awUHMynFmoVswbvsdRR3sUmcWyU6Q0IIxXWsuQ1VXCJLND0XuavPhouB5rgxfLGQrkfm2dOn0VudGXri6Tjf7ekFAq2ZsvhEWmYv4vvpP5i8/gl2Lba6gkf+ueJFIFjm5d0kJcs5YG9Ok0Xlmgavk+Ajs1SlMUE1GuLAjMBcHBaBjuJPpc4P5ZLuNsh89hGsDVPe3EmHBLSYDGTdXzrGrJKJsf6xRM+r8tdJbxTYuNMZ20BkGKGN/NEwmyiXPtWV+3Oe7qIEDU4qR2G8/jwdOsZCua1KFVGxydr9q1Qwhqscns3Y6rJvQOcvC4MNU1ZHm58meTz0nbG7a8yBvqOhqCDat00uYhdtFACWdwMAh2LWNKYvMe2HL9A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(376002)(346002)(366004)(396003)(451199015)(478600001)(7696005)(6506007)(53546011)(9686003)(26005)(186003)(76116006)(2906002)(55016003)(33656002)(52536014)(64756008)(66476007)(38100700002)(122000001)(8936002)(66446008)(38070700005)(8676002)(41300700001)(66946007)(5660300002)(66556008)(71200400001)(54906003)(86362001)(316002)(83380400001)(110136005)(66574015)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8pIUXGLBt/Wfj+HdzLEMB0OLcR8nFJXpkWv7nW43vC+hH7qeWyRlK+2+GJ?=
 =?iso-8859-1?Q?jnmViH4yoxUUvDBGnk2k9aYG2DwVdmIEm/y/grjp/TdVRVpkaCq8eb+Qma?=
 =?iso-8859-1?Q?4d2msKPQk+vmMMyTQzyk6HdKyH6PKYQ+g8z2Fcx2FeWttEIWXdT9tf7Pqn?=
 =?iso-8859-1?Q?BmXlt8J2+GWR9+GYDLfvdudqqY6ZE4lJX4b4lPNJk4JAg3jvzg8qrwSJHA?=
 =?iso-8859-1?Q?ZjEGOGhfIEwbJYMmhVqitLzXG7PVxuz2M0zfDyrkvaBOJeYXCwQw2WkT58?=
 =?iso-8859-1?Q?2zmn1CvOujucCyEYSRNNk/qXztZGSgGcax57Uh2PimBpbA52l/w3SNEuG9?=
 =?iso-8859-1?Q?or2SJg+AWoifD4oxN38cYTa0xwJXWA0J3UQeJ2+KSPx5iFiqzUMM4wWkGz?=
 =?iso-8859-1?Q?LedC+wu0Ix+fjW5ZfD/KOepKgG2agSe8t5PA6R+CwuzI8rihuktDH4MF65?=
 =?iso-8859-1?Q?qmhIWMlE2Qi4nSudCJup6YaGpGGZERNRcERsthTQS1MCSC9kOet86PeTT6?=
 =?iso-8859-1?Q?JTW83ttCZRy7cZggquW2VdNRF2E66w6xWEn3m3OieaEiVwbzwrAa27wfhP?=
 =?iso-8859-1?Q?u6ABJyEjS08nJmQPaYkjuI+jz6tdyQ5L78IoIDYW8jOXFMO5R1tl8NKceB?=
 =?iso-8859-1?Q?6L7IWgP8EqWNCdrnCUpgKZkzX/2CNLRlGNYmTobUUVfkbEYP/E8NSQWhWw?=
 =?iso-8859-1?Q?80B0w9AZOdTYIhBg8mFKeRmHGPoVxcDmXfqE+Oa+reRpKMnr+2IGfuAiQt?=
 =?iso-8859-1?Q?gbhE4+6e0n7JTaLZOmoF9wWhE76mK4xBRdocq1YTSmG518thHKDwq+BM0d?=
 =?iso-8859-1?Q?tf51V/aTbJPeUUA3VKW5vYuAnIuZw32GPEkWawtBGKDvNOz9Ew6J94LPDB?=
 =?iso-8859-1?Q?zrOlL6BwYlAAvGeEi3OSaHxwudjsBT1YRL1bEzCj3uDTI6mw+jP32bkWkP?=
 =?iso-8859-1?Q?6qjF1CODoLXfgNcjIxzczyHLLWU35pkBjPL2Yv6YJoRyLAn7M36rAnI8Cw?=
 =?iso-8859-1?Q?nz5Jy//GrCoKoFSd9xIajFclTpuGlrovm0KF2blmRTJZ92e8REaUaWIoJ4?=
 =?iso-8859-1?Q?rk+baot0XOQEPNOxeQciTq+Fe18L/m+Nt95orqaB0iuNu7b+niPRPEciI2?=
 =?iso-8859-1?Q?y+FxPx4nNzp1Jcayh9Akktn28lKOOypLnENIBj0vW6nOCWlo2WvnryCrcg?=
 =?iso-8859-1?Q?En3OJan+cjFjn3DLUAC4UYcxwKs9u1r/Pk/THNOWD2NJazXYdVTGtgkS28?=
 =?iso-8859-1?Q?JcP5382/fefaDhXiKfEd6qGOXSeDxVlgkWPLnYv1VtE5ScEDDSPNqSblav?=
 =?iso-8859-1?Q?+ohH30o5U+tnzavcs7jJnmlqnf1vRM3qQwP+n4vmuEDcPMTF6kJwhHprBL?=
 =?iso-8859-1?Q?rca9JkK03DHBM9+jRQkDzXY7xoreAF6OpbDvcYxjKHQYw0DEDiDEJyQf9l?=
 =?iso-8859-1?Q?Bc9MhGXcKZ/0lK46uCKxIZmL94ys3Z0ozuvHaWxjsQSuOKN1kx7GRVp1a9?=
 =?iso-8859-1?Q?q8HSvMC4JCWwmSlzga2Y2RGL4dzGhiOqMQJlgoVyyKJ0ge5B0GEV6TrXzM?=
 =?iso-8859-1?Q?td/ynvjUYefEZUaauejoL+tl9j7hmYXS8WzhF7o7VmgrfZRjvHkshl3h3N?=
 =?iso-8859-1?Q?+zRiz8kpxNDaZ/ihtZ5UXN0TobQk9gdAo/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: zwickroell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 456f407f-e53d-4714-af88-08daade28878
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 12:49:28.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 538edf66-8fb7-4bad-8608-a521ab580ca0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytgN0Fgr7YAo5QBO00p7Y5JfTjzk93Q9/fpNaRKEeA8Ig0QrNy1DRh6DReVPtsmiaE6SuFBnSu2khFYwHhEuza61IRH4FFzH+JcDf/r50PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2853

Hi Zqiang,

We' re glad to hear that someone else can reproduce our problem.
The problem disappears with your modification (move simple_allocator_init()=
 after pthread_setschedparam()) on our system, too.

We don't understand why this modification helps. Maybe we do when someone f=
ound the root cause.

Thanks
Stefan


-----Urspr=FCngliche Nachricht-----
Von: Zhang, Qiang1 <qiang1.zhang@intel.com>=20
Gesendet: Freitag, 14. Oktober 2022 11:28
An: Heber, Stefan <Stefan.Heber@zwickroell.com>; xenomai@lists.linux.dev; K=
iszka, Jan <jan.kiszka@siemens.com>; rpm@xenomai.org
Cc: Wang, Rick Y <rick.y.wang@intel.com>; Chen, Hongzhan <hongzhan.chen@int=
el.com>
Betreff: RE: Memory corruptions upon strcpy and similar when being interrup=
ted by scheduler


-----Original Message-----
From: Heber, Stefan <Stefan.Heber@zwickroell.com>=20
Sent: Friday, September 30, 2022 7:47 PM
To: xenomai@lists.linux.dev
Subject: Memory corruptions upon strcpy and similar when being interrupted =
by scheduler

Dear list,

we, as long time Xenomai users now have a severe problem. We are currently
in the process of migrating our huge application from xenomai 2.6.4 32bit=20
to 3.2.2 64bit (linux 5.4.105). In general we are almost done, but one=20
problem remains: Obviously we have memory corruptions resulting from=20
strcpy functions (transferring large configurations) being interrupted by=20
high prio tasks.

We now nailed this problem down in two minimal test applications in order=20
to rule out any programming errors in our own sources. These two=20
applications are:
a) a simple test that swaps two very large strings forth and back via=20
strcpy (and alternatively other copy implementations) and then check the=20
string contents. This simply happens on the main thread.
b) a "sleepproc" app that simply contains a while/nanosleep loop that=20
wakes up every 500ms just in order to interrupt app a).





Hi Heber, Stefan

I tested according to the steps a), b) you described, and I also can reprod=
uce this problem.

(xenomai-v3.2.1,  linux-5.4.105, ipipe-core-5.4.105-x86-4.patch)
The test method used is as follows:
after launching  txr19391sleepproc, run test.sh
copy methods: memcpy

#!/bin/bash

for host in {1..20000}
do
        ./txr19391test
done

# ./test.sh
ok
ok
ok
ok
error at position 40473600 of string S1: expected 98, actual: -56

but after I made changes to the code

about  txr19391test.c:
I only move simple_allocator_init() after pthread_setschedparam()

use test.sh to test it, this problem cannot reproduce.
But I haven't found the root cause yet,  You can test it according to my mo=
dification to
see if it can be reproduced.
Maybe Jan and Philippe  will have some ideas.

Thanks
Zqiang





When running the test app while sleepproc is running we see sporadically=20
errors (typically less than 20 runs of test until we see that error).=20
Without the sleepproc app, test runs without errors. And don't worry=20
about this magic txr19391 prefix, it is just an issue number ;-)

So, could you please help us and have a look into this problem?

Some remarks:
- The test seems to be highly sensitive concerning timing. So we had to=20
fine-tune a lot to see the error in this minimal test. Also it seems that=20
even the CPU may influence performance enough to make the error=20
disappear. Another weird thing is, that if we let the sleepproc sleep=20
100ms rather than 500ms the error disappears.
- In the test we can either work with individual mallocs for the needed=20
3 string buffers or with one large malloc and specific "pool allocations"=20
from that large pool buffer. We can see the error only, if we use the=20
pool approach (see the two options in the code switchable by commenting/
discommenting).
- We tested 5 different copy methods: strcpy, memcpy, two types of while=20
loops, one for-loop. We can only see the error with strcpy, memcpy and=20
for-loop. (also here: see the options in the code). Maybe that depends on=20
timing, maybe it depends on the implementation ... we don't know.

CPUs we tested on (all with more or less the same kernel config):=20
- Intel(R) Core(TM) i5-8400H CPU @ 2.50GHz, 4 cores
- Intel(R) Core(TM) i7-7820EQ CPU @ 3.00GHz, 4 cores
- Intel(R) Core(TM) i7-4700EQ CPU @ 2.40GHz, 4 cores
- Intel(R) Atom(TM) CPU D525 @ 1.80GHz, 2 cores ... here we couldn't tune=20
  it such that the error appears

So, thanks in advance and, btw, thanks a lot for your excellent work=20
during the last >15 years!

Best regards
Stefan
