Message-ID: <1c62fe8d1d96dde3311cf71655ed1ea0.squirrel@xenomai.org>
In-Reply-To: <5480832D.8050809@control.lth.se>
References: <54803595.90308@control.lth.se> <20141204121224.GA9728@hermes>
 <5480832D.8050809@control.lth.se>
Date: Thu, 4 Dec 2014 17:44:33 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Script to cleanup linux .config file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Xenomai <xenomai@xenomai.org>


Anders Blomdell wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 2014-12-04 13:12, Gilles Chanteperdrix wrote:
>> On Thu, Dec 04, 2014 at 11:21:09AM +0100, Anders Blomdell wrote:
>>> I post the attached script in the vain hope that it might be useful for
>>> someone else
>>> (and possibly enhanced by our all-knowing experts).
>>
>> I would say the simple option is to disable the options by directly
>> patching the Kconfig in the I-pipe patch.
>>
> Something like:
>
>   config ACPI_PROCESSOR
>           depends on ! IPIPE
>
> perhaps? Should I submit a patch for latest ipipe?

Yes, but be aware: not all options must be disabled on all architectures.

-- 
                    Gilles.


