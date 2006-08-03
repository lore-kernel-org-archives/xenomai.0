Message-ID: <44D1C326.4080906@domain.hid>
Date: Thu, 03 Aug 2006 11:34:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Future of Xenomai's RTDM driver repository
References: <44D07C4E.4040200@domain.hid> <44D1ACB8.3090906@domain.hid>
In-Reply-To: <44D1ACB8.3090906@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCE54CF69ED18624F9937D6C2"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE54CF69ED18624F9937D6C2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> instead of replying directly to Wolfgang's announcement of their great=

>> CAN stack I take the chance to start a generic thread on the future of=

>> RTDM drivers *within* Xenomai.
>>
>> If you look at the real-time Linux scene now and in the past, you may
>> find it fairly scattered. Specifically precious Open Source drivers ar=
e
>> hard to find, not always up-to-date, or not ported to your favourite
>> kernel/RT-patch. Just check how many CAN driver projects for how many =
RT
>> APIs are out there. There are even a few hardware vendors providing
>> driver packages for real-time Linux, others offer at least some kind o=
f
>> "reference code", but many nothing at all. Sad but true for _many_ yea=
rs.
>>
>> RTDM came into play to provide a common ground for real-time driver
>> development under Linux. It is already utilised by quite a few
>> stand-alone driver projects and even vendor drivers. But as resources
>> are limited, maintenance is tricky, and testers are rare, we should
>> consider concentrating driver development efforts more intensively. I'=
m
>> convinced such concentration should primarily happen within the Xenoma=
i
>> driver repository.
>>
>> Xenomai has the unique potential to provide a real-time framework for
>> both the co-scheduling approach and for the native RT-Linux environmen=
t
>> that Preempt-RT will probably push into mainline one day. And Xenomai =
is
>> also a sound foundation for the tricky 2.4/2.6 support scenario.
>>
>> Here are the concrete advantages I see in maintaining drivers *inside*=

>> Xenomai:
>>
>>  o Better visibility (did you know that there is a working FireWire
>>    stack for Xenomai?)
>>  o Better testing, also across architectures, due to more users (this
>>    applies to the drivers, but also to RTDM and Xenomai in all)
>>  o Closer to the latest RTDM development
>>  o Wrapping environments for changing kernel interfaces (2.4/2.6 etc.)=

>>  o In-kernel build
>>  o Simpler build system (look at RTnet...)
>>  o Single, integrated package, thus less breakages due to version
>>    mismatches
>>
>> Of course, there are also certain critical topics that need to be
>> resolved first:
>>
>>  o Clear acceptance rules
>>     - Maintenance commitment: "dump-and-run" will not scale. Unless
>>       there is already a community behind it, complex drivers need
>>       people to look after them. Dead/unused drivers should get moved =
in
>>       some corner after a while.
>>     - Coding style: Should simply be kernel style (though I personally=

>>       hate tabs).
>>     - Documentation: New RTDM profiles as well as the drivers themselv=
es
>>       must contain "some words" (surely a more softish requirement).
>>     - Test cases, test conformance: Drivers should provide some simple=

>>       tests or, if once available, conform to existing tests for their=

>>       RTDM profiles.
>>  o Repository organisation
>>     - Where to keep utilities (Wolfgang raised this as well)? Should a=

>>       "rtcanconfig" come with Xenomai, as a separate package of
>>       rt-utils, or as package of its own?
>>     - Where to put test cases? Distribute them separately?
>>     - Where to collect usage examples? This is actually a generic
>>       question, also for the skins (I think the current situation is
>>       a bit unsatisfactory).
>>  o Support organisation
>>       Simple drivers can certainly be managed via xenomai-help, existi=
ng
>>       communities will continue to use their own forums, but what abou=
t
>>       new subsystems? I could imagine introducing some
>>       xenomai-SUBSYSTEM@gna.org lists for them, Philippe suggested
>>       simply xenomai-drivers which is likely already sufficient.
>>
>> Now I would suggest to look at RTCAN (or what it will be called in the=

>> end) and to discuss on this first concrete example how we can proceed
>> towards the sketched goal.
>>
>> Looking forward to your feedback!
>=20
> As you have said, maintaining a RTDM driver within the Xenomai
> repository clearly has some advantages but it also puts more burden ont=
o
> the Xenomai maintainers and some developers might even prefer to keep
> thing separated. Therefore I suggest a simple RTDM add-on framework to
> support external RTDM drivers as well. They could be announced and
> listed on the Xenomai home page and then it would alsl be visible that
> there is a FireWire stack for Xenomai.

Yes, this way still remains open. RTnet, e.g., would be a candidate to
remain separate for a while or even longer.

OTOH, if you look at the relation between RT-Firewire and RTnet (RTnet
requires RT-Firewire to build its rt_eth1394 driver), you can see that
this can quickly become complicated, specifically from the build system
POV. Or think about some comedi driver for an USB DAQ that may want to
work over USB4RT in the future...

>=20
> What I had first was a add-rtdm-driver.sh, a modified version of
> Philippe's prepare-kernel.sh script, to add the RTDM driver to the
> kernel tree. Similarly, as script could be used to add "loosely" the
> driver to Xenomai.

This is something we could consider, but it is feasible only for the
plain drivers (no utils integration). Moreover, it requires the
existence of some profile header in include/rtdm/ because such
integration script will not be able to patch the automake system as well
(no one should be forced to run bootstrap to compile a driver against
Xenomai).

>=20
> What do you think?

Enhanced out-of-tree driver integration can help to simplify separately
maintained RTDM driver projects, that's true. But it still only provides
half of the advantages that I listed above for fully integrated drivers.

There is an extra burden on Xenomai, for sure. E.g. the coordination of
releases will need to become more formally once the driver repos grows.
But I think the gain for all involved parties, the users, the driver
developers, and Xenomai itself will compensate this.

Jan


--------------enigCE54CF69ED18624F9937D6C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0cMmniDOoMHTA+kRAgSRAJ0RpG7oqX8pwQehs6ODzeslMeMpnwCfYDkr
GL8IlSX2HKLGDVoN4YGOXgk=
=UDcf
-----END PGP SIGNATURE-----

--------------enigCE54CF69ED18624F9937D6C2--

