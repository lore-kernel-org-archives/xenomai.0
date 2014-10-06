Date: Mon, 6 Oct 2014 23:17:27 +0600
From: Alexey Shaposhnikov <canisdirusleidy@yandex.ru>
Message-ID: <20141006231727.0dbc8d26@warrawoona.sti>
In-Reply-To: <20141005135208.GC20179@sisyphus.hd.free.fr>
References: <20141004125236.655cdb65@warrawoona.sti>
 <20141004111706.GA7596@sisyphus.hd.free.fr>
 <20141005120601.112acc4e@warrawoona.sti>
 <20141005135208.GC20179@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting ipipe to vendor specific kernel. Newbie
 question.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On Sun, 5 Oct 2014 15:52:08 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> > Already tried this. But in result the script parse every driver code change
> > since 3.4.6 and make over four hundreds errors about missing architecture
> > for files like usb/serial/whiteheat.c
> 
> That is because genpatches.sh uses the stable kernel as a base for the
> patch by default. You have to pass as argument to genpatches.sh the
> hash of the commit you want it to use as base if you do not want
> that default behaviour.

Maybe I was misunderstood due to my terrible English... Current linux-sunxi
kernel is based on 3.4.103 mainstream kernel, so I trying to port ipipe core
patch from 3.4.6 for 3.4.103. For this I:

a)got sources from repository: "git clone -b legacy/core-3.4
git://git.xenomai.org/ipipe.git"
b)run genpatches.sh with this command: "./scripts/ipipe/genpatches.sh v3.4.103"
and get this:

===
./scripts/ipipe/genpatches.sh v3.4.103
reference: v3.4.103, kernel version: 3.4.6
Error unknown architecture for driver acpi/ac.c
ipipe-core-3.4.6-h8300-.patch
ipipe-core-3.4.6-avr32-.patch
ipipe-core-3.4.6-frv-.patch
ipipe-core-3.4.6-parisc-.patch
ipipe-core-3.4.6-score-.patch
ipipe-core-3.4.6-powerpc-4.patch
ipipe-core-3.4.6-microblaze-.patch
ipipe-core-3.4.6-xtensa-.patch
ipipe-core-3.4.6-um-.patch
ipipe-core-3.4.6-unicore32-.patch
ipipe-core-3.4.6-ia64-.patch
ipipe-core-3.4.6-arm-4.patch
ipipe-core-3.4.6-s390-.patch
ipipe-core-3.4.6-cris-.patch
ipipe-core-3.4.6-x86-4.patch
ipipe-core-3.4.6-sparc-.patch
ipipe-core-3.4.6-tile-.patch
ipipe-core-3.4.6-mips-.patch
ipipe-core-3.4.6-alpha-.patch
ipipe-core-3.4.6-sh-.patch
ipipe-core-3.4.6-mn10300-.patch
ipipe-core-3.4.6-m32r-.patch
ipipe-core-3.4.6-m68k-.patch
ipipe-core-3.4.6-blackfin-4.patch
===
(If use script from ipipe-3.14 branch then it not make all those crippled
patches, but generate four hundreds errors about missing architecture)

So I'm definitely doing something wrong, but can't figure what.

-- 
Alexey Shaposhnikov

