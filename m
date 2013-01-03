MIME-Version: 1.0
Date: Thu, 3 Jan 2013 17:22:25 -0500
Message-ID: <CAD1EtoiVOD7KdOD7ZyqtxQ3AttD=Ca0bbsOsKOiMQtyNxm47EA@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] make devices not run from deb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In the latest from git, when I create a .deb using debuild, the resulting
deb, when installed, doesn't seem to create /dev/rtheap.

Under 2.6.1, the same debuild process created a deb which when installed
did create /dev/rtheap.
