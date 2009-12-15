Message-ID: <4B276222.3010900@domain.hid>
Date: Tue, 15 Dec 2009 11:17:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B263E6A.7040104@domain.hid>
	<1260871765.2216.102.camel@domain.hid>
In-Reply-To: <1260871765.2216.102.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build tests.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <alexis.berlemont@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Mon, 2009-12-14 at 14:32 +0100, Gilles Chanteperdrix wrote:
>> Hi,
>>
>> I am working on automated build tests of several configurations of
>> Xenomai head. While running them, I found a few issues, and would need
>> acks, since it is in parts others maintain.
>>
>> Alex: https://mail.gna.org/public/xenomai-git/2009-12/msg00112.html
>>
>> Wolfgang: https://mail.gna.org/public/xenomai-git/2009-12/msg00113.html
>>
>> Anyone: https://mail.gna.org/public/xenomai-git/2009-12/msg00114.html
>>
>> Philippe (check powerpc 2.4):
>> https://mail.gna.org/public/xenomai-git/2009-12/msg00115.html
>>
> 
> We have to include asm/mmu.h to get phys_addr_t defined.
> The default declaration of this type for pre-2.6.28 kernels breaks
> 2.6.20. Better rely on phys_addr_t being defined in linux/types.h, or
> specifically in our wrappers for older kernels. What a mess.
> 
> Tested here on blackfin 2.6.3x, x86* 2.6.27-2.6.30, nios2 2.6.3x, ppc
> 2.4.x, 2.6.20, 2.6.3x. You may want to check this against ARM as well.

Ok. Will do.

-- 
                                          Gilles


