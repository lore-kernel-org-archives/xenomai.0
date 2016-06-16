Date: Thu, 16 Jun 2016 19:16:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160616171605.GD32532@hermes.click-hack.org>
References: <D9EDB4F689BF9F4EA6F2158A073942732E8007D6@de08ex3008.global.ds.honeywell.com>
 <20160608193911.GA31360@hermes.click-hack.org>
 <D9EDB4F689BF9F4EA6F2158A073942732E8008F3@de08ex3008.global.ds.honeywell.com>
 <20160609174118.GD1785@hermes.click-hack.org>
 <575AF2E1.3060401@siemens.com>
 <D9EDB4F689BF9F4EA6F2158A073942732E801DAA@de08ex3008.global.ds.honeywell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9EDB4F689BF9F4EA6F2158A073942732E801DAA@de08ex3008.global.ds.honeywell.com>
Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Jun 16, 2016 at 03:51:17PM +0000, Heinick, J Michael wrote:
> problem, the stripped down driver would hang the core2 computer
> just like the i7 computer.

Are you running a graphic system? If yes, have you tried to plug a
serial console or netconsole to try and retrieve the kernel console
when the hang happens? Because if the hang is in fact a kernel oops,
the oops message may indicate what the problem is.

> Eventually, I noticed that only nrt
> handlers were specified in the ops structure. After moving our
> ioctl functions to .ioctl_rt, both the stripped down driver and
> the full driver run on both the core2 and i7 computers.

You can not call "sleeping" services from an _nrt handler. If that
is what you were doing.

> Why the core2 computers appeared to work with only the ioctl_nrt
> handler specified in the full driver and hang the i7 computer is
> still a mystery to us.

Did the two machines run with the same kernel? Or were there
differences in the kernel configuration? Like I-pipe checks
disabled/enabled?

-- 
					    Gilles.
https://click-hack.org

