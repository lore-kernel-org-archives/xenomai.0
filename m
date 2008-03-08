Message-ID: <e39c9190803080624sf49293bwff20317788ad28f7@domain.hid>
Date: Sat, 8 Mar 2008 15:24:59 +0100
From: "juanba romance" <juanba.romance@domain.hid>
In-Reply-To: <47D27C0A.2010507@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32768_6106911.1204986299241"
References: <e39c9190803080255s7020537co8ea96ab71ed6ecc2@domain.hid>
	<47D27C0A.2010507@domain.hid>
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

------=_Part_32768_6106911.1204986299241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Mar 8, 2008 at 12:44 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> your mq_notify() call actually fails, because SIGEV_THREAD is not
> currently
> supported. SIGEV_SIGNAL is. A bug in the interface library prevents you
> from
> getting the right call status.
>
> --- src/skins/posix/mq.c        (revision 3549)
> +++ src/skins/posix/mq.c        (working copy)
> @@ -191,6 +191,14 @@
>
>  int __wrap_mq_notify(mqd_t mqdes, const struct sigevent *notification)
>  {
> -       return -XENOMAI_SKINCALL2(__pse51_muxid,
> -                                 __pse51_mq_notify, mqdes, notification);
> +       int err;
> +
> +       err = XENOMAI_SKINCALL2(__pse51_muxid,
> +                               __pse51_mq_notify, mqdes, notification);
> +       if (err) {
> +               errno = -err;
> +               return -1;
> +       }
> +
> +       return 0;
>  }
>
> --
> Philippe.
>

I got it, uhmm i will applied above patch on our current tree to prevent
future misunderstandings
Anyway i will check the probe program using the SIGEV_SIGNAL feedback method
instead of

Thanks a lot Philippe
cheers

------=_Part_32768_6106911.1204986299241
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Mar 8, 2008 at 12:44 PM, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">your mq_notify() call actually fails, because SIGEV_THREAD is not currently<br></div></div>
supported. SIGEV_SIGNAL is. A bug in the interface library prevents you from<br>
getting the right call status.<br>
<br>
--- src/skins/posix/mq.c &nbsp; &nbsp; &nbsp; &nbsp;(revision 3549)<br>
+++ src/skins/posix/mq.c &nbsp; &nbsp; &nbsp; &nbsp;(working copy)<br>
@@ -191,6 +191,14 @@<br>
<br>
&nbsp;int __wrap_mq_notify(mqd_t mqdes, const struct sigevent *notification)<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; return -XENOMAI_SKINCALL2(__pse51_muxid,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __pse51_mq_notify, mqdes, notification);<br>
+ &nbsp; &nbsp; &nbsp; int err;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; err = XENOMAI_SKINCALL2(__pse51_muxid,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __pse51_mq_notify, mqdes, notification);<br>
+ &nbsp; &nbsp; &nbsp; if (err) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; errno = -err;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -1;<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+<br>
+ &nbsp; &nbsp; &nbsp; return 0;<br>
&nbsp;}<br>
<br>
--<br>
<font color="#888888">Philippe.<br>
</font></blockquote></div><br>I got it, uhmm i will applied above patch on our current tree to prevent future misunderstandings <br>Anyway i will check the probe program using the SIGEV_SIGNAL feedback method instead of<br>
<br>Thanks a lot Philippe<br>cheers<br>

------=_Part_32768_6106911.1204986299241--

