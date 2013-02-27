Message-ID: <512E904A.2080408@xenomai.org>
Date: Thu, 28 Feb 2013 00:01:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512E8C10.8080707@ruggedcom.com>
In-Reply-To: <512E8C10.8080707@ruggedcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Is CLOCK_HOST_REALTIME supported for powerpc?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Makarand Pradhan <makarandpradhan@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/27/2013 11:43 PM, Makarand Pradhan wrote:

> Hi All,
> 
> I'm trying to use clock_gettime to read Linux time in my Xenomai task. I 
> may be doing something wrong, but the call fails. The code is properly 
> linked against the pthread_rt Xenomai library.
> 
> I'm running Linux 3.0.0, Xenomai 2.6.0 on powerpc MPC8360.


Please, upgrade to Xenomai 2.6.2.1.

> 
> Can you pl comment if this is supported? While quickly going through the 
> Xenomai code I had a feeling that it was supported only for x86 and arm.


clocktest -C 42 -D
will answer your question:
http://www.xenomai.org/documentation/xenomai-2.6/html/clocktest/

> 
> Thanks for your time.
> 
> Rgds,
> Makarand.
> 



-- 
                                                                Gilles.

