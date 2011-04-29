Message-ID: <4DBA9C26.2040903@domain.hid>
Date: Fri, 29 Apr 2011 17:08:22 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>	<4DB9B978.2010200@domain.hid>
	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
	<4DB9C0D3.4030003@domain.hid>
In-Reply-To: <4DB9C0D3.4030003@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

On 04/29/2011 01:32 AM, Gilles Chanteperdrix wrote:
> Maybe you can try booting with MMC disabled, to see if the I-pipe is
> working? Not permanently, just to confirm that you are not chasing the
> wrong bug.
Thank you for the root image!

Just did some simple checks.

It works with the same kernel, just with MMC card removed (heartbeat
blinks, "Waiting for root").
It STOPS working (heartbeat stops blinking) immediately after inserting
either MMC or USB flash. So it is not exactly MMC related, any interrupt
source (both MMC and USB) results in lockup.

The lockup is not immediate, it works for some short time (enough to
print kind of "new device found" to dmesg).

It does not depend on drivers actually compiled in, it depends on
devices being initialized. It stops working as soon as some hardware
starts sending frequent interrupts.

Now going to try your asm patch.

--
Alex



