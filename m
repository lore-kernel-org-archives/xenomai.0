Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D337B
	for <xenomai@lists.linux.dev>; Wed, 18 Jan 2023 16:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKfDA51Tbhb0dR3dhGPCuLz/OHGqg6oZayT+DgupegKO8kthV5pcwPXO960L8WDGVynfDDG6p1HAUDR798eeO8mwpXJGtulr65sWRMygrvPzB4xvzmx5gPj00pjZr7bJcN3UlfjyGUF74F5cbcGoxurUDY8bACpO1nY7I05V7hIKBXhTBHEinkxptdUVpDSTD2Z9MCB08rnYalUsCjvceQ0rDEcwIKKrCq2pW2ucSCNKupDq2w7STjFGvxInNeTGxGjeCDPc3WpnAy1aKy3n7ticQW8k2jbPtwOi8GOWQHkHswjldrkFLWCfDxs1vq+iMV3WUph9ErMhK8Xp03ImMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK5lm1nWOmjJ0UwqRShrNxlhyulZMHlg5z568IP6+b8=;
 b=Id7bLTIGxMhOJ/e26AGHfuEaUItW+mSMhcefR86W2wVV7lsgw07Itt0GMpTCbPeAXeXRKEqb7JW6f0o0Lk62ga/pk/HZWKimStVnnF5so8qaa+cDfQ4/UWcianZe9Exl0T/ys6JHvILc94SwfCToN6yinVGujxj6q6CtULRFKBmiClgr9NUBfoa0fMb1n+zHD6Ib7qglvc/U4MxBT8BBINmCdgNlVQ3DwO9rKh7CUCGsrSQOHOnSu903WhJViGkJrIb2hQFCnoV/u5x4pnNUsN4/V2hJhwDP2tS3W5FVJUV0C6+63rv8LZM1aPs1oqTR5/1jkMNaSl20Re+OnjwADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boschrexroth.nl; dmarc=pass action=none
 header.from=boschrexroth.nl; dkim=pass header.d=boschrexroth.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boschrexroth.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK5lm1nWOmjJ0UwqRShrNxlhyulZMHlg5z568IP6+b8=;
 b=MHud7a8SmLfUKv8NINK3y6SWg0lHNNsS0z2yxw9NOcXKNrjGfbJT25s5IbuNf0dYC/UmC+jTCF+Rf9u6EE2FSRFVzroliJQIJJDuwXPHY3IQ/FR2H1eFYU2UK6cJuJyK5AgMS/XzCjPa/L/En0MzyrcOqhPvpFOlDGg20mbzROQ=
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f::29)
 by DB9PR10MB5932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 16:44:46 +0000
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd8e:ce70:2cb:b314]) by DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd8e:ce70:2cb:b314%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 16:44:46 +0000
From: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>
To: Greg Gallagher <greg@embeddedgreg.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: RE: Process hangs after upgrade
Thread-Topic: Process hangs after upgrade
Thread-Index:
 AdkmmhngNDTyhWzyQbyfaaWtTlh5HwAvDIgAAAZCn4AAANE2gACdjIcAACpMHCAABfRbAAAsg49A
Date: Wed, 18 Jan 2023 16:44:46 +0000
Message-ID:
 <DB7PR10MB2459D0CB902662E6C5B5A6ABECC79@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
References:
 <DB7PR10MB245971E67E0E4183BD4D4F5CECFD9@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <ed5d41d3-cadc-67dd-72b7-bbe680d36134@siemens.com>
 <CALLqZ8SU192LLP+8noH1QeK1Djvi8E+xRi8r172pXhp99604eg@mail.gmail.com>
 <b401122e-7d0d-b63a-2689-81bd4284af8b@siemens.com>
 <CALLqZ8T1s9KN_s0=5u0=up-8E-KLx0L0rbRK=zZT4ybc4B9i0A@mail.gmail.com>
 <DB7PR10MB245911DDA609584F8C2682D1ECC69@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <CALLqZ8RMnou=0s-2Hcq-Xm5R7j3HVYNbN=aMHCPcHzY6ZfPJGg@mail.gmail.com>
In-Reply-To:
 <CALLqZ8RMnou=0s-2Hcq-Xm5R7j3HVYNbN=aMHCPcHzY6ZfPJGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boschrexroth.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2459:EE_|DB9PR10MB5932:EE_
