Message-ID: <7289437c0705150100m47ed71f5nb19f5f5f9468b794@domain.hid>
Date: Tue, 15 May 2007 10:00:48 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <17992.46476.24771.264671@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_96421_18120557.1179216048495"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0C9@domain.hid>
	<17992.46476.24771.264671@domain.hid>
Subject: Re: [Xenomai-help] Problem with Message queue
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

------=_Part_96421_18120557.1179216048495
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for all of your ideas.
I solve my issue.

On 5/14/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Fillod Stephane wrote:
> > Perrine Martignoni wrote:
> > [..]
> > >int DESTRUCT=0;
> >
> > I'm always nervous to see global variables shared among threads without
> > a volatile keyword. An explicit memory barrier would be better, as it
> > has been re-explained in a LWN article lately (wait Thursday for free
> access)
> > http://lwn.net/Articles/233479/
>
> Besides, this termination mechanism results on a deadlock on SMP. Please
> kill this DESTRUCT variable and replace cleanup_upon_sig with:
>
> void cleanup_upon_sig(int sig __attribute__((unused)))
>
> {
>        pthread_cancel(task1);
>        pthread_cancel(task2);
> }
>
>
> --
>
>
>                                            Gilles Chanteperdrix.
>

------=_Part_96421_18120557.1179216048495
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Thanks for all of your ideas.</div>
<div>I solve my issue.<br>&nbsp;</div>
<div><span class="gmail_quote">On 5/14/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Fillod Stephane wrote:<br>&gt; Perrine Martignoni wrote:<br>&gt; [..]<br>&gt; &gt;int DESTRUCT=0;<br>&gt; 
<br>&gt; I&#39;m always nervous to see global variables shared among threads without<br>&gt; a volatile keyword. An explicit memory barrier would be better, as it<br>&gt; has been re-explained in a LWN article lately (wait Thursday for free access)
<br>&gt; <a href="http://lwn.net/Articles/233479/">http://lwn.net/Articles/233479/</a><br><br>Besides, this termination mechanism results on a deadlock on SMP. Please<br>kill this DESTRUCT variable and replace cleanup_upon_sig with:
<br><br>void cleanup_upon_sig(int sig __attribute__((unused)))<br><br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_cancel(task1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_cancel(task2);<br>}<br><br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix.
<br></blockquote></div><br>

------=_Part_96421_18120557.1179216048495--

