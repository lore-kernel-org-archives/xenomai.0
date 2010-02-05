Message-ID: <4B6C1E66.2000008@domain.hid>
Date: Fri, 05 Feb 2010 14:34:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100204105700.GB20669@domain.hid>	
	<4B6ADA01.2080803@domain.hid>	
	<20100205103744.GA12904@domain.hid>	
	<4B6BFEDC.60403@domain.hid>
	<b88603c31002050439n790f4f71kd6e152198de511f2@domain.hid>
In-Reply-To: <b88603c31002050439n790f4f71kd6e152198de511f2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Force switch back to primary domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Unfortunately I was not able to capture the problem in a basic
> application :-( and I cannot sent our full application as is. It is
> easy to reproduce with our app.
> 
> But... As a quick (quick?!) test I disabled CONFIG_XENO_FASTSYNCH.
> Then I could not reproduce the problem anymore. So it I guess it is
> somewhere in that area...
> 
> We use the rt_mutex implementation from the Xenomai native skin from user space.

Maybe you could tell us on what platform you get the problem, and what
is the problem exactly? Does the mutex-torture-native unit test run fine?

It is very important for us to fix this ASAP, we can not afford to let
people know the bug exist and do nothing.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

