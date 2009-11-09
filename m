Message-ID: <4AF88A77.4030902@domain.hid>
Date: Mon, 09 Nov 2009 22:32:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <47a3101a0911070704o5307a23dhef368d04cc25fc6@domain.hid>
	<4AF59B0F.1020300@domain.hid>
	<47a3101a0911072306g42ddc0dfld0571e04fe1bf18b@domain.hid>
	<4AF6AA34.3040308@domain.hid> <4AF6E380.3010703@domain.hid>
	<47a3101a0911080922x1eda27ccja276c3f1a06e0941@domain.hid>
	<4AF701AC.5050702@domain.hid>
	<748872BF-565F-4637-BDBC-6534B04DFA24@domain.hid>
In-Reply-To: <748872BF-565F-4637-BDBC-6534B04DFA24@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Gumstix arm pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Linus Casassa <linus@domain.hid>

Stefan Schaal wrote:
> Hi Gilles,
> 
>    if aperiodic has better accuracy, what is the minimal time  
> resolution one can obtain, e.g., on a x86 (I assume that asking for  
> too short a wait can lead to system freezes)? Coming from the vxWorks  

The sleep time resolution is bound to the frequency of the hardware
timer used. I do not know x86 details that much, but I seem to remember
that the 8254 timer, the worst one, has a frequency around 1 MHz, which
gives you a resolution of 1us, enough for most uses I believe.

> philosophy, we have been running a 100000ns periodic clock (x86) to  
> work with semaphores and timing statements. Seemingly, you recommend  
> not to use the periodic clock. The rt_timer_ns2ticks and  
> rt_timer_ticks2ns seem to return 0 if the aperiodic clock is used. Is  
> this reasonable, or should they return that ticks and nanoseconds have  
> the same value in this case?
> 
>    Sorry, I am just learning about this different way of using a ROS.

either your system is misconfigured (if you have a periodic timer, any
time duration smaller than the timer period will give you a duration of
0 ticks, results are rounded toward 0), or there is a bug somewhere.

cat /proc/xenomai/timebases will tell you.

What xenomai version are you using exactly ?

-- 
					    Gilles.

