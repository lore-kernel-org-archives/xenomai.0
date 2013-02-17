MIME-Version: 1.0
In-Reply-To: 
References: 
From: George Broz <GBroz@moog.com>
Message-ID: <OF44D0F7ED.D0CBED6B-ON85257B15.00319BA4-85257B15.00319BA9@moog.com>
Date: Sun, 17 Feb 2013 04:01:51 -0500
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [Xenomai] properties of task at priority 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello All,

I'm using a kernel driver for which some calls cause the=20
Xenomai kernel to crash with a message:
    "Xenomai: stuck on nucleus lock..",=20
but only when called from a Xenomai task with a non-zero priority.


If I make the same calls from a Linux thread that is still part
of the Xenomai application, no crash results. And it seems
that when I make the same calls from a Xenomai task that has=20
a priority of "0", it also does not crash the kernel.


I knew these calls would put the task into secondary mode=20
since they make a number of kmallocs/kfrees and other syscalls.
I didn't expect there to be a difference in behavior between=20
a Xenomai task in secondary mode versus a normal Linux thread=20
versus a Xenomai task with priority of "0".


I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API on x86=20
(Atom, SMP, 32-bit).


Is it possible that a (well-written) driver can cause such=20
behavior?  (If not I can post the crashdump details).


I would like to use rt=5Fevent=5F / rt=5Fmutex=5F at other times=20
which I cannot do if I need to make this a Linux thread. =20
Is there a rational explanation that would allow me to use
these calls and the driver calls if I simply set the task=20
to priority "0"?


Thanks in advance!
----
George Broz
Moog, Inc. Industrial Group=


