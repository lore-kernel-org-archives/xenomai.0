From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <18157.27836.667782.514635@domain.hid>
References: <200709071127.17913.peter.soetens@domain.hid>
	<1189882379.25006.181.camel@domain.hid>
	<18157.27836.667782.514635@domain.hid>
Content-Type: text/plain
Date: Sun, 16 Sep 2007 21:31:27 +0200
Message-Id: <1189971087.25006.210.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [FIX] Summary: Xenomai 2.3.2 and 2.4
	lock-ups	and OOPSes
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2007-09-16 at 19:49 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > 
>  > Please try this patch against v2.3.x. A double free issue on a task TCB
>  > already scheduled for memory release was causing all sorts of troubles,
>  > basically trashing the system heap afterwards:
> 
> Is not there anything similar needed for the posix skin ?
> 

pthread_create() does allocate the TCB itself, and properly releases it
upon error while creating the thread, so the syscall wrapper does not
have to free any TCB memory by itself, which is a prerequisite to enter
the double release situation. There is no possibility to run the
deletion hook indirectly on behalf of pthread_create() either, so I
think it's safe.

-- 
Philippe.



