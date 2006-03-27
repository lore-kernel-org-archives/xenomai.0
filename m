From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] rt-video interface
Date: Mon, 27 Mar 2006 11:47:32 -0300
References: <200603201715.08482.lbocseg@domain.hid>
	<200603211434.03185.lbocseg@domain.hid> <442663AB.2070001@domain.hid>
In-Reply-To: <442663AB.2070001@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603271147.32774.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Em Domingo 26 Mar=3DE7o 2006 06:49, Jan Kiszka escreveu:

>...
>Maybe derived a subset from the full V4L2 API is the way to go. But
>let's wait if you discover other interface designs.

Actually, my priorities changed again... I'll need to finish (start actuall=
=3D
y)=3D20
an application using the camera in a hard real-time context for writing=3D20
another article for RTSS (http://www.rtss.org) that will happen in Brazil=
=3D20
this year. Hope to see some of you here if my article is approved. Then I=
=3D20
will come back to my interface designs research...

>...
>> This method also requires poll and select to be implemented in V4L2. We
>> should discuss how to deal with it if we stick with the V4L2 variant ide=
=3D
a.
>
>Hmm, what file descriptors have to be monitored in parallel so that
>poll/select is required?

I didn't really understand why should poll/select be required, but the auth=
=3D
or=3D20
says it is too important to be optional... We should ask him why ;) Anyway,=
=3D
=3D20
there are more efficient ways for monitoring a buffer state and wait for=3D=
20
events in RTDM. I don't think we should use poll/select anyway...

>...
>> Which vision applications do you have in mind?
>
>So far "only" a subset of your scenario: One of my colleagues needs to
>synchronise frame timestamps with timestamps of other input, from range
>sensors e.g. The actually processing is not (yet?) hard RT, but the
>input synchronisation is essential.

I think that the timestamp provided by the interface is enough, don't you=
=3D20
think?

Best Regards,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



