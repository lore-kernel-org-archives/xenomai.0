Message-ID: <4AD73ABD.60107@domain.hid>
Date: Thu, 15 Oct 2009 17:07:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AD738F3.8030200@domain.hid>
In-Reply-To: <4AD738F3.8030200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question about 'native skin
 or	CONFIG_XENO_OPT_PERVASIVE' problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: xenomai@xenomai.org

Benjamin Biegel wrote:
> Hello
> 
> I am new to the world of patching kernels etc. But i managed to install 
> xenomai guided by http://www.xenomai.org/index.php/Xenomai_quick_build_quide
> 
> However when trying to execute the ./trivial-periodic i get the 
> following error:
> 'Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled. (modproble 
> xeno_native?)'
> 
> I honestly don't know what this indicates. Not even where the 
> CONFIG_XENO_OPT_PERVASIVE flag is set.

The CONFIG_* options are linux kernel configuration options. The message
tells you that if you have compiled the native skin as module, you
should load the module, and that since you want to use it in user-space,
you should enable real-time in user-space, that is the
CONFIG_XENO_OPT_PERVASIVE option.

Nevertheless, the default configuration should have all this. So, if you
did not change the kernel configuration and get this error, could you
show us your kerne boot logs, and kernel configuration?

-- 
                                          Gilles


