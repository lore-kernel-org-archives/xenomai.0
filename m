Message-ID: <3D8E85F3.D57C292F@opersys.com>
Date: Sun, 22 Sep 2002 23:09:39 -0400
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
References: <3D8E8371.D2070D87@domain.hid> <20020923030312.GM20520@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Arnaldo Carvalho de Melo <acme@domain.hid>
Cc: linux-kernel <linux-kernel@domain.hid>, Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Arnaldo Carvalho de Melo wrote:
> Why this ifdef hell and not something like:
> 
>         lockbuf_lock();
>         bla
>         logbuf_unlock();
> 
> and have this defined in a header, say printk.h or whatever, with the
> ifdefs?

You're right, this is somewhat insane ;)

We'll fix it, thanks.

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================


