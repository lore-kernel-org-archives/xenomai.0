MIME-Version: 1.0
Sender: alexandre.tuleu@domain.hid
Date: Fri, 12 Aug 2011 10:14:35 +0200
Message-ID: <CAMQsbyZMRUKaSnNREKjxHuJqop7LPH8Wdmty_inEMGCLRJxJHw@domain.hid>
From: alexandre tuleu <alexandre.tuleu@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3071cc2cfb897204aa4a80c2
Subject: [Xenomai-help] Cross-compilation of debian package of linux patched
	kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--20cf3071cc2cfb897204aa4a80c2
Content-Type: text/plain; charset=UTF-8

Hi


For an embeded robotic project, I have to make package of xenomai for an
ubuntu lucid distribution. Based on this how to (
http://www.xenomai.org/index.php/Building_Debian_packages) I succeed to
patch and install a linux 2.6.34.5 kernel. On the target  system, after
installation of the package, Native skin is working fine like almost all
other testsuite tools. However when I wanted to compile the RTDM examples, I
remarked that all the link in /lib/module/2.6.34.5/build/xenomai are broken.
actually they all point to /xxx/yyy/xenomai-2.5.6/include/ where /xxx/yyy/
was the path from whom I cross-compiled my linux kernel on my amd64 desktop
computer. Actually on this system both linux and xenomai source tree are
under /xxx/yyy

I also have this warning when installing my linux headers packages :

 Hmm. There is a symbolic link /lib/modules/2.6.34.5-ipipe-vortex/build
 However, I can not read it: No such file or directory
 Therefore, I am deleting /lib/modules/2.6.34.5-ipipe-vortex/build

But apparently this was not the case since this directory is still there,
but just all the xenomai's links are broken.

I used this command for make-kpkg :

make-kpkg --cross-compile - -arch i386 buildpackage

And then used deb-reversion to change all "Architecture: amd64" to
"Architecture: i386" in control files of the generated packages.

I'm sure I made some beginner's mistake here. Does anyone have any idea of
what I would have done wrong. Or the idea to cross-compile form amd64 to
i386 while generating debian packages is just a really bad one ? My target
system is very limited in disk size and ressource, so its rather hard to
cross-compile on it.

best regards,

Alexandre Tuleu

--20cf3071cc2cfb897204aa4a80c2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; f=
ont-size: 13px; background-color: rgb(255, 255, 255); ">Hi<div><br></div><d=
iv><br></div><div>For an embeded robotic project, I have to make package of=
 xenomai for an ubuntu lucid distribution. Based on this how to (<a href=3D=
"http://www.xenomai.org/index.php/Building_Debian_packages" target=3D"_blan=
k" style=3D"color: rgb(0, 0, 0); ">http://www.xenomai.org/index.php/Buildin=
g_Debian_packages</a>) I succeed to patch and install a linux 2.6.34.5 kern=
el. On the target =C2=A0system, after installation of the package, Native s=
kin is working fine like almost all other testsuite tools. However when I w=
anted to compile the RTDM examples, I remarked that all the link in /lib/mo=
dule/<a href=3D"http://2.6.34.5/build/xenomai" target=3D"_blank" style=3D"c=
olor: rgb(0, 0, 0); ">2.6.34.5/build/xenomai</a>=C2=A0are broken. actually =
they all point to /xxx/yyy/xenomai-2.5.6/include/ where /xxx/yyy/ was the p=
ath from whom I cross-compiled my linux kernel on my amd64 desktop computer=
. Actually on this system both linux and xenomai source tree are under /xxx=
/yyy</div>
<div><br></div><div>I also have this warning when installing my linux heade=
rs packages :</div><div><br></div><div><div>=C2=A0Hmm. There is a symbolic =
link /lib/modules/2.6.34.5-ipipe-vortex/build</div><div>=C2=A0However, I ca=
n not read it: No such file or directory</div>
<div>=C2=A0Therefore, I am deleting /lib/modules/2.6.34.5-ipipe-vortex/buil=
d</div></div><div><br></div><div>But apparently this was not the case since=
 this directory is still there, but just all the xenomai&#39;s links are br=
oken.</div>
<div><br></div><div>I used this command for make-kpkg :</div><div><br></div=
><div>make-kpkg --cross-compile - -arch i386 buildpackage</div><div><br></d=
iv><div>And then used deb-reversion to change all &quot;Architecture: amd64=
&quot; to &quot;Architecture: i386&quot; in control files of the generated =
packages.</div>
<div><br></div><div>I&#39;m sure I made some beginner&#39;s mistake here. D=
oes anyone have any idea of what I would have done wrong. Or the idea to cr=
oss-compile form amd64 to i386 while generating debian packages is just a r=
eally bad one ? My target system is very limited in disk size and ressource=
, so its rather hard to cross-compile on it.</div>
<div><br></div><div>best regards,</div><div><br></div><div>Alexandre Tuleu<=
/div><div><br></div></span>

--20cf3071cc2cfb897204aa4a80c2--

