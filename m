Content-Type: text/plain; charset="utf-8"
In-Reply-To: <554b3972-2cd0-d5a9-95c1-249731e8dbde@xenomai.org>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Date: Thu, 07 Nov 2019 18:03:19 +0100
MIME-Version: 1.0
Message-ID: <b80-5dc44e80-14f-62bca880@213436924>
Subject: =?utf-8?q?Re=3A?= Weird page fault while debugging an application
 using gdbserver
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Le Jeudi, Novembre 07, 2019 16:54 CET, Philippe Gerum <rpm@xenomai.org>=
 a =C3=A9crit: 
 
> On 2019-11-07 16:37, Fran=C3=A7ois Legal via Xenomai wrote:
> > Hello,
> > 
> > I'm porting an existing application to xenomai, and trying to debug=
 it using GDBserver.
> > I try to set a break to stop at some interesting point in execution=
. That break is never reached, and each time I get the page fault error=
 with the log copied at the end of the message.
> > After that, I get the debug feature of the network driver automatic=
ally activated.
> > 
> > Starngely enought, the backtrace does not point to my application c=
ode, rather in linux kernel/drivers.
> > 
> > The system is an Arm7 Zynq 7000 reference board, being debugged via=
 ethernet.
> > Running linux 4.4.189 vanilla + corresponding ipipe patch and xenom=
ai 3.0.9
> 
> You likely need the following patch. This issue was fixed in the 4.14=
 time frame:
> 
> commit 8575e8ab404717e3eabafc36920459018bb052a3
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Tue Apr 10 11:34:29 2018 +0200
> 
>     arm/ipipe: re-enable user access in DAC after und=5Fuser trap han=
dling
>     
>     Before returning from an und=5Fuser fault we have been asked to
>     propagate, the client trap handler might have demoted the caller =
from
>     the head -> root stage, which boils down to performing a (double)=

>     context switch internally. If CONFIG=5FCPU=5FSW=5FDOMAIN=5FPAN is=
 set, such
>     transition would cause the DAC register to reflect a protected US=
ER
>     domain state, denying to the kernel access to user memory.
>     
>     We need to revert this change, restoring the expected domain
>     protection settings originally set by usr=5Fentry.
>     
>     This fixes page domain errors raised by running into breakpoint t=
raps
>     poked by GDB into the debuggee's executable image when
>     CONFIG=5FCPU=5FSW=5FDOMAIN=5FPAN is enabled in the kernel configu=
ration.
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-arm=
v.S
> index cd2e0b3d8336..3569b3174372 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -524,6 +524,7 @@ =5F=5Fund=5Fusr:
>  	bl	=5F=5Fipipe=5Fnotify=5Ftrap		@ branch to trap handler
>  	cmp	r0, #0
>  	bne	ret=5Ffrom=5Fexception
> +	uaccess=5Fenable ip
>  #endif /* CONFIG=5FIPIPE */
>  
>  	mov	r2, r4
> 
> -- 
> Philippe.
 
 Thanks. I do not get the page fault anymore, however, I seem to be una=
ble to halt on breakpoints now.


