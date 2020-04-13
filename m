MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 13 Apr 2020 15:20:33 +0800
Message-ID: <CAAvDm6bFOv=0_9kcX5BUtPYs3dRh-aVc7XARY7BtDo5Pu4Mz-Q@mail.gmail.com>
Subject: How could I allocate a huge memory in rtdm driver?
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
     I am using xenomai 3.1.

     How could I allocate a huge memory which may be larger then 50MB in
rtdm driver?

     I have tried rtdm_malloc function,but it returns NULL.

    To provide the operating system a large amount of free memory, I do
this test when the ubuntu is started at once in vmware.

    Best regards.
