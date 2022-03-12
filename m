References: <CAG40PBpE85EAn3N3RreYu7bmsM=StcO2Z8vDVf+3pFxQnd34Ow@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: copy-uapi.sh appears to copy absolute path of uapi headers to
 install prefix
Date: Sat, 12 Mar 2022 15:21:50 +0100
In-reply-to: <CAG40PBpE85EAn3N3RreYu7bmsM=StcO2Z8vDVf+3pFxQnd34Ow@mail.gmail.com>
Message-ID: <87ilsjfdyx.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Pettit <vendors@dysim.com>
Cc: xenomai@xenomai.org


Greg Pettit via Xenomai <xenomai@xenomai.org> writes:

> I am cross compiling libevl and pass -Dprefix=/usr/evl during meson
> setup.  The installed uapi headers are under /usr/evl/include as
> expected; however, the absolute meson build path precedes the uapi
> headers.
>
> For ex:
> /usr/evl/include/home/user/build/include/uapi...
>
> It appears the find command in the copy_uapi.sh script is passing the
> absolute path to cpio.  To test I ran the following copy_uapi.sh:
>
> #! /bin/sh
> # $1 = O_UAPI
> # $2 = $prefix/includedir
>
> #find -L $1/evl \! \( -name '*~' \) -type f | cpio -pduvm $DESTDIR/$2
> cp -rL $1 $DESTDIR/$2
>
> this installed the uapi in the /usr/evl/include directory:
> /usr/evl/include/uapi...
>
> Thanks,
> Greg

Fixed in master, thanks.

-- 
Philippe.

