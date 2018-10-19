From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Date: Fri, 19 Oct 2018 11:56:54 +0200
Message-ID: <2049752.DBDckmn0oA@lenni>
In-Reply-To: <2d0b645e-d23b-db0f-ea66-17dc8a75e918@xenomai.org>
References: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
 <trinity-71d48a15-4ece-4d49-b012-73220dfbbc6f-1539873444067@msvc-mesg-gmx123>
 <2d0b645e-d23b-db0f-ea66-17dc8a75e918@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 10/19/2018 09:16 AM, Philippe Gerum wrote:
> On 10/18/2018 04:37 PM, Sebastian Smolorz wrote:
> > Nevertheless, I guess there is an issue with the definition of const
> > (line 50) in include/boilerplate/compiler.h. It does work with gcc
> > 5.4 but not with gcc 4.3.5.
> 
> Could you elaborate on this? Which error pops us, in which context?

Compilation of libboilerplate and libiniparser (master and next) fails 
with a cross gcc 4.3.5 for x86_32 (i586) targets. If I change the line 
mentioned above into

#define __const const

the error does not pop up any more. Works also when I completely remove 
the #define __const.

-- 
Sebastian




