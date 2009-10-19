Message-ID: <4ADC3164.8070207@domain.hid>
Date: Mon, 19 Oct 2009 11:29:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20091019092051.2502.31525.stgit@domain.hid>
	<20091019092052.2502.1090.stgit@domain.hid>
In-Reply-To: <20091019092052.2502.1090.stgit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 1/2] nucleus: Add semaphore heap
	statistics
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
> This extends /proc/xenomai/heap with statistics about the global as well
> as all per-process semaphore heaps. This is helpful to track down the
> reason for ENOMEM (system or sem heap full?) and to find out that we
> are leaking memory from the global heap on automatic native mutex,
> queue, and heap deletion.

I'd rather see the xnholder_t in the xnheap structure. This way, we
would be able to add all heaps to /proc/xenomai/heaps.

-- 
                                          Gilles


