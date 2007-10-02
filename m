Message-ID: <470207F8.1010309@domain.hid>
Date: Tue, 02 Oct 2007 10:57:28 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4701E7FE.4090406@domain.hid> <4701FBE2.7010309@domain.hid>
In-Reply-To: <4701FBE2.7010309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt usb
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

Jan Kiszka wrote:
> Roland Tollenaar wrote:
>> Hi,
>>
>> I was just wondering whether any work was going on for real-time usb?
>>
>> This would enable the use of PCI adaptors over USB so that PCI-IO cards 
>> (like the peak-can card) can be used from laptops. CAN over USB is also 
>> rather valuable.
> 
> http://developer.berlios.de/projects/usb4rt
> https://gna.org/projects/usb20rt
> 
> Both projects are generally not directly usable and are currently in a 
> dormant state.
> 
>> Is any documentation available which clarifies why usb is a problem and 
>> how big the problem is (perhaps I can risk it?:) )
> 
> No longer at hand (a former student of mine did his diploma thesis about 
> usb4rt). Generally, there is no real show-stopper, we "just" need a 
> real-time-aware stack that provides appropriate API (e.g. to 
> preallocated required resources) and that is bug-free... :)
One problem with USB is the inherent 1ms(full speed)/125us(high speed) cycles,
which (AFAICT) prohibits closing a control loop any faster than that. On top of
that at least some USB I/O-cards (somewhat off-topic, since post was about CAN
over USB) tend to pack multiple values into one USB-packet, which leads to
larger delays.

I would investigate Ethernet-CAN gateways, perhaps brew my own using
http://www.hitex.com/str9-comstick/

/Anders


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

