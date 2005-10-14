Message-ID: <434FC6EC.9080909@domain.hid>
Date: Fri, 14 Oct 2005 17:55:40 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai -> PPC
References: <22826.193.52.24.125.1129297430.squirrel@domain.hid>
In-Reply-To: <22826.193.52.24.125.1129297430.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: smannori@domain.hid
Cc: xenomai@xenomai.org

smannori@domain.hid kirjoitti:
> Hi:
> 
> waiting some hints on x86 machine, I'm playing with may PowerBook 1.67 GHz.
> The 80GB is split equally bettewen MacOS X and Mandrake (Mandriva PPC 10.2).
> 
>>From xenomai/arc/ppc/patches and www.adeos.org I see that le latest kernel
> supported is the 2.6.10. Relase that I like BUT, unfortunately, there is NOT
> support for PowerBook audio and network. I tried anyway to install xenomai.

Hmm. I don't remember what the newer PowerBooks have, but at least with 
an older titanium PowerBook all devices are supported except wireless 
LAN and that won't be supported by any more recent kernel either. AFAIK 
all G4 PowerBooks have Sun GEM as ethernet adapter which is supported by 
2.6.10. The audio probably isn't, but you can always compile the alsa 
driver separately.


-- Heikki Lindholm

