Message-ID: <4AC2448B.1080500@domain.hid>
Date: Tue, 29 Sep 2009 19:31:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>


Hi guys,

full of energy after this tremendous first XUM, I would like to start a
discussion about what people would like to see in the 2.5 branch.

Here is a first list, please feel free to criticize it:
- signals in primary domain (something that we almost forgot)
- xnsynch_acquire using atomic_cmpxchg unconditionally (no #ifdefs)
- statistics of all mapped named heaps in /proc/xenomai/heap
- unwapped access to user-space posix skin methods
- fast semaphores in user-space
- syscall-less select ?

Actually, there are already a lot of things.
So, what do you think?

-- 
					    Gilles.

