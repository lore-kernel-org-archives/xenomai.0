From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17459.56454.15820.950170@domain.hid>
Date: Wed, 5 Apr 2006 17:04:38 +0200
Subject: Re: [Xenomai-help] problems building xenomai 2.1 for ppc
In-Reply-To: <02AA386EB831044F8537A696BA785C78A664EF@ILEX5.IL.NDS.COM>
References: <02AA386EB831044F8537A696BA785C78A664EF@ILEX5.IL.NDS.COM>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

Landau, Bracha wrote:
 > I'm trying to build xenomai 2.1 for an 8272 architecture using kernel 2.6.14.
 > I've successfully put in the adeos patch.
 > Here are the problems I've encountered.
 > 
 > 1) When doing ./scripts/prepare-kernel.sh I get an error that it can't find the file /include/asm-powerpc/ipipe.h.
 > I copied the file ipipe.h from /include/asm-ppc and reran prepare-kernel.sh with no errors.

For a quick step by step install guide of Xenomai with Denx ELDK, see also:

https://mail.gna.org/public/xenomai-help/2006-04/msg00059.html

-- 


					    Gilles Chanteperdrix.

