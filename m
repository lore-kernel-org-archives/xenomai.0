MIME-Version: 1.0
In-Reply-To: <07CA468F-2CEA-468D-95B7-E7E15E7C5C29@domain.hid>
References: <CAP1XtZx2JdZAs3SvbWGC8vkuwo+V5v8d69EBvBGzKmKLGi0iPQ@mail.gmail.com>
	<4F06C291.6020402@domain.hid>
	<CAP1XtZxO5_wF02Dt2m_4CF+EQ34zQ68Hany+QRonY1Zxpv7Obg@domain.hid>
	<C3C5060F-9149-43FE-9A41-CA0AF296B2D2@domain.hid>
	<CAP1XtZwrkxp4KQcf+TPyiMJfJdFSkp4CKx76fvg2JOs9iMDQrw@domain.hid>
	<07CA468F-2CEA-468D-95B7-E7E15E7C5C29@domain.hid>
Date: Tue, 10 Jan 2012 20:50:22 +0100
Message-ID: <CAP1XtZy58TKLqNxrdSzn8k3Jx6YPUK-NLJSxnLLyst7Nmvxs4g@domain.hid>
From: Santiago Focke <focke.85@domain.hid>
Content-Type: multipart/alternative; boundary=f46d0447f2d85fba6204b631d347
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

--f46d0447f2d85fba6204b631d347
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the quick reply

I'm having problems booting into the Xenomai kernel. I get a window which
says:

*Ubuntu is running in low-graphics mode*
The following error was encountered. You may need
to upgrade your configuration to solve this.
(EE) open /dev/fb0: No such file or directory
(EE) intel(0): [drm]: Failed to open DRM device for
pci:0000:00:02.0: No such file or directory
(EE) intel(0): Failed to become DRM master.
(EE) GARTInit: Unable to open /dev/agpgart (No such file or
directory)
(EE) intel(0): /dev/agpgart is either not available or no memory
is available
(EE) intel(0): Failed to initializekernel memory manager
(EE) intel(0): AGP GART support is either not available or
cannot be used
(EE) intel(0):  AGP GART support is either not available or
cannot be used
(EE) intel(0): Couldn't allocate video memory

When I exit to the console, I see a fatal error that says

Could not load /lib/modules/2.6.38/modules.dep: no such file or directory


My grub.cfg file was edited automatically after copying the bzImage and
typing update-grub:

sudo cp /home/corbys/linux-2.6.38/arch/x86/boot/bzImage
/boot/vmlinuz-2.6.38.8-xenomai-2.6
sudo addgroup xenomai
sudo usermod -a -G xenomai corbys
sudo usermod -a -G xenomai aleu
sudo update-grub

The update-grub added the following lines to grub.cfg

menuentry 'Ubuntu, with Linux 2.6.38.8-xenomai-2.6' --class ubuntu --class
gnu-linux --class gnu --class os {
    recordfail
    insmod ext2
    set root='(hd0,1)'
    search --no-floppy --fs-uuid --set 958aeec8-5e7e-42ce-9719-136139112849
    linux    /boot/vmlinuz-2.6.38.8-xenomai-2.6 root=/dev/sda1 ro   quiet
splash
}
menuentry 'Ubuntu, with Linux 2.6.38.8-xenomai-2.6 (recovery mode)' --class
ubuntu --class gnu-linux --class gnu --class os {
    recordfail
    insmod ext2
    set root='(hd0,1)'
    search --no-floppy --fs-uuid --set 958aeec8-5e7e-42ce-9719-136139112849
    echo    'Loading Linux 2.6.38.8-xenomai-2.6 ...'
    linux    /boot/vmlinuz-2.6.38.8-xenomai-2.6 root=/dev/sda1 ro single
    echo    'Loading initial ramdisk ...'
}

I tried also by changing root=/dev/sda1 for my UUID (root=UUID=958...), but
it didn't even started. I changed as well 'quiet splash' for
'xeno_nucleus.xenomai_gid=1001' and still didn't work (same 'Ubuntu is
running in low-graphics mode' error).

What can I do now??


2012/1/10 Tadele Shiferaw <metitad@domain.hid>

