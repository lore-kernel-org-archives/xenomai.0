Message-ID: <4A5F5204.6080001@domain.hid>
Date: Thu, 16 Jul 2009 18:15:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>	
	<4A5EE47E.5000507@domain.hid>	
	<b88603c30907160224o7a0ebde0w6d52016dc40fccbe@domain.hid>	
	<4A5EF277.8090304@domain.hid>	
	<b88603c30907160239u3417036g1fa21251e7d4a379@domain.hid>	
	<4A5EF6E1.80108@domain.hid>	
	<b88603c30907160325k693081efi63b92b4e5f5a2e06@domain.hid>	
	<4A5F058B.2090808@domain.hid>	
	<b88603c30907160544q54968965q20c185bd1deae25a@domain.hid>	
	<4A5F3ED3.20608@domain.hid>
	<b88603c30907160809m1b186d12p6e58e3f578d3aed4@domain.hid>
In-Reply-To: <b88603c30907160809m1b186d12p6e58e3f578d3aed4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation fault
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
> Unfortunately enabling the CONFIG_VFP in the kernel config and
> building the xenomai with CFLAGS="-mfpu=vfp -mfloat-abi=softfp"
> LDFLAGS="-mfpu=vfp -mfloat-abi=softfp" had no success and results in a
> system hang-up again. The only thing that works for me is disabling
> the CONFIG_VFP in the kernel with -msoft-float for the xenomai user
> build.

Ok. Do you generate a libc? In that case it should be built with support
for VFP? Or do you copy the one from the toolchain?

I am afraid Xenomai VFP support was written with armv6 and may not work
for the 926EJ-S which is an armv5. I will try and have a look.

-- 
                                          Gilles


