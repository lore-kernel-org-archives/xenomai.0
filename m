Message-ID: <45893F80.9090700@domain.hid>
Date: Wed, 20 Dec 2006 14:49:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [RFC] git workflow
References: <20061219213010.AF2A4352664@domain.hid>	<45890361.7000709@domain.hid>	<458925AA.6000404@domain.hid>	<458936F5.2090006@domain.hid>
	<45893CEF.1010205@domain.hid>
In-Reply-To: <45893CEF.1010205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig05489CB9C37712860CC6EAF9"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main <adeos-main@gna.org>, Wolfgang Denk <wd@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05489CB9C37712860CC6EAF9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>>> A while ago I also played a bit with stgit and I was also not
>>> convinced, that it's the right tool for our purpose. Nevertheless, I
>>> could reduce the amount of git trees to manage (but I have to spend
>>> more time for a better judgment).
>>>
>>> Currently I'm porting IPIPE v1.6 over arch/powerpc rising a few code
>>> management issues. I started porting with i386-1.6-01 extracting the
>>> common part from that patch and adapting the arch specify code for
>>> arch/powerpc. Now IPIPE is at v1.6-02 and I realized various
>>> modifications, also of the noarch part including some serious bug
>>> fixes (local_irq_disable_head in main.c did hang my system). But now,=

>>> there is no easy way to update the noarch part as we deal with
>>> combined noarch + arch patches. From a new git based code management
>>> system, I would appreciate a separation of noarch and arch. This
>>> would make it easier to keep the archs in sync with Philippe's
>>> reference implementation (for x86). Any comments?
>>
>> IMHO, having the noarch and arch code separated is a nuisance. If ther=
e
>> was a centralized ipipe branch for 2.6.19, you would simply synchroniz=
e
>> your working copy with the server using the equivalent of "cvs/svn
>> update" and "cvs/svn commit". On the other hand, if the arch and noarc=
h
>> code was separated, you would end up with twice as much updates and
>> commits.
>=20
> That would mean that we handle more than one arch in a branch, e.g.
> i386, ppc, powerpc, etc., and the arch maintainer just commits his arch=

> specific changes. Well, this sounds good.

Ack, at least for Philippe's main tree. Splitting trees makes sense

 o when a different person maintains it (you and Gilles may want to
   publish your arch trees for early testers)
 o for different bases (e.g. 2.4 or 2.6.16-stable or Blackfin)

On major releases of the original kernel tree we could create a branch
and maybe continue in those branches to maintain a stable patch version
as long as reasonable. This would also involve pulling critical fixes to
the HEAD down into those branches (or the other trees).

Well, I'm still convinced that "deeply merged" ipipe patches in those
git trees are the way to go. I'm optimistic we will easily find
mechanisms (scripts) to extract a potential ipipe patch series from
those trees. I think Philippe did this with his CVS managed tree as
well. The patch borders should run clearly along files and (arch-)subdirs=
=2E

And my original idea to have a dedicated I-pipe tree without further
kernel code is probably not needed for this workflow.

Jan


--------------enig05489CB9C37712860CC6EAF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiT+DniDOoMHTA+kRAj+PAJ46Ahbi7lWr5tEdxy6wSGjXsSr/ygCfTidR
YQpkld8pHVSGCIKIYjbqgHw=
=P+I0
-----END PGP SIGNATURE-----

--------------enig05489CB9C37712860CC6EAF9--

