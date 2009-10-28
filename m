Message-ID: <4AE8748B.3070706@domain.hid>
Date: Wed, 28 Oct 2009 17:42:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30910280734i7a823063s75b420720fdf3707@domain.hid>	
	<4AE858F0.4010600@domain.hid>	
	<b88603c30910280753uea312e1p3d5f62012814d355@domain.hid>	
	<4AE860FB.4090903@domain.hid>	
	<b88603c30910280825t39954bddl48f33c76181b9938@domain.hid>	
	<4AE86335.5030106@domain.hid>
	<b88603c30910280917x1eaa89f2q26c7283e381d05f1@domain.hid>
In-Reply-To: <b88603c30910280917x1eaa89f2q26c7283e381d05f1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Read TSC results in bus error (ARM iMX25)
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
> This code is part of the iMX25 bsp that is not part of any kernel yet,
> so generating a patch is not possible. Seems the upcoming 2.6.32
> kernel will have support for iMX25, but the -rc5 still has
> build-failures for this platform.

Ok. But could you point me to the code in the mach-mx3 tree? I do not
find any cpu.c. The Denx Qong box probably has the same issue as imx25,
and I would be interested in fixing it.

> 
> Maybe the complete BSP with ipipe for the iMX25 and 2.6.28 kernel
> might be interesting for release (similar as the patch
> ipipe-2.6.26-mxc.diff), but is still in an early development state:
> now the latency app runs I see it runs fine only for a few minutes and
> then gets overruns... asks for debugging ;-)

Ok. You can try and use the I-pipe tracer. And make sure to run latency
-p 1000. I can have a look at your I-pipe code to see if I do not see
anything obvious.

-- 
                                          Gilles


