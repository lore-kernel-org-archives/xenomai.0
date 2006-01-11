Message-ID: <43C58FBE.5060901@domain.hid>
Date: Thu, 12 Jan 2006 00:07:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43C12304.4040802@domain.hid>	<43C12CEC.8070403@domain.hid>	<43C14453.3040907@domain.hid>	<1136754149.17443.21.camel@domain.hid>	<43C18CE1.5040509@domain.hid>	<43C1CFC2.8040104@domain.hid>	<43C21BA7.4050806@domain.hid>	<43C220FE.4010100@domain.hid>	<17346.57955.432284.905332@domain.hid>	<43C37926.5060007@domain.hid>
	<17349.33404.156585.857948@domain.hid>
	<43C58820.5010006@domain.hid>
In-Reply-To: <43C58820.5010006@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] latency kernel part fixed
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Philippe Gerum wrote:
>> > Gilles Chanteperdrix wrote:
>> > > Philippe Gerum wrote:
>> > >  > Likely not this time (keep it cold anyway, who knows); I strongly suspect a bug in 
>> > >  > xnarch_switch_to() for all archs but x86
>> > > 
>> > > Now that you are talking about it, I may be the one who owes a beer to
>> > > everyone by first having put a bug in ia64 context-switch code... If I
>> > > am not wrong, the bug should be observed on ia64 too. Unfortunately, I
>> > > am unable to compile my ia64 kernel right now, so I wrote a patch for
>> > > power PC, and would be glad if some power PC owner could try it.
>> > > 
>> > 
>> > Nope, same lockup with hybrid scheduling.
>>
>>The latency -t 1 crash may be observed on ia64 too.
>>
>>But it does not seem to be due to the bug I was suspecting in context
>>switch code.
>>
> 
> 
> What about the PPC world? I saw some SVN commits claiming to fix this
> (also for blackfin) - but there was no "Hey, it's fixed now!" on the
> mailing list.
>

Ok... "Hey, it's fixed now!"

Hybrid scheduling (kernel and user-space Xeno threads combination) has been fixed 
for ppc32, ppc64, ia64 and the Blackfin. Issue fixed on the ARM port to come too. 
Some tests remain to be conducted on the ppc64 though. The rest has already been 
validated. Fixes are available from the SVN trunk/.

This said, here is my next Xmas wishlist I'd really appreciate you guys anticipate 
from, say 11 months and a couple of weeks: if you have any of the above archs, 
please run both the kernel and user-space latency tests on such hw:

Basically, this boils down to building Jan's timerbench test into the kernel or as 
a separate module, then run the following tests on the said kernel:

$ sudo ./latency -t0
$ sudo ./latency -t1
$ sudo ./latency -t2

Special note to the ppc32 people: I would be interested in having your feedback 
about switching on the ALTIVEC and SPE supports at kernel level, on platforms that 
do not have those beasts, and see if all tests survive this.

In any case, I'm eventually going to warn about such configurations at the very 
least, since relying on FTR fixups right in the middle of the fast path for all 
context switches is kind of, mmh, silly?! Nevertheless, knowing about the result 
might be important in the future.

TIA,

-- 

Philippe.

