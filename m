Message-ID: <507E94ED.9060401@xenomai.org>
Date: Wed, 17 Oct 2012 13:22:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507E946A.5020105@siemens.com>
In-Reply-To: <507E946A.5020105@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] can: Let Flexcan driver depend on platform
 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Wolfgang Grandegger <wg@denx.de>, Xenomai <xenomai@xenomai.org>

On 10/17/2012 01:20 PM, Jan Kiszka wrote:

> Just like the Linux version does, let our RT Flexcan driver depend on
> CONFIG_HAVE_CAN_FLEXCAN so that it can only be selected on platforms
> that actually support it.


Do all old kernels for CPUs which have a flexcan controller have this
symbol defined?

-- 
                                                                Gilles.

