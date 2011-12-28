Message-ID: <4EFB0D66.8060306@domain.hid>
Date: Wed, 28 Dec 2011 13:36:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
	<4EFAE1BF.4090203@domain.hid>
	<000301ccc556$168472e0$438d58a0$@soterem.fr>
	<4EFB0456.9010409@domain.hid>
	<000d01ccc55c$3cc52d40$b64f87c0$@soterem.fr>
In-Reply-To: <000d01ccc55c$3cc52d40$b64f87c0$@soterem.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gregory Gosse <gregory.gosse@domain.hid>
Cc: 'xenomai-help' <xenomai@xenomai.org>

On 12/28/2011 01:28 PM, Gregory Gosse wrote:
> For the moment I use an Intel Core I5 as host and target .
> 
> Since I think I have to compile a  64bits kernel .

For x86_64 processors, you have the choice to compile a 32 bits or 64
bits kernels. If you have a 64 bits filesystem, you must compile a 64
bits kernel. If you have a 32 bits filesystem and want to compile a 64
bits kernel, you have to enable the 32 bits compatibility option.

> 
> Do you know where is located CONFIG_CC_STACKPROTECTOR in the configuration menu ?

Use ctrl-F to search if using "make xconfig" or "/" if using "make
menuconfig".

-- 
                                                                Gilles.

