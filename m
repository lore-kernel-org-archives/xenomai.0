Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <4AF701AC.5050702@domain.hid>
Date: Mon, 9 Nov 2009 11:45:43 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <748872BF-565F-4637-BDBC-6534B04DFA24@domain.hid>
References: <47a3101a0911070704o5307a23dhef368d04cc25fc6@domain.hid>
	<4AF59B0F.1020300@domain.hid>
	<47a3101a0911072306g42ddc0dfld0571e04fe1bf18b@domain.hid>
	<4AF6AA34.3040308@domain.hid> <4AF6E380.3010703@domain.hid>
	<47a3101a0911080922x1eda27ccja276c3f1a06e0941@domain.hid>
	<4AF701AC.5050702@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>, Linus Casassa <linus@domain.hid>

Hi Gilles,

   if aperiodic has better accuracy, what is the minimal time  
resolution one can obtain, e.g., on a x86 (I assume that asking for  
too short a wait can lead to system freezes)? Coming from the vxWorks  
philosophy, we have been running a 100000ns periodic clock (x86) to  
work with semaphores and timing statements. Seemingly, you recommend  
not to use the periodic clock. The rt_timer_ns2ticks and  
rt_timer_ticks2ns seem to return 0 if the aperiodic clock is used. Is  
this reasonable, or should they return that ticks and nanoseconds have  
the same value in this case?

   Sorry, I am just learning about this different way of using a ROS.

-Stefan


On Nov 8, 2009, at 9:36, Gilles Chanteperdrix wrote:

> Linus Casassa wrote:
>> I am using:
>> http://www.xenomai.org/documentation/xenomai-2.4/html/api/trivial-periodic_8c-example.html
>>
>> Is this the right way of doing a periodic task? But it uses aperiodic
>> behind?
>>
>> I thought that periodic has better accuracy. How can I set it?
>
> Please test with the latency test first.
>
> And aperiodic has better accuracy.
>
> -- 
> 					    Gilles.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


