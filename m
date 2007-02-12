Message-ID: <b131c9f0702120843m23ea22b6jaf0fa4aa3dd77bbc@domain.hid>
Date: Mon, 12 Feb 2007 18:43:55 +0200
From: "vikesh rambaran" <vikesh.rambaran@domain.hid>
Subject: Re: [Xenomai-help] Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE
	disabled
In-Reply-To: <45D093DF.1060600@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_31419_32252871.1171298635438"
References: <b131c9f0702120811l64e300dbu7819f7254bdc6aa0@domain.hid>
	<45D093DF.1060600@domain.hid>
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

------=_Part_31419_32252871.1171298635438
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2/12/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> vikesh rambaran wrote:
> > Hi there
> >
> > I'm using ubuntu 6.06 LTS.
> > I patched a 2.6.19.1 vanilla kernel with xenomai 2.3.0 adeos
> > (Processor type is Pentuim III)
> > The realtime section has been left at the default settings.
> >
> > The kernel compiles and boots ok.
> >
> > Userspace Xenomai has been compiled with the --disable-x86-tsc option
> >
> > When i try to run the latency test, i get the following error
> >
> > Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled
> > (modprobe xeno_native?)
> >
> > The kernel .config file shows that the native skin is supposed to be
> > compiled
> > into the kernel and CONFIG_SENO_OPT_PERVASIVE=y
> >
> > Any help to solve this problem would be appreciated
>
> I bet you are still running your old kernel...
>
> Anyway, check the boot messages and the content of /proc/xenomai,
> specifically .../interfaces.
>
> Jan


Hi
Thanx for the reply

uname -al shows that the kernel is the patched kernel (2.6.19.1). Ubuntu's
kernel is 2.6.15
Xenomai is failing to load because of the APIC

Passing lapic=1 as a boot parameter causes a kernel panic

Going to try recompiling with APIC disabled (if it is)

Keep well
Vicki

------=_Part_31419_32252871.1171298635438
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2/12/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
vikesh rambaran wrote:<br>&gt; Hi there<br>&gt;<br>&gt; I&#39;m using ubuntu 6.06 LTS.<br>&gt; I patched a <a href="http://2.6.19.1">2.6.19.1</a> vanilla kernel with xenomai 2.3.0 adeos<br>&gt; (Processor type is Pentuim III)
<br>&gt; The realtime section has been left at the default settings.<br>&gt;<br>&gt; The kernel compiles and boots ok.<br>&gt;<br>&gt; Userspace Xenomai has been compiled with the --disable-x86-tsc option<br>&gt;<br>&gt; When i try to run the latency test, i get the following error
<br>&gt;<br>&gt; Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled<br>&gt; (modprobe xeno_native?)<br>&gt;<br>&gt; The kernel .config file shows that the native skin is supposed to be<br>&gt; compiled<br>&gt; into the kernel and CONFIG_SENO_OPT_PERVASIVE=y
<br>&gt;<br>&gt; Any help to solve this problem would be appreciated<br><br>I bet you are still running your old kernel...<br><br>Anyway, check the boot messages and the content of /proc/xenomai,<br>specifically .../interfaces.
<br><br>Jan</blockquote><div><br>
Hi<br>

Thanx for the reply<br>

<br>

uname -al shows that the kernel is the patched kernel (<a href="http://2.6.19.1">2.6.19.1</a>). Ubuntu&#39;s kernel is 2.6.15<br>

Xenomai is failing to load because of the APIC<br>

<br>

Passing lapic=1 as a boot parameter causes a kernel panic<br>

<br>

Going to try recompiling with APIC disabled (if it is)<br>

<br>

Keep well<br>

Vicki<br>
&nbsp;</div><br></div><br>

------=_Part_31419_32252871.1171298635438--

