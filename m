Message-ID: <8b216e9e0901130417q6a6ffa28la6fac3a2a22c046f@domain.hid>
Date: Tue, 13 Jan 2009 10:17:52 -0200
From: "=?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?=" <cavalkaf@domain.hid>
In-Reply-To: <496B1807.8090600@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_208337_27326129.1231849072562"
References: <20090112110445.gupikke2o4o40kko@domain.hid>
	<496B1807.8090600@domain.hid>
Subject: Re: [Xenomai-help] Xenomai on Gumstix
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
Cc: Sebastien.Berruer@domain.hid

------=_Part_208337_27326129.1231849072562
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Well, I did have a few issues with the initial kernel config - what I did t=
o
get the kernel working was to copy the original (i.e., the one that came
with the Gumstix) defconfig file to the working directory (IIRC,
~/gumstix/gumstix-oe/tmp/work/....) as .config BEFORE running the command
bitbake -c menuconfig gumstix-kernel. This will give you the default gumsti=
x
config to start off the kernel customization procedure.
After getting everything set up (including the removal of several features
witch you might not really need - the kernel needs to be less than 1 Mb), I
copied the new .config over to the defconfig file. Than I just went on to
compile the kernel as usual (however, my bitbake recipe does have a few
modifications to auto-patch adeos into the kernel).

BTW, keep in mind that you also need to install the xenomai userspace
packages, that will take up around 7 Mb in your system.

I will be happy to help if you have any other specific questions - I have a
fully custom gumstix distribution with Xenomai (it is a work in progress,
but it does seem to work fine at the moment), with a working kernel and
xenomai packages (stripped-out, no documentation, etc...) I would also be
happy to receive any interesting info on this area (any new solutions, etc)
- not many people seem to be using the gumstix platform for
real-time purposes, but it seems like an excellent choice. I do plan on
organizing all of this information sooner or later on a webpage (the last
step of my project involves porting the OROCOS plataform over to the XScale
processor, and than getting it working on the gumstix - after thats done, I
will document the entire process).

Hope this helps!
        -Felipe Brand=E3o Cavalcanti
        LARA - Laboratory of Robotics and Automation
        Department of Electrical Engineering
        UnB - University of Bras=EDlia, Brazil
        http://www.lara.unb.br/

On Mon, Jan 12, 2009 at 8:14 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Sebastien.Berruer@domain.hid wrote:
> > Hi,
> >
> > I'm a student and I work on a project to get Xenomai running on a
> > gumstix platform. I'm using a Verdex board and OpenEmbedded as my
> > development environment. Prior to re-flashing the board, I'm testing
> > the RAM image with Qemu.
> >
> > I've patched the kernel with Adeos. I followed the instruction of
> > Xenomai 2.4.3 for a linux kernel 2.6.24.
>
> Please use the latest version from the 2.4 (stable) branch: Xenomai
> 2.4.6.1.
>
> >
> > I've been careful to run the command :
> > bitbake gumstix-kernel -c menuconfig
> > to force the copy of
> >
> ~/gumstix/gumstix-oe/tmp/work/gumstix-custom-verdex-angstrom-linux-gnueab=
i/gumstix-kernel-2.6.24-r1/linux-2.6.24/.config
> > to
> >
> ~/gumstix/gumstix-oe/user.collection/packages/linux/gumstix-kernel-2.6.24=
/gumstix-custom-verdex/defconfig
> >
> > Then, I tried to recompile the kernel source code (without that
> > bitbake unpacked the archive of the previous version)
> > bitbake gumstix-kernel -f -c compile
> >
> > And create the new images
> > bitbake task-base-gumstix -c rebuild
> > bitbake gumstix-basic-image -c rebuild
> >
> > I've made an image of RAM with the dd command to run in Qemu. But,
> > when I'm trying to boot this image, the boot stop and said me :
> > Copying kernel to 0xa2000000 from 0x01f00000 (length 0x00100000)...done
> > ## Booting image at a2000000 ...
> >      Image Name:   Angstrom/2.6.24/gumstix-custom-v
> >      Image Type:   ARM Linux Kernel Image (uncompressed)
> >      Data Size:    1124960 Bytes =3D  1.1 MB
> >      Load Address: a0008000
> >      Entry Point:  a0008000
> > OK
> >
> > Starting kernel ...
> >
> > ran out of input data
>
> It looks like a memory layout issue, such as the bootloader not copying
> the kernel completely, or the places where the kernel is copied
> overlapping with something else like an initrd.
>
>
> --
>                                                  Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



--=20
*=BA=A4., =B8=B8,.=A4=BA*=A8*=A4., =B8=B8,.=A4=BA*=A8*
Cavalkaf (aka Felipe) <cavalkaf@domain.hid>
AIM: Cavalkaf | MSN: cavalkaf2@domain.hid
Check out <http://www.flickr.com/photos/rbcav2003/>

------=_Part_208337_27326129.1231849072562
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Well, I did have a few issues with the initial kernel config - what I did t=
o get the kernel working was to copy the original (i.e., the one that came =
with the Gumstix) defconfig file to the working directory (IIRC, ~/gumstix/=
gumstix-oe/tmp/work/....) as .config BEFORE running the command bitbake -c =
menuconfig gumstix-kernel. This will give you the default gumstix config to=
 start off the kernel customization procedure.<div>
<br></div><div>After getting everything set up (including the removal of se=
veral features witch you might not really need - the kernel needs to be les=
s than 1 Mb), I copied the new .config over to the defconfig file. Than I j=
ust went on to compile the kernel as usual (however, my bitbake recipe does=
 have a few modifications to auto-patch adeos into the kernel).</div>
