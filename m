Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 May 2008 12:24:33 +0200
Message-ID: <0C9896A4B6D338488AD6FFFE58BAEF100276E025@domain.hid>
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid><48297566.1010607@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>	<4829AA19.8070405@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>	<4829C8C9.4020300@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DDDE@serveur3.lgm.com>
	<482B3BCF.8090700@domain.hid> <482B3EE5.9030702@domain.hid>
From: "DOURNES Guillaume" <Guillaume.DOURNES@lgm.fr>
Subject: Re: [Xenomai-help] Interrupt management under rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Thanks a lot for your attention. And sorry for my poor english.
I change my context into a real RT context and my problem disappears.

Nevertheless, I have other questions about the IRQ management.

In fact, after executing my software application (so after the =
rtdm_close call, and so the free irq), I obtain a syslog message : =
kernel Disabling IRQ #11. This message doesn't affect my software if I =
run it again, but may be there are some side effect. In dmesg, the =
following error message appears : irq 11: nobody cared (try booting with =
the "irqpoll" option).
In my open function I call :=20
- request_region
- rtdm_irq_request
In my close function I call :
- rtdm_irq_free
- release_region
May be there is a function to call to avoid this disabling irq ?


Moreover, when I'm using my discrets I/O driver (on the IRQ 11) and I =
add an USB Key (on this IRQ 11) the software freeze. Note that my USB =
Key works normaly before I call my open function, and doesn't work after =
my software execution, may be because of the Disabling IRQ.
Note that the freeze appears with the 16550A rtdm driver use. For =
example, when my keyboard irq is the same as the seria board irq, the =
computer freeze when the driver is running and the keyboard is using at =
the same moment.
I think that the linux irq and xenomai irq are not usable at the same =
time !

Note that my kernel is configured with shared interrupt.

Guillaume.


-----Message d'origine-----
De : jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Envoy=E9 : mercredi 14 mai 2008 21:35
=C0 : DOURNES Guillaume
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] Interrupt management under rtdm driver

Jan Kiszka wrote:
> DOURNES Guillaume wrote:
>> Since I add the watchdog option in my kernel configuration, The =
software doesn't block.
>> But I obtain an EPREM (-1) error on the second call of =
rtdm_event_timedwait, and in dmesg : Xenomai: assertion failed at =
kernel/xenomai/skins/rtdm/drvlib.c:919 (!xnpod_unblockable_p()).
>=20
> See, that is interesting.
>=20
>> I don't understand why I have this error, because the =
rtdm_event_timedwait is used as the 16550A rtserial rtdm driver. And I =
use this rtserial driver, and it works.
>> Note that this problem doesn't appears when I call rt_task_suspend =
just after my rtdm_event_timedwait, and I resume the task by a gets.
>=20
> After having a look at your driver source meanwhile, the problem is=20
> that you register your IOCTL handler also for handling invocation from =

> non-RT
> (precisely: "secondary") context. But rtdm_event_timedwait always=20
> requires primary (RT) context. That is something you either have to=20
> check in the IOCTL handler before trying to block a caller - or you=20
> simply do not register for nrt_ioctl (or use a different handler for=20
> the set of IOCTLs in that context).
>=20
> The reason that suspending the caller made this issue go away was that =

> you have several plain Linux services in your RT loop that switches=20
> the caller automatically to secondary mode. Thus the first IOCTL=20
> succeeded, but the second failed after re-entering it now as a plain =
Linux caller.

...But suspending the thread shortly before IOCTL re-entry automatically =
switch it back into the right (=3D=3DRT) context.

Jan



