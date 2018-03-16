References: <CAOuPNLjjqZgqzwRe5ACxdPiCUpedbEW4Xh3FU=gSZc9tMmdgjw@mail.gmail.com>
 <5f063f66-df76-f7d4-c01e-aa7baadf3420@xenomai.org>
 <CAOuPNLhDXu3+igc7dKCWUxp1uy=1KzCXorr1gWmtjY=3ZrL4ig@mail.gmail.com>
 <78df92df-7f8b-c439-ce1c-732068e91ff3@xenomai.org>
 <CAOuPNLitA++hLqwGqU6+SN3mhhAfgOzfpyEd0XR4CvU_ykT7fg@mail.gmail.com>
 <b43d4638-51a6-e583-e138-c1c8317f669b@xenomai.org>
 <CAOuPNLgVyd45-vG9CF7vYnCxQ4ksf-O52etQe1iHUhSjG-HuxA@mail.gmail.com>
 <35565a5e-7e26-a419-715c-323dbdb13ba6@xenomai.org>
 <CAOuPNLhCTf5Hk+YPMmsKUXeokWEv+RYMp3sfqOpwRYy=khX=KA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <716a6af5-367b-e083-9490-396f0468dbc9@xenomai.org>
Date: Fri, 16 Mar 2018 11:19:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLhCTf5Hk+YPMmsKUXeokWEv+RYMp3sfqOpwRYy=khX=KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] segmentation fault during rt_task_unblock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/16/2018 10:49 AM, Pintu Kumar wrote:
> OK Thank you so much :)
> 

Fixed by this commit from the -stable branch.

http://git.xenomai.org/xenomai-3.git/commit/?id=945c7dbf7c5ae19755a26b69d00f714176c87c4a

>
>
> I think this tests works on Xenomai 2.6 (some one else tested long
> back. Unfortunately I don't have 2.6 setup now).
> 

The code is entirely different between 2.6 and 3.x regarding non-POSIX
APIs, that bug could not exist in 2.6 (not in that form).

> I wanted to help you in fixing this bug from Xenomai side and contribute.
> It will be a tiny help to start contributing to Xenomai kernel.
> 
> Is it possible to give some pointers so that I can debug more and fix
> a suitable fix?
> 

It's already done for this time, maybe if/when the next issue pops up,
thanks for the proposal.

As a general hint, I would recommend to build with --enable-debug=full
when something goes wrong, this would enable many internal checks that
may help detecting weird conditions in libcopperplate.

In addition, when non-POSIX APIs are involved, I would recommend to
proceed gradually as follows:

- if running over Cobalt, check whether the same bug would not also
happen over Mercury. If so, switching to Mercury would make debugging
fully native, enabling valgrind for looking for memory corruption, and
would move the dual kernel specifics out of the way. Building for
Mercury is trivial, and the resulting stack can immediately run on your
desktop with absolutely no Xenomai-specific kernel support. Of course,
this excludes real-time related issues, and bugs not reproducible
without rt drivers. Simple test cases about API breakage usually don't
need that anyway.

- if Xenomai was built with --enable-pshared, check whether the bug also
happens with a stack built the other way, i.e. --disable-pshared. This
would move the shared heap machinery out of the picture, simplifying the
debugging context.

What would definitely help is summarizing the issues your team went into
while building, installing, configuring, programming or running Xenomai
3. I'm currently collecting FAQ material to update our existing FAQ
list, which is skeletal.

Generally speaking, improving any part of the documentation that may
help users to get up to speed with Xenomai is a high priority task, and
a valuable contribution to the project.

-- 
Philippe.

