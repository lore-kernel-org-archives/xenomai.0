From: Gregory Perry <Gregory.Perry@govirtual.tv>
Date: Mon, 11 Feb 2013 17:50:34 +0000
Message-ID: <718DFA7882181D45B8BD18F31C46D55427A67767@MBX204.domain.local>
References: <718DFA7882181D45B8BD18F31C46D55427A67586@MBX204.domain.local>
	<718DFA7882181D45B8BD18F31C46D55427A675C0@MBX204.domain.local>,
	<C2B9A61F-3727-4B5F-9AC4-8212B803A725@mah.priv.at>
In-Reply-To: <C2B9A61F-3727-4B5F-9AC4-8212B803A725@mah.priv.at>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Question about 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mah@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>________________________________________
>From: Michael Haberler [mah@mah.priv.at]
>Sent: Monday, February 11, 2013 6:06 AM
>To: Gregory Perry
>Subject: Re: [Xenomai] Question about 2.6.2.1
>
>Am 11.02.2013 um 06:23 schrieb Gregory Perry:
>
>> How do I go about finding out what the most recent kernel for ARM that i=
s supported by 2.6.2.1?  Is it still 3.2.21?  Can someone point me to the f=
ile in the Xenomai >distro which describes the most recent kernel released =
with each Xenomai?
>>
>> I am going to take the plunge and patch each release up to 3.2.21 on the=
 BeagleBone with the TI support patches, and then attempt a Xenomai integra=
tion on that >optimized TI kernel.
>
>are you aware of this:
>
>http://wiki.linuxcnc.org/cgi-bin/wiki.pl?BeagleboneDevsetup
>
>and this
>
>http://git.mah.priv.at/gitweb?p=3Dlinuxcnc-kernel.git;a=3Dsummary ?
>
>- Michael

Yeah I've been following the EMC project for a while now as well as other i=
nitiatives to build Xenomai on the BeagleBone and BeagleBoard.  In fact I t=
hink that Stephan Kappertz has posted the best integration to date for the =
BeagleBone and Xenomai on Angstrom; however I am not aware of anyone to dat=
e that's been able to successfully integrate all of the TI patches into the=
 kernel and then patch the kernel with Xenomai.  So either you get the Beag=
leBone kernel with all all TI optimizations, or a generic kernel with Xenom=
ai support, but not both.  Typically this breaks support for additional thi=
ngs in the kernel, probably sysfs support for sysfs-based GPIO access and P=
WM toggling etc.

So according to Robert Nelson (the TI patch maintainer for the BeagleBoard/=
Bone kernel), the only way to do this is to start with the Aragon kernel, a=
pply each kernel revision patch from 3.2.0 -> 3.2.21, with the TI patch bra=
nch applied at each to arrive at a 3.2.21 kernel that has all of the TI pat=
ches integrated.

I think this is the right approach, or maybe I am just shooting fish in a b=
arrel here with this.

