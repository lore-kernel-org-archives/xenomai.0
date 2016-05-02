From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 2 May 2016 11:06:27 -0400
Message-ID: <20160502150627.GB2055@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Tiny typo in ipipe in pinctrl.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On branch ipipe-4.1.y in drivers/pinctrl/pinctrl.c at line 221:

#define PCS_QUIRK_SHARED_IRQ    (1 << 2)
#define PCS_FEAT_IRQ            (1 << 1)
#define PCS_FEAT_PINCONF        (1 << 0)
        struct pcs_soc_data socdata;
#ifdef CONFIG_IPIPE
        ipipe_spinlock_t lock;
#else /* !IPIPE */
        raw_spinlock_t lock                  <- missing ';'
#endif /* !IPIPE */
        struct mutex mutex;
        unsigned width;
        unsigned fmask;
        unsigned fshift;

-- 
Len Sorensen

