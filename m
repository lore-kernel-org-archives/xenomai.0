MIME-Version: 1.0
From: Andrew Tannenbaum <atannbis@gmail.com>
Date: Wed, 22 Sep 2021 14:30:44 -0400
Message-ID: <CAJPpvEO8X-uHq7+6rzoyGQD2sYBHhesywwq-VZ4Vzrrwo=6OXw@mail.gmail.com>
Subject: problem compiling EVL kernel with CONFIG_X86_UV set
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am just starting to work with EVL/Xenomai 4.  (I have worked with Xenomai
2 and 3 in the past.)
I cloned the linux-evl repo from LTS latest, my git HEAD is 105f39131e8a.
I am compiling on (and for) an Intel i5-10400 with Ubuntu Studio 20.04
distro installed,
and I started with a /boot/config file that came with the distro kernel as
the basis for my EVL Linux kernel .config.

I ran into a compile error:

# make modules
arch/x86/kernel/irq_pipeline.c: In function =E2=80=98do_sysvec_inband=E2=80=
=99:
arch/x86/kernel/irq_pipeline.c:117:3: error: implicit declaration of
function =E2=80=98__sysvec_uv_bau_message=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
  117 |   __sysvec_uv_bau_message(regs);
      |   ^~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
etc.

I looked in irq_pipeline.c and saw that __sysvec_uv_bau_message is
referenced inside #ifdef CONFIG_X86_UV.
Which is SGI Ultraviolet, a NUMA server setting that I don't need.
CONFIG_X86_UV is turned on in the distro kernel, so my EVL config inherited
this setting.
I was able to compile the EVL distro patched kernel after I
turned CONFIG_X86_UV off.
I think I tried EVL-patched 5.10.61 and 5.14.0 and both showed a similar
compile error.

-Andy
