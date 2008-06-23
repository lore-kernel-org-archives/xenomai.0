Message-ID: <485FD06A.8060805@domain.hid>
Date: Mon, 23 Jun 2008 18:33:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <485F7A69.7080004@domain.hid>	<5b5edafe752e2ab744303b0262edc05c@domain.hid>
	<485FC7F3.7020001@domain.hid>
In-Reply-To: <485FC7F3.7020001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Matthieu wrote:
> 
>> I have a segmentation fault error when I use modprobe xeno_vxworks
>> tick_arg=0 (tick_arg=1000 works)
>>
> 
> Any kernel log?
> 

wind_sysclk_init uses its argument for a division.

-- 
                                                 Gilles.

