Message-ID: <8b216e9e0901160857s12f620c2k851b5bc6f1c84a21@domain.hid>
Date: Fri, 16 Jan 2009 14:57:40 -0200
From: "=?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?=" <cavalkaf@domain.hid>
In-Reply-To: <20090116144238.805j8jy1w0s4ss08@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_231977_32643697.1232125060131"
References: <20090116144238.805j8jy1w0s4ss08@domain.hid>
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
To: Sebastien.Berruer@domain.hid
Cc: xenomai@xenomai.org

------=_Part_231977_32643697.1232125060131
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, Jan 16, 2009 at 11:42 AM, <Sebastien.Berruer@domain.hid>wrote=
:

> Hello,
>
> KERNEL VERSIONING
>
> > I've patched the kernel with Adeos. I followed the instruction of
>> > Xenomai 2.4.3 for a linux kernel 2.6.24.
>>
>> Please use the latest version from the 2.4 (stable) branch: Xenomai
>> 2.4.6.1.
>>
>
> I've tried to update from the repository using:
>
> svn update
>
> But, I still have only kernel minor versions 21, 22, 24 of kernel 2.6.
> (NOTE: letting svn using the content of .svn/ to find the repository
> or typing the complete address does the same)
> Then, I've tried to list the repository with:
>
> svn list
>
> There is still the same directory structure, so it's logical nothing
> append. I'm ready to use the patch 2.6.26 from Xenomai 2.4.6.1, but I
> need to be able to download the sources of the corresponding kernel.
> May I not looking for at the right place ? May I do my own recipe ?
>

