Message-ID: <3E632806.2080300@domain.hid>
Date: Mon, 03 Mar 2003 11:01:42 +0100
From: Juan Antonio Garcia <juan-antonio.garcia@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] rtai-24.1.11-pre3 plus ADEOS
List-Id: <adeos-main.nongnu.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rtai@domain.hid
Cc: adeos-main@gna.org

Sorry by the noise, in the previous message the priority relationships 
were bad showed.

My test have a periodic task(T1 with 1 ms period), an sporadic task(T2)
and an interrupt handler. The periodic task, in each period, set a bit
over the parallel port, this write activates the correspondent
interrupt. The interrupt handler uses a semaphore to signal this event
to the sporadic task which reset the bit


First Test:
       linux-2.4.19, rtai 2.4.11-pre3 with ADEOS patch, newlxrt
scheduler,  T1 priority >= T2 priority
       User Land(newlxrt) : OK
       Kernel Land: OK

Second Test::
     Same as above but the T1 priority < T2 priority, so the signal in the
interrupt handler results in T2 execution before exit from the interrupt
handler.
     User Land(newlxrt): KO The system freeze.
     Kernel Land: OK

Both tests go fine with the rthal patch.

Regards,
     Juan Antonio








