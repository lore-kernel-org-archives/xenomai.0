Message-ID: <50FEDBC4.8080801@xenomai.org>
Date: Tue, 22 Jan 2013 19:34:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1Etoj3AxmFr1=5Osf9nsb576_c9e9V_oEsHafMTe=4Hs_uyw@mail.gmail.com>
In-Reply-To: <CAD1Etoj3AxmFr1=5Osf9nsb576_c9e9V_oEsHafMTe=4Hs_uyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt
 used by debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the
 libraries. ... et al.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 01/22/2013 06:07 PM, Daniel M. Drucker, Ph.D. wrote:

> As noted by Andy yesterday, we've been having problems with Xenomai + i915,
> and it was suggested that we try using 2.6.2+3.5.7. I'm trying to build
> that combination now, using the git head (because the 2.6.2 tag has an
> error that prevents a deb from being built).
> 
> My build process is:
> git clone git://git.xenomai.org/xenomai-head.git
> cd xenomai-head
> DEBEMAIL="dev@interactive-motion.com" DEBFULLNAME="dev" debchange -v
> 2.6.git Release 2.6.git
> debuild -uc -us
> 
> [ lots of build messages here, and then: ]
> 
> dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
> debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
> debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current_mode used by
> debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current used by
> debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_sigshadow_install_once used by
> debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_map_heap used by
> debian/libxenomai1/usr/lib/libvrtx.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
> debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
> debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current_mode used by
> debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current used by
> debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_sigshadow_install_once used by
> debian/libxenomai1/usr/lib/libvxworks.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
> debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
> debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current_mode used by
> debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current used by
> debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_sigshadow_install_once used by
> debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_fault_stack used by
> debian/libxenomai1/usr/lib/libuitron.so.0.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol nkvdso used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_print_auto_init used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_sem_heap used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_vsyslog used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_fputs used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_puts used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_vfprintf used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xnarch_tsc_to_ns used by
> debian/libxenomai1/usr/lib/libpthread_rt.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: 13 other similar warnings have been skipped (use
> -v to see them all).
> dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xnarch_tsc_to_ns used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_sem_heap used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xnarch_ns_to_tsc used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current_mode used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_current used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_sigshadow_install_once used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_map_heap used by
> debian/libxenomai1/usr/lib/libnative.so.3.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: 2 other similar warnings have been skipped (use -v
> to see them all).
> dpkg-shlibdeps: warning: symbol rt_dev_close used by
> debian/libxenomai1/usr/lib/libanalogy.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_dev_write used by
> debian/libxenomai1/usr/lib/libanalogy.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_dev_read used by
> debian/libxenomai1/usr/lib/libanalogy.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_dev_ioctl used by
> debian/libxenomai1/usr/lib/libanalogy.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol rt_dev_open used by
> debian/libxenomai1/usr/lib/libanalogy.so.1.0.0 found in none of the
> libraries.
> dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
> debian/libxenomai1/usr/lib/librtdm.so.1.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_bind_skin_opt used by
> debian/libxenomai1/usr/lib/libpsos.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_handle_mlock_alert used by
> debian/libxenomai1/usr/lib/libpsos.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current_mode used by
> debian/libxenomai1/usr/lib/libpsos.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_set_current used by
> debian/libxenomai1/usr/lib/libpsos.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_sigshadow_install_once used by
> debian/libxenomai1/usr/lib/libpsos.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_map_heap used by
> debian/libxenomai1/usr/lib/libpsos.so.0.0.0 found in none of the libraries.
> dpkg-shlibdeps: warning: symbol xeno_fault_stack used by
> debian/libxenomai1/usr/lib/libpsos.so.0.0.0 found in none of the libraries.
> 
> 
> What's going on here?


The symbols are defined in libxenomai.so, but this library is not linked
with the skins libraries in order to avoid a libtool bug when
cross-compiling. However if you user xeno-config or pkg-config to build
your applications you will not have any issue, so you can ignore this
warning.

-- 
                                                                Gilles.

