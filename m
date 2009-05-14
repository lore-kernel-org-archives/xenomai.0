Message-ID: <4A0C1B0D.1050104@domain.hid>
Date: Thu, 14 May 2009 15:22:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF8AF478EE.52F5DF3F-ONC12575B5.004203DE-C12575B5.0042CC16@domain.hid>
In-Reply-To: <OF8AF478EE.52F5DF3F-ONC12575B5.004203DE-C12575B5.0042CC16@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

henning.richter@domain.hid wrote:
> Hi Gilles, Hi list,
> 
> nearly everything is working fine. I rebuild the kernel again without the
> given options and it seems to work.
> Even the latencies look quite much better. There is only one problem left
> that bothers me.
> 
> Every time I load the rt_eepro100 for my real-time device I get the
> message:
> 
> [   95.753152]   *** Receiver lock-up bug detected ***
> [   95.753154]   Your device may not work reliably!
> 
> and sometimes the systems hangs (and can not be woken up) at this point.
> 
> I know that this is a hint for a irq problem but I don't know where this
> should be.
> My eth0 device (irq6) is not sharing this irq with an other deveice.
> 
> IRQs after boot:

Hi,

when your question is new, please post a new message instead of replying
to an old thread. The person likely to answer your question probably did
not even read your message because it is buried so deep in a thread
which I handled until now.

Regards.

-- 
                                                 Gilles.