x-ms-office365-filtering-correlation-id: 01c95f2f-c505-41be-f60e-08daf9734ebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hd+v9VOe7arRYX5K13Hef5EMc9pogMPYK2yiEcB5DjReSLPG6fWQUgzGPdbf/V1Scio9xuJv/NoCJ4Ej0LCEAgto+/sFsDrNgcV8zfwIQLvTetkZjbDS90LIehpSm9OoBVFpcWSKU0Zm11ACvd7r2WJGJ/3p3nIIxLwaOiSfOyRFg2C5dwjjiHaqzh+Xjas0Ttp05DoJ5peKrjjACxjKL7lIUVzWJ9Jj+CDOu1ii4HxVONUxVBMUpznX4kyJFhvSAj3giUmmugsp77TnTbt/M1jWFDv8engWG8SfUVAzK3F8UQ8+Enqns5sObUb6+VXYbj9RPF7hp4Yl+zRYxy4FtqpWAIPdBl4e22e0C0278YLx1bwZz0eg5bzw3KxElPUxFdUoQtjbcXcCPkU3yiLkDmT3O4KfmPZnzaKkuPdfn5k2+Oro0vHKmpQCKT/6lrf7AyHHuxfdmRJdFsP91AId5UZa4DyhPm3Jk6dRmbqYc25seTPNzheirxumPGWztHFK58RuQsIrjxlM1C+eYlb7+B3PW7JpOFZMnNNBVhf4s9kStla2wPLzmRPr2CZ2k5YusYoys3JFERWGN6WbHRULsf7nLFqDCT55iQWelhFXDoHHHnsjIQ19RpQr0fVeLNpuAa+1S2kclMiGu+PfTESTLBC6SWEoOeyLTjTP72jcHz1eoHUj4ZE94BY2NIOt6niRuLCzxwFOm9kL6EearE+V+DvAr8ZKdpYdnCkPiOQNgK8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(26005)(82960400001)(45080400002)(478600001)(966005)(41300700001)(38070700005)(66446008)(38100700002)(33656002)(186003)(86362001)(71200400001)(316002)(54906003)(66556008)(66476007)(55016003)(7696005)(66946007)(76116006)(53546011)(3480700007)(6506007)(2906002)(5660300002)(4326008)(6916009)(9686003)(64756008)(83380400001)(8936002)(8676002)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QEj2RWn++0IRnu3SdOvFUxwhDGPVujiaMdlseejnzankDlmdIJi8+VFr+2Fe?=
 =?us-ascii?Q?cZo25Ysum9j/2BufZDUttHaDkUMX3GJLOXaj+eiSslFc1/4fSmSkzpMxBGAY?=
 =?us-ascii?Q?oklCOWfqT47tVXyFOIPIqnQiiTeG++slO43X8M8sxoNsen9Yho0d1dY9OxfD?=
 =?us-ascii?Q?kHQLX4i6sv+X7C+c53t7AtApJRwrD0sqxI0hIPEy8+kPzYbQjf0EJCnM6CUb?=
 =?us-ascii?Q?v+83U4r3wDkpRDFrUyWsTxdrbOSKKdnbgegAkx5Aty2Yo1WN4RYCJ7P78iEc?=
 =?us-ascii?Q?AbrTOXTvWsUFcpdzf2ZwbTsb0SJLoXQu7wuwKO5BACJ6gR+fUUCHqP6ySia5?=
 =?us-ascii?Q?KhkU6CLumLNXg54wxGVKffA8KZhK2vS8Y/rgU3yo/otM7UKmvXmY8yEiu+Ec?=
 =?us-ascii?Q?ns/u3QB+Fi7dMDrwEftQSyI8fBp7nuEJxObconbs8CG/novTi7VhIOIoZpUO?=
 =?us-ascii?Q?1zxN9UNjcuKRxsqNYnaYAnkVwSifSEPWW9Ik+hL45sR24mGePh8x1Gr91Cok?=
 =?us-ascii?Q?OrBDU6w6md08usKIlAJVjpgZq0VugILITRrWUZ35XYiea0CHLKVCpNPxe+vW?=
 =?us-ascii?Q?FMCPne8sIYXa5R+fKkTmjv2Z45IU9pPzgzi4jS9+dLJbMUsjaI8bXtrBOLf7?=
 =?us-ascii?Q?QEBoGyksalkhzTZhOqcXkbxXbEB06T7JrlRgjmP1MuVr9dIns1FFV8Ub7+no?=
 =?us-ascii?Q?KqtRe9E7uSR7+jKPXGRqfPjY2F79nREG7YyuijLT+x2iLMQcRABWNYewweAC?=
 =?us-ascii?Q?r1Zy11wblH+byLB1lQbjDBl8EPPCHbYGZE+7e2XZMCxyrt4Vnj6nQIiv6rmv?=
 =?us-ascii?Q?NaKRYXVWS1S9kCmOxvt1XSQ7TFdwi5BaOQtCUq2xfb2Wh/uxg3ByN42GNadG?=
 =?us-ascii?Q?kt2bRo9fCQLSGsG7bgTrCrjBZ/W98QDrKtV8FMAO3mI/5AaWfNx4O2NTL1Qt?=
 =?us-ascii?Q?J9aqYMSuXq9/D1pcSC6BnRoGAPaLVsZuOGSfJy5a3Fg3G3Sbw8nHdg3lzxFo?=
 =?us-ascii?Q?nbTqYUVEpq7V+ZHzwceItsLh9+UJV27fbGgdf5QeoESHL63VoXCClSy2NXUg?=
 =?us-ascii?Q?n0zk6mMd4IORuGd4bi3cQNxP3k2Ggpub8VmV5Id893UYP1FDYYoju4XzYgMa?=
 =?us-ascii?Q?T/JJdp9qPVghc9pxz40J8uBxxlLbO852mNi3KDJ59gMgM+4D09npcIF8atvM?=
 =?us-ascii?Q?Hm00XRNXHC4i+mWKeHq7m35QEso7WEwrG8pMQ6KdnI3Q5SiaYVnuRfLIJ7oy?=
 =?us-ascii?Q?eLV+wodWl/7JyDu5p+zIoTt+tHNxVv7r6zoJtch5C8T3GmJHeergeJfCi6x5?=
 =?us-ascii?Q?+p6+AeQ8QWwgDuOVKhDkzvwFakdf2HyU+0QUrBmJ3Ki123xsCNm1kbBrGDKn?=
 =?us-ascii?Q?BmuClQRx8chQPMKFrbIUgXRnfCscA1UebLjCjdU77ooE4qpP5mFdSO4hpiPV?=
 =?us-ascii?Q?1QtvZyjoRv3q6PBB6HhJx4TmaXEx7Vxd4LsjqOulolXAlvbqiC17pm5tbfJK?=
 =?us-ascii?Q?va8Gxlri+QOAdK7v1MQzyXe123woRgzwLK89jMI+0lSRkUWpckcPy9mGfyMv?=
 =?us-ascii?Q?D8uV4+D/Y5+gK7ND7UM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: boschrexroth.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c95f2f-c505-41be-f60e-08daf9734ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 16:44:46.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc1uImV9WZorI1Gc3A3sLbui/LnT8P9YiAy5sllsNxki2pZXRwL//4ZgmQd0s4L8CjmmoueoEIfXJD0pdnWunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5932

