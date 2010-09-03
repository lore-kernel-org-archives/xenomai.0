From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100903085639.12173@domain.hid>
References: <20100903085639.12173@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 03 Sep 2010 16:32:18 +0200
Message-ID: <1283524338.1709.2133.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai-help Digest, Vol 60, Issue 2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: C Robinson <starknight__@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-09-03 at 08:56 -0400, C Robinson wrote:
> Hi,
>=20
> So the position I am in is still not knowing how to run the examples.   A=
ttempting the command "sudo make  /home/<user name>/xenomai-2.5.4" from the=
 directory /usr/xenomai_egs/xenomai-head/examples/, results in the followin=
g error (as mentioned previously):
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------
> xddp-echo.c: In function ?realtime_thread?:
> xddp-echo.c:115: error: ?SOL_XDDP? undeclared (first use in this function=
)
> xddp-echo.c:115: error: (Each undeclared identifier is reported only once
> xddp-echo.c:115: error: for each function it appears in.)
> xddp-echo.c:115: error: ?XDDP_POOLSZ? undeclared (first use in this funct=
ion)
> make[1]: *** [xddp-echo] Error 1
> -------------------------------------------------------------------------=
--------------------------------------------------
>=20
> and shortly afterwards ended with:
>=20
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/usr/xenomai_egs/xenomai-head/examples/posix'
>=20
> How do I get around this error?  In addition, is it ok to use the default=
 user account. (or should a specific xenomai account be set up)
>=20

The guidelines are misleading, in the sense that pulling xenomai-head
today will download the code for the upcoming 2.6.x release.
Unfortunately, changes were made to the rtipc support for 2.6.x, which
are not available to 2.5.x. So, building the xenomai-head (2.6.x)
examples against headers and libraries belonging to 2.5(.4) won't
neither build nor work.

Sorry for the time lost fiddling with this. The guidelines were written
at a time when -head was actually the development tree for the 2.5.x
release. We opened the 2.6.x branch recently, thus becoming the new
-head.

>=20
> Trying to get up the man pages results in:
>=20
> -------------------------------------------------------------------------=
--------------------------------------------------
> clocktest man
> The program 'clocktest' is currently not installed.  You can install it b=
y typing:
> sudo apt-get install xenomai-runtime
> -------------------------------------------------------------------------=
--------------------------------------------------
> Is this because I installed the xenomai-runtime package manually via the =
Debian guideline ? (Synaptic shows this as being already installed, perhaps=
 this is a result of the earlier problem?).
>=20

I can't tell, but I can give you the steps to build any 2.5.x release
the way it should work for you, i.e. from the official tarball, assuming
x86 is your target system:

- unpack xenomai-2.5.4.tar.bz2 (yeah, ok, this one is no news)
- mkdir -p .../your/build/tree
- cd .../your/build/tree
- .../xenomai-2.5.4/configure [--enable-x86-sep]* [--prefix=3D/install-dir]
- make install

At this stage, you should have the userland bits properly compiled and
installed in /install-dir. This defaults to /usr/xenomai if
unspecified.=20

Those userland bits should work with any Xenomai 2.5.x kernel support,
regardless of whether you got it from the ubuntu/debian repos via apt,
or rebuilt it manually, assuming that the distro package was built with
sane defaults.

If you plan to rebuild your own kernel with Xenomai support instead of
picking the one shipped with the distro, then README.INSTALL, =C2=A72.1
should help. Why this could be a good idea is explained here:=20
http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86_k=
ernel

If you go for manual install, I would suggest that you purge all
previous Xenomai packages from your system, to avoid hair pulling
conflicts.

(*) best for x86_32, unless if running pre-Pentium II+ antiques. Not
needed on x86_64.

>=20
> Thanks,
> Charles
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



