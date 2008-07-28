Message-ID: <488D9A75.1040705@domain.hid>
Date: Mon, 28 Jul 2008 12:07:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200807152346.21863.leo@domain.hid>
In-Reply-To: <200807152346.21863.leo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] OT. A question about constraints in realtime
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

Leopold Palomo Avellaneda wrote:
> The sensable people claims that their driver works with some versions of Linux 
> (till fedora 4 and some suse) but I'm not be able to run it in a debian etch. 
> I don't know if the distros provide a kernel with some kind of modifications 
> that solve it, but I don't think so.
> 
> 
> Well, thanks in advance and I'm sorry for the noise. Really, the realtime 
> stuff is something not obvious...

The first thing to do is to get statistics about the scheduling latency
of your driver. This means measuring the difference between the date
when the driver (kernel-code) wakes up the task and the date when the
task effectively runs. The bad news is that it will be hard with a
binary-only driver. If the driver has some compilable glue, then you can
hook into this glue, otherwise, you will have to resort to ugly hacks in
the kernel code.

If this latency is really the problem, then before resorting to xenomai,
you have linux-only solutions, like using a real-time priority for the
task using the driver.

-- 
                                                 Gilles.

