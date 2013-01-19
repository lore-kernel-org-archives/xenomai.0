Message-ID: <50FAAB8A.9020008@xenomai.org>
Date: Sat, 19 Jan 2013 15:19:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>	<50F7AF53.2090800@xs4all.nl>	<50F7BC13.50009@xenomai.org>	<50F7FCD8.7020105@xs4all.nl>	<50FA9FA0.7020400@xenomai.org>	<F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>	<50FAA967.3090306@xenomai.org>
	<D291A2E5-1A46-4501-9781-3ACCC0F20E51@mah.priv.at>
In-Reply-To: <D291A2E5-1A46-4501-9781-3ACCC0F20E51@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Emc-developers] "new RTOS"
 status:	Scheduler	(?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 01/19/2013 03:14 PM, Michael Haberler wrote:

> that was xenomai 2.6.1 as per release tag in the git repo; the rest as outlined here: http://www.xenomai.org/pipermail/xenomai/2013-January/027164.html


Please upgrade to xenomai master. You are having bug which have already
been fixed since 2.6.1.

> [502738.607343] switchtest: page allocation failure: order:4, mode:0xd0


That is an allocation failure. I am afraid you can run
xeno-regression-test only once after the system boot (it is supposed to
run for several hours anyway).


-- 
                                                                Gilles.

