Subject: Re: pthread_cond_wait() never returns?
References: <eeaf1989-2795-d140-5311-302f61249c6c@rsi-elektrotechnik.de>
 <VI1PR05MB591783008A459B1A0E5CB5AAF66A0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <63f9cf79-5626-78b9-ed8b-f37313bbc7d9@rsi-elektrotechnik.de>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <5b549f1a-1f0c-e51b-6b1d-b252969e4fb4@web.de>
Date: Thu, 24 Oct 2019 12:20:20 +0200
MIME-Version: 1.0
In-Reply-To: <63f9cf79-5626-78b9-ed8b-f37313bbc7d9@rsi-elektrotechnik.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Leupold <leupold@rsi-elektrotechnik.de>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 24.10.19 10:09, Jan Leupold via Xenomai wrote:
> Great, now it works, thanks a lot!!
>
> I just realised that not locking the mutex for pthread_cond_signal() is =
not
> a good practice
> (https://stackoverflow.com/questions/4544234/calling-pthread-cond-signal=
-without-locking-mutex)
> ... but as it works most of the time with non-Xenomai pthread_cond_t it
> might be worth a comment in
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt_=
_api__cond.html
> and/or
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_To_Xenomai_POSIX#st=
atic-mutex-and-condition-variables-initializations

The primary issue of you pattern is that is lacks a condition check
against a shared state. The whole point of the mutex is to protect that
check against the update of the state.

"When using condition variables there is always a Boolean predicate
involving shared variables associated with each condition wait that is
true if the thread should proceed. Spurious wakeups from  the
pthread_cond_timedwait() or  pthread_cond_wait()  functions  may  occur.
 Since  the return from pthread_cond_timedwait() or pthread_cond_wait()
does not imply anything about the value of this predicate, the predicate
should be re-evaluated upon such return."

Jan

