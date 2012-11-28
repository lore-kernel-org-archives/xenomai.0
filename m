Message-ID: <50B5B966.4080506@gmail.com>
Date: Wed, 28 Nov 2012 08:12:38 +0100
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] GPIO in Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm looking for a way to use the SoC GPIO's (MPC5200) in an RT thread.
Accessing them via the sysfs (the Linux userspace way) is not an option
since we need to access the GPIO's at a quite high frequency.

How could the Linux gpiolib infrastructure best be exposed to RT
threads? Has this been discussed before? Any ideas about the "best"
approach here?

Thanks,
Stefan

