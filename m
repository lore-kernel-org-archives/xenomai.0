Message-ID: <45DEA9F2.4020104@domain.hid>
Date: Fri, 23 Feb 2007 09:46:42 +0100
From: =?ISO-8859-15?Q?Jan_R=FCdiger?= <ruediger@domain.hid>
MIME-Version: 1.0
References: <451C586A.7020309@domain.hid>
	<1159628606.5014.33.camel@domain.hid>	<4522A377.5030503@domain.hid>
	<45DDCC6D.6020908@domain.hid> <45DDCEE0.7070901@domain.hid>
	<45DDD478.7070403@domain.hid> <45DEA6D9.6010306@domain.hid>
In-Reply-To: <45DEA6D9.6010306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: [Xenomai-core] possible future conflict w
	LOCAL_APIC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

Hi

> 
> Do you happen to have SMP on? It takes away the choice of UP_APIC,
> because it assumes to find an APIC in any case.
> 
thx allot, SMP was enabled by default, disabling this and setting the
sub architecture from "default" to "PC-compatible" finally gives me the
choice to disable LOCAL_APIC.

> Unless you need it otherwise, CONFIG_PREEMPT is not required for good
> Xenomai latencies.
> 
> Jan
> 
> 
> PS: Please take care of CC, I re-added xenomai-help.
> 




