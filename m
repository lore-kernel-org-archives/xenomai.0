Message-ID: <25dd9bf10701160518o129cd728ne1b1dfb99149556a@domain.hid>
Date: Tue, 16 Jan 2007 18:48:10 +0530
From: "Subramani Venkatesh" <subbu31mani@domain.hid>
Subject: Re: [Adeos-main] Porting IPIPE on MIPS Architecture,
	User Process running error, Kernel hangs.
In-Reply-To: <45ACCDEC.2080807@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_108001_31810519.1168953490480"
References: <25dd9bf10701160219w72c8e522l33f4eb9cec59b869@domain.hid>
	<45ACB7EB.1060708@domain.hid>
	<25dd9bf10701160444s1eed7edfwabd5302b022902aa@domain.hid>
	<45ACCDEC.2080807@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

------=_Part_108001_31810519.1168953490480
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well Jan, with respect to PIC(i8259) I don't see many changes as compared to
code in Linux-2.6 on X86. But timer and whole Interrupt system changes. Will
look closely in it.  Have to put more effort on System calls as Phillipe
said, Will look into it and have to write test code with other customozed
domain like Registering with timer interrupt and try passing it to Linux
after handling it.

Subbu

On 1/16/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Subramani Venkatesh wrote:
> > BTW Jan, may I know how different is the IPIPE port on the Linux-2.6.10and
> > the current IPIPE port on Linux-2.6.16 or Linux-2.6.18.
>
> As you already picked a fairly new I-pipe core (1.5), the differences
> will be around the kernel subsystems that changed meanwhile. Philippe
> may better comment on details, still I guess no one here has tracked the
> MIPS development to be aware of important changes there. Aspects to
> check are specifically the timer and the IRQ subsystems. Both are under
> heavy reconstruction recently, heading toward more generic
> implementation which is a Good Thing also for I-pipe.
>
> When you upgrade, going to head (then likely 2.6.20) is recommended to
> avoid doing work twice - given that this kernel is stable in vanilla
> form for you.
>
> Jan
>
>
>
>

------=_Part_108001_31810519.1168953490480
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well Jan, with respect to PIC(i8259) I don&#39;t see many changes as compared to code in Linux-2.6 on X86. But timer and whole Interrupt system changes. Will look closely in it.&nbsp; Have to put more effort on System calls as Phillipe said, Will look into it and have to write test code with other customozed domain like Registering with timer interrupt and try passing it to Linux after handling it.
<br><br>Subbu<br><br><div><span class="gmail_quote">On 1/16/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Subramani Venkatesh wrote:<br>&gt; BTW Jan, may I know how different is the IPIPE port on the Linux-2.6.10 and<br>&gt; the current IPIPE port on Linux-2.6.16 or Linux-2.6.18.<br><br>As you already picked a fairly new I-pipe core (
1.5), the differences<br>will be around the kernel subsystems that changed meanwhile. Philippe<br>may better comment on details, still I guess no one here has tracked the<br>MIPS development to be aware of important changes there. Aspects to
<br>check are specifically the timer and the IRQ subsystems. Both are under<br>heavy reconstruction recently, heading toward more generic<br>implementation which is a Good Thing also for I-pipe.<br><br>When you upgrade, going to head (then likely 
2.6.20) is recommended to<br>avoid doing work twice - given that this kernel is stable in vanilla<br>form for you.<br><br>Jan<br><br><br><br></blockquote></div><br>

------=_Part_108001_31810519.1168953490480--

