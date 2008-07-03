Message-ID: <486D37CD.7020504@domain.hid>
Date: Thu, 03 Jul 2008 22:34:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <486CE4C5.8050309@domain.hid> <486CEF87.6060504@domain.hid>
	<486CF1C5.9020704@domain.hid> <486CF261.5010804@domain.hid>
	<486CF405.4070206@domain.hid> <486D377A.2050709@domain.hid>
In-Reply-To: <486D377A.2050709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How can I make Xenomai share a mii bus with the
 kernel?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Galea <michaelgalea@domain.hid>
Cc: xenomai@xenomai.org

Michael Galea wrote:
> /* Wait till MII management write is complete */
> while ((in_be32(&regs->miimind)) & MIIMIND_BUSY) cpu_relax();

This is no good. Putting this under spinlock may mean large masking
sections.

-- 


					    Gilles.

