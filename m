From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1271597170.16659.34.camel@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
	<5a62361072f2d0555ba65eba6dc2d322ad2f51e9.1271596366.git.Jan Kiszka
	jan.kiszka@domain.hid> <1271597170.16659.34.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 18 Apr 2010 15:30:09 +0200
Message-ID: <1271597409.16659.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v3 02/24] RTDM: Add rtdm_rt_capable()
 service
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, Alexis Berlemont <berlemont.hauw@domain.hid>

On Sun, 2010-04-18 at 15:26 +0200, Philippe Gerum wrote:
> On Sun, 2010-04-18 at 15:12 +0200, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@domain.hid>
> > 
> > This adds rtdm_rt_capable(), a function that can be used by drivers to
> > detect callers that could issue a service request also from the
> > (typically preferred) real-time context. If that is the case, the driver
> > can trigger a restart of the request if the current context is not
> > real-time.
> > 
> > CC: Philippe Gerum <rpm@xenomai.org>
> > CC: Alexis Berlemont <berlemont.hauw@domain.hid>
> > Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> > ---
> >  include/rtdm/rtdm_driver.h |    6 ++++++
> >  ksrc/skins/rtdm/drvlib.c   |   25 +++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
> > index 0fc1496..45be404 100644
> > --- a/include/rtdm/rtdm_driver.h
> > +++ b/include/rtdm/rtdm_driver.h
> > @@ -1296,6 +1296,12 @@ static inline int rtdm_in_rt_context(void)
> >  {
> >  	return (rthal_current_domain != rthal_root_domain);
> >  }
> > +
> > +static inline int rtdm_rt_capable(void)
> > +{
> > +	return xnpod_shadow_p();
> > +}
> > +
> 
> This won't do what your comment states; xnpod_shadow_p() would always
> return false on behalf of a relaxed shadow, since it tests the status
> bits of the current Xenomai thread, which has to be the root one in that
> case. xnpod_shadow_p is to be used in primary context only, to
> distinguish between kernel-based and userland Xenomai callers. 
> 
> What you want is probably something like:
> 
> static inline int rtdm_rt_capable(void)
> {
> 	return xnshadow_thread(current) != NULL;
> }

Btw, the predicate as you defined it would not work over kernel-based
Xenomai threads. rtdm_rt_capable() is ambiguous here.

> 
> 
> >  #endif /* !DOXYGEN_CPP */
> >  
> >  int rtdm_exec_in_rt(struct rtdm_dev_context *context,
> > diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
> > index 3b04493..6e26501 100644
> > --- a/ksrc/skins/rtdm/drvlib.c
> > +++ b/ksrc/skins/rtdm/drvlib.c
> > @@ -2341,6 +2341,31 @@ int rtdm_strncpy_from_user(rtdm_user_info_t *user_info, char *dst,
> >   */
> >  int rtdm_in_rt_context(void);
> >  
> > +/**
> > + * Test if the caller is capable of running in real-time context
> > + *
> > + * @return Non-zero is returned if the caller is able to execute in real-time
> > + * context (independent of its current execution mode), 0 otherwise.
> > + *
> > + * @note This function can be used by drivers that provide different
> > + * implementations for the same service depending on the execution mode of
> > + * the caller. If a caller requests such a service in non-real-time context
> > + * but is capable of running in real-time as well, it might be appropriate
> > + * for the driver to reject the request via -ENOSYS so that RTDM can switch
> > + * the caller and restart the request in real-time context.
> > + *
> > + * Environments:
> > + *
> > + * This service can be called from:
> > + *
> > + * - Kernel module initialization/cleanup code
> > + * - Kernel-based task
> > + * - User-space task (RT, non-RT)
> > + *
> > + * Rescheduling: never.
> > + */
> > +int rtdm_rt_capable(void);
> > +
> >  #endif /* DOXYGEN_CPP */
> >  
> >  /** @} Utility Services */
> 
> 


-- 
Philippe.



