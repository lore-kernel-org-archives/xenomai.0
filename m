Message-ID: <502D0E4A.9070509@grandegger.com>
Date: Thu, 16 Aug 2012 17:14:18 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <502D040F.2010906@axesseurope.com>
	<20120816144617.GD1237@csclub.uwaterloo.ca>
In-Reply-To: <20120816144617.GD1237@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Trying to get Xenomai on P1010RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 08/16/2012 04:46 PM, Lennart Sorensen wrote:
> On Thu, Aug 16, 2012 at 04:30:39PM +0200, Charles Retailleau wrote:
>> Hi all,
>> The patching/compilation/installation steps seem fine.
>> But at the end I cannot have any Xenomai software running on the
>> P1010RDB (I tried most of the provided test SW).
>>
>> I focused on latency and tried to debug it. I get that:
>>
>> Program received signal SIGILL, Illegal instruction.
>> 0x0ffde120 in __xn_rdtsc () from ....xenomai/lib/libnative.so.3
>>
>> It appears that the 'mftb/mftbu' instructions
>> are in cause (cf. the small test in attachment, the 1st part works but
>> not the mftb test).
>> Furthermore when I check the core e500 ref manual
>> http://cache.freescale.com/files/32bit/doc/ref_manual/E500CORERM.pdf
>> MFTB appears has NOT being part of the instruction list.
>>
>> Yet, Xenomai seems to work on P1020RDB which has the same core, so I'm
>> confused...
>> What did I do wrong ?
>>
>> I'm using
>>    Xenomai 2.6.1,
>>    linux 3.2.21 configured with mpc85xx_defconfig (default options for
>> the rest of it),
>>    Freescale's SDK 1.1.2 (that's the main difference between me and
>> Lukasz Zemla's config on P1020RDB, so I'm trying to get the latest 1.2)
> 
> mftb is a phased out instruction according to the powerpc 2.06 rev
> B documentation.  mfspr is the prefered instruction to use instead on
> everything other than the old 603 and POWER3 CPUs.
> 
> It is quite possible the e500 hence doesn't support it.  According to
> http://cache.freescale.com/files/32bit/doc/app_note/AN3445.pdf it
> specificly does NOT have mftb.  Neither does the e300 core which is what
> we are using with xenomai (MPC8360e specificly).

It uses an e500v2 core. I use the ELDK 5.2.1 "powerpc-e500v2" for the P2020.

Wolfgang.



