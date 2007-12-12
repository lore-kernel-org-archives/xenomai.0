Message-ID: <475F9446.6070802@domain.hid>
Date: Wed, 12 Dec 2007 08:56:54 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>	<18265.47545.897637.377869@domain.hid>	<18265.50385.343346.558000@domain.hid>	<475C6454.2090002@domain.hid>	<18268.29130.406826.933528@domain.hid>	<475D5923.2050701@domain.hid>	<2ff1a98a0712100755l5c091420oe4d86ecd919992a4@domain.hid>	<475DB21C.8040800@domain.hid>	<475DB3AA.3080306@domain.hid>	<475E8EA6.1040702@domain.hid>	<2ff1a98a0712110523tb0d23f0tdfa8b3778ae634fc@domain.hid>	<475EA121.2020809@domain.hid>
	<18270.60447.548134.462197@domain.hid>
In-Reply-To: <18270.60447.548134.462197@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] How to cancel a Xenomai POSIX thread
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

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>  > Gilles Chanteperdrix wrote:
>  > > On Dec 11, 2007 2:20 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>  > >> Wolfgang Grandegger wrote:
>  > >>> The attached test application using a more sophisticated signal handling
>  > >>> works fine on my MPC5200-board running Linux 2.6.23 and Xenomai trunk.
>  > >>> Going to try it tomorrow on my PC.
>  > >> It works fine as well on my PC with Linux 2.6.23 and Xenomai trunk and
>  > >> now also with Linux 2.4.25 and Xenomai 2.3.x :-). Just to understand it
>  > >> right: The task signaled with pthread_kill() will be suspended and
>  > >> switches to secondary mode if it was running in primary mode. The signal
>  > >> will then be handled by Linux as usual. When the task resumes, does it
>  > >> get switched back to primary mode automatically?
>  > > 
>  > > No, it will get swtiched back to primary mode only if it calls a
>  > > service needing primary mode.
>  > 
>  > OK.
>  > 
>  > >> Great, the only open issue is why executing init_task() switches to
>  > >> secondary mode resulting in period overruns in high_prio_task(). Is that
>  > >> obvious to you?
>  > > 
>  > > init_task calls pthread_create, which needs running in secondary mode
>  > > to create a thread. We can not create a task without help from
>  > > secondary mode.
>  > 
>  > OK.
>  > 
>  > I was a bit quick with my assumption that it works with 2.4. It actually
>  > only works, if I have a pthread_set_mode_np() in the while loop of the
>  > primary task:
>  > 
>  >         while (1) {
>  > 		pthread_set_mode_np(0, PTHREAD_PRIMARY);
>  >                 count++;
>  >         }
>  > 
>  > Without pthread_set_mode_np(), the system hangs after the following
>  > output lines:
>  > 
>  >   bash-2.05b# ./kill_pthread2
>  >   Starting high_prio_task
>  >   low_prio_task: policy=1 prio=5
>  >   SIGUSER1 to id_low: count=17497245, overruns=0
>  > 
>  > It seems to hang when the low_prio_task() calls pthread_wait_np()
>  > thereafter. Any quick idea where the problem is?
> 
> I am clueless. Are you sure you recompiled the kernel after applying the
> patch adding the pthread_kill syscall ?

Well, I tried with v2.3.2, v2.3.x and also trunk, which does not require
the patch. Unfortunately, all versions show the same behavior.

Wolfgang.


