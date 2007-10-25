MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18208.54980.748005.291295@domain.hid>
Date: Thu, 25 Oct 2007 19:47:48 +0200
In-Reply-To: <200710251535.l9PFZYpF021256@domain.hid>
References: <200710251535.l9PFZYpF021256@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Event flag from ISR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

Patrick wrote:
 > Hi all,
 > 
 >  
 > 
 > I am using a RT event flag structure to start a task from an ISR.
 > 
 > The task waits on rt_event_wait and when the IRQ occurs the ISR executes
 > rt_event_signal (the ISR code only clears the flag and calls
 > rt_event_signal).
 > 
 > I'm using an oscilloscope to measure the length of the ISR and the first
 > occurrence lasts about 20us and all the next occurrences last about 4us.
 > 
 >  
 > 
 > My question is why the first ISR is so long?
 > 
 >  
 > 
 > For information I use xenomai 2.4 rc4 on ARM pxa270 machine with 2.6.20
 > kernel. 

Typical worst case interrupt latency on ARM is around 50 us, so 20 us is
not that long. What you are observing is probably a cache effect. In
this case, you should observe 20us after each user-space context switch
since on ARM, cache is flushed at each user-space context switch.


-- 


					    Gilles Chanteperdrix.

