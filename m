MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18274.58440.2548.595079@domain.hid>
Date: Fri, 14 Dec 2007 21:15:04 +0100
In-Reply-To: <410198.28041.qm@domain.hid>
References: <410198.28041.qm@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

Michael Trimarchi wrote:
 > 
 > Hi,
 > 
 > +#define PICK_SPINUNLOCK_IRQ_RAW(lock)                          \
 > +do {                                                                   \
 > +       if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {                   \
 > +               __ipipe_spin_lock_irq(&((__ipipe_spinlock_t *)(lock))->__raw_lock); \
 > +       } else if (TYPE_EQUAL(lock, spinlock_t))                        \
 > +               __raw_spin_unlock(&((spinlock_t *)(lock))->raw_lock);   \
 > +               local_irq_enable();                                     \
 > +} while (0)
 > 
 > Who can me explain this in the official adeos-ipipe-2.6.20-arm-1.7-06.patch ?
 > I don't understand
 > 
 > Regards Michael

Looks like a cut and paste bug.

-- 


					    Gilles Chanteperdrix.

