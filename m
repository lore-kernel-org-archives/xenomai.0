MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Mon, 9 Mar 2009 10:20:49 -0400
Message-ID: <1236608449.3587.32.camel@domain.hid>
From: "Andreas Glatz" <AndreasGlatz@domain.hid>
Subject: [Xenomai-core] rt_queue_create in RT task?
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

Hi,

Calling rt_queue_create in a real-time task is supposed to fail
according to the documentation.=20

I found out, that the reason for this is, that the memory for=20
the queue memory pool is allocated with vmalloc/kmalloc.=20
Is there another reason?

I still would like to be able to call rt_queue_create in a=20
real-time task in my activity of porting real-time applications
to Xenomai because I think that patching rt_queue_create would
be less time consuming than redesigning the applications.

My approach to get there would be to split rt_queue_create into=20
two separate functions, one that allocates the memory pool
and another one which initializes the queue structure...=20

Best regards,
Andreas


=20

