Message-ID: <1457983382.28082.11.camel@henry-ThinkCentre-M93p>
From: Henry Bausley <hbausley@deltatau.com>
Date: Mon, 14 Mar 2016 12:23:02 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Reentrant Interrupts on Freescale LS1021A
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


For many years we have had a reentrant interrupt routine that has run on
our single core AMCC460EX for ~7-8yrs.  We received instructions on how
to do this many years ago.  See the link below


https://www.mail-archive.com/search?l=xenomai-help@gna.org&q=subject:%
22Re%5C%3A+%5C%5BXenomai%5C-help%5C%5D+Recurring+Interrupts%
22&o=newest&f=1

We have now changed to a Freescale dual core LS1021A ARM CPU.  It now
hangs on the LS1021A ARM.  Is there anyway we can support reentrant
interrupts on the LS1021A design?

We currently do this as we were instructed:

int your_isr(xnintr_t *intr)
{
unsigned long flags;

xnlock_clear_irqon(nklock);

... your code ...

xnlock_get_irqsave(nklock, flags); /* must re-lock on exit */
}

We are using xenomai-2.6.4 w/ linux 3.14.28

Any help would be greatly appreciated.

Thanks 


Henry




Outbound scan for Spam or Virus by Barracuda at Delta Tau


