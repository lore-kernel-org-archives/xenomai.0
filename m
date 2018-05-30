MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 30 May 2018 17:53:56 +0530
Message-ID: <CAOuPNLhyONj-YoVDYPN4bAfs2KVOryUCBXCg_1RKDgnBVwEhwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Creating my own folder inside xenomai/demo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I wanted to create my own folder "pintu" inside xenomai-3/demo and put
my sample test program (say: hello.c) to make it build as part of
xenomai - make
I added like this:
demo/Makefile.am:
+SUBDIRS = posix alchemy PINTU

/xenomai-3-next$ ls demo/PINTU/
Makefile.am  hello.c

I want to build this hello program as part of xenomai root build.
Can you describe the procedure on how to do it in simple steps.


Thanks,
Pintu

