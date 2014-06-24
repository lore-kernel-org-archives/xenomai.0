Message-ID: <53A9C41C.6020700@xenomai.org>
Date: Tue, 24 Jun 2014 20:31:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140623090857.GA4043@dmia-degroote.isae.fr>
 <53A7F1E4.2050603@xenomai.org> <20140623111823.GA5715@dmia-degroote.isae.fr>
 <53A8BC0C.2010608@xenomai.org> <20140624062309.GA9564@dmia-degroote.isae.fr>
 <53A91AC0.30801@xenomai.org> <20140624122129.GA18908@dmia-degroote.isae.fr>
In-Reply-To: <20140624122129.GA18908@dmia-degroote.isae.fr>
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

On 06/24/2014 02:21 PM, Arnaud Degroote wrote:
> On 24/Jun - 08:29, Gilles Chanteperdrix wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 06/24/2014 08:23 AM, Arnaud Degroote wrote:
>>> On 24/Jun - 01:45, Gilles Chanteperdrix wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>> 
>>>> On 06/23/2014 01:18 PM, Arnaud Degroote wrote:
>>>>> On 23/Jun - 11:22, Gilles Chanteperdrix wrote:
>>>>>> On 06/23/2014 11:08 AM, Arnaud Degroote wrote:
>>>>>>> Hi list,
>>>>>>> 
>>>>>>> I'm trying to deploy a 3.14 kernel on my BeagleBoard XM
>>>>>>> rev C but got several issues. So, first question, it
>>>>>>> is supposed to be supported or am I somewhere in a grey
>>>>>>> zone ?
>>>>>>> 
>>>>>>> Let describe more precisely the configuration and the 
>>>>>>> symptom. - linux-ipipe branch ipipe-3.14 - xenomai
>>>>>>> 2.6.3 + some patches from 2.6 branch (including 
>>>>>>> d1d00e0acd29bb5f9023494a883a7fa0def40917 
>>>>>>> 41cb1f73814d1094e0ea75ccbbd23ff01280787e 
>>>>>>> 7a48019268d7e1157ebb072b88f6683425f0c7c5 
>>>>>>> f00d22eca6277e780c19a5d5ecd2ed0e23dabafe )
>>>>>> 
>>>>>> It is supposed to work, could you try again with the
>>>>>> xenomai 2.6 git?
>>>>>> 
>>>>> 
>>>>> Hi Gilles,
>>>>> 
>>>>> I just tested against 2.6-git and observe the same
>>>>> behaviours.
>>>>> 
>>>>> Best regards,
>>>>> 
>>>> Could you post your configuration?
>>> 
>>> Sure, see the attached defconfig. It is basically yocto base
>>> arm kernel + xenomai (and some kernel hacking option).
>>> 
>>> 
>> Could you try to turn off CONFIG_NO_HZ ?
> 
> Without CONFIG_NO_HZ, it hangs repeatably during the boot (in the
> same place than with CONFIG_NO_HZ without CONFIG_DEBUG_LOCK_ALLOC,
> so this last option is more a timing workaround than a "real fix").
> See the attached defconfig and boot log.

Do you have the same problem if you boot using NFS instead of an SD card?

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTqcQcGpcgE6m/fboRAsBjAJ47pNyDcEdN6NKUEvL0edqpQlL+kgCbBNLs
3fCsgLjCVkJHZpqGsmfbpYM=
=F7+D
-----END PGP SIGNATURE-----

