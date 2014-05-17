Message-ID: <53775E2B.2060708@xenomai.org>
Date: Sat, 17 May 2014 15:03:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1400327913.49772.YahooMailNeo@web171604.mail.ir2.yahoo.com>
In-Reply-To: <1400327913.49772.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] cobalt kernel compile issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/17/2014 01:58 PM, Matthias Schneider wrote:
> This commit
>
> 8ac3db811d2150434a35fefca5bd3b467139f6e8 cobalt/rtdm: extract fd API
>
> seems to be the cause for the following kernel/cobalt compile issue:
>
> include/trace/events/cobalt-rtdm.h: In function 'ftrace_raw_event_fd_event':
> include/trace/events/cobalt-rtdm.h:27:15: error: incompatible types
> when assigning to type 'int' from type 'struct rtdm_fd'
>     __entry->fd = context->fd;
>
> [...]
>
> It appears that file rtdm file descriptors are struct rtdm_fd now
> instead of ints, leaving the trace implementation in need of
> adaptation.
>

Indeed, and we also have RTCAN and Analogy fixups to do after this 
change it seems. I'll handle this.

-- 
Philippe.

