From: Michael Haberler <haberlerm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <160C846F-0153-4526-9C58-F110C939335F@gmail.com>
Date: Mon, 31 Aug 2015 16:29:25 +0200
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: [Xenomai] clock_gettime(CLOCK_HOST_REALTIME) equivalent using
	native skin?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

We are planning to synchronize several nodes running machinekit with =
IEEE1588/Precision Time Protocol using the ptpd debian sid package
ptp adjusts the tunable kernel clock through adjtimex(2) similar to ntpd

Assuming Xenomai2, it seems the Posix skin's =
clock_gettime(CLOCK_HOST_REALTIME) is the way to access this timebase

do I need to use the Posix skin or is there a way to do the equivalent =
using the native API?


thanks in advance,

Michael


