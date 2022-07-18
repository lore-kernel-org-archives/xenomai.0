Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AA46BB
	for <xenomai@lists.linux.dev>; Mon, 18 Jul 2022 23:03:57 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id D6B7E100003
	for <xenomai@lists.linux.dev>; Mon, 18 Jul 2022 23:03:48 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 9BFE4941D9A
	for <xenomai@xenomai.org>; Mon, 18 Jul 2022 23:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP4FD9Qgtr8ALJzI72LqSHwuO8wlM0CIPxaWj+u7fMfi3lbv4GvhNE2nUj7jGxAkJ/Mu7qLdEWuPDajE9viy23SzQhbCV1rS+q7lOEkq2FRRETJQe17VdVzFPN9U6mFb4ZSzFjmwWaSuN3cJk22ODF1uVyMWz5TMpLYZl/8jZX8b1Ql3GM6YFYdQJF6b2cnfMQpgXnU97oqCOY3v6u/2pzscN3jG2yfcuMQwGJy8P7LsWx7nDu5591WAYRo0XHdM5MsMBXqMcmkVi+gCWykNWQG1pPvBRmtSgnpdolEr398myaog8ojaq9aY2LZkJypFqZlX7rzsfC88YlJRF9SMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xReDkD3N9hv3cFb5arDKUp56R/HC1u7trd5ycArS+4=;
 b=Ei3193gCTD2+HXNBlrz1BsABevvYqLsZeMxavsQe4Ce93vV2qtW7CVVJHSViMosOdWSevPgMlcwtYrvDi6x6TSxIDupDM/jDyos0yM6jEzKKCtApg8vX9HpEwmjOxCzlhtCqTMyHojI/ZqyJGIJ51umJsJF7XJfDVqARBLeBg/BJ9FbivTy6Ab5fiv1hKRkwmK2EXRqreaJUv4yMwyRuuDM9Wse7rWB2NjNg5FJIfUw3PLfBX3onwMkrbLhFfAt+fkn2Orbx/4qAIvKfdgjua+fpWt6WbeshCxz5uHq2HuJN1zdiwXP00uEF5ZMQM3kFJPS5vOmqeMT9dwBb5kpvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=omron.com; dmarc=pass action=none header.from=omron.com;
 dkim=pass header.d=omron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=omrongroup.onmicrosoft.com; s=selector2-omrongroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xReDkD3N9hv3cFb5arDKUp56R/HC1u7trd5ycArS+4=;
 b=V96iVjLDHimH3kHaI8FxSOjGMGfOknPRVZHHz3MQvA91CrkeEY/pk89XMhKUtmrHGyC+eB/nAbMtIzeyXMKn+hNhrTe4K4mcTUCky1sSTecUFvSrom4EnYNm9FdV9wJC9SOrTj5mhPLoQ/K1Pjl1yubAIHZC8J2hD3OXqUFrNmc=
Received: from OSZP286MB1823.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:166::5)
 by TYCP286MB1443.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 23:03:43 +0000
Received: from OSZP286MB1823.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ac2d:cdaf:249e:7502]) by OSZP286MB1823.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ac2d:cdaf:249e:7502%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 23:03:43 +0000
From: "nihar.unadkat@omron.com" <nihar.unadkat@omron.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject:
 =?Windows-1252?Q?RE:_How_to_POST_an_OOB_Kernel_semaphore_to_an_=93in_band?=
 =?Windows-1252?Q?=94_User_space_thread_in_DOVETAIL/XENOMAI_4?=
Thread-Topic:
 =?Windows-1252?Q?RE:_How_to_POST_an_OOB_Kernel_semaphore_to_an_=93in_band?=
 =?Windows-1252?Q?=94_User_space_thread_in_DOVETAIL/XENOMAI_4?=
Thread-Index: Adia+n0bgwhrCsZxR9eNIU4Ge/GoKA==
Date: Mon, 18 Jul 2022 23:03:43 +0000
Message-ID:
 <OSZP286MB1823283BC7739F3CF2D76091F68C9@OSZP286MB1823.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eca443f3-fa81-461f-a661-08da6911c34f
