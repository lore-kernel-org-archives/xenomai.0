Message-ID: <51DBF250.9070804@xenomai.org>
Date: Tue, 09 Jul 2013 13:21:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] No boot kernel with xenomai on i.MX6Q Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/09/2013 12:40 PM, Younes CHALABI wrote:

> Hi to all,
>
> I am currently trying to deploy Xenomai-2.6.2.1 patched to Linux-3.0.35 (Freescale Release) on the i.MX6Q Sabrelite board.
>
> I followed this procedure for the installation : http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#arm
>
> When I boot the target with an microSD card, the kernel starts to uncompressing but at one moment stops at this line : Switching to clocksource ipipe_tsc ; and nothing happens after.
>
> Any suggestion will be welcome.


Could you try with the latest version from xenomai git instead of 2.6.2.1?

-- 
                                                                 Gilles.

