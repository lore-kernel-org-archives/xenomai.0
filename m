Message-ID: <536EC25D.6020906@xenomai.org>
Date: Sun, 11 May 2014 02:20:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMbo_3DjWPb2xt27WAR6MF6bLHf-QZM-n-VduNTugx34cQ0LPg@mail.gmail.com>	<536DF390.9000604@xenomai.org>	<536E1962.30008@xenomai.org>
 <CAMbo_3Av1qCUpXk1osvwczvu5OtCzyge3wxSgsfbOZcYq786uw@mail.gmail.com>
In-Reply-To: <CAMbo_3Av1qCUpXk1osvwczvu5OtCzyge3wxSgsfbOZcYq786uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on v3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Brian Morel <brianmorel99@gmail.com>
Cc: xenomai@xenomai.org

On 05/11/14 02:07, Brian Morel wrote:
> I cloned the ipipe.git repository & checked out ipipe-3.14 .  I tried
> running the genpatches.sh script, but it appears that tag v3.14 doesn't
> exist in the repository.  I tried the same process for 3.8 & it worked
> fine.  I assume this is because the stable tree isn't there, but my git
> foo isn't good, so I don't know how to add it.  Any advice would be great.

The latest mainline tags have been pushed to the tree. Please retry.

>
> Thanks, Brian
>
>
> On Sat, May 10, 2014 at 8:19 AM, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
>
>     On 05/10/2014 11:38 AM, Philippe Gerum wrote:
>
>         On 05/10/2014 04:35 AM, Brian Morel wrote:
>
>             I want to start working on Xenomai & I-pipe on kernel 3.14
>             for arm
>             (beagle
>             bone black).  I was hoping for a little advise on which git
>             repositories to
>             use for both Xenomai & I-Pipe.  It looks like I would need
>             the I-Pipe
>             patch
>             from either the main I-Pipe repo. or one of the named repos.
>
>
>         ipipe-3.14 has just landed in git://git.xenomai.org/ipipe.__git
>         <http://git.xenomai.org/ipipe.git>, with the
>         latest ARM bits merged. The I-pipe support for ARM usually brews
>         in this
>         tree: git://git.xenomai.org/ipipe-__gch.git
>         <http://git.xenomai.org/ipipe-gch.git>, then gets merged in our
>         mainline tree as mentioned earlier.
>
>
>     Make sure to disable CONFIG_CONTEXT_TRACKING for now. We are still
>     investigating an issue with this feature.
>
>     --
>     Philippe.
>
>


-- 
Philippe.

