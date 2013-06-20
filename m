Message-ID: <41d414a76f40aa6f246bc60d89a11394.squirrel@www.xenomai.org>
In-Reply-To: <49E736B33FAAA645BCAB9FFEC26712E6FD1732@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
	<fb3e91c788e98c96e2c5061a83b96def.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD16CB@EXDAG0-B0.intra.cea.fr>
	<0012b71cd44fa48b579be970738eb844.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1732@EXDAG0-B0.intra.cea.fr>
Date: Thu, 20 Jun 2013 15:21:39 +0200
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
> "SIGDEBUG received, reason 4: affected by priority inversion". My bad, it
> wasn't in the text file.

It means that __wrap_send switches to secondary mode (probably by
calling __real_send), while your application holds a mutex.

>
> I am also talking about the socket passed to the send function that calls
> the incriminated __wrap_send, it's 896.
> However I'm not sure what you mean about the return value of the RTDM
> system call. Do you mean "rval = send(socket, ...); printf("%d", rval)"? I

No, I mean in __wrap_send implementation put a printf after the RTDM
system call and before the call to __real_send to know the reason for
calling __real_send. Alternatively, you can put some printk around in
kernel code to know why send fails.

Regards.

-- 
                    Gilles.


