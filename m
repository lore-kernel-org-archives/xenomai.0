Message-ID: <50CB561D.5070706@grandegger.com>
Date: Fri, 14 Dec 2012 17:38:53 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <50CB364C.70706@wanadoo.fr>
In-Reply-To: <50CB364C.70706@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Init issue with rtcan_flexcan
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 12/14/2012 03:23 PM, Thierry Bultel wrote:
> Hi,
> some days ago I have posted a patch for the rtcan_flexcan to be
> correctly probed on the iMX6q
> 
> It is functional, but I have not tested it enough, I am sorry about that.
> It only works if the linux flexcan driver module has been used once before.
> 
> Else I have got IRQs but no packet go to the upper layer, I think it is
> stuck in passive state, I am investigating on it.

It would be nice if you could port the missing patches from the mainline
Linux kernel to rtcan_flexcan.

Thanks,

Wolfgang.


