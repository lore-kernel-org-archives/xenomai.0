From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <01C12D13-C7D5-4DDD-8ED3-4359E6FBE665@mah.priv.at>
Date: Thu, 3 Jul 2014 10:56:22 -0400
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: [Xenomai] arm & 64bit atomics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

we found this: =
http://stackoverflow.com/questions/9857760/can-an-arm-interrupt-occur-in-m=
id-instruction and are considering which impact that has on machinekit, =
which uses doubles in memory shared between threads, relying on updates =
being atomic

I wonder if this topic has come up in the Xenomai context?

specifically - can it happen that an RT thread is rescheduled in the =
middle of a 64bit store?

also, I found that for older ARM's there are kernel mode helpers to =
support 64bit atomics =
(https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt) - =
I assume those work fine with Xenomai?

sorry about the fuzzy question - still trying to figure if/how this =
affects us

- Michael=