>
> On Jan 10, 2012, at 5:26 PM, Santiago Focke wrote:
>
> Thanks for the advise
>
> I downloaded a new kernel and it worked. I followed the steps from
> README.INSTALL successfully
>
> $ /usr/src/xenomai-2.6/scripts/prepare-kernel.sh
> --linux=/home/corbys/linux-2.6.38/
>
> --adeos=/usr/src/xenomai-2.6/ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-x86-2.11-01.patch
> --arch=x86
> $ cd ~/linux-2.6.38/
> $ make [ARCH=i386] xconfig
> $ make [ARCH=i386] bzImage modules
> $ mkdir ~/build/linux-2.6.38 && cd ~/build/linux-2.6.38
>
>
>
> $ /usr/src/xenomai-2.6/configure --enable-x86-sep --host=i686-linux CFLAGS="-m32 -O2" LDFLAGS="-m32"
>
> How can I check now that my Xenomai patched kernel was installed correctly
> and is ready to be used? Also, what does it mean "# then install as needed"
> after 'make bzImage modules'? I just followed the steps above. Should I had
> installed something else after that step?
>
> Thanks again.
>
>
> You are almost there ... Check the following for the rest of the
> installation steps and basic testing...
> http://www.xenomai.org/index.php/Xenomai_quick_build_quide
>
> Tadele
>
>
> 2012/1/9 Tadele Shiferaw <metitad@domain.hid>
>
>>
>> On Jan 9, 2012, at 4:22 PM, Santiago Focke wrote:
>>
>> Thanks for your reply.
>>
>> As I told you, I am really new with linux. I've been trying to find the
>> kernel source tree and not just the headers, but I haven't been able to do
>> it. I read that it is normally located in /usr/src/, but there I just have
>> the headers. How can I search the right path of the kernel source tree to
>> prepare the kernel?
>>
>>
>> Rather than using the kernel headers from ubuntu, clone a new kernel copy
>> in /usr/src and try to patch that.
>>
>> Regards,
>>
>>
>> Tadele
>>
>>
>> 2012/1/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>>> On 01/05/2012 08:16 PM, Santiago Focke wrote:
>>> > Hi all
>>> >
>>> > I'm quite new with Linux and Xenomai. I'm using Ubunto kernel
>>> > 2.6.32-24-generic. I tied to install Xenomai-2.6 following the
>>> > README.INSTALL document. First of all I cloned the GIT repository in
>>> >
>>> > /usr/src/xenomai-2.6
>>> >
>>> > After that, I tried to run the prepare-kernel.sh script as follows:
>>> >
>>> > /usr/src/xenomai-2.6/scripts/prepare-kernel.sh
>>> > --linux=/usr/src/linux-headers-2.6.32-24-generic/
>>>
>>> That is not going to work. Xenomai patches the kernel sources, and ask
>>> you to rebuild a kernel, just supplying the headers will not work.
>>>
>>>
>>> --
>>>                                            Gilles.
>>>
>>
>>
>>
>> --
>> Ing. Santiago Focke
>>  _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>>
>>
>
>
> --
> Ing. Santiago Focke
>
>
>


-- 
Ing. Santiago Focke

--f46d0447f2d85fba6204b631d347
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the quick reply<div><br></div><div>I&#39;m having problems booti=
ng into the Xenomai kernel. I get a window which says:<br><br><div style=3D=
"margin-left:40px"><b>Ubuntu is running in low-graphics mode</b><br>The fol=
lowing error was encountered. You may need<br>

to upgrade your configuration to solve this.<br>(EE) open /dev/fb0: No such=
 file or directory<br>(EE) intel(0): [drm]: Failed to open DRM device for<b=
r>pci:0000:00:02.0: No such file or directory<br>(EE) intel(0): Failed to b=
ecome DRM master.<br>

(EE) GARTInit: Unable to open /dev/agpgart (No such file or<br>directory)<b=
r>(EE) intel(0): /dev/agpgart is either not available or no memory<br>is av=
ailable<br>(EE) intel(0): Failed to initializekernel memory manager<br>

(EE) intel(0): AGP GART support is either not available or<br>cannot be use=
d<br>(EE) intel(0):=A0 AGP GART support is either not available or<br>canno=
t be used<br>(EE) intel(0): Couldn&#39;t allocate video memory<br></div>
</div>
<div><br></div><div>When I exit to the console, I see a fatal error that sa=
ys</div><div>
<br></div><blockquote style=3D"margin:0pt 0pt 0pt 40px;border:medium none;p=
adding:0px"><div>Could not load /lib/modules/2.6.38/modules.dep: no such fi=
le or directory</div></blockquote><div><br>My grub.cfg file was edited auto=
matically after copying the bzImage and typing update-grub:<br>

