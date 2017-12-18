MIME-Version: 1.0
In-Reply-To: <b37fe6c5-6655-920a-5909-1b049d6c3e84@xenomai.org>
References: <CAKJ14NcLeYWfjRdLnagFo9ZaukU3Bq8W8sPV1sC4LOD4OUgp8g@mail.gmail.com>
 <b37fe6c5-6655-920a-5909-1b049d6c3e84@xenomai.org>
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Mon, 18 Dec 2017 00:22:59 +0000
Message-ID: <CAKJ14NejvcrXgqPo4L_zt3jxJYE3ZFeQvHwx0sTS=kZ-Lw0egw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Dec 17, 2017 at 2:25 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 12/17/2017 12:01 AM, Andreas Glatz wrote:
>>>
>>> I pushed a pile of RTnet fixes in a WIP branch of the official repo
>>> (wip/rtnet-fixes). Most of them address invalid direct references to
>>> user memory from kernel space (instead of properly copying back and
>>> forth via the copy_from/to_user interface), which are badly wrong at any
>>> rate, even breaking the kernel on SMAP-enabled x86 platforms.
>>>
...
>> below). That seems to happen somewhere early on in the rt_udp_bind()
>> function.... I'm currently compiling the 4.9 kernel with debug symbols
>> to see where it exactly happens. I'll continue looking into it
>> tomorrow...
>>
>
> Thanks. You may need that patch:
>
> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
> index a3fd496f3..436830341 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> @@ -350,7 +350,7 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
>  {
>         struct rtsocket *sock = rtdm_fd_to_private(fd);
>         const struct _rtdm_setsockaddr_args *setaddr;
> -       struct _rtdm_setsockaddr_args *_setaddr;
> +       struct _rtdm_setsockaddr_args _setaddr;
>
>         /* fast path for common socket IOCTLs */
>         if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)--
>

Unfortunately, that wasn't everything for rt_udp_bind() and
rt_udp_connect() as the initial pointer to struct sockaddr_in was
still a user space pointer and accessing it caused a page domain
fault. Currently, I came up with the patch below with which I get
positive results for rt_udp_bind() and rt_udp_connect(). However,
there's still something wrong in rt_udp_recvmsg() and rt_udp_sendmsg()
(see backtrace further below). Notice also the patch in
rt_udp_recvmsg(): msg->msg_header is another userspace pointer inside
msg. Hence, it has to be used to copy back the struct sockaddr_in
stuff to the user. More tomorrow...

<snip1>
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c
b/kernel/drivers/net/stack/ipv4/udp/udp.c
index a3fd496..1beb56f 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -154,17 +154,14 @@ static inline struct rtsocket
*rt_udp_v4_lookup(u32 daddr, u16 dport)
  *  @s:     socket
  *  @addr:  local address
  */
