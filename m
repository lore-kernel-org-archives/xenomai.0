MIME-Version: 1.0
In-Reply-To: <54650689.8020005@xenomai.org>
References: <CAKKWdtdaDJkSOhS7WaiRo5t0+NnCSV4-DQJcFB3iYOPGZ=z-Gg@mail.gmail.com>
 <201411121225.22847.paul_c@tuxcnc.org>
 <54650689.8020005@xenomai.org>
Date: Sat, 15 Nov 2014 17:43:06 +0330
Message-ID: <CAKKWdtf_-vVbcmPgXyyAdL2ODPHaDkQteN3dEhTHSzojcwgRZQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] DAC and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: xenomai@xenomai.org

On 11/13/14, Jorge Ramirez Ortiz <jro@xenomai.org> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 11/12/2014 07:25 AM, Paul wrote:
>> On Wednesday 12 November 2014, ali hagigat wrote:
>>> I am trying to setup a real time system by a x86-32bits-intel-core 2
>>> quad computer and Xenomai. I need a DAC card (data acquisition card
>>> for making analog/digital signals/pulses) probably plugged into PCI
>>> bus and also a CAN controller, again plugged into PCI bus to send
>>> some reports to another. (is there any other way besides PCI bus?) I
>>> wonder if anybody can direct me what hardware i can buy to work
>>> probably. I need the name of the boards and their distributors and
>>> their related links.
>>
>> What conversion speeds do you need for ADC/DAC ?
>> How many channels ?
>> Are you willing/able to write drivers for unsupported hardware ?
>> Do you have a sizable budget ?
>>
>> A starting point for a moderately slow PCI analogue/digital acquisition
>> card that has support under the Xenomai analogy framework is
>> http://www.sensoray.com/products/626.htm
>
> Support for 626 has not been delivered yet (will be done soon) - there is
> support for
> s526.
> If you need software calibration support on Xenomai you could use NI M-6221
>
> http://sine.ni.com/nips/cds/view/p/lang/en/nid/14132
>
> I have seen some of these cards on ebay reasonably priced.
>

thank you for the note. i probably use this system for the motor
control. i suppose this board is driven by
ksrc/drivers/analogy/national_instruments/pcimio.c
There are some issues with this driver like when DMA is enabled
XXX_EV_CONVERT does not work and so on...
Did you test other drivers like mite.c or ni_660x.c?
Which one is more reliable and complete?

do you have any experience using a CAN controller for a PC?