I grabbed the latest Adeos patch from their website:
http://home.gna.org/adeos/
(actually, http://download.gna.org/adeos/patches/v2.6/arm/older/)
I chose the appropriate architecture and kernel version and used it by
passing an extra argument to the ./prepare-kernel script so that it would
use the apropriate version of the adeos patch. I don't remember it off the
top of my head, however a --help in the script should point you in the righ=
t
direction.


>
> KERNEL COMPILATION
>
>
>  After getting everything set up (including the removal of several featur=
es
>> witch you might not really need - the kernel needs to be less than 1
>> Mb)[...]
>>
>
> (NOTE: I've done my changes from the original copy of the kernel)
> I've tried to remove the device drivers for USB using the menuconfig:
>
> bitbake -c menuconfig gumstix-kernel
>
> Then, I still have done the manual patch for Xenomai and copied the
> .config over the defconfig.
> (NOTE: It would not change anything to patch first and then removing
> the USB drivers using the menuconfig (?) Furthermore, doing the copy over
> defconfig, I write definitively the default defconfig)


This should be fine - the important part is that the kernel is properly
configured (i.e., Gumstix selected as the target machine, etc..) and that
the xenomai options are properly configured as well (there should be a whol=
e
section for xenomai and real-time options).


>
> I force the compilation:
>
> bitbake -f -c compile gumstix-kernel
>
> I saw that Adeos doesn't work in the final kernel. During the boot in
> simulation with Qemu, I've got this kind of messages:
>
> [...]
> <4>smc91x: Unknown symbol __ipipe_unstall_root
> <4>smc91x: Unknown symbol __ipipe_root_status
> <4>smc91x: Unknown symbol __ipipe_restore_root
> <4>smc911x: Unknown symbol __ipipe_root_status
> <4>smc911x: Unknown symbol __ipipe_restore_root
> <4>evdev: Unknown symbol __ipipe_unstall_root
> <4>evdev: Unknown symbol __ipipe_root_status
> <4>mmc_core: Unknown symbol __ipipe_root_status
> <4>mmc_core: Unknown symbol __ipipe_restore_root
> <4>mmc_block: Unknown symbol __ipipe_unstall_root
> <4>mmc_block: Unknown symbol __ipipe_root_status
> [...]
>
> I'm disappointed and I'm asking myself if don't need to add something to
> the recipe that manage the modules (i.e task-base-gumstix) ?
>
> Regards,
>

Well, try to patch it with the other version of Adeos. I never really worke=
d
with Qemu, so I am not sure where the problem might be. I always generate a
new image for my gumstix (using the bitbake gumstix-basic-image -c
rebuild command,
as well as rebuilding task-base-gumstix) and flash it in order to do the
testing - however, Adeos is loaded way before any modules, so I doubt that
it has anything to do with that.

Anyway, try this out - if everything goes wrong, I can send you my own
kernel for testing, and I can take a quick look at your .config files to se=
e
if there is anything wrong.

Hope this helps,
      -Felipe Brand=E3o Cavalcanti
      LARA - Laboratory of Robotics and Automation
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/

PS: Don't forget to send the messages to the list!

Felipe Brand=E3o Cavalcanti <cavalkaf@domain.hid> a =E9crit :
>
>  Well, I did have a few issues with the initial kernel config - what I di=
d
>> to
>> get the kernel working was to copy the original (i.e., the one that came
>> with the Gumstix) defconfig file to the working directory (IIRC,
>> ~/gumstix/gumstix-oe/tmp/work/....) as .config BEFORE running the comman=
d
>> bitbake -c menuconfig gumstix-kernel. This will give you the default
>> gumstix
>> config to start off the kernel customization procedure.
>> After getting everything set up (including the removal of several featur=
es
>> witch you might not really need - the kernel needs to be less than 1 Mb)=
,
>> I
>> copied the new .config over to the defconfig file. Than I just went on t=
o
>> compile the kernel as usual (however, my bitbake recipe does have a few
>> modifications to auto-patch adeos into the kernel).
>>
>> BTW, keep in mind that you also need to install the xenomai userspace
>> packages, that will take up around 7 Mb in your system.
>>
>> I will be happy to help if you have any other specific questions - I hav=
e
>> a
>> fully custom gumstix distribution with Xenomai (it is a work in progress=
,
>> but it does seem to work fine at the moment), with a working kernel and
>> xenomai packages (stripped-out, no documentation, etc...) I would also b=
e
>> happy to receive any interesting info on this area (any new solutions,
>> etc)
>> - not many people seem to be using the gumstix platform for
>> real-time purposes, but it seems like an excellent choice. I do plan on
>> organizing all of this information sooner or later on a webpage (the las=
t
>> step of my project involves porting the OROCOS plataform over to the
>> XScale
>> processor, and than getting it working on the gumstix - after thats done=
,
>> I
>> will document the entire process).
>>
>> Hope this helps!
>>        -Felipe Brand=E3o Cavalcanti
>>        LARA - Laboratory of Robotics and Automation
>>        Department of Electrical Engineering
>>        UnB - University of Bras=EDlia, Brazil
>>        http://www.lara.unb.br/
>>
>> On Mon, Jan 12, 2009 at 8:14 AM, Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org> wrote:
>>
>>  Sebastien.Berruer@domain.hid wrote:
>>> > Hi,
>>> >
>>> > I'm a student and I work on a project to get Xenomai running on a
>>> > gumstix platform. I'm using a Verdex board and OpenEmbedded as my
>>> > development environment. Prior to re-flashing the board, I'm testing
>>> > the RAM image with Qemu.
>>> >
>>> > I've patched the kernel with Adeos. I followed the instruction of
>>> > Xenomai 2.4.3 for a linux kernel 2.6.24.
>>>
>>> Please use the latest version from the 2.4 (stable) branch: Xenomai
>>> 2.4.6.1.
>>>
>>> >
>>> > I've been careful to run the command :
>>> > bitbake gumstix-kernel -c menuconfig
>>> > to force the copy of
>>> >
>>>
>>> ~/gumstix/gumstix-oe/tmp/work/gumstix-custom-verdex-angstrom-linux-gnue=
abi/gumstix-kernel-2.6.24-r1/linux-2.6.24/.config
>>> > to
>>> >
>>>
>>> ~/gumstix/gumstix-oe/user.collection/packages/linux/gumstix-kernel-2.6.=
24/gumstix-custom-verdex/defconfig
>>> >
>>> > Then, I tried to recompile the kernel source code (without that
>>> > bitbake unpacked the archive of the previous version)
>>> > bitbake gumstix-kernel -f -c compile
>>> >
>>> > And create the new images
>>> > bitbake task-base-gumstix -c rebuild
>>> > bitbake gumstix-basic-image -c rebuild
>>> >
>>> > I've made an image of RAM with the dd command to run in Qemu. But,
>>> > when I'm trying to boot this image, the boot stop and said me :
>>> > Copying kernel to 0xa2000000 from 0x01f00000 (length 0x00100000)...do=
ne
>>> > ## Booting image at a2000000 ...
>>> >      Image Name:   Angstrom/2.6.24/gumstix-custom-v
>>> >      Image Type:   ARM Linux Kernel Image (uncompressed)
>>> >      Data Size:    1124960 Bytes =3D  1.1 MB
>>> >      Load Address: a0008000
>>> >      Entry Point:  a0008000
>>> > OK
>>> >
>>> > Starting kernel ...
>>> >
>>> > ran out of input data
>>>
>>> It looks like a memory layout issue, such as the bootloader not copying
>>> the kernel completely, or the places where the kernel is copied
>>> overlapping with something else like an initrd.
>>>
>>>
>>> --
>>>                                                 Gilles.
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>>>
>>
>
> |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
> | BERRUER S=E9bastien        |                                  |
> | 2 rue du Vieil Armand    | Tel : 06-76-35-29-55             |
> | Studio 112               | Email : sberruer@domain.hid     |
> | 67100 STRASBOURG         |                                  |
> |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
>

------=_Part_231977_32643697.1232125060131
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div class=3D"gmail_quote">On Fri, Jan 16, 2009 at 11:42 AM,  <span dir=
=3D"ltr">&lt;<a href=3D"mailto:Sebastien.Berruer@domain.hid">Sebastie=
n.Berruer@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex;">
Hello,<br>
<br><span class=3D"Apple-style-span" style=3D"border-collapse: collapse; ">=
KERNEL VERSIONING<div class=3D"Ih2E3d" style=3D"color: rgb(80, 0, 80); "><b=
r><br><blockquote class=3D"gmail_quote" style=3D"margin-top: 0px; margin-ri=
ght: 0px; margin-bottom: 0px; margin-left: 0.8ex; border-left-width: 1px; b=
order-left-color: rgb(204, 204, 204); border-left-style: solid; padding-lef=
t: 1ex; ">
&gt; I&#39;ve patched the kernel with Adeos. I followed the instruction of<=
br>&gt; Xenomai 2.4.3 for a linux kernel 2.6.24.<br><br>Please use the late=
st version from the 2.4 (stable) branch: Xenomai<br>2.4.6.1.<br></blockquot=
e>
<br></div>I&#39;ve tried to update from the repository using:<br><br>svn up=
date<br><br>But, I still have only kernel minor versions 21, 22, 24 of kern=
el 2.6.<br>(NOTE: letting svn using the content of .svn/ to find the reposi=
tory<br>
or typing the complete address does the same)<br>Then, I&#39;ve tried to li=
st the repository with:<br><br>svn list<br><br>There is still the same dire=
ctory structure, so it&#39;s logical nothing<br>append. I&#39;m ready to us=
e the patch 2.6.26 from Xenomai 2.4.6.1, but I<br>
need to be able to download the sources of the corresponding kernel.<br>May=
 I not looking for at the right place ? May I do my own recipe ?</span><br>=
</blockquote><div><br></div><div>I grabbed the latest Adeos patch from thei=
r website:&nbsp;<a href=3D"http://home.gna.org/adeos/">http://home.gna.org/=
adeos/</a></div>
<div>(actually,&nbsp;<a href=3D"http://download.gna.org/adeos/patches/v2.6/=
arm/older/">http://download.gna.org/adeos/patches/v2.6/arm/older/</a>)</div=
><div>I chose the&nbsp;appropriate&nbsp;architecture and kernel version and=
 used it by passing an extra argument to the ./prepare-kernel script so tha=
t it would use the apropriate version of the adeos patch. I don&#39;t&nbsp;=
remember&nbsp;it off the top of my head, however a --help in the script sho=
uld point you in the right direction.</div>
<div>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex;">
<br>
KERNEL COMPILATION<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"Ih2E3d">
After getting everything set up (including the removal of several features<=
br></div>
witch you might not really need - the kernel needs to be less than 1 Mb)[..=
.]<br>
</blockquote>
<br>
(NOTE: I&#39;ve done my changes from the original copy of the kernel)<br>
I&#39;ve tried to remove the device drivers for USB using the menuconfig:<d=
iv class=3D"Ih2E3d"><br>
<br>
bitbake -c menuconfig gumstix-kernel<br>
<br></div>
Then, I still have done the manual patch for Xenomai and copied the<br>
.config over the defconfig.<br>
(NOTE: It would not change anything to patch first and then removing<br>
the USB drivers using the menuconfig (?) Furthermore, doing the copy over d=
efconfig, I write definitively the default defconfig)</blockquote><div><br>=
</div><div>This should be fine - the important part is that the kernel is p=
roperly configured (i.e., Gumstix selected as the target machine, etc..) an=
d that the xenomai options are properly configured as well (there should be=
 a whole section for xenomai and real-time options).</div>
<div>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex;"><br>
I force the compilation:<br>
<br>
bitbake -f -c compile gumstix-kernel<br>
<br>
I saw that Adeos doesn&#39;t work in the final kernel. During the boot in s=
imulation with Qemu, I&#39;ve got this kind of messages:<br>
<br>
[...]<br>
&lt;4&gt;smc91x: Unknown symbol __ipipe_unstall_root<br>
&lt;4&gt;smc91x: Unknown symbol __ipipe_root_status<br>
&lt;4&gt;smc91x: Unknown symbol __ipipe_restore_root<br>
&lt;4&gt;smc911x: Unknown symbol __ipipe_root_status<br>
&lt;4&gt;smc911x: Unknown symbol __ipipe_restore_root<br>
&lt;4&gt;evdev: Unknown symbol __ipipe_unstall_root<br>
&lt;4&gt;evdev: Unknown symbol __ipipe_root_status<br>
&lt;4&gt;mmc_core: Unknown symbol __ipipe_root_status<br>
&lt;4&gt;mmc_core: Unknown symbol __ipipe_restore_root<br>
&lt;4&gt;mmc_block: Unknown symbol __ipipe_unstall_root<br>
&lt;4&gt;mmc_block: Unknown symbol __ipipe_root_status<br>
[...]<br>
<br>
I&#39;m disappointed and I&#39;m asking myself if don&#39;t need to add som=
ething to the recipe that manage the modules (i.e task-base-gumstix) ?<br>
<br>
Regards,<br></blockquote><div>&nbsp;</div><div>Well, try to patch it with t=
he other version of Adeos. I never really worked with Qemu, so I am not sur=
e where the problem might be. I always generate a new image for my gumstix =
(using the <span class=3D"Apple-style-span" style=3D"font-family: -webkit-m=
onospace; font-size: 12px; white-space: pre; ">bitbake gumstix-basic-image =
-c rebuild <span class=3D"Apple-style-span" style=3D"font-family: arial; fo=
nt-size: 13px; white-space: normal; ">command, as well as rebuilding task-b=
ase-gumstix) and flash it in order to do the testing - however, Adeos is lo=
aded way before any modules, so I doubt that it has anything to do with tha=
t.</span></span></div>
<div><br></div><div>Anyway, try this out - if everything goes wrong, I can =
send you my own kernel for testing, and I can take a quick look at your .co=
nfig files to see if there is anything wrong.</div><div><br></div><div>
Hope this helps,</div><div>&nbsp;&nbsp; &nbsp; &nbsp;-Felipe Brand=E3o Cava=
lcanti</div><div>&nbsp;&nbsp; &nbsp; &nbsp;LARA - Laboratory of Robotics an=
d Automation</div><div>&nbsp;&nbsp; &nbsp; &nbsp;Department of Electrical E=
ngineering</div><div>&nbsp;&nbsp; &nbsp; &nbsp;UnB - University of Bras=EDl=
ia, Brazil</div>
<div>&nbsp;&nbsp; &nbsp; &nbsp;<a href=3D"http://www.lara.unb.br/">http://w=
ww.lara.unb.br/</a></div><div><br></div><div>PS: Don&#39;t forget to send t=
he messages to the list!</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;=
">

Felipe Brand=E3o Cavalcanti &lt;<a href=3D"mailto:cavalkaf@domain.hid" targe=
t=3D"_blank">cavalkaf@domain.hid</a>&gt; a =E9crit&nbsp;:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"Ih2E3d">
Well, I did have a few issues with the initial kernel config - what I did t=
o<br>
get the kernel working was to copy the original (i.e., the one that came<br=
>
with the Gumstix) defconfig file to the working directory (IIRC,<br>
~/gumstix/gumstix-oe/tmp/work/....) as .config BEFORE running the command<b=
r>
bitbake -c menuconfig gumstix-kernel. This will give you the default gumsti=
x<br>
config to start off the kernel customization procedure.<br>
After getting everything set up (including the removal of several features<=
br></div><div class=3D"Ih2E3d">
witch you might not really need - the kernel needs to be less than 1 Mb), I=
<br></div><div class=3D"Ih2E3d">
copied the new .config over to the defconfig file. Than I just went on to<b=
r>
compile the kernel as usual (however, my bitbake recipe does have a few<br>
modifications to auto-patch adeos into the kernel).<br>
<br>
BTW, keep in mind that you also need to install the xenomai userspace<br>
packages, that will take up around 7 Mb in your system.<br>
<br>
I will be happy to help if you have any other specific questions - I have a=
<br>
fully custom gumstix distribution with Xenomai (it is a work in progress,<b=
r>
but it does seem to work fine at the moment), with a working kernel and<br>
xenomai packages (stripped-out, no documentation, etc...) I would also be<b=
r>
happy to receive any interesting info on this area (any new solutions, etc)=
<br>
- not many people seem to be using the gumstix platform for<br>
real-time purposes, but it seems like an excellent choice. I do plan on<br>
organizing all of this information sooner or later on a webpage (the last<b=
r>
step of my project involves porting the OROCOS plataform over to the XScale=
<br>
processor, and than getting it working on the gumstix - after thats done, I=
<br>
will document the entire process).<br>
<br>
Hope this helps!<br>
 &nbsp; &nbsp; &nbsp; &nbsp;-Felipe Brand=E3o Cavalcanti<br>
 &nbsp; &nbsp; &nbsp; &nbsp;LARA - Laboratory of Robotics and Automation<br=
>
 &nbsp; &nbsp; &nbsp; &nbsp;Department of Electrical Engineering<br>
 &nbsp; &nbsp; &nbsp; &nbsp;UnB - University of Bras=EDlia, Brazil<br>
 &nbsp; &nbsp; &nbsp; &nbsp;<a href=3D"http://www.lara.unb.br/" target=3D"_=
blank">http://www.lara.unb.br/</a><br>
<br></div>
On Mon, Jan 12, 2009 at 8:14 AM, Gilles Chanteperdrix &lt;<div class=3D"Ih2=
E3d"><br>
<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_blank">gille=
s.chanteperdrix@domain.hid</a>&gt; wrote:<br>
<br>
</div><div><div></div><div class=3D"Wj3C7c"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<a href=3D"mailto:Sebastien.Berruer@domain.hid" target=3D"_blank">Seb=
astien.Berruer@domain.hid</a> wrote:<br>
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
Please use the latest version from the 2.4 (stable) branch: Xenomai<br>
2.4.6.1.<br>
<br>
&gt;<br>
&gt; I&#39;ve been careful to run the command :<br>
&gt; bitbake gumstix-kernel -c menuconfig<br>
&gt; to force the copy of<br>
&gt;<br>
~/gumstix/gumstix-oe/tmp/work/gumstix-custom-verdex-angstrom-linux-gnueabi/=
gumstix-kernel-2.6.24-r1/linux-2.6.24/.config<br>
&gt; to<br>
&gt;<br>
~/gumstix/gumstix-oe/user.collection/packages/linux/gumstix-kernel-2.6.24/g=
umstix-custom-verdex/defconfig<br>
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
It looks like a memory layout issue, such as the bootloader not copying<br>
the kernel completely, or the places where the kernel is copied<br>
overlapping with something else like an initrd.<br>
<br>
<br>
--<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; Gilles.<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid" target=3D"_blank">Xenomai-help@domain.hid.=
org</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
</blockquote>
<br></div></div></blockquote><br><div><div></div><div class=3D"Wj3C7c">
<br>
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|<br>
| BERRUER S=E9bastien &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;|<br>
| 2 rue du Vieil Armand &nbsp; &nbsp;| Tel : 06-76-35-29-55 &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; |<br>
| Studio 112 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Email : <a =
href=3D"mailto:sberruer@domain.hid" target=3D"_blank">sberruer@domain.hid=
</a> &nbsp; &nbsp; |<br>
| 67100 STRASBOURG &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;|<br>
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|<br></div></div></blockquote></div><br=
>

------=_Part_231977_32643697.1232125060131--

