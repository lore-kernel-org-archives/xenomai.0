Message-ID: <54b161f50611170119x70b2104cma26e4ad77df8f965@domain.hid>
Date: Fri, 17 Nov 2006 10:19:56 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
In-Reply-To: <455D787D.9010407@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_107850_5630369.1163755196386"
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>
	<455CC9DE.6030601@domain.hid>
	<54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>
	<455D6D3B.9000009@domain.hid>
	<54b161f50611170041t2b8d2da1p177e9addade6a0e3@domain.hid>
	<455D787D.9010407@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_107850_5630369.1163755196386
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/17/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> > I entered the following command:
> >
> > modprobe  xeno_rtcan_isa io=55296,56320 irq=11
>
> Try "modprobe xeno_rtcan_isa io=55296,56320 irq=11,11" instead to assign
> the irq of the second port as well.
>
> Jan
>
>
This (two times irq 11) fails with the following output (only the last part
actually):

rtcan: registered rtcan0
ERROR! IRQ 11 busy or invalid (code=-16)!
ERROR -16 while trying to register SJA1000 device!
Unregistering SJA1000 device rtcan0
RTCAN: unregistered rtcan0
FATAL: Error inserting xeno_rtcan_isa (/lib/modules/../xeno_rtcan_isa.ko):
Device or resource busy

Then it just returns to the shell.

Any ideas about this?

Frits

------=_Part_107850_5630369.1163755196386
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 11/17/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; I entered the following command:<br>&gt;<br>&gt; modprobe&nbsp;&nbsp;xeno_rtcan_isa io=55296,56320 irq=11<br><br>Try &quot;modprobe xeno_rtcan_isa io=55296,56320 irq=11,11&quot; instead to assign<br>the irq of the second port as well.
<br><br>Jan<br><br></blockquote></div><br>
This (two times irq 11) fails with the following output (only the last part actually):<br>
<br>
rtcan: registered rtcan0<br>
ERROR! IRQ 11 busy or invalid (code=-16)!<br>
ERROR -16 while trying to register SJA1000 device!<br>
Unregistering SJA1000 device rtcan0<br>
RTCAN: unregistered rtcan0<br>
FATAL: Error inserting xeno_rtcan_isa (/lib/modules/../xeno_rtcan_isa.ko): Device or resource busy<br>
<br>
Then it just returns to the shell.<br>
<br>
Any ideas about this?<br>
<br>
Frits<br>
<br>
<br>

------=_Part_107850_5630369.1163755196386--

