MIME-Version: 1.0
Date: Wed, 1 Oct 2014 10:35:11 +0300
Message-ID: <CABaOOZ1C-Yo+SPfbxk35kYavnugGK0yZQ3nYivpritw6wtxO1A@mail.gmail.com>
From: Stratiyenko Roman <picoworm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Can not compile mertcury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Today I downloaded latest xenomai 3 from git.
I want to try mercury version
I did ./configure --with-core=mercury
after make, I have error compiling testsuite

../../lib/copperplate/.libs/libcopperplate.so: undefined reference to
`timer_create'
../../lib/copperplate/.libs/libcopperplate.so: undefined reference to
`timer_delete'
../../lib/copperplate/.libs/libcopperplate.so: undefined reference to
`timer_settime'
collect2: error: ld returned 1 exit status

What am I doing wrong?

Best regards,
Roman
