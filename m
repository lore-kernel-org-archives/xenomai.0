From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6A893E.9000907@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6A8194.80008@domain.hid> <1282048491.5255.92.camel@domain.hid>
	<4C6A8332.5050308@domain.hid>
	<1282049663.5255.99.camel@domain.hid>
	<4C6A893E.9000907@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 17 Aug 2010 15:19:17 +0200
Message-Id: <1282051157.5255.108.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Tue, 2010-08-17 at 15:06 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> > On Tue, 2010-08-17 at 14:40 +0200, Gilles Chanteperdrix wrote:
> >> No. As witnessed by the message:
> >> ./xeno-shmem-fork: relocation error: ./xeno-shmem-fork: symbol getpid,
> >> version GLIBC_2.0 not defined in file libc.so.6 with link time reference
> > 
> > 
> > have you seen that main process started  ? and linker didn't complain
> > about wrong symbol version. This happened only in child process after
> > line 88, have you seen output from line 89 ?
> > 
> > furthermore you can find commented out line in makefile which compiles
> > userland without linking with xenomai libraries. 
> > 
> > this executable works as expected.
> 
> As I said since we went from libc5 to libc6, all libcs have been
> backward ABI compatible. So, it makes perfect sense that the binary works.
> 
> Since you are calling getpid() after fork, it is normal that the error
> is not signalled before, symbols are only resolved at run-time, when
> they are use.

indeed so i think you should ask yourself how it was possible that main
process could resolve it but child couldn't.

> 
> > these libcs are same and i wonder whats wrong with you. 
> > How many times do i need to make you sure that these libcs are binary
> > same ?
> 
> As long as you are comparing the wrong binaries. What I ask you to
> compare is libc.so.6 with the result of gcc -print-file-name=libc.so
> gcc being the exact compiler use for compilation of the test program.
> 
> If these libraries are the same, then I will look at your test program,
> otherwise I will not waste more time on this issue.

so at the box i compile code gcc gives:
CHroot linux-e9um:/lib # gcc -print-file-name=libc.so
/usr/lib/gcc/i586-suse-linux/4.3/../../../libc.so


and i do not have gcc installed at target box (atest). i also double
checked if there could be "libc.so" file in whole rootfs which is abt
258M long and i did not found it.

also /usr/lib/gcc/i586-suse-linux/4.3/../../../libc.so
ie /usr/lib/libc.so is just a linker script of 238 bytes.

ld-linux.so.2 are binary same on these two boxes too.


> 


-- 
Krzysztof Blaszkowski


