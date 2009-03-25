MIME-Version: 1.0
In-Reply-To: <OF5B5E5AC3.6A0C34CA-ON65257584.004E9C1C-65257584.004E9C2A@tcs.com>
References: <OF5B5E5AC3.6A0C34CA-ON65257584.004E9C1C-65257584.004E9C2A@tcs.com>
Date: Wed, 25 Mar 2009 16:16:00 +0100
Message-ID: <f48df4840903250815q2a1c4362ka185d5b2738f3234@domain.hid>
From: Bruno Rouchouse <brouchouse@domain.hid>
Content-Type: multipart/alternative; boundary=001636c923d724c8080465f2fa82
Subject: Re: [Xenomai-help] Error in adapter.cc during the "make" of xenosim
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vandana Sasidharan <vandana.sasidharan@domain.hid>
Cc: xenomai@xenomai.org

--001636c923d724c8080465f2fa82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

sorry, my previous answer was misleading wrt your problem I think. Tix has
probably nothing to do in your current issue but I'll check. I got confused
since I answered from the top of my head without having the code base at
hand.

My advice still applies though: build the latest xenosim release on an older
Linux host distribution (Debian/Sarge, FC5 or an equivalent distribution)
may help you to get quicker results.

If you have a powerful host hardware platform (core 2 Duo for instance),
installing this older Linux distribution into a qemu or virtualbox may be a
good solution, at least for a first try in order to get through the whole
build process.

PS : I think I stumbled over the adapter.cc compilation issue at one point.
I'll check later on today and will give you an update later on...

--BR

2009/3/25 Vandana Sasidharan <vandana.sasidharan@domain.hid>

