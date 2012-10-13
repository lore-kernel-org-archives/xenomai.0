Message-ID: <50798BD3.6010308@xenomai.org>
Date: Sat, 13 Oct 2012 17:42:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN0CFw3KM6VC-q9QHjoME0AqJOApw_9h4aEP0D2uxeD6rgcGcw@mail.gmail.com>
In-Reply-To: <CAN0CFw3KM6VC-q9QHjoME0AqJOApw_9h4aEP0D2uxeD6rgcGcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Which kernel versions?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Grant <emailgrant@gmail.com>
Cc: xenomai@xenomai.org

On 10/13/2012 05:35 PM, Grant wrote:

> Does xenomai.org indicate which versions of the vanilla kernel can be
> patched with the latest xenomai release?



Basically, any linux version older than the version for which the
patches are provided in xenomai sources, for which an Adeos patch exists in

http://download.gna.org/adeos/patches/

is supposed to work. Except blatant bugs like the one fixed by the
following patch:
http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=28984e66e9e17701354f8883b025fcf83f8b0b68;hp=8417949f5e7d1b4483eb3b6344ec5f3124ecf740

Which prevents anything older from 3.2 to run with xenomai 2.6.1 on x86.

-- 
                                                                Gilles.

