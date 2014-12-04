Message-ID: <5480832D.8050809@control.lth.se>
Date: Thu, 04 Dec 2014 16:52:13 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <54803595.90308@control.lth.se> <20141204121224.GA9728@hermes>
In-Reply-To: <20141204121224.GA9728@hermes>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Script to cleanup linux .config file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2014-12-04 13:12, Gilles Chanteperdrix wrote:
> On Thu, Dec 04, 2014 at 11:21:09AM +0100, Anders Blomdell wrote:
>> I post the attached script in the vain hope that it might be useful for someone else
>> (and possibly enhanced by our all-knowing experts). 
> 
> I would say the simple option is to disable the options by directly
> patching the Kconfig in the I-pipe patch.
> 
Something like:

  config ACPI_PROCESSOR
          depends on ! IPIPE

perhaps? Should I submit a patch for latest ipipe?

/Anders
- -- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUgIMrAAoJENZYyvaDG8NcdzoH/j69M5q6UxT2BGJbnlFZXJtf
AtbT1cKHrfKHP0coyR7nmtEd/pIBRaYRWGyy3h68fq4ECX0id1mus5XCF/cnjz/J
BX8Y0FUmb9P6yTxqy+4ZPEykTb0TcraD8Qy2tHFfmdoEeBMo7NJ5AiJ6u3xN6NMi
UPL4cdRUgJOWp8oMDdzI640cLPSbsRtyMDDGr/nrH7t/+KIHzTn+S79TTtulbUct
xjvZNOPPyKwrSU88zUctvqF5PGTy1o72RYoBrAUQhaQxVB8Eo/C5gBY5sKUaJ1Ys
W6zifY7rjBtCM7trkM4t5nsXmv7k97yQ6KZUakokxFZeNvakPRI00e2qBZ87QYQ=
=HuAw
-----END PGP SIGNATURE-----

