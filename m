Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC61FA0
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 08:52:07 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 341AEE0009
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 08:52:00 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 1D91C941438
	for <xenomai@xenomai.org>; Tue, 18 Apr 2023 08:51:59 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202304180851576a5978a90790402385
        for <xenomai@xenomai.org>;
        Tue, 18 Apr 2023 10:51:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=M6u9anxBz2GIh8d3R4hHCcBHK9LDr1/ovwf9L90czwU=;
 b=OTpkV+mQeutjZySsApWrE2IVePrRxNAnqo7/75QxB4w573a8Pc1/6pgUlyqcjA0DNqwkOG
 kky8JF0gOzh2EmyAmU2kzlpsxLT6ai7qCLyRRWr7XfCUpfkOpjSV/lhZrxcIackwm/0Ekny5
 /91WraNTzYdoz/DnEQe8VNAUq1EUs=;
Message-ID: <8f66cdb6fc582024b5ccbf6b9433cf7a2fdb08a8.camel@siemens.com>
Subject: Re: Repeat initialization for wd_data->dev
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Greg Gallagher <greg@embeddedgreg.com>, linz <powertree@163.com>, "Chen,
 Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org"
 <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 18 Apr 2023 10:51:51 +0200
In-Reply-To: <abddba56-37d3-6fb7-be98-2f6ed64c2f97@163.com>
References: <0c88a90d-1a24-15c5-21e3-bd0a6d9c18aa@163.com>
	 <MN2PR11MB42858E0D781BE863F9FD4F40F29D9@MN2PR11MB4285.namprd11.prod.outlook.com>
	 <abddba56-37d3-6fb7-be98-2f6ed64c2f97@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
Received-SPF: pass (spool1: domain of rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) client-ip=185.136.65.227; envelope-from=fm-68982-202304180851576a5978a90790402385-0JU21S@rts-flowmailer.siemens.com; helo=mta-65-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=OTpkV+mQ;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-202304180851576a5978a90790402385-0JU21S@rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) smtp.mailfrom=fm-68982-202304180851576a5978a90790402385-0JU21S@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com

