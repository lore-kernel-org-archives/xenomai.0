MIME-Version: 1.0
In-Reply-To: <4AAA4AE9.5070101@domain.hid>
References: <4303dd240909110600tf787b85td93b46086953a0d9@domain.hid>
	<4AAA4AE9.5070101@domain.hid>
Date: Wed, 16 Sep 2009 09:55:14 -0300
Message-ID: <4303dd240909160555l5f53839g6bf917a17370bb09@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d77e91007ae60473b16948
Subject: Re: [Xenomai-help] Problems with instalation of xenomai in ubuntu
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

--0016e6d77e91007ae60473b16948
Content-Type: text/plain; charset=ISO-8859-1

Hello,
Sorry for the delay in the response.

In fact, I believe it is not really a kernel panic, because the login
message appears at the screen just before the screen is cleared (and the
computer is blocked). Sometimes I can see the mouse pointer for X, but the
computer is also blocked.

The boot behavior is something like this:

- normal boot, which the messages on the screen (I suppose the messages are
correct)
- login message (terminal mode)
- switch to X mode
- system block

Build information:
- Linux kernel 2.6.30
- Xenomai version 2.4.9.1 (I have tried also with xenomai 2.4.9 and I had
similar results)
- GCC version 4.3.2
- Ubuntu 8.10

Which information can I send to you in order to be more specific?

Thanks for your help.

Best regards,

Flavio

2009/9/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Flavio de Castro Alves Filho wrote:
> > Hello,
> >
> > I am new with Xenomai and I am having problems in booting a compiled
> > kernel into Ubuntu 8.10. I could compile the kernel with the appropriate
> > patch, configured grub to load the new kernel. But, when I boot the new
> > kernel, it performs all the boot configurations and at the end, when the
> > gnome is about to be loaded, the computer starts to blink the display
> > and then blocks.
> >
> > I am using the following configuration:
> >
> > - x86 platform (my notebook ... an intel core2duo machine)
> > - xenomai version 2.4.9
> > - linux 2.6.30
> > - ubuntu linux 8.10
> > I performed the following steps:
> >
> > - downloaded file linux-2.6.30.tar.bz2 from kernel.org <
> http://kernel.org>
> > - downloaded file xenomai-2.4.9.tar.bz2 from xenomai website
> > - from my home directory, I decompressed both files
> > - applied the patch, running the "scripts/prepare-kernel.sh" and
> > provided the path for my source files "/home/flavio/linux-2.6.30". The
> > script had correctly found the patch to be applied to my sources.
> > - make xconfig:
> >    - disabled HPET timer support
> >    - disabled PC Speaker
> >    - disabled Power Management Support
> >    - disabled CPU frequency scaling
> >    - enabled VxWorks emulator
> >    - enabled RTAI emulator
> >    - enabled Testing drivers
> > - make
> > - make modules
> > - sudo make modules_install
> > - sudo make install
> > - cd /boot
> > - sudo update-initramfs -c -k 2.6.30
> > - created an entry in grub list:
> >
> > title Xenomai 2.4.9 Linux 2.6.30
> > root (hd0,2)
> > kernel /boot/vmlinuz-2.6.30 root=/dev/sda3 ro
> > initrd /boot/initrd.img-2.6.30
> > savedefault
> > boot
> >
> > Just as a remark, I performed before the same procedure, except for the
> > xenomai patch, and I could execute the linux 2.6.30 kernel in my
> computer.
> >
> > Had anybody passed by the same experience? I have no idea what the
> > problem could be.
>
> The keyboard blinking means that you have a kernel panic. Try to get the
> kernel panic text (using serial console or network console for
> instance), and send it. Some people even made a snapshot of the kernel
> panic on their screen.
>
> --
>                                           Gilles
>
>


-- 
Flavio de Castro Alves Filho
Embedded Software Services
www.phiinnovations.com
+55 11 84 94 56 76

