Message-ID: <4ADCAD4C.2000504@domain.hid>
Date: Mon, 19 Oct 2009 20:17:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20091019171611.3332.24615.stgit@domain.hid>
	<20091019171612.3332.48569.stgit@domain.hid>
In-Reply-To: <20091019171612.3332.48569.stgit@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 2/3] nucleus: Include all heaps
	in	statistics
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> @@ -234,12 +239,65 @@ int xnheap_init(xnheap_t *heap,
>  
>  	appendq(&heap->extents, &extent->link);
>  
> +	vsnprintf(heap->name, sizeof(heap->name), name, args);
> +
> +	spin_lock(&heapq_lock);
> +	appendq(&heapq, &heap->stat_link);
> +	spin_unlock(&heapq_lock);

You can not use a Linux spinlock in xnheap_init and xnheap_destroy:
- this breaks the build for the simulator;
- callers of xnheap_init and xnheap_destroy are not guaranteed to run on
the root domain.

-- 
					    Gilles.

