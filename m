Message-ID: <53B1819F.10108@xenomai.org>
Date: Mon, 30 Jun 2014 17:26:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53AC5810.7040806@xenomai.org>
 <20140627072229.GA14771@dmia-degroote.isae.fr> <53AD9B7F.5030701@xenomai.org>
 <20140630082620.GA3314@dmia-degroote.isae.fr> <53B126EE.6020306@xenomai.org>
 <20140630091310.GA4019@dmia-degroote.isae.fr> <53B13914.2010706@xenomai.org>
 <20140630120135.GA4552@dmia-degroote.isae.fr> <53B1531F.4040504@xenomai.org>
 <20140630123704.GA32240@dmia-degroote.isae.fr>
 <20140630151836.GA14444@dmia-degroote.isae.fr>
In-Reply-To: <20140630151836.GA14444@dmia-degroote.isae.fr>
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

On 06/30/2014 05:18 PM, Arnaud Degroote wrote:
> On 30/Jun - 14:37, Arnaud Degroote wrote: [snip]
>>> Have you checked that the exact same kernel configuration,
>>> only without CONFIG_IPIPE and CONFIG_XENOMAI runs correctly
>>> under load?
>> 
>> The system seems to hang even without CONFIG_IPIPE. The
>> linux-yocto kernel seems to work properly (it looks like a
>> 3.14rc8), I will check precisely against linux kernel v3.14.
> 
> Some additional information
> 
> linux mainstream kernel on tag v3.14 runs fine on the platform.
> The system hangs with ipipe branch ipipe-3.14 (without xenomai
> stuff, and without CONFIG_IPIPE).

In the two cases the configuration is exactly the same?

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTsYGfGpcgE6m/fboRAvsVAJ9SNDmR1dfPS8//9e6FdNTdMNZoFwCfWt6J
sncwsiVDKeSfQRFFXSDrO6o=
=mj+/
-----END PGP SIGNATURE-----

