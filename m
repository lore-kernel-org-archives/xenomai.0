MIME-Version: 1.0
From: apittaluga@domain.hid
Date: Thu, 21 Jun 2007 16:27:35 +0200
Message-ID: <OF312C1866.8B15815B-ONC1257301.004EC26C-C1257301.004F6E2A@aeronautica.alenia.it>
Content-Type: multipart/mixed;
	boundary="=_mixed 004F6E24C1257301_="
Subject: [Xenomai-help] Rif: Re:  xeno-2.3.1 shared interrups BUG? SOLVED!
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
Cc: Xenomai <xenomai@xenomai.org>, apittaluga@domain.hid

--=_mixed 004F6E24C1257301_=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Content-Type: text/html;
	charset=ISO-8859-1

<FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D2><FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" s=
ize=3D2><DIV>OK! It's working perfectly, now. (xeno 2.3.1 and the attached =
patch)</DIV><DIV>Thank you very much for your quick help.</DIV><DIV>&nbsp;<=
/DIV><DIV>By the way, I have attached your patch in a text format, so any o=
ther user can use it without the need to edit the mail-inside one (tabs wer=
e lost...)</DIV><DIV>&nbsp;</DIV><DIV>Thanks,<BR></DIV><DIV>Alessandro Pitt=
aluga <BR><BR>Alenia Aeronautica <BR>Avionic System Qualification <BR>Test =
Systems <BR>Corso Marche, 41 <BR>10146 Torino (Italy) <BR>Phone +39-011-756=
.2915 <BR>+39-011-996.0714 <BR>Fax +39-011-756.2517 <BR><DIV><BR></DIV><FON=
T color=3D#990099>-----jan.kiszka@domain.hid ha scritto: ----- <BR><BR></FONT><=
BLOCKQUOTE style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px=
; BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">Per: apittaluga@domain.hid=
utica.alenia.it <BR>Da: Jan Kiszka &lt;jan.kiszka@domain.hid&gt; <BR>Inviato da=
: jan.kiszka@domain.hid <BR>Data: 21/06/2007 00.10 <BR>Cc: Dmitry Adamushko &lt=
;dmitry.adamushko@domain.hid&gt;, Xenomai &lt;xenomai@xenomai.org&gt; <BR>O=
ggetto: Re: [Xenomai-help] xeno-2.3.1 shared interrups BUG? <BR><BR><FONT f=
ace=3Dmonospace size=3D2>apittaluga@domain.hid wrote: <BR>&gt; H=
i, <BR>&gt; running a simple test application which spawns a periodic task =
writing on a <BR>&gt; serial interface <BR>&gt; the system hangs performing=
 the rt=5Fdev=5Fclose. <BR>&gt; The test program ran fine with xeno 2.2.6 w=
ith "Shared Interrupts" enabled, <BR>&gt; so as with <BR>&gt; xeno 2.3.1 wi=
th "Shared Interrupts" disabled. It fails with xeno 2.3.1 with <BR>&gt; "Sh=
ared Interrupts" enabled, so the problem seems to be in the shared <BR>&gt;=
 interrupts handling area. <BR>&gt; kernel is 2.6.20 adeos patched <BR>&gt;=
 <BR>&gt; Any suggestion? <BR><BR>OK, the commission came to the conclusion=
 that we may have a solution: <BR><BR>Could you please test this patch <BR>=
<BR>&nbsp; &nbsp; <A href=3D"https://mail.gna.org/public/xenomai-core/2007-=
06/msg00091.html" target=3Dblank>https://mail.gna.org/public/xenomai-core/2=
007-06/msg00091.html </A><BR><BR>and report the result to us? Oh... wait...=
 you are on 2.3.1. Then use the <BR>patch below. Applies against 2.3.x-SVN,=
 but should work with the release <BR>as well. <BR><BR>Thanks, <BR>Jan <BR>=
