Message-ID: <4FEC13B1.3040609@xenomai.org>
Date: Thu, 28 Jun 2012 10:20:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmuw2sM5PD0G1YvObij1dZvdm743hEMMP=6Ljg+k2ZSOQQ@mail.gmail.com>
In-Reply-To: <CANKLDmuw2sM5PD0G1YvObij1dZvdm743hEMMP=6Ljg+k2ZSOQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How setup receive-timeout for rt_dev_recvfrom?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: xenomai@xenomai.org

On 06/28/2012 10:05 AM, Henri Roosen wrote:
> Hi Xenomai-list,
> 
> I am using the native API and RTDM to read from a RTNet realtime interface.
> This all works, however, I need a timeout on the rt_dev_recvfrom.
> 
> As there is no rt_dev_select function, I tried to setup a receive
> timeout, similar to how the XDDP examples do:

The posix skin has select, which can be used by native skin threads. You
have to use the result of socket, and not rt_dev_socket as the fd to put
in the fd_set, but apart from that, it should work.

-- 
					    Gilles.

