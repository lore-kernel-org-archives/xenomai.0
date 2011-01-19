From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D35F6C8.5020306@domain.hid>
References: <4D35F6C8.5020306@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 12:31:11 +0100
Message-ID: <1295436671.1857.129.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Waldemar Valdas Bancewicz <waldemarbancewicz@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2011-01-18 at 15:23 -0500, Waldemar Valdas Bancewicz wrote:
> Hi,
> 
> I am getting an abnormally high cpu utilization (30 - 85%) for the 
> gatekeeper/0 thread. I'm using Xenomai 2.4.10 with a Debian linux kernel 
> 2.6.32. The problem appears after upgrading the kernel with newer debian 
> patches. Any ideas?

That is an interesting question, but I'm unsure that you will get a
definite answer, at least because of the following reasons:

- we have absolutely no clue about what those "newer debian patches"
are, we track the mainline kernel only.

- we don't know what your application does, what were the CPU figures
before you changed your configuration, etc.

- you are running 2.4.10, which is seriously outdated, and you did not
tell anything about the I-pipe release you are running, albeit this is
likely crucial for your issue. Actually we don't even know what
architecture you are running.

Wild guess:

- your RT code is probably doing a massive number of mode switches to
secondary mode. You may want to check whether the value of the CSW
counter from /proc/xenomai/stat increases at the same pace depending on
the version you are testing.

- those patches somehow broke the host clock tick accounting code of the
I-pipe, and the gatekeeper is unduly charged with all Linux timer ticks
which happened while your system was running in primary mode, as soon as
it returns to secondary mode. In such a case, the longer the time spent
in primary mode, the higher the likeliness to have deferred Linux ticks
charged this way.

> 
> Thanks.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



