From: Philippe Gerum <rpm@xenomai.org>
Subject: Dovetail/x86 early release
Message-ID: <b3004057-3098-5e5b-9ebd-de0b8f879e3a@xenomai.org>
Date: Mon, 20 May 2019 17:52:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>


As announced earlier [1], Dovetail is being ported to x86_64 over kernel
5.1. An early release is now available at [2]. Xenomai cannot use this
infrastructure yet (WIP, preparatory work ongoing at [3]), but EVL [4]
can as it is Dovetail-native and this is my co-kernel workhorse for
testing these days.

I only have access to a couple of x86 SoCs, so people willing to help in
testing this work on their x86 hardware of choice can find useful
information to bring up a basic test system at [5].

Thanks,

[1] https://www.xenomai.org/pipermail/xenomai/2019-May/040884.html
[2] git://git.evenless.org/linux-evl.git
[3] git://lab.xenomai.org/xenomai-rpm.git
[4] https://evenless.org/core/
[5] https://evenless.org/core/build-steps/

-- 
Philippe.

