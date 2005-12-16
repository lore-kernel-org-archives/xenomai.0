Message-ID: <43A2BB1F.1070707@domain.hid>
Date: Fri, 16 Dec 2005 14:03:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [testsuite/latency] intervals are much > than
	1	second
References: <b647ffbd0512160453w6baa9d4g@domain.hid>
In-Reply-To: <b647ffbd0512160453w6baa9d4g@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> Hello all,
> 
> I have been out of xeno-scope for a while so maybe I successufy missed 
> something important
> that might be the explanation of a problem described below.
> 
> The problem is as follows:
> 
> x86-ipipe-1.0.10 && xenomai-2.1 (CVS: ~ November, 21)
> 
> testsuite/letency is used as it is by defaulty (nsamples = 1 billion (1 
> second) / sample (e.g.100000 us))
> 
> I am used to getting data with ~1-second-interval on the screen when 
> "latency" is running and so expected to observe the same behaviour now.
> 
> Nevertheless, the interval (with all parameters by default) is ~ 4 
> seconds, and it gets up to 16-17 seconds when -p 1000 (sampling period 
> == 1 ms.) is used.
> 
> e.g. it took 1 minute and 30 seconds to get 21 lines of statistics on 
> the screen (-p 100) but should have been ~22-23 seconds.
> 
> And the latency thread really reported the presence of collected data 21 
> times (through rt_sem_v()) .
> 
> So have I missed something important? any ideas are wellcome.
>

Dunno yet, but this reminds me of a trap I've been into recently that 
caused a massive slowdown of the latency test (v2.0.x) whilst the 
reported real-time activity seemed to be ok. Weird enough, actually. The 
explanation was that I mistakenly left the full ACPI support and SUSPEND 
active in my kernel config (Asus box with ICH6 chipset). Shutting them 
down solved the issue. I've not investigated further which one of the 
ACPI options or SUSPEND caused that trouble yet.

> -- 
> Best regards,
> Dmitry Adamushko
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

