Message-ID: <486CEF9D.6060604@domain.hid>
Date: Thu, 03 Jul 2008 17:26:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <486CE4C5.8050309@domain.hid>
In-Reply-To: <486CE4C5.8050309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How can I make Xenomai share a mii bus with the
 kernel?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Galea <michaelgalea@domain.hid>
Cc: xenomai@xenomai.org

Michael Galea wrote:
> I wonder if someone can suggest an approach to the following problem.
> 
> We need to use xenomai to manage devices on the mii bus.  The mii bus 
> has PHYs managed by linux. What is the best way of providing access to 
> both linux and xenomai?
> 
> I know that before xenomai "loads", I can simply access the mii bus from 
> linux.  But after xenomai loads, is the right answer to make the linux 
> function that reads the phy migrate into the xenomai domain and contend 
> for the bus there?
>

Problem is that Xenomai does not really compete with Linux, it preempts it
bluntly and rudely when it needs so, regardless of the Linux locking. So regular
Linux users of the PHY layer would start having problems, and your board would
happily jump out of the window.

Therefore, you would have to analyze and fix every callee from net/phy (and on)
to use Xenomai locking, instead of plain Linux locking constructs, at the very
least. Aside of the fact that this may be quite time-consuming and error-prone,
this would also de facto make the critical sections defined in the phy code
non-preemptible RT-wise, which may have some impact on the worst-case latency as
well. Sorry, this is co-kernel neighbourhood: we fancy behaving as masochistic
zombies around here.

Question: Is the Xenomai code calling into the phy layer a real-time beast, with
actual deadlines to be met, or not?

If yes, then you have no other choice than "ironing" the phy management code, so
that it can be entered from both the Linux and real-time spaces in a mutually
exclusive manner.

If there are no deadlines (lucky you), then you probably want to issue a request
(_not_ a function call, but some kind of APC) to the Linux space from your
Xenomai task (see rthal_apc_alloc and friends). But in the latter case, the
Xenomai task would lose any RT properties, because your code would likely want
to wait for completion of that request on the Linux side, most of the time.

The description above assumes your code lives in kernel space. In case that code
could live in userland, then you could use a more straightforward
implementation, based on a small RTDM driver forwarding PHY requests and sending
back the results to userland. Since Xenomai tasks in user-space may switch
automatically back and forth between the Linux and Xenomai domains, you would
not need to handle the quirks of APC handling. Still, you would not have any RT
guarantees for the call site, but maybe that's acceptable.

-- 
Philippe.

