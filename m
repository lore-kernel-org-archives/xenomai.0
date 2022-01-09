References: <20220109102820.638985-1-rpm@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v3] dovetail: mm: fix logic of COW-disabling check
Date: Sun, 09 Jan 2022 16:22:03 +0100
In-reply-to: <20220109102820.638985-1-rpm@xenomai.org>
Message-ID: <87mtk5q655.fsf@xenomai.org>
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


Philippe  Gerum <rpm@xenomai.org> writes:

> From: Philippe Gerum <rpm@xenomai.org>
>
> COW-disabling for a dovetailed task does not depend on the pinning
> status of the source VMA considered by copy_present_page(). Decouple
> both checks, which fixes the following kernel splat on fork() from a
> dovetailed task:
>

Although this patch does prevent the crash, this still does not work the
way it should. Basically, we should not allow the DMA pinning check to
prevent COW from being disabled for a VMA attached to a dovetailed
task. This needs more thought. I'll follow up on this.

-- 
Philippe.

