MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Tue, 21 Apr 2020 13:38:30 +0800
Message-ID: <CAAvDm6bELZHyw+nq=WtBRn-G2qtH-fCkoKot-1uwmwMs_1Q=qQ@mail.gmail.com>
Subject: 
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi=EF=BC=8C
      What' the meaning of snapshot-driven Which is seen in the comments of
the code of xenomai-v3.1.
      For your convenice, I list the related code below.
Very few useful information could be aquired  through the search engines.

      I have seen  many function names which contain the letters 'snapshot'
while i am browsing xenomai source code .
     I tried my best to understand it, but i fail.

     Thanks for your attention.
     Look forward to hearing from you.
 /**

 * @brief Vfile locking operations
 * @anchor vfile_lockops
 *
 * This structure describes the operations to be provided for
 * implementing locking support on vfiles. They apply to both
 * snapshot-driven and regular vfiles.
 */
struct xnvfile_lock_ops {
   /**
    * @anchor lockops_get
    * This handler should grab the desired lock.
    *
    * @param vfile A pointer to the virtual file which needs
    * locking.
    *
    * @return zero should be returned if the call
    * succeeds. Otherwise, a negative error code can be returned;
    * upon error, the current vfile operation is aborted, and the
    * user-space caller is passed back the error value.
    */
   int (*get)(struct xnvfile *vfile);
   /**
    * @anchor lockops_put This handler should release the lock
    * previously grabbed by the @ref lockops_get "get() handler".
    *
    * @param vfile A pointer to the virtual file which currently
    * holds the lock to release.
    */
   void (*put)(struct xnvfile *vfile);
};
