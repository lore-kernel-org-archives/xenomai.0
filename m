Date: Tue, 10 Nov 2015 11:21:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151110102103.GA11824@hermes.click-hack.org>
References: <5641A442.80201@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5641A442.80201@free.fr>
Subject: Re: [Xenomai] safely terminate application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?Q?St=E9phane?= ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Nov 10, 2015 at 09:01:06AM +0100, St=E9phane ANCELOT wrote:
> Hi,
>=20
> I have got some problems terminating my RT application, I have very=20
> strange behavours.
> either locking application, either TERMINATE signal does not seem being=20
> propagated.
>=20
> I am using a SIGTERM handler to call a cleanup func to delete everything.

This is a bad solution. Most functions, including cleanup functions
like, say, pthread_mutex_destroy, are not "async-signal-safe", they
can not be called from the context of a signal handler. For this
reason, using signals with threaded applications is hard to get
right.

For instance, the "printf" function uses a mutex to protect
concurrent access to the underlying FILE *. If a signal handler
calls printf on a thread which had the mutex locked because it was
in the middle of a printf, you get a deadlock.


>=20
> I noticed that if I delete nothing , it seems to quit fine (altough=20
> there may be lot of memory leaks,etc...)

No, there will not be any memory leak. The memory reserved by an
application is automatically returned to the system when the
application terminates. On the Xenomai side, all Xenomai objects
created by your application are destroyed automatically.

--=20
					    Gilles.
https://click-hack.org

