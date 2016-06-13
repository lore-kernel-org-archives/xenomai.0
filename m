Date: Mon, 13 Jun 2016 16:30:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160613143016.GJ898@hermes.click-hack.org>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160403190948.GC20399@hermes.click-hack.org>
 <20160430064939.GC1781@hermes.click-hack.org>
 <09ef98ed5f8a438fa3703a3e3f5736f5@EDB2.wapice.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <09ef98ed5f8a438fa3703a3e3f5736f5@EDB2.wapice.localdomain>
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

On Mon, Jun 13, 2016 at 02:01:10PM +0000, Lassi Niemist=F6 wrote:
> Hello,
>=20
> Note: please keep gdb@sourceware.org as a recipient - I tried to post on =
both but xenomai rejected due to missing membership and I do not want to re=
-post on gdb..=20

Whether or not you should contact the gdb mailing list is simple: if
you get the issue without Xenomai, then it is a gdb issue, if you
get the issue only with Xenomai, then it is a Xenomai issue, and
there is no reason to bother the gdb mailing list.

>=20
> I am trying to debug (applications, not kernel) using hardware watchpoint=
s (memory breakpoints) with=20
>=20
> GDB: 7.10.1 and 7.11 (local mode)
> Processor: PowerPC e300c3 (MPC8309E)
> Xenomai: 2.6.1

Xenomai 2.6.1 is pretty old, a lot of things have been fixed since
then, including issues with gdb. So, do you get the same issue with
Xenomai 2.6.4?

--=20
					    Gilles.
https://click-hack.org

