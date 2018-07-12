MIME-Version: 1.0
In-Reply-To: <20180712160946.551f3019@md1pvb1c.ad001.siemens.net>
References: <CAFUnMknWBmuLjGbQfv+uqy49xo-+SNUWAtAgjwULUgY6nybgmA@mail.gmail.com>
 <20180712160946.551f3019@md1pvb1c.ad001.siemens.net>
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Thu, 12 Jul 2018 20:46:08 +0530
Message-ID: <CAFUnMknaxRKk6gp7ifPXL3OSnFz8j7-jernJqsRuQzg6zhWcQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] BUG: unable to handle kernel paging request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Thank you for your reply,

can I install linux- 4.9.90 with xenomai 3.0.7 on i3 processor
I have mentioned lscpu terminal output

root@texsonics:/usr/src# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    2
Core(s) per socket:    2
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 158
Stepping:              9
CPU MHz:               800.000
BogoMIPS:              7823.98
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              3072K
NUMA node0 CPU(s):     0-3

or anyother specific processor mother board is there for this xenomai-3.0.7

and can you suggest x86 architecture 64 bit processor and mother board for
xenomai-3.0.7

Thank you
R.Ashokkumar

On Thu, Jul 12, 2018 at 7:39 PM, Henning Schild <henning.schild@siemens.com>
wrote:

> Am Thu, 12 Jul 2018 19:22:39 +0530
> schrieb Ashok kumar <ashokkumar.bb@gmail.com>:
>
> > Hi,
> >
> > I am patching  linux- 3.14.44 with -xenomai-2.6.4,  I am using
> > ipipe-core-3.14.44-x86-12.patch
>
> Ok, have you tried 4.9.90 with xenomai 3.0.7? What you are using is far
> from still being supported.
>
> The only possible reason you are using such an outdated kernel is
> because you rely on other patches as well. Do you see the same bug when
> not applying these other patches?
>
> > and in menu config
> >
> > Required Options:
> > * Real-time sub-system
> >   --> Xenomai (Enable)
> >   --> Nucleus (Enable)
> > * Power management and ACPI options
> >   --> Run-time PM core functionality (Disable)
> >   --> ACPI (Advanced Configuration and Power Interface) Support
> >       --> Processor (Disable)
> >   --> CPU Frequency scaling
> >       --> CPU Frequency scaling (Disable)
> >   --> CPU idle
> >       --> CPU idle PM support (Disable)
> >
> > after installing the xenomai user library, while  checking latency I
> > am getting the following error
> >
> > BUG: unable to handle kernel paging  request
> >
> > I have attached the screen shot of this bug
>
> Please attach a serial console and provide this as text.
>
> Henning
>
> > anybody can help me to solve this issue
> >
> > Thank you
> > R.Ashokkumar
> > -------------- next part --------------
> > A non-text attachment was scrubbed...
> > Name: Screenshot from 2018-07-12 19:14:08.png
> > Type: image/png
> > Size: 129556 bytes
> > Desc: not available
> > URL:
> > <http://xenomai.org/pipermail/xenomai/attachments/20180712/
> df4ce641/attachment.png>
> > _______________________________________________ Xenomai mailing list
> > Xenomai@xenomai.org
> > https://xenomai.org/mailman/listinfo/xenomai
>
>
