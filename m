Message-ID: <e39c9190708061123k18f7e6afw260cc3ec5f3d18bb@domain.hid>
Date: Mon, 6 Aug 2007 20:23:14 +0200
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <18103.24835.247952.219162@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_136662_6560820.1186424594760"
References: <a18a592b0708060815s4a1d30c0w906ff61d9acb0fab@domain.hid>
	<18103.24835.247952.219162@domain.hid>
Subject: Re: [Xenomai-help] newbie question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

------=_Part_136662_6560820.1186424594760
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/6/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
>
> What you are referring to is the priority coupling between Xenomai and
> Linux schedulers, and can be disabled in Xenomai configuration.
>
> The linux kernel will keep the inherited priority until the RT-task
> calls xenomai again, or until it is suspended by Linux scheduler. If the
> RT-task does not call xenomai for a while (and is not suspended by Linux
> scheduler), then, well, it is an RT-task after all and should be able to
> run until it reaches a suspension point or wakes up another RT-task.

Hello both, i have a newbie doubt

What should i understand by a "xenomai" call ?
Does it simple means to call a symbol owned by the xenomai libs ?

Note however that during this time, Linux interruptions will be allowed
> to preempt the RT-task.
>
I think  that if one design a source thread/rt-task whatever which is
focused on rt constrains,
one would like to acquire ASAP the same rt-context free of such preempt
policy.
Right now i can hold a exhaustive monitoring related on my performed systems
calls
but i also suppose that at same place/time i will need some linux
service, and therefore a good practice could be quite useful, any hint
about?

Cheers

------=_Part_136662_6560820.1186424594760
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/6/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>What you are referring to is the priority coupling between Xenomai and<br>Linux schedulers, and can be disabled in Xenomai configuration.<br><br>The linux kernel will keep the inherited priority until the RT-task<br>calls xenomai again, or until it is suspended by Linux scheduler. If the
<br>RT-task does not call xenomai for a while (and is not suspended by Linux<br>scheduler), then, well, it is an RT-task after all and should be able to<br>run until it reaches a suspension point or wakes up another RT-task.
</blockquote><div>Hello both, i have a newbie doubt<br><span class="gmail_quote"></span><br>What should i understand by a &quot;xenomai&quot; call ? <br>Does it simple means to call a symbol owned by the xenomai libs ?&nbsp;  
<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Note however that during this time, Linux interruptions will be allowed<br>to preempt the RT-task.
<br></blockquote><div>I think&nbsp; that if one design a source thread/rt-task whatever which is focused on rt constrains, <br>one would like to acquire ASAP the same rt-context free of such preempt policy. <br>Right now i can hold a exhaustive monitoring related on my performed systems calls
<br>but i also suppose that at same place/time i will need some linux <br>service, and therefore a good practice could be quite useful, any hint about?<br></div><br>Cheers</div>

------=_Part_136662_6560820.1186424594760--

