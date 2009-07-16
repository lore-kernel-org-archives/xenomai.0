Message-ID: <4A5F058B.2090808@domain.hid>
Date: Thu, 16 Jul 2009 12:48:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907130031v9ec9618r46bd28b494ac3417@domain.hid>	
	<4A5CC870.3030208@domain.hid>	
	<b88603c30907160058n55d9a49eq644a2e326626bc01@domain.hid>	
	<4A5EE47E.5000507@domain.hid>	
	<b88603c30907160224o7a0ebde0w6d52016dc40fccbe@domain.hid>	
	<4A5EF277.8090304@domain.hid>	
	<b88603c30907160239u3417036g1fa21251e7d4a379@domain.hid>	
	<4A5EF6E1.80108@domain.hid>
	<b88603c30907160325k693081efi63b92b4e5f5a2e06@domain.hid>
In-Reply-To: <b88603c30907160325k693081efi63b92b4e5f5a2e06@domain.hid>
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
> I am using the xenomai-2.4.7 release and also the provided patch for
> the 2.6.28 kernel:
> xenomai-2.4.7/ksrc/arch/arm/patches/adeos-ipipe-2.6.28-arm-1.12-00.patch

Ok, so the issue with unmasked context switches is a red herring.
I see you have VFP enabled, does your processor really have a VFP unit?
Could you try disabling CONFIG_VFP?

Also note that to you must take care of the FPU instructions you use. If
you have VFP and want to use it (and have it enabled in kernel), you
should pass:
CFLAGS="-mfpu=vfp -mfloat-abi=softfp"
LDFLAGS="-mfpu=vfp -mfloat-abi=softfp"
on Xenomai's configure command line
if you want to compile for soft-floats, you should pass
CFLAGS="-msoft-float"
LDFLAGS="-msoft-float"

If you do not pass anything, the compiler will use instructions which
needs enabling the (slow) FPU emulation in kernel-space. So, I would
advise to start with -msoft-float first, disabling CONFIG_VFP in kernel
configuration, then if it works, try enabling CONFIG_VFP and recompile
user-space with proper options.

I am sorry for this, I took care of passing the proper compiler flags
for FP in head, but not in the v2.4 branch.

-- 
                                          Gilles


