Message-ID: <4F73138D.9000201@domain.hid>
Date: Wed, 28 Mar 2012 15:35:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1331579565.394426122@domain.hid>
	<oqzkb19tdz.fsf@domain.hid>
In-Reply-To: <oqzkb19tdz.fsf@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Mask signals in rt_print:printer_loop()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul Janzen <pcj@domain.hid>
Cc: xenomai@xenomai.org

On 03/28/2012 07:39 AM, Paul Janzen wrote:
> common/rt_print: Use sigfillset to actually mask all signals for
> logging thread.  Fixes commit a6dceeb9.

Thanks, but patch fails to apply on xenomai 2.6 master branch.

-- 
					    Gilles.

