MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 16 Apr 2020 15:49:57 +0800
Message-ID: <CAAvDm6ZqF-KdCS1Fz9MrXb7b16Otega46S=PH6CaJU3wcZt21Q@mail.gmail.com>
Subject: Must I provide both rt function and nrt function for the ops of rtdm
 driver ?
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
        Must I provide both rt function and nrt function for the ops of
rtdm driver ?
        Must I implement the rt read and nrt read operation if i need
provide read operation for my rtdm driver?What I have to consider?
        I have searched all over the source code of xenomai-v3.1.I find
that most rtdm driver have both rt_ioctl and nrt_ioctl  ,but none
nrt_read\nrt_write function is implemented except the driver named analogy.

         Look forward to hearing from you.
         Thanks a lot.
