Message-ID: <b647ffbd0609140055t328fec1fi3b5d86da178d790e@domain.hid>
Date: Thu, 14 Sep 2006 09:55:34 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <4507C49A.5070909@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_233474_14579241.1158220534222"
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
	<1158091876.5020.8.camel@domain.hid>
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
	<450727D1.6060203@domain.hid> <4507C49A.5070909@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] Bad EIP kernel-Oops
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_233474_14579241.1158220534222
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 13/09/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:

It's the indirect call to the event handler.
>
>    8b3:   8b 55 e4                mov    0xffffffe4(%ebp),%edx
>    8b6:   50                      push   %eax
> -> 8b7:   ff 94 93 80 22 00 00    call   *0x2280(%ebx,%edx,4)
>    8be:   83 c4 0c                add    $0xc,%esp
>    8c1:   85 c0                   test   %eax,%eax
>
> In my case the kernel tries to access the address 0xd09bc5e5 which seems
> like it used to be a valid one.


I suppose, you have <= 256 Mb on this machine? If so, 0xd09bc5e5 belongs to
vmalloc()'ed area (in the past). So that was likely some module (e.g.
nucleus).


So this looks like we really need some mechanism to make sure all CPUs
> use the updated pointers after unhooking some event handler and before
> proceeding with further cleanups.


It's more complicated, I'm afraid. We need to be sure the event handler
function itself will not disappear in the mean time. Hence, module unloading
should be delayed, iow something alike synchronize_rcu() that blocks a
"cleanup caller" (which calls unregister_domain()) untill all the readers
are done with their activities.

Maybe it's wrong. Some more code reading would be required.



> Jan
>
>
-- 
Best regards,
Dmitry Adamushko

------=_Part_233474_14579241.1158220534222
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">On 13/09/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">jan.kiszka@domain.hid</a>&gt; wrote:
<br>
<br>
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">It's the indirect call to the event handler.<br><br>&nbsp;&nbsp;
8b3:&nbsp;&nbsp; 8b 55
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mov&nbsp;&nbsp;&nbsp;&nbsp;0xffffffe4(%ebp),%edx<br>&nbsp;&nbsp;
8b6:&nbsp;&nbsp;
50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;push&nbsp;&nbsp;
%eax<br>-&gt; 8b7:&nbsp;&nbsp; ff 94 93 80 22 00 00&nbsp;&nbsp;&nbsp;&nbsp;call&nbsp;&nbsp; *0x2280(%ebx,%edx,4)<br>&nbsp;&nbsp;
8be:&nbsp;&nbsp; 83 c4
0c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;add&nbsp;&nbsp;&nbsp;&nbsp;$0xc,%esp<br>&nbsp;&nbsp;
8c1:&nbsp;&nbsp; 85
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
test&nbsp;&nbsp; %eax,%eax<br><br>In my case the kernel tries to access the address 0xd09bc5e5 which seems<br>like it used to be a valid one.</blockquote><div><br>
I suppose, you have &lt;= 256 Mb on this machine? If so, 0xd09bc5e5
belongs to vmalloc()'ed area (in the past). So that was likely some
module (e.g. nucleus).<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">So this looks like we really need some mechanism to make sure all CPUs<br>use the updated pointers after unhooking some event handler and before
<br>proceeding with further cleanups.</blockquote><div><br>
It's more complicated, I'm afraid. We need to be sure the event handler
function itself will not disappear in the mean time. Hence, module
unloading should be delayed, iow something alike synchronize_rcu() that
blocks a &quot;cleanup caller&quot; (which calls unregister_domain()) untill all
the readers are done with their activities.<br>
<br>
Maybe it's wrong. Some more code reading would be required.<br>
<br>
</div>&nbsp;<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br></blockquote></div><br>-- <br>Best regards,<br>Dmitry Adamushko


------=_Part_233474_14579241.1158220534222--

