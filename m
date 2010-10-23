Date: Sat, 23 Oct 2010 14:56:45 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4CC2E86F.5060304@domain.hid>
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
Message-ID: <1287842205.0925650@domain.hid>
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

Oh no... =0A=0Admesg | grep SMI=0A=0ACPU0: Thermal monitoring handled by SM=
I=0ACPU1: Thermal monitoring handled by SMI=0A=0ASo I guess that didn't wor=
k? I have used the 'Globally disable SMIs option' at kernel config time....=
 there is an option in  the BIOS to disable SMI but I was having problems w=
ith it... will investigate. Any other options?=0A=0A=0AOn Saturday, 23 Octo=
ber, 2010 2:51pm, "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>=
 said:=0A=0A> edward.robbins@domain.hid wrote:=0A>> Argh.. ok=
ay. Something is still wrong..very wrong..and went wrong=0A>> fairly early =
in the test I think. Latencies went up to around 4500.=0A>> I've attached a=
 trace. Any clues?=0A> =0A> What is your status with SMIs ?=0A> =0A> --=0A>=
                                                                 Gilles.=0A=
> =0A


