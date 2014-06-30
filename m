Message-ID: <53B12FA5.5070209@xenomai.org>
Date: Mon, 30 Jun 2014 11:36:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140625094715.GA26690@dmia-degroote.isae.fr>
 <53AB4BE3.2070302@xenomai.org> <20140626075607.GA32691@dmia-degroote.isae.fr>
 <53ABFF21.8010700@xenomai.org> <20140626111949.GA4486@dmia-degroote.isae.fr>
 <53AC5810.7040806@xenomai.org> <20140627072229.GA14771@dmia-degroote.isae.fr>
 <53AD9B7F.5030701@xenomai.org> <20140630082620.GA3314@dmia-degroote.isae.fr>
 <53B126EE.6020306@xenomai.org> <20140630091310.GA4019@dmia-degroote.isae.fr>
In-Reply-To: <20140630091310.GA4019@dmia-degroote.isae.fr>
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

On 06/30/2014 11:13 AM, Arnaud Degroote wrote:
> On 30/Jun - 10:59, Gilles Chanteperdrix wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 06/30/2014 10:26 AM, Arnaud Degroote wrote:
>>> On 27/Jun - 18:27, Gilles Chanteperdrix wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>> 
>>>> On 06/27/2014 09:22 AM, Arnaud Degroote wrote:
>>>>> On 26/Jun - 19:27, Gilles Chanteperdrix wrote:
>>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>>>> 
>>>>>> On 06/26/2014 01:19 PM, Arnaud Degroote wrote:
>>>>>>> On 26/Jun - 13:08, Gilles Chanteperdrix wrote:
>>>>>>>> switchtest is another story. Does switchtest hang,
>>>>>>>> or does the system completely freeze?
>>>>>>> 
>>>>>>> switchtest hangs, but the system is still responsive.
>>>>>>> I can ctrl-c it and restart it. On C-c, it prints
>>>>>>> "properly" a number of ctx switches done (which is far
>>>>>>> from other "normal" values).
>>>>>>> 
>>>>>> You mean it is as if switchtest had continued switching 
>>>>>> contexts but had not printed anything? Do you see
>>>>>> counters incrementing in /proc/xenomai/stat ?
>>>>> 
>>>>> I just meant that switchtest seems to respond properly to
>>>>> C-c, even if it does not progress. But counters from 
>>>>> /proc/xenomai/stat stops incrementing at some point.
>>>>> 
>>> 
>>> Related to my previous mail, I'm able to reduce threadspec to
>>> 
>>> rtk0 rtk0  rtup0
>>> 
>>> or
>>> 
>>> rtk0  rtup0 rtup0
>>> 
>>> Both demonstrates some quick hang. Other pattern may block too,
>>> I don't try the full combinatorial.
>>> 
>> Could you test rtk0 alone?
>> 
>> It would mean there is an issue with the context switch. Are you 
>> running with the xenomai git?
> 
> It fails with 'rtk0 rtk0 rtk0' (really quickly). With 'rtk0 rtk0'
> it seems to work.
> 
> I'm using xenomai-2.6 git
> (4eb593df1eb89a47f1bc3423cea44c345d22ee3e).
> 
Could you send me (privately) your current kernel configuration?

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTsS+lGpcgE6m/fboRAhfDAJ9Q8fwTrrSKKzh3ZbdP1t+GKDiLLQCePdgf
dwTDj35dB3gZJqupCMtMKI0=
=lcZ+
-----END PGP SIGNATURE-----

