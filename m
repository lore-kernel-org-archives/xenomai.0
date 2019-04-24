Subject: Re: Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
References: <BB5C4F5E3633C64999D0577F81995AE70286E71C@XMAIL.tecom.nnov.ru>
 <55438112-789f-da93-99ed-0320b6486fa3@siemens.com>
 <DM6PR09MB3402364C4B51AF4E5095788D853C0@DM6PR09MB3402.namprd09.prod.outlook.com>
 <8333b206-e819-c3e7-1394-3698baf2a075@siemens.com>
 <20190424195112.ceet7ddwlgg6hky2@csclub.uwaterloo.ca>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <25ce82c1-ccef-96b8-6563-b593394c55d0@siemens.com>
Date: Wed, 24 Apr 2019 22:21:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190424195112.ceet7ddwlgg6hky2@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems, Inc]" <steven.seeger@nasa.gov>, Alexander Sharabanov <sharabanov.a@tecomgroup.ru>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 24.04.19 21:51, Lennart Sorensen wrote:
> On Wed, Apr 24, 2019 at 08:28:05AM +0200, Jan Kiszka via Xenomai wrote:
>> That will surely be a valuable result, likely not even bound to ppc32.
>>
>> As I only learned recently (from a vendor that is still selling a lot of
>> ppc32 silicon but no longer developing it) the toolchain situation is also
>> getting worse: gcc discontinued ppc with release 8 and will drop it from 9.
>> So, it will be "fun" to build for that arch in the not so far future, I'm
>> afraid.
>>
>> Jan
> 
> GCC has NOT dropped powerpc support.
> 
> They have dropped this:
> 
> Support for the powerpc*-*-*spe*
> 
> PowerPC SPE is the signal processing version implemented in the e500
> core for example (good riddance as far as I am concerned).  It has an
> incompatible FPU design with different instructions that conflict with
> altivec and some other extensions.  Very few CPUs seem to have ever been
> designed with the SPE extension and hence why it sees very little use
> or testing.
> 
> Real PowerPC is doing fine in GCC.
> 

Yes, I meanwhile understood that this information I got first-hand from a 
company that still dominants the ppc32 silicon market was inaccurate.

Still, this won't change the fact that ppc32 is a dying arch. There is no new 
silicon design coming up anymore, major distros are moving away from it (not to 
speak of those who never jumped on it), and the arch is - in contrast to MIPS or 
specifically RISC-V - still a proprietary one, thus without hope of a second 
life in the free world. Internally, I haven't received support request for it 
for almost a decade.

It's history, let's face reality.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

