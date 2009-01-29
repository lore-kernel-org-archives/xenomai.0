Message-ID: <4981862D.9000901@domain.hid>
Date: Thu, 29 Jan 2009 10:34:21 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CDD78C600C124BCC853CDDDEEDDB1749@domain.hid>
In-Reply-To: <CDD78C600C124BCC853CDDDEEDDB1749@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_pipe_read returns -ENOBUFS
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: newsgroup <newsgroup@domain.hid>
Cc: xenomai@xenomai.org

newsgroup wrote:
> Hello,
> 
> ive got an userspace process running in realtime and try to communicate to another process unsing the Pipes.
> rt_pipe_write() to the non realtime process works fine. ich can read the /dev/rtp1 without problems.
> 
> Now i try to write from this process to the realtime process using the /dev/rtp2.
> The rt_pipe_read() returns a -ENOBUFS.
> 
> here the call (dirty copy): 
> 
> struct struct_FIFO_Header {
>  unsigned short ID;
>  unsigned short Size;
>  };
> 
> struct_FIFO_Header _Header;
>     
> ret = rt_pipe_read(&pipe_read,&_Header,sizeof(_Header),TM_NONBLOCK );
> 
> ret is now -ENOBUFS
> 
> Ive done similar the same using rtai without problems.
> anone an idea why it occours?

The great thing with Xenomai compared to rtai is that it has doc. But if
you do not use it, you are right, you have no reason to use Xenomai
instead of rtai.

-- 
                                                 Gilles.

