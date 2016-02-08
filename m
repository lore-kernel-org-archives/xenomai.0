Date: Mon, 8 Feb 2016 09:24:38 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160208092438.5d5d8489@md1em3qc>
In-Reply-To: <1454716405.2925.18.camel@hpe.com>
References: <20160204131901.6cd6924b@md1em3qc>
 <1454604076.7389.27.camel@hpe.com>
 <20160204173528.50a028bb@md1em3qc>
 <1454618843.7389.35.camel@hpe.com>
 <20160205105128.027df956@md1em3qc>
 <1454699543.2925.13.camel@hpe.com>
 <1454716405.2925.18.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] huge ioremap from kernel 4.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, 5 Feb 2016 16:53:25 -0700
Toshi Kani <toshi.kani@hpe.com> wrote:

> On Fri, 2016-02-05 at 12:12 -0700, Toshi Kani wrote:
> > On Fri, 2016-02-05 at 10:51 +0100, Henning Schild wrote: =20
> > > On Thu, 4 Feb 2016 13:47:23 -0700
> > > Toshi Kani <toshi.kani@hpe.com> wrote: =20
> > =C2=A0: =20
> > > >=20
> > > > When a process is created via fork(), it calls pgd_alloc(),
> > > > which then
> > > > calls pgd_ctor(). =C2=A0This function copies the kernel's pgd
> > > > entries to the process's pgd for the kernel ranges. =C2=A0So,
> > > > process's pgd shares the same page tables for the kernel
> > > > space. =20
> > >=20
> > > Sure a new process will inherit the current kernel reference. The
> > > pinning we do is for pre-existing mm's that did not inherit those
> > > parts when they where forked. Hence the example with init and a
> > > later insmod causing ioremap. There has to be a way to sync the
> > > changes from the insmod mm into the init-mm. Otherwise running
> > > the device driver in the init-mm could cause #PFs.
> > > So i am afraid it is still not completely clear to me. =20
> >=20
> > Agreed. =C2=A0We need to sync when a run-time call to ioremap caused
> > allocation
> > of a new pud table.
> >  =20
> > > > Let me know if I am missing something. =20
> > >=20
> > > Sorry to bother you with these questions, but you obviously know
> > > that subsystem better than me. =20
> >=20
> > Thanks for pointing this out. =C2=A0I will work on the fix. =20
>=20
> Can you test the attached patch to see if it solves your problem? =C2=A0I
> have tested 64-bit, but have not been able to test 32-bit yet due to
> an issue in my setup.

I will give it a try, but since we are still at 4.1 i need to backport
it. Plus it actually looks exactly like what i already came up with.

http://xenomai.org/pipermail/xenomai/2016-February/035822.html

But before making that part of "our" xenomai patch-stack we wanted to
understand why mainline did not have the problem we experienced.

That looks like the kind of patch that needs backporting all the way to
4.1. Who is responsible for such a backport?

Henning

