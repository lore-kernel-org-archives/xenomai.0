Message-ID: <53AC5810.7040806@xenomai.org>
Date: Thu, 26 Jun 2014 19:27:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140624062309.GA9564@dmia-degroote.isae.fr>
 <53A91AC0.30801@xenomai.org> <20140624122129.GA18908@dmia-degroote.isae.fr>
 <53A9C41C.6020700@xenomai.org> <20140625081129.GA31341@dmia-degroote.isae.fr>
 <53AA8A35.7000506@xenomai.org> <20140625094715.GA26690@dmia-degroote.isae.fr>
 <53AB4BE3.2070302@xenomai.org> <20140626075607.GA32691@dmia-degroote.isae.fr>
 <53ABFF21.8010700@xenomai.org> <20140626111949.GA4486@dmia-degroote.isae.fr>
In-Reply-To: <20140626111949.GA4486@dmia-degroote.isae.fr>
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

On 06/26/2014 01:19 PM, Arnaud Degroote wrote:
> On 26/Jun - 13:08, Gilles Chanteperdrix wrote:
>> switchtest is another story. Does switchtest hang, or does the 
>> system completely freeze?
> 
> switchtest hangs, but the system is still responsive. I can ctrl-c
>  it and restart it. On C-c, it prints "properly" a number of ctx 
> switches done (which is far from other "normal" values).
> 
You mean it is as if switchtest had continued switching contexts but
had not printed anything? Do you see counters incrementing in
/proc/xenomai/stat ?

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTrFgQGpcgE6m/fboRAm7kAJ4kkZfK+krIMFv/Z37mXkS/B0lnIQCfSuwi
LTkCql1VdCG+9gjEybO5UXc=
=hpEZ
-----END PGP SIGNATURE-----

