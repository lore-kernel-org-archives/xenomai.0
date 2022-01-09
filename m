References: <20220109181359.811425-1-rpm@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] mm: dovetail: rename page_needs_cow_for_dma() to
 page_needs_cow()
Date: Sun, 09 Jan 2022 19:15:32 +0100
In-reply-to: <20220109181359.811425-1-rpm@xenomai.org>
Message-ID: <87iluspyeb.fsf@xenomai.org>
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
> With the addition of the Dovetail COW-breaking logic,
> page_needs_cow_for_dma() does not exclusively apply to pinned memory
> for DMA anymore. Give it a more generic name.
>

Should that be merged to the v4 fix?

-- 
Philippe.

