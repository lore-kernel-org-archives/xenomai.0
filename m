Message-ID: <2ff1a98a0712040608l634b902kf1d7db3652b71575@domain.hid>
Date: Tue, 4 Dec 2007 15:08:29 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375F43@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
	<51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int>
	<2ff1a98a0712030235vfc316b8nff4b1e422db82c96@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int>
	<2ff1a98a0712030552y1c9b10b8p54730d45f6245906@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEE@slcmail.slc.mew.int>
	<18260.25837.479943.881970@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375F08@domain.hid>
	<18260.29573.817255.968962@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375F43@domain.hid>
Subject: Re: [Xenomai-help] wathcdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

On Dec 4, 2007 2:57 PM, Steven Seeger
<sseeger@domain.hid> wrote:
> It seems that I am missing something. I see that you limit the signal to
> be sent to a thread with a matching mm, however doesn't this send a
> signal that can only be captured by a kernel space thread with
> rt_task_catch()?

No, signals with xnshadow_send_sig are pure linux signals sent with
the kernel function send_sig. So, they are caught by installing a
signal handler with either signal or sigaction.

 If so, that wouldn't be part of the application. I
> don't really know what "mm" means, but if it's a virtual address space,
> then usually that's shared among all modules.

mm is almost the only way to recognize threads belonging to the same
process. Threads created with linuxthreads are alone in their thread
group, so we can not portably use the threads group feature.

Note that if a kernel space thread is killed by the watchdog, all
user-space threads which armed the XNSIGWDG are notified, because we
do not know to which process the kernel-space thread logically
belongs.

>
> Steven
>
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Sent: Monday, December 03, 2007 2:22 PM
> > To: Steven Seeger
> > Cc: xenomai@xenomai.org
> > Subject: RE: [Xenomai-help] wathcdog
> >
>
> > Steven Seeger wrote:
> >  > > Ok. We can send the signal only to threads which are part of the
> same
> >  > > application as the faulting thread.
> >  >
> >  > That would be a big help! At least then we can report which
> application
> >  > had the fault. We have a few applications that work together.
> >
> > Here it comes.
>
>



-- 
                                               Gilles Chanteperdrix

