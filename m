Message-ID: <5587EAF1.8000305@xenomai.org>
Date: Mon, 22 Jun 2015 13:01:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t2XmS1FSxmoJJ7DSCfgsPw5vOrf60BxK15w2XE9zgTe6g@mail.gmail.com>
In-Reply-To: <CAKk99t2XmS1FSxmoJJ7DSCfgsPw5vOrf60BxK15w2XE9zgTe6g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to make user space app wait to read from driver
 with rtdm_select? (Xenomai 3.x)f
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/22/2015 10:43 AM, Helder Daniel wrote:
> Hi,
> 
> I am writing a Xenomai 3.x RTDM driver.
> This driver gets data from a device and stores it a buffer. This takes a
> while.
> After buffer is filled a user space application issues a read call to the
> driver fd get data.
> 
> The problem is how to make user space app wait for the buffer to be filled.
> 
> One could think on using the poll interface (http://linux.die.net/man/2/poll
> ),
> but as I understood from Xenomai 3.0-rc5 API reference there is no real
> time implementation of poll or epoll.
> 
> However I found there a real time implementation of select:
> RTDM_select_handler.
> I am assuming that (can I?) in user space an app use select the same way as
> with POSIX (http://linux.die.net/man/2/select)
> 
> Unfortunately I did not find any example of programming the rtdm_select
> driver handler.
> In (https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/) shows how to
> declare the handler in a (struct rtdm_driver) but not how to program the
> handler function.
> 
> Is there any example of implementing rtdm_select handler? For instance in
> the Xenomai 3.x-rc4 source code? I tried to find it in the drivers section
> but I didn't (I might be looking in the wrong place).
> 
> Or there is another (better?) way to make an user space app (real time)
> wait for the driver before reading from it?
> 

See kernel/drivers/ipc, looking for xnselect_bind() [wait registration],
and xnselect_signal() [state change notifications]. A particular
direction (e.g. wait for read / wait for write) is associated with a
dedicated selector, declared with DECLARE_XNSELECT().

The logic of the rtdm_fd_ops.select() handler is:

- determine the current poll state (which events are currently
satisfied). The value encoding the event state (e.g. readable or
writable) is arbitrary, non-zero means set, zero means absent.
- allocate a binding block via xnmalloc() [required]
- call xnselect_bind(), mentioning the proper selector and binding, the
current poll state and the details about the user request.
- drop the binding block if the binding failed, or return. RTDM will do
the rest.

RTDM events and sema4s readily provide cooked routines doing just that,
which you can invoke from your handler if your code synchronizes on
those objects (rtdm_event_select(), rtdm_sem_select()).

-- 
Philippe.

