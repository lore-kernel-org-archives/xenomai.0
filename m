Message-ID: <43E0BEC1.2060400@domain.hid>
Date: Wed, 01 Feb 2006 14:59:29 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>
In-Reply-To: <b647ffbd0601311053s2f9f77c3m@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Are XN_ISR_CHAINED and XN_ISR_ENABLE mutually
	exclusive?
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

While looking into how to implement sharing of interrupts between realtime and 
non-realtime domains (and applying Wolfgang Grandegger's patch 
[https://mail.gna.org/public/xenomai-core/2006-01/msg00233.html], which is 
necessary to make XN_ISR_ENABLE work at all on the PowerPC platform), I'm 
beginning to think that XN_ISR_CHAINED and XN_ISR_ENABLE are mutually exclusive, 
since if both are set, desc->handler->end will be called twice:

   1. When the realtime isr handler returns
   2. When the Linux domain calls it in __do_IRQ

In the solution I have in mind at the moment, I will:

   1. Add an extra iend handler argument to xnintr_init
   2. If XN_ISR_ENABLE is returned from the isr handler,
      replace desc->handler->end with the user supplied
      iend handler.

Hereby I hope to be able to handle interrupts shared between realtime and 
non-realtime domain, without having the realtime domain wait for all 
non-realtime interrupts to finish. This is the scenario I'm thinking of:

   1. A non-RT interrupt occurs
   2. The (RT) isr handler detects the non-RT interrupt,
      disables further non-RT interrupts on that irq-vector, replaces
      desc->handler->end with the user supplied iend handler,
      returns XN_ISR_CHAINED | XN_ISR_ENABLE.
   3. RT interrupts are serviced by the (RT) isr handler,
      returns XN_ISR_ENABLE
   4. The Linux domain get a chance to run the chained interrupt,
      and eventually calls desc->handler->end (supplied iend handler)
   5. The iend handler reenables non-RT interrupts.

Comments on the above are most welcome!

-- 

Anders Blomdell

