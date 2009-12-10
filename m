Message-ID: <4B20F933.60703@domain.hid>
Date: Thu, 10 Dec 2009 14:35:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EA8B423DB69FD24FA233008019A052AE016689FC@zue-s-15.zue.zwick.de>
	<4B20D066.5070904@domain.hid>
	<EA8B423DB69FD24FA233008019A052AE01668DD6@domain.hid>
In-Reply-To: <EA8B423DB69FD24FA233008019A052AE01668DD6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with gettimeofday
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Soboljew, Patrick" <Patrick.Soboljew@domain.hid>
Cc: xenomai@xenomai.org

Soboljew, Patrick wrote:
>>> Anybody an idea?
>> You should be using clock_gettime(CLOCK_REALTIME). In case you
>> insist on using gettimeofday, see:
>> 
>> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Timing_services.
> 
> It's not me who insists on that call but this framework :). But
> thanks for your help. The solution thats provided with the link would
> help I think. I was also interested what things can cause the
> difference between both functions on real hardware and in the vmware
> image e.g. kernel config parameters.

Xenomai keeps synchronized with Linux, if Linux uses the same
clocksource as xenomai i.e. the tsc, if it does not update the wallclock
time after the boot, and if it does not use NTP.

-- 
                                          Gilles


