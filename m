References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
 <52cbdb82-5281-37fc-636d-5219950b77f0@siemens.com>
 <383c055b-6809-c073-ad67-0e5558c8c5b1@alstefgroup.com>
 <a7a3f0d6-18a9-f836-31ce-ab7dcfccd5ce@siemens.com>
From: Philippe Gerum <philippe.gerum@ixblue.com>
Subject: Re: [PATCH 00/31] Update fec driver for xenomai 3 and linux kernel
 5.4 and add I.MX8 support
In-reply-to: <a7a3f0d6-18a9-f836-31ce-ab7dcfccd5ce@siemens.com>
Date: Mon, 14 Jun 2021 08:55:05 +0200
Message-ID: <87bl896ily.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jean-Baptiste =?utf-8?Q?Tr=C3=A9dez?= <jean-baptiste.tredez@alstefgroup.com>, xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.06.21 19:00, Jean-Baptiste Tr=C3=A9dez wrote:
>> Le 04/06/2021 =C3=A0 11:14, Jan Kiszka a =C3=A9crit :
>>> On 11.05.21 18:05, Jean-Baptiste Tr=C3=A9dez via Xenomai wrote:
>>>> Update fec driver for xenomai 3 and linux kernel 5.4 and add I.MX8
>>>> support
>>>>
>>>> Patch  1 to 27 : rtnet-mcast+vlan branch from Philippe Gerum with
>>>> updated driver for 4.18.85 kernel
>>> May I assume that submission of this branch has been coordinated between
>>> you two, and Philippe considers them ready as well? Some patches lack
>>> descriptions, and maybe I will find more things that should be adjusted
>>> first. Will you address them then, Jean-Baptiste?
>>>
>>> Jan
>>=20
>> I rebased the work on fec driver with the rtnet-mcast+vlan branch on
>> next, as suggested by Philippe, and added separated patch (patch 30 and
>> 31) to show what i would like to change on previous work and added patch
>> 28 and 29 to upgrade to 5.4.x kernels.
>>=20
>> I will address your findings on the fec driver and test it with a 5.4
>> kernel on our target. I am not very familiar with the multicast and vlan
>> work, if the work is not ready, i can submit the fec driver without the
>> mcast+vlan work.
>>=20
>
> Then it's better to split that, also the make the series smaller and,
> thus, easier to digest for me.
>

A bit of context to clarify:

I submitted the multicast and vlan series for inclusion in 3.x two years
ago [1], but it could not make it into the 3.1 series due to bad timing
(release date too close) and lack of time for the review process
basically. Since then, it has been in use in lab configuration at
iXblue, so far so good.

This series is a port to Xenomai 3.1 of a work Gilles did on top of
2.6.5 back in 2015. This original work is production software since
then.

[1] https://xenomai.org/pipermail/xenomai/2019-March/040588.html

--=20
Philippe.

