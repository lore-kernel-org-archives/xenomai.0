Message-ID: <4463C090.8050309@domain.hid>
Date: Fri, 12 May 2006 00:54:08 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Errors running sim testsuite for vxWorks
References: <200605111823.51650.niklaus.giger@domain.hid>	<17507.27519.455277.534105@domain.hid>	<200605111956.57892.niklaus.giger@domain.hid>
	<17507.39938.328795.132737@domain.hid>
In-Reply-To: <17507.39938.328795.132737@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Niklaus Giger wrote:
>  > Do you have any ideas? Thanks in advance.
> 
> No idea, the x86 version does not seem to have the same problem, but
> valgrind give many errors.
> 

Valgrind chokes on the co-routine switching code, which is fair enough, 
since it's quite hard for it to track stack context changes the way 
setcontext/getcontext do it.

However, like for the previous stack size issue with satch.c, I wonder 
if the fixed-size stacks allocated by the simulator for its threads are 
not overflowed.

-- 

Philippe.

