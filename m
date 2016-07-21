MIME-Version: 1.0
From: Alexey Gerasev <alexey.gerasev@gmail.com>
Date: Thu, 21 Jul 2016 09:37:28 +0000
Message-ID: <CAG7USP29CKpLQkRcnPzXFsVYjuMozaGv3AjUEa228XpeOsyr-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai]  'select' for RTCAN sockets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gilles@click-hack.org
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thank you for your reply!
I've tried to answer your questions and modify the patch.

Sorry for the formatting of the massage - I've copied it from archive and
formated manually because I've not received it in my mail.

On Mon, Jul 18, 2016 at 11:39:47, Gilles Chanteperdrix wrote:
> On Mon, Jul 18, 2016 at 09:28:50AM +0000, Alexey Gerasev wrote:
> > Hello, everybody!
> >
> > I am trying to port existing program from Linux to Xenomai. This program
> > works with CAN devices via CAN raw sockets in single thread, and
'select'
> > syscall is used for read/write multiplexing.
> > I use Xenomai-3 branch 'stable-3.0.x'. When I try to use 'select'
syscall
> > on RTCAN sockets, it returns -1 and 'errno' is set to 19 - "No such
> > device". I've found that there is no handler for 'select' event in RTCAN
> > driver in 'xenomai-3/kernel/drivers/can/rtcan_raw.c' in 'rtcan_driver'
at
> > line 978.
> > Does some fundamental reason for absence of 'rtcan_driver.select'
handler
> > for RTCAN sockets exist? Or it wasn't implemented just because 'select'
> > syscall is rarely used?
> >
> > I have also tried to implement 'rtcan_driver.select' handler by myself.
The
> > patch is attached to this message.
> > For XNSELECT_READ I use 'rtdm_sem_select' on socket semaphore like it is
> > used in RTNet TCP driver in
> > 'xenomai-3/kernel/drivers/net/stack/ipv4/tcp/tcp.c' at line 2083. For
> > XNSELECT_WRITE I also use 'rtdm_sem_select' on device TX semaphore like
in
> > 'rtcan_raw_sendmsg' function.
> > I have tested this implementation and it seems to be working.
> > Please review it.
> >
> > Best regards,
> > Alexey
> > -------------- next part --------------
> > A non-text attachment was scrubbed...
> > Name: rtcan-select.patch
>
> Ok, please, next time, could you put the patch inline in your
> e-mail? Anyway, I just have a comment:
>
> diff --git a/kernel/drivers/can/rtcan_raw.c
b/kernel/drivers/can/rtcan_raw.c
> index 693b927..8ecb5e7 100644
> --- a/kernel/drivers/can/rtcan_raw.c
> +++ b/kernel/drivers/can/rtcan_raw.c
> @@ -964,6 +964,38 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
>      return ret;
>  }
>
> +/***
> + *  rtcan_raw_select
> + */
> +static int rtcan_raw_select(struct rtdm_fd *fd,
> +                rtdm_selector_t *selector,
> +                enum rtdm_selecttype type,
> +                unsigned fd_index)
> +{
> +    struct rtcan_socket *sock = rtdm_fd_to_private(fd);
> +
> +    switch (type) {
> +    case XNSELECT_READ:
> +        return rtdm_sem_select(&sock->recv_sem, selector, XNSELECT_READ,
fd_index);
> +    case XNSELECT_WRITE:
> +    {
> +        struct rtcan_device *dev;
> +        int ifindex = 0;
> +
> +        if (!(ifindex = atomic_read(&sock->ifindex)))
> +        return -ENXIO;
>
> Why do we need that? I mean, either the fd reference count is
> sufficient for the interface to be linked unequivocally with the file
> descriptor, and this dance is useless, or not, and the fact that you
> use atomic_read will not make the race go away: ifindex may well
> change between the time you read it, albeit atomically, and the time
> you use it.

Sorry, I hardly understand. Does 'dance' mean atomic_read? If so, it's put
here not to eliminate the race, but just to read int value from atomic_t.

I've got this way to access the device by socket from rtcan_raw.c
in rtcan_raw_sendmsg. At line 802 I saw such comment:

/* We only want a consistent value here, a spin lock would be
* overkill. Nevertheless, the binding could change till we have
* the chance to send. Blame the user, though. */
ifindex = atomic_read(&sock->ifindex);

As I understand in rtcan_raw_sendmsg there's no protection from
socket rebinding, just 'blame the user'. So, in rtcan_raw_select
such protection is unnecessary too, I think.


> +
> +        if ((dev = rtcan_dev_get_by_index(ifindex)) == NULL)
> +        return -ENXIO;
>
> I believe you have taken a reference on the device here, you need
> to return it after the call to rtdm_sem_select.

Does this mean I need to decrement dev->refcount if it exists?
It can be done using rtcan_dev_dereference(dev).


> --
>                         Gilles.

Here is the modified patch:

diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index 693b927..20df5f3 100644
--- a/kernel/drivers/can/rtcan_raw.c
+++ b/kernel/drivers/can/rtcan_raw.c
@@ -964,6 +964,43 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
     return ret;
 }

+/***
+ *  rtcan_raw_select
+ */
+static int rtcan_raw_select(struct rtdm_fd *fd,
+                rtdm_selector_t *selector,
+                enum rtdm_selecttype type,
+                unsigned fd_index)
+{
+    struct rtcan_socket *sock = rtdm_fd_to_private(fd);
+
+    switch (type) {
+    case XNSELECT_READ:
+        return rtdm_sem_select(&sock->recv_sem, selector, XNSELECT_READ,
fd_index);
+    case XNSELECT_WRITE:
+    {
+        struct rtcan_device *dev;
+        int ifindex = 0;
+        int ret;
+
+        if (!(ifindex = atomic_read(&sock->ifindex)))
+        return -ENXIO;
+
+        if ((dev = rtcan_dev_get_by_index(ifindex)) == NULL)
+        return -ENXIO;
+
+        ret = rtdm_sem_select(&dev->tx_sem, selector, XNSELECT_WRITE,
fd_index);
+
+        rtcan_dev_dereference(dev);
+
+        return ret;
+    }
+    default:
+        return -EBADF;
+    }
+
+    return -EINVAL;
+}

 static struct rtdm_driver rtcan_driver = {
     .profile_info        = RTDM_PROFILE_INFO(rtcan,
@@ -981,6 +1018,7 @@ static struct rtdm_driver rtcan_driver = {
         .ioctl_nrt    = rtcan_raw_ioctl,
         .recvmsg_rt    = rtcan_raw_recvmsg,
         .sendmsg_rt    = rtcan_raw_sendmsg,
+        .select        = rtcan_raw_select,
     },
 };
