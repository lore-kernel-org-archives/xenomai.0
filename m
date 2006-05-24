From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] Strange behaviour of RTDM CAN driver
Date: Wed, 24 May 2006 12:23:41 +0200
References: <200605161240.33036.Sebastian.Smolorz@domain.hid>
	<16854688.1147779550976.JavaMail.ngmail@domain.hid>
	<Pine.GSO.4.58.0605161411160.1782@domain.hid>
In-Reply-To: <Pine.GSO.4.58.0605161411160.1782@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605241223.42176.Sebastian.Smolorz@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: u.marx@domain.hid

> On Tue, 16 May 2006 u.marx@domain.hid wrote:
> > I don't know your hardware, but i think it's a not a hardware problem.
> > Your desctription sounds more than a compiler optimization problem.
> >
> > Ok, this is your READ_REG definition,
> >
> >  /** Read access to a register of the SJA1000 CAN controller */
> > #define READ_REG(base, register) \
> >     readb((void *)(base+register))
> >
> > please try this one:
> >
> >  /** Read access to a register of the SJA1000 CAN controller */
> > #define READ_REG(base, register) \
> >     readb((volatile void *)(base+register))
>
> But I am desperate enough to try this one out. (That means mailing your
> suggestion to the person who owns the Advantech CAN card; developing a
> driver without the possibility to test it is really difficult.)

OK, i got the results. As I expected the patch above does not make any 
difference.


Sebastian

