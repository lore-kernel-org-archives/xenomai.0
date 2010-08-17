From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6A8194.80008@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6A8194.80008@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 17 Aug 2010 14:35:49 +0200
Message-Id: <1282048549.5255.93.camel@domain.hid>
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
Cc: xenomai@xenomai.org

On Tue, 2010-08-17 at 14:33 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> > Hello,
> > 
> > I found recently that large application uses to segfault before fork()
> > leaves its glibc wrapper.
> > 
> > I included here a test suite which can be easily used to verify what
> > goes wrong. It may be necessary to adjust makefile to compile the code.
> > So, the console is missing output from line #89. We can see instead a
> > message that getpid couldn't be linked which is 1st sign of memory
> > corruption.
> > 
> > i used to think that this issue could be related to not unbinding heap
> > before fork() but it turned out that it is enough to link userspace with
> > xenomai libraries.
> > 
> > I wonder if this is known issue and if there is any fix, does 2.5.4 work
> > same ? or maybe there is something wrong with the kernel i use (or adeos
> > patch)
> > 
> > Another question is why rt_task_create() is marked deprecated in native
> > skin. Does it mean that native skin is going to be removed from source
> > tree ?
> 
> The libc on the system you run the test is not the same as the one of
> the compiler. Please re-run the test when using the same libc on the
> test board as on the machine where you are compiling.
> 

these rootfs'es are equal regarding libc at least of course.

> 


-- 
Krzysztof Blaszkowski


