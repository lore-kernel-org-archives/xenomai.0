MIME-Version: 1.0
In-Reply-To: <50E60994.8010903@xenomai.org>
References: <CAD1EtoiVOD7KdOD7ZyqtxQ3AttD=Ca0bbsOsKOiMQtyNxm47EA@mail.gmail.com>
	<50E60647.5090309@xenomai.org>
	<CAD1EtoiFivw1qesTzEUF9Scb-uMwMaJpnw18cJJ79DJQ3tejLw@mail.gmail.com>
	<50E608CF.3020606@xenomai.org>
	<CAD1EtoiHmA1YnRcoc-vHLT6BO1A61VuP9Ey+WWnoZS_7aOmYmQ@mail.gmail.com>
	<50E60994.8010903@xenomai.org>
Date: Thu, 3 Jan 2013 17:45:35 -0500
Message-ID: <CAD1Etohn+D9+8XebcRFj09hb=tbu_PgC_Tsx0bxLwMJ8w1xAzA@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] make devices not run from deb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>
>
> What does dpkg -L libxenoma1 say?
>
>

imt@imtrobot:~$ dpkg -L libxenomai1
/.
/usr
/usr/lib
/usr/lib/libvxworks.so.1.0.0
/usr/lib/libpthread_rt.so.1.0.0
/usr/lib/librtdm.so.1.0.0
/usr/lib/libpsos.so.0.0.0
/usr/lib/libanalogy.so.1.0.0
/usr/lib/libvrtx.so.0.0.0
/usr/lib/libxenomai.so.0.0.0
/usr/lib/libnative.so.3.0.0
/usr/lib/libuitron.so.0.0.0
/usr/share
/usr/share/lintian
/usr/share/lintian/overrides
/usr/share/lintian/overrides/libxenomai1
/usr/share/doc
/usr/share/doc/libxenomai1
/usr/share/doc/libxenomai1/CREDITS
/usr/share/doc/libxenomai1/changelog.gz
/usr/share/doc/libxenomai1/README.INSTALL.gz
/usr/share/doc/libxenomai1/copyright
/usr/share/doc/libxenomai1/TROUBLESHOOTING.gz
/etc
/etc/modprobe.d
/etc/modprobe.d/xenomai.conf
/etc/udev
/etc/udev/xenomai.rules
/etc/udev/rules.d
/etc/init.d
/etc/init.d/xenomai
/usr/lib/libpsos.so.0
/usr/lib/libxenomai.so.0
/usr/lib/librtdm.so.1
/usr/lib/libanalogy.so.1
/usr/lib/libnative.so.3
/usr/lib/libvrtx.so.0
/usr/lib/libvxworks.so.1
/usr/lib/libuitron.so.0
/usr/lib/libpthread_rt.so.1
