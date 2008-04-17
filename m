Message-ID: <48072EB1.1070102@domain.hid>
Date: Thu, 17 Apr 2008 13:04:17 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <d6c8ef150804170346t4537b9dehf448cd6c9d0debb5@domain.hid>
In-Reply-To: <d6c8ef150804170346t4537b9dehf448cd6c9d0debb5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Bosko Radivojevic wrote:
> What could be the reason of rt_dev_open() returning 0 (zero)?
> 
> I can see that device is properly registered. When I start user-space
> program, I can see in /proc/xenomai/rtdm/filedes that one file is
> open:
> Index   Locked  Device          Owner [PID]
> 0       0       macbdev0        user [306]
> 
> But I never reach write function. rt_dev_write() & rt_dev_read() are
> returning -1.

Which read and write handlers do you have registered with your device 
(RT/NRT)? From which context do you call the RTDM functions 
(primary/secondary)?

  In API documentation, for rt_dev_open return values
> says:
> Positive file descriptor value on success, otherwise a negative error code.

I think this is a bug in the documentation. Negative values mean errors, 
all other values (including zero) success.

-- 
Sebastian

