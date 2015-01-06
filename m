Date: Tue, 6 Jan 2015 10:16:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150106091658.GA11206@hermes.click-hack.org>
References: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
 <20141223164659.GB1537@daedalus>
 <1238414447.116297.1419353922775.JavaMail.zimbra@wandercraft.eu>
 <20141224002912.GC1537@daedalus>
 <2022750954.117025.1419413418676.JavaMail.zimbra@wandercraft.eu>
 <20141224144928.GA2945@daedalus>
 <1544959523.130965.1420453839375.JavaMail.zimbra@wandercraft.eu>
 <20150105165813.GA8043@hermes.click-hack.org>
 <642019253.136329.1420535370881.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <642019253.136329.1420535370881.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] Differents switch mode from differents Xenomai skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Tue, Jan 06, 2015 at 10:09:30AM +0100, Huy Cong Vu wrote:
> 
> 
> ----- Mail original -----
> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> > Cc: xenomai@xenomai.org
> > Envoyé: Lundi 5 Janvier 2015 17:58:13
> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin
> 
> > On Mon, Jan 05, 2015 at 11:30:39AM +0100, Huy Cong Vu wrote:
> >> 
> >> 
> >> ----- Mail original -----
> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> >> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> >> > Cc: xenomai@xenomai.org
> >> > Envoyé: Mercredi 24 Décembre 2014 15:49:28
> >> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin
> >> 
> >> > On Wed, Dec 24, 2014 at 10:30:18AM +0100, Huy Cong Vu wrote:
> >> >> 
> >> >> 
> >> >> ----- Mail original -----
> >> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> >> >> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> >> >> > Cc: xenomai@xenomai.org
> >> >> > Envoyé: Mercredi 24 Décembre 2014 01:29:12
> >> >> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin
> >> >> 
> >> >> > On Tue, Dec 23, 2014 at 05:58:42PM +0100, Huy Cong Vu wrote:
> >> >> >> 
> >> >> >> 
> >> >> >> ----- Mail original -----
> >> >> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> >> >> >> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> >> >> >> > Cc: xenomai@xenomai.org
> >> >> >> > Envoyé: Mardi 23 Décembre 2014 17:46:59
> >> >> >> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin
> >> >> >> 
> >> >> >> > On Tue, Dec 23, 2014 at 05:43:41PM +0100, Huy Cong Vu wrote:
> >> >> >> >> 
> >> >> >> >> 
> >> >> >> >> ----- Mail original -----
> >> >> >> >> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> >> >> >> >> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> >> >> >> >> > Cc: xenomai@xenomai.org
> >> >> >> >> > Envoyé: Mardi 23 Décembre 2014 17:35:35
> >> >> >> >> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin
> >> >> >> >> 
> >> >> >> >> > On Tue, Dec 23, 2014 at 05:23:07PM +0100, Huy Cong Vu wrote:
> >> >> >> >> >> void mini( void *ptr )
> >> >> >> >> >> {
> >> >> >> >> >> 
> >> >> >> >> >> 
> >> >> >> >> >> 	uint8_t b;
> >> >> >> >> >> 	int ret1;
> >> >> >> >> >> 	int idx;
> >> >> >> >> >> 
> >> >> >> >> >> 	pthread_set_mode_np(0, PTHREAD_WARNSW);
> >> >> >> >> >>    printf("Starting posix test\n");
> >> >> >> >> >> 
> >> >> >> >> >> 	ec_port = malloc(sizeof(ecx_portt*));
> >> >> >> >> >> 
> >> >> >> >> >> 	if (setup_nic(ec_port,"rteth0") > 0) {
> >> >> >> >> >> 		   idx = getindex (ec_port);
> >> >> >> >> >>    		/* setup datagram */
> >> >> >> >> >> 			b = 0x0000;
> >> >> >> >> >>    		setupdatagram (ec_port, &(ec_port->txbuf[idx]),0x0009, idx, 0x0000, 0x0103,
> >> >> >> >> >>    		sizeof(b), &b );
> >> >> >> >> >>    		/* send data and wait for answer */
> >> >> >> >> >>    		wkc = srconfirm (ec_port, idx, EC_TIMEOUTRET3);
> >> >> >> >> >> 	}
> >> >> >> >> >> 	
> >> >> >> >> >> }
> >> >> >> >> > 
> >> >> >> >> > Typically, as I already explained, what you do here is wrong: you
> >> >> >> >> > should not arm the PTHREAD_WARNSW bit before call such as malloc or
> >> >> >> >> > the calls in setup_nic, which switch to secondary mode.
> >> >> >> >> 
> >> >> >> >> Ok, should I call it laterly? It is just for detect mode switch
> >> >> >> >> reason in fact
> >> >> >> > 
> >> >> >> > How to use PTHREAD_WARNSW is thoroughly documented, see:
> >> >> >> > https://xenomai.org/2014/06/finding-spurious-relaxes/
> >> >> >> > 
> >> >> >> 
> >> >> >> So perhaps I was misunderstanding this statement?
> >> >> >> Then, you need to enable the warn_upon_switch capability on a per-thread basis.
> >> >> >> For instance, a POSIX-based application would run this code from the thread to
> >> >> >> monitor for spurious relaxes:
> >> >> >> 
> >> >> >>     /* Ask Xenomai to warn us upon switches to secondary mode. */
> >> >> >>     pthread_set_mode_np(0, PTHREAD_WARNSW);
> >> >> >> 
> >> >> >> Does that means that I must put the line into the thread with function calls
> >> >> >> that cause mode switch?
> >> >> >> I thought it means that I have to put the line in the threads of my program (in
> >> >> >> my case mini() ).
> >> >> > 
> >> >> > Enabling this bit, causes every switch to secondary mode of the
> >> >> > thread where you enabled it to send a signal to that thread. I do
> >> >> > not understand what is so hard to understand about this.
> >> >> 
> >> >> Ok, so I guess I didn't understand this wrongly at least.
> >> >> 
> >> >> Suppose that I remove PTHREAD_WARNSW bit, here what I got in output:
> >> >> SOEM (Simple Open EtherCAT Master)
> >> >> Simple test
> >> >> Starting posix test
> >> >> Mode switch (reason bad functions call while holding mutex, or other unknown
> >> >> issue), aborting. Backtrace:
> >> >> ./posix_minimal[0x401bf6]
> >> >> /lib/x86_64-linux-gnu/libpthread.so.0(+0xfcb0)[0x7f94ef972cb0]
> >> >> /usr/xenomai/lib/libpthread_rt.so.1(__wrap_send+0xd5)[0x7f94efd8f9f5]
> >> >> ./posix_minimal[0x4017dc]
> >> >> ./posix_minimal[0x4016ed]
> >> >> ./posix_minimal[0x4011cd]
> >> >> /usr/xenomai/lib/libpthread_rt.so.1(+0x5b45)[0x7f94efd8cb45]
> >> >> /lib/x86_64-linux-gnu/libpthread.so.0(+0x7e9a)[0x7f94ef96ae9a]
> >> >> /lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)[0x7f94ef28d3fd]
> >> >> Temps UCT limite expiré (core dumped)
> >> >> 
> >> >> It is the same output as when PTHREAD_WARNSW is active. Could you give me some
> >> >> hints why?
> >> > 
> >> > I already gave you some hints. I need to run the test code you sent.
> >> > But the test code you sent is wrong in the place where it enables
> >> > the PTHREAD_WARNSW bit.
> >> 
> >> The output of:
> >>  void mini( void *ptr )
> >>  {
> >>  
> >>  	uint8_t b;
> >>  	int ret1;
> >>  	int idx;
> >> 
> >>         printf("Starting posix test\n");
> >>  
> >>  	ec_port = malloc(sizeof(ecx_portt*));
> >>  
> >>  	if (setup_nic(ec_port,"rteth0") > 0) {
> >>  		   idx = getindex (ec_port);
> >>      		   /* setup datagram */
> >>          	   b = 0x0000;
> >>     	           setupdatagram (ec_port, &(ec_port->txbuf[idx]),0x0009, idx, 0x0000, 0x0103,
> >>     	           sizeof(b), &b );
> >>                    /* send data and wait for answer */
> >>                    pthread_set_mode_np(0, PTHREAD_WARNSW);
> >>                    wkc = srconfirm (ec_port, idx, EC_TIMEOUTRET3);
> >>         }
> >> }
> >> 
> >> and program without any PTHREAD_WARNSW are the same as the last post I gave you.
> >> So we can conclude that it was not setup_nic or malloc which trigger the
> >> SIGDEBUG handler.
> > 
> > It makes sense for malloc not to cause a SIGDEBUG, because malloc
> > does not always cause a switch to secondary mode. But for setup_nic
> > I really have doubts. Are you sure that the thread is not running
> > with the SCHED_OTHER policy and this is not the cause of both
> > behaviours (no mode switch on secondary mode operations, because the
> > thread is running in secondary mode, then switch when calling a
> > primary mode operation because of the automatic switch back to
> > secondary mode due to the SCHED_OTHER policy)?
> > 
> 
> Hi Gilles, 
> 
> With my old minimal test, there were no mode switch for setup_nic with SCHED_OTHER & SCHED_FIFO. The mode switch occurs only at the __wrap_send call (err RESCNT_IMBALANCE)
> 
> But I inserted this line yesterday in main() function to setup p_attr1: 
> pthread_attr_setinheritsched(&p_attr1, PTHREAD_EXPLICIT_SCHED);
> 
> With this, the behavior becomes normal, i.e:
> with SCHED_FIFO, there are 1 mode switch in setup_nic when calling __wrap_socket (which is valid), and after that there are no mode switch anymore.

It makes sense.

> with SCHED_OTHER, always the same mode switch at __wrap_send.

That does not really make sense. If the driver you use uses some
RTDM spinlock, it is possible that you have the same issue with RTDM
mutexes as was fixed recently in Xenomai 3:

https://git.xenomai.org/xenomai-3.git/commit/?id=ef0992d6278ccad0af594b388f19d6536ececb29

> 
> So basiclly, now its worked, but I don't understand why the setinheritsched call can hold the mode switch in __wrap_send while all others fail? 

Sorry, I do not understand your question. Without
PTHREAD_EXPLICIT_SCHED, the newly created thread uses the same
scheduling policy as the calling thread, which is SCHED_OTHER if you
do not do anything special (such as running the program with chrt).

-- 
					    Gilles.

