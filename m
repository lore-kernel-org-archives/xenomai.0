Message-ID: <7289437c0705280557k2dea8db6r7e4e162078a3c846@domain.hid>
Date: Mon, 28 May 2007 14:57:32 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <1180343533.6188.40.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_123263_3539110.1180357052980"
References: <7289437c0705280043o7b8eaf85hbbfad33b95c243fb@domain.hid>
	<1180342178.6188.37.camel@domain.hid> <465A9AD6.7040008@domain.hid>
	<1180343533.6188.40.camel@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
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

------=_Part_123263_3539110.1180357052980
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry for the details.
I work on an ARM and I use the cross compiler ELDK version 4.1 (build :
2007-01-22-uclibc).

When I compile sources of xenomai, I have this error message :


-Wl,shm_unlink -Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap
cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.a -lpthread
-lrt

../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In function
`__wrap_shm_open':

shm.c:(.text+0x74): undefined reference to `shm_open'

../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In function
`__wrap_shm_unlink':

shm.c:(.text+0xdc): undefined reference to `shm_unlink'

collect2: ld returned 1 exit status

make[3]: *** [cyclictest] Erreur 1

make[3]: Leaving directory `/usr/src/xenomai-2.3.1/src/testsuite/cyclic'

make[2]: *** [all-recursive] Erreur 1

make[2]: Leaving directory `/usr/src/xenomai-2.3.1/src/testsuite'

make[1]: *** [all-recursive] Erreur 1

make[1]: Leaving directory `/usr/src/xenomai-2.3.1/src'

make: *** [all-recursive] Erreur 1


On 5/28/07, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Mon, 2007-05-28 at 11:03 +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> > > On Mon, 2007-05-28 at 09:43 +0200, Perrine Martignoni wrote:
> > >> And after when I want to compile a code with API Posix, the error
> > >>is :
> > >>API Posix not available
> > >>
> > >
> > >
> > > Xenomai does not output such messsage. Is this verbatim?
> > >
> >
> > I thik this message comes from xeno-config when it can not find
> > posix.wrappers. But it is normal that xeno-config does not find
> > posix.wrappers if installation failed.
> >
>
> Ok, so this is "POSIX support is not available" we should grep then, I
> guess. Indeed, the installation seems to be toast.
>
> --
> Philippe.
>
>
>

------=_Part_123263_3539110.1180357052980
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Sorry for the details.</div>
<div>I work on an ARM and I use the cross compiler ELDK version 4.1 (build : <span style="FONT-SIZE: 12pt; FONT-FAMILY: &#39;Nimbus Roman No9 L&#39;; mso-fareast-font-family: &#39;Luxi Sans&#39;; mso-bidi-font-family: &#39;Times New Roman&#39;; mso-fareast-language: #00FF; mso-ansi-language: FR; mso-bidi-language: AR-SA">
<font face="Times New Roman">2007-01-22-uclibc</font></span>).</div>
<div>&nbsp;</div>
<div>When I compile sources of xenomai, I have this error message : </div>
<div>&nbsp;</div>
<div>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">-Wl,shm_unlink -Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap cyclictest-cyclictest.o<span style="mso-spacerun: yes">&nbsp; </span>../../skins/posix/.libs/libpthread_rt.a -lpthread -lrt
</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In function `__wrap_shm_open&#39;:</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">shm.c:(.text+0x74): undefined reference to `shm_open&#39;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In function `__wrap_shm_unlink&#39;:</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">shm.c:(.text+0xdc): undefined reference to `shm_unlink&#39;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">collect2: ld returned 1 exit status</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">make[3]: *** [cyclictest] Erreur 1</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">make[3]: Leaving directory `/usr/src/xenomai-2.3.1/src/testsuite/cyclic&#39;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">make[2]: *** [all-recursive] Erreur 1</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">make[2]: Leaving directory `/usr/src/xenomai-2.3.1/src/testsuite&#39;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">make[1]: *** [all-recursive] Erreur 1</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">make[1]: Leaving directory `/usr/src/xenomai-2.3.1/src&#39;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">make: *** [all-recursive] Erreur 1</font></p></div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/28/07, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Mon, 2007-05-28 at 11:03 +0200, Gilles Chanteperdrix wrote:<br>&gt; Philippe Gerum wrote:<br>&gt; &gt; On Mon, 2007-05-28 at 09:43 +0200, Perrine Martignoni wrote:
<br>&gt; &gt;&gt; And after when I want to compile a code with API Posix, the error<br>&gt; &gt;&gt;is :<br>&gt; &gt;&gt;API Posix not available<br>&gt; &gt;&gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; Xenomai does not output such messsage. Is this verbatim?
<br>&gt; &gt;<br>&gt;<br>&gt; I thik this message comes from xeno-config when it can not find<br>&gt; posix.wrappers. But it is normal that xeno-config does not find<br>&gt; posix.wrappers if installation failed.<br>&gt;<br>
<br>Ok, so this is &quot;POSIX support is not available&quot; we should grep then, I<br>guess. Indeed, the installation seems to be toast.<br><br>--<br>Philippe.<br><br><br></blockquote></div><br>

------=_Part_123263_3539110.1180357052980--

