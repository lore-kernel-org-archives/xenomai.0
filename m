From: steve freyder <steve@freyder.net>
Subject: [Xenomai] bad syscall <0x197>
Message-ID: <d44aeeb8-f265-81fd-01b8-3f2648949ead@freyder.net>
Date: Wed, 24 Feb 2021 14:45:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Greetings Xenomai list,


I have a Linux OE 4.14.85 build with Xenomai 3.1 -next branch, and am 
seeing this:

root@ICB-G3L:~ # uname -a
Linux ICB-G3L 4.14.85_C01571-15S01A01.000.zimg+35a84af5b7 #1 SMP Mon Feb 
22 20:57:38 UTC 2021 armv7l GN
U/Linux
root@ICB-G3L:~ # smokey --run=posix_mutex
[  694.433129] [Xenomai] bad syscall <0x197>
posix_mutex OK

I found this thread:

https://www.mail-archive.com/xenomai@xenomai.org/msg17931.html

But I can't get a clear picture on the proper resolution of this issue, 
other than it's related to a non-existent syscall, perhaps glibc 
version, and/or __real_usleep().  I'd like to get this working on either 
4.14 or 4.19, is there a simple workaround for this?

Thanks in advance,

Steve




