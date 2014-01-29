Message-ID: <52E8CD0F.6040808@xenomai.org>
Date: Wed, 29 Jan 2014 10:42:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1390939945.5452.YahooMailNeo@web171602.mail.ir2.yahoo.com>
In-Reply-To: <1390939945.5452.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] atomic_sub_fetch in atomic.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/28/2014 09:12 PM, Matthias Schneider wrote:
> Hi all,
>
> shouldn't
>
> #define atomic_sub_fetch(v, n)  _sync_sub_and_fetch(&(v), n)
>
> in file include/nocore/atomic.h line 48 of xenomai-forge be rather
>
> #define atomic_sub_fetch(v, n)  __sync_sub_and_fetch(&(v), n)
>
> ?
> It is not used by the current code anyway, but does not compile when trying to
> do so..
>

Typo indeed. Thanks for the heads up.

-- 
Philippe.

