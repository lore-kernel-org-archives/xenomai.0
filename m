Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] pthread_setname_np
Date: Wed, 15 Nov 2006 14:26:23 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0154EFA2@domain.hid>
In-Reply-To: <455B1966.10609@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix wrote:

>> The switchtest program works here correctly as well. Looking at the
>> switchtest code I found out that one has to call this function
>> _after_ one has actually created the thread with pthread_create()
>> not like pthread_attr_setXXXX() functions which have to be called
>> before. After changing the order in my code, it worked there as well.
>>=20
>> Is this behaviour intended ?
>=20
> pthread_set_name_np requires a pthread_t argument, and returns ESRCH
> if this argument is invalid. It is supposed to be documented at:
>
http://www.xenomai.org/documentation/trunk/html/api/group__posix__thread
.html#g414a759c928f7be7ac105980d8e73431

Yes it is documented and one can guess that the function only should be
called for a valid thread, i.e. a thread that is already created by
reading the part of the documentation which mentions the error code.

But as this is a non standard function and normally for Posix threads
one expects to specify all attributes before spawning a thread (compare
also pthread_attr_setname_np()), maybe one should add a sentence in the
documentation, stating that this function is only valid for an already
running thread.

Btw. Is there a reason why the call to pthread_attr_setname_np() is
limited to kernel space ?

Best regards,

Daniel Schnell.

