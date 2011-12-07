Message-ID: <4EDFA127.3060609@domain.hid>
Date: Wed, 07 Dec 2011 18:23:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4ED8EEB1.1040904@domain.hid> <4EDE5AFA.2050503@domain.hid>
	<4EDF7A34.2020701@domain.hid>
In-Reply-To: <4EDF7A34.2020701@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai installation: high latencies
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kurt Geebelen <kurt.geebelen@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/07/2011 03:37 PM, Kurt Geebelen wrote:
> Hi all,
> 
> Sorry for taking so long to respond, I didn't have time to work on it. 
> SMI's didn't appear to be the problem, and I also am not using the 
> nvidia binary driver.
> 
> I tried disabling USB in the BIOS, and that helped! My latencies are now 
> under 6 microseconds. Since I don't need USB (I'm using a PS/2 mouse and 
> keyboard now), I'll use it like this.

Usually, only legacy USB emulation is a source of problems. You can
disable it in BIOS configuration. Sometimes, enabling USB in kernel
configuration (and loading USB modules at run time) is enough as the USB
modules disable legacy emulation as part of their initialization.

-- 
					    Gilles.