-int rt_udp_bind(struct rtsocket *sock, const struct sockaddr *addr,
-                socklen_t addrlen)
+int rt_udp_bind(struct rtsocket *sock, const struct sockaddr_in *usin)
 {
-    struct sockaddr_in  *usin = (struct sockaddr_in *)addr;
     rtdm_lockctx_t      context;
     int                 index;
     int                 err = 0;


-    if ((addrlen < (int)sizeof(struct sockaddr_in)) ||
-        ((usin->sin_port & auto_port_mask) == auto_port_start))
+    if ((usin->sin_port & auto_port_mask) == auto_port_start)
         return -EINVAL;

     rtdm_lock_get_irqsave(&udp_socket_base_lock, context);
@@ -207,10 +204,8 @@ int rt_udp_bind(struct rtsocket *sock, const
struct sockaddr *addr,
 /***
  *  rt_udp_connect
  */
-int rt_udp_connect(struct rtsocket *sock, const struct sockaddr *serv_addr,
-                   socklen_t addrlen)
+int rt_udp_connect(struct rtsocket *sock, const struct sockaddr_in *usin)
 {
-    struct sockaddr_in  *usin = (struct sockaddr_in *) serv_addr;
     rtdm_lockctx_t      context;
     int                 index;

@@ -233,8 +228,7 @@ int rt_udp_connect(struct rtsocket *sock, const
struct sockaddr *serv_addr,

         rtdm_lock_put_irqrestore(&udp_socket_base_lock, context);
     } else {
-        if ((addrlen < (int)sizeof(struct sockaddr_in)) ||
-            (usin->sin_family != AF_INET))
+        if (usin->sin_family != AF_INET)
             return -EINVAL;

         rtdm_lock_get_irqsave(&udp_socket_base_lock, context);
@@ -350,7 +344,9 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int
request, void __user *arg)
 {
        struct rtsocket *sock = rtdm_fd_to_private(fd);
        const struct _rtdm_setsockaddr_args *setaddr;
-       struct _rtdm_setsockaddr_args *_setaddr;
+       struct _rtdm_setsockaddr_args _setaddr;
+       const struct sockaddr_in *usin;
+       struct sockaddr_in _usin;

        /* fast path for common socket IOCTLs */
        if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
@@ -362,10 +358,18 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned
int request, void __user *arg)
                setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
                if (IS_ERR(setaddr))
                        return PTR_ERR(setaddr);
-               if (request == _RTIOC_BIND)
-                       return rt_udp_bind(sock, setaddr->addr,
setaddr->addrlen);
+
+               if (setaddr->addrlen < (int)sizeof(struct sockaddr_in))
+                       return -EINVAL;
+
+               usin = rtnet_get_arg(fd, &_usin, setaddr->addr,
setaddr->addrlen);
+               if (IS_ERR(usin))
+                       return PTR_ERR(usin);

-               return rt_udp_connect(sock, setaddr->addr, setaddr->addrlen);
+               if (request == _RTIOC_BIND)
+                       return rt_udp_bind(sock, usin);
+               else
+                       return rt_udp_connect(sock, usin);

         default:
                return rt_ip_ioctl(fd, request, arg);
@@ -380,7 +384,7 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int
request, void __user *arg)
 /***
  *  rt_udp_recvmsg
  */
-ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
int msg_flags)
+ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr
*msg_hdr, int msg_flags)
 {
     struct rtsocket     *sock = rtdm_fd_to_private(fd);
     size_t              len;
@@ -393,11 +397,11 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd,
struct user_msghdr *msg, int msg_flag
     struct sockaddr_in  sin;
     nanosecs_rel_t      timeout = sock->timeout;
     int                 ret, flags;
-    struct user_msghdr _msg;
+    struct user_msghdr  *msg, _msg;
     socklen_t namelen;
     struct iovec iov_fast[RTDM_IOV_FASTMAX], *iov;

-    msg = rtnet_get_arg(fd, &_msg, msg, sizeof(*msg));
+    msg = rtnet_get_arg(fd, &_msg, msg_hdr, sizeof(_msg));
    if (IS_ERR(msg))
            return PTR_ERR(msg);

@@ -438,7 +442,7 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct
user_msghdr *msg, int msg_flag
            sin.sin_family      = AF_INET;
            sin.sin_port        = uh->source;
            sin.sin_addr.s_addr = skb->nh.iph->saddr;
-           ret = rtnet_put_arg(fd, &msg->msg_name, &sin, sizeof(sin));
+           ret = rtnet_put_arg(fd, msg->msg_name, &sin, sizeof(sin));
            if (ret)
                    goto fail;

@@ -489,6 +493,7 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct
user_msghdr *msg, int msg_flag
            if (ret)
                    goto fail;
     }
+
 out:
     if ((msg_flags & MSG_PEEK) == 0)
         kfree_rtskb(first_skb);
</snip1>


<snip2>
[ 1462.954012] Unhandled fault: page domain fault (0x01b) at 0xbe90e9a4
[ 1462.963089] pgd = ebb3c000
[ 1462.967451] [be90e9a4] *pgd=8d0f8831
[ 1462.971317] Internal error: : 1b [#3] SMP ARM
[ 1462.975685] Modules linked in: rtudp rt_fec rtpacket rtipv4
rt_loopback rtnet 8021q garp mrp stp llc iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_na]
[ 1463.024766] CPU: 3 PID: 1464 Comm: server Tainted: G      D
4.9.69-armv7-x6 #7
[ 1463.032692] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[ 1463.039227] I-pipe domain: Linux
[ 1463.042465] task: ee107140 task.stack: eced8000
[ 1463.047031] PC is at rt_udp_getfrag+0x44/0x124 [rtudp]
[ 1463.052235] LR is at rt_ip_build_xmit+0x238/0x304 [rtipv4]
[ 1463.057734] pc : [<bf043c14>]    lr : [<bf01b3b4>]    psr: 200b0013
               sp : eced9ce8  ip : bf043be8  fp : eced9d0c
