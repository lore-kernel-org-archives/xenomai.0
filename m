Message-ID: <4D237F62.2030609@domain.hid>
Date: Tue, 04 Jan 2011 21:13:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D233AB4.5070702@domain.hid> <4D2352C9.9050006@domain.hid>
	<4D2377B5.1040807@domain.hid>
	<4D23785B.5050108@domain.hid> <4D2379EF.5@domain.hid>
	<4D237A89.3010205@domain.hid> <4D237CA9.2090408@domain.hid>
In-Reply-To: <4D237CA9.2090408@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai failure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tamas Szklenar <tszklenar@domain.hid>
Cc: xenomai@xenomai.org

Tamas Szklenar wrote:
> Hi
> 
> Sure, I attach it to the mail. I tried to load the xeno modules one by 
> one, this is in the log too.
> 
> Thanks for the help!

Ok. -19 is -ENODEV, it usually means that the timer initialization
failed. Could you try enabling CONFIG_HIGHRES_TIMERS? From the config
file you sent it is disabled, but I am not sure it is the one you are
running, since in the configuration you sent CONFIG_XENO_OPT_NATIVE is
not compiled as a module, whereas according to your logs, the kernel you
are running obviously has it compiled as module.

Also, your kernel configuration has MSI enabled whereas it should not,
which indicates that you should probably check:
http://www.xenomai.org/index.php/Configuring_x86_kernels

-- 
                                                                Gilles.

