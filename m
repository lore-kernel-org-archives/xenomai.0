MIME-Version: 1.0
In-Reply-To: <CB3E339B-7A10-4A25-A49D-63971ED35FA7@imag.fr>
References: <CB3E339B-7A10-4A25-A49D-63971ED35FA7@imag.fr>
Date: Mon, 17 Dec 2012 15:21:17 +0100
Message-ID: <CAKvQZ_0fwkVB_SAkxQbsc68_CO+HqHBtHn1ky+yRR3cb1C4d6Q@mail.gmail.com>
From: Willy Lambert <lambert.willy@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Beginner's Problem: Installing Xenomai Kernel for i7
 multi-core processor
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: James Leonard <james.leonard@imag.fr>
Cc: xenomai@xenomai.org

2012/12/17 James Leonard <james.leonard@imag.fr>:
> Hello everyone,
>
> I'm an absolute beginner when it comes to Linux based RTOS systems, so I =
apologise in advance for any beginner=92s mistakes I may have made.
>
> I have been trying to install and configure a Xenomai patched Kernel on a=
 PC with a Intel i7 quad core processor and an ASUS P7P55D motherboard, but=
 so far I have had no success.
>
> I tried patching and installing a 2.6.38.8 Kernel on a Fedora 16 OS (with=
 3.4.2 default kernel), but upon boot I was told that the 'ext4' root file =
system was not recognized, so I decided to try installing on other OS, form=
atted with ext3.
>

As always, before trying to have a real time kernel, just try to have
a kernel. So in your case, before trying to do anything with xenomai,
you have to choose a kernel version compatible with xenomai (2.6.38.8
is ok, but in the end, why taking a so old version since, afaik, newer
are working ?), and configure/build your kernel and try again until it
works correctly. In your case you certainly needs some options about
ext4 to let your linux boot on it (and this depend if you use an
initrd or not).

Usually you start with an older kernel version, and use a newer one
with "make oldconfig". I'm not sure that your system can go backward
that way from 3.4.X to 2.6.38.X ...

Then, and only then, add xenomai kernel patches and user space and you
will just have xenomai problems.


> I tried Debian (installing via the debian packages) and Fedora 14 (manual=
 patching and install). The results I have with these are the following:
> =B7     When booting, I get a "MP BIOS bug: 8254 timer not connected to I=
O-APIC" error. Then the system starts OK

This is a quite classical issue. If you google your error message you
should find a lot of info on it, it is related to apic configuration.
As far as I can remember passing some parameters to your kernel boot
command line like "noioapic" or "noapic" would help. To be confirmed
by xenomai experts

>
> =B7      The latency test gives about 10000 overruns per cycle, with enor=
mous max latency times.
>
> I've tried many different configurations, initially following this tutori=
al (in French) http://doc.fedora-fr.org/wiki/Mise_en_=9Cuvre_de_Xenomai_pou=
r_cr=E9er_un_noyau_Temps_R=E9el_dur :
>
>         - simply disabling power options such as APM and CPU Freq Scaling=
 (as in tutorial)
>         - Enabling the SMI workaround and globally disabling the SMIs
>         - Other things listed in the x86 kernel config guide of the Xenom=
ai website
>
> I'm sorry, the description of my problem is probably very vague, but I ge=
t the feeling I must be forgetting something basic in the hardware/kernel c=
onfiguration, as I cannot get things to work at all and have seen many peop=
le use i7 processors and Xenomai successfully.

You will have to provide some more precise informations like your
kernel.config file, dmesg results, ... (is there a xenomai page on the
wiki telling us what infos to give ?). But before that I highly
suggests that you make your system working with your choosed vanilla
kernel

>
>
>  Regards,
>
> James Leonard
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

