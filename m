Message-ID: <4546494d0607120124t6a38b19dp8e9f4514c64309a2@domain.hid>
Date: Wed, 12 Jul 2006 16:24:46 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <44B4AA17.2050708@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_119218_233844.1152692686094"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B341E2.9040506@domain.hid>
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>
	<44B35346.2070200@domain.hid>
	<4546494d0607110043x45804030td009ed790040420b@domain.hid>
	<4546494d0607111851t3d432f80offde2c1a2ef37689@domain.hid>
	<44B497FE.9090207@domain.hid>
	<4546494d0607120034l3635fb89yda1c79bcbd6c196b@domain.hid>
	<44B4AA17.2050708@domain.hid>
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
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_119218_233844.1152692686094
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

But how to handle the situation when, e.g, a normal Linux task( in kernel
space) and a Xenomai task (in kernel space),
they share a global data structure. The Linux task want to block the Xenomai
task for a while when it handles this data structure, while
at the same time HW interrupt is enabled? When the data is ready, Xenomai
task is waken up.


Thanks,

-Yi

On 7/12/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Li Yi (Adam) wrote:
> > Thanks Jan.
> >
> > If I understand correctly, a normal Linux task (in kernel or user space)
> > may
> > call rt_task_suspend()/rt_task_resume()
> > to suspend/resume the execution of a RT task -- Originally I am thinking
> > only RT tasks can use such APIs - Looks I am wrong here.
>
> Hmm, in theory it should be no problem to call rt_task_suspend(task)
> with task != NULL from arbitrary contexts. But the native skin prevents
> this. I must confess I do not know the reason behind this right now. The
> point is that you do not need to block for remote-suspending some other
> task, thus the caller's context should not matter. Anyone else any idea?
>
> rt_task_resume() in contrast is fine from any context again.
>
> Jan
>
>
>
>

------=_Part_119218_233844.1152692686094
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

But how to handle the situation when, e.g, a normal Linux task( in kernel space) and a Xenomai task (in kernel space),<br>they share a global data structure. The Linux task want to block the Xenomai task for a while when it handles this data structure, while
<br>at the same time HW interrupt is enabled? When the data is ready, Xenomai task is waken up.<br><br><br>Thanks,<br><br>-Yi<br><br><div><span class="gmail_quote">On 7/12/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;
<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Li Yi (Adam) wrote:
<br>&gt; Thanks Jan.<br>&gt;<br>&gt; If I understand correctly, a normal Linux task (in kernel or user space)<br>&gt; may<br>&gt; call rt_task_suspend()/rt_task_resume()<br>&gt; to suspend/resume the execution of a RT task -- Originally I am thinking
<br>&gt; only RT tasks can use such APIs - Looks I am wrong here.<br><br>Hmm, in theory it should be no problem to call rt_task_suspend(task)<br>with task != NULL from arbitrary contexts. But the native skin prevents<br>this. I must confess I do not know the reason behind this right now. The
<br>point is that you do not need to block for remote-suspending some other<br>task, thus the caller's context should not matter. Anyone else any idea?<br><br>rt_task_resume() in contrast is fine from any context again.<br>
<br>Jan<br><br><br><br></blockquote></div><br>

------=_Part_119218_233844.1152692686094--

