MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 6 Apr 2020 15:22:46 +0800
Message-ID: <CAAvDm6Zsm-gF+HwBLx1jo4-WHHu37_YoPGOTvgey3FVeWVCMWA@mail.gmail.com>
Subject: Is anybody can show me a simple rtdm driver to read/write virtual
 memory device?
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

Is anybody could show me a simple xenomai3 rtdm driver to read/write
virtual memory device?
A virtual memory device to:
    write "hello world" to memory device in real real time(It's appricate
if the write operation could wake up the read task which allready waited to
read)
read  the memory device in real time(It's appricate if the read operation
could wake up the write task which allready waited to write)
