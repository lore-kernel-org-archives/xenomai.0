From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Subject: Re: [Xenomai] [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp
 to be built
Date: Wed, 31 Oct 2018 20:18:42 +0100
Message-ID: <1603372.t0VIGcUN6F@lenni>
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BC96@DDCEXCH.ddc-ny.com>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <7041379.eS1cmEbPlD@lenni>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BC96@DDCEXCH.ddc-ny.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "Hillman,
 Robert" <hillman@ddc-web.com>

Pham, Phong wrote:
> Now I encounter a different problem,
> 
> recv() returns 0 bytes but I know my FTP server sends a packet (seen
> by WireShark).  Can you point me where is the recv() implemented in
> tcp.c?  Is it rt_tcp_rcv or rt_tcp_recvmsg?

There are indeed two more issues with the rttcp driver: one in the
receive path, one in the close path. I have prepared patches for both.
Could you give them a try? I will include them in the v2 patch series
for the rttcp driver.

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 2678e6a..3242a08 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -2084,17 +2084,10 @@ static ssize_t rt_tcp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg, int m
 
        len = iov[0].iov_len;
        if (len > 0) {
-               buf = xnmalloc(len);
-               if (buf == NULL) {
-                       ret = -ENOMEM;
-                       goto out;
-               }
-               ret = rtdm_copy_from_user(fd, buf, iov[0].iov_base, len);
-               if (!ret)
-                       ret = rt_tcp_read(fd, buf, len);
-               xnfree(buf);
+               buf = iov[0].iov_base;
+               ret = rt_tcp_read(fd, buf, len);
        }
-out:
+
        rtdm_drop_iovec(iov, iov_fast);
 
        return ret;

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 3242a08..c066e06 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -249,15 +249,18 @@ static struct rtsocket *rt_tcp_v4_lookup(u32 daddr, u16 dport)
 {
     rtdm_lockctx_t  context;
     struct tcp_socket *ts;
+    int ret;
 
     rtdm_lock_get_irqsave(&tcp_socket_base_lock, context);
     ts = port_hash_search(daddr, dport);
 
-    if (ts && rt_socket_reference(&ts->sock) == 0) {
-
-       rtdm_lock_put_irqrestore(&tcp_socket_base_lock, context);
+    if (ts != NULL) {
+       ret = rt_socket_reference(&ts->sock);
+       if (ret == 0 || (ret == -EIDRM && ts->is_closed)) {
+               rtdm_lock_put_irqrestore(&tcp_socket_base_lock, context);
 
-       return &ts->sock;
+               return &ts->sock;
+       }
     }
 
     rtdm_lock_put_irqrestore(&tcp_socket_base_lock, context);

-- 
Sebastian