<div><br></div><div>BTW, keep in mind that you also need to install the xen=
omai userspace packages, that will take up around 7 Mb in your system.</div=
><div><br></div><div>I will be happy to help if you have any other specific=
 questions - I have a fully custom gumstix distribution with Xenomai (it is=
 a work in progress, but it does seem to work fine at the moment), with a w=
orking kernel and xenomai packages (stripped-out, no documentation, etc...)=
 I would also be happy to receive any interesting info on this area (any ne=
w solutions, etc) - not many people seem to be using the gumstix&nbsp;platf=
orm&nbsp;for real-time&nbsp;purposes, but it seems like an&nbsp;excellent&n=
bsp;choice. I do plan on organizing all of this information sooner or later=
 on a webpage (the last step of my project involves porting the OROCOS plat=
aform over to the XScale processor, and than getting it working on the gums=
tix - after thats done, I will document the entire process).</div>
<div><br></div><div>Hope this helps!</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &=
nbsp;-Felipe Brand=E3o Cavalcanti</div><div><span class=3D"Apple-style-span=
" style=3D"border-collapse: collapse; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; LARA - Laboratory of Robotics and Automation<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; Department of Electrical Engineering<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UnB - University of Bras=EDlia, =
Brazil</span></div><div><span class=3D"Apple-style-span" style=3D"border-co=
llapse: collapse;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;<a href=3D"http://www.l=
ara.unb.br/">http://www.lara.unb.br/</a></span></div><div><span class=3D"Ap=
ple-style-span" style=3D"border-collapse: collapse;"><br>
</span><div class=3D"gmail_quote">On Mon, Jan 12, 2009 at 8:14 AM, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex;">
<div class=3D"Ih2E3d"><a href=3D"mailto:Sebastien.Berruer@domain.hid"=
>Sebastien.Berruer@domain.hid</a> wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I&#39;m a student and I work on a project to get Xenomai running on a<=
br>
&gt; gumstix platform. I&#39;m using a Verdex board and OpenEmbedded as my<=
br>
&gt; development environment. Prior to re-flashing the board, I&#39;m testi=
ng<br>
&gt; the RAM image with Qemu.<br>
&gt;<br>
&gt; I&#39;ve patched the kernel with Adeos. I followed the instruction of<=
br>
&gt; Xenomai 2.4.3 for a linux kernel 2.6.24.<br>
<br>
</div>Please use the latest version from the 2.4 (stable) branch: Xenomai 2=
.4.6.1.<br>
<div class=3D"Ih2E3d"><br>
&gt;<br>
&gt; I&#39;ve been careful to run the command :<br>
&gt; bitbake gumstix-kernel -c menuconfig<br>
&gt; to force the copy of<br>
&gt; ~/gumstix/gumstix-oe/tmp/work/gumstix-custom-verdex-angstrom-linux-gnu=
eabi/gumstix-kernel-2.6.24-r1/linux-2.6.24/.config<br>
&gt; to<br>
&gt; ~/gumstix/gumstix-oe/user.collection/packages/linux/gumstix-kernel-2.6=
.24/gumstix-custom-verdex/defconfig<br>
&gt;<br>
&gt; Then, I tried to recompile the kernel source code (without that<br>
&gt; bitbake unpacked the archive of the previous version)<br>
&gt; bitbake gumstix-kernel -f -c compile<br>
&gt;<br>
&gt; And create the new images<br>
&gt; bitbake task-base-gumstix -c rebuild<br>
&gt; bitbake gumstix-basic-image -c rebuild<br>
&gt;<br>
&gt; I&#39;ve made an image of RAM with the dd command to run in Qemu. But,=
<br>
&gt; when I&#39;m trying to boot this image, the boot stop and said me :<br=
>
&gt; Copying kernel to 0xa2000000 from 0x01f00000 (length 0x00100000)...don=
e<br>
&gt; ## Booting image at a2000000 ...<br>
&gt; &nbsp; &nbsp; &nbsp;Image Name: &nbsp; Angstrom/2.6.24/gumstix-custom-=
v<br>
&gt; &nbsp; &nbsp; &nbsp;Image Type: &nbsp; ARM Linux Kernel Image (uncompr=
essed)<br>
&gt; &nbsp; &nbsp; &nbsp;Data Size: &nbsp; &nbsp;1124960 Bytes =3D &nbsp;1.=
1 MB<br>
&gt; &nbsp; &nbsp; &nbsp;Load Address: a0008000<br>
&gt; &nbsp; &nbsp; &nbsp;Entry Point: &nbsp;a0008000<br>
&gt; OK<br>
&gt;<br>
&gt; Starting kernel ...<br>
&gt;<br>
&gt; ran out of input data<br>
<br>
</div>It looks like a memory layout issue, such as the bootloader not copyi=
ng<br>
the kernel completely, or the places where the kernel is copied<br>
overlapping with something else like an initrd.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
</font><div><div></div><div class=3D"Wj3C7c"><br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>*=BA=A4., =
=B8=B8,.=A4=BA*=A8*=A4., =B8=B8,.=A4=BA*=A8*<br>Cavalkaf (aka Felipe) &lt;<=
a href=3D"mailto:cavalkaf@domain.hid">cavalkaf@domain.hid</a>&gt;<br>AIM: Cav=
alkaf | MSN: <a href=3D"mailto:cavalkaf2@domain.hid">cavalkaf2@domain.hid</a>=
<br>
Check out &lt;<a href=3D"http://www.flickr.com/photos/rbcav2003/">http://ww=
w.flickr.com/photos/rbcav2003/</a>&gt;<br>
</div>

------=_Part_208337_27326129.1231849072562--

