Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 8 Dec 2008 10:46:48 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38480@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Blackfin BF537 userspace - kernelspace strategy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Pagani <danielepagani@domain.hid>, xenomai@xenomai.org

Daniele Pagani wrote:
> I'm using uClinux with Xenomai on BF537 and it works fine.
>=A0
>But, I need to understand the best strategy to use about Linux/Xenomai =
and >userspace/kernelspace.
[...]
>=A0The driver is developed in Linux environment (without real time), =
using 2d-dma buffering and dma_copy in function read/write.

My advice would be to have a simple kernel driver that keeps the double=20
buffer DMA continuously running, and have that buffer memory mmapped to =
user
land. The user RT task would either be notified by interrupt, either by=20
polling (my preference).
=A0
> and inside the real time task I'm using read/write function according =
to the char device driver sport. The priority of the task is set to 99.

If I'm not mistaken, the read/write is not RT safe.

> Anyway, when I'm using this configuration, sometimes a calling to a
> webserver (that is running on the same machine) could cause an error =
on=20
> the audio output, so I think that something is not in real time =
environment.

Has you kernel PREEMPT_RT enabled?
=A0
> So the question is, what I need to do?
=A0
> 1) write real time driver (very difficult now for me)

RTDM should ease that pathway, isn't?

> 2) write userspace application with real time interrupt and=20
> dma=A0management? If yes, I don't understand if in Xenomai context I =
can set
> the Blackfin register from a userspace application or if in Xenomai
> context has no sense to speak about user/kernel space.=20

Not sure about the BF arch, but generally, you can access=20
the hardware register by mmap'ing /dev/mem from userspace, and once =
mapped,
stay in RT. See the following for inspiration:
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acces=
singPeripheralsFromUserSpace

Regards
--=20
Stephane

