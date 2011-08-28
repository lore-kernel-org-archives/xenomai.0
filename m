MIME-Version: 1.0
In-Reply-To: <4E5A2AC4.8050904@domain.hid>
References: <CAKvQZ_06JKNPsiGeXOC1PEnc1Je5zSDSnX9AdOHT4eraggv7Eg@domain.hid>
	<4E5A2AC4.8050904@domain.hid>
Date: Sun, 28 Aug 2011 15:12:06 +0200
Message-ID: <CAKvQZ_1w-b=DwqYt4gJUfkmSKbmYtFXmCtbdu0=hsJwbQk=7-Q@mail.gmail.com>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=0016364eec6872c71004ab9086e7
Subject: Re: [Xenomai-help] CPU frequency of 0 in a Vmware with Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--0016364eec6872c71004ab9086e7
Content-Type: text/plain; charset=ISO-8859-1

Thanks Gilles and Jan for answering.

I agree that kvm/qemu are better solution for this, it is a matter of time,
cause i'll have some work for this. I was thinking to switch to this anyway,
so maybe this will be the trigger.

I don't need the vmware to be representative of my robot, it just has to
compile and "looks like to run". But I'll always need a VM because some of
my developpers are under Windows for many reasons.

2011/8/28 Jan Kiszka <jan.kiszka@domain.hid>

> On 2011-08-28 12:28, Willy Lambert wrote:
> > Hi all,
> >
> > I am trying to make xenomai running into a Debian Squeeze 32b with a
> custom
> > 2.6.38.8 kernel with xenomai among other things. I am running this into a
> > Vmware for testing this before going on my real target.
> >
> > I have a "CPU frequency of 0" Error at boot, which I think is "classic"
> with
> > Vmwares :
> > http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/6632
> >
> > ard@domain.hid:~$ dmesg | grep Xenomai
> > [    0.559923] Xenomai has detected a CPU frequency of 0. Aborting.
> > [    0.560923] Xenomai: system init failed, code -19.
> > [    0.560923] Xenomai: native skin init failed, code -19.
> > [    0.560923] Xenomai: starting POSIX services.
> > [    0.561923] Xenomai: POSIX skin init failed, code -19.
> > [    0.561923] Xenomai: RTDM skin init failed, code -19.
>
> You may work around this by statically setting the CPU frequency via the
> xeno_hal.cpufreq kernel parameter.
>
> However, unless you are locked into VMware, use KVM on a Linux host. It
> provides the better experience for testing Xenomai images.
>
> Jan
>
>

--0016364eec6872c71004ab9086e7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Gilles and Jan for answering.<br><br>I agree that kvm/qemu are bette=
r solution for this, it is a matter of time, cause i&#39;ll have some work =
for this. I was thinking to switch to this anyway, so maybe this will be th=
e trigger. <br>
<br>I don&#39;t need the vmware to be representative of my robot, it just h=
as to compile and &quot;looks like to run&quot;. But I&#39;ll always need a=
 VM because some of my developpers are under Windows for many reasons.<br>
<br><div class=3D"gmail_quote">2011/8/28 Jan Kiszka <span dir=3D"ltr">&lt;<=
a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;</span><br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex;">
<div class=3D"im">On 2011-08-28 12:28, Willy Lambert wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I am trying to make xenomai running into a Debian Squeeze 32b with a c=
ustom<br>
&gt; 2.6.38.8 kernel with xenomai among other things. I am running this int=
o a<br>
&gt; Vmware for testing this before going on my real target.<br>
&gt;<br>
&gt; I have a &quot;CPU frequency of 0&quot; Error at boot, which I think i=
s &quot;classic&quot; with<br>
&gt; Vmwares :<br>
&gt; <a href=3D"http://comments.gmane.org/gmane.linux.real-time.xenomai.dev=
el/6632" target=3D"_blank">http://comments.gmane.org/gmane.linux.real-time.=
xenomai.devel/6632</a><br>
&gt;<br>
&gt; ard@domain.hid:~$ dmesg | grep Xenomai<br>
&gt; [ =A0 =A00.559923] Xenomai has detected a CPU frequency of 0. Aborting=
.<br>
&gt; [ =A0 =A00.560923] Xenomai: system init failed, code -19.<br>
&gt; [ =A0 =A00.560923] Xenomai: native skin init failed, code -19.<br>
&gt; [ =A0 =A00.560923] Xenomai: starting POSIX services.<br>
&gt; [ =A0 =A00.561923] Xenomai: POSIX skin init failed, code -19.<br>
&gt; [ =A0 =A00.561923] Xenomai: RTDM skin init failed, code -19.<br>
<br>
</div>You may work around this by statically setting the CPU frequency via =
the<br>
xeno_hal.cpufreq kernel parameter.<br>
<br>
However, unless you are locked into VMware, use KVM on a Linux host. It<br>
provides the better experience for testing Xenomai images.<br>
<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote></div><br>

--0016364eec6872c71004ab9086e7--

