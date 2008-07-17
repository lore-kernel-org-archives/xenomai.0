Message-ID: <5719c6f30807170812w30599c3ay19fd5b476b89d0f0@domain.hid>
Date: Thu, 17 Jul 2008 17:12:11 +0200
From: "Florent Audebert" <f.audebert@domain.hid>
In-Reply-To: <485B8332.90908@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5719c6f30805050943p31f3f5eew74d0f7ef3dd2b5a5@domain.hid>
	<4820B784.3080306@domain.hid>
	<5719c6f30806190900v5fea670amef6954efaae59882@domain.hid>
	<485B8332.90908@domain.hid>
Subject: Re: [Adeos-main] Advice regarding MIPS port
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

Hi,

I'm still on my the way with the MIPS port. My kernel is now booting
and I'm able to register a domain. I was successful catching various
interrupts (only printk'ing in the handler) using
ipipe_virtualize_irq().

Next, I would like to test syscalls grabbing. I tried registering an
handler with something like this in my test module :

ipipe_catch_event(ipipe_root_domain,
                           IPIPE_EVENT_SYSCALL,
                           (ipipe_event_handler_t)adeos_sys_handler);

Before testing on MIPS, I'm trying my module on X86 arch and it does
not work. I searched in Xenomai sources and didn't spot anything
specific when using ipipe_catch_event(). I'm obviously missing
something... What is the common way of using ipipe_catch_event() ?

This issue aside, do you have any advice concerning other tests cases ?


Regards,

-- 
Florent Audebert

