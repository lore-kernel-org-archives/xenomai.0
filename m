Message-ID: <12fd9d1aac8.sdiani@domain.hid>
Date: Tue, 10 May 2011 14:11:27 +0200 (CEST)
From: "sdiani@domain.hid" <sdiani@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_30241_12640927.1305029487308"
Subject: [Adeos-main] R:  R: Re:  Adeos for PowerPc 2.6.29.4-64 bit
Reply-To: "sdiani@domain.hid" <sdiani@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

------=_Part_30241_12640927.1305029487308
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It seems working, it worked for 1 hour without freezing
Now i want to stress the kernel a bit.

Thank's a lot

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







------=_Part_30241_12640927.1305029487308
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems working,&nbsp;it worked for 1 hour without freezing<BR>Now i want =
to stress the kernel a bit.<BR><BR>Thank's a lot<BR><BR>Sergio<BR>
<BLOCKQUOTE>----Messaggio originale----<BR>Da: sdiani@domain.hid<BR>Data: 9-m=
ag-2011 17.16<BR>A: &lt;rpm@xenomai.org&gt;<BR>Cc: &lt;adeos-main@gna.org&g=
t;<BR>Ogg: [Adeos-main] R: Re: Adeos for PowerPc 2.6.29.4-64 bit<BR><BR>Ton=
ight I try it and I will&nbsp;tell You<BR><BR>Thanks<BR><BR>Sergio<BR>
<BLOCKQUOTE>----Messaggio originale----<BR>Da: rpm@xenomai.org<BR>Data: 4-m=
ag-2011 16.44<BR>A: "sdiani@domain.hid"&lt;sdiani@domain.hid&gt;<BR>Cc: &lt;ade=
os-main@domain.hid&gt;<BR>Ogg: Re: [Adeos-main] Adeos for PowerPc 2.6.29.4-64 =
bit<BR><BR>On Wed, 2011-05-04 at 14:57 +0200, sdiani@domain.hid wrote:<BR>&gt=
; <BR>&gt; Hi everyone,<BR>&gt; i'm trying to compile the 2.6.29.4 64-bit D=
enx kernel for PowerPC<BR>&gt; ( PPC 970 , G5 Desktop ).<BR>&gt; I have app=
lied the<BR>&gt; patch&nbsp; adeos-ipipe-2.6.29.4-powerpc-DENX-2.7-04.patch=
&nbsp; and after<BR>&gt; reboot i get this error:<BR>&gt; <BR>&gt;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NIP [000001C96=
8] .power4_idle+0x54/0x58 <BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; LR =3D (null)<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<B=
R>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Exceptionn: 901 at power4_idle+0x54/0x58<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LR =3D .cpu_idle +0x11c/0x1d4<BR>&=
gt; <BR>&gt; It regards the idle_power4.S file and the only changes in it, =
are<BR>&gt; about the CONFIG_SOFTDISABLE.<BR>&gt; Can Anyone help me to sol=
ve it ?<BR><BR>The power save code for powermac won't work as is with Adeos=
. Try<BR>booting with powersave=3Doff.<BR><BR>&gt; <BR>&gt; Thank you in ad=
vance<BR>&gt; <BR>&gt; Sergio<BR>&gt; _____________________________________=
__________<BR>&gt; Adeos-main mailing list<BR>&gt; Adeos-main@domain.hid<BR>&g=
t; https://mail.gna.org/listinfo/adeos-main<BR><BR>-- <BR>Philippe.<BR><BR>=
<BR><BR></BLOCKQUOTE><BR><BR></BLOCKQUOTE><BR>
------=_Part_30241_12640927.1305029487308--


