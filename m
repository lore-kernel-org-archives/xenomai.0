Message-ID: <535D3E4B.7060506@xenomai.org>
Date: Sun, 27 Apr 2014 19:28:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1BF62296-6E7D-4758-9084-62F575A58151@mah.priv.at>
In-Reply-To: <1BF62296-6E7D-4758-9084-62F575A58151@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] q: userland timestamps  which match rt_timer_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>, xenomai@xenomai.org

On 04/27/2014 05:29 PM, Michael Haberler wrote:
> I need to create ns-resolution timestamps from RT (using
> rt_timer_read() - no surprises) and from normal userland programs
> 
> the latter binaries should be Xenomai-unaware if possible - is there
> a normal Linux API which reads the same timestamp source as
> rt_timer_read()?
> 
> eg: clock_gettime(CLOCK_xxxx)?

No, xenomai clock and linux clock generally are not synchronized. If you
need only timestamps though, you can access linux realtime clock from
xenomai program (wihout a switch to secondary mode) by using xenomai
posix skin clock_gettime(CLOCK_HOST_REALTIME). This clock can not be
used for timers (or timeouts) though.

-- 
                                                                Gilles.

