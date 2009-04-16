Message-ID: <49E73DE7.9020307@domain.hid>
Date: Thu, 16 Apr 2009 16:17:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <37f89760904160447j7399b4ctced93a3e4956db6a@domain.hid>	
	<49E72BA8.20203@domain.hid>
	<37f89760904160654g43fde4f0l6cd228faa65d6baf@domain.hid>
In-Reply-To: <37f89760904160654g43fde4f0l6cd228faa65d6baf@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] driver: IOCTL command behavior
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Marcel Soulot wrote:
> Hi,
> sorry, i don't realise that my description is a bit fuzzy.
> 
> Here I define two IOCTL command:
> 
> #define RT_GPIO_RTIOC_GET_DIRECTION\
>     _IOR(RTIOC_TYPE_GPIO, 0x01, int)
> 
> #define RT_GPIO_RTIOC_SET_DIRECTION\
>     _IOR(RTIOC_TYPE_GPIO, 0x02, int)
> 
> the commands (both) works fine. For the command
> RT_GPIO_RTIOC_SET_DIRECTION,I try to switch _IOR() to _IOW() according
> the driver "xeno_16550A" (in the
> file /usr/xenomai/include/rtdm/rtserial.h)
> 
> #define RTSER_RTIOC_GET_CONFIG    \
>     _IOR(RTIOC_TYPE_SERIAL, 0x00, struct rtser_config)
> 
> #define RTSER_RTIOC_SET_CONFIG    \
>     _IOW(RTIOC_TYPE_SERIAL, 0x01, struct rtser_config)
> 
> But when I define :
> 
> #define RT_GPIO_RTIOC_SET_DIRECTION\
>     _IOW(RTIOC_TYPE_GPIO, 0x02, int)
> 
> or
> 
> #define RT_GPIO_RTIOC_SET_DIRECTION\
>     _IOWR(RTIOC_TYPE_GPIO, 0x02, int)
> 
> the call of "rt_dev_ioctl(my_fd,RT_GPIO_RTIOC_SET_DIRECTION,0xFF)" returns
> me the error  "-ENOTTY".
> Which means that the command RT_GPIO_RTIOC_SET_DIRECTION is not recognized
> and I drop in default error.
> 
> Hope my explanation is better,

No, please send us enough code for us to reproduce the issue.

Please do not drop the mailing list from the discussion.

-- 
                                                 Gilles.

