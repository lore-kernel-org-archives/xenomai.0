Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Maximum number of realtime tasks
Date: Tue, 31 Oct 2006 12:15:32 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0144D632@domain.hid>
In-Reply-To: <45473968.2070906@domain.hid>
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

> Setting the stack size with pthread_attr_setstacksize seems to allow
> a stack greater than the limit fixed by ulimit, but I do not think it
> is wise to rely on such a behaviour. =20

If one wants to have always the same stack size for every thread than
ulimit -s would be probably the way to go. But often in Realtime
applications it is the preferred way of setting  the stack size
individually, so one doesn't waste too much memory. A mixture of both
seems to be tempting: setting a general stack size and individually
change it. So why not rely on this ? Which part in the system actually
creates the stack for a Xenomai task and how is the interaction between
Linux and Xenomai to derive the general system wide stack limit to a
Xenomai task ?

Is there a way to find out, which thread has which stack size ?

Daniel

