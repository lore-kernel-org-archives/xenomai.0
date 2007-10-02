Message-ID: <470202BA.4070206@domain.hid>
Date: Tue, 02 Oct 2007 10:35:06 +0200
MIME-Version: 1.0
References: <4701E7FE.4090406@domain.hid> <4701FBE2.7010309@domain.hid>
In-Reply-To: <4701FBE2.7010309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] rt usb
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
Cc: Xenomai-help@domain.hid

Hi Jan,

>> Is any documentation available which clarifies why usb is a problem 
>> and how big the problem is (perhaps I can risk it?:) )
> 
> No longer at hand (a former student of mine did his diploma thesis about 
> usb4rt). 
Pity.

>Generally, there is no real show-stopper, we "just" need a 
> real-time-aware stack that provides appropriate API (e.g. to 

So, if I run CAN over USB from a rt thread there is a chance that even 
though it is not rt-safe, it may not screw up latency?

I realize that this will seem pointless and is technically incorrect but 
  if for example the USB device is not addressed by any other processes, 
what is the chance that I will have problems?

Regards,

Roland





> 
> Jan
> 

