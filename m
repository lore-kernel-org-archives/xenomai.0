Message-ID: <5468C910.2010200@xenomai.org>
Date: Sun, 16 Nov 2014 10:56:00 -0500
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdaDJkSOhS7WaiRo5t0+NnCSV4-DQJcFB3iYOPGZ=z-Gg@mail.gmail.com>	<201411121225.22847.paul_c@tuxcnc.org>	<54650689.8020005@xenomai.org>
 <CAKKWdtf_-vVbcmPgXyyAdL2ODPHaDkQteN3dEhTHSzojcwgRZQ@mail.gmail.com>
In-Reply-To: <CAKKWdtf_-vVbcmPgXyyAdL2ODPHaDkQteN3dEhTHSzojcwgRZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] DAC and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/15/2014 09:13 AM, ali hagigat wrote:
> On 11/13/14, Jorge Ramirez Ortiz <jro@xenomai.org> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 11/12/2014 07:25 AM, Paul wrote:
>>> On Wednesday 12 November 2014, ali hagigat wrote:
>>>> I am trying to setup a real time system by a x86-32bits-intel-core 2
>>>> quad computer and Xenomai. I need a DAC card (data acquisition card
>>>> for making analog/digital signals/pulses) pWojciech Domski <wojciech.domski@gmail.com>robably plugged into PCI
>>>> bus and also a CAN controller, again plugged into PCI bus to send
>>>> some reports to another. (is there any other way besides PCI bus?) I
>>>> wonder if anybody can direct me what hardware i can buy to work
>>>> probably. I need the name of the boards and their distributors and
>>>> their related links.
>>>
>>> What conversion speeds do you need for ADC/DAC ?
>>> How many channels ?
>>> Are you willing/able to write drivers for unsupported hardware ?
>>> Do you have a sizable budget ?
>>>
>>> A starting point for a moderately slow PCI analogue/digital acquisition
>>> card that has support under the Xenomai analogy framework is
>>> http://www.sensoray.com/products/626.htm
>>
>> Support for 626 has not been delivered yet (will be done soon) - there is
>> support for
>> s526.
>> If you need software calibration support on Xenomai you could use NI M-6221
>>
>> http://sine.ni.com/nips/cds/view/p/lang/en/nid/14132
>>
>> I have seen some of these cards on ebay reasonably priced.
>>
> 
> thank you for the note. i probably use this system for the motor
> control. i suppose this board is driven by
> ksrc/drivers/analogy/national_instruments/pcimio.c

yes

> There are some issues with this driver like when DMA is enabled
> XXX_EV_CONVERT does not work and so on...

if you find issues with the driver please let me know and I can try and fix them.
our testing capabilities are limited.
do you have a a use case I can use to reproduce this issue?

> Did you test other drivers like mite.c or ni_660x.c?

not sure I understand. mite is used by the NI pci devices so it is tested.

> Which one is more reliable and complete?

It is hard to say as I said, we dont have a board farm where can run a CI loop and
rely on contributors to report issues.
all I can say is that we do have a 6221 that I can use to try and address bugs that
you report.

Also I will be integrating this week the sensoray 626 driver contributed by
wojciech.domski@gmail.com.
Maybe you could consider this one too since I believe it should have had quite a
real-life test cycle


> 
> do you have any experience using a CAN controller for a PC?
> 

I have used CAN controllers in the printing and automotive industry. what do you want
to do?

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUaMkNAAoJECDcy2IJkagRom4H/3yMt0QiwbCf92f3+oTblSiE
qI1ClFkjtNmtlx5G5qVjgiGhOLY0Cni+M3eS7ZARqCFI3VkEoUp77ZpIDpzDnvHS
UtZvQ2yLkNSWcZjUBs+EXCUmEiOAnz1PPIaAE1VEEqBYejRCqVMNscpNQJZZD4CN
9Htn6fHKvq53xADjwdZ/A1d+S04m+Kbz0w+kTVEnia0iKOlk1CAcY2JvRnNn4PDD
VcLRqnhG6UsxB8eOpjhAIfjW1LsXp0kDhhopaDgGLTKfXZs6QpRvNW47nMKTdiLD
a9BMyVCl6oR7ELrEpzdKXNGiOi6qTMlbPmP6D4gxdJ+q+bUuxn9eO3WOjPMm5eQ=
=nI3J
-----END PGP SIGNATURE-----

