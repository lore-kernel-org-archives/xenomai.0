Message-ID: <38b44d590703061059x1ddc72aau9ead4838a7fa6cb7@domain.hid>
Date: Wed, 7 Mar 2007 00:29:42 +0530
From: "Saiful Khan" <saiful.etc@domain.hid>
Subject: Re: [Xenomai-help] process memory not locked
In-Reply-To: <45EDAD18.9080701@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_109988_27671514.1173207582497"
References: <38b44d590703060949lfa70769na93c19abd2ff248f@domain.hid>
	<45EDAB66.9070700@domain.hid> <45EDAD18.9080701@domain.hid>
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

------=_Part_109988_27671514.1173207582497
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

First of all thank you a lot. For the last several days I am getting lots of
help from you. As well as I achived some positive results also. By the way
my observation now is -

mlockall is successfull
pthread_attr_init() - is successfull
pthread_attr_setdetachstate() - successfull
Here I am getting the message "Xenomai - process memory not locked (missing
mlockall?)" and its stuck.
pthread_create()  - this is returning nothing not success(0) nor failure.

What can be the possible reason?

Thanks and regards
Saiful




On 3/6/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Gilles Chanteperdrix wrote:
> >>2. What to do so that the thread also run in highest priority?
> >
> >
> > Use pthread_attr_setschedparam, or pthread_setschedparam.
> >
>
> Start here and follow the links:
>
>
> http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__posix__sched.html
>
> --
>                                                  Gilles Chanteperdrix
>

------=_Part_109988_27671514.1173207582497
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>First of all thank you a lot. For the last several days I am getting lots of help from you. As well as I achived some positive results also. By the way my observation now is -<br>&nbsp;<br>mlockall is successfull<br>
<span class="q">pthread_attr_init() - is successfull<br>pthread_attr_setdetachstate() - successfull<br>Here I am getting the message &quot;Xenomai - process memory not locked </span><span class="q">(missing mlockall?)</span>
<span class="q">&quot; and its stuck. <br>pthread_create()&nbsp; - this is returning nothing not success(0) nor failure.<br><br>What can be the possible reason? <br><br>Thanks and regards<br>Saiful<br><br><br></span><br><br><div>
<span class="gmail_quote">On 3/6/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Gilles Chanteperdrix wrote:<br>&gt;&gt;2. What to do so that the thread also run in highest priority?<br>&gt;<br>&gt;<br>&gt; Use pthread_attr_setschedparam, or pthread_setschedparam.<br>&gt;<br><br>Start here and follow the links:
<br><br><a href="http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__posix__sched.html">http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__posix__sched.html</a><br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix
<br></blockquote></div><br>

------=_Part_109988_27671514.1173207582497--

