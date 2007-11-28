Message-ID: <231e15c10711280212p671f1379s5ebb45989e94e22f@domain.hid>
Date: Wed, 28 Nov 2007 18:12:48 +0800
From: "=?GB2312?B?xtbSwcfH?=" <heyanandsu@domain.hid>
In-Reply-To: <18253.13326.22540.125750@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3230_21510533.1196244768772"
References: <231e15c10711280045p3dd7ec1arf871b8d3395a7167@domain.hid>
	<18253.13326.22540.125750@domain.hid>
Subject: Re: [Xenomai-help] native pipe can not write
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
Cc: xenomai@xenomai.org

------=_Part_3230_21510533.1196244768772
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think that will just cause the failure of read operation. But in my case
write operation is failed before read. And I chage the program like this:
char rd[16]; ,the return values are still "create return: 0, write return:
-12, read return: -110". Is there any other possibility to lead these
errors? Thank you.


2007/11/28, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> wrote:
> > Hi,
> > I try to use the message pipe in native API, but I can not write to the
> > pipe. Can anyone help me to find what is wrong?
> > And in Linux side it says:"write failed: Cannot allocate memory"
> > Thank you!
> > Following is the program and return message.
> > #./test_pipe
> > create return: 0, write return: -12, read return: -110
> >
> > #include <stdio.h>
> > #include <errno.h>
> > #include <native/task.h>
> > #include <sys/mman.h>
> >
> > RT_PIPE pipe_desc;
> > RT_TASK task;
> >
> > void op_pipe(void *arg)
> > {
> >         int  err, pipe_fd, wre, rre;
> >         char buf[16] = {'a', 'b', 'c'};
> >         char rd;
> >
> >         err = rt_pipe_create(&pipe_desc, "my_testpipe2", 3, 128);
> >         char tmp[] = {"test pipe"};
> >
> >         wre = rt_pipe_write(&pipe_desc, buf, 2, P_NORMAL);
> >         rre = rt_pipe_read(&pipe_desc, &rd, 2, 100);
>
> I do not know if this is related with your issue, but the receive buff
> is too small: you want write 2 bytes in a 1 byte buffer.
>
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_3230_21510533.1196244768772
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think that will just cause the failure of read operation. But in my
case write operation is failed before read. And I chage the program
like this: char rd[16]; ,the return values are still &quot;create return: 0,
write return: -12, read return: -110&quot;. Is there any other possibility
to lead these errors? Thank you.<br>
<br><br><div><span class="gmail_quote">2007/11/28, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
 wrote:<br> &gt; Hi,<br> &gt; I try to use the message pipe in native API, but I can not write to the<br> &gt; pipe. Can anyone help me to find what is wrong?<br> &gt; And in Linux side it says:&quot;write failed: Cannot allocate memory&quot;
<br> &gt; Thank you!<br> &gt; Following is the program and return message.<br> &gt; #./test_pipe<br> &gt; create return: 0, write return: -12, read return: -110<br> &gt;<br> &gt; #include &lt;stdio.h&gt;<br> &gt; #include &lt;
errno.h&gt;<br> &gt; #include &lt;native/task.h&gt;<br> &gt; #include &lt;sys/mman.h&gt;<br> &gt;<br> &gt; RT_PIPE pipe_desc;<br> &gt; RT_TASK task;<br> &gt;<br> &gt; void op_pipe(void *arg)<br> &gt; {<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;err, pipe_fd, wre, rre;
<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[16] = {&#39;a&#39;, &#39;b&#39;, &#39;c&#39;};<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char rd;<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = rt_pipe_create(&amp;pipe_desc, &quot;my_testpipe2&quot;, 3, 128);<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char tmp[] = {&quot;test pipe&quot;};
<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wre = rt_pipe_write(&amp;pipe_desc, buf, 2, P_NORMAL);<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rre = rt_pipe_read(&amp;pipe_desc, &amp;rd, 2, 100);<br><br>I do not know if this is related with your issue, but the receive buff
<br>is too small: you want write 2 bytes in a 1 byte buffer.<br><br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles
Chanteperdrix.<br></blockquote></div><br>

------=_Part_3230_21510533.1196244768772--