>On Tue, Jan 17, 2023 at 12:03 PM Schuman Eelco (DC-AE/ESW5) <Eelco.Schuman=
@boschrexroth.nl> wrote:
>>
>> > On Fri, Jan 13, 2023 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
>> > >
>> > > On 13.01.23 17:51, Greg Gallagher wrote:
>> > > On Fri, Jan 13, 2023 at 8:52 AM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
>> > > >
>> >> > > On 12.01.23 16:26, Schuman Eelco (DC-AE/ESW5) wrote:
>> >> >>> Hi,
>> >> >>>
>> >> >>> I'm trying to upgrade a system from Linux 4.4 to v5.10.y-dovetail=
 with Xenomai 3.2.2 on a Zynq 7000 ARMv7 board.
>> >> >>> I'm seeing scheduling problems, e.g. sleep 1 does not finish.
>> >> >>>
>> >> >>> The IRQ pipeline torture tests run OK:
>> >> >>> [    0.992675] Starting IRQ pipeline tests...
>> >> >>> [    0.992687] IRQ pipeline: high-priority torture stage added.
>> >> >>> [    1.005789] irq_pipeline-torture: CPU0 initiates stop_machine(=
)
>> >> >>> [    1.011772] irq_pipeline-torture: CPU1 responds to stop_machin=
e()
>> >> >>> [    1.021390] CPU1: proxy tick device registered (325.00MHz)
>> >> >>> [    1.026881] CPU0: proxy tick device registered (325.00MHz)
>> >> >>> [    1.035773] irq_pipeline-torture: CPU0: irq_work handled
>> >> >>> [    1.041099] irq_pipeline-torture: CPU0: in-band->in-band irq_w=
ork trigger works
>> >> >>> [    1.048430] irq_pipeline-torture: CPU0: stage escalation reque=
st works
>> >> >>> [    1.048436] irq_pipeline-torture: CPU0: irq_work handled
>> >> >>> [    1.060276] irq_pipeline-torture: CPU0: oob->in-band irq_work =
trigger works
>> >> >>> [    2.113302] CPU1: proxy tick device unregistered
>> >> >>> [    2.117930] CPU0: proxy tick device unregistered
>> >> >>> [    2.126014] IRQ pipeline: torture stage removed.
>> >> >>> [    2.130654] IRQ pipeline tests OK.
>> >> >>>
>> >> >>>
>> >> >>> There is a warning in the kernel logs:
>> >> >>>
>> >> >>>      0.000000] ------------[ cut here ]------------
>> >> >>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:17=
42 irq_pipeline_init+0x20/0x84
>> >> >>
>> >> >> This complains that hard-IRQs would be on while they must not.=20
>> >> >> All that in fairly early boot code.
>> >> >>
>> >> >>> [    0.000000] Modules linked in:
>> >> >>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.157=
-xenomai #2
>> >> >>> [    0.000000] Hardware name: Xilinx Zynq Platform
>> >> >>> [    0.000000] IRQ stage: Linux
>> >> >>> [    0.000000] [<c0014460>] (unwind_backtrace) from [<c0011400>] =
(show_stack+0x10/0x14)
>> >> >>> [    0.000000] [<c0011400>] (show_stack) from [<c03aac8c>] (dump_=
stack+0xdc/0xfc)
>> >> >>> [    0.000000] [<c03aac8c>] (dump_stack) from [<c03a7b08>] (__war=
n+0xa4/0xcc)
>> >> >>> [    0.000000] [<c03a7b08>] (__warn) from [<c03a7ba8>] (warn_slow=
path_fmt+0x78/0xb0)
>> >> >>> [    0.000000] [<c03a7ba8>] (warn_slowpath_fmt) from [<c04d1e20>]=
 (irq_pipeline_init+0x20/0x84)
