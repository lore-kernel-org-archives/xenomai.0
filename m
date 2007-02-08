Message-ID: <45CAE367.5040803@domain.hid>
Date: Thu, 08 Feb 2007 09:46:31 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45CA5AFD.9020805@domain.hid>
In-Reply-To: <45CA5AFD.9020805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Linux lock-up with rtcanrecv
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Jan,

Jan Kiszka wrote:
> Hi all,
> 
> fiddling with latest Xenomai trunk and 2.3.x on one of our robots (there
> is still a bug in trunk /wrt broken timeouts of rt_dev_read on
> xeno_16550A - different issue...), I ran into a weird behaviour of
> rtcanrecv:
> 
> I have a continuous stream of a few thousand packets/s towards the
> robot. When I start up two "rtcanrecv rtcan0 -p1000" instances (or one +
> our own receiver application), the second one causes a Linux lock-up.
> Sometimes this happens during startup of the second rtcanrecv, but at
> latest on its termination. Other RT tasks are still running. I can
> resolve the lock-up by pulling the CAN cable, everyone is fine
> afterwards and can be cleaned up. I played with quite a few combinations
> of recent ipipe patches and Xenomai revisions (even back to #1084 in
> v2.3.x), no noticeable difference.
> 
> Seems like I have to take a closer look - once time permits and the
> robot is available. So any ideas or attempts to reproduce this are
> welcome, current .config attached (no magic knob found there yet).

I will try to reporduce the problem a.s.a.p.

> Jan
> 
> 
> PS: Wolfgang, any objections against "decoupling" -v from -p and
> lowering the receiver priority to 0?

No, -v with -p looks like a bug anyway. And does it make sense to define 
an option for the task priority?

> 
> Index: src/utils/can/rtcanrecv.c
> ===================================================================
> --- src/utils/can/rtcanrecv.c	(revision 2146)
> +++ src/utils/can/rtcanrecv.c	(working copy)
> @@ -192,6 +192,7 @@ int main(int argc, char **argv)
> 
>  	case 'p':
>  	    print = strtoul(optarg, NULL, 0);
> +	    break;
> 
>  	case 'v':
>  	    verbose = 1;
> @@ -312,7 +313,7 @@ int main(int argc, char **argv)
>      }
> 
>      snprintf(name, sizeof(name), "rtcanrecv-%d", getpid());
> -    ret = rt_task_shadow(&rt_task_desc, name, 1, 0);
> +    ret = rt_task_shadow(&rt_task_desc, name, 0, 0);
>      if (ret) {
>  	fprintf(stderr, "rt_task_shadow: %s\n", strerror(-ret));
>  	goto failure;
> 

Wolfgang.