<br><div style=3D"text-align:left;margin-left:40px">sudo cp /home/corbys/li=
nux-2.6.38/arch/x86/boot/bzImage /boot/vmlinuz-2.6.38.8-xenomai-2.6<br>sudo=
 addgroup xenomai<br>sudo usermod -a -G xenomai corbys<br>sudo usermod -a -=
G xenomai aleu<br>

sudo update-grub<br><br></div><div style=3D"text-align:left">The update-gru=
b added the following lines to grub.cfg</div></div><div><br><div style=3D"m=
argin-left:40px">menuentry &#39;Ubuntu, with Linux 2.6.38.8-xenomai-2.6&#39=
; --class ubuntu --class gnu-linux --class gnu --class os {<br>
=A0=A0=A0 recordfail<br>
=A0=A0=A0 insmod ext2<br>=A0=A0=A0 set root=3D&#39;(hd0,1)&#39;<br>=A0=A0=
=A0 search --no-floppy --fs-uuid --set 958aeec8-5e7e-42ce-9719-136139112849=
<br>=A0=A0=A0 linux=A0=A0=A0 /boot/vmlinuz-2.6.38.8-xenomai-2.6 root=3D/dev=
/sda1 ro=A0=A0 quiet splash<br>}<br>

menuentry &#39;Ubuntu, with Linux 2.6.38.8-xenomai-2.6 (recovery mode)&#39;=
 --class ubuntu --class gnu-linux --class gnu --class os {<br>=A0=A0=A0 rec=
ordfail<br>=A0=A0=A0 insmod ext2<br>=A0=A0=A0 set root=3D&#39;(hd0,1)&#39;<=
br>=A0=A0=A0 search --no-floppy --fs-uuid --set 958aeec8-5e7e-42ce-9719-136=
139112849<br>

=A0=A0=A0 echo=A0=A0=A0 &#39;Loading Linux 2.6.38.8-xenomai-2.6 ...&#39;<br=
>=A0=A0=A0 linux=A0=A0=A0 /boot/vmlinuz-2.6.38.8-xenomai-2.6 root=3D/dev/sd=
a1 ro single <br>=A0=A0=A0 echo=A0=A0=A0 &#39;Loading initial ramdisk ...&#=
39;<br>}<br></div><br>I tried also by changing root=3D/dev/sda1 for my UUID=
 (root=3DUUID=3D958...), but it didn&#39;t even started. I changed as well =
&#39;quiet splash&#39; for &#39;xeno_nucleus.xenomai_gid=3D1001&#39; and st=
ill didn&#39;t work (same &#39;Ubuntu is running in low-graphics mode&#39; =
error).<br>
<br>What can I do now??<br><br><br><div class=3D"gmail_quote">

2012/1/10 Tadele Shiferaw <span dir=3D"ltr">&lt;<a href=3D"mailto:metitad@domain.hid=
mail.com" target=3D"_blank">metitad@domain.hid</a>&gt;</span><br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">

<div style=3D"word-wrap:break-word">
<br><div><div><div>On Jan 10, 2012, at 5:26 PM, Santiago Focke wrote:</div>=
<br><blockquote type=3D"cite">Thanks for the advise<br><br>I downloaded a n=
ew kernel and it worked. I followed the steps from README.INSTALL successfu=
lly<br>


<pre style=3D"margin-left:40px">$ /usr/src/xenomai-2.6/scripts/prepare-kern=
el.sh <br>--linux=3D/home/corbys/linux-2.6.38/ <br>
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



<br>Thanks again.<br><br></blockquote><div><br></div></div>You are almost t=
here ...=A0Check the following for the rest of the installation steps and b=
asic testing...</div><div><a href=3D"http://www.xenomai.org/index.php/Xenom=
ai_quick_build_quide" target=3D"_blank">http://www.xenomai.org/index.php/Xe=
nomai_quick_build_quide</a></div>


<span><font color=3D"#888888"><div><br></div><div>Tadele</div></font></span=
><div><div><div><blockquote type=3D"cite"><br><div class=3D"gmail_quote">20=
12/1/9 Tadele Shiferaw <span dir=3D"ltr">&lt;<a href=3D"mailto:metitad@domain.hid=
l.com" target=3D"_blank">metitad@domain.hid</a>&gt;</span><br>



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
</blockquote></div><br></div></div></div></blockquote></div><br><br clear=
=3D"all"><div><br></div>-- <br>Ing. Santiago Focke<br>
</div>

--f46d0447f2d85fba6204b631d347--

