MIME-Version: 1.0
In-Reply-To: <497F436E.3080907@domain.hid>
References: <57e813c90901270847o6907862areb78f7713e8255e6@domain.hid>
	<57e813c90901270918g1b74cd6ev7698e0717647c0d9@domain.hid>
	<497F436E.3080907@domain.hid>
Date: Wed, 28 Jan 2009 10:52:06 -0200
Message-ID: <57e813c90901280452v6761f462kbe342c2142fd5b07@domain.hid>
From: Zara Tustra <zarawesome@domain.hid>
Content-Type: multipart/alternative; boundary=0016364177cf6a328104618a70bc
Subject: Re: [Xenomai-help] librt.so.1 missing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016364177cf6a328104618a70bc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

So if I were to checkout glibc and compile it with the arm-unknown-linux
toolchain (the same used to compile the rest of the kernel), the resulting
libraries would be usable? Another person generated the root file system and
they aren't being very helpful.

On Tue, Jan 27, 2009 at 3:25 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Zara Tustra wrote:
> > Running the test suite on the ARM board results on the message:
> >
> >  error while loading shared libraries: librt.so.1: cannot open shared
> object
> > file: No such file or directory
> >
> > I cannot find librt.so in any directory of the compiled kernel or the
> user
> > space. Am I missing something?
>
> It is part of the glibc, so should be installed by whatever you use to
> generate your root file system. If you do not compile glibc, you will
> find it in the toolchain directories.
>
> --
>                                                  Gilles.
>

--0016364177cf6a328104618a70bc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

So if I were to checkout glibc and compile it with the arm-unknown-linux to=
olchain (the same used to compile the rest of the kernel), the resulting li=
braries would be usable? Another person generated the root file system and =
they aren&#39;t being very helpful.<br>
<br><div class=3D"gmail_quote">On Tue, Jan 27, 2009 at 3:25 PM, Gilles Chan=
teperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
mai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"Wj3C7c">Zara Tustra wrote:<br>
&gt; Running the test suite on the ARM board results on the message:<br>
&gt;<br>
&gt; &nbsp;error while loading shared libraries: librt.so.1: cannot open sh=
ared object<br>
&gt; file: No such file or directory<br>
&gt;<br>
&gt; I cannot find librt.so in any directory of the compiled kernel or the =
user<br>
&gt; space. Am I missing something?<br>
<br>
</div></div>It is part of the glibc, so should be installed by whatever you=
 use to<br>
generate your root file system. If you do not compile glibc, you will<br>
find it in the toolchain directories.<br>
<br>
--<br>
<font color=3D"#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
</font></blockquote></div><br>

--0016364177cf6a328104618a70bc--

