MIME-Version: 1.0
from: "DEGROOTE Arnaud" <Arnaud.DEGROOTE@isae.fr>
message-id: <7016-53b1af80-3d5-7f54e300@12077259>
content-type: text/plain; charset="utf-8"
date: Mon, 30 Jun 2014 20:41:28 +0200
in-reply-to: <53B18C8F.6030807@xenomai.org>
content-transfer-encoding: quoted-printable
Subject: Re: [Xenomai] Support of Beagleboard xm rev C on 3.14-ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

 
On Monday, June 30, 2014 18:13 CEST, Gilles Chanteperdrix <gilles.chant=
eperdrix@xenomai.org> wrote: 
 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 06/30/2014 06:06 PM, Arnaud Degroote wrote:
> > On 30/Jun - 17:48, Gilles Chanteperdrix wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> On 06/30/2014 05:45 PM, Arnaud Degroote wrote:
> >>> On 30/Jun - 17:26, Gilles Chanteperdrix wrote:
> >>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>> 
> >>>> On 06/30/2014 05:18 PM, Arnaud Degroote wrote:
> >>>>> On 30/Jun - 14:37, Arnaud Degroote wrote: [snip]
> >>>>>>> Have you checked that the exact same kernel 
> >>>>>>> configuration, only without CONFIG=5FIPIPE and 
> >>>>>>> CONFIG=5FXENOMAI runs correctly under load?
> >>>>>> 
> >>>>>> The system seems to hang even without CONFIG=5FIPIPE. The 
> >>>>>> linux-yocto kernel seems to work properly (it looks like 
> >>>>>> a 3.14rc8), I will check precisely against linux kernel 
> >>>>>> v3.14.
> >>>>> 
> >>>>> Some additional information
> >>>>> 
> >>>>> linux mainstream kernel on tag v3.14 runs fine on the 
> >>>>> platform. The system hangs with ipipe branch ipipe-3.14 
> >>>>> (without xenomai stuff, and without CONFIG=5FIPIPE).
> >>>> 
> >>>> In the two cases the configuration is exactly the same?
> >>>> 
> >>> Yes, there are no semantic difference. The only diff are
> >>> 
> >>> CONFIG=5FLOCALVERSION
> >>> 
> >>> and the ipipe kernel has the extra line
> >>> 
> >>> # CONFIG=5FIPIPE is not set
> >>> 
> >> If you have a rootfs without hardfp (based on the codesourcery 
> >> toolchain for instance), could you try to boot without 
> >> CONFIG=5FVFP?
> > 
> > I don't have such toolchain for the moment, but I can try to hack 
=

> > my current yocto toolchain to test without hardfp.
> 
> The codesourcery toolchain is available for download, already compile=
d.
> 
> > Still, I have compiled a kernel without CONFIG=5FVFP but it still
> > hangs in the same place, so I don't think it is related to the
> > current issue.
> 
> If you are running a rootfs with hardfp with a kernel without
> CONFIG=5FVFP, the system should not finish booting.

Yes obviously, but at the moment, I don't arrive to the call to /sbin/i=
nit
> 
> Where does the system hang exactly? We were talking about a hang when=

> running switchtest. How do you produce the hang on a system without
> CONFIG=5FXENOMAI, since obviously you can not run switchtest?

Yes, sorry, I was not very precise.  I get the same behaviour than desc=
ribed in the 
beginning of the thread, i.e. the kernel hangs during the boot (and not=
hing happens after that). 
As I said previously, the hang happens with linux-ipipe without CONFIG=5F=
IPIPE. The various change
of configuration makes it "work" by accident.

An hanging kernel boot msg is available on my mail of 24 June, 14:21 CE=
ST. I cannont reproduce it at 
the moment, as I'm not anymore at work. 
> 
> - -- 
>                                                                 Gille=
s.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
> Comment: Using GnuPG with Icedove - http://www.enigmail.net/
> 
> iD8DBQFTsYyPGpcgE6m/fboRAuwoAJ9TEgar4bWWtMMJrSqrStuEI647awCfdYK+
> XhjleCJ3pCwymjmI0l/33hk=3D
> =3DADfr
> -----END PGP SIGNATURE-----
 
 
 
 


