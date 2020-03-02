Subject: Re: Ipipe-Patch for kernel version 5.4.23
References: <DB8PR09MB3612215A31188B5C00AD779BF0E70@DB8PR09MB3612.eurprd09.prod.outlook.com>
 <c4a79189-6696-a109-97f6-8cadbb36923e@siemens.com>
 <CALLqZ8TNspMLYOfrA11_xB6dh=LjXiTV8_P12+s_a_exUv6tqQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <68ddab50-1002-7100-a745-3387b28592b2@siemens.com>
Date: Mon, 2 Mar 2020 17:01:19 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8TNspMLYOfrA11_xB6dh=LjXiTV8_P12+s_a_exUv6tqQ@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>, Ralf Moder <ralf.moder@hbkworld.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02.03.20 16:17, Greg Gallagher wrote:
> 
> On Mon, Mar 2, 2020 at 7:38 AM Jan Kiszka via Xenomai 
> <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> wrote:
> 
>     On 02.03.20 11:00, Ralf Moder via Xenomai wrote:
>      > Hello everyone,
>      > I need the kernel version 5.4.23 in an embedded linux project
>     because of driver stuff but also the Xenomai extension. How big is
>     the probability that an I-pipe patch for the 5.4 version will be
>     released in the next 2 to 3 months?
> 
>     I would first of all say that it's >0. But beyond that, it depends on
>     the architecture: x86 should be available on 5.4 in the next months
>     with
>     a probability >>50% as that will be my primary target for looking into
>     how to move forward. ARM and ARM64 currently lacks a maintainer. If we
>     are lucky, the base enabling via Philippe's dovetail queue will enable
>     those more or less as well. But it will definitely take someone to take
>     responsibility for those archs because my colleagues and I currently
>     cannot invest beyond integrating contributions. There is also ppc32
>     (which has a maintainer), but I suppose that this is not your target.
> 
>     Jan
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 
> If you need this for arm I was going to try to port the ipipe to 5.4 in 
> the near future. Effort wise it shouldn't be too bad, but it all depends 
> on how much the upstream changes impact us.  What board are you targeting?

I suppose that questions addresses Ralf (provided he runs on ARM).

As mentioned before, our tiny test lab currently contains for ARM a 
BeagleBone Black and QEMU instance.

> 
> Jan, I can  help out maintaining the ARM ipipe.  We can talk offline if 
> you'd like.

That would be great, looking forward!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

