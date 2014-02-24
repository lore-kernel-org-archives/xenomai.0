References: <1392798642.29863.YahooMailNeo@web163904.mail.gq1.yahoo.com>
 <201402191131.57684.paul_c@tuxcnc.org>
 <1392902695.25358.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <5306058A.7060107@xenomai.org>
 <1392906926.89759.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <53061485.6090500@xenomai.org>
Message-ID: <1393246468.37730.YahooMailNeo@web163903.mail.gq1.yahoo.com>
Date: Mon, 24 Feb 2014 04:54:28 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <53061485.6090500@xenomai.org>
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

On Thursday, February 20, 2014 3:44 PM, Gilles Chanteperdrix <gilles.chante=
perdrix@xenomai.org> wrote:=0A =0AOn 02/20/2014 03:35 PM, Huub Van Niekerk =
wrote:=0A>=0A>=0A>=0A> On Thursday, February 20, 2014 2:39 PM, Gilles Chant=
eperdrix=0A> <gilles.chanteperdrix@xenomai.org> wrote:=0A> On 02/20/2014 02=
:24 PM, Huub Van Niekerk wrote:=0A>=0A>=A0 >=0A>=A0 >=0A>=A0 > On Wednesday=
, February 19, 2014 12:32 PM, Paul <paul_c@tuxcnc.org=0A> <mailto:paul_c@tu=
xcnc.org>>=0A>=A0 > wrote:=0A>=A0 >=0A>=A0 > On Wednesday 19 February 2014,=
 Huub Van Niekerk wrote:=0A>=A0 >=0A>=A0 >> The patch you created for the a=
rmhf architecture, will it work=0A>=A0 >> with older Linux kernels such as =
2.6.x and 3.2.x as well ?=0A>=A0 >=0A>=A0 >> Just to clarify, the patch tha=
t I submitted is for the Broadcom=0A>=A0 >> BCM2835 SoC (an ARMv6K core) - =
armhf covers a variety of ARM=0A>=A0 >> flavours.=0A>=A0 >=0A>=A0 >> If you=
 can find a 2.6.xx kernel that has support for the BCM2835=0A>=A0 >> AND in=
cludes the DWC-OTG drivers, there is no reason why the=0A>=A0 >> Raspberry =
Pi patch couldn't be adapted.=0A>=A0 >=0A>=A0 >> The 3.2.x kernel reportedl=
y had a few serious bugs - I don't know=0A>=A0 >> if these bugs impacted on=
 the BCM2835 or the operation of Xenomai.=0A>=A0 >> If you are looking at u=
sing a 3.x.x series kernel, it would be=0A>=A0 >> advisable to get the late=
st stable release that has a corresponding=0A>=A0 >> Xenomai patch.=0A>=A0 =
>=0A>=A0 > I just tried to build xenomai-2.6.2 on armhf (after applying you=
r=0A>=A0 > patch) using debuild -us -uc. This fails with an error I had bef=
ore:=0A>=A0 > fatal error at line 1350: dpkg-buildpackage -rfakeroot -B -us=
 -uc=0A>=A0 > failed. Does this mean that your patch is not suitable for v.=
 2.6.2=0A>=0A>=A0 > ?=0A>=0A>=A0 >Please do not use 2.6.2, it was so buggy =
that 2.6.2.1 was released just=0A>=A0 >a little time after. And in fact, th=
ere is no reason not to use 2.6.3,=0A>=A0 >it is ABI compatible with 2.6.2 =
and 2.6.2.1.=0A>=0A> OK. The reason I tried 2.6.2 is that this version has =
a patch for kernel=0A> 3.2, which 2.6.3 has not, as far as I can see.=0A=0A=
>Bad reason:=0A>- the patch for 3.2 is broken, as has been said several tim=
es on this =0A>mailing list, including in the very first answer you receive=
d in this =0A>same discussion thread;=0A>- the latest version of Xenomai sh=
ould be compatible with all the past =0A>patches (though it only has been w=
ell tested with the latest patch it =0A>provides).=0AOut of curiosity: has =
this patch actually been tested on an armhf board prior to releasing to me =
or stock ?=0A
