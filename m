Date: Mon, 13 Jun 2016 17:20:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160613152034.GK898@hermes.click-hack.org>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160403190948.GC20399@hermes.click-hack.org>
 <20160430064939.GC1781@hermes.click-hack.org>
 <09ef98ed5f8a438fa3703a3e3f5736f5@EDB2.wapice.localdomain>
 <20160613143016.GJ898@hermes.click-hack.org>
 <d7f1e0d09cba4c14a5e0e20d168a2141@EDB2.wapice.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d7f1e0d09cba4c14a5e0e20d168a2141@EDB2.wapice.localdomain>
Subject: Re: [Xenomai] PowerPC hardware watchpoints unstable with GDB and
 Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lassi =?iso-8859-1?Q?Niemist=F6?= <lassi.niemisto@wapice.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Jun 13, 2016 at 03:14:05PM +0000, Lassi Niemist=F6 wrote:
> > Whether or not you should contact the gdb mailing list is simple: if yo=
u get the issue without Xenomai, then it is a=20
> > gdb issue, if you get the issue only with Xenomai, then it is a Xenomai=
 issue, and there is no reason to bother the=20
> > gdb mailing list.
>=20
> Well, I had no idea which side contains the Xenomai support and I wished =
the GDB guys to provide some debugging hints. But if you see it most probab=
ly as a Xenomai issue, let's not cross-post it then.
>=20
>=20
> > Xenomai 2.6.1 is pretty old, a lot of things have been fixed since then=
, including issues with gdb. So, do you get the same issue with Xenomai 2.6=
.4?
>=20
> I will find out if we have the possibility of trying the version
> update with sensible effort.=20

The update should be painless: the two versions belong to the same
branch, they are ABI compatible. This means that you do not even
need to recompile your applications, you simply need to compile the
new xenomai version. Also, recompiling the kernel support should be
enough.

>=20
> A thought: I have been getting "warning: Unable to find libthread_db matc=
hing inferior's thread library, thread debugging will not be available." at=
 GDB startup, but ignored it this far as the threading has worked just fine=
.. Might this have anything to do with my issue, and does anyone know how t=
o get rid of the message on Xenomai? I know how to specify the library for =
GDB, but which one should be the correct for Xenomai?

No idea, I always debugged threaded programs with libthread_db.so,
and it has to come from the toolchain used to compile the target
gdb/gdbserver. And if using gdbserver, the cross-gdb running on host
and the gdbserver running on target should have the same version too.

--=20
					    Gilles.
https://click-hack.org

