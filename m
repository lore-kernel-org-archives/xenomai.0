Message-ID: <543E567C.4070800@xenomai.org>
Date: Wed, 15 Oct 2014 13:11:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
In-Reply-To: <543E5380.3080700@cgglobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] First call to rt_timer_tsc() causes an unexpected
 switch to secondary mode.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alberto.ozalla@cgglobal.com, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/15/2014 12:59 PM, ZIV-Alberto Ozalla Cantabrana wrote:
> 
> Dear colleagues,
> 
> I face an unexpected switch to secondary mode after the very first call to rt_timer_tsc() into a real-time task created by Xenomai.
> This unexpected switch  only arises if it is the very first call to rt_timer_tsc().

Hi,

I see two possible reasons for that:
- either on-demand mapping of library text page
- or first access to the hardware register.

In order to find which is the reason.

Could you replace the call to rt_timer_tsc() with a call to __xn_rdtsc()
after including asm/xenomai/tsc.h ?


-- 
                                                                Gilles.

