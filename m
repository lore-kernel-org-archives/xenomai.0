Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <oq1trzkztv.fsf@merlin.sez.to>
Date: Fri, 29 Aug 2014 21:01:08 -0400
Message-Id: <9BDC8606-00F8-4532-9EDD-D78BADC08E9C@gatech.edu>
References: <7DEE8379-159F-470A-B22D-01B16FBEECB3@gatech.edu>
 <oq1trzkztv.fsf@merlin.sez.to>
Content-Type: text/plain;
	charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Analogy PCI Slot issues?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>
Cc: xenomai@xenomai.org

> What happens if you use "1,10" or "0x1,0x0a=94?=20

I=92ve tried 0x1, 0x0a, and 0xa - but no luck. All result in same error. =
I have not tried 1,10. I=92ll see if I can and get back to you guys.

For now - not providing a bus address works perfectly.

Yogi

On Aug 29, 2014, at 12:47 PM, Paul Janzen <pcj@xenomai.sez.to> wrote:

> "Yogi A. Patel" <yapatel@gatech.edu> writes:
>=20
>> We run $ sudo analogy_config analogy0 analogy_ni_pcimio 0x1,0a=20
>>=20
>> and get: $ analogy_config: attach failed err=3D-2 ERROR: Analogy =
device loading failed.
>=20
> What happens if you use "1,10" or "0x1,0x0a"?=20
>=20
> analogy_config uses strtoul to parse options, and "0a" is not a format
> that strtoul will recognize.
>=20
> (It would try to parse it as octal, because it starts with a leading
> 0, but "a" is not a valid octal digit.)
>=20
> -- Paul

