Date: Sat, 4 Oct 2014 12:52:36 +0600
From: Alexey Shaposhnikov <canisdirusleidy@yandex.ru>
Message-ID: <20141004125236.655cdb65@warrawoona.sti>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Porting ipipe to vendor specific kernel. Newbie question.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


I trying to port Xenomai 2.6 on Cubieboard (Allwinner A10 based), but encounter
following problems:

1) How to port core patch on newer (than 3.4.6) kernel? Just run genpatches.sh
give errors "unknown architecture for driver" and incomplete patch.
2) Starting (approximately) from version 3.4.29 linux-sunxi kernel have code
backported from 3.5 (mainstream) kernel (arch/arm/include/asm/mmu_context.h for
example), so generated for 3.4 kernel core patch can't be applied. Is there a
(correct) way to backport those parts of ipipe patch without direct patch file
edit and manual copy-paste hunks?

-- 
Alexey Shaposhnikov.

