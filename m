From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17430.53111.874553.840320@domain.hid>
Date: Tue, 14 Mar 2006 15:13:11 +0100
Subject: Re: [Xenomai-help] the same error
In-Reply-To: <4416CC6A.8030605@domain.hid>
References: <4416CC6A.8030605@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marcellin <marcellin.fotze@domain.hid>
Cc: xenomai@xenomai.org

marcellin wrote:
 > well, I've made some little modifications, now i use the 
 > "rt_task_shadow()  function", but  from  the  "rt_intr_wait() function"  
 > the  numerical  error is  "-1".  

What does lsmod say, did you compile the native skin as a module, is the
module loaded ?
Did you try the latency program ?

 > To answer to Gilles, i use the RTC irq 
 > because i work on a (slow) acquisition system wich works continuously, 
 > and don't allow time drifts. The use of xenomai is to have tiny latencies.

Then rt_task_set_periodic()/rt_task_wait_period() is probably what
you should be using.

-- 


					    Gilles Chanteperdrix.

