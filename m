MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Wed, 8 Jul 2020 18:40:12 +0800
Message-ID: <CAAvDm6bez1O1YUv9N93wLgwNdpxn0tbxXLx=rRzKLyepSU+Cow@mail.gmail.com>
Subject: How to comprehend "Xenomai threads shadow Linux threads" in the right
 way?
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

Hi, list

There is such a macro in the source code:
#define XNUSER    0x00040000 /**< Shadow thread running in userland */
So, I guess shadow thread is equivalent to real-time thread(maybe,
xenomai thread is more suitable here).

As per the presentation
(https://elinux.org/images/d/d7/Practical-Real-Time-Linux-ELCE15.pdf
 page 7),
which says that:
"Xenomai threads shadow Linux threads".
I guess that there is a one-to-one correspondence between xenomai
threads and Linux threads.
And if my guess is right, what happens then?
There should be several Linux threads **which can be observed by `ps
-elf` of  `top`** when I
have created the same number of xenomai threads.
But I have not seen such a phenomenon. So where goes wrong?

Thank you for your attention to this matter.
Looking forward to hearing from you.
Best Regards.

