Message-ID: <4AB22C38.4030304@domain.hid>
Date: Thu, 17 Sep 2009 14:31:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0909160436q12741cbat2b5aabde83dc0171@domain.hid>
In-Reply-To: <7a15153d0909160436q12741cbat2b5aabde83dc0171@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PXA] How to use GPIO
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Felipe Castro wrote:
> Hi all !
> 
> I found a thread about using GPIO in real time domain with PXA processor,
> and in that thread there are some patch to implement that.
> It's a old thread so, this patch was included in the last adeos-ipipe patch
> ? There are some code to test the GPIO access ?

The I-pipe patch includes the code to demultiplex GPIOs interrupts. But
we have no driver for access to GPIOs. Maybe someone could define an
RTDM profile to do so. It would be a good idea to look at what Linux
does, and do approximatively the same thing. If you do this, we would be
glad to include in xenomai code base.

-- 
					    Gilles.

