From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15971.5493.382489.89745@domain.hid>
Date: Mon, 3 Mar 2003 09:42:29 +0100
In-Reply-To: <3E630431.1080301@domain.hid>
References: <3E630431.1080301@domain.hid>
Subject: [Adeos-main] Re: rtai-24.1.11-pre3 plus ADEOS
Reply-To: philippe.gerum@domain.hid
List-Id: <adeos-main.nongnu.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Juan Antonio Garcia <juan-antonio.garcia@domain.hid>
Cc: adeos-main@gna.org, rtai@domain.hid


Hi,

Juan Antonio Garcia wrote:
 > Hi all.
 > 
 > I've been testing a bit the 2.4.11-pre3 plus the ADEOS patch. I've found 
 > the following behaviour:
 > 
 > My test have a periodic task(T1 with 1 ms period), an sporadic task(T2) 
 > and an interrupt handler. The periodic task, in each period, set a bit  
 > over the parallel port, this write activates the correspondent 
 > interrupt. The interrupt handler uses a semaphore to signal this event 
 > to the sporadic task which reset the bit
 > 
 > 
 > First Test:
 >       linux-2.4.19, rtai 2.4.11-pre3 with ADEOS patch, newlxrt 
 > scheduler, T1 priority <= T2 priority
 >       User Land(newlxrt) : OK
 >       Kernel Land: OK
 > 
 > Second Test::
 >     Same as above but the T1 priority >T2 priority, so the signal in the 
 > interrupt handler results in T2 execution before exit from the interrupt 
 > handler.
 >     User Land(newlxrt): KO The system freeze.
 >     Kernel Land: OK
 > 
 > Both tests go fine with the rthal patch.

Ok. I'll try to reproduce this bug asap and let you know. Thanks for
helping.

Philippe.


