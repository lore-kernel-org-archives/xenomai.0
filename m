Message-ID: <353969d40709270257y1e1ea80die836bc56a11e2e15@domain.hid>
Date: Thu, 27 Sep 2007 11:57:18 +0200
From: "Guillaume Gaudonville" <guillaume.gaudonville@domain.hid>
In-Reply-To: <46FA8D23.6010203@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1583_24291836.1190887038821"
References: <353969d40709260127s1c7fb5c6necdcf3591abc90f4@domain.hid>
	<46FA26C0.5050606@domain.hid>
	<353969d40709260447l1b64e966hb500f8d3c0d4a0a@domain.hid>
	<353969d40709260858w3e1e30bbr58492008e8ca28ae@domain.hid>
	<46FA8D23.6010203@domain.hid>
Subject: Re: [Xenomai-core] new features for 16550A driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

------=_Part_1583_24291836.1190887038821
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2007/9/26, Jan Kiszka <jan.kiszka@domain.hid>:
>
> Guillaume Gaudonville wrote:
> > I've attached the patch drafts. It works fine for me. it prepare the
> work to
> > implement the other iflag values as describe in man tcsetattr.
> >
>
> ...
>
> >
> > Index: ksrc/drivers/serial/16550A.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- ksrc/drivers/serial/16550A.c      (r=E9vision 2765)
> > +++ ksrc/drivers/serial/16550A.c      (copie de travail)
> > @@ -153,7 +153,10 @@ static inline int rt_16550_rx_interrupt(
> >       do {
> >               c =3D rt_16550_reg_in(mode, base, RHR);   /* read input c=
har
> */
> >
> > -             ctx->in_buf[ctx->in_tail] =3D c;
> > +             if (testbits(ctx->config.iflags, RTSER_IFLAG_ISTRIP))
> > +                     ctx->in_buf[ctx->in_tail] =3D c & 0x7f;
> > +             else
> > +                     ctx->in_buf[ctx->in_tail] =3D c;
>
> OK, things become clearer.
>
> Question: Switching parity checking on in the hardware does not work/is
> no option for you? Shouldn't that clear the parity information as well?

It's not an option for me. I'm not sure if that clear the parity informatio=
n
but I don't want to have parity error checking. I think this option exist
to permit to manage a remote hardware which communicates over
the serial line with parity enabled when we don't mind of the parity
information and don't want to see parity error.


>               if (ctx->in_history)
> >                       ctx->in_history[ctx->in_tail] =3D *timestamp;
> >               ctx->in_tail =3D (ctx->in_tail + 1) & (IN_BUFFER_SIZE - 1=
);
> > @@ -426,6 +429,10 @@ static int rt_16550_set_config(struct rt
> >               rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
> >       }
> >
> > +     if (testbits(config->config_mask, RTSER_SET_IFLAGS)) {
> > +             ctx->config.iflags =3D config->iflags;
> > +     }
> > +
> >       return err;
> >  }
> >
> > Index: include/rtdm/rtserial.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- include/rtdm/rtserial.h   (r=E9vision 2765)
> > +++ include/rtdm/rtserial.h   (copie de travail)
> > @@ -184,6 +184,7 @@
> >  #define RTSER_SET_TIMEOUT_EVENT              0x0400
> >  #define RTSER_SET_TIMESTAMP_HISTORY  0x0800
> >  #define RTSER_SET_EVENT_MASK         0x1000
> > +#define RTSER_SET_IFLAGS             0x2000
> >  /** @} */
> >
> >
> > @@ -238,6 +239,15 @@
> >  #define RTSER_BREAK_SET                      0x01
> >
> >
> > +/*!
> > + * @anchor RTSER_IFLAG_xxx   @name RTSER_IFLAG_xxx
> > + * Input behaviour (when used every bits will be set by the ioctl
> command)
> > + * @{ */
> > +#define RTSER_IFLAG_NONE             0x00
> > +#define RTSER_IFLAG_ISTRIP           0x01
> > +#define RTSER_IFLAG_DEFAULT          0x00
> > +
> > +
> >  /**
> >   * Serial device configuration
> >   */
> > @@ -280,6 +290,11 @@ typedef struct rtser_config {
> >       /** event mask to be used with @ref RTSER_RTIOC_WAIT_EVENT, see
> >        *  @ref RTSER_EVENT_xxx */
> >       int             event_mask;
> > +
> > +     /** input flags, see @ref RTSER_IFLAG_xxx, RTSER_IFLAG_ISTRIP is
> > +      *  the only one supported for the moment (when used every bits
> > +      *  must be set according to the desired configuration)*/
> > +     int             iflags;
> >  } rtser_config_t;
> >
> >  /**
>
> The patch looks very clean, no question! Assuming my attempt above to
> use the hardware for this is nonsense, I then wonder if the feature is
> worth the additional conditional branch + another potential cache miss
> (for ctx->config.iflags) inside the critical reception path.


This is precisely that question of balance: Is the extension of some
> broader interest? Do we need it inside the driver (I see no reason yet
> why the application cannot do the masking, and we are not forced into
> compatibility with termios)? And does the extension impact critical paths=
?


I agree with you if the goal was just to manage the ISTRIP option. But we
could
then add some of the other input flag :

       * IGNBRK Ignore BREAK condition on input.
       * BRKINT If  IGNBRK  is set, a BREAK is ignored. If it is not set bu=
t
BRKINT is set, then a BREAK causes the input and output queues to be
flushed, and if the terminal is the controlling terminal of a foreground
process group, it will cause a SIGINT to be sent to this foreground process
group.  When neither IGNBRK nor BRKINT are set, a BREAK reads as a null byt=
e
('\0'), except when  PARMRK is set, in which case it reads as the sequence
\377 \0 \0.
       * IGNPAR Ignore framing errors and parity errors.
       * PARMRK If  IGNPAR is not set, prefix a character with a parity
error or framing error with \377 \0.  If neither IGNPAR nor PARMRK is set,
read a character with a parity error or framing error as \0.
       * INPCK  Enable input parity checking.
       * ISTRIP Strip off eighth bit.
       * INLCR  Translate NL to CR on input.
       * IGNCR  Ignore carriage return on input.
       * ICRNL  Translate carriage return to newline on input (unless IGNCR
is set).

Maybe I could implement some of them. Number depending upon the time I have=
.

This flag could be very useful to Xenomai users. I know some of them are
implemented
both in termios and in the tyLib of VxWorks. So, I see two use case:

           * peoples who will have to port a Linux application or a VxWorks
application
              under Xenomai: those features would permit them to limits the
modifications
              in the original code (which I think is a big constraint of
this type of work).
           * peoples who will have to code an application which need those
features. This features
              seems to be implemented by a lot of OSes, I don't think this
is done for nothing. This
              limits the development work in User Space while not adding a
big coomplexity in the driver.

Just a precision: Under Linux this is not done in the low-level driver but
in the serial line discipline code. But
your driver manage already the communication with User Space which is more
than what Linux serial
drivers do.


Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>



--=20
Guillaume Gaudonville
E-mail: guillaume.gaudonville@domain.hid

------=_Part_1583_24291836.1190887038821
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">2007/9/26, Jan Kiszka &lt;<a href=
=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;:</span><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Guillaume Gaudonville wrote:<br>&gt; I&#39;ve attached the patch drafts. It=
 works fine for me. it prepare the work to<br>&gt; implement the other ifla=
g values as describe in man tcsetattr.<br>&gt;<br><br>...<br><br>&gt;<br>
&gt; Index: ksrc/drivers/serial/16550A.c<br>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt; --- ksrc/drivers/serial/16550A.c&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(r=E9vision 2765)<br>&gt; +++ ksrc/drivers/ser=
ial/16550A.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(copie de travail)
<br>&gt; @@ -153,7 +153,10 @@ static inline int rt_16550_rx_interrupt(<br>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c =3D rt_1655=
0_reg_in(mode, base, RHR);&nbsp;&nbsp; /* read input char */<br>&gt;<br>&gt=
; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ctx-&gt;in_buf[ctx-&gt;in_tail] =3D c;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (testbits(ctx-&gt;config.iflags, RTSER_IFLAG_ISTRIP))<br>&gt; +&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;in_buf[ctx-&gt;in_tail=
] =3D c &amp; 0x7f;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; else<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ctx-&gt;in_buf[ctx-&gt;in_tail] =3D c;
<br><br>OK, things become clearer.<br><br>Question: Switching parity checki=
ng on in the hardware does not work/is<br>no option for you? Shouldn&#39;t =
that clear the parity information as well?</blockquote><div>It&#39;s not an=
 option for me. I&#39;m not sure if that clear the parity information
<br>but I don&#39;t want to have parity error checking. I think this option=
 exist<br>to permit to manage a remote hardware which communicates over<br>=
the serial line with parity enabled when we don&#39;t mind of the parity
<br>information and don&#39;t want to see parity error.<br>&nbsp;</div><br>=
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(ctx-&gt;in_history)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;i=
n_history[ctx-&gt;in_tail] =3D *timestamp;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;in_tail=
 =3D (ctx-&gt;in_tail + 1) &amp; (IN_BUFFER_SIZE - 1);<br>&gt; @@ -426,6 +4=
29,10 @@ static int rt_16550_set_config(struct rt
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; rtdm_lock_put_irqrestore(&amp;ctx-&gt;lock, lock_ctx);<br=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt; +&nbsp;&nbsp;&n=
bsp;&nbsp; if (testbits(config-&gt;config_mask, RTSER_SET_IFLAGS)) {<br>&gt=
; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ctx-&gt;config.iflags =3D config-&gt;iflags;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return err;<br>&gt;&nbsp;&nbsp;}<br>&gt;<br>&gt; Index: inc=
lude/rtdm/rtserial.h<br>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>&gt; --- include/rtdm/rtserial.h&nbsp;&nbsp; (r=E9vision 2765)
<br>&gt; +++ include/rtdm/rtserial.h&nbsp;&nbsp; (copie de travail)<br>&gt;=
 @@ -184,6 +184,7 @@<br>&gt;&nbsp;&nbsp;#define RTSER_SET_TIMEOUT_EVENT&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;0x0400<br>&gt;&nbsp;&nbsp;#define RTSER_SET_TIMESTAMP_HISTORY&nbsp;&nb=
sp;0x0800<br>&gt;&nbsp;&nbsp;#define RTSER_SET_EVENT_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1000
<br>&gt; +#define RTSER_SET_IFLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2000<br>&gt;&nbsp;&nbsp;/** @} */<br>&gt;=
<br>&gt;<br>&gt; @@ -238,6 +239,15 @@<br>&gt;&nbsp;&nbsp;#define RTSER_BREA=
K_SET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x01<br>&gt;<=
br>&gt;<br>&gt; +/*!<br>&gt; + * @anchor RTSER_IFLAG_xxx&nbsp;&nbsp; @name =
RTSER_IFLAG_xxx
<br>&gt; + * Input behaviour (when used every bits will be set by the ioctl=
 command)<br>&gt; + * @{ */<br>&gt; +#define RTSER_IFLAG_NONE&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<br>&gt; +#d=
efine RTSER_IFLAG_ISTRIP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x01<br>&gt; +#define RTSER_IFLAG_DEFAULT&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00
<br>&gt; +<br>&gt; +<br>&gt;&nbsp;&nbsp;/**<br>&gt;&nbsp;&nbsp; * Serial de=
vice configuration<br>&gt;&nbsp;&nbsp; */<br>&gt; @@ -280,6 +290,11 @@ type=
def struct rtser_config {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** e=
vent mask to be used with @ref RTSER_RTIOC_WAIT_EVENT, see
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;@ref R=
TSER_EVENT_xxx */<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_mask;<=
br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /** input flags, see @ref RTSER=
_IFLAG_xxx, RTSER_IFLAG_ISTRIP is<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;*&nbsp;&nbsp;the only one supported for the moment (when used every bit=
s
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;must be set acco=
rding to the desired configuration)*/<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
lags;<br>&gt;&nbsp;&nbsp;} rtser_config_t;<br>&gt;<br>&gt;&nbsp;&nbsp;/**<b=
r><br>The patch looks very clean, no question! Assuming my attempt above to
<br>use the hardware for this is nonsense, I then wonder if the feature is<=
br>worth the additional conditional branch + another potential cache miss<b=
r>(for ctx-&gt;config.iflags) inside the critical reception path.&nbsp;&nbs=
p;</blockquote>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">This is preci=
sely that question of balance: Is the extension of some<br>broader interest=
? Do we need it inside the driver (I see no reason yet
<br>why the application cannot do the masking, and we are not forced into<b=
r>compatibility with termios)? And does the extension impact critical paths=
?</blockquote><div><br>I agree with you if the goal was just to manage the =
ISTRIP option. But we could
<br>
then add some of the other input flag : <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * IGNBRK Ignore BREAK condition on input.<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * BRKINT If&nbsp; IGNBRK&nbsp; is set, a BREAK is ignored.=
 If it is not set but BRKINT is set, then a BREAK causes the input and outp=
ut queues to be flushed, and if the terminal is the controlling terminal of=
 a foreground process group, it will cause a SIGINT to be sent to this fore=
ground process group.&nbsp; When neither IGNBRK nor BRKINT are set, a BREAK=
 reads as a null byte (&#39;\0&#39;), except when&nbsp; PARMRK is set, in w=
hich case it reads as the sequence \377 \0 \0.
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * IGNPAR Ignore framing errors and=
 parity errors.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PARMRK If&nbsp; I=
GNPAR is not set, prefix a character with a parity error or framing error w=
ith \377 \0.&nbsp; If neither IGNPAR nor PARMRK is set, read a character wi=
th a parity error or framing error as \0.
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * INPCK&nbsp; Enable input parity =
checking.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ISTRIP Strip off eighth=
 bit.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * INLCR&nbsp; Translate NL to=
 CR on input.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * IGNCR&nbsp; Ignore =
carriage return on input.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ICRNL&n=
bsp; Translate carriage return to newline on input (unless IGNCR is set).
<br><br>Maybe I could implement some of them. Number depending upon the tim=
e I have.<br><br>This flag could be very useful to Xenomai users. I know so=
me of them are implemented<br>both in termios and in the tyLib of VxWorks. =
So, I see two use case:
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * peop=
les who will have to port a Linux application or a VxWorks application<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; under Xenomai: those features would permit them to limits the modificati=
ons<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; in the original code (which I think is a big constraint of this =
type of work).
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * peoples =
who will have to code an application which need those features. This featur=
es<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; seems to be implemented by a lot of OSes, I don&#39;t think this =
is done for nothing. This<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; limits the development work in User Space =
while not adding a big coomplexity in the driver.
<br><br>Just a precision: Under Linux this is not done in the low-level dri=
ver but in the serial line discipline code. But<br>your driver manage alrea=
dy the communication with User Space which is more than what Linux serial
<br>drivers do.<br><br></div><br><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">Jan<br><br>--<br>Siemens AG, Corporate Technology, CT SE 2<=
br>
Corporate Competence Center Embedded Linux<br></blockquote></div><br><br cl=
ear=3D"all"><br>-- <br>Guillaume Gaudonville<br>E-mail: <a href=3D"mailto:g=
uillaume.gaudonville@domain.hid">guillaume.gaudonville@domain.hid</a>

------=_Part_1583_24291836.1190887038821--

