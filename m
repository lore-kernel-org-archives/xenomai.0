Message-ID: <b647ffbd0703241536v1630d8a3g112e4e55e96acf68@domain.hid>
Date: Sat, 24 Mar 2007 23:36:51 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: [off-list] Re: [Xenomai-help] [RT_PIPE] - User space read() not
	waking up
In-Reply-To: <1174737325.20953.24.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_248342_28768533.1174775811811"
References: <20070322215707.232970@domain.hid>
	<b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>
	<460481F2.5010408@domain.hid>
	<b647ffbd0703240320ta4f54ccg344108ddd1f47958@domain.hid>
	<1174737325.20953.24.camel@domain.hid>
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
Cc: Viktor STARK <stark.viktor@domain.hid>, Xenomai help <xenomai@xenomai.org>

------=_Part_248342_28768533.1174775811811
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 24/03/07, Philippe Gerum <rpm@xenomai.org> wrote:
>
> [...]
> I would add that if you really want to keep the pipe semantics for
> exchanging data without crossing domains between real-time tasks, then
> you may access the real-time API of message pipes from user-space too.
> i.e.
> rt_pipe_create/bind/delete/read/write/stream() are all available from a
> user-space application, in which case data exchange will happen in
> primary mode.


rt_pipe_read -> rt_pipe_receive -> xnpipe_recv -> take from state->inq

rt_pipe_write -> rt_pipe_send -> xnpipe_send -> put into state->outq

So there are 2 different queues.

If a user space side makes use of rt_pipe_read(), then a kernel side
(driver) should use
xnpipe_write(), not rt_pipe_*


For data transfer in the opposite direction, [user space] rt_pipe_write()
---> [kernel space] xnpipe_read()


kernel-side:
>
> void foo_task(void)
> {
>         for (;;) {
>                 rt_pipe_read/write(&pipe_desc, ...);
>         }
> }
>
> int init_module(void)
> {
>         rt_pipe_create(&pipe_desc, "channel", ...);
> }
>
> user-space side:
>
> int main(int argc, char *argv[])
> {
> #ifdef REALTIME_TO_REALTIME
>         /* promote main() to the Xenomai real-time space */
>         rt_task_shadow(&task_desc, __FUNCTION__, ...);
>         /* bind to the pipe created in kernel space */
>         rt_pipe_bind(&pipe_desc, "channel", TM_INFINITE);
>         for (;;) {
>                 rt_pipe_read/write(&pipe_desc, "channel", ...);
>         }
> #else /* REALTIME_TO_REGULAR */
>         fd = open("/proc/xenomai/registry/native/pipes/channel",O_RDWR);
>         for (;;) {
>                 read/write(fd, ...);
>         }
> #endif
> }
> --
> Philippe.
>
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_248342_28768533.1174775811811
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 24/03/07, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">rpm@xenomai.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
[...]<br>I would add that if you really want to keep the pipe semantics for<br>exchanging data without crossing domains between real-time tasks, then<br>you may access the real-time API of message pipes from user-space too.
<br>i.e.<br>rt_pipe_create/bind/delete/read/write/stream() are all available from a<br>user-space application, in which case data exchange will happen in<br>primary mode.</blockquote><div><br>
rt_pipe_read -&gt; rt_pipe_receive -&gt; xnpipe_recv -&gt; take from state-&gt;inq<br>
<br>
rt_pipe_write -&gt; rt_pipe_send -&gt; xnpipe_send -&gt; put into state-&gt;outq<br>
<br>
So there are 2 different queues.<br>
<br>
If a user space side makes use of rt_pipe_read(), then a kernel side (driver) should use<br>
xnpipe_write(), not rt_pipe_*<br>
<br>
<br>
For data transfer in the opposite direction, [user space] rt_pipe_write() ---&gt; [kernel space] xnpipe_read()<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">kernel-side:<br><br>void foo_task(void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (;;) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_pipe_read/write(&amp;pipe_desc,
...);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>}<br><br>int init_module(void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_pipe_create(&amp;pipe_desc, &quot;channel&quot;, ...);<br>}<br><br>user-space side:<br><br>int main(int argc, char *argv[])<br>{<br>#ifdef REALTIME_TO_REALTIME
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* promote main() to the Xenomai real-time space */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_shadow(&amp;task_desc, __FUNCTION__, ...);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* bind to the pipe created in kernel space */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_pipe_bind(&amp;pipe_desc, &quot;channel&quot;, TM_INFINITE);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (;;) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_pipe_read/write(&amp;pipe_desc,
&quot;channel&quot;, ...);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>#else /* REALTIME_TO_REGULAR */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fd = open(&quot;/proc/xenomai/registry/native/pipes/channel&quot;,O_RDWR);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (;;) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;read/write(fd, ...);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>#endif<br>}<br>--<br>Philippe.<br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_248342_28768533.1174775811811--

