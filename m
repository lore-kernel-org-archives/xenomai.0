Message-ID: <2ff1a98a0803130606u7d6dd7b3mce33a5e30735d11a@domain.hid>
Date: Thu, 13 Mar 2008 14:06:10 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150803130423p63a0a43esb37b74efcf009476@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803130409g2a618d30gbede878d6a09e470@domain.hid>
	<2ff1a98a0803130412h12261b67n3b43912354173107@domain.hid>
	<d6c8ef150803130423p63a0a43esb37b74efcf009476@domain.hid>
Subject: Re: [Adeos-main] New I-pipe patch for ARM.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Thu, Mar 13, 2008 at 12:23 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> # cat /proc/interrupts
>            CPU0
>   1:      16079         AIC  atmel_serial
>   12:          2         AIC  atmel_spi.0
>   17:    1015857         AIC  at91_tick
>   82:          0        GPIO  eth0
>  Err:          0
>
>  # cat /proc/xenomai/irq
>  IRQ         CPU0
>   17:     1062363         [timer]
>  194:           0         [virtual]
>

So, you do not seem to have any IRQ conflict. What is your main clock
frequency, 100 MHz ?

-- 
 Gilles Chanteperdrix

