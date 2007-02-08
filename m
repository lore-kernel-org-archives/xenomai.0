From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17867.28775.863256.865268@domain.hid>
Date: Thu, 8 Feb 2007 19:48:07 +0100
Subject: Re: [Xenomai-core] [PATCH] Enable usage of pthread_set_{mode,
	name}_np from kernel space
In-Reply-To: <1170951733.23555.2.camel@domain.hid>
References: <1170951733.23555.2.camel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Stelian Pop wrote:
 > Hi,
 > 
 > Is there a reason why pthread_set_{mode,name}_np are not allowed to be
 > called from a kernel space POSIX thread ?
 > 
 > If there is none, please apply the patch below.

No, this is completely unintended. Thanks.

-- 


					    Gilles Chanteperdrix.

