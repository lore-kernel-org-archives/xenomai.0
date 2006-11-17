Message-ID: <54b161f50611170041t2b8d2da1p177e9addade6a0e3@domain.hid>
Date: Fri, 17 Nov 2006 09:41:40 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
In-Reply-To: <455D6D3B.9000009@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_107374_4249884.1163752900635"
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>
	<455C8B8A.80105@domain.hid> <455CBC4A.5010108@domain.hid>
	<54b161f50611161200u7a32f87etdad89178ddc1a195@domain.hid>
	<455CC9DE.6030601@domain.hid>
	<54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>
	<455D6D3B.9000009@domain.hid>
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

------=_Part_107374_4249884.1163752900635
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So,

On 11/17/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
>
> You could try handing region 2 or 3 to the rtcan_isa driver or region 0
> to rtcan_mem. Maybe your adapter actually does 1:1 mapping of the
> SJA1000 address space (it looks like). I just wonder what region 4 is
> doing. Maybe it controls the content of region 0, which may either hold
> the first or the second CAN controller. Just a theory...
>
> Jan



I entered the following command:

modprobe  xeno_rtcan_isa io=55296,56320 irq=11

and the following output appeared:

RTCAN SJA1000 driver registered
rtcan: registered rtcan0
rtcan: registered rtcan1

and shortly thereafter:

Xenomai: xnintr_irq_handler: IRQ0 not handled. Disabling IRQ line.

The first part seems quite good to me. I don't know what to think of the
'disabling IRQ line' message.

I have to get hold of a CAN cable, so I can actually test if it works. I'll
get back on this one soon.

Frits

------=_Part_107374_4249884.1163752900635
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So,<br><br><div><span class="gmail_quote">On 11/17/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>You could try handing region 2 or 3 to the rtcan_isa driver or region 0<br>to rtcan_mem. Maybe your adapter actually does 1:1 mapping of the<br>SJA1000 address space (it looks like). I just wonder what region 4 is<br>
doing. Maybe it controls the content of region 0, which may either hold<br>the first or the second CAN controller. Just a theory...<br><br>Jan</blockquote><div><br>
<br>
I entered the following command:<br>
<br>
modprobe&nbsp; xeno_rtcan_isa io=55296,56320 irq=11<br>
<br>
and the following output appeared:<br>
<br>
RTCAN SJA1000 driver registered<br>
rtcan: registered rtcan0<br>
rtcan: registered rtcan1<br>
<br>
and shortly thereafter:<br>
<br>
Xenomai: xnintr_irq_handler: IRQ0 not handled. Disabling IRQ line.<br>
<br>
The first part seems quite good to me. I don't know what to think of the 'disabling IRQ line' message.<br>
<br>
I have to get hold of a CAN cable, so I can actually test if it works. I'll get back on this one soon.<br>
<br>
Frits<br>
</div><br></div><br>

------=_Part_107374_4249884.1163752900635--

