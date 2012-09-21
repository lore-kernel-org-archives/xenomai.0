Message-ID: <505C3A52.9050107@bollue.de>
Date: Fri, 21 Sep 2012 11:58:42 +0200
From: Kai Bollue <mlist1@bollue.de>
MIME-Version: 1.0
References: <1347634862.78737.YahooMailNeo@web29605.mail.ird.yahoo.com>
In-Reply-To: <1347634862.78737.YahooMailNeo@web29605.mail.ird.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Context Switch with rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 14.09.2012 17:01, Franz Engel wrote:
> Hi,
>
> I've a little problem. I'm using the rtnet.h-header and the following function:
> ret = recvfrom ( ethernetConnection.sock, &recBuffer, sizeof ( recBuffer ),0, ( struct sockaddr * ) &ethernetConnection.dest_addr,&destlen );

Hi,

stupid question: But you do use an rtnet socket, not a normal one, do 
you? In this case, shouldn't it be rt_dev_recvfrom(...)?


Kai

