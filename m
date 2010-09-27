Message-ID: <4CA08F40.2000701@domain.hid>
Date: Mon, 27 Sep 2010 14:34:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim0ROW9R84M2cmxBOKc3m2EUuPOUK5og0p5ErcN@mail.gmail.com>	<4C9D0ACB.1000004@domain.hid>	<4C9D0B69.4000507@domain.hid>
	<AANLkTimtQT3U=pdjLY3aDu9zFK2h6oG59vqN1cQHk=uA@mail.gmail.com>
In-Reply-To: <AANLkTimtQT3U=pdjLY3aDu9zFK2h6oG59vqN1cQHk=uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_start returns -38 (ENOSYS)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: martin mangard <martin@domain.hid>
Cc: xenomai@xenomai.org

martin mangard wrote:
> Hello
> 
> I did some more research.
> What I haven't memtioned is, that I'm using openembedded to build
> xenomai. It turned out that the reason that caused the ENOSYS error
> was the same as descibed in:
> 
> https://mail.gna.org/public/xenomai-help/2009-08/msg00047.html
> 
> I changed the CFLAGS and the latency test program worked without
> errors. It seems to me that some people have made xenomai recipes but
> none of them made their way into the
> openembedded repository. Maybe I will post my recipe in the
> openembedded mailinglist to discuss the possibilities of a xenomai
> integration in openembedded.

Ok. But maybe we should fix Xenomai too...

-- 
					    Gilles.

