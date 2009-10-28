Message-ID: <4AE86335.5030106@domain.hid>
Date: Wed, 28 Oct 2009 16:28:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30910280734i7a823063s75b420720fdf3707@domain.hid>	
	<4AE858F0.4010600@domain.hid>	
	<b88603c30910280753uea312e1p3d5f62012814d355@domain.hid>	
	<4AE860FB.4090903@domain.hid>
	<b88603c30910280825t39954bddl48f33c76181b9938@domain.hid>
In-Reply-To: <b88603c30910280825t39954bddl48f33c76181b9938@domain.hid>
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
> Hi Gilles,
> 
> I found the problem.
> 
> There seems to be a sw-workaround needed to access the peripherals in
> user-mode. It is implemented in cpu.c, which the bsp for the iMX25 did
> not have, but the iMX3 has. I implemented the post_cpu_init() call for
> the iMX25 and now the access is fine.
> 
> Thanks for your reply!

Could you send me a patch? We will put this in the I-pipe patch.

-- 
                                          Gilles


