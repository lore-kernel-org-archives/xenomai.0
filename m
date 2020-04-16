MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 16 Apr 2020 16:57:42 +0800
Message-ID: <CAAvDm6bm0dd5KMfZuC9n2f8h7hBJb4ppmigKdQhfwEEy1_SRrQ@mail.gmail.com>
Subject: =?UTF-8?B?RVJSIE1TR++8miBjYWxsZWQgcmVndWxhciByZWFkKCkgb24gL2Rldi9ydGRtL2Zha2VfZA==?=
 =?UTF-8?B?ZXY=?=
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,
       I got the error message listed below when I called read operation to
an opened rtdm file handle in main function.
       I have implemented the rt read operation in my rtdm driver allready.
       I think the main thread is allready turned into xenomai thread
because I have called rt_shadow_task function before the reading opreation.
       I wonder why this error message occurs.

       Error message from kernel.
       [155453.637967] [Xenomai] task@1[42395][42395] called regular read()
on /dev/rtdm/fake_dev.
       Look forward to hearing from you.
      Thanks a lot.
