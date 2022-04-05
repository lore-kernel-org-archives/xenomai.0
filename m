MIME-Version: 1.0
From: Ashwik John <johnashwik994@gmail.com>
Date: Tue, 5 Apr 2022 14:34:21 +0200
Message-ID: <CAESnvfOs_Y+p8kTJqHeOCp8Miref_ca+YhGg=MUJVOpnHxyuTA@mail.gmail.com>
Subject: Re: EVL testing
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

Hi,
I have successfully booted the system with EVL core enabled. I proceed to
test the EVL and I receive this error message.

libevl-next/tests/basic-xbuf.c:41: FAILED: evl_attach_thread((0 << 16),
"basic-xbuf:%d", getpid()) (=Permission denied)
** basic-xbuf: BROKEN

I use libel : branch next and linux-evl-v5.15.29-evl2-rebase.

Thank you for your reply.
