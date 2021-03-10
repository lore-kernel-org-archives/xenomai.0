From: Wolfgang Denk <wd@denx.de>
Subject: Re: [IMPORTANT] gitlab relocation / rename
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <20210308083457.76db0c20@md1za8fc.ad001.siemens.net>
References: <621240.1614155458@gemini.denx.de>
 <781641.1614525295@gemini.denx.de>
 <20210308083457.76db0c20@md1za8fc.ad001.siemens.net>
Date: Wed, 10 Mar 2021 08:56:48 +0100
Message-ID: <1083829.1615363008@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Wolfgang Denk via Xenomai <xenomai@xenomai.org>, u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de, Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>

Dear Henning,

In message <20210308083457.76db0c20@md1za8fc.ad001.siemens.net> you wrote:
>
> I do not understand why this is not just gitlab (proper) or github. I
> hope this discussion was held with the communities of the affected
> projects involved. While being disruptive i would suggest for Xenomai
> to move away from denx. For the git side of the operations. To be more
> open and welcoming to users/contributers etc.

Are you positively sure that moving to any otherhosting environment
will have any positive effect on how the Xenomai community works?

We use the very same setup for U-Boot as well, which has a _much_
bigger and _much_ more active community.  We have regular releases
every 3 months, and most releases include commits from >200
developers from >30 employers.  And the CI setup for U-Boot is in no
respect (number of supported architectures / processors / boards /
tool chains) less challenging than what you do in Xenomai, on
contrary.  Not to mention the development rate - U-Boot sees > 20
commits per day in mainline.

Sorry, but I don't buy your "more open and welcoming to users/contri-
buters" comment.  THe existing environment has proven to work fine
for a FOSS community project.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Someone who thinks logically is a nice contrast to the real world.

