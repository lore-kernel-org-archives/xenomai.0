Message-ID: <53FF33CE.10303@xenomai.org>
Date: Thu, 28 Aug 2014 15:51:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACreCV+9seA7yp8gmjvOb6CQ7-Fbt-HyQ6YAoB_dqtmqmyvy7Q@mail.gmail.com>	<53FDFD27.2010207@xenomai.org>
 <CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>
In-Reply-To: <CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ODROID-U3 porting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: xenomai@xenomai.org

On 08/28/2014 03:45 PM, GP Orcullo wrote:
> On Wed, Aug 27, 2014 at 11:45 PM, Gilles Chanteperdrix
>> So, this is a cortex a9. On Cortex a9, Xenomai tries to use the global
>> timer for tsc emulation. Are you sure this processor has a global timer?
>> Again, running the "tsc" program will help you see if the tsc emulation
>> is working correctly.
> 
> AFAIK, the exynos soc doesn't use twd - they have a multi-core timer
> instead. There is one global timer and a local timer for each core.
> 
> BTW, is it necessary that there should be an ipipe timer for each core
> or a single
> "global" one will do?

The global timer is not the same thing as the twd, and I was talking
about using the global timer as a clock source (for tsc emulation), not
as a timer, the advantage being that you would have a much better
resolution. Xenomai indeed requires local timer support (for which it
uses twd on cortex a9), that is one timer per core.

-- 
                                                                Gilles.

