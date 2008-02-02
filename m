MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18340.32766.975932.415518@domain.hid>
Date: Sat, 2 Feb 2008 15:36:46 +0100
In-Reply-To: <47A47E33.4030909@domain.hid>
References: <18340.31233.591834.293535@domain.hid>
	<47A47E33.4030909@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 0/5] Support for select v2.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Hi,
 > > 
 > > after some tests, bug fixes and optimizations, here comes a second version of 
 > > the patch-set adding select support to xenomai posix skin.
 > 
 > It's on my agenda for today or tomorrow to have a closer look at this.
 > Just one general question already: Why is it "select" and not "poll and
 > select"? Is it trivial to extend later on?

Because making an O(1) poll is impossible, when entering poll, you have
to scan the whole list of file descriptors for new descriptors, and this
will take O(n). In select implementation, this is done with bounded bit
operations so remains O(1). Of course, the downside is that you are
limited to FD_SETSIZE (that is 1024) descriptors, but I do not find this
limitation unbearable for real-time applications.

Anyway, you can implement poll in user-space to use select. I saw this
for instance in Asterisk sources.

-- 


					    Gilles Chanteperdrix.