On Tue, 2023-04-18 at 16:42 +0800, linz wrote:
> Hi,=C2=A0 the issue does not happen with common Linux kernel after you=
=20
> disable I-PIPE, because it may be IPIPE bug.
>=20
> We can see that the function is as follows from=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/dr=
ivers/watchdog/watchdog_dev.c?h=3Dv4.19.209-cip59
>=20
> static  int  watchdog_cdev_register(struct  watchdog_device  *wdd)
> {
> 	struct  watchdog_core_data  *wd_data;
> 	int  err;
>=20
> 	wd_data  =3D  kzalloc(sizeof(struct  watchdog_core_data),  GFP_KERNEL);
> 	if  (!wd_data)
> 		return  -ENOMEM;
> 	mutex_init(&wd_data->lock);
>=20
> 	wd_data->wdd  =3D  wdd;
> 	wdd->wd_data  =3D  wd_data;
>=20
> 	if  (IS_ERR_OR_NULL(watchdog_kworker))  {
> 		kfree(wd_data);
> 		return  -ENODEV;
> 	}
>=20
> 	device_initialize(&wd_data->dev);
> 	wd_data->dev.devt  =3D  MKDEV(MAJOR(watchdog_devt),  wdd->id);
> 	wd_data->dev.class  =3D  &watchdog_class;
> 	wd_data->dev.parent  =3D  wdd->parent;
> 	wd_data->dev.groups  =3D  wdd->groups;
> 	wd_data->dev.release  =3D  watchdog_core_data_release;
> 	dev_set_drvdata(&wd_data->dev,  wdd);
> 	dev_set_name(&wd_data->dev,  "watchdog%d",  wdd->id);
>=20
> 	kthread_init_work(&wd_data->work,  watchdog_ping_work);
> 	hrtimer_init(&wd_data->timer,  CLOCK_MONOTONIC,  HRTIMER_MODE_REL);
> 	wd_data->timer.function  =3D  watchdog_timer_expired;
>=20
> 	if  (wdd->id  =3D=3D  0)  {
>=20
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0 ... ....
>=20
> }
>=20
> But=C2=A0 the function is as follows from=20
> https://source.denx.de/Xenomai/ipipe-arm64/-/blob/ipipe/4.19.y-cip/driver=
s/watchdog/watchdog_dev.c
>=20
> We can see the lines 19 to 26 are duplicated with the lines 28 to 35. I=
=20
> guess the lines 28 to 35 may be added mistakenly.
>=20
> 1 static int watchdog_cdev_register(struct watchdog_device *wdd)
> 2 {
> 3 =C2=A0=C2=A0=C2=A0 struct watchdog_core_data *wd_data;
> 4=C2=A0=C2=A0=C2=A0 int err;
> 5
> 6=C2=A0=C2=A0=C2=A0 wd_data =3D kzalloc(sizeof(struct watchdog_core_data)=
, GFP_KERNEL);
> 7=C2=A0=C2=A0=C2=A0 if (!wd_data)
> 8=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENOMEM;
> 9=C2=A0=C2=A0=C2=A0 mutex_init(&wd_data->lock);
> 10
> 11=C2=A0=C2=A0=C2=A0 wd_data->wdd =3D wdd;
> 12=C2=A0=C2=A0=C2=A0 wdd->wd_data =3D wd_data;
> 13
> 14=C2=A0=C2=A0=C2=A0 if (IS_ERR_OR_NULL(watchdog_kworker)) {
> 15=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 kfree(wd_data);
> 16=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENODEV;
> 17=C2=A0=C2=A0=C2=A0 }
> 18
> 19 device_initialize(&wd_data->dev);
> 20=C2=A0=C2=A0=C2=A0 wd_data->dev.devt =3D MKDEV(MAJOR(watchdog_devt), wd=
d->id);
> 21=C2=A0=C2=A0=C2=A0 wd_data->dev.class =3D &watchdog_class;
> 22=C2=A0=C2=A0=C2=A0 wd_data->dev.parent =3D wdd->parent;
> 23=C2=A0=C2=A0=C2=A0 wd_data->dev.groups =3D wdd->groups;
> 24=C2=A0=C2=A0=C2=A0 wd_data->dev.release =3D watchdog_core_data_release;
> 25=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wd_data->dev, wdd);
> 26=C2=A0=C2=A0=C2=A0 dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
> 27
> 28 device_initialize(&wd_data->dev);
> 29=C2=A0=C2=A0=C2=A0 wd_data->dev.devt =3D MKDEV(MAJOR(watchdog_devt), wd=
d->id);
> 30=C2=A0=C2=A0=C2=A0 wd_data->dev.class =3D &watchdog_class;
> 31=C2=A0=C2=A0=C2=A0 wd_data->dev.parent =3D wdd->parent;
> 32=C2=A0=C2=A0=C2=A0 wd_data->dev.groups =3D wdd->groups;
> 33=C2=A0=C2=A0=C2=A0 wd_data->dev.release =3D watchdog_core_data_release;
> 34=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wd_data->dev, wdd);
> 35=C2=A0=C2=A0=C2=A0 dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
> 36
> 37=C2=A0=C2=A0=C2=A0 kthread_init_work(&wd_data->work, watchdog_ping_work=
);
> 38=C2=A0=C2=A0=C2=A0 hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIM=
ER_MODE_REL);
> 39=C2=A0=C2=A0=C2=A0 wd_data->timer.function =3D watchdog_timer_expired;
> 40
> 41=C2=A0=C2=A0=C2=A0 if (wdd->id =3D=3D 0) {
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... ...
>=20
> }

This is clearly a IPIPE bug, very likely a merge has gone wrong.
Adding Greg, our IPIPE for arm maintainer.

Problem has been introduced with [1].

[1] https://source.denx.de/Xenomai/ipipe-arm64/-/commit/28b56c041720030a859=
58febf9163ee5151bec98

