Message-ID: <47234083.4000602@domain.hid>
Date: Sat, 27 Oct 2007 15:43:31 +0200
MIME-Version: 1.0
References: <e4ef24880710261838l4d1961a5s8117d116be499cee@domain.hid>	<e4ef24880710262040r718b58f7xa2e5f89156d9024b@domain.hid>	<e4ef24880710262126g658f3f7ci534ca13df32b2e0e@domain.hid>
	<4723118D.9060807@domain.hid> <472326E6.9080103@domain.hid>
	<47232A0C.60705@domain.hid>
In-Reply-To: <47232A0C.60705@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] RTNet in non-TDMA mode?
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

>> between RTdevices and non-RT devices crash the system? And whether I
>> understand correctly that later versions (2.4 up?) of xenomai do not
>> have the problem of the freezing system at least.?
> 
> Since Xenomai 2.3, actually, no system is supposed to "crash" anymore
> when IRQ conflicts between the domains arise. But if you loose, e.g.,
> your USB keyboard or your serial console or whatever input device due to
> a conflict, you may get the impression of a crash. However, if anyone
> suspects that something else happens on his system, please report the
> findings to the Xenomai mailing list!

The systems I have found to "crash" all used PS/2 input device and 
normal VGA monitor. Generally a freeze is initiated by some grafical 
action in X after starting rtnet. dmesg will tell me that there is a 
shared IRQ, and in some cases it will disable it. In the latter case the 
system does not freeze but I still have to find another IRQ address. 
When there is a shared interrupt then there might be a freeze. If it 
does not freeze immediately it never freezes and the shared IRQ is no 
problem. For a while I thought there was only a problem with the VGA 
device and the rtnet card so if I kept those two off the same IRQ there 
would be no problem. On other machines this theory was brutally smashed.
Sorry I cannot be more specific here since all problems in the end are 
"solved".

Hmm, I am just considering that since I use live linux it may be that 
the conflict was between the rtnet card and a USBport that gives access 
to the usbstick(s).

But my question remains -purely out of interest- why non-rt devices and 
rt devices can _fundamentally_ not share an IRQ?

kind

regards,

Roland.



> 
> Jan
> 

