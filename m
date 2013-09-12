MIME-Version: 1.0
Date: Thu, 12 Sep 2013 18:17:58 -0400
Message-ID: <CAD1EtojVmN2YVhTXswREuxaue2gzZe=Hgsxhnfksop6YRghWrA@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] cat /proc/rtcan/sockets gives "Bad address"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

$ cat /proc/rtcan/sockets
cat: /proc/rtcan/sockets: Bad address

Other than this, our Xenomai and CAN systems are working just fine. This
used to work. Any idea why we'd be getting that?

Daniel
