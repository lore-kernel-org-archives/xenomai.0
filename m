From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 28 Aug 2014 16:35:32 -0400
Message-ID: <20140828203532.GA17690@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Xenomai/Ipipe on arm with LPAE enabled not booting
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

So I did some experiments on 3.12 kernel on an omap5726.

Xenomai/ipipe seems to work great (after all it managed to pass the
xenomai test suite).

LPAE+KVM also works great.

However if you enable LPAE (with or without KVM) while ipipe is enabled
(with or without xenomai enabled), then the kernel never boots (no
console messages at all).

Any ideas where to start on debugging this problem?

-- 
Len Sorensen

