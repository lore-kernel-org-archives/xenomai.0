From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46B1A842.1090708@domain.hid>
References: <46B1A842.1090708@domain.hid>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 12:12:36 +0200
Message-Id: <1186049556.6611.319.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
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
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

On Thu, 2007-08-02 at 11:47 +0200, Johan Borkhuis wrote:
> I am experiencing an unexpected switch to secondary mode in a 
> rt_timer_tsc2ns call from userspace.
> 
> The following code give a switch:
>     SRTIME timeStamp;
>     timeStamp = rt_timer_tsc2ns(rt_timer_tsc());
>     while((rt_timer_tsc2ns(rt_timer_tsc()) - timeStamp) < (usecs*1000)) {}
> 
> while the following code does not:
>     RTIME timeStamp;
>     timeStamp = rt_timer_tsc();
>     while((rt_timer_tsc() - timeStamp) < (usecs*1000)) {}
> 
> (I know that the second example causes a longer timeout, but this was to 
> show the testcase).
> 
> When splitting up the 2nd line in the first example I see that the 
> rt_timer_tsc() call does not cause a switch, but the rt_timer_tsc2ns 
> does. What am I doing wrong here?
> 
> I am using Xenomai-2.3.2.
> 

- Which CPU architecture, and which Adeos patch release are you using?
- How do you notice the switches, SIGXCPU or /proc/xenomai/stat?

> Kind regards,
>     Johan Borkhuis
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



