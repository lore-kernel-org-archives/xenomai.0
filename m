Date: Fri, 23 Jan 2015 08:52:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150123075237.GL29604@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] ARM/ipipe patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,

You may have missed the discussion between Jan and me, but I am
opposed to the following commits:
https://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.14&id=7272c23ff5e1be3bfad58497de132e0336649c34
https://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.14&id=5ca7ed6c7c0316de5f494b773f3c7c3263aa726b

as long as Jan does not provide an explanation on how it fixes all
the possible paths (which are not numerous) in entry.S. As long as I
do not have this explanation, I consider these patches of the
half-baked, "works for me" kind and refuse to have to be the one who
on a user bug report, after a lengthy discussion, discover that they
cause some unexpected crashes. And since I am the one maintaining
the I-pipe pat for ARM, this is what is going to happen if they
indeed do not fix all the possible pathes in entry.S. The reason why
I did not make CONFIG_TRACE_IRQFLAGS depend on !IPIPE is because I
expected Jan to provide this explanation since he never said he
would not do it.

Regards.

-- 
					    Gilles.

