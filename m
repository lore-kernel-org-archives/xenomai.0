Message-ID: <4EA524B4.3010701@domain.hid>
Date: Mon, 24 Oct 2011 10:41:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <584f2ab9.7f72956e.4e78ccaa.5171d@domain.hid>
	<4E78D7C0.2090108@domain.hid>
	<2b889a6c.722ea076.4ea51970.edef6@domain.hid>
In-Reply-To: <2b889a6c.722ea076.4ea51970.edef6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] installing xenomai on pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert <robert-km@domain.hid>
Cc: xenomai@xenomai.org

On 10/24/2011 09:53 AM, Robert wrote:
> Compiled the kernel, modules and copied uImage to boot partition.
> After reboot i got the following dmesg | grep -i xeno:
> user@domain.hid$ dmesg | grep -i xeno
> [    1.195556] I-pipe: Domain Xenomai registered.
> [    1.195587] Xenomai: hal/arm started.
> [    1.195861] Xenomai: scheduling class idle registered.
> [    1.195861] Xenomai: scheduling class rt registered.
> [    1.199798] Xenomai: real-time nucleus v2.6.0-rc5 (head) loaded.
> [    1.199798] Xenomai: debug mode enabled.
> [    1.590240] Xenomai: native skin init failed, code -19.
> [    1.590270] Xenomai: starting POSIX services.
> [    1.980804] Xenomai: POSIX skin init failed, code -19.
> [    2.371429] Xenomai: RTDM skin init failed, code -19.

Missed that. Please post us your .config

-- 
					    Gilles.