[ 1463.069220] r10: eb8bce24  r9 : 00000000  r8 : 0000000d
[ 1463.074454] r7 : eb3a4864  r6 : 0000000d  r5 : eced9dac  r4 : 00000000
[ 1463.080990] r3 : be90e9a4  r2 : 00000000  r1 : eb3a4864  r0 : 00000000
[ 1463.087530] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 1463.094675] Control: 10c5387d  Table: 3bb3c04a  DAC: 00000051
[ 1463.100431] Process server (pid: 1464, stack limit = 0xeced8220)
[ 1463.106448] Stack: (0xeced9ce8 to 0xeceda000)
[ 1463.110823] 9ce0:                   eced9d0c eced9cf8 eb317400
00002100 eb3a47c0 eb3a4864
[ 1463.119016] 9d00: eced9d64 eced9d10 bf01b3b4 bf043bdc eced9db4
eced9d20 c0189c30 6c03a8c0
[ 1463.127207] 9d20: eced9ddc bf01e718 eced9dac bf043bd0 0000000f
0000000d eced9d64 c160418c
[ 1463.135397] 9d40: 00000005 eced9ddc 00000000 eb8bce00 eced9e04
00000000 eced9eb4 eced9d68
[ 1463.143590] 9d60: bf0440dc bf01b188 eced9ddc 00000000 5003a8c0
00007491 6c03a8c0 c1516b54
[ 1463.151780] 9d80: c160504c 00000000 c0223168 eced9e04 be90ebf8
00000010 be90e9a4 00000001
[ 1463.159971] 9da0: 00000000 00000000 00000000 7491b822 00000d00
6c03a8c0 5003a8c0 eb8bce00
[ 1463.168163] 9dc0: be90e9a4 00000001 00000000 74910002 6c03a8c0
00000000 00000000 6c03a8c0
[ 1463.176352] 9de0: b5cb1600 00003ab6 00000000 00000000 00000000
00000000 00000000 00000000
[ 1463.184545] 9e00: eb317400 be90e9f4 00000005 c0170f24 eced9e44
eced9e20 c0170f24 c01130c0
[ 1463.192734] 9e20: c177b088 00000001 00000002 ee118000 00000000
00000000 eced9e64 eced9e48
[ 1463.200926] 9e40: c0222efc c01183a4 c1516b54 c160504c 00000000
00000000 eced9e94 eced9e68
[ 1463.209117] 9e60: c029907c c0222ee8 be90ebf8 c160418c 00000003
00000000 00000003 00000000
[ 1463.217309] 9e80: eced9ef0 00040945 eced9eb4 eb8bce00 c1517cf4
800b0013 00000003 00000000
[ 1463.225501] 9ea0: eced9ef0 c15159b4 eced9eec eced9eb8 c0299b38
bf043d00 ed3bac08 c1517d44
[ 1463.233692] 9ec0: c1648aa4 c160418c 00000003 00000000 00000051
00000001 c029ecb0 c15159b4
[ 1463.241884] 9ee0: eced9f2c eced9ef0 c029ed60 c0299ab0 be90ebf8
00000010 be90e9a4 00000001
[ 1463.250076] 9f00: 00000000 00000000 00000000 00040945 eced9fb0
00000052 c160504c f0936008
[ 1463.258267] 9f20: eced9f64 eced9f30 c02ac9a0 c029ecbc be90e9ac
c0365388 ed3bac00 eedcb9b4
[ 1463.266457] 9f40: 00000001 eedcc9b4 c160504c c1820600 c1820600
c15159b4 eced9fac eced9f68
[ 1463.274648] 9f60: c02236bc c02ac874 c15159b4 c1517cf4 c1820600
eced9fb0 c1820600 200b0013
[ 1463.282838] 9f80: 009fc6d0 00000000 be90e9ac 00000003 000f0042
c0109668 eced8000 00000002
[ 1463.291029] 9fa0: 00000000 eced9fb0 c01095b4 c02235b0 10000054
00000003 be90e9ac 00000000
[ 1463.299220] 9fc0: 00000000 be90e9ac 00000003 000f0042 be90e9f4
00000005 00000000 00000000
[ 1463.307410] 9fe0: b6f860dc be90e978 00000000 b6f6dee2 000b0030
10000054 65725f65 656d7573
[ 1463.315687] [<bf043c14>] (rt_udp_getfrag [rtudp]) from [<bf01b3b4>]
(rt_ip_build_xmit+0x238/0x304 [rtipv4])
[ 1463.325502] [<bf01b3b4>] (rt_ip_build_xmit [rtipv4]) from
[<bf0440dc>] (rt_udp_sendmsg+0x3e8/0x460 [rtudp])
[ 1463.335279] [<bf0440dc>] (rt_udp_sendmsg [rtudp]) from [<c0299b38>]
(rtdm_fd_sendmsg+0x94/0x1cc)
[ 1463.344088] [<c0299b38>] (rtdm_fd_sendmsg) from [<c029ed60>]
(CoBaLt_sendmsg+0xb0/0xb8)
[ 1463.352113] [<c029ed60>] (CoBaLt_sendmsg) from [<c02ac9a0>]
(ipipe_syscall_hook+0x138/0x370)
[ 1463.360571] [<c02ac9a0>] (ipipe_syscall_hook) from [<c02236bc>]
(__ipipe_notify_syscall+0x118/0x1dc)
[ 1463.369727] [<c02236bc>] (__ipipe_notify_syscall) from [<c01095b4>]
(pipeline_syscall+0x8/0x24)
[ 1463.378444] Code: c590001c da00000a e5953014 e1a02000 (e7930184)
[ 1463.384554] ---[ end trace f8a046fb32eafdc5 ]---
</snip2>

