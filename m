Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <20150315214851.GX25508@csclub.uwaterloo.ca>
Date: Sun, 15 Mar 2015 23:00:48 -0400
Message-Id: <8F36B2B1-5841-4FE1-9ED7-D76F2B1E7F03@gatech.edu>
References: <8863A7ED-4603-4043-8777-74B3867F9BDE@gatech.edu>
 <20150315183757.GJ1497@hermes.click-hack.org>
 <165AA07D-BD57-40AB-B4B2-6499B278A376@gatech.edu>
 <20150315214851.GX25508@csclub.uwaterloo.ca>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Graphics Iissues only after loading analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org


> On Mar 15, 2015, at 17:48, Lennart Sorensen =
<lsorense@csclub.uwaterloo.ca> wrote:
>=20
> On Sun, Mar 15, 2015 at 03:32:24PM -0400, Yogi A. Patel wrote:
>>=20
>>> On Mar 15, 2015, at 14:37, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:
>>>=20
>>> On Sun, Mar 15, 2015 at 01:36:05PM -0400, Yogi A. Patel wrote:
>>>> Hi -
>>>>=20
>>>> I have multiple systems running Ubuntu 14.04 with Xenomai 2.6.3 or =
2.6.4. Each system has a PCI/PCIe graphics card and an NI DAQ card.
>>>>=20
>>>> On some machines, the system runs great - however on some of my =
machines the GUI becomes sluggish ONLY after the DAQ card has been =
loaded and attached using analogy_config. The mouse and keyboard =
interactions are affected. I=E2=80=99ve also noticed that dropping to a =
shell using CTRL+ALT+F1 is affected (the shell is slow to respond).
>>>>=20
>>>> I=E2=80=99ve seen this on a variety of machines using ATI or Nvidia =
cards and with both proprietary and open-source drivers. On all of my =
machines, I have DRM/DKMS enabled for the appropriate graphics drivers =
and I=E2=80=99ve checked the DMESG and XORG logs - but nothing stands =
out/reveals why loading the DAQ leads to this behavior.
>>>>=20
>>>> Has anyone else experienced this?
>>>=20
>>> Are you sure this is not the well known irq conflicts issue?
>>>=20
>>> --=20
>>> 					    Gilles.
>>=20
>> Hi Gilles -
>>=20
>> I just looked into this and you are correct. The ethernet module and =
the PCI card in question are on the same IRQ line. How do I change the =
IRQ of one of these devices? I can=E2=80=99t seem to find much on it =
online besides irqtune (which appears outdated).
>=20
> For PCI devices, the only way to change IRQs tends to be to change =
slots.
> Traditional PCI used 4 IRQs, which were assigned as IRQ A through D
> on each slot, in a rotating pattern (most cards only use IRQ A on a
> given slot, which means slot 1 and 5 would share, 2 and 6 would share,
> etc).  On board PCI based hardware also gets assigned to those 4 IRQs.
> Newer machines using an APIC tend to avoid the IRQ sharing entirely,
> but depends on the design of the hardware.
>=20
> --=20
> Len Sorensen

Thanks, Giles/Len. It turns out the problem is shared IRQs - this =
explains the non-deterministic results across various machines.

Yogi A. Patel
@yapatel525 <https://twitter.com/yapatel525>
