Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Oct 2007 20:10:05 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB267@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.4-rc4: freeze with RTAI skin,
	fine with other skins
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
>Fillod Stephane wrote:
>> For the legacy RTAI application to load, the attached patch was
>> necessary.
>> The patch against ksrc/skins/rtai/shm.c is somewhat defeating the
>> purpose
>> of a lower XNCORE_PAGE_SIZE, so a better fix might be expected.
>>=20
>
>This one should prevent -EINVAL from being returned. Hopefully.

Nope, it doesn't :-(
Most probably because still (hdrsize + 2 * pagesize > heapsize).

[..]=20
>> In the mean time, does anyone have a clue where to look particularly?
>>=20
>
>Hard to say at this point. Since the nucleus watchdog does not trigger,
>you may want to try disabling X86_UP_IOAPIC while keeping X86_UP_APIC,
>and arm the kernel NMI watchdog on the LAPIC (nmi_watchdog=3D2). You =
may
>be lucky and have a backtrace after the freeze.
>
>PS: maybe enabling all the nucleus debug options would catch something
too.

Thanks for the ideas. It looks like part of the problem came from memory
corruption (access beyond heap) in the application (not so stable app
in the end, he!). I'm still experiencing random freeze when freeing
resources when stopping application, but runtime is stable.
To be honest, the freeze was not a perfect freeze, I got just a one line
trace from do_page_fault(), with no backtrace or pointer. Unhelpful.
I have updated http://xenomai.org/index.php/FAQs

--=20
Stephane

