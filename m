Message-ID: <231e15c10711280045p3dd7ec1arf871b8d3395a7167@domain.hid>
Date: Wed, 28 Nov 2007 16:45:05 +0800
From: "=?GB2312?B?xtbSwcfH?=" <heyanandsu@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2960_7333719.1196239505217"
Subject: [Xenomai-help] native pipe can not write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_2960_7333719.1196239505217
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I try to use the message pipe in native API, but I can not write to the
pipe. Can anyone help me to find what is wrong?
And in Linux side it says:"write failed: Cannot allocate memory"
Thank you!
Following is the program and return message.
#./test_pipe
create return: 0, write return: -12, read return: -110

#include <stdio.h>
#include <errno.h>
#include <native/task.h>
#include <sys/mman.h>

RT_PIPE pipe_desc;
RT_TASK task;

void op_pipe(void *arg)
{
        int  err, pipe_fd, wre, rre;
        char buf[16] = {'a', 'b', 'c'};
        char rd;

        err = rt_pipe_create(&pipe_desc, "my_testpipe2", 3, 128);
        char tmp[] = {"test pipe"};

        wre = rt_pipe_write(&pipe_desc, buf, 2, P_NORMAL);
        rre = rt_pipe_read(&pipe_desc, &rd, 2, 100);

       printf("create return: %d, write return: %d, read return: %d\n", err,
wre, rre);
      //printf("write return %s\n", rt_pipe_write(&pipe_desc, &tmp, 9,
P_NORMAL));


        rt_pipe_delete(&pipe_desc);

}


int main(int argc, char *argv[])
{
        int  err, pipe_fd, wre, rre;

        mlockall(MCL_CURRENT|MCL_FUTURE);

        err = rt_task_create(&task,"test_pipe_task",0,1,T_FPU);
        if(err < 0)
                printf("task create error \n");
        err = rt_task_start(&task, &op_pipe, NULL);
        if(err < 0)
                printf("task start error \n");

        rt_task_delete(&task);
        return 0;

}



Best wishes

                        Pu Yiqiao(Joy)

------------------------------------------------
Add: Tianshui South Road 222, Lanzhou, P.R.China
Tel: +86-931-8912025
fax: +86-931-8912025
Zip Code: 73000
URL: http://dslab.lzu.edu.cn
E-mail: puyq06@domain.hid

------=_Part_2960_7333719.1196239505217
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, <br>

I try to use the message pipe in native API, but I can not write to the pipe. Can anyone help me to find what is wrong? <br>

And in Linux side it says:&quot;write failed: Cannot allocate memory&quot;<br>

Thank you!<br>

Following is the program and return message.<br>

#./test_pipe<br>

create return: 0, write return: -12, read return: -110<br>

<br>

#include &lt;stdio.h&gt;<br>

#include &lt;errno.h&gt;<br>

#include &lt;native/task.h&gt;<br>

#include &lt;sys/mman.h&gt;<br>

<br>

RT_PIPE pipe_desc;<br>

RT_TASK task;<br>

<br>

void op_pipe(void *arg)<br>

{<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp; err, pipe_fd, wre, rre;<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[16] = {&#39;a&#39;, &#39;b&#39;, &#39;c&#39;};<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char rd;<br>

<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = rt_pipe_create(&amp;pipe_desc, &quot;my_testpipe2&quot;, 3, 128);<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char tmp[] = {&quot;test pipe&quot;};<br>

<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wre = rt_pipe_write(&amp;pipe_desc, buf, 2, P_NORMAL);<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rre = rt_pipe_read(&amp;pipe_desc, &amp;rd, 2, 100);<br>

<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;create return: %d, write return: %d, read return: %d\n&quot;, err, wre, rre);<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //printf(&quot;write return %s\n&quot;, rt_pipe_write(&amp;pipe_desc, &amp;tmp, 9, P_NORMAL));<br>

<br>

<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_pipe_delete(&amp;pipe_desc);<br>

<br>

}<br>

<br>

<br>

int main(int argc, char *argv[])<br>

{<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp; err, pipe_fd, wre, rre;<br>

<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<br>

<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = rt_task_create(&amp;task,&quot;test_pipe_task&quot;,0,1,T_FPU);<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err &lt; 0)<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;task create error \n&quot;);<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = rt_task_start(&amp;task, &amp;op_pipe, NULL);<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err &lt; 0)<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;task start error \n&quot;);<br>

<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_delete(&amp;task);<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>

<br>

}<br>

<br>

<br>
<br>
<tt>Best wishes</tt><br>

<br>

<tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Pu Yiqiao(Joy)</tt><br>

<br>

<tt>------------------------------------------------</tt><br>

<tt>Add: Tianshui South Road 222, Lanzhou, P.R.China</tt><br>

<tt>Tel: +86-931-8912025</tt><br>

<tt>fax: +86-931-8912025</tt><br>

<tt>Zip Code: 73000</tt><br>

<tt>URL: <a href="http://dslab.lzu.edu.cn/">http://dslab.lzu.edu.cn</a></tt><br>

<tt>E-mail: <a href="mailto:puyq06@domain.hid">puyq06@domain.hid</a></tt><br>

<br>


------=_Part_2960_7333719.1196239505217--

