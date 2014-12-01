References: <5389961F-2DC1-43AA-8FEA-2BD0D3A61B7E@gmail.com>
 <20141201073130.GQ2964@hermes>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20141201073130.GQ2964@hermes>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AF1E090-0090-49C9-B83C-91367661CD11@gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Date: Mon, 1 Dec 2014 06:59:22 -0600
Subject: Re: [Xenomai] Performance monitoring question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Perfect.  Thanks.

Sent from my Packard Bell 386

On Dec 1, 2014, at 1:31 AM, Gilles Chanteperdrix <gilles.chanteperdrix@xenom=
ai.org> wrote:

> On Sun, Nov 30, 2014 at 10:39:56PM -0600, Mathew Benson wrote:
>> I'm using the native skin. I understand there are things you can
>> do to cause a user space task to fall back to the normal Linux
>> scheduler. How do I know if this has happened? Will RT functions
>> like semaphores fail with an incorrect mode failure?
>=20
> No, Xenomai automatically switches user-space tasks to primary or
> secondary mode when needed.
>=20
>> Can I register a callback to be notified?
>>=20
>> I'm asking because I added code to my project fully expecting it
>> to kick it back to normal scheduler or cause timers to fail, but
>> nothing. Everything still seems to be working just fine.
>> Specifically, I'm making ioctl calls to access a webcam. So what
>> can I do to verify that my tasks really are running on the rt
>> scheduler?
>=20
> See:
> http://xenomai.org/2014/06/finding-spurious-relaxes/
>=20
> --=20
>                        Gilles.

