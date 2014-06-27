Message-ID: <53AD9B7F.5030701@xenomai.org>
Date: Fri, 27 Jun 2014 18:27:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140624122129.GA18908@dmia-degroote.isae.fr>
 <53A9C41C.6020700@xenomai.org> <20140625081129.GA31341@dmia-degroote.isae.fr>
 <53AA8A35.7000506@xenomai.org> <20140625094715.GA26690@dmia-degroote.isae.fr>
 <53AB4BE3.2070302@xenomai.org> <20140626075607.GA32691@dmia-degroote.isae.fr>
 <53ABFF21.8010700@xenomai.org> <20140626111949.GA4486@dmia-degroote.isae.fr>
 <53AC5810.7040806@xenomai.org> <20140627072229.GA14771@dmia-degroote.isae.fr>
In-Reply-To: <20140627072229.GA14771@dmia-degroote.isae.fr>
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

On 06/27/2014 09:22 AM, Arnaud Degroote wrote:
> On 26/Jun - 19:27, Gilles Chanteperdrix wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 06/26/2014 01:19 PM, Arnaud Degroote wrote:
>>> On 26/Jun - 13:08, Gilles Chanteperdrix wrote:
>>>> switchtest is another story. Does switchtest hang, or does
>>>> the system completely freeze?
>>> 
>>> switchtest hangs, but the system is still responsive. I can
>>> ctrl-c it and restart it. On C-c, it prints "properly" a number
>>> of ctx switches done (which is far from other "normal"
>>> values).
>>> 
>> You mean it is as if switchtest had continued switching contexts
>> but had not printed anything? Do you see counters incrementing
>> in /proc/xenomai/stat ?
> 
> I just meant that switchtest seems to respond properly to C-c, even
> if it does not progress. But counters from /proc/xenomai/stat
> stops incrementing at some point.
> 
You are running switchtest alone, after booting, nothing else is
running in the background, right? If yes, then that would mean that an
error in FP handling was detected. Do you get a message in the kernel
logs, or a message by switchtest itself?

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTrZt/GpcgE6m/fboRAi8kAJ9U6J3m8tCwxoyT+u6Vld68oCgMvQCdHPsw
wQx1aYF4mtI7uF9Z7dIFutY=
=sIeX
-----END PGP SIGNATURE-----

