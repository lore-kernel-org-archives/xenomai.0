Message-ID: <53B15B9F.5040806@xenomai.org>
Date: Mon, 30 Jun 2014 14:44:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140626111949.GA4486@dmia-degroote.isae.fr>
 <53AC5810.7040806@xenomai.org> <20140627072229.GA14771@dmia-degroote.isae.fr>
 <53AD9B7F.5030701@xenomai.org> <20140630082620.GA3314@dmia-degroote.isae.fr>
 <53B126EE.6020306@xenomai.org> <20140630091310.GA4019@dmia-degroote.isae.fr>
 <53B13914.2010706@xenomai.org> <20140630120135.GA4552@dmia-degroote.isae.fr>
 <53B1531F.4040504@xenomai.org> <20140630123704.GA32240@dmia-degroote.isae.fr>
In-Reply-To: <20140630123704.GA32240@dmia-degroote.isae.fr>
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

On 06/30/2014 02:37 PM, Arnaud Degroote wrote:
> While running xddp_test:
> 
> [  122.886107] I-pipe: Detected stalled head domain, probably
> caused by a b= ug. [  122.886107]         A critical section may
> have been left unterminated.

This one is a serious error, but not an oops. It means, someone should
have a look at the xddp driver.

> [  123.157094] WARNING: CPU: 0 PID: 447 at
> include/linux/ipipe.h:225 xnpipe= _open+0x9d8/0x3670() [
> 130.728085] WARNING: CPU: 0 PID: 456 at include/linux/ipipe.h:225
> xnregi= stry_remove+0x960/0x228c()

These two are warnings, not oopses either.

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTsVufGpcgE6m/fboRAlIzAJ9DDpK5bN3pV0ewAkTJfOpaQjH6wQCfVrFF
2dL9Gnr6IceXq4J/gtSeTxI=
=JKpt
-----END PGP SIGNATURE-----

