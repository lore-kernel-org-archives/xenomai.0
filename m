Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/alternative; boundary=Apple-Mail-3-14246395
From: Tadele Shiferaw <metitad@domain.hid>
In-Reply-To: <CAP1XtZwrkxp4KQcf+TPyiMJfJdFSkp4CKx76fvg2JOs9iMDQrw@domain.hid>
Date: Tue, 10 Jan 2012 17:43:17 +0100
Message-Id: <07CA468F-2CEA-468D-95B7-E7E15E7C5C29@domain.hid>
References: <CAP1XtZx2JdZAs3SvbWGC8vkuwo+V5v8d69EBvBGzKmKLGi0iPQ@mail.gmail.com>
	<4F06C291.6020402@domain.hid>
	<CAP1XtZxO5_wF02Dt2m_4CF+EQ34zQ68Hany+QRonY1Zxpv7Obg@domain.hid>
	<C3C5060F-9149-43FE-9A41-CA0AF296B2D2@domain.hid>
	<CAP1XtZwrkxp4KQcf+TPyiMJfJdFSkp4CKx76fvg2JOs9iMDQrw@domain.hid>
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
To: Santiago Focke <focke.85@domain.hid>
Cc: xenomai@xenomai.org


--Apple-Mail-3-14246395
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On Jan 10, 2012, at 5:26 PM, Santiago Focke wrote:

> Thanks for the advise
>=20
> I downloaded a new kernel and it worked. I followed the steps from =
README.INSTALL successfully
> $ /usr/src/xenomai-2.6/scripts/prepare-kernel.sh=20
> --linux=3D/home/corbys/linux-2.6.38/=20
>=20
> =
--adeos=3D/usr/src/xenomai-2.6/ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-=
x86-2.11-01.patch=20
> --arch=3Dx86
> $ cd ~/linux-2.6.38/
> $ make [ARCH=3Di386] xconfig
> $ make [ARCH=3Di386] bzImage modules
> $ mkdir ~/build/linux-2.6.38 && cd ~/build/linux-2.6.38
>=20
> $ /usr/src/xenomai-2.6/configure --enable-x86-sep --host=3Di686-linux =
CFLAGS=3D"-m32 -O2" LDFLAGS=3D"-m32"
> How can I check now that my Xenomai patched kernel was installed =
correctly and is ready to be used? Also, what does it mean "# then =
install as needed" after 'make bzImage modules'? I just followed the =
steps above. Should I had installed something else after that step?
>=20
> Thanks again.
>=20

You are almost there ... Check the following for the rest of the =
installation steps and basic testing...
http://www.xenomai.org/index.php/Xenomai_quick_build_quide

Tadele
>=20
> 2012/1/9 Tadele Shiferaw <metitad@domain.hid>
>=20
> On Jan 9, 2012, at 4:22 PM, Santiago Focke wrote:
>=20
>> Thanks for your reply.
>>=20
>> As I told you, I am really new with linux. I've been trying to find =
the kernel source tree and not just the headers, but I haven't been able =
to do it. I read that it is normally located in /usr/src/, but there I =
just have the headers. How can I search the right path of the kernel =
source tree to prepare the kernel?
>>=20
>=20
> Rather than using the kernel headers from ubuntu, clone a new kernel =
copy in /usr/src and try to patch that.=20
>=20
>> Regards,
>=20
> Tadele
>>=20
>> 2012/1/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> On 01/05/2012 08:16 PM, Santiago Focke wrote:
>> > Hi all
>> >
>> > I'm quite new with Linux and Xenomai. I'm using Ubunto kernel
>> > 2.6.32-24-generic. I tied to install Xenomai-2.6 following the
>> > README.INSTALL document. First of all I cloned the GIT repository =
in
>> >
>> > /usr/src/xenomai-2.6
>> >
>> > After that, I tried to run the prepare-kernel.sh script as follows:
>> >
>> > /usr/src/xenomai-2.6/scripts/prepare-kernel.sh
>> > --linux=3D/usr/src/linux-headers-2.6.32-24-generic/
>>=20
>> That is not going to work. Xenomai patches the kernel sources, and =
ask
>> you to rebuild a kernel, just supplying the headers will not work.
>>=20
>>=20
>> --
>>                                            Gilles.
>>=20
>>=20
>>=20
>> --=20
>> Ing. Santiago Focke
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
>=20
>=20
> --=20
> Ing. Santiago Focke


