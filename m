Message-ID: <2ff1a98a0712060528y13159abdwb83617a8744b3735@domain.hid>
Date: Thu, 6 Dec 2007 14:28:33 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4757F811.70905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4757EBAE.4050608@domain.hid>
	<2ff1a98a0712060513g3b056866x883691498daf00e1@domain.hid>
	<4757F811.70905@domain.hid>
Subject: Re: [Xenomai-core] How to cancel a Xenomai POSIX thread
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Dec 6, 2007 2:24 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > On Dec 6, 2007 1:31 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
> >> Hello,
> >>
> >> how do I cancel or delete a Xenomai POSIX thread running in primary
> >> context from a higher priority thread? IIUC, pthread_kill() can only be
> >> used in secondary context. I tried pthread_cancel(), but it only works
> >> when hitting a cancelation point, e.g. pthread_testcancel(). Setting
> >> pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS) did not help. Is
> >> there a code snippet or even an example program showing how to cancel a
> >> pthread in primary context?
> >
> > pthread_kill or pthread_cancel should result in sending a signal to
> > the target thread, so should cause this thread to switch to secondary
> > mode to handle it. If you want to wait for the target thread to be
> > canceled, you should use pthread_cancel and pthread_join.
>
> There is no way to cancel a pthread in primary mode from another pthread?

No. You always need secondary mode to effectively delete a thread. The
same goes for the native skin.

-- 
                                               Gilles Chanteperdrix

