Message-ID: <4F14CD27.2020701@domain.hid>
Date: Tue, 17 Jan 2012 02:21:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMak2D-C8E3GVhymyOUEF6hztdgnXnczNzEMNoO9sHqemxL9Zg@domain.hid>
In-Reply-To: <CAMak2D-C8E3GVhymyOUEF6hztdgnXnczNzEMNoO9sHqemxL9Zg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper using 90% CPU...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

On 01/17/2012 02:14 AM, Eric Eric wrote:
> (snip)
> /proc/xenomai/stat shows about double the number of mode switches for my
> benchmark versus in-kernel periodic task.  While this may not be optimal,
> it doesn't seem like it should bring gatekeeper from 1% CPU to 90% CPU
> usage.  My system is a beagleboard XM running Xenomai 2.6.0 with the TI
> 2.6.37 kernel with beagle board patches applied.
> 
> As always, thanks for any assistance.

Show us the source. Also note that spinning in primary mode more than
10ms is a bad idea, as the linux kernel will then try to catch up with
the lost ticks. gatekeeper activity is normally the sign of mode
switches. As for the mode switches detection, check
examples/native/sigdebug.c.

-- 
                                                                Gilles.

