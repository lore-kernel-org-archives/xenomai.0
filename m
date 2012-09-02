Message-ID: <50436D2A.2070607@xenomai.org>
Date: Sun, 02 Sep 2012 16:28:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2211797.6MhXv49D68@valtin-rt>
In-Reply-To: <2211797.6MhXv49D68@valtin-rt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Scicos/Xcos Code Generation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Markus Valtin <valtin@control.tu-berlin.de>
Cc: xenomai@xenomai.org

On 08/22/2012 06:28 PM, Markus Valtin wrote:

> Hello all,
> 
> i have a question regarding automated code generation from Scilab Xcos/Scicos.
> 
> Is this possible? And if yes, how is the necessary setup.
> 
> Background:
> 
> We currently use RTAI for hard realtime but we want to use recent Kernel 
> versions, so Xenomai with his RTAI skin seamed promising.
> 
> However I read that the RTAI emulation was removed from version 2.6.0 because 
> of lack of feedback / lack of LXRT emulation.
> 
> So, is there another way like the native Xenomai Support as suggested on
> http://www.evidence.eu.com/scilabscicos-code-generator-xenomai.html


>From what I understand from this post:
http://www.xenomai.org/pipermail/xenomai-help/2008-09/msg00077.html

This code generator does not use the RTAI skin, but the POSIX skin.

-- 
                                                                Gilles.

