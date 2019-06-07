MIME-Version: 1.0
References: <CAEmXcAzOL4M-JRUWgm3mjmz+bQ=nHc-QW5dr-iBc24RXXu5CTg@mail.gmail.com>
 <320b1c56-047f-764f-036a-d3302ddbd0f4@siemens.com>
 <CAEmXcAxuFzE2uQHGMUjBnbgadTTcNU_DwV64uvLPahxxDMKTyQ@mail.gmail.com>
 <be5b28d1-e689-5c60-4d20-2be511ec489a@siemens.com>
 <CAEmXcAxs3O_Hmph-48JArHgCmWSj+wAiffkNCZKiL9uVew6irg@mail.gmail.com>
 <22b6931e-8f7b-0cae-2316-5b278d1186d6@siemens.com>
 <CAEmXcAzzSfT5jVQpM2CidLh-CCJRPt45jJMRq_mmXz0wHFnyXQ@mail.gmail.com>
 <34f86f81-70f4-9b07-26e7-3525bfaf6fcf@siemens.com>
In-Reply-To: <34f86f81-70f4-9b07-26e7-3525bfaf6fcf@siemens.com>
From: danwe <daniel.wenninger92@gmail.com>
Date: Fri, 7 Jun 2019 10:09:26 +0200
Message-ID: <CAEmXcAz6p9yg65uigQx6zJyey1nnkmdq8+i1Ou2bT888n-thrg@mail.gmail.com>
Subject: Re: Fwd: Round-Trip Time Requester with Xenomai / RTnet on Beaglebone
 Black
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

I'm sorry I did upload the old Makefile as I had a source-file which was
using the "native" skin. For "rtt-sender" and "rtt-responder" I was using
the posix skin. Otherwise it would throw "undefined reference" error and I
it would not be able to compile my source-file. So I did use POSIX skin and
the compiling was successful but there is still the error that the network
is not reachable when I'm running "rtt-sender". By running "rtt-responder"
no error occurs.. Any other ideas? Could it be a problem that I have to
define which MAC belongs to which IP address like I described before?

Regards

Daniel

Am Fr., 7. Juni 2019 um 07:00 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com
>:

