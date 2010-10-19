Date: Tue, 19 Oct 2010 14:52:04 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4CB85C64.9040307@domain.hid>
References: <1281709057.650414331@domain.hid>
	<4C65583D.3030800@domain.hid> 
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid> 
	<1283531433.789315367@domain.hid>   
	<1283590285.1709.2153.camel@domain.hid>  
	<1287134519.029617765@domain.hid> 
	<1287143691.028416668@domain.hid> <4CB85C64.9040307@domain.hid>
Message-ID: <1287496324.10921156@domain.hid>
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

Having disabled MTRR (and leaving in Phillipes patch) I am not getting unre=
asonable latencies unless I enable graphics acceleration. Can I be sure thi=
s has solved the issue?=0A=0AEdward=0A=0AOn Friday, 15 October, 2010 2:51pm=
, "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> said:=0A=0A> ed=
ward.robbins@domain.hid wrote:=0A>> I am also finding that ta=
sks are frequently hanging, causing=0A>> ipipetraces with "INFO: task xxx:x=
xx blocked for more than 120=0A>> seconds". Ihave just had this with apt-ge=
t update, and was previously=0A>> getting itwith grub-install. Could this b=
e related?=0A> =0A> Yes. There is obviously an issue in your patched kernel=
, we need to find=0A> this first before we draw any conclusion from any oth=
er behaviour.=0A> =0A> From the trace you sent, it looks like it happens in=
 the MTRR code, but=0A> it could also be an SMI, or some other bug. For deb=
ugging purposes,=0A> could you try disabling MTRRs in the kernel configurat=
ion?=0A> =0A> --=0A> =09=09=09=09=09    Gilles.=0A> =0A


