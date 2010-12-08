Message-ID: <4CFF4CAC.4040406@domain.hid>
Date: Wed, 08 Dec 2010 10:15:24 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CFE1E35.3020603@domain.hid> <4CFE1FA4.2030501@domain.hid>
	<4CFE217A.1010609@domain.hid>
	<4CFE23DE.8050906@domain.hid> <4CFE413C.30908@domain.hid>
	<4CFE9731.1000004@domain.hid> <4CFF34DE.3030603@domain.hid>
	<4CFF46E0.6090705@domain.hid>
In-Reply-To: <4CFF46E0.6090705@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Problem with gcc-4.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2010-12-08 09.50, Gilles Chanteperdrix wrote:
> Anders Blomdell wrote:
>> On 2010-12-07 21.21, Gilles Chanteperdrix wrote:
>>> Anders Blomdell wrote:
>>>> On 12/07/2010 01:09 PM, Gilles Chanteperdrix wrote:
>>>>  > Anders Blomdell wrote:
>>>>  >> On 12/07/2010 12:51 PM, Gilles Chanteperdrix wrote:
>>>>  >>> Anders Blomdell wrote:
>>>>  >>>> When compiling Xenomai on Fedora-14 with gcc-4.5.1 [version 4.5.1
>>>>  >>>> 20100924 (Red Hat 4.5.1-4)], the loading of xeno_nucleus fails 
>>>> with the
>>>>  >>>> attached kernel OOPS, a notable difference between the 4.5.1 compiled
>>>>  >>>> version and a working one built with gcc-4.4.4 on the same system with
>>>>  >>>> the same configuration, sis tthat __rthal_x86_nodiv_ullimd is not
>>>>  >>>> inlined, is this anybody has seen before?
>>>>  >>> No, that is new, we need to see the disassembly of 
>>>> __rthal_x86_nodiv_ullimd
>>>>  >>
>>>>  >> objdump -S:
>>>>  >>
>>>>  >> static inline __attribute__((const)) unsigned long long
>>>>  >> __rthal_x86_nodiv_ullimd(const unsigned long long op,
>>>>  >> 			 const unsigned long long frac,
>>>>  >> 			 unsigned integ)
>>>>  >> {
>>>>  >>       e7a8:	55                   	push   %ebp
>>>>  >>       e7a9:	89 e5                	mov    %esp,%ebp
>>>>  >>       e7ab:	57                   	push   %edi
>>>>  >>       e7ac:	56                   	push   %esi
>>>>  >>       e7ad:	53                   	push   %ebx
>>>>  >>       e7ae:	83 ec 10             	sub    $0x10,%esp
>>>>  >>       e7b1:	8d 7d 08             	lea    0x8(%ebp),%edi
>>>>  >>       e7b4:	e8 fc ff ff ff       	call 
>>>> e7b5<__rthal_x86_nodiv_ullimd+0xd>
>>>>  >>       e7b9:	8b 1f                	mov    (%edi),%ebx
>>>>  >>       e7bb:	8b 4f 04             	mov    0x4(%edi),%ecx
>>>>  >> 	register unsigned rm __asm__("esi");
>>>>  >> 	register unsigned rh __asm__("edi");
>>>>  >> 	unsigned fracl, frach, opl, oph;
>>>>  >> 	register unsigned long long t;
>>>>  >>
>>>>  >> 	__rthal_u64tou32(op, oph, opl);
>>>>  >>       e7be:	89 45 e8             	mov    %eax,-0x18(%ebp)
>>>>  >> 	__rthal_u64tou32(frac, frach, fracl);
>>>>  >>       e7c1:	89 5d f0             	mov    %ebx,-0x10(%ebp)
>>>>  >> 	register unsigned rm __asm__("esi");
>>>>  >> 	register unsigned rh __asm__("edi");
>>>>  >> 	unsigned fracl, frach, opl, oph;
>>>>  >> 	register unsigned long long t;
>>>>  >>
>>>>  >> 	__rthal_u64tou32(op, oph, opl);
>>>>  >>       e7c4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
>>>>  >> 	__rthal_u64tou32(frac, frach, fracl);
>>>>  >>       e7c7:	89 4d ec             	mov    %ecx,-0x14(%ebp)
>>>>  >>
>>>>  >> 	__asm__ ("mov %[oph], %%eax\n\t"
>>>>  >>       e7ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
>>>>  >>       e7cd:	f7 65 ec             	mull   -0x14(%ebp)
>>>>  >>       e7d0:	89 c6                	mov    %eax,%esi
>>>>  >>       e7d2:	89 d7                	mov    %edx,%edi
>>>>  >>       e7d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
>>>>  >>       e7d7:	f7 65 f0             	mull   -0x10(%ebp)
>>>>  >>       e7da:	89 d1                	mov    %edx,%ecx
>>>>  >>       e7dc:	d1 e0                	shl    %eax
>>>>  >>       e7de:	83 d1 00             	adc    $0x0,%ecx
>>>>  >>       e7e1:	83 d6 00             	adc    $0x0,%esi
>>>>  >>       e7e4:	83 d7 00             	adc    $0x0,%edi
>>>>  >>       e7e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
>>>>  >>       e7ea:	f7 65 f0             	mull   -0x10(%ebp)
>>>>  >>       e7ed:	01 c1                	add    %eax,%ecx
>>>>  >>       e7ef:	11 d6                	adc    %edx,%esi
>>>>  >>       e7f1:	83 d7 00             	adc    $0x0,%edi
>>>>  >>       e7f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
>>>>  >>       e7f7:	f7 65 ec             	mull   -0x14(%ebp)
>>>>  >>       e7fa:	01 c1                	add    %eax,%ecx
>>>>  >>       e7fc:	11 d6                	adc    %edx,%esi
>>>>  >>       e7fe:	83 d7 00             	adc    $0x0,%edi
>>>>  >>       e801:	8b 45 e8             	mov    -0x18(%ebp),%eax
>>>>  >>       e804:	f7 67 08             	mull   0x8(%edi)
>>>>  >
>>>>  > Problem is here: edi is used by gcc as if it contained an address
>>>>  > whereas it is used by the assembly for the computation. Should be marked
>>>>  > "early clobber". So,
>>>>  >
>>>>  > in include/asm-x86/arith_32.h, replace:
>>>>  >
>>>>  > : [rl]"=c"(rl), [rm]"=S"(rm), [rh]"=D"(rh), "=A"(t)
>>>>  >
>>>>  > with:
>>>>  >
>>>>  > : [rl]"=&c"(rl), [rm]"=&S"(rm), [rh]"=&D"(rh), "=&A"(t)
>>>>  >
>>>>  >
>>>>
>>>> No cigar (:-()
>>> Ok. Maybe we can try something less radical, such as:
>>>
>>> : [rl]"=c"(rl), [rm]"=S"(rm), [rh]"=&D"(rh), "=A"(t)
>>>
>>> This is incorrect, but we can hope for the best...
>> As previously said, changing the optimization from -Os to anything else for
>> xeno_nucleus (see patch in mail dated 'Tue, 07 Dec 2010 17:20:37 +0100'), solved
>> that issue (incorrect code + hope for the best -> spurious disasters). Rather
>> compile time errors than runtime errors.
> 
> We are not going to decide instead of the user what optimization level
> to use, if he wants to use -Os, we have to make it work for -Os. If this
> one does not work, we have other things to try.
Then start with something that you belive is correct, I *WILL NOT* test
something which you think is incorrect.

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

