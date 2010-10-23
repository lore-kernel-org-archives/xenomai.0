Date: Sat, 23 Oct 2010 12:08:26 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_20101023120826000000_48653"
In-Reply-To: <4CBDF92F.20403@domain.hid>
References: <1281709057.650414331@domain.hid>
	<4C65583D.3030800@domain.hid> 
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid> 
	<1283531433.789315367@domain.hid>    
	<1283590285.1709.2153.camel@domain.hid>   
	<1287134519.029617765@domain.hid>  
	<1287143691.028416668@domain.hid> <4CB85C64.9040307@domain.hid> 
	<1287496324.10921156@domain.hid> <4CBDF92F.20403@domain.hid>
Message-ID: <1287832106.517512323@domain.hid>
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

------=_20101023120826000000_48653
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, this script sounds like exactly what I need. I downloaded the lates=
t snapshot of mkrootfs from git, but I don't want to install that on my roo=
tfs. I'd just download the script alone, but looking at it I see it would w=
ant to run a script in /ltp as well, so I guess I need ltp too. Can you tel=
l me an easier way to set up dohell that might save me sifting through the =
whole of ltp and mkrootfs to figure it out?=0A=0AThanks again,=0A=0AEdward=
=0A=0AOn Tuesday, 19 October, 2010 9:01pm, "Gilles Chanteperdrix" <gilles.c=
hanteperdrix@domain.hid> said:=0A=0A> edward.robbins@domain.hid=
.uk wrote:=0A> > Having disabled MTRR (and leaving in Phillipes patch) I am=
 not=0A> > getting unreasonable latencies unless I enable graphics accelera=
tion.=0A> > Can I be sure this has solved the issue?=0A> =0A> Yes, run a lo=
ng stress test while running latency. The stress test=0A> should stress any=
thing (drivers, kernel services) you plan to use in the=0A> final system.=
=0A> =0A> The way we do this when validating Xenomai is by running the "doh=
ell"=0A> scripts, which relies on LTP to stress many kernel services.=0A> h=
ttp://git.xenomai.org/?p=3Dmkrootfs.git;a=3Dblob;f=3Dtests/dohell;h=3D327a9=
f20755e23547f960e4c316141652f839bbf;hb=3Dmaster=0A> =0A> --=0A>            =
                                                     Gilles.=0A> =0A
------=_20101023120826000000_48653
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial" size=3D"2">Thanks, this script sounds like exactly wha=
t I need. I downloaded the latest snapshot of mkrootfs from git, but I don'=
t want to install that on my rootfs. I'd just download the script alone, bu=
t looking at it I see it would want to run a script in /ltp as well, so I g=
uess I need ltp too. Can you tell me an easier way to set up dohell that mi=
ght save me sifting through the whole of ltp and mkrootfs to figure it out?=
<br><br>Thanks again,<br><br>Edward<br><br>On Tuesday, 19 October, 2010 9:0=
1pm, "Gilles Chanteperdrix" &lt;gilles.chanteperdrix@xenomai.org&gt; said:<=
br><br>&gt; edward.robbins@domain.hid wrote:<br>&gt; &gt; Hav=
ing disabled MTRR (and leaving in Phillipes patch) I am not<br>&gt; &gt; ge=
tting unreasonable latencies unless I enable graphics acceleration.<br>&gt;=
 &gt; Can I be sure this has solved the issue?<br>&gt; <br>&gt; Yes, run a =
long stress test while running latency. The stress test<br>&gt; should stre=
ss anything (drivers, kernel services) you plan to use in the<br>&gt; final=
 system.<br>&gt; <br>&gt; The way we do this when validating Xenomai is by =
running the "dohell"<br>&gt; scripts, which relies on LTP to stress many ke=
rnel services.<br>&gt; http://git.xenomai.org/?p=3Dmkrootfs.git;a=3Dblob;f=
=3Dtests/dohell;h=3D327a9f20755e23547f960e4c316141652f839bbf;hb=3Dmaster<br=
>&gt; <br>&gt; --<br>&gt;                                                  =
               Gilles.<br>&gt; <br></font>
------=_20101023120826000000_48653--