>> >> >>> [    0.000000] [<c04d1e20>] (irq_pipeline_init) from [<c04c6d4c>]=
 (start_kernel+0x28c/0x4b8)
>> >> >>> [    0.000000] [<c04c6d4c>] (start_kernel) from [<00000000>] (0x0=
)
>> >> >>> [    0.000000] ---[ end trace 58996bc4bee07162 ]---
>> >> >>> [    0.000000] IRQ pipeline enabled
>> >> >>>
>> >> >>> The system and applications run OK with only one core in use.
>> >> >>>
>> >> >>> Is there something missing in the Linux config or anything else I=
 can try?
>> >> >>
>> >> >> Not sure. We don't have a Zynq in the test lab or at least as=20
>> >> >> reference image here. It might be that dovetail is missing some=20
>> >> >> bits for this SoC, e.g. a patch analogously to [1] for=20
>> >> >> drivers/gpio/gpio-zynq.c. Adding Philippe for possibly more insigh=
ts.
>> >> >>
>> >> >> ARM multi-core is generically fine, see our QEMU target=20
>> >> >> (https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F
>> >> >> %2F
>> >> >> source.denx.de%2FXenomai%2Fxenomai-images%2F-%2Fjobs%2F552798&data=
=3D05%7C01%7CEelco.Schuman%40boschrexroth.nl%7Cbde2fcb830c7453eb24e08daf7ff=
f75c%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638094975982300406%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DX9HSPXZaFPte2sxFfS5OTd683dFqMhWRpRcGXX%2F=
tRDg%3D&reserved=3D0 e.g.). But our only physical armhf target in the lab i=
s a single-core beaglebone.
>> >> >>
>> >> >> Jan
>> >> >>
>> >> >> [1]
>> >> >> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
>> >> >> 2Fs%2F&data=3D05%7C01%7CEelco.Schuman%40boschrexroth.nl%7C503f3bab
>> >> >> a62247f1cc7008daf8c0f983%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%
>> >> >> 7C0%7C638095804954456375%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>> >> >> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
>> >> >> %7C&sdata=3Dgskg%2FBDZWbmrHmEJe2%2B26EiYQDdroZJBOXXz9d29ROY%3D&res
>> >> >> erved=3D0=20
>> >> >> ource.denx.de%2FXenomai%2Flinux-dovetail%2F-%2Fcommit%2F3d3e5a16
>> >> >> 59d=20
>> >> >> 69c9dc96471efa542dc05fcc58e56&data=3D05%7C01%7CEelco.Schuman%40bos
>> >> >> chr=20
>> >> >> exroth.nl%7Cbde2fcb830c7453eb24e08daf7fff75c%7C0ae51e1907c84e4bb
>> >> >> b6d=20
>> >> >> 648ee58410f4%7C0%7C0%7C638094975982300406%7CUnknown%7CTWFpbGZsb3
>> >> >> d8e
>> >> >> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>> >> >> D%7=20
>> >> >> C3000%7C%7C%7C&sdata=3DOwo4KNn2Bo6r8yKJaI0ZrJNKTQ7woM4eOjYCb74M6ZA
>> >> >> %3D
>> >> >> &reserved=3D0
>> >> >>
>> >> >> --
>> >> >> Siemens AG, Technology
>> >> >> Competence Center Embedded Linux
>> >> >>
>> >> >>
>> >> >>
>> >> > If Philippe doesn't have time for an immediate answer I can try=20
>> >> > one of my zynq boards this weekend.  I reserved some time for=20
>> >> > ipipe things, I can add this to the list and see if I can help.
>> >>
>> >> That would be great! I have one zync board literally at my feet as=20
>> >> well, but setting all that up will take the usual time...
>> >>
>> >> Jan
>> >>
>> >> --
>> >> Siemens AG, Technology
>> >> Competence Center Embedded Linux
>> >>
>> >
>> >I reproduced the issue (pretty sure), I can look at it this week if tha=
t helps.  Just to confirm, Eelco, to reproduce I can create a thread and ca=
ll sleep(1) and I should see the process hang?
>> >
>> >-Greg
>>
>>
>> Hi Greg, many thanks for looking at this issue. Yes, a 'sleep(1)' in an =
application or thread hangs the process.  I noticed that the proxy tick doe=
s not get any interrupts:
>>
>>           CPU0       CPU1
>>  24:          0          5     SIRQC  24 Edge          in-band work
>>  25:          0          0     GIC-0  27 Edge          gt
>>  26:      94785      94399     GIC-0  29 Edge     oob  twd
>>  27:          0          0     GIC-0  37 Level         arm-pmu
>>  28:          0          0     GIC-0  38 Level         arm-pmu
>>  29:         43          0     GIC-0  39 Level         f8007100.adc
>>  32:          0          0     GIC-0  45 Level         f8003000.dmac
>>  33:          0          0     GIC-0  46 Level         f8003000.dmac
>>  34:          0          0     GIC-0  47 Level         f8003000.dmac
>>  35:          0          0     GIC-0  48 Level         f8003000.dmac
>>  36:          0          0     GIC-0  49 Level         f8003000.dmac
>>  37:          0          0     GIC-0  72 Level         f8003000.dmac
>>  38:          0          0     GIC-0  73 Level         f8003000.dmac
>>  39:          0          0     GIC-0  74 Level         f8003000.dmac
>>  40:          0          0     GIC-0  75 Level         f8003000.dmac
>>  41:          0          0     GIC-0  54 Level         eth0
>>  43:       2840          0     GIC-0  57 Level         cdns-i2c
>>  45:        463          0     GIC-0  59 Level         xuartps
>>  46:          0          0     GIC-0  64 Level    oob  [nyce-kmod]
>>  48:          0          0     SIRQC  48 Edge          Inband sirq
>>  49:          0          0     SIRQC  49 Edge          Inband sirq
>>  50:          0          0     SIRQC  50 Edge          Inband sirq
>>  51:          0          0     SIRQC  51 Edge          proxy tick
>> IPI0:          0          0  CPU wakeup interrupts
>> IPI1:          0          0  Timer broadcast interrupts
>> IPI2:        321        528  Rescheduling interrupts
>> IPI3:          5          2  Function call interrupts
>> IPI4:          0          0  CPU stop interrupts
>> IPI5:          0          0  IRQ work interrupts
>> IPI6:          0          0  completion interrupts
>>
>> Is this because xnintr_host_tick() is not called, e.g. from xnintr_core_=
clock_handler() ?
>>
>>
>> Best regards,
>>
>> Eelco
>>
>>
>I would start looking there, that looks suspicious to me.  Prior to the sl=
eep() call proxy tick does get interrupts?
>
>-Greg

- A process with 'sleep 1' hangs, so if you do (in bash)
   * sleep 1
   * wait 2 seconds
   * put in background ^Z                      [1]+  Stopped               =
     sleep 1
   * process is scheduled and finishes         [1]+  Done                  =
     sleep 1

- The proxy tick has no interrupts before and after sleep. I don't see chan=
ges in the interrupt counts, except for the twd count.

- I did a quick experiment to force xnintr_host_ticks(). With this I see pr=
oxy tick interrupts and sleep works as expected.=20

void xnintr_core_clock_handler(void)
{
...
...
	sched =3D xnsched_current();
	// if ((sched->lflags & XNHTICK) &&               -- force inband interrup=
ts to proxy tick
	if (xnthread_test_state(sched->curr, XNROOT))
		xnintr_host_tick(sched);
}

Thanks,
--Eelco


