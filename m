Message-ID: <455E1C04.1030004@domain.hid>
Date: Fri, 17 Nov 2006 21:31:00 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>	
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>	
	<455CC9DE.6030601@domain.hid>	
	<54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>	
	<455D6D3B.9000009@domain.hid>	
	<54b161f50611170041t2b8d2da1p177e9addade6a0e3@domain.hid>	
	<455D787D.9010407@domain.hid>	
	<54b161f50611170119x70b2104cma26e4ad77df8f965@domain.hid>	
	<455D7FFB.9080802@domain.hid>	
	<54b161f50611170143l10a4b91bl846991103fc39c9f@domain.hid>
	<54b161f50611170220l728e2ffaxf3dd63a259ac1cd5@domain.hid>
In-Reply-To: <54b161f50611170220l728e2ffaxf3dd63a259ac1cd5@domain.hid>
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Frits de Klark wrote:
> Hello,
> 
> Well, my first tests look very promising. Using your rtcansend and 
> rtcanrecv utilities and a cable between port 1 and port 2 on my card, 
> the messages arrive perfectly.
> 
> I'm off to do some more testing. If I run into any strange situations, 
> I'll let you know.
> 
> Thanks so far for all your help!

This already looks very good, indeed. The right thing now would be to 
integrate that into a PCI driver. Should not be that difficult.

Wolfgang.

