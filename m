Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] pthread_setname_np
Date: Wed, 15 Nov 2006 13:31:49 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0154EF61@domain.hid>
In-Reply-To: <455B11AC.7000300@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

Gilles Chanteperdrix wrote:

> I tested pthread_set_name_np with the "switchtest" program on x86 and
> ARM, and it works. Could you run switchtest on your platform and see
> if the information in /proc/xenomai/sched is correct ? =20

The switchtest program works here correctly as well. Looking at the
switchtest code I found out that one has to call this function _after_
one has actually created the thread with pthread_create() not like
pthread_attr_setXXXX() functions which have to be called before. After
changing the order in my code, it worked there as well.

Is this behaviour intended ?

Best regards,

Daniel Schnell.

