Message-ID: <5357C407.8060206@xenomai.org>
Date: Wed, 23 Apr 2014 15:45:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1398115447.70510.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53561B23.6010104@xenomai.org>
 <1398163799.26874.YahooMailNeo@web171604.mail.ir2.yahoo.com>
 <53566854.2040502@xenomai.org>
 <1398189653.17723.YahooMailNeo@web171602.mail.ir2.yahoo.com>
In-Reply-To: <1398189653.17723.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] occasional EBADF in select() in notifier.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/22/2014 08:00 PM, Matthias Schneider wrote:

>
> Considering the three options I think I prefer the last one and remove the
> select() altogether. I have attached a small patch that does exactly that.
>

Merged, thanks.


-- 
Philippe.

