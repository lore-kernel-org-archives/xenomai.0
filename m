Subject: Re: [Adeos-main] adeos_tune_timer()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <40C03A5E.7030006@domain.hid>
References: <40C03A5E.7030006@domain.hid>
Content-Type: text/plain
Message-Id: <1086254126.680.15.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 03 Jun 2004 11:15:26 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Fri, 2004-06-04 at 11:01, Wolfgang Grandegger wrote:
> Hello,
> 
> the function adeos_tune_timer() allows to change the tick frequency of
> the hardware timer. I wonder if Linux is aware of this change? Doesn't
> it still believe that the timer interrupt comes at a rate of 100 Hz?
> 

No, Linux is not aware of that. It's the burden of the domain tuning the
timer to also intercept the timer interrupt and propagate one of them
down the pipeline at the proper pace (e.g. 1 from 10 if the domain sets
the timer for ticking at 10Khz, and Linux expects 1Khz), so that Linux
is not affected by the change. Of course, this only works if the timer
is tuned by a domain more prioritary than Linux, so such propagation can
occur; less prioritary domains should not have to grab the timer anyway.

IIRC, some example code in the tree illustrates this principle for the
timer IRQ.

> Wolfgang.
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 

Philippe.