>=20
>=20
> =E5=9C=A8 2023/4/18 16:20, Chen, Hongzhan =E5=86=99=E9=81=93:
> >=20
> > > -----Original Message-----
> > > From: linz <powertree@163.com>
> > > Sent: Tuesday, April 18, 2023 4:01 PM
> > > To: xenomai@xenomai.org
> > > Subject: Repeat initialization for wd_data->dev
> > >=20
> > > Hi, I find a Call trace when arm64 kernel is booting when I use
> > > remotes/origin/ipipe/4.19.y-cip branch, the Call trace is as follows
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 2.108797] I-pipe domain: Linux
> > > [=C2=A0=C2=A0=C2=A0 2.112014] Call trace:
> > > [=C2=A0=C2=A0=C2=A0 2.114458]=C2=A0 dump_backtrace+0x0/0x150
> > > [=C2=A0=C2=A0=C2=A0 2.118112]=C2=A0 show_stack+0x14/0x20
> > > [=C2=A0=C2=A0=C2=A0 2.121419]=C2=A0 dump_stack+0xd0/0x110
> > > [=C2=A0=C2=A0=C2=A0 2.124812]=C2=A0 kobject_init+0x8c/0xa0
> > > [=C2=A0=C2=A0=C2=A0 2.128294]=C2=A0 device_initialize+0x3c/0xd0
> > > [=C2=A0=C2=A0=C2=A0 2.132209]=C2=A0 watchdog_dev_register+0xd4/0x2e0
> > > [=C2=A0=C2=A0=C2=A0 2.136557]=C2=A0 __watchdog_register_device+0xd0/0=
x2a0
> > > [=C2=A0=C2=A0=C2=A0 2.141338]=C2=A0 watchdog_register_device+0x70/0x9=
0
> > > [=C2=A0=C2=A0=C2=A0 2.145858]=C2=A0 sbsa_gwdt_probe+0x160/0x310
> > > [=C2=A0=C2=A0=C2=A0 2.149772]=C2=A0 platform_drv_probe+0x50/0xa0
> > > [=C2=A0=C2=A0=C2=A0 2.153771]=C2=A0 really_probe+0x248/0x3b0
> > > [=C2=A0=C2=A0=C2=A0 2.157423]=C2=A0 driver_probe_device+0x54/0xf0
> > > [=C2=A0=C2=A0=C2=A0 2.161509]=C2=A0 __driver_attach+0x104/0x120
> > > [=C2=A0=C2=A0=C2=A0 2.165423]=C2=A0 bus_for_each_dev+0x70/0xcc
> > > [=C2=A0=C2=A0=C2=A0 2.169248]=C2=A0 driver_attach+0x20/0x30
> > > [=C2=A0=C2=A0=C2=A0 2.172813]=C2=A0 bus_add_driver+0x164/0x20c
> > > [=C2=A0=C2=A0=C2=A0 2.176638]=C2=A0 driver_register+0x74/0x120
> > > [=C2=A0=C2=A0=C2=A0 2.180463]=C2=A0 __platform_driver_register+0x44/0=
x50
> > > [=C2=A0=C2=A0=C2=A0 2.185160]=C2=A0 sbsa_gwdt_driver_init+0x18/0x20
> > > [=C2=A0=C2=A0=C2=A0 2.189421]=C2=A0 do_one_initcall+0x50/0x160
> > > [=C2=A0=C2=A0=C2=A0 2.193248]=C2=A0 kernel_init_freeable+0x19c/0x23c
> > > [=C2=A0=C2=A0=C2=A0 2.197596]=C2=A0 kernel_init+0x10/0x100
> > > [=C2=A0=C2=A0=C2=A0 2.201074]=C2=A0 ret_from_fork+0x14/0x24
> > >=20
> > > The reason is that there is repeat initialization for wd_data->dev in
> > > function watchdog_cdev_register on remotes/origin/ipipe/4.19.y-cip br=
anch.
> > Thanks for your email. Does the issue happen with common Linux kernel a=
fter you disable I-PIPE? If not , it should be common kernel issue and you =
may like to report it to Linux kernel community.
> >=20
> > Regards
> >=20
> > Hongzhan Chen
> > > The fixed up patch is as follows:
> > >=20
> > > diff --git a/drivers/watchdog/watchdog_dev.c
> > > b/drivers/watchdog/watchdog_dev.c
> > > index 863b2dfc9..8fe59b7d8 100644
> > > --- a/drivers/watchdog/watchdog_dev.c
> > > +++ b/drivers/watchdog/watchdog_dev.c
> > > @@ -958,15 +958,6 @@ static int watchdog_cdev_register(struct
> > > watchdog_device *wdd)
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wd_data->dev, wdd);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 dev_set_name(&wd_data->dev, "watchdog%d", w=
dd->id);
> > >=20
> > > -=C2=A0=C2=A0=C2=A0 device_initialize(&wd_data->dev);
> > > -=C2=A0=C2=A0=C2=A0 wd_data->dev.devt =3D MKDEV(MAJOR(watchdog_devt),=
 wdd->id);
> > > -=C2=A0=C2=A0=C2=A0 wd_data->dev.class =3D &watchdog_class;
> > > -=C2=A0=C2=A0=C2=A0 wd_data->dev.parent =3D wdd->parent;
> > > -=C2=A0=C2=A0=C2=A0 wd_data->dev.groups =3D wdd->groups;
> > > -=C2=A0=C2=A0=C2=A0 wd_data->dev.release =3D watchdog_core_data_relea=
se;
> > > -=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wd_data->dev, wdd);
> > > -=C2=A0=C2=A0=C2=A0 dev_set_name(&wd_data->dev, "watchdog%d", wdd->id=
);
> > > -
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 kthread_init_work(&wd_data->work, watchdog_=
ping_work);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_init(&wd_data->timer, CLOCK_MONOTON=
IC,
> > > HRTIMER_MODE_REL);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 wd_data->timer.function =3D watchdog_timer_=
expired;
> > >=20
> > >=20
> > > Thank you
> > >=20
> > >=20
>=20
>=20

