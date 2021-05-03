From: Philippe Gerum <rpm@xenomai.org>
Subject: [RFC] status of [meta-]xenomai for Yocto
Date: Mon, 03 May 2021 18:58:49 +0200
Message-ID: <878s4vu52u.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


I'd like to discuss the current status of what exists, what might be
planned regarding a meta layer which would/does provide support for
Xenomai-enabled kernels. This could be a topic raised during the next
community meeting.

I can see a couple of options floating around on the net, all dedicated
to specific hardware it seems, some/all extending their support up to
the rootfs image.

Would it be possible to conceive such support as a meta-bsp layer
instead, implementing a new kernel type, one that could be included in
bbconf settings without imposing anything about the image to be
produced?  Something which could be extended to cover Xenomai 4/EVL at
some point as well.

It would be nice to discuss ideas around the general topic of having a
reference meta layer for Xenomai in the most flexible way. Whether it
already exists, or not.

-- 
Philippe.

