Message-ID: <50D0CFB9.9050602@xenomai.org>
Date: Tue, 18 Dec 2012 21:19:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPyuKK5Sr9mxXFw+KMhD3g1F+Q5=d8Xm7nQS6hF5OCebw@mail.gmail.com>	<50D08B74.1010809@xenomai.org>	<50D08C0A.10502@xenomai.org>	<CAPpP=rPi6NvBV6OAfLM3Ynym2FWtO_i7iyKx0hT7eYJLUT+8Bg@mail.gmail.com>	<50D099A2.3080407@xenomai.org>
	<CAPpP=rO9JjAeWS7evj9u-bVOZuS79NxVJhtLOUJRpFn1zRCb5w@mail.gmail.com>
In-Reply-To: <CAPpP=rO9JjAeWS7evj9u-bVOZuS79NxVJhtLOUJRpFn1zRCb5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Page fault - POSIX skin] Interraction between malloc
 en nanosleep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: xenomai@xenomai.org

On 12/18/2012 08:27 PM, alex alex wrote:

> In fact, this is what I intend to use when the bug will be solved. I use
> native because RTDM semaphore freezes my PC while with native, semaphore
> is just no longer blocking (so native helped me to find out the bug and
> it keeps me from restart the PC when it bugs... )
> 
> Thanks for the link.


Please try the patch to see if it still causes the bug.

-- 
                                                                Gilles.

