Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <3DF4E126-156D-4C0D-89A0-240509FD50BA@comcast.net>
References: <3DF4E126-156D-4C0D-89A0-240509FD50BA@comcast.net>
Content-Type: multipart/alternative; boundary=Apple-Mail-118-64887373
Message-Id: <C73405B6-C7F3-49BD-9239-9CD90C7E1031@domain.hid>
From: ckreider <ckreider@domain.hid>
Date: Thu, 9 Aug 2007 12:46:41 -0400
Subject: Re: [Xenomai-help] WTF???
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


--Apple-Mail-118-64887373
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


Post and then figure it out ....

There is a non obvious (at least to me) option,

general setup -> configure standard kernel features (for small  
systems) -> use full shmem filesystem

that substitutes ramfs for tmpfs, which seemed like a good idea since  
I am using ramdisks for all the writable directories, but it does  
break Posix shared memory.

Thanks for your indulgence.



On Aug 9, 2007, at 12:09 PM, ckreider wrote:

>
> I realize that is seems off topic, but it results from changing  
> from RTLinux to Xenomai.  I need to change a dozen uses of mbuff to  
> user space shared memory (yes, they are all user space processes  
> using kernel memory) and want to use Posix stuff because all the  
> code assumes names like "ANALOG" or "DIAG".  My test code works on  
> an unpatched 2.4.32 kernel, an rtlinux patched 2.4.29 kernel, but  
> not on an ipipe patched 2.6.20 kernel.  Both have tmpfs enabled. In  
> both cases, tmpfs is mounted.  The only change from one to the  
> other is the kernel selected with grub at boot time.  Does anyone  
> know what is different with the 2.6.xx kernels that causes this  
> behavior?  Two hours of googling has not yielded any clues.
>
> ---
> Carl Kreider
> ckreider@domain.hid
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

---
Carl Kreider
ckreider@domain.hid




--Apple-Mail-118-64887373
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>Post and then figure it out =
....<DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>There is a non =
obvious (at least to me) option,=A0</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>general setup -&gt; =
configure standard kernel features (for small systems) -&gt; use full =
shmem filesystem</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>that substitutes ramfs for =
tmpfs, which seemed like a good idea since I am using ramdisks for all =
the writable directories, but it does break Posix shared =
memory.</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>Thanks =
for your indulgence.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><BR><DIV><DIV>On Aug 9, =
2007, at 12:09 PM, ckreider wrote:</DIV><BR =
class=3D"Apple-interchange-newline"><BLOCKQUOTE type=3D"cite"><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>I realize that is seems off =
topic, but it results from changing from RTLinux to Xenomai.=A0 I need =
to change a dozen uses of mbuff to user space shared memory (yes, they =
are all user space processes using kernel memory) and want to use Posix =
stuff because all the code assumes names like "ANALOG" or "DIAG".=A0 My =
test code works on an unpatched 2.4.32 kernel, an rtlinux patched 2.4.29 =
kernel, but not on an ipipe patched 2.6.20 kernel.=A0 Both have tmpfs =
enabled. In both cases, tmpfs is mounted.=A0 The only change from one to =
the other is the kernel selected with grub at boot time.=A0 Does anyone =
know what is different with the 2.6.xx kernels that causes this =
behavior?=A0 Two hours of googling has not yielded any =
clues.<DIV><BR><DIV> <SPAN class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Palatino; font-size: 14px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Palatino; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>---</DIV><DIV>Carl Kreider</DIV><DIV><A =
href=3D"mailto:ckreider@domain.hid">ckreider@domain.hid</A></DIV><DIV><B=
R class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN></SPAN> </DIV><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; =
">_______________________________________________</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Xenomai-help mailing list</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><A =
href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</A></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><A =
href=3D"https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/l=
istinfo/xenomai-help</A></DIV> </BLOCKQUOTE></DIV><BR><DIV> <SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Palatino; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Palatino; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>---</DIV><DIV>Carl Kreider</DIV><DIV><A =
href=3D"mailto:ckreider@domain.hid">ckreider@domain.hid</A></DIV><DIV><B=
R class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-118-64887373--

