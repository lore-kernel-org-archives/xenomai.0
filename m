Message-ID: <3f027d060705121156h60c002c2hc70c57c702ddaa23@domain.hid>
Date: Sat, 12 May 2007 20:56:07 +0200
From: "Zany Super Chimp" <zanychimp@domain.hid>
In-Reply-To: <4645F633.8080308@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_108627_3425075.1178996167824"
References: <3f027d060705120736h73663da1v9bcf819f6c7452f9@domain.hid>
	<4645F633.8080308@domain.hid>
Subject: Re: [Xenomai-help] Problem compiling kernel-2.6.20-11-ipipe
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

------=_Part_108627_3425075.1178996167824
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/5/12, Jan Kiszka <jan.kiszka@domain.hid>:
>
> Zany Super Chimp wrote:
> > Hi !
> >
> > I just configured my kernel with the prepare-kernel script:
> >
> > sudo ./scripts/prepare-kernel.sh
> > --linux=/usr/src/linux-2.6.20.11-ipipe--adeos=~/xenomai/src/ksrc
> > /arch/i386/patches/adeos-ipipe-2.6.20-i386-1.8-00.patch --arch=i386
> >
> >
> > When I make all, I get the following error:
> >
> >  CHK     include/linux/version.h
> >  CHK     include/linux/utsrelease.h
> >  CHK     include/linux/compile.h
> >  AS      arch/i386/kernel/entry.o
> > arch/i386/kernel/entry.S: Assembler messages:
> > arch/i386/kernel/entry.S:270: Error: invalid character '_' in mnemonic
> > arch/i386/kernel/entry.S:347: Error: invalid character '_' in mnemonic
> > arch/i386/kernel/entry.S:477: Error: invalid character '_' in mnemonic
> > arch/i386/kernel/entry.S:520: Error: invalid character '_' in mnemonic
> > arch/i386/kernel/entry.S:534: Error: invalid character '_' in mnemonic
> > make[1]: *** [arch/i386/kernel/entry.o] Error 1
> > make: *** [arch/i386/kernel] Error 2
> >
> > I'm using gcc 4.1.2 and GNU assembler 2.17.50 on Ubuntu 7.04. Maybe it
> is
> > the problem...
> >
> > Did someone already stumble over that problem ?
>
> Please check your .config for CONFIG_PARAVIRT, that must be off (maybe
> we should catch this...). If it already is, please post your .config.


Well... I don't know how you figured that one out but yes, it fixes my
problem ^^.

Thanks a lot.

Jan
>
>
>
--Zany

------=_Part_108627_3425075.1178996167824
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/5/12, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Zany Super Chimp wrote:<br>&gt; Hi !<br>&gt;<br>&gt; I just configured my kernel with the prepare-kernel script:<br>&gt;<br>&gt; sudo ./scripts/prepare-kernel.sh<br>&gt; --linux=/usr/src/linux-2.6.20.11-ipipe--adeos=~/xenomai/src/ksrc
<br>&gt; /arch/i386/patches/adeos-ipipe-2.6.20-i386-1.8-00.patch --arch=i386<br>&gt;<br>&gt;<br>&gt; When I make all, I get the following error:<br>&gt;<br>&gt;&nbsp;&nbsp;CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>&gt;&nbsp;&nbsp;CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/utsrelease.h
<br>&gt;&nbsp;&nbsp;CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<br>&gt;&nbsp;&nbsp;AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/i386/kernel/entry.o<br>&gt; arch/i386/kernel/entry.S: Assembler messages:<br>&gt; arch/i386/kernel/entry.S:270: Error: invalid character &#39;_&#39; in mnemonic
<br>&gt; arch/i386/kernel/entry.S:347: Error: invalid character &#39;_&#39; in mnemonic<br>&gt; arch/i386/kernel/entry.S:477: Error: invalid character &#39;_&#39; in mnemonic<br>&gt; arch/i386/kernel/entry.S:520: Error: invalid character &#39;_&#39; in mnemonic
<br>&gt; arch/i386/kernel/entry.S:534: Error: invalid character &#39;_&#39; in mnemonic<br>&gt; make[1]: *** [arch/i386/kernel/entry.o] Error 1<br>&gt; make: *** [arch/i386/kernel] Error 2<br>&gt;<br>&gt; I&#39;m using gcc 
4.1.2 and GNU assembler 2.17.50 on Ubuntu 7.04. Maybe it is<br>&gt; the problem...<br>&gt;<br>&gt; Did someone already stumble over that problem ?<br><br>Please check your .config for CONFIG_PARAVIRT, that must be off (maybe
<br>we should catch this...). If it already is, please post your .config.</blockquote><div><br>Well... I don&#39;t know how you figured that one out but yes, it fixes my problem ^^.<br><br>Thanks a lot.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Jan<br><br><br></blockquote></div><br>--Zany

------=_Part_108627_3425075.1178996167824--

