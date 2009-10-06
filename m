Message-ID: <4ACB5F62.5050609@domain.hid>
Date: Tue, 06 Oct 2009 17:16:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DIIE.000001AF0000AC52@domain.hid>
In-Reply-To: <DIIE.000001AF0000AC52@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: oliver.schlenker@domain.hid
Cc: xenomai@xenomai.org

oliver.schlenker@domain.hid wrote:
> 
> 
> Hi,
> 
> we are using a xenomai system with kernel 2.6.22 and xenomai 2.4.7.
> 
> There is some strange behaviour when using rt_printf in one of our
> application. The application is setup as a server process, which itself
> is setting up several xenomai tasks. 
> All rt_printf outputs are displayed correctly as long as the server process is not daemonized. 
> 
> If the server process is daemonized with code like
> 
> if( (pid=fork()) < 0 )
> {
>         return(-1);
> }else
> {
>         if( pid != 0 )
>         {
>             exit(0);
>         }
> }

This is over-simplified. You process is not really daemonized. You
should really call the glibc daemon() function.

> 
> all rt_printf-output is printed only when the server process exits
> and not during the time the server process is running.
> 
> 
> Any idea ?

I guess you do not need rt_printf output in the parent. So, you should
try and initialize the rt_printf library only in the child.

-- 
                                          Gilles


