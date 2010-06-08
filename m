MIME-Version: 1.0
In-Reply-To: <4C0E05F6.5030200@domain.hid>
References: <AANLkTimIDghE4o5RpesavooS0cB96ekIgYTXv8rkPRZb@domain.hid>
	<4C0E05F6.5030200@domain.hid>
Date: Tue, 8 Jun 2010 18:04:46 +0200
Message-ID: <AANLkTikxCJ0mDTu2RmSndN-McFJNv1PuWV8j-xywS3NK@mail.gmail.com>
From: Cyril Wallois <walloiscyril@domain.hid>
Content-Type: multipart/alternative; boundary=0015174c1240b98b2e048886f215
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
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

--0015174c1240b98b2e048886f215
Content-Type: text/plain; charset=ISO-8859-1

Hi Gilles,

Thanks for your help

Still on ARM, right? Do you have the same issue if you use an I-pipe
> patch for a more recent kernel versions (anything more recent than 2.6.28).
>

Yes on ARM with PXA270 (toradex colibri), I try to use a newer kernel but I
have a problem of file system and can't use NFS (ethernet driver as module
for rtnet).
On an other embedded system, with kernel 2.6.29, I haven't any problem.

Other than that, you do not give us enough information to help solving
> your issue. What about the last issue you had? What was the value of the
> r3 register at the time of the alignment fault?
>

I don't solve the last issue, I focus on try with newer version of kernel
and xenomai.
Probably my problem should be solve with a more recent kernel , I think I
will try 2.6.29 (and try to solve fs problem).

Regards,

WALLOIS Cyril

--0015174c1240b98b2e048886f215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,<br><br>Thanks for your help<br><br>
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">Still on ARM, right? Do you have the same issue if you use an I-p=
ipe<br>

patch for a more recent kernel versions (anything more recent than 2.6.28).=
<br></blockquote><div>=A0</div><div>Yes on ARM with PXA270 (toradex colibri=
), I try to use a newer kernel but I have a problem of file system and can&=
#39;t use NFS (ethernet driver as module for rtnet).<br>
On an other embedded system, with kernel 2.6.29, I haven&#39;t any problem.=
<br><br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0p=
t 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Other than that, you do not give us enough information to help solving<br>
your issue. What about the last issue you had? What was the value of the<br=
>
r3 register at the time of the alignment fault?<font color=3D"#888888"><br>=
</font></blockquote><div>=A0</div><div>I don&#39;t solve the last issue, I =
focus on try with newer version of kernel and xenomai.<br>Probably my probl=
em should be solve with a more recent kernel , I think I will try 2.6.29 (a=
nd try to solve fs problem).<br>
<br>Regards,<br><br>WALLOIS Cyril<br></div></div><br>

--0015174c1240b98b2e048886f215--

