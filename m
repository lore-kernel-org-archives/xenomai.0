References: <CAJPpvEO8X-uHq7+6rzoyGQD2sYBHhesywwq-VZ4Vzrrwo=6OXw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: problem compiling EVL kernel with CONFIG_X86_UV set
In-reply-to: <CAJPpvEO8X-uHq7+6rzoyGQD2sYBHhesywwq-VZ4Vzrrwo=6OXw@mail.gmail.com>
Date: Fri, 24 Sep 2021 17:21:11 +0200
Message-ID: <8735pu0zko.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrew Tannenbaum <atannbis@gmail.com>
Cc: xenomai@xenomai.org


Andrew Tannenbaum via Xenomai <xenomai@xenomai.org> writes:

> I am just starting to work with EVL/Xenomai 4.  (I have worked with Xenom=
ai
> 2 and 3 in the past.)
> I cloned the linux-evl repo from LTS latest, my git HEAD is 105f39131e8a.
> I am compiling on (and for) an Intel i5-10400 with Ubuntu Studio 20.04
> distro installed,
> and I started with a /boot/config file that came with the distro kernel as
> the basis for my EVL Linux kernel .config.
>
> I ran into a compile error:
>
> # make modules
> arch/x86/kernel/irq_pipeline.c: In function =E2=80=98do_sysvec_inband=E2=
=80=99:
> arch/x86/kernel/irq_pipeline.c:117:3: error: implicit declaration of
> function =E2=80=98__sysvec_uv_bau_message=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
>   117 |   __sysvec_uv_bau_message(regs);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> etc.
>
> I looked in irq_pipeline.c and saw that __sysvec_uv_bau_message is
> referenced inside #ifdef CONFIG_X86_UV.
> Which is SGI Ultraviolet, a NUMA server setting that I don't need.
> CONFIG_X86_UV is turned on in the distro kernel, so my EVL config inherit=
ed
> this setting.
> I was able to compile the EVL distro patched kernel after I
> turned CONFIG_X86_UV off.
> I think I tried EVL-patched 5.10.61 and 5.14.0 and both showed a similar
> compile error.
>

Fixed, thanks.

--=20
Philippe.

