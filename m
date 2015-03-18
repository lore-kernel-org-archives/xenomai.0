MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <5509B74A.8080302@xenomai.org>
References: <CAKk99t3x2u4GN0D2w_pSBY8jWVRuE1yFki66dYNUfFBSd2GQ6w@mail.gmail.com>
 <5509B74A.8080302@xenomai.org>
Date: Wed, 18 Mar 2015 20:46:46 +0000
Message-ID: <CAKk99t26kP+wCRVS07LSAkm3zfF_Xjoo-E6d7Ynn9Cof3vXnug@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Makefile to use 2 APIs (rtdm and alchemy)
	simultaneously
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

>
> XDDP is based on RTDM, so you need POSIX, along with Alchemy for the
> changes you added, i.e.:
>
> xeno-config --alchemy --posix --ldflags


ok, thanks


> > For the original version POSIX version xeno-config returns the correct
> > compilation flags specifying rtdm skin or posix skin. It is not needed to
> > specify both.
>
> Unlike with 2.6.x, mentioning RTDM is pointless with Xenomai 3.x because
> you always have POSIX implicitly for any application, therefore you have
> RTDM. Giving --skin=rtdm or --rtdm is a no-op for compat purpose with
> legacy Makefiles actually.
>
> With 3.x, RTDM implies POSIX I/O calls and the socket interface, which
> is readily available with libcobalt, which all apps link against.
>
>
Ok, but it is still needed to specifying both:

xeno-config --alchemy --posix --ldflags

to get the all necessary linking flags, right?

Because if only specified --alchemy program is linked with libcobalt but it
still gives the same error. From the flags returned by xeno-config it seems
that it is required to specify --posix to get the wrappers on posix
functions like socket():

-Wl,@/usr/xenomai/lib/cobalt.wrappers


> xeno-config --alchemy --posix --ldflags
-Wl,@/usr/xenomai/lib/cobalt.wrappers  -lalchemy -Wl,--wrap=main
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -lcopperplate
-L/usr/xenomai/lib -lcobalt -lpthread -lrt    -lfuse

> xeno-config --alchemy --ldflags
-lalchemy -Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld
-lcopperplate -L/usr/xenomai/lib -lcobalt -lpthread -lrt    -lfuse
