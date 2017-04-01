References: <CAHz_r8DdqD_jRhr452riik5wu55hDmjOr3T4ap8r3PwAaWAPpw@mail.gmail.com>
 <CAHz_r8DUdsE7HEDWQk1mULAEw1xZ4GqgNW71ggWUHn1_ZGtfQg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f6833c8c-cbdd-2d31-fbd6-f1a4e9edbc18@xenomai.org>
Date: Sat, 1 Apr 2017 11:34:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAHz_r8DUdsE7HEDWQk1mULAEw1xZ4GqgNW71ggWUHn1_ZGtfQg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Compilation error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Benjamin Alix <alixbenjamin53@gmail.com>, xenomai@xenomai.org

On 03/31/2017 03:49 PM, Benjamin Alix wrote:
> ---------- Forwarded message ----------
> From: Benjamin Alix <alixbenjamin53@gmail.com>
> Date: 2017-03-30 17:56 GMT+02:00
> Subject: [Xenomai] Compilation error
> To: xenomai@xenomai.org
> 
> 
> Hi,
> 
> I'm compiling Xenomai 3.0.3 with a cross toolchain built with
> buildroot (based on gcc 6.3.0) and when it comes to build xenomai I
> get the following errors :
> 
> make[5]: Entering directory
> `/free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/lib/boilerplate/init'
>   CC       libbootstrap_a-bootstrap.o
>   CC       libbootstrap_pic_la-bootstrap.lo
> In file included from
> /free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/time.h:26:0,
>                  from
> /free/stagiaire/buildroot-2017.02/output/host/usr/powerpc-buildroot-linux-uclibc/sysroot/usr/include/sys/types.h:132,
>                  from bootstrap.c:18:
> /free/stagiaire/buildroot-2017.02/output/build/xenomai-3.0.3/include/cobalt/stdio.h:68:1:
> error: pasting "__cobalt_" and "(" does not give a valid preprocessing
> token

It looks like you are building Xenomai on top of a uClibc release which
is implementing fputc() and putchar() as macros, without defining the
__STDIO_PUTC_MACRO indicator (anymore). You need to find a way to
discriminate both cases, so that the right declaration block is picked
for those routines in include/cobalt/stdio.h.

-- 
Philippe.

