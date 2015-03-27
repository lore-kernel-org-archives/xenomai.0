MIME-Version: 1.0
In-Reply-To: <CACreCV+tYp1QConFh2uKWjnqVOQ4uA=xLmbyay_XT9mui0txfw@mail.gmail.com>
References: <CACreCVLijm5Wup7aTrRTq=SHBmEUQY5D2pYpXThWXSrGqpcuqw@mail.gmail.com>
 <20150318142119.GF24525@hermes.click-hack.org>
 <CACreCV+WajHg9wKp3HpxZ4uVdva5ADAWtOH6DDjPfWzcyNk2YQ@mail.gmail.com>
 <20150318145611.GG24525@hermes.click-hack.org>
 <CACreCV+VoYvYQbejhJ2RzU9ZJDUBExwZyRv-DFs3TzWtQvzZkg@mail.gmail.com>
 <20150325145730.GJ15125@hermes.click-hack.org>
 <CACreCVLQk_4i7OdMdOFBG6cLKxh3-qJLZGMoz9i_q4XoZPbdoA@mail.gmail.com>
 <20150325160852.GK15125@hermes.click-hack.org>
 <CACreCV+tYp1QConFh2uKWjnqVOQ4uA=xLmbyay_XT9mui0txfw@mail.gmail.com>
Date: Fri, 27 Mar 2015 18:19:01 +0800
Message-ID: <CACreCVLG=dtjriCzUUqYtOK1Pz+NqYoPFNLJZ4KrM-AccBoHPA@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

What happens in between the clocksource switch and head domain registration?

[    0.090129] DMA: preallocated 4096 KiB pool for atomic coherent
allocations
[    0.095333] Switching to clocksource ipipe_tsc
[    0.122397] I-pipe: head domain Xenomai registered.
[    0.124618] Xenomai: hal/arm started.

I'm trying to trace the code to find out where it stops. I tried
adding printk to to the set and request functions and the code never
runs when CONFIG_SMP is enabled.

Thanks,

GP Orcullo

