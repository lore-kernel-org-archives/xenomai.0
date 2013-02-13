Message-ID: <511B8A11.1060204@xenomai.org>
Date: Wed, 13 Feb 2013 13:41:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CC872764D2E12B469BE82C0BF22F24DF2716AB5A@icexch-m2.ic.ac.uk>
In-Reply-To: <CC872764D2E12B469BE82C0BF22F24DF2716AB5A@icexch-m2.ic.ac.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai linux kernel compile
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Giataganas, Petros" <petros.giataganas11@imperial.ac.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/12/2013 08:20 PM, Giataganas, Petros wrote:

> Hi all,
> 
> Thank you for your amazing work on xenomai and the documentation that supports it.
> 
> I have to say that I am newbie but I have not found any solution on mr. Google!
> 
> I am running ubuntu 12.04 and I want to run xenomai 2.6.2.1
> 
> My problem is presented when I am doing the full kernel compile based on the guide :
> 
> http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on-ubuntu-12-04/


The instructions for installing Xenomai on a Debian distribution are here:
http://xenomai.org/index.php/Building_Debian_packages

They are a bit outdated as they mention a
"/usr/src/kernel-patches/i386/apply/xenomai" script which no longer
exists. Instead, see what patch you need in the
/usr/src/kernel-patches/diffs/xenomai

and apply it to the kernel sources with the patch command.

You may also find pre-compiled packages for Ubuntu starting on this page:
http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages

-- 
                                                                Gilles.

