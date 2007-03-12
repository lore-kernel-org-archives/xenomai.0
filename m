Message-ID: <45F5562F.4030000@domain.hid>
Date: Mon, 12 Mar 2007 14:31:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai on MIPS intial boot
References: <403615.11286.qm@domain.hid>
In-Reply-To: <403615.11286.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: somshekar kadam <som_kadam@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

somshekar kadam wrote:
> ./configure --target=mips --host=i386 --enable-shared
> CC=mips_fp_be-gcc 

What you probably want is ./configure --host=mips


-- 
                                                 Gilles Chanteperdrix

