From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] boilerplate/avl: fix NULL link representation in pshared mode
Date: Sat, 26 Oct 2019 12:04:24 +0200
Message-Id: <20191026100424.30908-1-rpm@xenomai.org>
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

Detect and store NULL links as zero offsets into the shared AVL
tree. Otherwise, non-constant offsets may be generated for
representing a NULL link, depending on the process-specific start
address of the pshared AVL tree in memory as obtained from a memory
mapping.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/boilerplate/avl-inner.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/boilerplate/avl-inner.h b/include/boilerplate/avl-inner.h
index 10c91140c..8e4de8487 100644
--- a/include/boilerplate/avl-inner.h
+++ b/include/boilerplate/avl-inner.h
@@ -104,26 +104,30 @@ static inline struct shavlh *
 shavlh_link(const struct shavl *const avl,
 	    const struct shavlh *const holder, unsigned int dir)
 {
-	return (void *)avl + holder->link[avl_type2index(dir)].offset;
+	ptrdiff_t offset = holder->link[avl_type2index(dir)].offset;
+	return offset ? (void *)avl + offset : NULL;
 }
 
 static inline void
 shavlh_set_link(struct shavl *const avl, struct shavlh *lhs,
 		int dir, struct shavlh *rhs)
 {
-	lhs->link[avl_type2index(dir)].offset = (void *)rhs - (void *)avl;
+	ptrdiff_t offset = rhs ? (void *)rhs - (void *)avl : 0;
+	lhs->link[avl_type2index(dir)].offset = offset;
 }
 
 static inline
 struct shavlh *shavl_end(const struct shavl *const avl, int dir)
 {
-	return (void *)avl + avl->end[avl_type2index(dir)].offset;
+	ptrdiff_t offset = avl->end[avl_type2index(dir)].offset;
+	return offset ? (void *)avl + offset : NULL;
 }
 
 static inline void
 shavl_set_end(struct shavl *const avl, int dir, struct shavlh *holder)
 {
-	avl->end[avl_type2index(dir)].offset = (void *)holder - (void *)avl;
+	ptrdiff_t offset = holder ? (void *)holder - (void *)avl : 0;
+	avl->end[avl_type2index(dir)].offset = offset;
 }
 
 #define shavl_count(avl)	((avl)->count)
-- 
2.21.0


