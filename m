Message-ID: <4C2C0519.3090506@domain.hid>
Date: Wed, 30 Jun 2010 20:01:45 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>	<4C2A518F.8030302@domain.hid>	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>	<4C2B0043.1070108@domain.hid>
	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
In-Reply-To: <AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> However, I am having problems with the kernel - any user-space Xenomai
> program gives me the following error:
> Xenomai or CONFIG_OPT_PERVASIVE disabled.
> (modprobe xeno_nucleus?)
> Kernel-space programs give me the following error:
> open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or
> directory
> modprobe klat_mod or try the -P latency
>
> I've tried the obvious solutions (tweaking kernel configs, enabling
> debug, etc...) but no clues on how to fix the error.

You did not say explicitly: did you do the modprobes as suggested in the 
error messages above?

                       - Tom

