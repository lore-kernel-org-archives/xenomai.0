Subject: =?utf-8?q?Segmentation_error_6_in_rt=5Fheap=5Fcreate=28=29_without_=2D=2Denable=2Dpshared?=
Date: Mon, 05 Nov 2018 12:06:36 +0100
From: =?utf-8?q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20181105120636.B8E60FC0@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello.
I'm continuing to test newest Xenomai (git clone).
If I configure Xenomai without --enable-pshared, I will always get an segmentation error 6 in rt_heap_create() call. It doesn't matter, if I use NULL as heap name or not.
With --enable-pshared everything works fine.
Petr

