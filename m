From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Subject: Re: [PATCH v2 4/8] net/tcp: Copy data back to user buffer in
 rt_tcp_recvmsg
Date: Thu, 08 Nov 2018 09:09:04 +0100
Message-ID: <2186966.bbFq7nfX5c@lenni>
In-Reply-To: <87bbe98f-1799-8dbc-0a7f-763380cace8c@siemens.com>
References: <1541498426-2916-1-git-send-email-sebastian.smolorz@gmx.de>
 <1541498426-2916-5-git-send-email-sebastian.smolorz@gmx.de>
 <87bbe98f-1799-8dbc-0a7f-763380cace8c@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 06.11.18, 19:52, Jan Kiszka wrote:
> On 06.11.18 11:00, Sebastian Smolorz via Xenomai wrote:
> > A bug in rt_tcp_recvmsg() prevented an application to receive data
> > over an RTTCP socket. Data was not copied back to the application's
> > buffer but rather into a temporary kernel buffer.
> > 
> > Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
> > ---
> > 
> >  kernel/drivers/net/stack/ipv4/tcp/tcp.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > b/kernel/drivers/net/stack/ipv4/tcp/tcp.c index 2678e6a..3242a08
> > 100644
> > --- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > +++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > @@ -2084,17 +2084,10 @@ static ssize_t rt_tcp_recvmsg(struct rtdm_fd
> > *fd, struct user_msghdr *msg, int m> 
> >  	len = iov[0].iov_len;
> >  	if (len > 0) {
> > 
> > -		buf = xnmalloc(len);
> > -		if (buf == NULL) {
> > -			ret = -ENOMEM;
> > -			goto out;
> > -		}
> > -		ret = rtdm_copy_from_user(fd, buf, iov[0].iov_base, len);
> > -		if (!ret)
> > -			ret = rt_tcp_read(fd, buf, len);
> > -		xnfree(buf);
> > +		buf = iov[0].iov_base;
> > +		ret = rt_tcp_read(fd, buf, len);
> 
> Does this go well with smap? IOW: Was everything testing on a system
> with smap support available and enabled?

smap was enabled. Tests were executed on an Atom E3845. cat /proc/
cpuinfo showed no smap flag.

> >  	}
> > 
> > -out:
> > +
> > 
> >  	rtdm_drop_iovec(iov, iov_fast);
> >  	
> >  	return ret;

-- 
Sebastian




