From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 5/5] net: dovetail: fix NULL reference in socket release
Date: Tue, 31 Aug 2021 10:27:09 +0200
Message-Id: <20210831082709.1296249-6-rpm@xenomai.org>
In-Reply-To: <20210831082709.1296249-1-rpm@xenomai.org>
References: <20210831082709.1296249-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

sock_oob_capable() might be called for a socket for which no
protocol-agnostic area is allocated yet. Be careful when dereferencing
this field.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index c673cea523eb78f..cfd99bcb6072caf 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -145,7 +145,7 @@ static void sock_show_fdinfo(struct seq_file *m, struct file *f)
 
 static inline bool sock_oob_capable(struct socket *sock)
 {
-	return !!sock->sk->oob_data;
+	return sock->sk && sock->sk->oob_data;
 }
 
 int __weak sock_oob_attach(struct socket *sock)
-- 
2.31.1


