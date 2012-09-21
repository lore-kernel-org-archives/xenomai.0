Message-ID: <505C3B2D.3080701@xenomai.org>
Date: Fri, 21 Sep 2012 12:02:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1347634862.78737.YahooMailNeo@web29605.mail.ird.yahoo.com>
	<505C3A52.9050107@bollue.de>
In-Reply-To: <505C3A52.9050107@bollue.de>
Content-Type: text/plain; charset=UTF-8
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
To: Kai Bollue <mlist1@bollue.de>
Cc: xenomai@xenomai.org

On 09/21/2012 11:58 AM, Kai Bollue wrote:
> On 14.09.2012 17:01, Franz Engel wrote:
>> Hi,
>>
>> I've a little problem. I'm using the rtnet.h-header and the following function:
>> ret = recvfrom ( ethernetConnection.sock, &recBuffer, sizeof ( recBuffer ),0, ( struct sockaddr * ) &ethernetConnection.dest_addr,&destlen );
> 
> Hi,
> 
> stupid question: But you do use an rtnet socket, not a normal one, do 
> you? In this case, shouldn't it be rt_dev_recvfrom(...)?

When using the posix skin, recvfrom is substituted at compilation (or
more exactly link-edit) time with __wrap_recvfrom, implemented in
libpthread_rt.so, allowing to work with real-time sockets.

(But that works only if you used socket too instead of rt_dev_socket).

-- 
					    Gilles.

