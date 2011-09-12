Message-ID: <1325fd9ad86.sdiani@domain.hid>
Date: Tue, 13 Sep 2011 00:54:53 +0200 (CEST)
From: "sdiani@domain.hid" <sdiani@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_170817_21771034.1315868093834"
Subject: [Adeos-main] Adeos for PowerPc 2.6.29.4-64 bit
Reply-To: "sdiani@domain.hid" <sdiani@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: rpm@xenomai.org

------=_Part_170817_21771034.1315868093834
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

  Is it possible to have an adeos 64-bit patch  for the 2.6.29.4-64-bit kernel, running on a G5 (PowerPc64)?
  if not, how can I built one ?
  The latest that I found is "adeos-ipipe-2.6.22-rc5-powerpc64-1.4-00.patch".

Thanks 
Sergio


----Messaggio originale----

Da: sdiani@domain.hid

Data: 10-mag-2011 14.11

A: <rpm@xenomai.org>

Cc: <adeos-main@gna.org>

Ogg: R: [Adeos-main] R: Re:  Adeos for PowerPc 2.6.29.4-64 bit



It seems working, it worked for 1 hour without freezing
Now i want to stress the kernel a bit.

Thanks a lot

Sergio

----Messaggio originale----
Da: sdiani@domain.hid
Data: 9-mag-2011 17.16
A: <rpm@xenomai.org>
Cc: <adeos-main@gna.org>
Ogg: [Adeos-main] R: Re: Adeos for PowerPc 2.6.29.4-64 bit

Tonight I try it and I will tell You

Thanks

Sergio

----Messaggio originale----
Da: rpm@xenomai.org
Data: 4-mag-2011 16.44
A: "sdiani@domain.hid"<sdiani@domain.hid>
Cc: <adeos-main@gna.org>
Ogg: Re: [Adeos-main] Adeos for PowerPc 2.6.29.4-64 bit

On Wed, 2011-05-04 at 14:57 +0200, sdiani@domain.hid wrote:
> 
> Hi everyone,
> i'm trying to compile the 2.6.29.4 64-bit Denx kernel for PowerPC
> ( PPC 970 , G5 Desktop ).
> I have applied the
> patch  adeos-ipipe-2.6.29.4-powerpc-DENX-2.7-04.patch  and after
> reboot i get this error:
> 
>                         NIP [000001C968] .power4_idle+0x54/0x58 
>                         LR = (null)
>                             ....
>                         Exceptionn: 901 at power4_idle+0x54/0x58
>                                     LR = .cpu_idle +0x11c/0x1d4
> 
> It regards the idle_power4.S file and the only changes in it, are
> about the CONFIG_SOFTDISABLE.
> Can Anyone help me to solve it ?

The power save code for powermac won't work as is with Adeos. Try
booting with powersave=off.

> 
> Thank you in advance
> 
> Sergio
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main

-- 
Philippe.











------=_Part_170817_21771034.1315868093834
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>&nbsp; Is it possible to have an adeos 64-bit patch&nbsp; for th=
e 2.6.29.4-64-bit kernel, running on a G5 (PowerPc64)?<br>&nbsp; if not, ho=
w can I built one ?<br>&nbsp; The latest that I found is "adeos-ipipe-2.6.2=
2-rc5-powerpc64-1.4-00.patch".<br><br>Thanks <br>Sergio<br>
<blockquote>
----Messaggio originale----<br>
Da: sdiani@domain.hid<br>
Data: 10-mag-2011 14.11<br>
A: &lt;rpm@xenomai.org&gt;<br>
Cc: &lt;adeos-main@gna.org&gt;<br>
Ogg: R: [Adeos-main] R: Re:  Adeos for PowerPc 2.6.29.4-64 bit<br>
<br>
It seems working,&nbsp;it worked for 1 hour without freezing<br>Now i want =
to stress the kernel a bit.<br><br>Thanks a lot<br><br>Sergio<br>
<blockquote>----Messaggio originale----<br>Da: sdiani@domain.hid<br>Data: 9-m=
ag-2011 17.16<br>A: &lt;rpm@xenomai.org&gt;<br>Cc: &lt;adeos-main@gna.org&g=
t;<br>Ogg: [Adeos-main] R: Re: Adeos for PowerPc 2.6.29.4-64 bit<br><br>Ton=
ight I try it and I will&nbsp;tell You<br><br>Thanks<br><br>Sergio<br>
<blockquote>----Messaggio originale----<br>Da: rpm@xenomai.org<br>Data: 4-m=
ag-2011 16.44<br>A: "sdiani@domain.hid"&lt;sdiani@domain.hid&gt;<br>Cc: &lt;ade=
os-main@domain.hid&gt;<br>Ogg: Re: [Adeos-main] Adeos for PowerPc 2.6.29.4-64 =
bit<br><br>On Wed, 2011-05-04 at 14:57 +0200, sdiani@domain.hid wrote:<br>&gt=
; <br>&gt; Hi everyone,<br>&gt; i'm trying to compile the 2.6.29.4 64-bit D=
enx kernel for PowerPC<br>&gt; ( PPC 970 , G5 Desktop ).<br>&gt; I have app=
lied the<br>&gt; patch&nbsp; adeos-ipipe-2.6.29.4-powerpc-DENX-2.7-04.patch=
&nbsp; and after<br>&gt; reboot i get this error:<br>&gt; <br>&gt;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NIP [000001C96=
8] .power4_idle+0x54/0x58 <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; LR =3D (null)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<b=
r>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Exceptionn: 901 at power4_idle+0x54/0x58<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LR =3D .cpu_idle +0x11c/0x1d4<br>&=
gt; <br>&gt; It regards the idle_power4.S file and the only changes in it, =
are<br>&gt; about the CONFIG_SOFTDISABLE.<br>&gt; Can Anyone help me to sol=
ve it ?<br><br>The power save code for powermac won't work as is with Adeos=
. Try<br>booting with powersave=3Doff.<br><br>&gt; <br>&gt; Thank you in ad=
vance<br>&gt; <br>&gt; Sergio<br>&gt; _____________________________________=
__________<br>&gt; Adeos-main mailing list<br>&gt; Adeos-main@domain.hid<br>&g=
t; https://mail.gna.org/listinfo/adeos-main<br><br>-- <br>Philippe.<br><br>=
<br><br></blockquote><br><br></blockquote><br><br>
</blockquote><br>

------=_Part_170817_21771034.1315868093834--