x-ms-traffictypediagnostic: TYCP286MB1443:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yxtYT1dcaQdbhufruntGuFrY0gQsvUFxVlz8sTxUkq38Tnl6Z7vGMpqy+lg7GWzrdUl4TF7vKVM0ZGWHBBqaYUMvuM8QLUOdoOrQJ4WUqLixhvBvU0uISPVmkf9Phl69SHkF36EI0eqaa9V0S9OSkEPPd5DPa8QSFZLzza1Vwa3M7UIJjYTervpmTuPLpzycQXkDb2fMGhowmBauh1U5lOv40nJEBDZuZvlVW+U6IF5TKt4LnZrWDFA+O0ASK8xoqpDDHxfqvhMcNOLiy8AmapmPSL02e+2Tat6I7dhntsF5ESnAEj0DcHN8bBCHrfgItb3Q/HRuIlpf7Ki6KQgTUmsc871Hz5Tr8TaEC+6zK2iFD1fV8qAvLrgkRkF2S5u8UgfxReN6XE+eePt2t92Bg8KaRP1dt3pmfYQ0n8m/64DiKLcltD4rIGsO8euIMGRNYig+1zX6Ve24QZSw4bWhk1rlNRQhQru3iSIx0I5ESSpIr628XRbK0dZz4aABDt0j0myGD6Rwgy7Y18G/mpKAh3MlAQ99J1n2egKbqoPydYfxdG9FfDP48Un2NaEZpNNY4p5Ew0fJWhutU7zZM0+Ka+s+/GbK+ZkRCRVWsNMG+BzPx/ZNRN4mIYx9vMReAHPy0ie2MXfPaptZE6wf7KGavZVG5OaG+NjHcJyWGEZwAaE8QPNtU6WjfohxBRVmZe2JJdHE/wBKn0+FdvbIafiMAECOT/2NJfp55yMXaDS56ZuSkWEp3n5sacBUHrog8mTA8W8xsukeFL/JIf4DxT2MzmPK7lXTm8MwuA7R/6EUV74=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1823.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(136003)(396003)(366004)(71200400001)(41300700001)(478600001)(186003)(9686003)(122000001)(6506007)(38100700002)(38070700005)(7696005)(66476007)(83380400001)(66946007)(76116006)(33656002)(2906002)(55016003)(8936002)(5660300002)(52536014)(64756008)(66446008)(316002)(66556008)(6916009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?jbMkl8jHLJr5apSKgXP1Mhe7dH/NEDZ7R9X7JvbWBfObYZ1RaQu/LfvJ?=
 =?Windows-1252?Q?f3fyeyRLyyzG5OhyliEdzyzvfSxGRrGRv5/dnKb35+n+1vMZSdd28yPj?=
 =?Windows-1252?Q?cY27nxJ3ZPEbIL4jA5hqsb8VKa5V0u9nTL1XR85vRepRXguQEsg4waG1?=
 =?Windows-1252?Q?VHK50YSDOGta0tmyRYGj9XP53Iid2uunD0TyG7UixvSzUw2oCGCR8rMe?=
 =?Windows-1252?Q?qTAn4A96mWacr2I4KZNwaLQScajoF7Lf7vFtqBaeSyaAGrDTMevyesBS?=
 =?Windows-1252?Q?2UgaOfYxSsMLBx7TvkaAXXM4j+197FJqfGIUjz1W2I5P8C1wXDGeO/20?=
 =?Windows-1252?Q?f1TEXy1Z6Ov9hGciVr9wqu/tqd8RCshVRgIsXT4npBTekVkdlFi+OKQM?=
 =?Windows-1252?Q?hyF7QHYLlaCr/cNIwl3zvCENJqpy9/4zHWfsK7/Y0voljxydSXSrQzsQ?=
 =?Windows-1252?Q?7T88tAIeMYkWbNQdp1gJVN1cb4UK+O4eOuVv8eiLcp7gahmvu/ryXAEF?=
 =?Windows-1252?Q?aSDd7v4qHTmZXKGe6IKQecnc0FG2jon+xsIN2xz45PYd1/5ukxGvU3eG?=
 =?Windows-1252?Q?OStMrwAqUbSSvb5Qh2aY6lxxtUK8yAP1JrROFFghPR8wnDh30LzP84e5?=
 =?Windows-1252?Q?B4rv4TbaNXOpGWb+9EmcY1Y6kJlQbbz2/VLUVJNKUKWzrrtLAAjtHIby?=
 =?Windows-1252?Q?OUS/pbMXIDtMTWGjZeiTKyfWhe/4IhkrUPyAJ7aCb9k82vr6ynNH/ptE?=
 =?Windows-1252?Q?bSwP9kA55WjW5AW9Zjt+YtRxVDRU0mI4ppMMiXhoogrlfMd+/VBOxL/r?=
 =?Windows-1252?Q?obkFTu+Joz6YYbZd2y+4Cn47ibCz6QAh8br/nC+Skh6ANckiZ1iMWDf7?=
 =?Windows-1252?Q?vwhidRm6+A7vo5znoP9TnxTzjbbhkB+DdhE0rIq7j0fV1sGUhwQtzBwq?=
 =?Windows-1252?Q?yooGLT2Eaj2JtAV0DzaBM8GVceIczHaLQX1bdtmIss4Wffgyec1vO9s9?=
 =?Windows-1252?Q?61HUhpOCbKF04ixIIBr0kCuDi/BOq+jnV3FE834r+3KbhVO05e9BsqBl?=
 =?Windows-1252?Q?EGYjH+pE48npPORiHIyPv1VUwjjctzPAgevgq7nKc4b4u7ccx+h9WIof?=
 =?Windows-1252?Q?hNbLfIkiq+GKIaRpkMwVXo+j2uzlwFLncqXvHxYVDj5W/ozL2F9jtB4s?=
 =?Windows-1252?Q?c/x13q96ovX5idOl4ktroOI8BD9UFhTk8YYgFfOLqejVSAV6Un2OC26W?=
 =?Windows-1252?Q?zFutRiAtGaYof2JAh7jfmp7TCLf78Ardtf+JiXdc2Yu18/0bYZwu31B2?=
 =?Windows-1252?Q?PMKxcDFmETycHHNN60MMGG92jtHga4FXobamThQXWPw3GcePU/JqIBPF?=
 =?Windows-1252?Q?aI9ZvyLOaBsTwB8zOm8H8IoReXSQvUb2iy/ldfQe5cK/Xx2uJu0dJVYL?=
 =?Windows-1252?Q?ZWJ4iYCDGPIzC7FPYj4pNLwk3VPoD722Dtm17sEkG5udNqlhiExk0J9+?=
 =?Windows-1252?Q?eD7LVvam+uUbb34briJzpTQEtxuSYgW2NuNgQ6kjx6VdiSva7/qzroij?=
 =?Windows-1252?Q?jcLAh1H5dJ1p4nIoGsWpsE7f3zVSFTe8HM5ZlOyk3budA4Rc6nZH2VYj?=
 =?Windows-1252?Q?QHXmk6Sf1sEiUiDoAdomzti4mNn63mFmBiDJMI5cII4fn8cX/iJbEtUi?=
 =?Windows-1252?Q?C+likQ0iXUZ33+qJARUMfFLKeqstRwpRuvPNM+Tdgv0d1b8D0Jti5C3Q?=
 =?Windows-1252?Q?7R+fo8/9VTTiDMryL/D/D+vdRjUdGYdwPw8mbFRI?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: omron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1823.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eca443f3-fa81-461f-a661-08da6911c34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 23:03:43.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ecff5a9-4bef-4a7b-96ec-a96579b4ac37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LeohEoYDTOujQH4neHooKWOK41zjylBH7PPkBwlHPtIm4fr2NjPZlc00Xd+FH1rEvIj/7gwFfwiB3i5gtY9hJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1443
Received-SPF: pass (spool1: domain of omron.com designates 40.107.114.115 as permitted sender) client-ip=40.107.114.115; envelope-from=nihar.unadkat@omron.com; helo=JPN01-TYC-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=omrongroup.onmicrosoft.com header.s=selector2-omrongroup-onmicrosoft-com header.b=V96iVjLD;
	spf=pass (spool.mail.gandi.net: domain of nihar.unadkat@omron.com designates 40.107.114.115 as permitted sender) smtp.mailfrom=nihar.unadkat@omron.com;
	dmarc=pass (policy=none) header.from=omron.com

We would like to know how to POST an OOB Kernel semaphore to an =93in band=
=94 User space thread. We are currently using PREEMPT-RT up/down semaphores=
 in and in band IOCTL function with the User space thread making the IOCTL =
calls to the up/down.=20

See the example code below: NOTE everything below this is PREEMPT-RT

THIS CODE IS IN KERNEL SPACE:

// define which file operations are supported
static const struct file_operations rtpmac_fops =3D
{
=A0 .open=A0 =3D rtpmac_open,
=A0 .release =3D rtpmac_release,
=A0 .unlocked_ioctl =3D rtpmac_ioctl,
=A0 .mmap =3D rtpmac_mmap
};

static long rtpmac_ioctl(struct file* file, unsigned int cmd, unsigned long=
 arg)
{
=A0 switch (cmd)
=A0 {
=A0=A0=A0 case IOCTL_RTINT_CPLC_SEM_POST:
=A0=A0=A0=A0 =A0if(RtiCplc_sem.count =3D=3D 0)
=A0=A0=A0=A0=A0=A0 =A0=A0up(&RtiCplc_sem);=A0=A0 =A0
=A0=A0=A0=A0=A0=A0break;
=A0=A0=A0 case IOCTL_RTINT_CPLC_SEM_WAIT:
=A0=A0 =A0=A0=A0down(&RtiCplc_sem);
=A0=A0=A0=A0=A0 break;

=A0=A0=A0 // other calls from another User In Band thread
=A0 }
}

This is to create the Semaphore
sema_init(&RtiCplc_sem, 0);

This is how we are creating PREEMPT-RT ISR
request_irq(phaseirq, (irq_handler_t)&phaseintr_handler, IRQF_NO_THREAD, "U=
BUS_Phase", &phasecookie);

This is the post from OOB Kernel side ISR
if(RtiCplc_sem.count =3D=3D 0)
=A0=A0=A0=A0 up(&RtiCplc_sem);


THIS CODE IS IN USERSPACE:
This how we create the "in band" User space thread:=20

pthread_attr_init(&rtithread_attr);
pthread_attr_setinheritsched(&rtithread_attr, PTHREAD_EXPLICIT_SCHED);
pthread_attr_setschedpolicy(&rtithread_attr, SCHED_FIFO);
rtithread_param.sched_priority =3D sched_get_priority_max(SCHED_FIFO) - 1;
if (pthread_attr_setschedparam(&rtithread_attr, &rtithread_param) =3D=3D 0)
=A0 =A0 rtithread_status =3D pthread_create(&rtithread_thread_id, &rtithrea=
d_attr, &pRtiThread, NULL);

#This is the User space thread IOCTL call
while (rti_thread_run)
{
=A0=A0=A0 ioctl(iortfd, IOCTL_RTINT_CPLC_SEM_WAIT,NULL, 0); // This is an i=
n band Kernel ioctl call
}


# This is the current DoveTail OOB ISR=20
request_irq(phaseirq, (irq_handler_t)&phaseintr_handler, IRQF_OOB, "UBUS_Ph=
ase", &phasecookie);


Using the code above we are trying to figure out how to the same using DOVE=
TAIL/XENOMAI 4

NOTE: We are currently using Kernel version 5.15.0
uname -a=20
Linux ppmac64 5.15.0 #19 SMP PREEMPT IRQPIPE Tue Jun 28 17:00:39 PDT 2022 a=
arch64 aarch64 aarch64 GNU/Linux

Please provide any feedback it would be greatly appreciated.

Thank you.