<BR><BR>--- <BR>ksrc/nucleus/intr.c | &nbsp; 68 ++++++++++++++++-----------=
------------------------- <BR>1 file changed, 21 insertions(+), 47 deletion=
s(-) <BR><BR>Index: xenomai-2.3.x/ksrc/nucleus/intr.c <BR>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   <BR>--- xenomai-2.3.x.orig/ksrc/nucl=
eus/intr.c <BR>+++ xenomai-2.3.x/ksrc/nucleus/intr.c <BR>@@ -145,39 +145,13=
 @@ typedef struct xnintr=5Fshirq { <BR><SPAN style=3D"VISIBILITY: hidden">=
&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnintr=5Ft *handlers; <BR><SPAN style=3D"VI=
SIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>int unhandled; <BR>#ifdef=
 CONFIG=5FSMP <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&n=
bsp; </SPAN>atomic=5Fcounter=5Ft active; <BR>+ <SPAN style=3D"VISIBILITY: h=
idden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnlock=5Ft lock; <BR>#endif <BR><BR>=
} xnintr=5Fshirq=5Ft; <BR><BR>static xnintr=5Fshirq=5Ft xnshirqs[RTHAL=5FNR=
=5FIRQS]; <BR><BR>-static inline void xnintr=5Fshirq=5Flock(xnintr=5Fshirq=
=5Ft *shirq) <BR>-{ <BR>-#ifdef CONFIG=5FSMP <BR>- <SPAN style=3D"VISIBILIT=
Y: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnarch=5Fatomic=5Finc(&amp;shirq=
-&gt;active); <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&n=
bsp; </SPAN>xnarch=5Fmemory=5Fbarrier(); <BR>-#endif <BR>-} <BR>- <BR>-stat=
ic inline void xnintr=5Fshirq=5Funlock(xnintr=5Fshirq=5Ft *shirq) <BR>-{ <B=
R>-#ifdef CONFIG=5FSMP <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp=
;&nbsp;&nbsp; </SPAN>xnarch=5Fmemory=5Fbarrier(); <BR>- <SPAN style=3D"VISI=
BILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnarch=5Fatomic=5Fdec(&amp;=
shirq-&gt;active); <BR>-#endif <BR>-} <BR>- <BR>-void xnintr=5Fsynchronize(=
xnintr=5Ft *intr) <BR>-{ <BR>-#ifdef CONFIG=5FSMP <BR>- <SPAN style=3D"VISI=
BILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnintr=5Fshirq=5Ft *shirq =
=3D &amp;xnshirqs[intr-&gt;irq]; <BR>- <BR>- <SPAN style=3D"VISIBILITY: hid=
den">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>while (xnarch=5Fatomic=5Fget(&amp;shir=
q-&gt;active)) <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&=
nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </=
SPAN>cpu=5Frelax(); <BR>-#endif <BR>-} <BR>- <BR>#if defined(CONFIG=5FXENO=
=5FOPT=5FSHIRQ=5FLEVEL) <BR>/* <BR>&nbsp;* Low-level interrupt handler disp=
atching the user-defined ISRs for <BR>@@ -201,7 +175,7 @@ static void xnint=
r=5Fshirq=5Fhandler(unsigne <BR><BR><SPAN style=3D"VISIBILITY: hidden">&nbs=
p;&nbsp;&nbsp;&nbsp; </SPAN>++sched-&gt;inesting; <BR><BR>- <SPAN style=3D"=
VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnintr=5Fshirq=5Flock(s=
hirq); <BR>+ <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </=
SPAN>xnlock=5Fget(&amp;shirq-&gt;lock); <BR><SPAN style=3D"VISIBILITY: hidd=
en">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>intr =3D shirq-&gt;handlers; <BR><BR><S=
PAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>while (int=
r) { <BR>@@ -222,7 +196,7 @@ static void xnintr=5Fshirq=5Fhandler(unsigne <=
BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN=
 style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>intr =3D intr=
-&gt;next; <BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>} <BR><BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nb=
sp; </SPAN>xnintr=5Fshirq=5Funlock(shirq); <BR>+ <SPAN style=3D"VISIBILITY:=
 hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnlock=5Fput(&amp;shirq-&gt;lock);=
 <BR><BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN=
>if (unlikely(s =3D=3D   XN=5FISR=5FNONE)) { <BR><SPAN style=3D"VISIBILITY:=
 hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden"=
>&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>if (++shirq-&gt;unhandled =3D=3D XNINTR=5F=
MAX=5FUNHANDLED) { <BR>@@ -272,7 +246,7 @@ static void xnintr=5Fedge=5Fshir=
q=5Fhandler(un <BR><BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp=
;&nbsp; </SPAN>++sched-&gt;inesting; <BR><BR>- <SPAN style=3D"VISIBILITY: h=
idden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnintr=5Fshirq=5Flock(shirq); <BR>+ =
<SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnlock=
=5Fget(&amp;shirq-&gt;lock); <BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&=
nbsp;&nbsp;&nbsp; </SPAN>intr =3D shirq-&gt;handlers; <BR><BR><SPAN style=
=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>while (intr !=3D en=
d) { <BR>@@ -303,7 +277,7 @@ static void xnintr=5Fedge=5Fshirq=5Fhandler(un=
 <BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SP=
AN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN style=
=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>intr =3D shirq-&gt;=
handlers; <BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; <=
/SPAN>} <BR><BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbs=
p; </SPAN>xnintr=5Fshirq=5Funlock(shirq); <BR>+ <SPAN style=3D"VISIBILITY: =
hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnlock=5Fput(&amp;shirq-&gt;lock); =
<BR><BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
if (counter &gt; MAX=5FEDGEIRQ=5FCOUNTER) <BR><SPAN style=3D"VISIBILITY: hi=
dden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&n=
bsp;&nbsp;&nbsp;&nbsp; </SPAN>xnlogerr <BR>@@ -386,9 +360,12 @@ static inli=
ne int xnintr=5Firq=5Fattach(xnin <BR><BR><SPAN style=3D"VISIBILITY: hidden=
">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=5F=5Fsetbits(intr-&gt;flags, XN=5FISR=5F=
ATTACHED); <BR><BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&=
nbsp; </SPAN>/* Add a given interrupt object. */ <BR><SPAN style=3D"VISIBIL=
ITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>intr-&gt;next =3D NULL; <BR>+ =
<BR>+ <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>/*=
 Add a given interrupt object. */ <BR>+ <SPAN style=3D"VISIBILITY: hidden">=
