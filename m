Message-ID: <46483114.30808@domain.hid>
Date: Mon, 14 May 2007 11:51:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0705140221tb124a04mcbf9910e47d3ac2e@domain.hid>
In-Reply-To: <7289437c0705140221tb124a04mcbf9910e47d3ac2e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
> Hello,
>  
> I'm writing an application using Message queue and mq_send returns the
> errno value EBADF.
> I don't understand what I'm doing wrong, I need some help.

I see nothing obvious, EBADF usually means that the queue descriptor is
incorrect, or that the open mode is incorrect. I will try your example
later.

-- 
                                                 Gilles Chanteperdrix

