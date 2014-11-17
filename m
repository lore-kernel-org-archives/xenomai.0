From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 17 Nov 2014 14:12:37 -0500
Message-ID: <20141117191237.GS24110@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545D12D2.2020104@xenomai.org>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Nov 07, 2014 at 07:43:30PM +0100, Philippe Gerum wrote:
> For this particular issue, Xenomai 2.x is deadly wrong. Creating,
> deleting, enabling or disabling an IRQ channel must be done from
> secondary mode. The syscall mode bits for these native API calls are
> wrong, should be as follows instead:
> 
> diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
> index 950b092..dff7f4d 100644
> --- a/ksrc/skins/native/syscall.c
> +++ b/ksrc/skins/native/syscall.c
> @@ -4145,12 +4145,12 @@ static xnsysent_t __systab[] = {
>  	[__native_alarm_stop] = {&__rt_alarm_stop, __xn_exec_any},
>  	[__native_alarm_wait] = {&__rt_alarm_wait, __xn_exec_primary},
>  	[__native_alarm_inquire] = {&__rt_alarm_inquire, __xn_exec_any},
> -	[__native_intr_create] = {&__rt_intr_create, __xn_exec_any},
> +	[__native_intr_create] = {&__rt_intr_create, __xn_exec_lostage},
>  	[__native_intr_bind] = {&__rt_intr_bind, __xn_exec_conforming},
> -	[__native_intr_delete] = {&__rt_intr_delete, __xn_exec_any},
> +	[__native_intr_delete] = {&__rt_intr_delete, __xn_exec_lostage},
>  	[__native_intr_wait] = {&__rt_intr_wait, __xn_exec_primary},
> -	[__native_intr_enable] = {&__rt_intr_enable, __xn_exec_any},
> -	[__native_intr_disable] = {&__rt_intr_disable, __xn_exec_any},
> +	[__native_intr_enable] = {&__rt_intr_enable, __xn_exec_lostage},
> +	[__native_intr_disable] = {&__rt_intr_disable, __xn_exec_lostage},
>  	[__native_intr_inquire] = {&__rt_intr_inquire, __xn_exec_any},
>  	[__native_pipe_create] = {&__rt_pipe_create, __xn_exec_lostage},
>  	[__native_pipe_bind] = {&__rt_pipe_bind, __xn_exec_conforming},

Are you sure all 4 of those had to change?  I can see intr_create and
intr_delete, but intr_enable and disable?  We are seeing insane latency
from realtime irqs on the omap gpio irqs (a few ms response to an irq).
Of course it could be the gpio irq is just doing something wrong.
Not sure yet.  Of course before doing this change we sometimes saw it
take close to 1s to call the realtime irq handler which made no sense
at all.  gic interrupts are working as expected and see no delays that
we are aware of at least.

-- 
Len Sorensen

