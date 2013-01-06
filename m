Message-ID: <50EA0496.7070700@xenomai.org>
Date: Mon, 07 Jan 2013 00:11:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50E471AC.2000701@siemens.com> <50E5A0E4.4000108@xenomai.org>
	<50E5A75B.6090507@siemens.com> <50E5B174.2040106@xenomai.org>
	<50E5BF03.5020004@siemens.com> <50E5C134.3010804@xenomai.org>
	<50E5C69E.7090707@siemens.com> <50E6A871.9010008@xenomai.org>
	<50E6ABF7.1050503@siemens.com> <50E6AFC3.5080400@xenomai.org>
	<50E6BB87.4020100@siemens.com> <50E6BE15.2060805@xenomai.org>
	<50E6C112.6070106@siemens.com> <50E6D11E.9090808@xenomai.org>
	<50E9A18D.5040509@xenomai.org> <50EA028A.1070903@web.de>
In-Reply-To: <50EA028A.1070903@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] XNARCH_TIMER_IRQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 01/07/2013 12:02 AM, Jan Kiszka wrote:

> Splitting /proc is not a good idea from the usability POV. The whole
> point of showing the load of IRQs in /stat is to have all information in
> one place (percentages sum up to 100...).
> 
> I've pushed a simple patch via for-upstream in my repo that should be
> sufficient for 2.6. We could refine on top later on.


That is fine, except that you pushed the change of the intrlock to a
mutex as well...

-- 
                                                                Gilles.