> On 06.06.19 19:50, danwe via Xenomai wrote:
> > ---------- Forwarded message ---------
> > Von: Jan Kiszka <jan.kiszka@siemens.com>
> > Date: Do., 6. Juni 2019 um 12:14 Uhr
> > Subject: Re: Round-Trip Time Requester with Xenomai / RTnet on Beaglebone
> > Black
> > To: danwe <daniel.wenninger92@gmail.com>
> >
> >
> > Mailingliste!
> >
> > On 06.06.19 12:10, danwe wrote:
> >> Oh that's what I'm doing. Sorry for the misunderstanding.
> >> There is a provided makefile for all source-files which needs to be
> > compiled.
> >> When I like to compile a source-file I do need to set some flags (will
> be
> > done
> >> in Makefile) and set some variables (will be done by export commands). I
> > am
> >> setting DESTDIR variable because it is using by xeno-config.
> >> So before I am compile anything with makefile I am using the following
> > commands
> >> in the Linux terminal of Virtual Box where my Makefile is located:
> >>
> >> $ export
> DESTDIR=~/Desktop/compile/Daniel/buildroot-2014.08/output/staging
> >>
> >> $ export
> >>
> >
> PATH=~/Desktop/compile/Daniel/buildroot-2014.08/output/host/usr/bin:$DESTDIR/usr/bin:$PATH
> >>
> >>
> >> And now I can compile source-files with my Makefile. If I do not export
> > these
> >> variables I do get error while compiling or at least I do get some
> > warnings. Now
> >> with export commands and my Makefile I do not get any errors or warnings
> > and
> >> some programs are running (like "raw-ethernet" provided by buildroot)
> but
> > one
> >> error with the "rtt-sender" file.
> >>
> >> The Makefile is the following:
> >>
> >> # Allow overriding xeno-config on make command line
> >> XENO_CONFIG := xeno-config
> >>
> >> prefix := $(shell $(XENO_CONFIG) --prefix)
> >>
> >> ifeq ($(prefix),)
> >> $(error Please add <xenomai-install-path>/bin to your PATH variable)
> >> endif
> >>
> >> CC := $(shell $(XENO_CONFIG) --skin=native --cc)
> >> STD_CFLAGS  := $(shell $(XENO_CONFIG) --skin=native --cflags) -g
> >> STD_LDFLAGS := $(shell $(XENO_CONFIG) --skin=native --ldflags) -g -lrtdm
> >>
>
> The rtt examples are using the posix skin, not "native". So your makefile
> fails
> to wrap socket, sendmsg etc. calls to the Xenomai implementation.
>
> Jan
>
> >> STD_TARGETS := rtt-sender
> >>
> >> all: $(STD_TARGETS)
> >>
> >> $(STD_TARGETS): $(STD_TARGETS:%=%.c)
> >> $(CC) -o $@ $< $(STD_CFLAGS) $(STD_LDFLAGS)
> >>
> >> clean:
> >> $(RM) -f *.o *~ $(STD_TARGETS)
> >>
> >>
> >> Regards.
> >>
> >>
> >> Daniel
> >>
> >>
> >> Am Do., 6. Juni 2019 um 12:00 Uhr schrieb Jan Kiszka <
> > jan.kiszka@siemens.com
> >> <mailto:jan.kiszka@siemens.com>>:
> >>
> >>      [Re-adding the list]
> >>
> >>      On 06.06.19 11:40, danwe wrote:
> >>       > Hello Jan,
> >>       >
> >>       > yes the source for RTnet was the reason for the version choice.
> I
> > did get
> >>      the
> >>       > whole operation system (with Kernel, Xenomai, RTnet) from one
> > programmer who
> >>       > made it out of buildroot and who said that RTnet is only working
> > on BBB
> >>      if you
> >>       > use that version. It may work on Xenomai 3 but you have to do
> some
> > config
> >>       > operations and I do not have time in my research work for
> changing
> > to
> >>      Xenomai 3.
> >>       > The whole Xenomai 2 thing was made before in a research work.
> >>       > I do have two source-files working under RTnet where no error
> > occur. These
> >>       > source-files like "raw-ethernet.c" or "rtping.c" did come with
> the
> >>      buildroot. So
> >>       > did the files "rtt-sender" and "rtt-responder" come from. Those
> > files were
> >>       > developed for using RTnet. I did compile theses files by using a
> > makefile
> >>      which
> >>       > is necessary for that operation system which was build by
> > buildroot. I
> >>      have used
> >>       > that makefile for e.g. "raw-ethernet" and it's working finde.
> >>
> >>      And this manual step is very likely the source for the error. Make
> > sure you
> >>      build and link with the proper flags provided by xeno-config.
> >>
> >>      Jan
> >>
> >>       >
> >>       > Daniel
> >>       >
> >>       > Am Do., 6. Juni 2019 um 08:06 Uhr schrieb Jan Kiszka
> >>      <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
> >>       > <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com
> >>>:
> >>       >
> >>       >     On 05.06.19 12:30, danwe via Xenomai wrote:
> >>       >      > Hello,
> >>       >      >
> >>       >      > I am using two Beaglebone Black with Linux kernel version
> > 3.8.13 and
> >>       >      > Xenomai version 2.6.3. I have built the Kernel with
> Xenomai
> > and
> >>      RTnet with
> >>       >
> >>       >     Why did you choose these old versions? The problem might be
> >>      unrelated, but it's
> >>       >     now impossible for us to reproduce easily.
> >>       >
> >>       >     Where did you get the RTnet Ethernet driver from? It's not
> > upstream
> >>      as far as I
> >>       >     know. Was that source the reason for this version choice
> >>       >
> >>       >
> >>       >      > buildroot. At the moment I am trying to use the provided
> > source-files
> >>       >      > "rtt-sender" and "rtt-responder" for sending some
> > "Round-Trip Time
> >>      Request".
> >>       >      > I have changed my destination IP in "rtt-responder" to my
> >>      destination BBB.
> >>       >      > I did not do any other changes. Then I did run
> > "rtt-responder" on
> >>      BBB2 and
> >>       >      > "rtt-sender" on BBB1 but I always get the following
> error:
> >>       >      > [image: image.png]
> >>       >
> >>       >     Better copy&paste the text from the console than taking
> > screenshots.
> >>       >
> >>       >     The error messages could indicate that those tools are
> trying
> > to use
> >>      regular
> >>       >     Linux sockets, not RTnet ones. Did you compile them
> manually,
> > or
> >>      where they
> >>       >     built by the Xenomai build system? Check if they refer to
> > symbols like
> >>       >     "__wrap_socket", rather than just "socket".
> >>       >
> >>       >     Jan
> >>       >
> >>       >      > Can anyone tell me why I do get that error?
> >>       >      > In order to this I need to say that both BBB's get a
> random
> > MAC-Adress
> >>       >      > after each boot. That means I need to tell each BBB which
> > MAC adress
> >>       >      > belongs to which IP-Adress. For example BBB1 has IP
> > 192.168.127.10
> >>      with MAC
> >>       >      > AA:AA:AA:AA:AA and BBB2 has IP 192.168.127.11 with MAC
> >>      BB:BB:BB:BB:BB I
> >>       >      > need to execute the following commands:
> >>       >      >
> >>       >      > For BBB1: rtroute add 192.168.127.11 BB:BB:BB:BB:BB dev
> > rteth0
> >>       >      > For BBB2: rtroute add 192.168.127.10 AA:AA:AA:AA:AA dev
> > rteth0
> >>       >      >
> >>       >      > Now it is possible to send rtpings with the command:
> rtping
> >>      192.168.127.10
> >>       >      > or rtping 192.168.127.11. Depens on which BBB you want to
> > send the
> >>      ping.
> >>       >      >
> >>       >      > So my idea was it is only possible to run the
> "rtt-sender"
> > and
> >>       >      > "rtt-responder" file when my BBB's know which MAC belongs
> > to which IP.
> >>       >      >
> >>       >      > But there is still the error, that the Network is
> > unreachable. Why?
> >>       >      >
> >>       >      > You can find the source-files enclosed.
> >>       >      >
> >>       >      > Kind Regards
> >>       >      > -------------- next part --------------
> >>       >      > A non-text attachment was scrubbed...
> >>       >      > Name: image.png
> >>       >      > Type: image/png
> >>       >      > Size: 13271 bytes
> >>       >      > Desc: not available
> >>       >      > URL:
> >>       >
> >>        <
> >
> http://xenomai.org/pipermail/xenomai/attachments/20190605/8613c6ca/attachment.png
> >>
> >>       >      > -------------- next part --------------
> >>       >      > A non-text attachment was scrubbed...
> >>       >      > Name: rtt-sender.c
> >>       >      > Type: application/octet-stream
> >>       >      > Size: 9879 bytes
> >>       >      > Desc: not available
> >>       >      > URL:
> >>       >
> >>        <
> >
> http://xenomai.org/pipermail/xenomai/attachments/20190605/8613c6ca/attachment.obj
> >>
> >>       >      > -------------- next part --------------
> >>       >      > A non-text attachment was scrubbed...
> >>       >      > Name: rtt-responder.c
> >>       >      > Type: application/octet-stream
> >>       >      > Size: 5705 bytes
> >>       >      > Desc: not available
> >>       >      > URL:
> >>       >
> >>        <
> >
> http://xenomai.org/pipermail/xenomai/attachments/20190605/8613c6ca/attachment-0001.obj
> >>
> >>       >      >
> >>       >
> >>       >     --
> >>       >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >>       >     Corporate Competence Center Embedded Linux
> >>       >
> >>
> >>      --
> >>      Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >>      Corporate Competence Center Embedded Linux
> >>
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
