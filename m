Message-ID: <462882BD.6000203@domain.hid>
Date: Fri, 20 Apr 2007 11:07:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>	<078801c77d27$5e7cc420$1b764c60$@com>	<461E6CFE.7000004@domain.hid>	<009301c77da1$124fba10$36ef2e30$@com>
	<17960.30503.154972.409174@domain.hid>
	<00e801c78328$d2569a90$7703cfb0$@com>
In-Reply-To: <00e801c78328$d2569a90$7703cfb0$@com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jose Pascual <josepascual@domain.hid>
Cc: adeos-main@gna.org

Jose Pascual wrote:
> Hi Gilles,
> 
> Thank you so much for your answer,
> 
> Do you have a ipipe patch for 2.6.20? is only for at91sam9261 or I can use
> it for at91rm9200?

The patch for 2.6.20 only exists on my disk and is only tested on
at91rm9200. I need to test the compilation on other ARMs, but I should
publish it soon after.

> I'm having in ethernet driver some ROVR errors because dma became full for
> load in linux, do 
> you think adeos-ipipe can help me in it? shoud it be necessary to change
> ethernet irq (portng to adeos)?

You could port it to RTnet, you will get low latency IP/UDP, but beware,
RTnet is incompatible with plain ipv4, so, if you want to run a network
with RTnet, all machines on the network need to run RTnet.

-- 
                                                 Gilles Chanteperdrix

