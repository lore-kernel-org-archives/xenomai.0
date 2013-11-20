Message-ID: <528CCE14.2040505@xenomai.org>
Date: Wed, 20 Nov 2013 15:58:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A4FA4D76-58FD-4DB4-AE7F-5B2D3D20FF35@mah.priv.at>
In-Reply-To: <A4FA4D76-58FD-4DB4-AE7F-5B2D3D20FF35@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] integrate event signaled by RT thread into non-RT
 event loops (poll, select, eventfd..)?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/20/2013 03:33 PM, Michael Haberler wrote:
> I'm looking for a simple method to post an event from an RT thread so
> a userland non-RT thread can wait for, and pick it up via a file
> descriptor (without switching the originating thread to primary
> domain, of course)
> 
> event context can be minimal since the userland handler can figure;
> actual data transfer not required - event number or mask a plus
> 
> purpose would be integration into existing event loops; only
> RT->userland signalling needed
> 
> if it's possible from a kernel RT context, it's a plus
> 
> ---
> 
> one scheme I thought of was: using rt_event services, monitor the
> event flag in a userland shadow thread and post to an eventfd whose
> other side could be integrated into an event loop. Making sense?
> 
> thanks in advance,
> 
> Michael
> 
> ps: this needs to be portable across RT kernel variants; my approach
> for RTAI would be to use rt_request_srq() and post to an eventfd from
> the Linux context

You may use XDDP IPC for that, see:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/xddp-echo_8c-example.html

-- 
					    Gilles.

