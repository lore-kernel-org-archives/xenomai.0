From: Nihar Unadkat <Nihar@deltatau.com>
Date: Wed, 31 Jan 2018 01:09:17 +0000
Message-ID: <SN1PR11MB06061A18733A417D16117719D1FB0@SN1PR11MB0606.namprd11.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] suspending kernel thread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Henry Bausley <hbausley@deltatau.com>

Hi=20

I am using ipipe-ipipe-core-4.1.18-arm-9 which is patched with xenomai-2.6.=
5

I am getting an error=20
Xenomai: suspending kernel thread 7f8c2cb8 ('xxxx') at 0x7f89d6e8 after exc=
eption #0x8

Where ('xxxx') is our function name.

So I searched for where this message comes from and  I found it in the file=
 pod.c and the function that is causing this error is=20

/*!
 * \fn void xnpod_trap_fault(xnarch_fltinfo_t *fltinfo);
 * \brief Default fault handler.
 *
 * This is the default handler which is called whenever an uncontrolled
 * exception or fault is caught. If the fault is caught on behalf of a
 * real-time thread, the fault is not propagated to the host system.
 * Otherwise, the fault is unhandled by the nucleus and simply propagated.
 *
 * @param fltinfo An opaque pointer to the arch-specific buffer
 * describing the fault. The actual layout is defined by the
 * xnarch_fltinfo_t type in each arch-dependent layer file.
 *
 */

int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)
{
=09xnthread_t *curr;

=09if (!xnpod_active_p() ||
=09    (!xnpod_interrupt_p() && xnpod_idle_p()))
=09=09return 0;

=09curr =3D xnpod_current_thread();

=09trace_mark(xn_nucleus, thread_fault,
=09=09   "thread %p thread_name %s ip %p type 0x%x",
=09=09   curr, xnthread_name(curr),
=09=09   (void *)xnarch_fault_pc(fltinfo),
=09=09   xnarch_fault_trap(fltinfo));

#ifdef __KERNEL__
=09if (xnarch_fault_fpu_p(fltinfo)) {
=09=09if (__xnpod_fault_init_fpu(curr))
=09=09=09return 1;
=09=09print_symbol("invalid use of FPU in Xenomai context at %s\n",
=09=09=09     xnarch_fault_pc(fltinfo));
=09}

=09if (!xnpod_userspace_p()) {
=09=09xnprintf
=09=09    ("suspending kernel thread %p ('%s') at 0x%lx after exception #0x=
%x\n",
=09=09     curr, curr->name, xnarch_fault_pc(fltinfo),
=09=09     xnarch_fault_trap(fltinfo));

=09=09xnpod_suspend_thread(curr, XNSUSP, XN_INFINITE, XN_RELATIVE, NULL);
=09=09return 1;
=09}

#ifdef CONFIG_XENO_OPT_PERVASIVE
=09/* If we experienced a trap on behalf of a shadow thread, just
=09   move the second to the Linux domain, so that the host O/S
=09   (e.g. Linux) can attempt to process the exception. This is
=09   especially useful in order to handle user-space errors or debug
=09   stepping properly. */

=09if (xnpod_shadow_p()) {
#if XENO_DEBUG(NUCLEUS)
=09=09if (!xnarch_fault_um(fltinfo)) {
=09=09=09xnarch_trace_panic_freeze();
=09=09=09xnprintf
=09=09=09    ("Switching %s to secondary mode after exception #%u in "
=09=09=09     "kernel-space at 0x%lx (pid %d)\n", curr->name,
=09=09=09     xnarch_fault_trap(fltinfo),
=09=09=09     xnarch_fault_pc(fltinfo),
=09=09=09     xnthread_current_user_pid(curr));
=09=09=09xnarch_trace_panic_dump();
=09=09} else if (xnarch_fault_notify(fltinfo))=09/* Don't report debug trap=
s */
=09=09=09xnprintf
=09=09=09    ("Switching %s to secondary mode after exception #%u from "
=09=09=09     "user-space at 0x%lx (pid %d)\n", curr->name,
=09=09=09     xnarch_fault_trap(fltinfo),
=09=09=09     xnarch_fault_pc(fltinfo),
=09=09=09     xnthread_current_user_pid(curr));
#endif /* XENO_DEBUG(NUCLEUS) */
=09=09if (xnarch_fault_pf_p(fltinfo))
=09=09=09/* The page fault counter is not SMP-safe, but it's a
=09=09=09   simple indicator that something went wrong wrt memory
=09=09=09   locking anyway. */
=09=09=09xnstat_counter_inc(&curr->stat.pf);

=09=09xnshadow_relax(xnarch_fault_notify(fltinfo),
=09=09=09       SIGDEBUG_MIGRATE_FAULT);
=09}
#endif /* CONFIG_XENO_OPT_PERVASIVE */
#endif /* __KERNEL__ */

=09return 0;
}
EXPORT_SYMBOL_GPL(xnpod_trap_fault);


The only way for me to bypass the error Xenomai: suspending kernel thread 7=
f8c2cb8 ('xxxx') at 0x7f89d6e8 after exception #0x8
Was to comment out the section given below and everything works ok.

/*=09if (!xnpod_userspace_p()) {
=09=09xnprintf
=09=09    ("suspending kernel thread %p ('%s') at 0x%lx after exception #0x=
%x\n",
=09=09     curr, curr->name, xnarch_fault_pc(fltinfo),
=09=09     xnarch_fault_trap(fltinfo));

=09=09xnpod_suspend_thread(curr, XNSUSP, XN_INFINITE, XN_RELATIVE, NULL);
=09=09return 1;
=09}
*/

My question are
1) What does this function do?=20
2) why am I getting that error.
3) What is your advice or suggestion on this.

Thank you=20

Nihar Unadkat =A0
Senior Firmware Engineer
Direct: 818-444-5206
nihar@deltatau.com

OMRON DELTA TAU=20
21314 Lassen Street, Chatsworth, CA 91311
deltatau.com=20
youtube.com/DeltaTauDataSystems


