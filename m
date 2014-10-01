MIME-Version: 1.0
In-Reply-To: <20141001213611.GI4435@csclub.uwaterloo.ca>
References: <CANgF67Q+ZneJM-osJT07NS45AWaZEPetHjUL5EBc5SvW0Dc7rQ@mail.gmail.com>
 <20141001213611.GI4435@csclub.uwaterloo.ca>
Date: Thu, 2 Oct 2014 00:46:22 +0300
Message-ID: <CANgF67SoFqOZtcC87Wy04RT5ARqK2+H8w+b79Yvf3d_QcnqAjQ@mail.gmail.com>
From: agnes jurek <agnessjurek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] nucleus/sched.h: No such file or directory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

2014-10-02 0:36 GMT+03:00 Lennart Sorensen <lsorense@csclub.uwaterloo.ca>:

> On Thu, Oct 02, 2014 at 12:27:34AM +0300, agnes jurek wrote:
> > I tried to write simple code myself using xenomai rtdm module. When I
> added
> > "
> > #include <xenomai/rtdm/rtdm.h>", compilation  was ok. But when I added "
> > #include <xenomai/native/task.h>", I got an error message. It said that
> > "/usr/include/xenomai/native/task.h:25:27: fatal error: nucleus/sched.h:
> No
> > such file or directory
> > compilation terminated."
>
> Xenomai unfortunately requires you to add /usr/include/xenomai to your
> includes, which does mean you don't have to put xenomai/ in your #include
> statements though.
>
> # pkg-config --cflags libxenomai_rtdm libxenomai_native
> -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/include/xenomai
>
> # pkg-config --libs libxenomai_rtdm libxenomai_native
> -lrtdm -lnative -lxenomai -lpthread -lrt
>
> pkg-config is handy, and worth using.
>
> --
> Len Sorensen
>


@Lennart, you said "you don't have to put xenomai/ in your #include
statements though.". But when I added  "#include <rtdm/rtdm.h>" and
"-lrtdm" on linking, I got error. If I add "#include
<xenomai/rtdm/rtdm.h>", it is ok.
