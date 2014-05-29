Message-ID: <53878C85.80506@xenomai.org>
Date: Thu, 29 May 2014 21:37:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1401378135.12445.YahooMailNeo@web171606.mail.ir2.yahoo.com>
In-Reply-To: <1401378135.12445.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_mutex_init on forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/29/2014 05:42 PM, Matthias Schneider wrote:
> Hi all,
>
> I have a question about rtdm_mutex_init in forge. BUG_ON is
> triggered each time I create an rtdm_mutex. This seems to be
> due to a check in xnsynch_init, while apparently some
> implementation is still missing in rtdm_mutex_init():
>

Could you please give a try to this patch? It implements fast locking 
for RTDM mutexes, which should fix the issue:

http://git.xenomai.org/xenomai-forge.git/commit/?h=next&id=c00754093d283247695356d416608daab0979786

TIA,

-- 
Philippe.

