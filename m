MIME-Version: 1.0
In-Reply-To: <C3C5060F-9149-43FE-9A41-CA0AF296B2D2@domain.hid>
References: <CAP1XtZx2JdZAs3SvbWGC8vkuwo+V5v8d69EBvBGzKmKLGi0iPQ@mail.gmail.com>
	<4F06C291.6020402@domain.hid>
	<CAP1XtZxO5_wF02Dt2m_4CF+EQ34zQ68Hany+QRonY1Zxpv7Obg@domain.hid>
	<C3C5060F-9149-43FE-9A41-CA0AF296B2D2@domain.hid>
Date: Tue, 10 Jan 2012 17:26:54 +0100
Message-ID: <CAP1XtZwrkxp4KQcf+TPyiMJfJdFSkp4CKx76fvg2JOs9iMDQrw@domain.hid>
From: Santiago Focke <focke.85@domain.hid>
Content-Type: multipart/alternative; boundary=e89a8f6472e5b8defd04b62efb6b
Subject: Re: [Xenomai-help] Problems with installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tadele Shiferaw <metitad@domain.hid>
Cc: xenomai@xenomai.org

--e89a8f6472e5b8defd04b62efb6b
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the advise

I downloaded a new kernel and it worked. I followed the steps from
README.INSTALL successfully

$ /usr/src/xenomai-2.6/scripts/prepare-kernel.sh
--linux=/home/corbys/linux-2.6.38/
--adeos=/usr/src/xenomai-2.6/ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-x86-2.11-01.patch
--arch=x86
$ cd ~/linux-2.6.38/
$ make [ARCH=i386] xconfig
$ make [ARCH=i386] bzImage modules
$ mkdir ~/build/linux-2.6.38 && cd ~/build/linux-2.6.38
$ /usr/src/xenomai-2.6/configure --enable-x86-sep --host=i686-linux
CFLAGS="-m32 -O2" LDFLAGS="-m32"

How can I check now that my Xenomai patched kernel was installed correctly
and is ready to be used? Also, what does it mean "# then install as needed"
after 'make bzImage modules'? I just followed the steps above. Should I had
installed something else after that step?

Thanks again.


2012/1/9 Tadele Shiferaw <metitad@domain.hid>

>
> On Jan 9, 2012, at 4:22 PM, Santiago Focke wrote:
>
> Thanks for your reply.
>
> As I told you, I am really new with linux. I've been trying to find the
> kernel source tree and not just the headers, but I haven't been able to do
> it. I read that it is normally located in /usr/src/, but there I just have
> the headers. How can I search the right path of the kernel source tree to
> prepare the kernel?
>
>
> Rather than using the kernel headers from ubuntu, clone a new kernel copy
> in /usr/src and try to patch that.
>
> Regards,
>
>
> Tadele
>
>
> 2012/1/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
>> On 01/05/2012 08:16 PM, Santiago Focke wrote:
>> > Hi all
>> >
>> > I'm quite new with Linux and Xenomai. I'm using Ubunto kernel
>> > 2.6.32-24-generic. I tied to install Xenomai-2.6 following the
>> > README.INSTALL document. First of all I cloned the GIT repository in
>> >
>> > /usr/src/xenomai-2.6
>> >
>> > After that, I tried to run the prepare-kernel.sh script as follows:
>> >
>> > /usr/src/xenomai-2.6/scripts/prepare-kernel.sh
>> > --linux=/usr/src/linux-headers-2.6.32-24-generic/
>>
>> That is not going to work. Xenomai patches the kernel sources, and ask
>> you to rebuild a kernel, just supplying the headers will not work.
>>
>>
>> --
>>                                            Gilles.
>>
>
>
>
> --
> Ing. Santiago Focke
>  _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
>


-- 
Ing. Santiago Focke

