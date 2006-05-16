Date: Tue, 16 May 2006 14:30:32 +0200 (MEST)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] Strange behaviour of RTDM CAN driver
In-Reply-To: <16854688.1147779550976.JavaMail.ngmail@domain.hid>
Message-ID: <Pine.GSO.4.58.0605161411160.1782@domain.hid>
References: <200605161240.33036.Sebastian.Smolorz@domain.hid>
	<16854688.1147779550976.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: u.marx@domain.hid
Cc: xenomai@xenomai.org

Hello Ulrich!

On Tue, 16 May 2006 u.marx@domain.hid wrote:
> I don't know your hardware, but i think it's a not a hardware problem.
> Your desctription sounds more than a compiler optimization problem.
>
> Ok, this is your READ_REG definition,
>
>  /** Read access to a register of the SJA1000 CAN controller */
> #define READ_REG(base, register) \
>     readb((void *)(base+register))
>
> please try this one:
>
>  /** Read access to a register of the SJA1000 CAN controller */
> #define READ_REG(base, register) \
>     readb((volatile void *)(base+register))

Thank you for your suggestion. In my initial mail I forgot to mention that
the problem of an over-optimising compiler came into my mind, too. I tried
several workarounds to exclude every effect of the compiler (compiling
with -O0 instead of -O2, replacing readb directly with the definition
used in the Linux Kernel sources, and lastly disassembling the driver to
assure myself that there are really memory access commands to the IO
memory). Also, when I compile the driver with the change you suggested,
the kernel module is not different to that compiled without that change.
But I am desperate enough to try this one out. (That means mailing your
suggestion to the person who owns the Advantech CAN card; developing a
driver without the possibility to test it is really difficult.)


Regards,

Sebastian

