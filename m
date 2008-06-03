MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18501.49795.524807.575629@domain.hid>
Date: Wed, 4 Jun 2008 00:15:31 +0200
In-Reply-To: <d6c8ef150806031032k32cbc284m3533392c0871755f@domain.hid>
References: <d6c8ef150806031032k32cbc284m3533392c0871755f@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Binding to rt_heap from kernel space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Bosko Radivojevic wrote:
 > After quick look on API documentation (for 2.4.x) it seems it is not
 > possible to bind on a heap created in user space. Is that true or I'm
 > missing something?

No, but you can call rt_heap_create in kernel-space and rt_heap_bind in
user-space.

-- 


					    Gilles.

