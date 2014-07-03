Date: Thu, 3 Jul 2014 10:38:07 +0200
From: Arnaud Degroote <arnaud.degroote@isae.fr>
Message-ID: <20140703083807.GA10654@dmia-degroote.isae.fr>
References: <7016-53b1af80-3d5-7f54e300@12077259>
 <53B1B529.9040106@xenomai.org>
 <20140701083910.GA28764@dmia-degroote.isae.fr>
 <53B27E5B.10507@xenomai.org>
 <20140701155123.GA5547@dmia-degroote.isae.fr>
 <53B30A78.40605@xenomai.org>
 <20140702114142.GA13439@dmia-degroote.isae.fr>
 <53B44879.5020203@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B44879.5020203@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support of Beagleboard xm rev C on 3.14-ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 02/Jul - 19:59, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Well, this sucks, posted writes increase the timer programming latency.
> 
> Does the latency test run correctly with this patch?

Yes, the latency test seems to work properly. 

I need to investigate a bit more, because the kernel without the patch
seems to work properly with a different uboot (the one for my gumstix)
while it hangs with the uboot for my beagleboard. 

Best regards,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140703/b947d875/attachment.sig>
