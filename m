MIME-Version: 1.0
In-Reply-To: <50895B51.60409@xenomai.org>
References: <CANzNmi8DYqXmwtGe+Nu_HnLC8KgRO=H-29p6QBrjWrawreK_ig@mail.gmail.com>
	<508837F9.9060904@xenomai.org>
	<CANzNmi8qKWz2PwyS0e_fchO7xpcsq_a0yqDYbuiRU_PYVjsvQA@mail.gmail.com>
	<50883F34.4010604@xenomai.org>
	<CANzNmi-7SKy9HS=5g63=aMom1KsO_ZmxkdULe2gAteuPsuW+_A@mail.gmail.com>
	<50895B51.60409@xenomai.org>
Date: Thu, 25 Oct 2012 12:35:10 -0300
Message-ID: <CANzNmi_0j7sFOBpLSdsyAgbsdvcRdB=3448nMpoTDQiq_wg+=A@mail.gmail.com>
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Problem trying an example for the first time.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

2012/10/25 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 10/25/2012 05:21 PM, Sebastian Pavez wrote:
> > 2012/10/24 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 10/24/2012 09:08 PM, Sebastian Pavez wrote:
> >>>
> >>>
> >>> 2012/10/24 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> >>> <mailto:gilles.chanteperdrix@xenomai.org>>
> >>>
> >>>     On 10/24/2012 07:45 PM, Sebastian Pavez wrote:
> >>>     > Hi everyone,
> >>>     >
> >>>     > Finally I was able to boot the kernel with xenomai. I did that
> with
> >>>     > xenomai-2.6.1, linux-3.2.32 and ipipe-core-3.2.21-x86-1.patch
> with
> >>>     this
> >>>     > steps as a guide
> >>>     > http://code.google.com/p/jhu-lcsr-ros-pkg/wiki/UbuntuXenomai.
> >>>     >
> >>>     > Now when I try to execute an example like the one suggested on
> the
> >>>     quick
> >>>     > build guide I get an error, I attached the capt of this,
> >>>
> >>>     Please try to run the latency test or the xeno-test script first
> >> before
> >>>     trying to compile examples.
> >>>
> >>>     For patches on the issue with examples, see the mailing list
> >> archives.
> >>>
> >>>     --
> >>>                                                 Gilles.
> >>>
> >>> Thank you Gilles for your response  ... again
> >>>
> >>> I executed the test. I attach a capture of them.
> >>> I think the latency one is ok, but for xeno-test the result doesn't
> seem
> >>> nice.
> >>
> >> First, please stop wasting people's bandwidth with images. When the
> >> error is text, simply cut and paste the text.
> >>
> >> Please no private mails.
> >>
> >> Second the xeno-test you are running is not xenomai 2.6.1 xeno-test, so
> >> you have binaries of some other version of xenomai version installed,
> >> presumably xenomai 2.5. As explained in the troubleshooting guide, this
> >> is a risky situation.
> >>
> >>>
> >>> Regarding the issue with the examples I already read this post
> >>> http://www.xenomai.org/pipermail/xenomai/2012-October/026561.html but
> I
> >>> didn't understand exactly what to do with that ... I have to change the
> >>> entries that are different on the file??
> >>
> >> Try applying the patch. Using xenomai supposes that you are a C
> >> programmer and as such you should already have seen "unresolved
> >> symbols", and that you are familiar with using the common unix tools.
> >>
> >>>
> >>> One last question, what does it mean the negative values on the latency
> >>> test?? Are they normal??
> >>
> >> Yes, this too is an issue which has been discussed many times on this
> list.
> >>
> >>
> >> --
> >>                                             Gilles.
> >>
> >
> > Sorry for the private mail, I didn't mean to.
> >
> > Regarding the xeno-test issue, I don't know why other version of xenomai
> > could be on the system, I recognize that I tried a lot of things before
> but
> > never a Xenomai-2.5 ... In any case I re-install ubuntu from scratch to
> > prevent any mistake about that. However when I tried to run xeno-test,
> the
> > system demands me to install xenomai-runtime ... so, I did it. After
> that I
> > get the same results:
>
> What does apt-cache show xenomai-runtime say?
>
> --
>                                             Gilles.
>


Package: xenomai-runtime
Priority: extra
Section: universe/devel
Installed-Size: 688
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Roland Stigge <stigge@antcom.de>
Architecture: i386
Source: xenomai
Version: 2.5.5.2-1ubuntu2
Replaces: xenomai
Depends: libc6 (>= 2.11), libxenomai1
Suggests: linux-patch-xenomai, xenomai-doc
Conflicts: xenomai
Filename: pool/universe/x/xenomai/xenomai-runtime_2.5.5.2-1ubuntu2_i386.deb
Size: 145328
MD5sum: aba924557cd70b287c3eefc9dc2563ac
SHA1: cc77efe97fa6ecbbca862beaf03df5c58fe33255
SHA256: ae7f9ff546cabc4beda8f4a81e1c9814a4200e5eb69d13251b261229fa4f1255
Description-en: Xenomai runtime utilities
 Xenomai is a real-time development framework cooperating with the Linux
 kernel in order to provide a pervasive, interface-agnostic, hard real-time
 support to user-space applications, seamlessly integrated into the
GNU/Linux
 environment. Xenomai provides its own API and emulation layers ("skins") to
 make migration from other RTOS easier. Examples are: pSOS+, VxWorks, VRTX,
 uiTRON, RTAI, POSIX.
 .
 This package contains the runtime programs and the testsuite for the
Xenomai
 realtime system.
Homepage: http://www.xenomai.org/
Description-md5: 9a1401d98489cd8dc7f48a6473c339b1
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Origin: Ubuntu
