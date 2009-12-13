Message-ID: <4B25014E.9050407@domain.hid>
Date: Sun, 13 Dec 2009 15:59:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <94A6EC74-5941-40D6-9F99-6DF96D1FD006@domain.hid>
In-Reply-To: <94A6EC74-5941-40D6-9F99-6DF96D1FD006@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [i.MX27] imx serial driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paolo Bernini <nihil84@domain.hid>
Cc: xenomai@xenomai.org

Paolo Bernini wrote:
> Hello all, first of all I introduce myself: I am Paolo Bernini and I
> am a student of University of Pisa.
> 
> While working on my thesis I wrote a real time driver for i.MX
> special serial devices based on current implementation of 16550A. It
> is very simple, it has several limitations and it is tested only for
> i.MX27 processors, but it should support any i.MX processor if
> supplied of their memory map of the devices.
> 
> Actually it allocate only one device and the only way to choose
> which, is by in code constraints definitions but it can be easily
> enhanced, I think.
> 
> If you are interested I can send it to you as is.
> 
> 
> Thanks.

Hi,

I suspect this serial driver would interest many users of the imx
architecture, so, could you send it as a patch against the head branch?

Thanks in advance.

-- 
					    Gilles.

