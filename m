Message-ID: <d6c8ef150803130423p63a0a43esb37b74efcf009476@domain.hid>
Date: Thu, 13 Mar 2008 12:23:02 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <2ff1a98a0803130412h12261b67n3b43912354173107@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803130409g2a618d30gbede878d6a09e470@domain.hid>
	<2ff1a98a0803130412h12261b67n3b43912354173107@domain.hid>
Subject: Re: [Xenomai-help] [Adeos-main] New I-pipe patch for ARM.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

# cat /proc/interrupts
           CPU0
  1:      16079         AIC  atmel_serial
 12:          2         AIC  atmel_spi.0
 17:    1015857         AIC  at91_tick
 82:          0        GPIO  eth0
Err:          0

# cat /proc/xenomai/irq
IRQ         CPU0
 17:     1062363         [timer]
194:           0         [virtual]

On Thu, Mar 13, 2008 at 12:12 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, Mar 13, 2008 at 12:09 PM, Bosko Radivojevic
>  <bosko.radivojevic@domain.hid> wrote:
>  > Hi Gilles,
>  >
>  >  I have a quite strange problem. I successfully compiled kernel
>  >  (2.6.24.3+at91 patch) with Xenomai-trunk (2.4.2 wont compile with the
>  >  new ipipe patch). Kernel boots OK on At91SAM9260 based board (but with
>  >  DM9000 on it). Strange problem is that Ethernet communication is not
>  >  working, I'm getting following error on console (after trying some
>  >  pings):
>  >  NETDEV WATCHDOG: eth0: transmit timed out
>
>  Ok. Could you show us /proc/interrupts and /proc/xenomai/irq ?
>
>  --
>   Gilles Chanteperdrix
>

