From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BF62296-6E7D-4758-9084-62F575A58151@mah.priv.at>
Date: Sun, 27 Apr 2014 17:29:08 +0200
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: [Xenomai] q: userland timestamps  which match rt_timer_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I need to create ns-resolution timestamps from RT (using rt_timer_read() =
- no surprises) and from normal userland programs

the latter binaries should be Xenomai-unaware if possible - is there a =
normal Linux API which reads the same timestamp source as =
rt_timer_read()?

eg: clock_gettime(CLOCK_xxxx)?

thanks in advance,

Michael


