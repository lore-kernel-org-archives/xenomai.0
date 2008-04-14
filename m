Message-ID: <4803073B.3060802@domain.hid>
Date: Mon, 14 Apr 2008 09:26:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4802A8F4.4090108@domain.hid>
In-Reply-To: <4802A8F4.4090108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Interrupt propagation question
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai@xenomai.org

Tomas Kalibera wrote:
> Hi,
> 
> I'm receiving interrupts in Xenomai user-domain using rt_intr_wait. What 
> is the semantics of rt_intr_enable and rt_intr_disable ? And I_NOAUTOENA ?
> 
> I used I_NOAUTOENA when calling rt_intr_create. I thought that after 
> returning from rt_intr_wait, the interrupt would be disabled before I 
> explicitly call rt_intr_enable. However, next call to rt_intr_wait 
> happily returned with the next interrupt, as opposed to blocking 
> indefinitely. Why ? Does rt_intr_wait automatically re-enable the 
> interrupt ?
> 
> I tried to intentionally loose interrupts - I called rt_intr_enable 
> while handling an interrupt intentionally before making the hardware 
> generate next one. Still, the next call to rt_intr_wait did return (the 
> interrupt was not lost). How could this happen ? If interrupts are 
> logged anyway, what the rt_intr_enable/disable does ?
> 
> I read in the API documentation
> 
> "Interrupt receipts are logged if they cannot be delivered immediately 
> to some interrupt server task, so that a call to rt_intr_wait() 
> <http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__interrupt.html#g222e6a9a681f83b13ed5b51021711f4d> 
> might return immediately if an IRQ is already pending on entry of the 
> service."
> 
> How does Xenomai find out about this ? I mean, if a "interrupt server 
> task" is not presently blocked in rt_intr_wait for a particular 
> interrupt, how does Xenomai know that a task is actually an "interrupt 
> server task" ? When does this association happen ? Does a call to 
> rt_intr_create make Xenomai log interrupts for the domain from which 
> rt_intr_create was called ?
> 

This call delivers interrupts to the Xenomai domain, only.

For the rest, have a look at ksrc/skins/native/syscall.c, __rt_intr_wait, and
__rt_intr_handler.

> Thanks !
> Tomas
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

