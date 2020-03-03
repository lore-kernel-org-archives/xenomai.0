Subject: Re: Ipipe-Patch for kernel version 5.4.23
References: <DB8PR09MB3612215A31188B5C00AD779BF0E70@DB8PR09MB3612.eurprd09.prod.outlook.com>
 <c4a79189-6696-a109-97f6-8cadbb36923e@siemens.com>
 <CALLqZ8TNspMLYOfrA11_xB6dh=LjXiTV8_P12+s_a_exUv6tqQ@mail.gmail.com>
 <68ddab50-1002-7100-a745-3387b28592b2@siemens.com>
 <1a4b8b29-2c9d-676b-cedc-d7eddb461189@hbm.com>
 <CALLqZ8S63mKXCpWcAeb7haW4x03Y07evBxJPD-j2ciJY40=9NA@mail.gmail.com>
 <39eee7a6-f95c-e55e-8922-3cef387abe93@hbm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <657c12d0-b0c9-f359-8f29-a266ad08ddc1@siemens.com>
Date: Tue, 3 Mar 2020 15:48:39 +0100
MIME-Version: 1.0
In-Reply-To: <39eee7a6-f95c-e55e-8922-3cef387abe93@hbm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ralf Moder <ralf.moder@hbkworld.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.03.20 15:23, Ralf Moder wrote:
> Am 03.03.20 um 14:53 schrieb Greg Gallagher:
>>
>>
>> On Tue, Mar 3, 2020 at 8:46 AM Ralf Moder <ralf.moder@hbkworld.com 
>> <mailto:ralf.moder@hbkworld.com>> wrote:
>>
>>     Am 02.03.20 um 17:01 schrieb Jan Kiszka:
>>     > On 02.03.20 16:17, Greg Gallagher wrote:
>>     >>
>>     >> On Mon, Mar 2, 2020 at 7:38 AM Jan Kiszka via Xenomai
>>     >> <xenomai@xenomai.org <mailto:xenomai@xenomai.org>
>>     <mailto:xenomai@xenomai.org <mailto:xenomai@xenomai.org>>> wrote:
>>     >>
>>     >>     On 02.03.20 11:00, Ralf Moder via Xenomai wrote:
>>     >>      > Hello everyone,
>>     >>      > I need the kernel version 5.4.23 in an embedded linux
>>     project
>>     >>     because of driver stuff but also the Xenomai extension. How
>>     big is
>>     >>     the probability that an I-pipe patch for the 5.4 version
>>     will be
>>     >>     released in the next 2 to 3 months?
>>     >>
>>     >>     I would first of all say that it's >0. But beyond that, it
>>     >> depends on
>>     >>     the architecture: x86 should be available on 5.4 in the
>>     next months
>>     >>     with
>>     >>     a probability >>50% as that will be my primary target for
>>     looking
>>     >> into
>>     >>     how to move forward. ARM and ARM64 currently lacks a
>>     maintainer.
>>     >> If we
>>     >>     are lucky, the base enabling via Philippe's dovetail queue will
>>     >> enable
>>     >>     those more or less as well. But it will definitely take someone
>>     >> to take
>>     >>     responsibility for those archs because my colleagues and I
>>     currently
>>     >>     cannot invest beyond integrating contributions. There is
>>     also ppc32
>>     >>     (which has a maintainer), but I suppose that this is not your
>>     >> target.
>>     >>
>>     >>     Jan
>>     >>
>>     >>     --     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>>     >>     Corporate Competence Center Embedded Linux
>>     >>
>>     >> If you need this for arm I was going to try to port the ipipe
>>     to 5.4
>>     >> in the near future. Effort wise it shouldn't be too bad, but it all
>>     >> depends on how much the upstream changes impact us.  What board are
>>     >> you targeting?
>>     it is a SoC from xilinx with 2 arm cortex a53 kernel on it
>>
>> This is an ultrascale? I’ve run the current ipipe code (4.19) on the 
>> ultra96 without issue.
> 
> You are right. It is a Xilinx UltraScale+ ZU2CG.  For some reasons we 
> need the 5.4 kernel version on this board.

In the CIP project, Cybertrust is currently working on a mainline 
backport of UltraScale patches to 4.19-cip. I have no overview about 
what they already support or can realistically achieve, but it may be a 
plan B. If there is interest, I can ask them for an update on the 
current status.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

