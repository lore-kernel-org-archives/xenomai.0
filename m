Message-ID: <4991B7AC.60901@domain.hid>
Date: Tue, 10 Feb 2009 17:21:48 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1LWvjc-0006Xw-FB@mailer.emlix.com> <4991AF95.1030301@domain.hid>
	<E1LWwFb-000754-FT@mailer.emlix.com>
In-Reply-To: <E1LWwFb-000754-FT@mailer.emlix.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] strange latency output (xenomai-2.4.5)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Georg Gottleuber <gg@domain.hid>
Cc: xenomai@xenomai.org

Georg Gottleuber wrote:
> 
> Gilles Chanteperdrix schrieb:
>> Georg Gottleuber wrote:
>>> Hi,
>>>
>>> I recently port a  ARM926EJ-S mach to Xenomai
>>> (like described in http://www.xenomai.org/index.php/I-pipe:ArmPorting).
>>>
>>> While testing with latency I got this output:
>>> # /usr/xenomai/bin/latency  -p 1000 -h -s -H 500 -t 1
>>> == Sampling period: 1000 us
>>> == Test mode: in-kernel periodic task
>>> == All results in microseconds
>>> warming up...
>>> RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
>>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
>>> RTD|      78.992|     104.308|     124.131|       0|      78.992|     124.131
>>> ...
>>> RTD|      14.678|      68.413|      96.275|       0|       9.528|     155.321
>>> RTD|      84.046|     116.435|     175.192|       0|       9.528|     182.139
>>> ...                                ^^^^^^^                            ^^^^^^^
>> I do not understand, what is wrong with these values ?
> 
> It thought, if "lat max" of the current interval is bigger than "lat worst", this "lat
> max" updates the "lat worst". So I ask myself, out of which interval comes the updated 182
> value?

Ok. Got it.

What type of floats are you compiling with ?

-- 
                                                 Gilles.