--e89a8f6472e5b8defd04b62efb6b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the advise<br><br>I downloaded a new kernel and it worked. I fol=
lowed the steps from README.INSTALL successfully<br><pre style=3D"margin-le=
ft:40px">$ /usr/src/xenomai-2.6/scripts/prepare-kernel.sh <br>--linux=3D/ho=
me/corbys/linux-2.6.38/ <br>
--adeos=3D/usr/src/xenomai-2.6/ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-x=
86-2.11-01.patch <br>--arch=3Dx86<br>$ cd ~/linux-2.6.38/<br>$ make [ARCH=
=3Di386] xconfig<br>$ make [ARCH=3Di386] bzImage modules<br>$ mkdir ~/build=
/linux-2.6.38 &amp;&amp; cd ~/build/linux-2.6.38<br>
$ /usr/src/xenomai-2.6/configure --enable-x86-sep --host=3Di686-linux CFLAG=
S=3D&quot;-m32 -O2&quot; LDFLAGS=3D&quot;-m32&quot;</pre>
How can I check now that my Xenomai patched kernel was installed correctly =
and is ready to be used? Also, what does it mean &quot;# then install as ne=
eded&quot; after &#39;make bzImage modules&#39;? I just followed the steps =
above. Should I had installed something else after that step?<br>
<br>Thanks again.<br><br><br><div class=3D"gmail_quote">2012/1/9 Tadele Shi=
feraw <span dir=3D"ltr">&lt;<a href=3D"mailto:metitad@domain.hid" target=3D"=
_blank">metitad@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div style=3D"word-wrap:b=
reak-word"><br><div><div><div>On Jan 9, 2012, at 4:22 PM, Santiago Focke wr=
ote:</div>

<br><blockquote type=3D"cite">Thanks for your reply.<div><br></div><div>As =
I told you, I am really new with linux. I&#39;ve been trying to find the ke=
rnel source tree and not just the headers, but I haven&#39;t been able to d=
o it. I read that it is normally located in /usr/src/, but there I just hav=
e the headers. How can I search the right path of the=A0kernel source tree=
=A0to prepare the kernel?</div>


<div><br></div></blockquote><div><br></div></div>Rather than using the kern=
el headers from ubuntu, clone a new kernel copy in /usr/src and try to patc=
h that.=A0</div><div><br><blockquote type=3D"cite"><div>Regards,<br></div>

</blockquote><br>Tadele<br><blockquote type=3D"cite"><div><div><br><div cla=
ss=3D"gmail_quote">2012/1/6 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_blank">gilles.ch=
anteperdrix@domain.hid</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<div>On 01/05/2012 08:16 PM, Santiago Focke wrote:<br>
&gt; Hi all<br>
&gt;<br>
&gt; I&#39;m quite new with Linux and Xenomai. I&#39;m using Ubunto kernel<=
br>
&gt; 2.6.32-24-generic. I tied to install Xenomai-2.6 following the<br>
&gt; README.INSTALL document. First of all I cloned the GIT repository in<b=
r>
&gt;<br>
&gt; /usr/src/xenomai-2.6<br>
&gt;<br>
&gt; After that, I tried to run the prepare-kernel.sh script as follows:<br=
>
&gt;<br>
&gt; /usr/src/xenomai-2.6/scripts/prepare-kernel.sh<br>
&gt; --linux=3D/usr/src/linux-headers-2.6.32-24-generic/<br>
<br>
</div>That is not going to work. Xenomai patches the kernel sources, and as=
k<br>
you to rebuild a kernel, just supplying the headers will not work.<br>
<span><font color=3D"#888888"><br>
<br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Ing. Santiago Focke<br>
</div></div>
_______________________________________________<br>Xenomai-help mailing lis=
t<br><a href=3D"mailto:Xenomai-help@domain.hid" target=3D"_blank">Xenomai-help=
@gna.org</a><br><a href=3D"https://mail.gna.org/listinfo/xenomai-help" targ=
et=3D"_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>

</blockquote></div><br></div></blockquote></div><br><br clear=3D"all"><br>-=
- <br>Ing. Santiago Focke<br>

--e89a8f6472e5b8defd04b62efb6b--

