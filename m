Message-ID: <45EC177E.403@domain.hid>
Date: Mon, 05 Mar 2007 14:13:34 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour (IRQ raise
	forever and may lock system)
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HOBsC-0004y8-Rb@domain.hid> <45EC0A19.2060708@domain.hid>
	<E1HOCcE-0008TF-Ac@domain.hid>
In-Reply-To: <E1HOCcE-0008TF-Ac@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: Xenomai-help@domain.hid

thanks.

Will rebuild the modules.

Regards,

Roland

Sebastian Smolorz wrote:
> Roland Tollenaar wrote:
>> Hi,
>>
>> Sebastian Smolorz wrote:
>>> Roland Tollenaar wrote:
>>>> IMHO it would be nice if the warning did get into the message buffer
>>>> (assuming that they cannot -easily- be expelled elsewhere) but that the
>>>> overflowing does not result in triggering non-application
>>> You mean the log printing? Simply don't set
>>> CONFIG_XENO_DRIVERS_CAN_DEBUG.
>> Aha! This sounds like something that may sort out my little problem.
>> Where do I set this parameter? I certainly did not turn it on so it must
>> be in some default configuration. Is it on compiling the kernel? Where?
>> how do I unset it?
> 
> It's in the same kernel config menu where you activated RT-Socket-CAN.
> 
> --
> Sebastian
> 

