Message-ID: <4D238C56.40906@domain.hid>
Date: Tue, 04 Jan 2011 22:08:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D233AB4.5070702@domain.hid> <4D2352C9.9050006@domain.hid>
	<4D2377B5.1040807@domain.hid>
	<4D23785B.5050108@domain.hid> <4D2379EF.5@domain.hid>
	<4D237A89.3010205@domain.hid> <4D237CA9.2090408@domain.hid>
	<4D237F62.2030609@domain.hid> <4D2381B6.80304@domain.hid>
In-Reply-To: <4D2381B6.80304@domain.hid>
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
> Hi Gilles,
> 
> Thanks for the help. In a previous kernel config I used 
> CONFIG_HIGH_RES_TIMERS, but I had the same failure.
> I will change my config now and I will send you a mail if I'm finished.

I have no real idea then. Please try and boot the kernel with loglevel=7
and capture the logs with netconsole (your kernel seems to have
netconsole enabled, you only need to configure it, see
Documentation/networking/netconsole.txt in the kernel sources).

-- 
                                                                Gilles.

