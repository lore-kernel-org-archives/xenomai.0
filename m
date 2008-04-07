Message-ID: <2ff1a98a0804070514y4c632fbdk7fa2aedc7fdd8a31@domain.hid>
Date: Mon, 7 Apr 2008 14:14:47 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <OF4C98FBB1.81F59369-ONC1257421.00355333-C1257424.003F5EB0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <OF4C98FBB1.81F59369-ONC1257421.00355333-C1257424.003F5EB0@domain.hid>
Subject: Re: [Xenomai-core] posix-skin: unexpected scheduler behaviour
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Apr 7, 2008 at 1:32 PM, Thomas Wiedemann
<Thomas.Wiedemann@domain.hid> wrote:
> Hi folks,
>
>  i think there is a problem with the xenomai scheduler or the sched_yield()
>  call, when using the POSIX skin (Xenomai 2.4.3, Linux 2.6.24.4, SMP,
>  .config is attached).

The semantic of sched_yield() is a bit specific: it causes threads
running in primary mode to yield to other threads running in primary
mode. To get threads running in secondary mode to yield to other
threads running in secondary mode, you have to call
__real_sched_yield().

Your example is of little interest when run with Xenomai: it only
calls vanilla Linux calls, so the threads are always running in
secondary mode. Xenomai brings you nothing (except overhead) in this
configuration.

-- 
 Gilles

