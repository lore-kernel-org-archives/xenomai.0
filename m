Message-ID: <d3623eab0801110806y75b51c1kc31efe7d357de522@domain.hid>
Date: Fri, 11 Jan 2008 11:06:35 -0500
From: "Jerome Pasquero" <jay@domain.hid>
Sender: jerome.pasquero@domain.hid
In-Reply-To: <d3623eab0801110744y63764ba2sb122db96a85bde80@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1820_17648766.1200067595410"
References: <d3623eab0801110744y63764ba2sb122db96a85bde80@domain.hid>
Subject: [Xenomai-help] cannot make system() calls anymore
Reply-To: jay@domain.hid
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

------=_Part_1820_17648766.1200067595410
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I recently upgraded from xenomai 2.3.0 under linux 2.6.17.14 to the latest
stable version of xenomai 2.4.1 under linux 2.6.23.12.
Everything seems to be working just fine, except that I seem to  no longer
be able to make system calls inside a real-time task. It simply freezes
everything and I need to restart my computer.
I don't know if it was just a fluke that it was working with 2.3.0 and that
I am not supposed to do that at all. Could it be that I forgot to include an
option when recompiling the kernel?

Note that I have no problem making system calls from outside a real time
task (for instance, right before a rt_task_shadow() call).
Also, it seems that the problem only occurs when other libraries are used.
For instance, if one compiles the code below with no other libraries than
the xenomai libs (and stdc++), it works just fine:
gcc  `/usr/xenomai/bin/xeno-config --xeno-cflags`
`/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative main.cpp

However, as soon as I add the libxml2 library, it crashes:
gcc  -D_GNU_SOURCE -D_REENTRANT -D__XENO__  -I/usr/include/libxml2
-I/usr/xenomai-2.4.1/include  -L/usr/local/lib -L/usr/xenomai-2.4.1/lib
-lxml2 -lnative -lpthread `/usr/xenomai/bin/xeno-config --xeno-cflags`
`/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative main.cp

This is true with other libraries as well (e.g. gsl lib) but not of all
libraries (for instance, it seems to work with the math library i.e. -lm)

Am I doing something wrong?
In case you were wondering, I want to be able to make system calls from
inside real time threads cause I want to load/unload realtime modules
directly from my application. In the code snippet below, I am simply trying
to do a  'ls'  command to keep it as simple as possible.

Thanks for your help in advance.


#include <iostream>
#include <sys/mman.h>
#include <signal.h>
#include <native/mutex.h>
#include <native/timer.h>
#include <native/task.h>

void cleanup(int unused)
{
    // delete current task
    rt_task_delete(NULL);
}

int main(int argc, char *argv[])
{
    signal(SIGABRT, cleanup);
    signal(SIGKILL, cleanup);
    signal(SIGINT, cleanup);
    signal(SIGTERM, cleanup);
    signal(SIGHUP, cleanup);
    signal(SIGALRM, cleanup);


    RT_TASK mainTask;

    mlockall(MCL_CURRENT | MCL_FUTURE);
    rt_task_shadow(&mainTask, "gui", 50, T_FPU);

    rt_task_sleep((RTIME) 1E9);

    system("ls"); // this is what causes the problem...

    cleanup(0);

    return 0;
}


-jerome

-- 
Jerome Pasquero
Ph.D. Student
McGill University
Montreal

------=_Part_1820_17648766.1200067595410
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote">Hi, <br><br>I recently upgraded from xenomai 2.3.0 under linux <a href="http://2.6.17.14" target="_blank">2.6.17.14</a> to the latest stable version of xenomai 2.4.1 under linux <a href="http://2.6.23.12" target="_blank">
2.6.23.12</a>.<br>Everything seems to be working just fine, except that I seem to&nbsp; no longer be able to make system calls inside a real-time task. It simply freezes everything and I need to restart my computer.
<br>I don&#39;t know if it was just a fluke that it was working with 2.3.0 and that I am not supposed to do that at all. Could it be that I forgot to include an option when recompiling the kernel?<br><br>Note that I have no problem making system calls from outside a real time task (for instance, right before a rt_task_shadow() call).
<br>Also, it seems that the problem only occurs when other libraries are used.<br>For instance, if one compiles the code below with no other libraries than the xenomai libs (and stdc++), it works just fine:<br>gcc&nbsp; `/usr/xenomai/bin/xeno-config --xeno-cflags` `/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative 
main.cpp<br><br>However, as soon as I add the libxml2 library, it crashes:<br>gcc&nbsp; -D_GNU_SOURCE -D_REENTRANT -D__XENO__&nbsp; -I/usr/include/libxml2 -I/usr/xenomai-2.4.1/include&nbsp; -L/usr/local/lib -L/usr/xenomai-2.4.1/lib -lxml2 -lnative -lpthread `/usr/xenomai/bin/xeno-config --xeno-cflags` `/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative 
main.cp<br><br>This is true with other libraries as well (e.g. gsl lib) but not of all libraries (for instance, it seems to work with the math library i.e. -lm)<br><br>Am I doing something wrong?<br>In case you were wondering, I want to be able to make system calls from inside real time threads cause I want to load/unload realtime modules directly from my application. In the code snippet below, I am simply trying to do a&nbsp; &#39;ls&#39;&nbsp; command to keep it as simple as possible.
<br><br>Thanks for your help in advance. <br><br><br>#include &lt;iostream&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;signal.h&gt;<br>#include &lt;native/mutex.h&gt;<br>#include &lt;native/timer.h&gt;<br>#include &lt;native/task.h&gt;
<br>&nbsp;<br>void cleanup(int unused)<br>{<br>&nbsp;&nbsp;&nbsp; // delete current task<br>&nbsp;&nbsp;&nbsp; rt_task_delete(NULL);<br>} <br><br>int main(int argc, char *argv[])<br>{<br>&nbsp;&nbsp;&nbsp; signal(SIGABRT, cleanup);&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; signal(SIGKILL, cleanup);&nbsp;&nbsp;&nbsp; 
<br>&nbsp;&nbsp;&nbsp; signal(SIGINT, cleanup);<br>&nbsp;&nbsp;&nbsp; signal(SIGTERM, cleanup);<br>&nbsp;&nbsp;&nbsp; signal(SIGHUP, cleanup); <br>&nbsp;&nbsp;&nbsp; signal(SIGALRM, cleanup);<br><br><br>&nbsp;&nbsp;&nbsp; RT_TASK mainTask;<br><br>&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT | MCL_FUTURE);<br>&nbsp;&nbsp;&nbsp; rt_task_shadow(&amp;mainTask, &quot;gui&quot;, 50, T_FPU);
<br>&nbsp; <br>&nbsp;&nbsp;&nbsp; rt_task_sleep((RTIME) 1E9);<br><br>&nbsp;&nbsp;&nbsp; system(&quot;ls&quot;); // this is what causes the problem...<br><br>&nbsp;&nbsp;&nbsp; cleanup(0);<br><br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br>
</div><br><br>-jerome<br clear="all"><br>-- <br>Jerome Pasquero<br>Ph.D. Student<br>McGill University<br>Montreal<br>

------=_Part_1820_17648766.1200067595410--

