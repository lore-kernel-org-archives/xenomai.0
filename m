Message-ID: <525EAFFD.3010207@steinkuehler.net>
Date: Wed, 16 Oct 2013 10:25:49 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>
	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>
	<525E8A43.5090601@xenomai.org> <525E8BFF.1060201@steinkuehler.net>
In-Reply-To: <525E8BFF.1060201@steinkuehler.net>
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

On 10/16/2013 7:52 AM, Charles Steinkuehler wrote:
> Anyway, are there any in-between steps I can test with the kernel that
> might help isolate what code to go over in the mmc driver?  Anything
> between "no xenomai patches" and "patched and configured to run xenomai"
> might potentially be enlightening.  =


I built and tested a patched kernel that has no xenomai configure
options enabled:

# CONFIG_XEN is not set

...and I still get the hang.

I'll start reviewing the driver changes pre and post the xenomai
patches, but would appreciate any suggestions or guidance as to what I
should be looking for.

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131016/ca4f0c7=
f/attachment.pgp>
