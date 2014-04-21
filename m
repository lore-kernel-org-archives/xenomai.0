References: <5352BA1D.7070707@xenomai.org>
 <1398061722.33492.YahooMailNeo@web163901.mail.gq1.yahoo.com>
 <5354D3AB.3020009@xenomai.org>
Message-ID: <1398083901.18170.YahooMailNeo@web163905.mail.gq1.yahoo.com>
Date: Mon, 21 Apr 2014 05:38:21 -0700 (PDT)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <5354D3AB.3020009@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Pre/Post patches
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

On Monday, April 21, 2014 10:15 AM, Gilles Chanteperdrix <gilles.chanteperd=
rix@xenomai.org> wrote:=0A =0ALe 21/04/2014 08:28, Huub Van Niekerk a =E9cr=
it :=0A>>On Saturday, April 19, 2014 8:07 PM, Gilles Chanteperdrix=0A> <gil=
les.chanteperdrix@xenomai.org> wrote:=0A> =0A>>Hi all,=0A> =0A>>I am curren=
tly validating the I-pipe patch for Linux 3.14 on armv4 and=0A>>armv5, but =
it should already work for armv6 and armv7 processors, it is=0A>>available =
as a branch for-ipipe-3.14.0 in ipipe-gch git. Could you have=0A>>a look at=
 it on BeagleBone, Raspberry and Zynq? For the SOCs supported=0A>>by mainli=
ne, please simply send patches to the for-ipipe-3.14.0 branch.=0A> =0A> Hi,=
=0A> =0A> When looking at http://git.xenomai.org/ipipe-gch.git/?h=3Dfor-ipi=
pe-3.14.0=0A> , I think I see several patches but I'm not sure how to act t=
o get a=0A> patch for the armv7 (armhf / beagle-xm).=0A=0A>Note that the ma=
il was intended for BeagleBone, Raspberry and Zynq. For=0A>beagleboard, the=
 kernel should already work, and you can wait for the=0A>final I-pipe patch=
 to be released. But if you want to validate the=0A>kernel early, please go=
 ahead, it will not hurt.=0A=0A>Simply checkout this tree, and use it with =
the "prepare-kernel.sh"=0A>script, it will detect that the tree already con=
tains the I-pipe=0A>changes, and will not try and apply an I-pipe patch.=0A=
=0AOk, I think I will wait for the final I-pipe patch then (assuming it won=
't be a long wait). BTW, with this be for version 2.6.3 or a new version ?=
=0A
