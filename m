From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTikH_NciDFN402p-bvPW__K2du9bZRgcS7AUfz+t@domain.hid>
References: <AANLkTikH_NciDFN402p-bvPW__K2du9bZRgcS7AUfz+t@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Feb 2011 21:00:10 +0100
Message-ID: <1298318410.2075.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_pipe_stream: not getting EPIPE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: varname <varname@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2011-02-21 at 18:54 +0100, varname wrote:
> All,
> 
> trying to write a simple producer / consumer using message pipes in
> the native API, this phrase from the documentation (found here [1])
> confuses me:
> 
> "-EPIPE is returned if the associated special device is not yet open."
> 
> It's not so much the sentence itself, but more the fact that I'm not
> getting that return value from rt_pipe_stream() when streaming bytes
> to a RT_PIPE that hasn't had its "special device" opened in secondary
> domain.
> 
> I've attached a modified trivial-periodic.c that demonstrates what I'm
> seeing. Afaik there is nothing open(2)-ing the /dev/rtp9 in the
> secondary domain. All writes succeed, up to about write 31 (*1024),
> after which all writes return 0.
> 
> [..]
> wrote: 1024, res: 1024
> wrote: 1024, res: 948
> wrote: 1024, res: 0
> wrote: 1024, res: 0
> [..]
> 
> Is the documentation incorrect, or am I misunderstanding something?

The doc is wrong (former implementation, 2.1.x series), the pipe
services do buffer real-time output until the special device is
eventually opened starting with Xenomai 2.2.x. Since you are using
rt_pipe_stream(), the output is directed to an internal buffer until
there is no more space there, which causes the final 0-byte returns.

So everything looks ok, except the doc.

> 
> Related info:
>   Xenomai: 2.5.5.2
>   Kernel: 2.6.32.26
> 
> [1] http://www.xenomai.org/documentation/trunk/html/api/group__pipe.html#gb4d85ecda7675a75611500070c28b22e
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



