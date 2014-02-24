References: <1392798642.29863.YahooMailNeo@web163904.mail.gq1.yahoo.com>
 <201402191131.57684.paul_c@tuxcnc.org>
 <1392902695.25358.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <5306058A.7060107@xenomai.org>
 <1392906926.89759.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <53061485.6090500@xenomai.org>
 <1393246468.37730.YahooMailNeo@web163903.mail.gq1.yahoo.com>
 <530B4F14.8050400@xenomai.org>
Message-ID: <1393251827.35887.YahooMailNeo@web163905.mail.gq1.yahoo.com>
Date: Mon, 24 Feb 2014 06:23:47 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <530B4F14.8050400@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] armhf patch
Reply-To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Monday, February 24, 2014 2:54 PM, Gilles Chanteperdrix <gilles.chantepe=
rdrix@xenomai.org> wrote:=0A =0AOn 02/24/2014 01:54 PM, Huub Van Niekerk wr=
ote:=0A> On Thursday, February 20, 2014 3:44 PM, Gilles Chanteperdrix=0A> <=
gilles.chanteperdrix@xenomai.org> wrote:=0A> On 02/20/2014 03:35 PM, Huub V=
an Niekerk wrote:=0A>=A0 >=0A>=A0 >=0A>=A0 >=0A>=A0 > On Thursday, February=
 20, 2014 2:39 PM, Gilles Chanteperdrix=0A>=A0 > <gilles.chanteperdrix@xeno=
mai.org=0A> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:=0A>=A0 > On 0=
2/20/2014 02:24 PM, Huub Van Niekerk wrote:=0A>=A0 >=0A>=A0 >=A0 >=0A>=A0 >=
=A0 >=0A>=A0 >=A0 > On Wednesday, February 19, 2014 12:32 PM, Paul <paul_c@=
tuxcnc.org=0A> <mailto:paul_c@tuxcnc.org>=0A>=A0 > <mailto:paul_c@tuxcnc.or=
g <mailto:paul_c@tuxcnc.org>>>=0A>=A0 >=A0 > wrote:=0A>=A0 >=A0 >=0A>=A0 >=
=A0 > On Wednesday 19 February 2014, Huub Van Niekerk wrote:=0A>=A0 >=A0 >=
=0A>=A0 >=A0 >> The patch you created for the armhf architecture, will it w=
ork=0A>=A0 >=A0 >> with older Linux kernels such as 2.6.x and 3.2.x as well=
 ?=0A>=A0 >=A0 >=0A>=A0 >=A0 >> Just to clarify, the patch that I submitted=
 is for the Broadcom=0A>=A0 >=A0 >> BCM2835 SoC (an ARMv6K core) - armhf co=
vers a variety of ARM=0A>=A0 >=A0 >> flavours.=0A>=A0 >=A0 >=0A>=A0 >=A0 >>=
 If you can find a 2.6.xx kernel that has support for the BCM2835=0A>=A0 >=
=A0 >> AND includes the DWC-OTG drivers, there is no reason why the=0A>=A0 =
>=A0 >> Raspberry Pi patch couldn't be adapted.=0A>=A0 >=A0 >=0A>=A0 >=A0 >=
> The 3.2.x kernel reportedly had a few serious bugs - I don't know=0A>=A0 =
>=A0 >> if these bugs impacted on the BCM2835 or the operation of Xenomai.=
=0A>=A0 >=A0 >> If you are looking at using a 3.x.x series kernel, it would=
 be=0A>=A0 >=A0 >> advisable to get the latest stable release that has a co=
rresponding=0A>=A0 >=A0 >> Xenomai patch.=0A>=A0 >=A0 >=0A>=A0 >=A0 > I jus=
t tried to build xenomai-2.6.2 on armhf (after applying your=0A>=A0 >=A0 > =
patch) using debuild -us -uc. This fails with an error I had before:=0A>=A0=
 >=A0 > fatal error at line 1350: dpkg-buildpackage -rfakeroot -B -us -uc=
=0A>=A0 >=A0 > failed. Does this mean that your patch is not suitable for v=
. 2.6.2=0A>=A0 >=0A>=A0 >=A0 > ?=0A>=A0 >=0A>=A0 >=A0 >Please do not use 2.=
6.2, it was so buggy that 2.6.2.1 was released just=0A>=A0 >=A0 >a little t=
ime after. And in fact, there is no reason not to use 2.6.3,=0A>=A0 >=A0 >i=
t is ABI compatible with 2.6.2 and 2.6.2.1.=0A>=A0 >=0A>=A0 > OK. The reaso=
n I tried 2.6.2 is that this version has a patch for kernel=0A>=A0 > 3.2, w=
hich 2.6.3 has not, as far as I can see.=0A>=0A>=A0 >Bad reason:=0A>=A0 >- =
the patch for 3.2 is broken, as has been said several times on this=0A>=A0 =
>mailing list, including in the very first answer you received in this=0A>=
=A0 >same discussion thread;=0A>=A0 >- the latest version of Xenomai should=
 be compatible with all the past=0A>=A0 >patches (though it only has been w=
ell tested with the latest patch it=0A>=A0 >provides).=0A>=0A> Out of curio=
sity: has this patch actually been tested on an armhf board=0A> prior to re=
leasing to me or stock ?=0A=0A>I do not known what patch you are talking ab=
out. But the I-pipe patches =0A>are tested on omap3 and omap4, with armhf c=
ompilers before each release.=0A=0A>Now, if you are talking about the gener=
ation of Debian packages, 2.6.2 =0A>was released with a broken debian/rules=
, which was the main reason for =0A>releasing 2.6.2.1. Now, I have to admit=
 that I do not generate debian =0A>packages, I let others do it.=0A=0A>I co=
nsider that validating Xenomai with armhf compiler proves that it =0A>can w=
ork.=0A=0AOk, thank you for the answer. By further testing I found my probl=
em is somewhere in the kernel and so far has nothing to do with Xenomai.
