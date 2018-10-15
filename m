MIME-Version: 1.0
Message-ID: <trinity-70018182-a93d-4059-a47a-ac135950334a-1539593219791@msvc-mesg-gmx121>
From: "Sebastian Smolorz" <Sebastian.Smolorz@gmx.de>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Oct 2018 10:46:59 +0200
In-Reply-To: <cd81c172-a1d8-6564-e37c-6ea0b7e4dc24@xenomai.org>
References: <2060132.jtzqTOXOF1@lenni>
 <cd81c172-a1d8-6564-e37c-6ea0b7e4dc24@xenomai.org>
Subject: Re: [Xenomai] Retrieval of user fd from struct rtdm_fd
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Philippe Gerum wrote:

> On 10/14/2018 09:27 PM, Sebastian Smolorz wrote:
> > Hello Philippe or Jan,
> > 
> > I need to retrieve the socket file descriptor from an RTDM device driver 
> > routine.
> 
> Could you elaborate on the reason to need this?

The rttcp driver was programmed to only accept one connection
and not create a new socket for it but instead use the existing
one. So rt_tcp_accept() returns its socket's fd number.

-- 
Sebastian

