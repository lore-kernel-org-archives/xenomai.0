Message-ID: <4D77A08D.1030106@domain.hid>
Date: Wed, 09 Mar 2011 16:45:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <540841299685269@domain.hid>
In-Reply-To: <540841299685269@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Runtime error on PXA270 for
 branch	'for-ipipe-2.6.35-arm' in 'ipipe-gch.git'
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Nazarov Sergey <s-nazarov@domain.hid>
Cc: michael.bernhard@domain.hid, xenomai@xenomai.org

Nazarov Sergey wrote:
> Hello! The problem is the same as on my Compulab EM-X270 board, I
> think. dm9000 ethernet controller works unstable with level-type irq
> handler. Sergey.

Hi Sergey,

The I-pipe patches for ARM included in Xenomai 2.5.6, released
yesterday, reversed the irq type to edge, as another user reported the
same failure on another board (colibri).

Regards.

-- 
					    Gilles.

