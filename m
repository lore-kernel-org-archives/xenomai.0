Message-ID: <52AEB440.5090103@xenomai.org>
Date: Mon, 16 Dec 2013 09:05:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rehashing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>


Hi Philippe,

looking at the registry code, I had an idea: we could increase the
number of descriptors dynamically when they are exhausted, and increase
the hash size as well. This would make the configurable number of slots
a starting point, but not a liimit. The access to the registry by name
does not really need to be fast, so we could protect it with a mutex
(that would mean that all services accessing the registry by name would
need to run in secondary mode, but I am not sure we care, and if we do,
we can use an xnsynch instead).

What do you think?

-- 
                                                                Gilles.

