Date: Tue, 29 Sep 2015 10:41:44 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20150929104144.70f30775@md1em3qc>
In-Reply-To: <20150929012542.GC15767@hermes.click-hack.org>
References: <20150929012542.GC15767@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe tracer issue on at91
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, 29 Sep 2015 03:25:42 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> Hi,
> 
> since the AT91 I-pipe timer code was rebased on the mainline
> tcb_clksrc driver, the I-pipe tracer is broken for these platforms.
> The following patch is an attempt to fix it. If everyone agrees with
> the patch, I can apply it to the most recent I-pipe branches.

On the way to 3.19 a lot more at91 consolidated is done. Have a look at
kernel commit 878ba61aa98cbb97a513757800e77613f856a029 and what happened
before.

In my merge that was one of the bigger arm-topics where i probably
broke something. 

Should be in my merges 90eef0a7881a4..92529d1ed9bca on
https://github.com/siemens/linux-ipipe.git

Henning

