Date: Thu, 21 Dec 2006 08:00:21 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
Subject: Re: [Xenomai-help] please i need help for rt_intr_create() fails
In-Reply-To: <458AADEE.6070005@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1079913404-1166716821=:923"
Content-Transfer-Encoding: 8bit
Message-ID: <851374.923.qm@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--0-1079913404-1166716821=:923
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Jan.
Please tell me which xenomai version are you using.i think i need to recompile me kernel again.

Best regards
imran
Jan Kiszka <jan.kiszka@domain.hid> wrote: mani bhatti wrote:
> Hi all
> i am trying to create a user space parallel port interrupt but the problem is that   err=rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTOENA);
> 
> returns -22 instead of zero which means success.i dont have idea what this error code  -22 means.please help me in this regard.i am attaching the sample code.If some one can send me some basic working user space xenomai  code i would be  very thankful.Thanks,

Your test loads fine for me over latest Xenomai (but I see no reason why
older versions should fail). Maybe your kernel/userspace pair is out of
sync.

If the problem persists, add some printk into the path the
rt_intr_create syscall takes. Start here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/syscall.c#3066

Jan



 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1079913404-1166716821=:923
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Jan.<br>Please tell me which xenomai version are you using.i think i need to recompile me kernel again.<br><br>Best regards<br>imran<br><b><i>Jan Kiszka &lt;jan.kiszka@domain.hid&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> mani bhatti wrote:<br>&gt; Hi all<br>&gt; i am trying to create a user space parallel port interrupt but the problem is that   err=rt_intr_create(&amp;intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTOENA);<br>&gt; <br>&gt; returns -22 instead of zero which means success.i dont have idea what this error code  -22 means.please help me in this regard.i am attaching the sample code.If some one can send me some basic working user space xenomai  code i would be  very thankful.Thanks,<br><br>Your test loads fine for me over latest Xenomai (but I see no reason why<br>older versions should fail). Maybe your kernel/userspace pair is out of<br>sync.<br><br>If the problem persists, add
 some printk into the path the<br>rt_intr_create syscall takes. Start here:<br><br>http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/syscall.c#3066<br><br>Jan<br><br></blockquote><br><p>&#32;__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1079913404-1166716821=:923--

