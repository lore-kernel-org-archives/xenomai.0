Message-ID: <4912EE34.1020109@domain.hid>
Date: Thu, 06 Nov 2008 14:16:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <442698.30595.qm@domain.hid>
In-Reply-To: <442698.30595.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] the exception saga - system hangs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gabriele Moabiti wrote:
>     __asm__ __volatile__("nop; movl %dr7, %eax;nop");

This piece of inline assembly is incorrect, you should mark as output
register the registers you clobber.

-- 
                                                 Gilles.

