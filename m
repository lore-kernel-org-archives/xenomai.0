From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
Date: Mon, 20 Mar 2006 11:42:27 -0300
References: <44172B67.2000609@domain.hid> <441E9698.5080506@domain.hid>
	<441EAD78.3030007@domain.hid>
In-Reply-To: <441EAD78.3030007@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603201142.27591.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Philippe Gerum wrote:
>...
>Given the description above, just that some skin might return either
>nucleus ticks or corrected timestamps to the applications, which would
>in turn do some arithmetics for converting values they got from the skin
>between both scales internally, and mistakenly use the result while
>assuming that both scales are always in sync. In this situation, and
>during a fraction of the time (i.e. the jitter), both scales might not
>be in sync, and the result would be unusable.

But I still can't find a real situation where the user would need these val=
ues=20
to be in sync...

>...
>But maybe we are still discussing different issues actually, so it would
>be useful that the core issue that triggered the discussion about
>periodic mode precision be exposed again.

The core issue is that:
I think the driver development should be kind of independent from the user =

programs. That said, if the driver needs a precise timestamp, it should be =

able to get it, even if the user is fine with a, say, 100ms periodic tick. =
If=20
the user have a loop with a deadline of 100ms, and if it takes two=20
consecutive images for estimating speed in the same loop, the user will nee=
d=20
to have a higher precision timestamps for the images. So, the driver will=20
need a high precision timer reading for making possible to provide those=20
timestamps...

I hope that was what you were asking for...

Regards,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


