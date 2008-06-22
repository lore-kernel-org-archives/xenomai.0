Message-ID: <485EAC26.8040407@domain.hid>
Date: Sun, 22 Jun 2008 21:46:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6132061f0806190723x7f1716f4v1b3f3831c78717f6@domain.hid>	
	<485E6AC6.9070005@domain.hid>
	<6132061f0806221237l24195e2ta5a0e62e9f890c36@domain.hid>
In-Reply-To: <6132061f0806221237l24195e2ta5a0e62e9f890c36@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai App question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: xenomai@xenomai.org

Breno Carneiro Pinheiro wrote:
> Thanks Gilles. On my system I have:
> 
> *include/config/auto.conf:CONFIG_XENO_OPT_TIMING_PERIODIC=y
> include/linux/autoconf.h:#define CONFIG_XENO_OPT_TIMING_PERIODIC 1*
> 
> Is that correctly set? I wanna run periodic tasks and my processor's clock
> is 400Mhz. Which is the best config.?

Read the help about this option in the Kernel configuration menu. It 
will tell you all you need to know.

-- 


					    Gilles.

