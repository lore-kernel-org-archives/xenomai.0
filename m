References: <9305b0f8a1e72466ac65.1481034395@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e782324c-47f1-a8b4-acf9-c326bf62d2a6@xenomai.org>
Date: Fri, 9 Dec 2016 12:03:06 +0100
MIME-Version: 1.0
In-Reply-To: <9305b0f8a1e72466ac65.1481034395@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] copperplate: Limit memory usage tlsf-heap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 12/06/2016 03:26 PM, Ronny Meeus wrote:
> Before this patch the system memory pool's (tlsf variant) behavior was
> to grow in case allocations were done when depleted. This is a
> contradiction with the expected behavior (see mem-pool-size tunable
> documentation). When the pool is depleted, an error should be retuned
> instead of growing the pool.
> 
> This patch solves this bug.
> To be backwards compatible an option has been introduced that allows the
> configuration of the pool's growing capability. The default is

Since growing the pool was a bug causing an inconsistency with all other
allocators (such as the one used when enabling process shared heaps), we
need no backward compatibility, only the fix.

-- 
Philippe.

