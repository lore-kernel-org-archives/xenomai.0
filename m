Message-ID: <5525E21C.90709@ebus.com>
Date: Wed, 08 Apr 2015 19:21:16 -0700
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
References: <54F01C44.9090000@ebus.com> <54F43A5D.1050704@xenomai.org>
In-Reply-To: <54F43A5D.1050704@xenomai.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] Detecting closure of non-RT end of XDDP from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 03/02/2015 02:24 AM, Philippe Gerum wrote:
> On 02/27/2015 08:27 AM, Doug Brunner wrote:
>> Hi all,
>>
>> I have a need for an RT task that communicates with Linux tasks through
>> XDDP to tell when the Linux process has closed /dev/rtpN. In this case t=
he
>> RT task is acting as a server of sorts from which Linux processes retrie=
ve
>> data, and if an ill-behaved Linux process dies, the RT task needs to cle=
an
>> up its connection state in order to not flood the hapless Linux process
>> that connects next with all the data that built up in the XDDP buffers. I
>> would rather avoid implementing a heartbeat mechanism (RT task watches f=
or
>> periodic "I'm alive" signal from Linux process), because of the many
>> moving parts this would introduce.
>>
>> It looks like the information is there - xnpipe_state::status (please
>> forgive my C++ scoping operator :)) has a bit indicating whether the Lin=
ux
>> side is connected, XNPIPE_USER_CONN. I was thinking of adding a function
>> xnpipe_get_status, which retrieves the status word:
>>
>> int xnpipe_get_status(int minor, unsigned long *out);
>>
>> The XDDP getsockopt() can then return this information to userspace,
>> mirroring how Linux sockets behave (if I understand correctly):
>>
>> int err;
>> getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, sizeof(err));
>> if(err =3D=3D 0) {
>>      /* socket is connected on Linux end */
>> }
>> else if(err =3D=3D EPIPE) {
>>      /* socket is not connected on Linux end*/
>> }
>>
>> One other possibility would be to add a socket option that, when set,
>> causes sendmsg() and recvmsg() to fail with EPIPE if the Linux end of the
>> pipe is not connected.
>>
>> Does either/both of these seem like a good idea?
>>
> Yes, I think so. Fixing send/receive seems the most appropriate option,
> since the current implementation is half-baked with respect to this
> issue. In addition, this could be paired with select() for Xenomai 3.x.
>
> Actually, the code detects when the nrt peer disconnects and it notifies
> the rt peer accordingly, but only when the latter is currently blocked
> on input. But, if the rt peer attempts to read from the channel _after_
> the nrt side has disconnected, the former is simply put to sleep,
> waiting for the next nrt peer to connect and send data, which is broken.
>
> On the send side, the rt peer is currently allowed to log output before
> the _next_ nrt peer connects to the same channel, at which point the
> logged data can be received. This was a deliberate choice, because
> synchronizing both peers so that channel nrt/rt endpoints are opened in
> any required sequence at application startup, would have been a pain in
> the common case.
>
> We could change this to logging output solely before the _first_ nrt
> peer connects to the channel instead, then returning -EPIPE for any send
> request received after the nrt peer has dropped the connection. However,
> although I'm willing to do it that way in Xenomai 3.x, I'm wary of such
> change in Xenomai 2.6.x for backward compatibility reason, although
> there would be no issue to adapt existing code which currently rely on
> this undocumented behavior.
>
> Here is a patch for 2.6.x implementing both changes. I'd be interested
> to know whether it addresses the issue you mentioned:
>
> diff --git a/include/nucleus/pipe.h b/include/nucleus/pipe.h
> index a4fa785..aec2459 100644
> --- a/include/nucleus/pipe.h
> +++ b/include/nucleus/pipe.h
> @@ -54,6 +54,7 @@
>   #define XNPIPE_USER_WREAD_READY  0x20
>   #define XNPIPE_USER_WSYNC        0x40
>   #define XNPIPE_USER_WSYNC_READY  0x80
> +#define XNPIPE_USER_GONE	 0x100
>
>   #define XNPIPE_USER_ALL_WAIT \
>   (XNPIPE_USER_WREAD|XNPIPE_USER_WSYNC)
> diff --git a/ksrc/nucleus/pipe.c b/ksrc/nucleus/pipe.c
> index 3c4dccf..8422a14 100644
> --- a/ksrc/nucleus/pipe.c
> +++ b/ksrc/nucleus/pipe.c
> @@ -438,6 +438,11 @@ ssize_t xnpipe_send(int minor, struct xnpipe_mh
> *mh, size_t size, int flags)
>   		return -EBADF;
>   	}
>
> +	if (testbits(state->status, XNPIPE_USER_GONE)) {
> +		xnlock_put_irqrestore(&nklock, s);
> +		return -EPIPE;
> +	}
> +
>   	inith(xnpipe_m_link(mh));
>   	xnpipe_m_size(mh) =3D size - sizeof(*mh);
>   	xnpipe_m_rdoff(mh) =3D 0;
> @@ -528,6 +533,11 @@ ssize_t xnpipe_recv(int minor, struct xnpipe_mh
> **pmh, xnticks_t timeout)
>   		goto unlock_and_exit;
>   	}
>
> +	if (testbits(state->status, XNPIPE_USER_GONE)) {
> +		ret =3D -EIDRM;
> +		goto unlock_and_exit;
> +	}
> +
>   	curr =3D xnpod_current_thread();
>
>   	while ((h =3D getq(&state->inq)) =3D=3D NULL) {
> @@ -659,7 +669,7 @@ static int xnpipe_open(struct inode *inode, struct
> file *file)
>
>   	__clrbits(state->status,
>   		  XNPIPE_USER_ALL_WAIT | XNPIPE_USER_ALL_READY |
> -		  XNPIPE_USER_SIGIO);
> +		  XNPIPE_USER_SIGIO | XNPIPE_USER_GONE);
>
>   	if (!testbits(state->status, XNPIPE_KERN_CONN)) {
>   		if (testbits(file->f_flags, O_NONBLOCK)) {
> @@ -695,6 +705,7 @@ static int xnpipe_release(struct inode *inode,
> struct file *file)
>
>   	xnpipe_dequeue_all(state, XNPIPE_USER_WREAD);
>   	xnpipe_dequeue_all(state, XNPIPE_USER_WSYNC);
> +	__setbits(state->status, XNPIPE_USER_GONE);
>
>   	if (testbits(state->status, XNPIPE_KERN_CONN)) {
>   		/* Unblock waiters. */
>
>
Hi Philippe,

Sorry it took me so long to try this out. I found that it does work on the =
RT =

sending side (you get EPIPE as expected), but when I call recvfrom() in RT =
after =

the NRT peer has closed the file descriptor, it returns 0 rather than retur=
ning =

-1 and setting errno =3D EIDRM as expected. I looked over the kernel code, =
but =

wasn't able to figure out why this was happening. I've attached an example =
program.

This isn't a huge deal for me to get fixed (the issue is worked around by =

changes I have to make for other reasons), but I wanted to let you know how=
 it =

turned out.

Thanks,
     --Doug Brunner
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xddp_epipe.c
Type: text/x-csrc
Size: 5922 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150408/ec9cd4f=
2/attachment.c>
