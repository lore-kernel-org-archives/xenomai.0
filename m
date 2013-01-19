Message-ID: <50FAFF77.8020803@zultron.com>
Date: Sat, 19 Jan 2013 14:17:59 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] 32-bit regression tests:  CLOCK_REALTIME wonkiness
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi list,

These are the final tests on 32-bit before the initial RedHat packages
can be released for wider testing.

On this host, a Dell Celeron with ICH5 chipset, the CLOCK_REALTIME
numbers look funny.  All other tests run correctly.

++ /usr/lib/xenomai/clocktest -T 30
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  0.0            0.000          0            0.0
^[[1A  0           -1074721.3           39.245          0            0.0
^[[1A  0           -1074711.5           39.172          0            0.0
^[[1A  0           -1074701.8           39.096          0            0.0
^[[1A  0           -1074691.9           39.184          0            0.0

This is Gilles's i-pipe dev tree and xenomai master pulled yesterday,
kernel 3.5.7.

	John


http://www.zultron.com/static/2013/01/xenomai/3.5.7-test-32-bit/config-3.5.7.txt

http://www.zultron.com/static/2013/01/xenomai/3.5.7-test-32-bit/dmesg.log

http://www.zultron.com/static/2013/01/xenomai/3.5.7-test-32-bit/xeno-regression-test.log

