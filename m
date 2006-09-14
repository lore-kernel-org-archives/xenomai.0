Message-ID: <b647ffbd0609140525h62ddc07crca474ba48c67863d@domain.hid>
Date: Thu, 14 Sep 2006 14:25:39 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] premetion
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D6951562F@INDEXCH2003.gmi.domain>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_235577_17048786.1158236739469"
References: <9D98C51005D80D43A19A3DF329A61D6951562F@INDEXCH2003.gmi.domain>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nilanjan Roychowdhury <Nilanjan.Roychowdhury@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_235577_17048786.1158236739469
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 14/09/06, Nilanjan Roychowdhury <Nilanjan.Roychowdhury@domain.hid> wrote:
>
>  Can a normal Linux thread ( pthread with priority 90) can preempt any
> user space XENOMAI thread with priority (85). If the XENOMAI thread is
> running in primary domain ???
>

No. The secondary domain (i.e. Linux) gets control only when there is no
activity in the primary one. OTOH, primary domain activities may always
(well, if it's not a case of cross-domain synchonization) preempt the ones
from linux domain.
That's why, e.g. kernel-space real-time threads or ISR must not use linux
kernel services, the kernel could have been preempted at any point and,
thus, it's not-reentrant.



-- 
Best regards,
Dmitry Adamushko

------=_Part_235577_17048786.1158236739469
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 14/09/06, <b class="gmail_sendername">Nilanjan Roychowdhury</b> &lt;<a href="mailto:Nilanjan.Roychowdhury@domain.hid">Nilanjan.Roychowdhury@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>








<div link="blue" vlink="purple" lang="EN-US">

<div>

<p><font face="Arial" size="2"><span style="font-size: 10pt; font-family: Arial;">Can a normal Linux thread ( pthread with priority 90) can
preempt any user space XENOMAI thread with priority (85). If the XENOMAI thread
is running in primary domain ???</span></font></p></div></div></div></blockquote><div><br>
No. The secondary domain (i.e. Linux) gets control only when there is
no activity in the primary one. OTOH, primary domain activities may
always (well, if it's not a case of cross-domain synchonization)
preempt the ones from linux domain.<br>
That's why, e.g. kernel-space real-time threads or ISR must not use
linux kernel services, the kernel could have been preempted at any
point and, thus, it's not-reentrant.<br>
&nbsp;</div></div><br>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_235577_17048786.1158236739469--

