Message-ID: <e39c9190803081026s88acfe1h7dbef2f26ec7acc5@domain.hid>
Date: Sat, 8 Mar 2008 19:26:46 +0100
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <47D2D537.7020106@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_33008_33544334.1205000806518"
References: <e39c9190803080255s7020537co8ea96ab71ed6ecc2@domain.hid>
	<47D27C0A.2010507@domain.hid>
	<e39c9190803080624sf49293bwff20317788ad28f7@domain.hid>
	<e39c9190803080942k302e66a6m75ed94dccd55aaac@domain.hid>
	<47D2D537.7020106@domain.hid>
Subject: Re: [Xenomai-help] Posix skin and message queues operation mode
	misunderstanding
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

------=_Part_33008_33544334.1205000806518
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Mar 8, 2008 at 7:04 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> Yes it does. Maybe contributing the needed support for SIGEV_THREAD to the
> Xenomai library would spare you way more invasive changes to your code
> base.
> After all, honoring SIGEV_THREAD seems to me a matter of running a server
> thread
> in the background to poll for notifications, which is what we do in a
> number of
> occasions for other skins. Additionally, we don't actually care if this
> support
> is only available to userland programs, and not to kernel-based modules.
>
> Philippe.
>

I see, well, imho its a performance issue for our concerns, we developed our
APIs, in general terms, based on threads dispatching instead of signal
delivering due to the "historic" limited bandwidth in the signal mechanisms
under Unix/Linux..whatever.

Right now, we dont have a clear idea about it..  so we move on in a first
approach with software re-usage issues in mind cause we have already passed
a validation proccess. Anyway the required modifications seems not to be too
hard(right now), so before deep inside we will check our application
prototypes following your current capabilities..

Best regards.

------=_Part_33008_33544334.1205000806518
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Mar 8, 2008 at 7:04 PM, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Yes it does. Maybe contributing the needed support for SIGEV_THREAD to the<br></div>
Xenomai library would spare you way more invasive changes to your code base.<br>
After all, honoring SIGEV_THREAD seems to me a matter of running a server thread<br>
in the background to poll for notifications, which is what we do in a number of<br>
occasions for other skins. Additionally, we don&#39;t actually care if this support<br>
is only available to userland programs, and not to kernel-based modules.<br>
<div><div></div><br></div><font color="#888888">Philippe.<br>
</font></blockquote></div><br>I see, well, imho its a performance issue for our concerns, we developed our APIs, in general terms, based on threads dispatching instead of signal delivering due to the &quot;historic&quot; limited bandwidth in the signal mechanisms under Unix/Linux..whatever. <br>
<br>Right now, we dont have a clear idea about it..&nbsp; so we move on in a first approach with software re-usage issues in mind cause we have already passed a validation proccess. Anyway the required modifications seems not to be too hard(right now), so before deep inside we will check our application prototypes following your current capabilities..&nbsp;  <br>
<br>Best regards.

------=_Part_33008_33544334.1205000806518--

