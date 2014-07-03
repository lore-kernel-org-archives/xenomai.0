Message-ID: <53B54DEA.9020306@xenomai.org>
Date: Thu, 03 Jul 2014 14:34:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7016-53b1af80-3d5-7f54e300@12077259>
 <53B1B529.9040106@xenomai.org> <20140701083910.GA28764@dmia-degroote.isae.fr>
 <53B27E5B.10507@xenomai.org> <20140701155123.GA5547@dmia-degroote.isae.fr>
 <53B30A78.40605@xenomai.org> <20140702114142.GA13439@dmia-degroote.isae.fr>
 <53B44879.5020203@xenomai.org> <20140703083807.GA10654@dmia-degroote.isae.fr>
In-Reply-To: <20140703083807.GA10654@dmia-degroote.isae.fr>
Content-Type: text/plain; charset=UTF-8
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
To: Arnaud Degroote <arnaud.degroote@isae.fr>
Cc: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/03/2014 10:38 AM, Arnaud Degroote wrote:
> On 02/Jul - 19:59, Gilles Chanteperdrix wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> 
>> Well, this sucks, posted writes increase the timer programming
>> latency.
>> 
>> Does the latency test run correctly with this patch?
> 
> Yes, the latency test seems to work properly.

That is strange, because the Xenomai timer also uses non-posted writes.

> 
> I need to investigate a bit more, because the kernel without the
> patch seems to work properly with a different uboot (the one for my
> gumstix) while it hangs with the uboot for my beagleboard.

Perhaps the u-boot which works implement some workaround for processor
errata, which the u-boot which does not work does not implement?


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTtU3qGpcgE6m/fboRAiaqAJ0Z1HWfwSTosuDNn2Y/Rm2mwPOBlACfYNwl
UQCwKjRsGTtoDwMAAWHMTUs=
=XtNR
-----END PGP SIGNATURE-----

