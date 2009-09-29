Message-ID: <4AC23564.6020709@domain.hid>
Date: Tue, 29 Sep 2009 18:27:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580909242312i2a817f43y6a63a8d15631d3ec@domain.hid>	
	<4ABC8140.4000301@domain.hid>	
	<1f3e02580909250400r7595efw769fedac12b71fce@domain.hid>	
	<4ABCA99D.1040206@domain.hid>	
	<1f3e02580909250526v52a0408ex455cc22191f3802@domain.hid>	
	<4ABCC977.6010500@domain.hid>
	<1f3e02580909280458ubf3f610he5e52aab1efa1cc6@domain.hid>
In-Reply-To: <1f3e02580909280458ubf3f610he5e52aab1efa1cc6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: jorge.ramirez@domain.hid, Xenomai help <xenomai@xenomai.org>, mohamad.sharifi@domain.hid

Didenko Sergey wrote:
> Dear Gilles
> 
> 
>> Ok. You do not need to send me the sources, I found what I needed in the
>> .config you sent me. To add support the SOC quickly, you have to follow
>> this howto: http://www.xenomai.org/index.php/I-pipe:ArmPorting
> 
> 
> I'm coming through this guide...and so far I do not have a good progress
> having real hard time with configuring the timig related functions and
> definitions...
> meanwhile, could you please clarify one thing: If target ARCH is not
> supported by Xenomai, after I did patch the Kernel with Xenomai, what kind
> of configuration has been patched? What else should I do after doing all
> steps from to HOWTO?

Well, you need to follow the README.INSTALL guide to install Xenomai
using your modified kernel. You need to add some stuff to configure.in
if you want to use the TSC emulation in user-space, but it is not
important for a first step, so you should configure Xenomai with the
--enable-arm-mach=generic. Then run the latency test to see whether the
system is running.

P.S: please do not forget to CC the mailing list.

-- 
					    Gilles.

