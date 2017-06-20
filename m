Date: Tue, 20 Jun 2017 11:06:57 +0800 (GMT+08:00)
From: kirayamato@zju.edu.cn
Message-ID: <6352019.c1ef.15cc377a590.Coremail.kirayamato@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai: /dev/rtheap is missing (chardev,
	major=10 minor=254)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello, everyone~

I am compiling xenomai 2.6.4 on ubuntu 14.04.2 with a kernel verion 3.14.17

I can run the xeno latency test, and the latency in user space has a max value of 20 us with the select period of 100us.

But when I tried to run a compiled example trivial-periodic.c under the source directory */xenomai-2.6.4/examples, the following alarm showed:

root@*****:/home/robot/Desktop# ./trivial-periodic
Xenomai: /dev/rtheap is missing
(chardev, major=10 minor=254)

and the compile command is:

gcc  -I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -D__XENO__    trivial-periodic.c -Xlinker -rpath
-Xlinker /usr/xenomai/lib -lnative -L/usr/xenomai/lib -lxenomai
-lpthread -lrt -o trivial-periodic

The file do not exist under the /dev/ directory.
My question is:
Is this problem due to an error config or compiling of xenomai and the patched kernel ?
Or it is caused by a wrong settings when I compiled the source code?
How should I fix it?

3Q~

                                                                                                                    yours: Kira Yamato
                                                                                                                       2017-06-19