&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnlock=5Fget(&amp;shirq-&gt;lock); <BR><SPA=
N style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>*p =3D intr;=
 <BR>+ <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>x=
nlock=5Fput(&amp;shirq-&gt;lock); <BR><BR><SPAN style=3D"VISIBILITY: hidden=
">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>return 0; <BR>} <BR>@@ -409,8 +386,10 @@ =
static inline int xnintr=5Firq=5Fdetach(xnin <BR><BR><SPAN style=3D"VISIBIL=
ITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>while ((e =3D *p) !=3D NULL) {=
 <BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SP=
AN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>if (e =3D=
=3D intr) { <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbs=
p; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPA=
N><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>/* Rem=
ove a given interrupt object from the list. */ <BR>+ <SPAN style=3D"VISIBIL=
ITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hid=
den">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nb=
sp;&nbsp;&nbsp;&nbsp; </SPAN>/* Remove the given interrupt object from the =
list. */ <BR>+ <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><=
SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnlock=5F=
get(&amp;shirq-&gt;lock); <BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbs=
p;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;=
&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; <=
/SPAN>*p =3D e-&gt;next; <BR>+ <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nb=
sp;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp=
;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>xnlock=5Fput(&amp;shirq-&gt;lock); <BR><BR><SPAN style=3D"VISIBILITY=
: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden=
">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;=
&nbsp;&nbsp;&nbsp; </SPAN>/* Release the IRQ line if this was the last user=
 */ <BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>=
<SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN st=
yle=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>if (shirq-&gt;ha=
ndlers =3D=3D NULL) <BR>@@ -429,12 +408,8 @@ static inline int xnintr=5Firq=
=5Fdetach(xnin <BR>int xnintr=5Fmount(void) <BR>{ <BR><SPAN style=3D"VISIBI=
LITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>int i; <BR>- <SPAN style=3D"V=
ISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>for (i =3D 0; i &lt; RTH=
AL=5FNR=5FIRQS; ++i) { <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp=
;&nbsp;&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&=
nbsp; </SPAN>xnshirqs[i].handlers =3D  NULL; <BR>-#ifdef CONFIG=5FSMP <BR>-=
 <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN s=
tyle=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnarch=5Fatomic=
=5Fset(&amp;xnshirqs[i].active, 0); <BR>-#endif <BR>- <SPAN style=3D"VISIBI=
LITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>} <BR>+ <SPAN style=3D"VISIBI=
LITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>for (i =3D 0; i &lt; RTHAL=5F=
NR=5FIRQS; ++i) <BR>+ <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;=
&nbsp; </SPAN><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; <=
/SPAN>xnlock=5Finit(&amp;xnshirqs[i].lock); <BR><SPAN style=3D"VISIBILITY: =
hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>return 0; <BR>} <BR><BR>@@ -450,7 +=
425,6 @@ static inline int xnintr=5Firq=5Fdetach(xnin <BR><SPAN style=3D"VI=
SIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>return xnarch=5Frelease=
=5Firq(intr-&gt;irq); <BR>} <BR><BR>-void xnintr=5Fsynchronize(xnintr=5Ft *=
intr) {} <BR>int xnintr=5Fmount(void) { return 0; } <BR><BR>#endif /* CONFI=
G=5FXENO=5FOPT=5FSHIRQ=5FLEVEL || CONFIG=5FXENO=5FOPT=5FSHIRQ=5FEDGE */ <BR=
>@@ -626,6 +600,9 @@ int xnintr=5Fdestroy(xnintr=5Ft *intr) <BR>&nbsp;* a l=
ow-level error occurred while attaching the interrupt. -EBUSY is <BR>&nbsp;=
* specifically returned if the interrupt object was already attached. <BR>&=
nbsp;* <BR>+ * @note The caller <B>must not </B>hold nklock when invoking t=
his service, <BR>+ * this would cause deadlocks. <BR>+ * <BR>&nbsp;* Enviro=
nments: <BR>&nbsp;* <BR>&nbsp;* This service can be called from: <BR>@@ -65=
4,7 +631,7 @@ int xnintr=5Fattach(xnintr=5Ft *intr, void * <BR><BR><SPAN st=
yle=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>if (!err) <BR><S=
PAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN><SPAN styl=
e=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnintr=5Fstat=5Fco=
unter=5Finc(); <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&=
nbsp; </SPAN><BR>+ <BR><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp=
;&nbsp; </SPAN>xnlock=5Fput=5Firqrestore(&amp;intrlock, s); <BR><BR><SPAN s=
tyle=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>return err; <BR=
>@@ -678,6 +655,9 @@ int xnintr=5Fattach(xnintr=5Ft *intr, void * <BR>&nbsp=
;* a non-attached interrupt object leads to a null-effect and returns <BR>&=
nbsp;* 0. <BR>&nbsp;* <BR>+ * @note The caller <B>must not </B>hold nklock =
when invoking this service, <BR>+ * this would cause deadlocks. <BR>+ * <BR=
>&nbsp;* Environments: <BR>&nbsp;* <BR>&nbsp;* This service can be called f=
rom: <BR>@@ -703,12 +683,6 @@ int xnintr=5Fdetach(xnintr=5Ft *intr) <BR><BR=
><SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>xnlock=
=5Fput=5Firqrestore(&amp;intrlock, s); <BR><BR>- <SPAN style=3D"VISIBILITY:=
 hidden">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>/* The idea here is to keep a deta=
ched interrupt object valid as long <BR>- <SPAN style=3D"VISIBILITY: hidden=
">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>&nbsp; as the corresponding irq handler i=
s running. This is one of the <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbs=
p;&nbsp;&nbsp;&nbsp; </SPAN>&nbsp; requirements to iterate over the xnintr=
=5Fshirq=5Ft::handlers list in <BR>- <SPAN style=3D"VISIBILITY: hidden">&nb=
sp;&nbsp;&nbsp;&nbsp; </SPAN>&nbsp; xnintr=5Firq=5Fhandler() in a lockless =
way. */ <BR>- <SPAN style=3D"VISIBILITY: hidden">&nbsp;&nbsp;&nbsp;&nbsp; <=
/SPAN>xnintr=5Fsynchronize(intr); <BR>- <BR><SPAN style=3D"VISIBILITY: hidd=
en">&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>return err; <BR>} <BR><BR><BR></FONT></=
BLOCKQUOTE><BR></DIV></FONT></FONT>----------------------------------------=
---------------------------------------------------------------------------=
----------------------------------------------<br />Questa comunicazione co=
ntiene informazioni confidenziali ed =E8 riservata esclusivamente ai destin=
atari. <br />Se ritenete di averla ricevuta per errore o di non essere il c=
orretto destinatario&#44; siete pregati di eliminare <br />il messaggio sen=
za stamparlo&#44; copiarlo&#44; distribuirlo o usare questa informazione in=
 alcun modo&#44; e di <br />notificare l'errore al mittente.<br />     <br =
/>   <br />This communication contains confidential information and is inte=
nded for the named recipient(s) only. <br />If you believe that you have re=
ceived it in error or that you are not the intended recipient&#44; do not p=
rint&#44;<br />copy&#44; disseminate or use this information in any way&#44=
; and notify this error to the sender.<br />
--=_mixed 004F6E24C1257301_=
Content-Type: application/octet-stream; name="xeno-2.3.1-sh_int.patch"
Content-Disposition: attachment; filename="xeno-2.3.1-sh_int.patch"
Content-Transfer-Encoding: base64

LS0tIHhlbm9tYWktMi4zLngub3JpZy9rc3JjL251Y2xldXMvaW50ci5jCisrKyB4ZW5vbWFpLTIu
My54L2tzcmMvbnVjbGV1cy9pbnRyLmMKQEAgLTE0NSwzOSArMTQ1LDEzIEBAIHR5cGVkZWYgc3Ry
dWN0IHhuaW50cl9zaGlycSB7CiAJeG5pbnRyX3QgKmhhbmRsZXJzOwogCWludCB1bmhhbmRsZWQ7
CiAjaWZkZWYgQ09ORklHX1NNUAotCWF0b21pY19jb3VudGVyX3QgYWN0aXZlOworCXhubG9ja190
IGxvY2s7CiAjZW5kaWYKIAogfSB4bmludHJfc2hpcnFfdDsKIAogc3RhdGljIHhuaW50cl9zaGly
cV90IHhuc2hpcnFzW1JUSEFMX05SX0lSUVNdOwogCi1zdGF0aWMgaW5saW5lIHZvaWQgeG5pbnRy
X3NoaXJxX2xvY2soeG5pbnRyX3NoaXJxX3QgKnNoaXJxKQotewotI2lmZGVmIENPTkZJR19TTVAK
LQl4bmFyY2hfYXRvbWljX2luYygmc2hpcnEtPmFjdGl2ZSk7Ci0JeG5hcmNoX21lbW9yeV9iYXJy
aWVyKCk7Ci0jZW5kaWYKLX0KLQotc3RhdGljIGlubGluZSB2b2lkIHhuaW50cl9zaGlycV91bmxv
Y2soeG5pbnRyX3NoaXJxX3QgKnNoaXJxKQotewotI2lmZGVmIENPTkZJR19TTVAKLQl4bmFyY2hf
bWVtb3J5X2JhcnJpZXIoKTsKLQl4bmFyY2hfYXRvbWljX2RlYygmc2hpcnEtPmFjdGl2ZSk7Ci0j
ZW5kaWYKLX0KLQotdm9pZCB4bmludHJfc3luY2hyb25pemUoeG5pbnRyX3QgKmludHIpCi17Ci0j
aWZkZWYgQ09ORklHX1NNUAotCXhuaW50cl9zaGlycV90ICpzaGlycSA9ICZ4bnNoaXJxc1tpbnRy
LT5pcnFdOwotCi0Jd2hpbGUgKHhuYXJjaF9hdG9taWNfZ2V0KCZzaGlycS0+YWN0aXZlKSkKLQkJ
Y3B1X3JlbGF4KCk7Ci0jZW5kaWYKLX0KLQogI2lmIGRlZmluZWQoQ09ORklHX1hFTk9fT1BUX1NI
SVJRX0xFVkVMKQogLyoKICAqIExvdy1sZXZlbCBpbnRlcnJ1cHQgaGFuZGxlciBkaXNwYXRjaGlu
ZyB0aGUgdXNlci1kZWZpbmVkIElTUnMgZm9yCkBAIC0yMDEsNyArMTc1LDcgQEAgc3RhdGljIHZv
aWQgeG5pbnRyX3NoaXJxX2hhbmRsZXIodW5zaWduZQogCiAJKytzY2hlZC0+aW5lc3Rpbmc7CiAK
LQl4bmludHJfc2hpcnFfbG9jayhzaGlycSk7CisJeG5sb2NrX2dldCgmc2hpcnEtPmxvY2spOwog
CWludHIgPSBzaGlycS0+aGFuZGxlcnM7CiAKIAl3aGlsZSAoaW50cikgewpAQCAtMjIyLDcgKzE5
Niw3IEBAIHN0YXRpYyB2b2lkIHhuaW50cl9zaGlycV9oYW5kbGVyKHVuc2lnbmUKIAkJaW50ciA9
IGludHItPm5leHQ7CiAJfQogCi0JeG5pbnRyX3NoaXJxX3VubG9jayhzaGlycSk7CisJeG5sb2Nr
X3B1dCgmc2hpcnEtPmxvY2spOwogCiAJaWYgKHVubGlrZWx5KHMgPT0gWE5fSVNSX05PTkUpKSB7
CiAJCWlmICgrK3NoaXJxLT51bmhhbmRsZWQgPT0gWE5JTlRSX01BWF9VTkhBTkRMRUQpIHsKQEAg
LTI3Miw3ICsyNDYsNyBAQCBzdGF0aWMgdm9pZCB4bmludHJfZWRnZV9zaGlycV9oYW5kbGVyKHVu
CiAKIAkrK3NjaGVkLT5pbmVzdGluZzsKIAotCXhuaW50cl9zaGlycV9sb2NrKHNoaXJxKTsKKwl4
bmxvY2tfZ2V0KCZzaGlycS0+bG9jayk7CiAJaW50ciA9IHNoaXJxLT5oYW5kbGVyczsKIAogCXdo
aWxlIChpbnRyICE9IGVuZCkgewpAQCAtMzAzLDcgKzI3Nyw3IEBAIHN0YXRpYyB2b2lkIHhuaW50
cl9lZGdlX3NoaXJxX2hhbmRsZXIodW4KIAkJCWludHIgPSBzaGlycS0+aGFuZGxlcnM7CiAJfQog
Ci0JeG5pbnRyX3NoaXJxX3VubG9jayhzaGlycSk7CisJeG5sb2NrX3B1dCgmc2hpcnEtPmxvY2sp
OwogCiAJaWYgKGNvdW50ZXIgPiBNQVhfRURHRUlSUV9DT1VOVEVSKQogCQl4bmxvZ2VycgpAQCAt
Mzg2LDkgKzM2MCwxMiBAQCBzdGF0aWMgaW5saW5lIGludCB4bmludHJfaXJxX2F0dGFjaCh4bmlu
CiAKIAlfX3NldGJpdHMoaW50ci0+ZmxhZ3MsIFhOX0lTUl9BVFRBQ0hFRCk7CiAKLQkvKiBBZGQg
YSBnaXZlbiBpbnRlcnJ1cHQgb2JqZWN0LiAqLwogCWludHItPm5leHQgPSBOVUxMOworCisJLyog
QWRkIGEgZ2l2ZW4gaW50ZXJydXB0IG9iamVjdC4gKi8KKwl4bmxvY2tfZ2V0KCZzaGlycS0+bG9j
ayk7CiAJKnAgPSBpbnRyOworCXhubG9ja19wdXQoJnNoaXJxLT5sb2NrKTsKIAogCXJldHVybiAw
OwogfQpAQCAtNDA5LDggKzM4NiwxMCBAQCBzdGF0aWMgaW5saW5lIGludCB4bmludHJfaXJxX2Rl
dGFjaCh4bmluCiAKIAl3aGlsZSAoKGUgPSAqcCkgIT0gTlVMTCkgewogCQlpZiAoZSA9PSBpbnRy
KSB7Ci0JCQkvKiBSZW1vdmUgYSBnaXZlbiBpbnRlcnJ1cHQgb2JqZWN0IGZyb20gdGhlIGxpc3Qu
ICovCisJCQkvKiBSZW1vdmUgdGhlIGdpdmVuIGludGVycnVwdCBvYmplY3QgZnJvbSB0aGUgbGlz
dC4gKi8KKwkJCXhubG9ja19nZXQoJnNoaXJxLT5sb2NrKTsKIAkJCSpwID0gZS0+bmV4dDsKKwkJ
CXhubG9ja19wdXQoJnNoaXJxLT5sb2NrKTsKIAogCQkJLyogUmVsZWFzZSB0aGUgSVJRIGxpbmUg
aWYgdGhpcyB3YXMgdGhlIGxhc3QgdXNlciAqLwogCQkJaWYgKHNoaXJxLT5oYW5kbGVycyA9PSBO
VUxMKQpAQCAtNDI5LDEyICs0MDgsOCBAQCBzdGF0aWMgaW5saW5lIGludCB4bmludHJfaXJxX2Rl
dGFjaCh4bmluCiBpbnQgeG5pbnRyX21vdW50KHZvaWQpCiB7CiAJaW50IGk7Ci0JZm9yIChpID0g
MDsgaSA8IFJUSEFMX05SX0lSUVM7ICsraSkgewotCQl4bnNoaXJxc1tpXS5oYW5kbGVycyA9IE5V
TEw7Ci0jaWZkZWYgQ09ORklHX1NNUAotCQl4bmFyY2hfYXRvbWljX3NldCgmeG5zaGlycXNbaV0u
YWN0aXZlLCAwKTsKLSNlbmRpZgotCX0KKwlmb3IgKGkgPSAwOyBpIDwgUlRIQUxfTlJfSVJRUzsg
KytpKQorCQl4bmxvY2tfaW5pdCgmeG5zaGlycXNbaV0ubG9jayk7CiAJcmV0dXJuIDA7CiB9CiAK
QEAgLTQ1MCw3ICs0MjUsNiBAQCBzdGF0aWMgaW5saW5lIGludCB4bmludHJfaXJxX2RldGFjaCh4
bmluCiAJcmV0dXJuIHhuYXJjaF9yZWxlYXNlX2lycShpbnRyLT5pcnEpOwogfQogCi12b2lkIHhu
aW50cl9zeW5jaHJvbml6ZSh4bmludHJfdCAqaW50cikge30KIGludCB4bmludHJfbW91bnQodm9p
ZCkgeyByZXR1cm4gMDsgfQogCiAjZW5kaWYgLyogQ09ORklHX1hFTk9fT1BUX1NISVJRX0xFVkVM
IHx8IENPTkZJR19YRU5PX09QVF9TSElSUV9FREdFICovCkBAIC02MjYsNiArNjAwLDkgQEAgaW50
IHhuaW50cl9kZXN0cm95KHhuaW50cl90ICppbnRyKQogICogYSBsb3ctbGV2ZWwgZXJyb3Igb2Nj
dXJyZWQgd2hpbGUgYXR0YWNoaW5nIHRoZSBpbnRlcnJ1cHQuIC1FQlVTWSBpcwogICogc3BlY2lm
aWNhbGx5IHJldHVybmVkIGlmIHRoZSBpbnRlcnJ1cHQgb2JqZWN0IHdhcyBhbHJlYWR5IGF0dGFj
aGVkLgogICoKKyAqIEBub3RlIFRoZSBjYWxsZXIgPGI+bXVzdCBub3Q8L2I+IGhvbGQgbmtsb2Nr
IHdoZW4gaW52b2tpbmcgdGhpcyBzZXJ2aWNlLAorICogdGhpcyB3b3VsZCBjYXVzZSBkZWFkbG9j
a3MuCisgKgogICogRW52aXJvbm1lbnRzOgogICoKICAqIFRoaXMgc2VydmljZSBjYW4gYmUgY2Fs
bGVkIGZyb206CkBAIC02NTQsNyArNjMxLDcgQEAgaW50IHhuaW50cl9hdHRhY2goeG5pbnRyX3Qg
KmludHIsIHZvaWQgKgogCiAJaWYgKCFlcnIpCiAJCXhuaW50cl9zdGF0X2NvdW50ZXJfaW5jKCk7
Ci0JCisKIAl4bmxvY2tfcHV0X2lycXJlc3RvcmUoJmludHJsb2NrLCBzKTsKIAogCXJldHVybiBl
cnI7CkBAIC02NzgsNiArNjU1LDkgQEAgaW50IHhuaW50cl9hdHRhY2goeG5pbnRyX3QgKmludHIs
IHZvaWQgKgogICogYSBub24tYXR0YWNoZWQgaW50ZXJydXB0IG9iamVjdCBsZWFkcyB0byBhIG51
bGwtZWZmZWN0IGFuZCByZXR1cm5zCiAgKiAwLgogICoKKyAqIEBub3RlIFRoZSBjYWxsZXIgPGI+
bXVzdCBub3Q8L2I+IGhvbGQgbmtsb2NrIHdoZW4gaW52b2tpbmcgdGhpcyBzZXJ2aWNlLAorICog
dGhpcyB3b3VsZCBjYXVzZSBkZWFkbG9ja3MuCisgKgogICogRW52aXJvbm1lbnRzOgogICoKICAq
IFRoaXMgc2VydmljZSBjYW4gYmUgY2FsbGVkIGZyb206CkBAIC03MDMsMTIgKzY4Myw2IEBAIGlu
dCB4bmludHJfZGV0YWNoKHhuaW50cl90ICppbnRyKQogCiAJeG5sb2NrX3B1dF9pcnFyZXN0b3Jl
KCZpbnRybG9jaywgcyk7CiAKLQkvKiBUaGUgaWRlYSBoZXJlIGlzIHRvIGtlZXAgYSBkZXRhY2hl
ZCBpbnRlcnJ1cHQgb2JqZWN0IHZhbGlkIGFzIGxvbmcKLQkgICBhcyB0aGUgY29ycmVzcG9uZGlu
ZyBpcnEgaGFuZGxlciBpcyBydW5uaW5nLiBUaGlzIGlzIG9uZSBvZiB0aGUKLQkgICByZXF1aXJl
bWVudHMgdG8gaXRlcmF0ZSBvdmVyIHRoZSB4bmludHJfc2hpcnFfdDo6aGFuZGxlcnMgbGlzdCBp
bgotCSAgIHhuaW50cl9pcnFfaGFuZGxlcigpIGluIGEgbG9ja2xlc3Mgd2F5LiAqLwotCXhuaW50
cl9zeW5jaHJvbml6ZShpbnRyKTsKLQogCXJldHVybiBlcnI7CiB9Cg==


--=_mixed 004F6E24C1257301_=--


