Message-ID: <4C402573.5090602@domain.hid>
Date: Fri, 16 Jul 2010 11:25:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikGMBzKX_Ci-vC_B_6nCiNNIq2VL5k3xBXdM297@domain.hid>
In-Reply-To: <AANLkTikGMBzKX_Ci-vC_B_6nCiNNIq2VL5k3xBXdM297@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Building Problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: PREMRAJ SV <svprem20@domain.hid>
Cc: xenomai@xenomai.org

PREMRAJ SV wrote:
> Dear all,
>              I am trying to compile and build xenomai-2.5.3 on
> linux-2.6.34..I am almost done with compilation with make
> menuconfig..Everything ran well without any error.. When i am trying the
> next step i.e, Building Xenomai for User space modules,
> 
> $<xenomai path/configure> --enable-linux-build=<linux tree>
> 
> The follwing steps are carried out,
> Making linux a shadow copy of <linux tree>
> Changing linux directory...
> Make[1]: Entering directory<linux tree/linux>
> ./config .status linux
> config.status: executing linux commands
> removing existing linux directory....done
> Making linux a shadow copy of <linux tree>  (cursor blinking)
> 
> This step stays for hours...

When doing this, if the machine you are using has lndir, lndir is used,
which is pretty fast if your machine is reasonably fast. If lndir is not
found, a replacement, written with find and some scriptery is used,
which may be pretty slow if your machine is slow. You do not tell us
much about your setup, but I guess Xenomai sources are on a slow storage
system, such as NFS over a 10 Mbits/sec network.

Anyway, please do not use --enable-linux-build if it is too slow on your
machine. I am thinking about removing --enable-linux-build in the 2.6
branch anyway, it does not really well cover all the cases.

-- 
					    Gilles.

