Subject: Re: [Xenomai-help] Interrupt shield
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1163712755.4980.16.camel@domain.hid>
References: <E1Gke0B-0003BT-CA@mailer.emlix.com>
	<1163712755.4980.16.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 12:21:08 +0100
Message-Id: <1163762469.4980.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-11-16 at 22:32 +0100, Philippe Gerum wrote:
> On Thu, 2006-11-16 at 10:57 +0100, Sebastian Smolorz wrote:
> > Hello,
> > 
> > can anybody confirm this behaviour? If I configure the I-shield into the 
> > kernel and start the latency test the RT tasks have not activated T_SHIELD 
> > although the documentation states it (and btw in rt_task_create this bit is 
> > set).
> 
> The documentation of rt_task_create() is wrong. The default behaviour
> should be to create tasks with disabled I-shield support.
> 
> >  If I try to set T_SHIELD inside the display task, the system hangs, a 
> > soft lockup appears and sometimes a few correct lines of the display task are 
> > printed, followed by the next lockup.
> 
> Confirmed here (on x86).
> 
> > 
> > Explainable?
> > 
> 
> Yes. I must have screwed up something somewhere, many moons ago.
> 

Yes I did. This patch should fix the issue on your setup too.

--- ksrc/nucleus/shadow.c	(revision 1838)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -554,6 +554,9 @@
 #ifndef CONFIG_XENO_OPT_RPIDISABLE
 			xnpod_renice_root(XNPOD_ROOT_PRIO_BASE);
 #endif /* CONFIG_XENO_OPT_RPIDISABLE */
+#ifdef CONFIG_XENO_OPT_ISHIELD
+			disengage_irq_shield();
+#endif /* CONFIG_XENO_OPT_ISHIELD */
 			xnpod_schedule();
 		}
 
-- 
Philippe.



