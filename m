Message-ID: <525F362F.6080109@steinkuehler.net>
Date: Wed, 16 Oct 2013 19:58:23 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>	<525E8A43.5090601@xenomai.org>	<525E8BFF.1060201@steinkuehler.net>	<525EAFFD.3010207@steinkuehler.net>	<525EB7A2.1050601@xenomai.org>
	<525EBAD4.3080100@steinkuehler.net>
	<525EEBE2.8080708@steinkuehler.net>
In-Reply-To: <525EEBE2.8080708@steinkuehler.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 10/16/2013 2:41 PM, Charles Steinkuehler wrote:
> On 10/16/2013 11:12 AM, Charles Steinkuehler wrote:
>> I'll test with ipipe disabled, go through the Arm Porting guide, and see
>> where that gets me...
> =

> After building a patched kernel without ipipe or xenomai enabled:
> =

> $ egrep '(IPIPE|XENO)' KERNEL/.config
> # CONFIG_XENOMAI is not set
> CONFIG_XENO_GENERIC_STACKPOOL=3Dy
> CONFIG_XENO_FASTSYNCH_DEP=3Dy
> CONFIG_XENO_FASTSYNCH=3Dy
> # CONFIG_IPIPE is not set
> =

> ...the mmc issue seems fixed.  So according to the porting guide, this
> indicates a likely problem with interrupts or the interrupt controller
> (as Gilles indicated).

Based on the ARM porting guide, the first thing I did was to disable IRQ
muting by simply commenting out the two calls to:

  ipipe_pic_muter_register

...in <linux>/drivers/gpio/gpio-omap.c

This results in a kernel that DOES NOT HANG with ipipe enabled!

So it looks like the issue is related to interrupt muting, and I have
two paths to push forward:

1) Build a kernel with ipipe and xenomai both enabled (but no IRQ
muting) and see if this works (and how much it affects worst-case latency)

2) Dig into the IRQ muting code and look for any goofs

I can handle #1, building and testing a kernel with IRQ muting disabled.

Can anyone advise on a good way to approach #2?  Since everything
_almost_ works, I suspect a problem that could be difficult to find,
especially for someone like me who isn't really all that familiar with
the Linux kernel and ipipe internals.

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131016/330bf34=
d/attachment.pgp>
