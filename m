MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4E70A876.3020009@domain.hid>
References: <CANKLDms-kVpt6hk7adH880tK5xJL2=D9Y=M25Cn-0hBDueuUfQ@mail.gmail.com>
	<4E70A876.3020009@domain.hid>
Date: Wed, 14 Sep 2011 10:00:38 -0500
Message-ID: <CAAvA3H--++6D4MhP-EOcdV7mW8Dwje+OzhxRYxeNaPJY0d4ffA@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307d02bee6100d04ace805b9
Subject: Re: [Xenomai-help] multicore: reserving core(s) for Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--20cf307d02bee6100d04ace805b9
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Sep 14, 2011 at 8:13 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 09/14/2011 02:18 PM, Henri Roosen wrote:
> [snip]
> >
> > What I would like to do is to run the Xenomai realtime threads on one
> > core of the multi-core CPU. And I would like to reserve this core only
> > for the Xenomai realtime threads.
> >
> [snip]
> The kernel has an "isolcpus" option, which allows to specify which cpus
> should not be used by Linux.
>
> See Documentation/kernel-parameters.txt in the linux kernel sources for
> an explanation.
>
>
I tried to do this a year ago with the kernel isolcpus option, but could not
get this to work:

>Gilles Chanteperdrix to Jeff, xenomai-help
>Jeff  wrote:
>> What is the best method for segregating Xenomai and Linux by CPU?  I was
>> unable to do this cleanly using /proc/xenomai/affinity for Xenomai,
>> together with the Linux isolcpus boot option.  Details below.
>
>I have no definite answer, I have not checked. What I suspect, however,
>is that when you try and force an affinity for a Xenomai thread, it
>tries and apply this affinity in secondary mode, i.e. as a plain Linux
>thread. So, will fail if the target thread is not in the "isolcpus"
>mask. In other words, a Xenomai thread can not run on a CPU where Linux
>threads can not run.

at the time my config was:
x86 32-bit arch
linux-2.6.34.5
Xenomai-2.5.4
adeos-ipipe-2.6.34.5-x86-2.7-03.patch

Has the Xenomai cpu affinity or Linux isolcpus implementation changed since
then?

Jeff

--20cf307d02bee6100d04ace805b9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">On Wed=
, Sep 14, 2011 at 8:13 AM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 09/14/2011 02:18 PM, H=
enri Roosen wrote:<br>
</div><div class=3D"im">[snip]<br>
&gt;<br>
&gt; What I would like to do is to run the Xenomai realtime threads on one<=
br>
&gt; core of the multi-core CPU. And I would like to reserve this core only=
<br>
&gt; for the Xenomai realtime threads.<br>
&gt;<br>[snip]
</div>The kernel has an &quot;isolcpus&quot; option, which allows to specif=
y which cpus<br>
should not be used by Linux.<br>
<br>
See Documentation/kernel-parameters.txt in the linux kernel sources for<br>
an explanation.<br><font class=3D"Apple-style-span" color=3D"#888888"><br><=
/font></blockquote><div><br></div><div>I tried to do this a year ago with t=
he kernel isolcpus option, but could not get this to work:</div><meta http-=
equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><div>
<div><br></div><div>&gt;Gilles Chanteperdrix to Jeff, xenomai-help</div><di=
v><span class=3D"Apple-style-span" style=3D"border-collapse: collapse; colo=
r: rgb(80, 0, 80); font-family: arial, sans-serif; font-size: 13px; ">&gt;J=
eff =A0wrote:</span></div>
</div><div><div class=3D"im" style=3D"color: rgb(80, 0, 80); border-collaps=
e: collapse; font-family: arial, sans-serif; font-size: 13px; ">&gt;&gt; Wh=
at is the best method for segregating Xenomai and Linux by CPU? =A0I was<br=
>&gt;&gt; unable to do this cleanly using /proc/xenomai/affinity for Xenoma=
i,<br>
&gt;&gt; together with the Linux isolcpus boot option. =A0Details below.<br=
>&gt;</div><span class=3D"Apple-style-span" style=3D"border-collapse: colla=
pse; font-family: arial, sans-serif; font-size: 13px; ">&gt;I have no defin=
ite answer, I have not checked. What I suspect, however,</span><span class=
=3D"Apple-style-span" style=3D"border-collapse: collapse; font-family: aria=
l, sans-serif; font-size: 13px; "><br>
</span><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;=
 font-family: arial, sans-serif; font-size: 13px; ">&gt;is that when you tr=
y and force an affinity for a Xenomai thread, it</span><span class=3D"Apple=
-style-span" style=3D"border-collapse: collapse; font-family: arial, sans-s=
erif; font-size: 13px; "><br>
</span><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;=
 font-family: arial, sans-serif; font-size: 13px; ">&gt;tries and apply thi=
s affinity in secondary mode, i.e. as a plain Linux</span><span class=3D"Ap=
ple-style-span" style=3D"border-collapse: collapse; font-family: arial, san=
s-serif; font-size: 13px; "><br>
</span><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;=
 font-family: arial, sans-serif; font-size: 13px; ">&gt;thread. So, will fa=
il if the target thread is not in the &quot;isolcpus&quot;</span><span clas=
s=3D"Apple-style-span" style=3D"border-collapse: collapse; font-family: ari=
al, sans-serif; font-size: 13px; "><br>
</span><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;=
 font-family: arial, sans-serif; font-size: 13px; ">&gt;mask. In other word=
s, a Xenomai thread can not run on a CPU where Linux</span><span class=3D"A=
pple-style-span" style=3D"border-collapse: collapse; font-family: arial, sa=
ns-serif; font-size: 13px; "><br>
</span><span class=3D"Apple-style-span" style=3D"border-collapse: collapse;=
 font-family: arial, sans-serif; font-size: 13px; ">&gt;threads can not run=
.</span><br><br></div><div>at the time my config was:</div><div><span class=
=3D"Apple-style-span" style=3D"border-collapse: collapse; font-family: aria=
l, sans-serif; font-size: 13px; ">x86 32-bit arch<br>
linux-2.6.34.5<br>Xenomai-2.5.4<br>adeos-ipipe-2.6.34.5-x86-2.7-03.patch<br=
></span><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Has=
 the Xenomai cpu affinity or Linux isolcpus implementation changed since th=
en?</div>
<div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Jeff</div><=
div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><br></div></=
div></div></div>

--20cf307d02bee6100d04ace805b9--

