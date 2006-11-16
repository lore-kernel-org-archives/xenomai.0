Message-ID: <54b161f50611160754td24368dx150aa449dca1f80c@domain.hid>
Date: Thu, 16 Nov 2006 16:54:11 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
Subject: Re: [Xenomai-help] invalid parameter for xeno_rtcan_mem.ko
In-Reply-To: <455C8766.5030905@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_93230_13034488.1163692451661"
References: <54b161f50611160723r355a603awc1d8e1234e5ed44d@domain.hid>
	<455C8766.5030905@domain.hid>
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

------=_Part_93230_13034488.1163692451661
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

do you mean I should have better provided a patch? I'd love to do so, but
I'm not (yet) much of a Linux developer and I've never created a patch
before. But I guess there's no escaping the need of learning how to do so
very soon :)

Best regards,

Frits

On 11/16/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Frits de Klark wrote:
> > Hello everyone,
> >
> > I tried to load the xeno_rtcan_mem module. I got a message that
> parameter
> > 'io' is unknown. After a modinfo I found out that the actual parameter
> > should be 'mem'. I suggest you fix this, since it can be somewhat
> > confusing.
>
> I simple patch would explain better that you are referring to the
> message in rtcan_mem_init(). And it would already fix the issue. :)
>
> Jan
>
>
>
>

------=_Part_93230_13034488.1163692451661
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>
<br>
do you mean I should have better provided a patch? I'd love to do so,
but I'm not (yet) much of a Linux developer and I've never created a
patch before. But I guess there's no escaping the need of learning how
to do so very soon :)<br>
<br>
Best regards,<br>
<br>
Frits<br><br><div><span class="gmail_quote">On 11/16/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Frits de Klark wrote:<br>&gt; Hello everyone,<br>&gt;<br>&gt; I tried to load the xeno_rtcan_mem module. I got a message that parameter<br>&gt; 'io' is unknown. After a modinfo I found out that the actual parameter<br>&gt; should be 'mem'. I suggest you fix this, since it can be somewhat
<br>&gt; confusing.<br><br>I simple patch would explain better that you are referring to the<br>message in rtcan_mem_init(). And it would already fix the issue. :)<br><br>Jan<br><br><br><br></blockquote></div><br>

------=_Part_93230_13034488.1163692451661--

