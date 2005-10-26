Message-ID: <435FF7E3.2080408@domain.hid>
Date: Wed, 26 Oct 2005 23:40:51 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM & serial port
References: <435EFAB8.2050501@domain.hid> <435F2DDA.1030702@domain.hid>
	<435FB6CB.9030307@domain.hid> <435FBDB1.2010109@domain.hid>
	<435FC965.8040400@domain.hid> <435FCAA7.8090003@domain.hid>
	<435FE178.1040100@domain.hid> <435FECBA.20605@domain.hid>
In-Reply-To: <435FECBA.20605@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
[...]
>>API-docs -> Modules -> Real-Time Driver Model -> Device Profiles ->
>>Serial Devices ?
> 
> Hmm, that part is intended to remain implementation indepent. Will have
> to think about it.

Ok, what about a README.DRIVERS in the root-dir of the xeno tarball ?
This file could contain any information regarding RTDM drivers.

[...]
> Well, the patch containing this check is rather new. Maybe it should
> better read like this:
> 
> if (!rtdm_in_rt_context())
>     return -ENOSYS;
> 
> The result would be that the nucleus will try to switch the caller to RT
> on return and restart the call afterwards. Then you shouldn't notice any
> error. Patch in preparation...

I dunno if either solution is good. IMO, if the program is not in RT, it
should work anyway. And I'm not sure if it's good, if it ist switched sliently
to RT... *shrugs*

Thanks and best regards,
Hannes.

