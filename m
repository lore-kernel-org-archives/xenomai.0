Date: Tue, 29 Sep 2015 03:25:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929012542.GC15767@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] I-pipe tracer issue on at91
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

since the AT91 I-pipe timer code was rebased on the mainline
tcb_clksrc driver, the I-pipe tracer is broken for these platforms.
The following patch is an attempt to fix it. If everyone agrees with
the patch, I can apply it to the most recent I-pipe branches.

Regards.

-- 
					    Gilles.
https://click-hack.org

