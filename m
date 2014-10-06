Message-ID: <5432D2D7.4080807@xenomai.org>
Date: Mon, 06 Oct 2014 19:35:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20141004125236.655cdb65@warrawoona.sti>
 <20141004111706.GA7596@sisyphus.hd.free.fr>
 <20141005120601.112acc4e@warrawoona.sti>
 <20141005135208.GC20179@sisyphus.hd.free.fr>
 <20141006231727.0dbc8d26@warrawoona.sti>
In-Reply-To: <20141006231727.0dbc8d26@warrawoona.sti>
Content-Type: text/plain; charset=UTF-8
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
To: Alexey Shaposhnikov <canisdirusleidy@yandex.ru>, Xenomai <xenomai@xenomai.org>

On 10/06/2014 07:17 PM, Alexey Shaposhnikov wrote:
> ./scripts/ipipe/genpatches.sh v3.4.103
> reference: v3.4.103, kernel version: 3.4.6

You are generating I-pipe patches for the diff between v3.4.103 and
v3.4.6. This is probably not what you want to do.

If you want to generate I-pipe patch for 3.4.6 branch, then simply run
genpatches.sh v3.4.6 or genpatches.sh with no argument.

But these patches are available here:
http://download.gna.org/adeos/patches/v3.x/arm/older/

What I would do if I were you is:

git checkout -b my-3.4 legacy/core-3.4
git merge v3.4.103

Fix the conflicts.

genpatches.sh v3.4.103, in order to generate patches for the 3.4.103 branch.

Then git merge sun-xi

Fix the conflicts and get the port running

Then follow:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#Working_with_vendor_forks

To generate pre- and post- patches for the patches for 3.4.103 generated
above.

Alternatively,

run genpatches.sh sun-xi

in order to generate an all-in-one adeos patch for the sun-xi kernel. It
may also make sense since the kernel 3.4 is a bit old now (more than 2
years), so we are not going to include a new version of it in a next
release of xenomai.

-- 
                                                                Gilles.

