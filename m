Message-ID: <4A43896E.7030600@domain.hid>
Date: Thu, 25 Jun 2009 16:27:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1245226350.3614.10.camel@domain.hid>
	<E5CDD68F7A516B4F863D651CDA2DBF71010A9E62@domain.hid>
In-Reply-To: <E5CDD68F7A516B4F863D651CDA2DBF71010A9E62@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] message pipe services
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: LEMARCHAND Ludovic <Ludovic.LEMARCHAND@tech.viveris.com>
Cc: xenomai@xenomai.org

LEMARCHAND Ludovic wrote:
> Hello
> 
> I have an application with xenomai task and a standard linux process in order to establish a communication between them.
> I have read that message pipe services is the best solution.
> 
> So, I tested the pipe.c exemple, but it doesn't compile. I have include native/pipe.h library but it doesn't find RT_PIPE_MSG and rt_pipe_alloc().
> So, I take a look at the library and this elements are declared between ifdef __KERNEL__ ... endif, but this condition is never validate.
> 
> How can I register my xenomai task as __KERNEL__ ? Is it automatic, have I something to do ?

See:
http://www.xenomai.org/documentation/trunk/html/api/group__pipe.html

Each service documentation tells the context from which it may be
called. Some services may only be called from kernel context (that is,
if you are compiling a kernel module), some other may be called from
user-space.

What you are likely looking for is rt_pipe_create.

-- 
                                          Gilles


