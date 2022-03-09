MIME-Version: 1.0
From: Greg Pettit <vendors@dysim.com>
Date: Wed, 9 Mar 2022 15:06:18 -0500
Message-ID: <CAG40PBpE85EAn3N3RreYu7bmsM=StcO2Z8vDVf+3pFxQnd34Ow@mail.gmail.com>
Subject: copy-uapi.sh appears to copy absolute path of uapi headers to install
 prefix
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am cross compiling libevl and pass -Dprefix=/usr/evl during meson
setup.  The installed uapi headers are under /usr/evl/include as
expected; however, the absolute meson build path precedes the uapi
headers.

For ex:
/usr/evl/include/home/user/build/include/uapi...

It appears the find command in the copy_uapi.sh script is passing the
absolute path to cpio.  To test I ran the following copy_uapi.sh:

#! /bin/sh
# $1 = O_UAPI
# $2 = $prefix/includedir

#find -L $1/evl \! \( -name '*~' \) -type f | cpio -pduvm $DESTDIR/$2
cp -rL $1 $DESTDIR/$2

this installed the uapi in the /usr/evl/include directory:
/usr/evl/include/uapi...

Thanks,
Greg

