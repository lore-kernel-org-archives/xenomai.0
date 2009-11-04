Message-ID: <4AF15B38.4080104@domain.hid>
Date: Wed, 04 Nov 2009 11:45:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <11361891.1003501257322627993.JavaMail.defaultUser@domain.hid>
In-Reply-To: <11361891.1003501257322627993.JavaMail.defaultUser@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] BUG: scheduling while atomic
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "cagnulein@domain.hid" <cagnulein@domain.hid>
Cc: xenomai@xenomai.org

cagnulein@domain.hid wrote:
> I've tried with your patch and asking to do latency test with 1000ns but

It is 1000us, not 1000ns. No platform running xenomai is able to sustain
a task with a 1000ns period.

> the result is still the same :(
> Do you have any other ideas? I'm very lost in space :(

The error you have is undoubtedly the one I talk about in the mail I
sent you. Are you sure you recompiled the kernel after applying the
patch and booted on that modified kernel? To be sure about that, you can
add a printk somewhere and check in the boot logs that this message is
printed.

If you want a solution which works out of the box, please use Xenomai
2.4.9.1 with one of the I-pipe patches it contains.
-- 
                                          Gilles


