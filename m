Message-ID: <45E7E67A.6050201@domain.hid>
Date: Fri, 02 Mar 2007 09:55:22 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
	<45E7E31B.1090102@domain.hid>
In-Reply-To: <45E7E31B.1090102@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,

>> FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No such
>> device
>>
> 
> Maybe a conflict with parport_pc.

Is there any way I can confirm this suspicion of yours? Can it be solved 
by disabling parallel port support in the kernel? (humbly assuming this 
would not install the parport layer in the first place).


> Wolfgang, do we always have to remove that module, or is there a chance
> to cooperate with it without loosing real-time? When removing the Linux
> parport layer, there is the risk that the port is powered off (see
> irqbench), 
What am I looking for?



Regards,

Roland.

and xeno_can_peak_dng does not account for this yet.
> 
> Jan
> 

