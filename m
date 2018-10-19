From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Date: Fri, 19 Oct 2018 17:10:17 +0200
Message-ID: <36670432.JDg3nDlJl9@lenni>
In-Reply-To: <2049752.DBDckmn0oA@lenni>
References: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
 <2d0b645e-d23b-db0f-ea66-17dc8a75e918@xenomai.org> <2049752.DBDckmn0oA@lenni>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] [PATCH] boilerplate/avl: fix missing include
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Philippe,

Sebastian Smolorz wrote:
> On 10/19/2018 09:16 AM, Philippe Gerum wrote:
> > On 10/18/2018 04:37 PM, Sebastian Smolorz wrote:
> > > Nevertheless, I guess there is an issue with the definition of
> > > const
> > > (line 50) in include/boilerplate/compiler.h. It does work with gcc
> > > 5.4 but not with gcc 4.3.5.
> > 
> > Could you elaborate on this? Which error pops us, in which context?
> 
> Compilation of libboilerplate and libiniparser (master and next) fails
> with a cross gcc 4.3.5 for x86_32 (i586) targets. If I change the
> line mentioned above into
> 
> #define __const const
> 
> the error does not pop up any more. Works also when I completely
> remove the #define __const.

I've found two additional compile errors due to the usage of ancient gcc 
and glibc. I could prepare patches for that. But I'm not sure how to fix 
this __const issue properly. I've seen that you introduced those lines 
in commit  5632adb8 into -next. I suppose you faced an issue which 
needed this fix, am I correct?

Thanks,

-- 
Sebastian