--Apple-Mail-3-14246395
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><br><div><div>On Jan 10, 2012, at 5:26 PM, Santiago Focke wrote:</div><br class="Apple-interchange-newline"><blockquote type="cite">Thanks for the advise<br><br>I downloaded a new kernel and it worked. I followed the steps from README.INSTALL successfully<br><pre style="margin-left:40px">$ /usr/src/xenomai-2.6/scripts/prepare-kernel.sh <br>--linux=/home/corbys/linux-2.6.38/ <br>
--adeos=/usr/src/xenomai-2.6/ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-x86-2.11-01.patch <br>--arch=x86<br>$ cd ~/linux-2.6.38/<br>$ make [ARCH=i386] xconfig<br>$ make [ARCH=i386] bzImage modules<br>$ mkdir ~/build/linux-2.6.38 &amp;&amp; cd ~/build/linux-2.6.38<br>
$ /usr/src/xenomai-2.6/configure --enable-x86-sep --host=i686-linux CFLAGS="-m32 -O2" LDFLAGS="-m32"</pre>
How can I check now that my Xenomai patched kernel was installed correctly and is ready to be used? Also, what does it mean "# then install as needed" after 'make bzImage modules'? I just followed the steps above. Should I had installed something else after that step?<br>
<br>Thanks again.<br><br></blockquote><div><br></div>You are almost there ...&nbsp;Check the following for the rest of the installation steps and basic testing...</div><div><a href="http://www.xenomai.org/index.php/Xenomai_quick_build_quide">http://www.xenomai.org/index.php/Xenomai_quick_build_quide</a></div><div><br></div><div>Tadele</div><div><blockquote type="cite"><br><div class="gmail_quote">2012/1/9 Tadele Shiferaw <span dir="ltr">&lt;<a href="mailto:metitad@domain.hid" target="_blank">metitad@domain.hid</a>&gt;</span><br>
<blockquote class="gmail_quote" style="margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div style="word-wrap:break-word"><br><div><div><div>On Jan 9, 2012, at 4:22 PM, Santiago Focke wrote:</div>

<br><blockquote type="cite">Thanks for your reply.<div><br></div><div>As I told you, I am really new with linux. I've been trying to find the kernel source tree and not just the headers, but I haven't been able to do it. I read that it is normally located in /usr/src/, but there I just have the headers. How can I search the right path of the&nbsp;kernel source tree&nbsp;to prepare the kernel?</div>


<div><br></div></blockquote><div><br></div></div>Rather than using the kernel headers from ubuntu, clone a new kernel copy in /usr/src and try to patch that.&nbsp;</div><div><br><blockquote type="cite"><div>Regards,<br></div>

</blockquote><br>Tadele<br><blockquote type="cite"><div><div><br><div class="gmail_quote">2012/1/6 Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br>

<blockquote class="gmail_quote" style="margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div>On 01/05/2012 08:16 PM, Santiago Focke wrote:<br>
&gt; Hi all<br>
&gt;<br>
&gt; I'm quite new with Linux and Xenomai. I'm using Ubunto kernel<br>
&gt; 2.6.32-24-generic. I tied to install Xenomai-2.6 following the<br>
&gt; README.INSTALL document. First of all I cloned the GIT repository in<br>
&gt;<br>
&gt; /usr/src/xenomai-2.6<br>
&gt;<br>
&gt; After that, I tried to run the prepare-kernel.sh script as follows:<br>
&gt;<br>
&gt; /usr/src/xenomai-2.6/scripts/prepare-kernel.sh<br>
&gt; --linux=/usr/src/linux-headers-2.6.32-24-generic/<br>
<br>
</div>That is not going to work. Xenomai patches the kernel sources, and ask<br>
you to rebuild a kernel, just supplying the headers will not work.<br>
<span><font color="#888888"><br>
<br>
--<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></span></blockquote></div><br><br clear="all"><div><br></div>-- <br>Ing. Santiago Focke<br>
</div></div>
_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid" target="_blank">Xenomai-help@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>

</blockquote></div><br></div></blockquote></div><br><br clear="all"><br>-- <br>Ing. Santiago Focke<br>
</blockquote></div><br></body></html>
--Apple-Mail-3-14246395--

