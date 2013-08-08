Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <52039EC3.4050908@gmail.com>
Date: Thu, 8 Aug 2013 16:26:04 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
References: <52039EC3.4050908@gmail.com>
Subject: Re: [Xenomai] Using hardware PWM generators with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sagar,

you might want to study the LinuxCNC code, which does PWM - among other =
functions like a stepper generator - via the PRU

=
http://git.linuxcnc.org/gitweb?p=3Dlinuxcnc.git;a=3Dtree;f=3Dsrc/hal/drive=
rs/hal_pru_generic;h=3D5e7dc56c1891408833362fd7f480a9da20dcc31d;hb=3Drefs/=
heads/unified-build-candidate-1

- Michael
Am 08.08.2013 um 15:36 schrieb Sagar Behere <sagar.behere@gmail.com>:

> Hello,
>=20
> I wish to generate PWM signals from Xenomai, using the beaglebone =
black, kernel 3.8.13 patched with xenomai.
>=20
> There already exist linux kernel modules for the hardware PWM =
generator (eHRPWM) on the am335x chip in the beaglebone. The PWM =
generator can be configured and controlled via the /sysfs interface and =
the whole thing works very well.
>=20
> I understand that the /sysfs interface cannot be used by xenomai tasks =
without triggering a transition away from the primary xenomai (hard =
realtime) domain. So my question is: What is the least effort way to =
change the duty cycle of the hardware PWM generator, from a xenomai =
task?
>=20
> Does the following approach sound feasible?
>=20
> 1. Configure the PWM generator (freq, polarity etc.) from the /sysfs =
interface at application startup. This need not be realtime
> 2. Assuming that the duty-cycle is controlled by the value of some =
memory-mapped register, use mmap()/ioremap() to map that register's =
address into the xenomai task's address space.
> 3. Write the duty-cycle values to the mapped memory, from within the =
xenomai task
>=20
> So this is like a hybrid approach that uses the existing linux kernel =
module for initializing/configuring the hardware PWM and the xenomai =
task only changes the value of one register that affects the duty cycle =
of the output waveform.
>=20
> Thanks in advance,
> Sagar
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


