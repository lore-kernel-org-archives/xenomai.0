Message-ID: <3D90F20E.405769B0@domain.hid>
Date: Tue, 24 Sep 2002 19:15:26 -0400
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch 
 code
References: <3D8E8371.D2070D87@domain.hid> <20020922045907.C35@domain.hid> <3D90D388.746D0C0D@opersys.com> <20020924213356.GA14291@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Jacob Gorm Hansen <jg@domain.hid>
Cc: Pavel Machek <pavel@domain.hid>, linux-kernel <linux-kernel@domain.hid>, Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jacob Gorm Hansen wrote:
> On Tue, Sep 24, 2002 at 05:05:12PM -0400, Karim Yaghmour wrote:
> >
> > To be honest, nothing in Adeos is "new". Adeos is implemented on
> > classic early '90s nanokernel research. I've listed a number of
> > nanokernel papers in the paper I wrote on Adeos. A complete list
> > of nanokernel papers would probably have hundreds of entries.
> > Some of these nanokernels even had OS schedulers (exokernel for
> > instance). All Adeos implements is a scheme for sharing the
> > interrupts among the various OSes using an interrupt pipeline.
> 
> Hi,
> 
> are you planning to add spaces & portals, like in Space or Pebble?

I'm not sure whether what we plan to offer actually fits Space's definition
of spaces, but domains already exist and portals should be trivial to
implement over what we already have. For details on what plan to offer
in terms of spaces, take a look at the paper I wrote describing how
to implement Linux SMP clusters:
http://opersys.com/ftp/pub/Adeos/practical-smp-clusters.ps
Basically, Adeos would hand over RAM regions according to each OS
instance's requests. In such a case, each kernel would have its own
virtual memory and communication would be possible using "bridges",
shared physical RAM regions. Many OSes can coexist in the same virtual
address space, but the mechanisms for managing the virtual address
space are not up to Adeos.

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================


