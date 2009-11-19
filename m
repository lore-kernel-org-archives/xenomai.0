MIME-Version: 1.0
In-Reply-To: <4B026454.9080604@domain.hid>
References: <1f3e02580911161827y4926a14fm1facd405efa44ba4@domain.hid> 
	<4B026454.9080604@domain.hid>
From: Sergey Didenko <didenkos@domain.hid>
Date: Thu, 19 Nov 2009 14:31:46 +0900
Message-ID: <1f3e02580911182131g672d58e9ie7467ad304d9f3c3@domain.hid>
Content-Type: multipart/alternative; boundary=00504502ad14070ee30478b2aed1
Subject: Re: [Xenomai-help] Patch to support ARM_MV
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

--00504502ad14070ee30478b2aed1
Content-Type: text/plain; charset=UTF-8

>
> In __ipipe_mach_demux_irq, you must call ipipe_handle_irq, not
> desc_handle_irq.


I hope you mean __ipipe_handle_irq

ipipe_mach_get_tscinfo also needs fixing (type should be
> IPIPE_TSC_TYPE_FREERUNNING_COUNTDOWN,


file ipipe.h (arch\arm\include\asm) has next defines

#define IPIPE_TSC_TYPE_NONE       0
#define IPIPE_TSC_TYPE_FREERUNNING 1
#define IPIPE_TSC_TYPE_DECREMENTER 2

Do you mean i have to use IPIPE_TSC_TYPE_DECREMENTER or I have to define
IPIPE_TSC_TYPE_FREERUNNING_COUNTDOWN as 3 and use it?


> and counter should be set to timer0's physical address, not virtual address

Ok, for my board it is same...naming problem, not an issue...

Sergey

--00504502ad14070ee30478b2aed1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>In __ipipe_mach_demux_irq, you must call ipipe_handle_irq, not<br>

desc_handle_irq. </blockquote></div><div>=C2=A0<br>I hope you mean __ipipe_=
handle_irq<br><br></div><div class=3D"im"><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">

ipipe_mach_get_tscinfo also needs fixing (type should=C2=A0be IPIPE_TSC_TYP=
E_FREERUNNING_COUNTDOWN, </blockquote>
</div><div><br>file ipipe.h (arch\arm\include\asm) has next defines<br><br>=
#define IPIPE_TSC_TYPE_NONE=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0<br>#define IPI=
PE_TSC_TYPE_FREERUNNING 1<br>#define IPIPE_TSC_TYPE_DECREMENTER 2<br><br>Do=
 you mean i have to use IPIPE_TSC_TYPE_DECREMENTER or I have to define IPIP=
E_TSC_TYPE_FREERUNNING_COUNTDOWN as 3 and use it?=C2=A0<br>


</div><div class=3D"im">

<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1p=
x solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">=
and counter should be set to=C2=A0timer0&#39;s physical address,=C2=A0not v=
irtual address</blockquote>


</div><div>Ok, for my board it is same...naming problem, not an issue...<br=
></div>
=C2=A0<br>Sergey

--00504502ad14070ee30478b2aed1--

