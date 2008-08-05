Message-ID: <2b490f270808050422r2997ded4ta2ee4de6206bb0e5@domain.hid>
Date: Tue, 5 Aug 2008 13:22:04 +0200
From: "Dehann Fourie" <dehann.fourie@domain.hid>
In-Reply-To: <20080804144936.45B241C066@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_29693_7358928.1217935324497"
References: <20080804144936.45B241C066@domain.hid>
Subject: Re: [Xenomai-help] xenomai version 2.4.4 with linux kernel
	2.6.25.11 under ubuntu problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stefano.franzoni@domain.hid
Cc: xenomai@xenomai.org

------=_Part_29693_7358928.1217935324497
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

Im not the expert but I had the same problem under xubuntu 7.10. I tried
mkinitrd, but this command doesn't come standard with Ubuntu. I resorted to
Debian and installed under an unencrypted fs. I think that the fs encryptio=
n
could be ur problem.

Dehann

On Mon, Aug 4, 2008 at 4:49 PM, <stefano.franzoni@domain.hid> wrote:

>
> Dear
>
> I am trying to install Xenomai under Ubuntu following this guide:
> http://www.xenomai.org/index.php/Xenomai_quick_build_quide
>
> I have successfully patched the kernel with xenomai and compiled it.
>
> I have created a new entry in grub/menu.lst
>
> title kernel 2.6.25.11 with xenomai 2.4.4 and Ubuntu 8.04
> root (hd0,2)
> kernel /boot/vmlinuz-2.6.25.11-xenomai-2.4.4 root=3D/dev/hdb3 ro
> zeno_nucleus.xenomai_gid=3D1004
>
> I have one hard disk with two partitions and I am working on hdb3.
>
> At the reboot of the PC I see the message:
>
> cannot open root device "hdb3" or unknown-block(0,0)
> please append a correct root=3D boot option; here are the available
> partitions:
> 0100 65536 ram0 (driver?)
> 0101 65536 ram1 (driver?)
> =85
> 010f 65536 ram15 (driver?)
>
> kernel panic - not syncing: VFS unable to mount root fs on
> unknown-block(0,0)
>
> - I have included in the kernel, not as module the File System EXT3.
> - I have also included in the kernel, not as module, the
> ATA/ATAPI/MFM/RLL Support -> Enhanced IDE/MFM
>
> Any suggestions?
>
> Thanks in advance
>
> ----------------------------------------------------------------
> Stefano Franzoni
> Sofware Research
> Marposs S.p.A. - via Saliceto 13
> 40010 Bentivoglio (BO) - Italy
> www.marposs.com
>
> Tel: +39 051 899633
> Fax: +39 051 899802
> stefano.franzoni@domain.hid
> ----------------------------------------------------------------
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_29693_7358928.1217935324497
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">HI,<br><br>Im not the expert but I had the same problem un=
der xubuntu 7.10. I tried mkinitrd, but this command doesn&#39;t come stand=
ard with Ubuntu. I resorted to Debian and installed under an unencrypted fs=
. I think that the fs encryption could be ur problem.<br>
<br>Dehann<br><br><div class=3D"gmail_quote">On Mon, Aug 4, 2008 at 4:49 PM=
,  <span dir=3D"ltr">&lt;<a href=3D"mailto:stefano.franzoni@domain.hid">st=
efano.franzoni@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Dear<br>
<br>
I am trying to install Xenomai under Ubuntu following this guide:<br>
<a href=3D"http://www.xenomai.org/index.php/Xenomai_quick_build_quide" targ=
et=3D"_blank">http://www.xenomai.org/index.php/Xenomai_quick_build_quide</a=
><br>
<br>
I have successfully patched the kernel with xenomai and compiled it.<br>
<br>
I have created a new entry in grub/menu.lst<br>
<br>
title kernel <a href=3D"http://2.6.25.11" target=3D"_blank">2.6.25.11</a> w=
ith xenomai 2.4.4 and Ubuntu 8.04<br>
root (hd0,2)<br>
kernel /boot/vmlinuz-2.6.25.11-xenomai-2.4.4 root=3D/dev/hdb3 ro<br>
zeno_nucleus.xenomai_gid=3D1004<br>
<br>
I have one hard disk with two partitions and I am working on hdb3.<br>
<br>
At the reboot of the PC I see the message:<br>
<br>
cannot open root device &quot;hdb3&quot; or unknown-block(0,0)<br>
please append a correct root=3D boot option; here are the available<br>
partitions:<br>
0100 65536 ram0 (driver?)<br>
0101 65536 ram1 (driver?)<br>
=85<br>
010f 65536 ram15 (driver?)<br>
<br>
kernel panic - not syncing: VFS unable to mount root fs on<br>
unknown-block(0,0)<br>
<br>
- I have included in the kernel, not as module the File System EXT3.<br>
- I have also included in the kernel, not as module, the<br>
ATA/ATAPI/MFM/RLL Support -&gt; Enhanced IDE/MFM<br>
<br>
Any suggestions?<br>
<br>
Thanks in advance<br>
<br>
----------------------------------------------------------------<br>
Stefano Franzoni<br>
Sofware Research<br>
Marposs S.p.A. - via Saliceto 13<br>
40010 Bentivoglio (BO) - Italy<br>
<a href=3D"http://www.marposs.com" target=3D"_blank">www.marposs.com</a><br=
>
<br>
Tel: +39 051 899633<br>
Fax: +39 051 899802<br>
<a href=3D"mailto:stefano.franzoni@domain.hid">stefano.franzoni@domain.hid=
m</a><br>
----------------------------------------------------------------<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</blockquote></div><br></div>

------=_Part_29693_7358928.1217935324497--

