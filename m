From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 2 Oct 2017 14:25:28 +0000
Message-ID: <DB6PR0701MB2456EC4E9CD10826927A4E8EB57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB24567885F171F1129C2FCE61B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <b7c66b27-ccc4-d1d0-56ed-1925514868b0@xenomai.org>
In-Reply-To: <b7c66b27-ccc4-d1d0-56ed-1925514868b0@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] The task calling pthread_cond_signal() has to own the
 lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> libcobalt enforces the requirement to hold the lock so that optimizing
> the wake up process is possible - under the assumption that the caller
> owns the lock. There is no hack around this.

Then I would suggest that pthread_cond_signal() should return an error code=
 if the caller does not own the mutex. Currently it returns 0 (success), wh=
ich is pretty confusing. I am happy to help bringing the documentation up t=
o date once this is done.

Am I right to say that the waiting thread will only be unblocked after the =
lock has been released from the calling thread, thus avoiding a potential d=
eadlock situation?

Thanks,
Giulio=

