MIME-Version: 1.0
In-Reply-To: <1284969270.4114.12.camel@domain.hid>
References: <AANLkTi=5RZVyUPvThyLDRPsmD9U0=A8_UPPm3bUi1E_q@domain.hid>
	<1284960227.4114.11.camel@domain.hid>
	<4C97106E.7060602@domain.hid>
	<1284969270.4114.12.camel@domain.hid>
Date: Mon, 20 Sep 2010 20:46:47 +0200
Message-ID: <AANLkTinBD8X1OO_79zf9=24fvB_cMuBrD1AaFd4F=Bv1@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6dee732abfb010490b55592
Subject: Re: [Xenomai-help] pSOS+ simple example returns error code -14
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e6dee732abfb010490b55592
Content-Type: text/plain; charset=ISO-8859-1

After applying the patch the problem is resolved.
Thank you very much for the quick support.

Best regards,
Ronny

On Mon, Sep 20, 2010 at 9:54 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Mon, 2010-09-20 at 09:42 +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> > > On Sun, 2010-09-19 at 16:04 +0100, ronny meeus wrote:
> > >> Hello
> > >>
> > >> I'm using xenomai in a qemu setup.
> > >> My final goal is to use xenomai to port extisting pSOS application to
> > >> the linux platform.
> > >>
> > >> The first step I did was building a kernel with the pSOS skin enabled.
> > >> These traces are generated at kernel startup:
> > >> [    0.212363] I-pipe: Domain Xenomai registered.
> > >> [    0.212363] Xenomai: hal/i386 started.
> > >> [    0.212363] Xenomai: scheduling class idle registered.
> > >> [    0.212363] Xenomai: scheduling class rt registered.
> > >> [    0.246987] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
> > >> [    0.246987] Xenomai: debug mode enabled.
> > >> [    0.274658] Xenomai: starting native API services.
> > >> [    0.274658] Xenomai: starting POSIX services.
> > >> [    0.296357] Xenomai: starting RTDM services.
> > >> [    0.296357] Xenomai: registered exported object RN#0 (regions)
> > >> [    0.296357] Xenomai: starting pSOS+ services.
> > >> [    0.305601] HugeTLB registered 4 MB page size, pre-allocated 0
> > >> pages
> > >>
> > >> This is the example application:
> > >>
> > >> #include <psos+/psos.h>
> > >>
> > >> void task2_func(u_long a,u_long b,u_long c,u_long d)
> > >> {
> > >>         while (1) {
> > >>                 tm_wkafter(1000);
> > >>         }
> > >> }
> > >>
> > >> int main(int argc, char **argv)
> > >> {
> > >>         unsigned long tid;
> > >>         unsigned long args[4] = {0,0,0,0};
> > >>
> > >>         t_create("TEST",10,160000,160000,0,&tid);
> > >>         t_start(tid,0,task2_func,args);
> > >>         while (1) {
> > >>                 sleep(100);
> > >>         }
> > >> }
> > >
> > > I'm unsure whether the code above is actually the one which issues the
> > > output mentioned below. I see no t_shadow call, and no status printout
> > > there.
> >
> > Maybe the auto-shadowing of the main thread?
> >
>
> Correct. I did not recall we had auto-shadowing in place for pSOS
> actually.
>
> --
> Philippe.
>
>
>

--0016e6dee732abfb010490b55592
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

After applying the patch the problem is resolved.<br>Thank you very much fo=
r the quick support.<br><br>Best regards,<br>Ronny<br><br><div class=3D"gma=
il_quote">On Mon, Sep 20, 2010 at 9:54 AM, Philippe Gerum <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span> wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On Mon, 2010-09-20 at 09:42 +0200, Gilles Chanteperdrix wr=
ote:<br>

&gt; Philippe Gerum wrote:<br>
&gt; &gt; On Sun, 2010-09-19 at 16:04 +0100, ronny meeus wrote:<br>
&gt; &gt;&gt; Hello<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;m using xenomai in a qemu setup.<br>
&gt; &gt;&gt; My final goal is to use xenomai to port extisting pSOS applic=
ation to<br>
&gt; &gt;&gt; the linux platform.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The first step I did was building a kernel with the pSOS skin=
 enabled.<br>
&gt; &gt;&gt; These traces are generated at kernel startup:<br>
&gt; &gt;&gt; [ =A0 =A00.212363] I-pipe: Domain Xenomai registered.<br>
&gt; &gt;&gt; [ =A0 =A00.212363] Xenomai: hal/i386 started.<br>
&gt; &gt;&gt; [ =A0 =A00.212363] Xenomai: scheduling class idle registered.=
<br>
&gt; &gt;&gt; [ =A0 =A00.212363] Xenomai: scheduling class rt registered.<b=
r>
&gt; &gt;&gt; [ =A0 =A00.246987] Xenomai: real-time nucleus v2.5.4 (Sleep W=
alk) loaded.<br>
&gt; &gt;&gt; [ =A0 =A00.246987] Xenomai: debug mode enabled.<br>
&gt; &gt;&gt; [ =A0 =A00.274658] Xenomai: starting native API services.<br>
&gt; &gt;&gt; [ =A0 =A00.274658] Xenomai: starting POSIX services.<br>
&gt; &gt;&gt; [ =A0 =A00.296357] Xenomai: starting RTDM services.<br>
&gt; &gt;&gt; [ =A0 =A00.296357] Xenomai: registered exported object RN#0 (=
regions)<br>
&gt; &gt;&gt; [ =A0 =A00.296357] Xenomai: starting pSOS+ services.<br>
&gt; &gt;&gt; [ =A0 =A00.305601] HugeTLB registered 4 MB page size, pre-all=
ocated 0<br>
&gt; &gt;&gt; pages<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This is the example application:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; #include &lt;psos+/psos.h&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; void task2_func(u_long a,u_long b,u_long c,u_long d)<br>
&gt; &gt;&gt; {<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 while (1) {<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tm_wkafter(1000);<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 }<br>
&gt; &gt;&gt; }<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; int main(int argc, char **argv)<br>
&gt; &gt;&gt; {<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 unsigned long tid;<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 unsigned long args[4] =3D {0,0,0,0};<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 t_create(&quot;TEST&quot;,10,160000,160000,0,=
&amp;tid);<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 t_start(tid,0,task2_func,args);<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 while (1) {<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep(100);<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 }<br>
&gt; &gt;&gt; }<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m unsure whether the code above is actually the one which i=
ssues the<br>
&gt; &gt; output mentioned below. I see no t_shadow call, and no status pri=
ntout<br>
&gt; &gt; there.<br>
&gt;<br>
&gt; Maybe the auto-shadowing of the main thread?<br>
&gt;<br>
<br>
</div></div>Correct. I did not recall we had auto-shadowing in place for pS=
OS<br>
actually.<br>
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016e6dee732abfb010490b55592--

