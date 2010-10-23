Date: Sat, 23 Oct 2010 15:48:23 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4CC2F334.4060804@domain.hid>
References: <1281709057.650414331@domain.hid>
	<4C65583D.3030800@domain.hid> 
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid> 
	<1283531433.789315367@domain.hid>         
	<1283590285.1709.2153.camel@domain.hid>        
	<1287134519.029617765@domain.hid>       
	<1287143691.028416668@domain.hid> <4CB85C64.9040307@domain.hid> 
	<1287496324.10921156@domain.hid> <4CBDF92F.20403@domain.hid>     
	<1287832106.517512323@domain.hid> <4CC2C361.5020608@domain.hid> 
	<1287832939.719617755@domain.hid> <4CC2C8AB.70708@domain.hid>   
	<1287841513.64613295@domain.hid> <4CC2E86F.5060304@domain.hid>  
	<1287842205.0925650@domain.hid> <4CC2E9F8.9040205@domain.hid> 
	<1287844373.032420306@domain.hid> <4CC2F334.4060804@domain.hid>
Message-ID: <1287845303.420222171@domain.hid>
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Yeah, sorry, was just dealing with one message at a time... see the next on=
e.=0A=0AWell, maybe it is something strange with my BIOS... it does explici=
tly say I wont be able to do "legacy usb boot". But then it works anyway if=
 I go into the bios 'boot manager'. I will try playing with the boot order =
settings.=0A=0A=0AOn Saturday, 23 October, 2010 3:37pm, "Gilles Chanteperdr=
ix" <gilles.chanteperdrix@xenomai.org> said:=0A=0A> edward.robbins@domain.hid=
chnologies.co.uk wrote:=0A>> Assuming you mean /var/log/messages and dmesg,=
 they say nothing about=0A>> SMIs except what I previously wrote.=0A> =0A> =
Then it means, as I tried to explain in the link I posted, that Xenomai=0A>=
 SMI workaround code does not support your chipset. But adding it should=0A=
> be really easy.=0A> =0A> And yes, legacy usb is based on SMIs. But as far=
 as I know, it is=0A> something for keyboards and mice (emulating PS/2 peri=
pherals using USB=0A> peripherals). It should not prevent you from booting =
from an USB key.=0A> =0A> --=0A>                                           =
                      Gilles.=0A> =0A


