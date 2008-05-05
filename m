Message-ID: <2ff1a98a0805050933p380f8c8fod5a8dacc42c694da@domain.hid>
Date: Mon, 5 May 2008 18:33:33 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <18459.38644.699369.801548@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
	<18459.38644.699369.801548@domain.hid>
Subject: Re: [Xenomai-core] [Patch 4/7] Define ARM atomic operations in
	user-space
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On Sat, May 3, 2008 at 12:34 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
>  The include/asm-arm/atomic.h header now defines the xnarch_memory_barrier in
>  addition to user-space atomic operations. The pxa3xx deserves a special
>  treatment since it uses the ARMv6 memory barrier operation whereas being an
>  ARMv5 for other operations, hence a special --enable-arm-mach=pxa3xx option in
>  configure.in.

After a quick look at all architectures xenomai supports, it seems
that we can implement atomic_cmpxchg for most of them in user-space.
The only one for which I have a doubt is blackfin. Since linux for
blackfin is uclinux, can we call cli/sti from user-space ?

-- 
 Gilles

