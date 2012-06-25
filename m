MIME-Version: 1.0
Date: Mon, 25 Jun 2012 18:51:53 +0430
Message-ID: <CAKKWdtczsEk=XA+7J5z-8N1AKMh223dr3tTkh2-prK1QPLb7SQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] memory size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

My computer has 3G bytes RAM. I have disabled "high memory", PAE and
64-bit memory and I/O resources for the Xenomai kernel and the memory
size is nearly 900M (Why the memory size became smaller than 1G? By
disabling those options the size should be still 3G!) :

/root> cat /proc/meminfo
MemTotal:         894660 kB
MemFree:           56472 kB
Buffers:          110264 kB
Cached:           329584 kB
SwapCached:        47844 kB
Active:           327936 kB
Inactive:         417484 kB
Active(anon):     142080 kB
Inactive(anon):   166236 kB
Active(file):     185856 kB
Inactive(file):   251248 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       5144572 kB
SwapFree:        5014556 kB

I did it according to an Intel white paper for Xenomai. Why is it
necessary? The total memory is below 1G bytes now. Does it make the
scheduling latency higher in general? (Because I think bigger size of
the memory makes the latencies smaller. Is that right?)


Regards

