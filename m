From: Robert Berger <gmane@reliableembeddedsystems.com>
Date: Sun, 04 Nov 2012 00:13:02 +0200
Message-ID: <509596EE.5010307@reliableembeddedsystems.com>
References: <k73ua9$nf5$1@ger.gmane.org> <50958E65.9090106@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <50958E65.9090106@xenomai.org>
Subject: Re: [Xenomai] Beagle-XM - ipipe-core-3.2.21
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

On 11/03/2012 11:36 PM, Gilles Chanteperdrix wrote:
> Please disable CONFIG_SMP. The I-pipe for 3.2.21 does not support
> SMP_ON_UP yet, it has only be added to 3.4.

Spot on! Thanks a lot!

Now I have a booting kernel, which even takes the rootfs from nfs.

Regards,

Robert


..."Software is like sex, it's better when it's free"

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1



