Message-ID: <4701FBE2.7010309@domain.hid>
Date: Tue, 02 Oct 2007 10:05:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4701E7FE.4090406@domain.hid>
In-Reply-To: <4701E7FE.4090406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
> Hi,
> 
> I was just wondering whether any work was going on for real-time usb?
> 
> This would enable the use of PCI adaptors over USB so that PCI-IO cards 
> (like the peak-can card) can be used from laptops. CAN over USB is also 
> rather valuable.

http://developer.berlios.de/projects/usb4rt
https://gna.org/projects/usb20rt

Both projects are generally not directly usable and are currently in a 
dormant state.

> 
> Is any documentation available which clarifies why usb is a problem and 
> how big the problem is (perhaps I can risk it?:) )

No longer at hand (a former student of mine did his diploma thesis about 
usb4rt). Generally, there is no real show-stopper, we "just" need a 
real-time-aware stack that provides appropriate API (e.g. to 
preallocated required resources) and that is bug-free... :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

