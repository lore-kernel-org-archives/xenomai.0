From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3bbbaaec-cd16-ab0f-b1f1-94dc33e72318@xenomai.org>
Date: Sun, 2 Apr 2017 17:32:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai 3.0.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Xenomai 3.0.4 is out. It includes several critical bug fixes in the
Copperplate library, which means that people running non-POSIX
applications over earlier Xenomai 3.x releases should definitely
consider upgrading (especially those enabling multi process
configurations via --enable-pshared).

On the kernel side, RTDM-based SPI and GPIO driver frameworks have been
added.

http://xenomai.org/downloads/xenomai/stable/latest/xenomai-3.0.4.tar.bz2

-- 
Philippe.

