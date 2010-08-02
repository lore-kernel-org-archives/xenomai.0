MIME-Version: 1.0
In-Reply-To: <AANLkTiktAuNZQP0hqXoHBZMayaywfkZ9By6_ug5B8YM_@domain.hid>
References: <AANLkTimuiAP=dGQSKG2PYJUnGw--1iXBzPJ1325czz-_@domain.hid>
	<1280655383.6700.11.camel@domain.hid>
	<AANLkTiktAuNZQP0hqXoHBZMayaywfkZ9By6_ug5B8YM_@domain.hid>
Date: Sun, 1 Aug 2010 22:32:48 -0300
Message-ID: <AANLkTi=b8xQcH+-nOAeP=fJgYwbqug7FFHC-nefv8JuQ@mail.gmail.com>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=00163646b956ac2ff2048ccd2dce
Subject: Re: [Xenomai-help] Problems with user_irq.c Native example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: murilomarinho@domain.hid, xenomai@xenomai.org

--00163646b956ac2ff2048ccd2dce
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I also recommend the rtdm approach. I used it here in a pc/104 and irq7 bus
and it works very well.

Best regards,

Flavio

Em 01/08/2010 10:13, "Henri Roosen" <henriroosen@domain.hid>escreveu:

If you really want to use the rt_intr_xxx interface, you might want to
pass the RT_INTR_NOENABLE mode-flag to rt_intr_create and call
rt_intr_enable after you have acknowledged your interrupt source (or
just before you wait for the interrupt) in your interrupt handler.

But as Philippe mentioned it is cleaner to use the rtdm driver approach.

Henri.


On Sun, Aug 1, 2010 at 11:36 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Sun, 2010-08-01 at 04...

--00163646b956ac2ff2048ccd2dce
Content-Type: text/html; charset=ISO-8859-1

<p>Hello,</p>
<p>I also recommend the rtdm approach. I used it here in a pc/104 and irq7 bus and it works very well.</p>
<p>Best regards,</p>
<p>Flavio</p>
<p><blockquote type="cite">Em 01/08/2010 10:13, &quot;Henri Roosen&quot; &lt;<a href="mailto:henriroosen@domain.hid">henriroosen@domain.hid</a>&gt;escreveu:<br><br>If you really want to use the rt_intr_xxx interface, you might want to<br>

pass the RT_INTR_NOENABLE mode-flag to rt_intr_create and call<br>
rt_intr_enable after you have acknowledged your interrupt source (or<br>
just before you wait for the interrupt) in your interrupt handler.<br>
<br>
But as Philippe mentioned it is cleaner to use the rtdm driver approach.<br>
<font color="#888888"><br>
Henri.<br>
</font><p><font color="#500050"><br>On Sun, Aug 1, 2010 at 11:36 AM, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:<br>&gt; On Sun, 2010-08-01 at 04...</font></p></blockquote></p>

--00163646b956ac2ff2048ccd2dce--

