Date: Sat, 23 Oct 2010 15:32:53 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4CC2E9F8.9040205@domain.hid>
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
Message-ID: <1287844373.032420306@domain.hid>
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

Assuming you mean /var/log/messages and dmesg, they say nothing about SMIs =
except what I previously wrote.=0A=0AI have managed to boot with SMI disabl=
ed in BIOS. The only trouble is I have to manually go into the BIOS bootloa=
der and select to boot from USB every time or it reports there is no bootab=
le device. It warns in the BIOS that disabling SMI will cause legacy USB bo=
ot to not work, so I presume this is the cause since my root fs is on a USB=
 attached compact flash. =0A=0AI will try now running tests with SMI disabl=
ed in the BIOS. =0A=0A=0AOn Saturday, 23 October, 2010 2:58pm, "Gilles Chan=
teperdrix" <gilles.chanteperdrix@xenomai.org> said:=0A=0A> edward.robbins@domain.hid=
xfordtechnologies.co.uk wrote:=0A>> Oh no...=0A>>=0A>> dmesg | grep SMI=0A>=
>=0A>> CPU0: Thermal monitoring handled by SMI=0A>> CPU1: Thermal monitorin=
g handled by SMI=0A>>=0A>> So I guess that didn't work? I have used the 'Gl=
obally disable SMIs option' at=0A>> kernel config time.... there is an opti=
on in  the BIOS to disable SMI but I was=0A>> having problems with it... wi=
ll investigate. Any other options?=0A> =0A> What do the boot logs say?=0A> =
=0A> --=0A>                                                                =
 Gilles.=0A> =0A


