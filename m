Message-ID: <2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>
Date: Tue, 8 Jan 2008 11:23:30 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <14854214.1199776626079.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <14854214.1199776626079.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] posix functions for real time and non real time
	threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Jan 8, 2008 8:17 AM, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> Hi everybody,
>
> I have a fairly huge application that consists of several real time threads and several non real time (posix) threads.
> For the non real time threads I use the pthread_create function and e.g. the pthread_mutex_lock/unlock functions to
> synchronize them.
> Is it possible to use the Xenomai Posix skin for real time threads as well?
> When linking against pthread_rt and pthread I have two "variants" of e.g. pthread_create. One to be used for real
> time threads and one for the non real time threads. How are they distinguished?
> How can I define to create a real time task using pthread_create and how can I define to create a non real time task
> using pthread_create.

In fact, linking agains pthread_rt is not enough to use Xenomai posix
skin real-time services, in order to get the real-time pthread_create,
you have to add to the link flags of your application
-Wl,--wrap,pthread_create. Note that you do not have to pass the
--wrap yourself, xeno-config --posix-ldflags will pass all the --wrap
flags.

Once you pass the -Wl,--wrap,pthread_create to gcc, all calls to
pthread_create in your code are replaced with calls to
__wrap_pthread_create, and all calls to __real_pthread_create are
replaced with calss to the original, non wrapped, pthread_create.

So, when an application is compiled for Xenomai posix skin, the
pthread_* services are the real-time services, and the
__real_pthread_* services are non real-time services.

-- 
                                               Gilles Chanteperdrix

