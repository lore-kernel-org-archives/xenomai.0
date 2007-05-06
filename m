Message-ID: <7289437c0705060731h4234f196gfcde2753fa65e976@domain.hid>
Date: Sun, 6 May 2007 16:31:37 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <463B33BC.5020408@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_30759_317123.1178461897772"
References: <7289437c0705040615n2272cf83oeec8db0a7dda910c@domain.hid>
	<463B33BC.5020408@domain.hid>
Subject: Re: [Xenomai-help] Problem to compile for ARM
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

------=_Part_30759_317123.1178461897772
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks a lot, it works fine.
I did this : essai_mutex_rt.o -lpthread_rt -lpthread -lrt   in the linker
command line.


On 5/4/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Perrine Martignoni wrote:
> > Hello,
> >
> > I have some problems to compile my code Posix for ARM. I have installed
> > xenomai in /usr/xenomai_arm-2.3.1 for ARM.
> >
> > Here is my compilation :
> > (...)
> > -L/usr/xenomai_arm-2.3.1/lib -lpthread_rt -lpthread -lrt
> > essai_mutex_rt.o   -o essai_mutex_rt
>
> The order of arguments on the linker command line is important, this
> should be:
>
> essai_mutex_rt.o -lpthread_rt -lpthread -lrt
>
> --
>                                                  Gilles Chanteperdrix
>

------=_Part_30759_317123.1178461897772
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks a lot, it works fine.<br>I did this : essai_mutex_rt.o -lpthread_rt -lpthread -lrt&nbsp;&nbsp; in the linker command line.<br><br><br><div><span class="gmail_quote">On 5/4/07, <b class="gmail_sendername">Gilles Chanteperdrix</b>
 &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Perrine Martignoni wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I have some problems to compile my code Posix for ARM. I have installed<br>&gt; xenomai in /usr/xenomai_arm-2.3.1 for ARM.<br>&gt;<br>&gt; Here is my compilation :<br>
&gt; (...)<br>&gt; -L/usr/xenomai_arm-2.3.1/lib -lpthread_rt -lpthread -lrt<br>&gt; essai_mutex_rt.o&nbsp;&nbsp; -o essai_mutex_rt<br><br>The order of arguments on the linker command line is important, this<br>should be:<br><br>essai_mutex_rt.o -lpthread_rt -lpthread -lrt
<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_30759_317123.1178461897772--

