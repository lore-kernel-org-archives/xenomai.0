Message-ID: <b647ffbd0703201721g1752e0falbe3fed8df405b3f8@domain.hid>
Date: Wed, 21 Mar 2007 01:21:19 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Xenomai support for ARM926EJ
In-Reply-To: <17920.13832.789072.876398@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_178637_28642621.1174436479099"
References: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>
	<17914.63535.18893.207257@domain.hid>
	<fdba73240703201122w447cce8bl186ba32df55665c7@domain.hid>
	<17920.13832.789072.876398@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_178637_28642621.1174436479099
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 20/03/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Muruganandam Ganapathy wrote:
>  > The board is based on the Fujitsu SOC which has the ARM926EJ processor
core.
>  >
>  > This board has SPI, I2C and 10/100 ethernet interfaces and it can
support
>  > 16/32MB SDRAM
>  > and 4/8MB flash memory.
>
> You still do not tell us the name of the board, but it is probably not
> supported.
>
>  >
>  >
>  > In addition, I would like to know the interrupt reponse  mesaured with
>  > Xenomai in ARM9
>  > processor based platforms, if any.
>  > The interrupt response expected is around 40 -50 microseconds in our
case.
>  > The interrupt response I mean, it is the time between the generation of
the
>  > interrupt and the actual ISR invocation.
>  >
>  >
>  > Whether use of Xenomai will enable us meet this timing reqirement.
>
> The latencies I have observed so far on ARM are usually larger than 150
> microseconds, but these are userspace dispatch latencies.
>
> So, you could improve situation if you stay in interrupt handlers.
>
> Another way to improve the situation a bit more is to use ucLinux, if
> your platform is supported.
>
> Still, IMHO, 40-50 microseconds is too ambitious.

Gilles, as I understood the question was about the interrupt latency, not
the scheduling one.

I guess, the vitually tagged cache is an additional component of high
scheduling latencies on ARM.

The interrupt latency should be ok though.

>
> --
>
>
>                                             Gilles Chanteperdrix.
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_178637_28642621.1174436479099
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>On 20/03/07, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>&gt; Muruganandam Ganapathy wrote:<br>&gt;&nbsp;&nbsp;&gt; The board is based on the Fujitsu SOC which has the ARM926EJ processor core.
<br>&gt;&nbsp;&nbsp;&gt;<br>&gt;&nbsp;&nbsp;&gt; This board has SPI, I2C and 10/100 ethernet interfaces and it can support<br>&gt;&nbsp;&nbsp;&gt; 16/32MB SDRAM<br>&gt;&nbsp;&nbsp;&gt; and 4/8MB flash memory.<br>&gt; <br>&gt; You still do not tell us the name of the board, but it is probably not
<br>&gt; supported.<br>&gt; <br>&gt;&nbsp;&nbsp;&gt;<br>&gt;&nbsp;&nbsp;&gt;<br>&gt;&nbsp;&nbsp;&gt; In addition, I would like to know the interrupt reponse&nbsp;&nbsp;mesaured with<br>&gt;&nbsp;&nbsp;&gt; Xenomai in ARM9<br>&gt;&nbsp;&nbsp;&gt; processor based platforms, if any.<br>
&gt;&nbsp;&nbsp;&gt; The interrupt response expected is around 40 -50 microseconds in our case.<br>&gt;&nbsp;&nbsp;&gt; The interrupt response I mean, it is the time between the generation of the<br>&gt;&nbsp;&nbsp;&gt; interrupt and the actual ISR invocation.
<br>&gt;&nbsp;&nbsp;&gt;<br>&gt;&nbsp;&nbsp;&gt;<br>&gt;&nbsp;&nbsp;&gt; Whether use of Xenomai will enable us meet this timing reqirement.<br>&gt; <br>&gt; The latencies I have observed so far on ARM are usually larger than 150<br>&gt; microseconds, but these are userspace dispatch latencies.
<br>&gt; <br>&gt; So, you could improve situation if you stay in interrupt handlers.<br>&gt; <br>&gt; Another way to improve the situation a bit more is to use ucLinux, if<br>&gt; your platform is supported.<br>&gt; <br>&gt; Still, IMHO, 40-50 microseconds is too ambitious.
<br>
<br>
Gilles, as I understood the question was about the interrupt latency, not the scheduling one.<br>
<br>
I guess, the vitually tagged cache is an additional component of high scheduling latencies on ARM.<br>
<br>
The interrupt latency should be ok though.<br>
<br>&gt; <br>&gt; --<br>&gt; <br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Gilles Chanteperdrix.<br>&gt; <br>&gt; _______________________________________________<br>&gt; Xenomai-core mailing list<br>&gt; <a href="mailto:Xenomai-core@domain.hid">Xenomai-core@domain.hid</a><br>&gt; <a href="https://mail.gna.org/listinfo/xenomai-core">
https://mail.gna.org/listinfo/xenomai-core</a><br>&gt; <br><br><br>-- <br>Best regards,<br>Dmitry Adamushko<br>

------=_Part_178637_28642621.1174436479099--