--0016e6d77e91007ae60473b16948
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>Sorry for the delay in the response.</div><div><b=
r></div><div>In fact, I believe it is not really a kernel panic, because th=
e login message appears at the screen just before the screen is cleared (an=
d the computer is blocked). Sometimes I can see the mouse pointer for X, bu=
t the computer is also blocked.</div>
<div><br></div><div>The boot behavior is something like this:</div><div><br=
></div><div>- normal boot, which the messages on the screen (I suppose the =
messages are correct)</div><div>- login message (terminal mode)</div><div>
- switch to X mode</div><div>- system block</div><div><br></div><div>Build =
information:</div><div>- Linux kernel 2.6.30</div><div>- Xenomai version 2.=
4.9.1 (I have tried also with xenomai 2.4.9 and I had similar results)</div=
>
<div>- GCC version 4.3.2</div><div>- Ubuntu 8.10</div><div><br></div><div>W=
hich information can I send to you in order to be more specific?</div><div>=
<br></div><div>Thanks for your help.</div><div><br></div><div>Best regards,=
</div>
<div><br></div><div>Flavio<br><br><div class=3D"gmail_quote">2009/9/11 Gill=
es Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdr=
ix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex;">
<div class=3D"im">Flavio de Castro Alves Filho wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am new with Xenomai and I am having problems in booting a compiled<b=
r>
&gt; kernel into Ubuntu 8.10. I could compile the kernel with the appropria=
te<br>
&gt; patch, configured grub to load the new kernel. But, when I boot the ne=
w<br>
&gt; kernel, it performs all the boot configurations and at the end, when t=
he<br>
&gt; gnome is about to be loaded, the computer starts to blink the display<=
br>
&gt; and then blocks.<br>
&gt;<br>
&gt; I am using the following configuration:<br>
&gt;<br>
&gt; - x86 platform (my notebook ... an intel core2duo machine)<br>
&gt; - xenomai version 2.4.9<br>
&gt; - linux 2.6.30<br>
&gt; - ubuntu linux 8.10<br>
&gt; I performed the following steps:<br>
&gt;<br>
</div>&gt; - downloaded file linux-2.6.30.tar.bz2 from <a href=3D"http://ke=
rnel.org" target=3D"_blank">kernel.org</a> &lt;<a href=3D"http://kernel.org=
" target=3D"_blank">http://kernel.org</a>&gt;<br>
<div><div></div><div class=3D"h5">&gt; - downloaded file xenomai-2.4.9.tar.=
bz2 from xenomai website<br>
&gt; - from my home directory, I decompressed both files<br>
&gt; - applied the patch, running the &quot;scripts/prepare-kernel.sh&quot;=
 and<br>
&gt; provided the path for my source files &quot;/home/flavio/linux-2.6.30&=
quot;. The<br>
&gt; script had correctly found the patch to be applied to my sources.<br>
&gt; - make xconfig:<br>
&gt; =A0 =A0- disabled HPET timer support<br>
&gt; =A0 =A0- disabled PC Speaker<br>
&gt; =A0 =A0- disabled Power Management Support<br>
&gt; =A0 =A0- disabled CPU frequency scaling<br>
&gt; =A0 =A0- enabled VxWorks emulator<br>
&gt; =A0 =A0- enabled RTAI emulator<br>
&gt; =A0 =A0- enabled Testing drivers<br>
&gt; - make<br>
&gt; - make modules<br>
&gt; - sudo make modules_install<br>
&gt; - sudo make install<br>
&gt; - cd /boot<br>
&gt; - sudo update-initramfs -c -k 2.6.30<br>
&gt; - created an entry in grub list:<br>
&gt;<br>
&gt; title Xenomai 2.4.9 Linux 2.6.30<br>
&gt; root (hd0,2)<br>
&gt; kernel /boot/vmlinuz-2.6.30 root=3D/dev/sda3 ro<br>
&gt; initrd /boot/initrd.img-2.6.30<br>
&gt; savedefault<br>
&gt; boot<br>
&gt;<br>
&gt; Just as a remark, I performed before the same procedure, except for th=
e<br>
&gt; xenomai patch, and I could execute the linux 2.6.30 kernel in my compu=
ter.<br>
&gt;<br>
&gt; Had anybody passed by the same experience? I have no idea what the<br>
&gt; problem could be.<br>
<br>
</div></div>The keyboard blinking means that you have a kernel panic. Try t=
o get the<br>
kernel panic text (using serial console or network console for<br>
instance), and send it. Some people even made a snapshot of the kernel<br>
panic on their screen.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Flavio de Castro=
 Alves Filho<br>Embedded Software Services<br><a href=3D"http://www.phiinno=
vations.com">www.phiinnovations.com</a><br>+55 11 84 94 56 76<br>
</div>

--0016e6d77e91007ae60473b16948--

