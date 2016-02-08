Date: Mon, 8 Feb 2016 09:14:46 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160208091446.3e2239f9@md1em3qc>
In-Reply-To: <1454699543.2925.13.camel@hpe.com>
References: <20160204131901.6cd6924b@md1em3qc>
 <1454604076.7389.27.camel@hpe.com>
 <20160204173528.50a028bb@md1em3qc>
 <1454618843.7389.35.camel@hpe.com>
 <20160205105128.027df956@md1em3qc>
 <1454699543.2925.13.camel@hpe.com>
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

On Fri, 5 Feb 2016 12:12:23 -0700
Toshi Kani <toshi.kani@hpe.com> wrote:

> On Fri, 2016-02-05 at 10:51 +0100, Henning Schild wrote:
> > On Thu, 4 Feb 2016 13:47:23 -0700
> > Toshi Kani <toshi.kani@hpe.com> wrote: =20
> =C2=A0:
> > >=20
> > > When a process is created via fork(), it calls pgd_alloc(), which
> > > then calls pgd_ctor(). =C2=A0This function copies the kernel's pgd
> > > entries to the process's pgd for the kernel ranges. =C2=A0So,
> > > process's pgd shares the same page tables for the kernel space. =20
> >=20
> > Sure a new process will inherit the current kernel reference. The
> > pinning we do is for pre-existing mm's that did not inherit those
> > parts when they where forked. Hence the example with init and a
> > later insmod causing ioremap. There has to be a way to sync the
> > changes from the insmod mm into the init-mm. Otherwise running the
> > device driver in the init-mm could cause #PFs.
> > So i am afraid it is still not completely clear to me. =20
>=20
> Agreed. =C2=A0We need to sync when a run-time call to ioremap caused
> allocation of a new pud table.
>
> > > Let me know if I am missing something. =20
> >=20
> > Sorry to bother you with these questions, but you obviously know
> > that subsystem better than me. =20
>=20
> Thanks for pointing this out. =C2=A0I will work on the fix.
> -Toshi
>=20
> ps.
> xenomai list rejects my reply since I'm not a subscriber.

I do not know how this list in configured, but that should probably be
fixed. But this answer to your mail should make sure it ends up in the
archive.

Henning

