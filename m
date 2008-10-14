Message-ID: <48F506A6.9040306@domain.hid>
Date: Tue, 14 Oct 2008 22:52:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F505A9.7030507@domain.hid>
In-Reply-To: <48F505A9.7030507@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] Warnings in ksrc/drivers/comedi/buffer.c
Reply-To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> are these warnings due to an unfinished highmem fix (I did not follow
> all details)?
> 
> drivers/xenomai/comedi/buffer.c: In function ‘comedi_free_buffer’:
> drivers/xenomai/comedi/buffer.c:49: warning: passing argument 1 of ‘vmalloc_to_page’ makes pointer from integer without a cast
> drivers/xenomai/comedi/buffer.c: In function ‘comedi_alloc_buffer’:
> drivers/xenomai/comedi/buffer.c:76: warning: passing argument 1 of ‘vmalloc_to_page’ makes pointer from integer without a cast
> drivers/xenomai/comedi/buffer.c:88: warning: passing argument 1 of ‘vmalloc_to_page’ makes pointer from integer without a cast
> drivers/xenomai/comedi/buffer.c:88: warning: assignment makes integer from pointer without a cast
> 
> If not, please fix.

Ok. Will fix. I did not actually compiled my change.

-- 
					    Gilles.

