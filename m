Message-ID: <0012b71cd44fa48b579be970738eb844.squirrel@www.xenomai.org>
In-Reply-To: <49E736B33FAAA645BCAB9FFEC26712E6FD16CB@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
	<fb3e91c788e98c96e2c5061a83b96def.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD16CB@EXDAG0-B0.intra.cea.fr>
Date: Wed, 19 Jun 2013 16:32:28 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


HAUTBOIS Flavian wrote:
> Hi Gilles,
>
> I'm using a middleware that arms T_WARNSW by default, I cannot change
> that. Plus, I would like to use only RTNet to send this packet, as I need
> real-time performances.
> I may be mistaken, but I thought the message stating the reason was one of
> the first lines of the files I joined.

Could you simply paste that line in a mail? So we definitely know what
causes this signal?


>
> The socket being used by the program is 896 (which equals 1024-128), so
> the issue should be somewhere else if I understood you correctly?

I am talking about the socket used by the particular call to __wrap_send
which gets the signal, not about any other socket. What would be interesting
next is the return value of the RTDM system call in __wrap_send.

>
> RTNet should be correctly configured and started but I'm not 100%
> positive. Here are the outputs of rtconfig and lsmod. (I have two Ethernet
> cards in my computer, one uses the e1000e module and the other one the
> e100 module. The latter one is the one I use with rtnet)
>
> You mentioned other reasons for failure that I can't really investigate
> without further precisions, such as wrong kernel-space options, any more
> details?

Have you tried enabling debugs to see if you get a message in the kernel
logs? Otherwise, you may add printfs or printks around to see the exact
reason for receiving this signal.

-- 
                    Gilles.