>
> HI,
>
> Following the below query posted yesterday,
> I tried using previous versions of xenosim(as per the reply), but still
> could not resolve the below errors in adapter.cc.
> Just to go forward I commented the lines in adapter.cc where I found
> errors.
>
> Further when I started recompiling, I got errors in queue.h and heap.h in
> under native skin,
> This is what I am getting:
>
> 2.4.7/../include/nucleus/pod.h:34,
>
> from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:31:
> /usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union that
> defines no instances
> In file included
> from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:44:
> /usr/src/xenomai-2.4.7/xenosim-2.4.7/../include/native/queue.h:136: syntax
> error before `*'
> In file included
> from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:45:
> /usr/src/xenomai-2.4.7/xenosim-2.4.7/../include/native/heap.h:122: syntax
> error before `*'
> make[2]: *** [module.o] Error 1
> make[2]: Leaving directory
> `/usr/src/xenomai-2.4.7/xenosim-2.4.7/sim_bld/skins/native'
> make[1]: *** [all-recursive] Error 1
>
>
> Please can you help and let me know where I am going wrong?
>
> Thanks & regards,
> Vandana
>
> ---------------------------------------------------------------------------
>
> Hi,
>
> First of all sorry for mailing to Xenomai-core.
>
> Can you please tell me whether I should switch to the older distribution of
> xenosim, Linux or Tix, I am a bit confused regarding the same and it would
> be be really great if you you could clarify it. In case if
> it is Tix where can I get the download? Thanks in advance.
>
> For those who dont know what error I am getting:-
>
> an error occurs when I am trying to "MAKE" Xenosim- 2.4.7.
> I have already installed Xenomai- 2.4.7 along with libelf -0.8.10 , Tcl
> 8.3.5, Tk 8.3.5 , Tix 4.1.0.007 and an adeos patch that is adeos-ipipe
> -2.6.25-x86-2.0-08.patch on a linux kernel which we built which has a
> version Linux 2.6.25.11.
> after configuring Xenosim along with the gcc -2.95.3 tar .gz when I try to
> "make" the xenosim I'm getting an error :
>
> xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 65: error :too few
> arguments
> xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 67: error :too few
> arguments
>
> Kind Regards,
> Vandana.
>
> =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain
> confidential or privileged information. If you are
> not the intended recipient, any dissemination, use,
> review, distribution, printing or copying of the
> information contained in this e-mail message
> and/or attachments to it are strictly prohibited. If
> you have received this communication in error,
> please notify us by reply e-mail or telephone and
> immediately and permanently delete the message
> and any attachments. Thank you
>
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--001636c923d724c8080465f2fa82
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>sorry, my previous answer was misleading wrt your problem I thin=
k. Tix has probably nothing to do in your current issue but I&#39;ll check.=
 I got confused since I answered from the top of my head without having the=
 code base at hand.<br>
<br>
My advice still applies though: build the latest xenosim release on an olde=
r Linux host distribution (Debian/Sarge, FC5 or an equivalent distribution)=
 may help you to get quicker results.<br><br>If you have a powerful host ha=
rdware platform (core 2 Duo for instance), installing this older Linux dist=
ribution into a qemu or virtualbox may be a good solution, at least for a f=
irst try in order to get through the whole build process.<br>

<br>PS : I think I stumbled over the adapter.cc compilation issue at one po=
int. I&#39;ll check later on today and will give you an update later on...<=
br><br>--BR<br><br><div class=3D"gmail_quote">2009/3/25 Vandana Sasidharan =
<span dir=3D"ltr">&lt;<a href=3D"mailto:vandana.sasidharan@domain.hid" target=
=3D"_blank">vandana.sasidharan@domain.hid</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
HI,<br>
<br>
Following the below query posted yesterday,<br>
I tried using previous versions of xenosim(as per the reply), but still<br>
could not resolve the below errors in adapter.cc.<br>
Just to go forward I commented the lines in adapter.cc where I found<br>
errors.<br>
<br>
Further when I started recompiling, I got errors in queue.h and heap.h in<b=
r>
under native skin,<br>
This is what I am getting:<br>
<br>
2.4.7/../include/nucleus/pod.h:34,<br>
<br>
from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:31:=
<br>
/usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union that<br>
defines no instances<br>
In file included<br>
from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:44:=
<br>
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../include/native/queue.h:136: syntax<=
br>
error before `*&#39;<br>
In file included<br>
from /usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/module.c:45:=
<br>
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../include/native/heap.h:122: syntax<b=
r>
error before `*&#39;<br>
make[2]: *** [module.o] Error 1<br>
make[2]: Leaving directory<br>
`/usr/src/xenomai-2.4.7/xenosim-2.4.7/sim_bld/skins/native&#39;<br>
make[1]: *** [all-recursive] Error 1<br>
<br>
<br>
Please can you help and let me know where I am going wrong?<br>
<br>
Thanks &amp; regards,<br>
Vandana<br>
<br>
---------------------------------------------------------------------------=
<br>
<br>
Hi,<br>
<br>
First of all sorry for mailing to Xenomai-core.<br>
<br>
Can you please tell me whether I should switch to the older distribution of=
<br>
xenosim, Linux or Tix, I am a bit confused regarding the same and it would<=
br>
be be really great if you you could clarify it. In case if<br>
it is Tix where can I get the download? Thanks in advance.<br>
<br>
For those who dont know what error I am getting:-<br>
<br>
an error occurs when I am trying to &quot;MAKE&quot; Xenosim- 2.4.7.<br>
I have already installed Xenomai- 2.4.7 along with libelf -0.8.10 , Tcl<br>
8.3.5, Tk 8.3.5 , Tix 4.1.0.007 and an adeos patch that is adeos-ipipe<br>
-2.6.25-x86-2.0-08.patch on a linux kernel which we built which has a<br>
version Linux 2.6.25.11.<br>
after configuring Xenosim along with the gcc -2.95.3 tar .gz when I try to<=
br>
&quot;make&quot; the xenosim I&#39;m getting an error :<br>
<br>
xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 65: error :too few<br>
arguments<br>
xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 67: error :too few<br>
arguments<br>
<br>
Kind Regards,<br>
Vandana.<br>
<br>
=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D<br>
Notice: The information contained in this e-mail<br>
message and/or attachments to it may contain<br>
confidential or privileged information. If you are<br>
not the intended recipient, any dissemination, use,<br>
review, distribution, printing or copying of the<br>
information contained in this e-mail message<br>
and/or attachments to it are strictly prohibited. If<br>
you have received this communication in error,<br>
please notify us by reply e-mail or telephone and<br>
immediately and permanently delete the message<br>
and any attachments. Thank you<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid" target=3D"_blank">Xenomai-help@domain.hid.=
org</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</blockquote></div><br>

--001636c923d724c8080465f2fa82--

