Message-ID: <525EEBE2.8080708@steinkuehler.net>
Date: Wed, 16 Oct 2013 14:41:22 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>	<525E8A43.5090601@xenomai.org>
	<525E8BFF.1060201@steinkuehler.net>	<525EAFFD.3010207@steinkuehler.net>
	<525EB7A2.1050601@xenomai.org> <525EBAD4.3080100@steinkuehler.net>
In-Reply-To: <525EBAD4.3080100@steinkuehler.net>
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

On 10/16/2013 11:12 AM, Charles Steinkuehler wrote:
> I'll test with ipipe disabled, go through the Arm Porting guide, and see
> where that gets me...

After building a patched kernel without ipipe or xenomai enabled:

$ egrep '(IPIPE|XENO)' KERNEL/.config
# CONFIG_XENOMAI is not set
CONFIG_XENO_GENERIC_STACKPOOL=3Dy
CONFIG_XENO_FASTSYNCH_DEP=3Dy
CONFIG_XENO_FASTSYNCH=3Dy
# CONFIG_IPIPE is not set

...the mmc issue seems fixed.  So according to the porting guide, this
indicates a likely problem with interrupts or the interrupt controller
(as Gilles indicated).

Looks like I get to dive into IRQ code review...at least I have some
configuration options to grep for to hopefully light the way.  And I
have a test case that kills the system in fairly short order!

Thanks again for all the help and hand-holding!

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131016/1145586=
6/attachment.pgp>
