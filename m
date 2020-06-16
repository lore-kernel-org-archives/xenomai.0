Subject: Re: TSN support on xenomai
References: <SG2PR04MB325361212B0F13BA9DE98BC0A49D0@SG2PR04MB3253.apcprd04.prod.outlook.com>
 <263bfd52-638e-1205-dc57-c0fb773b0acf@numalliance.com>
 <dee89c0f-c026-33c2-da13-42d090f58d6c@siemens.com>
 <VI1PR05MB59171660A06A205C47F6DF3AF69D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <c244091f-127a-e3ac-8116-b3624907f17a@siemens.com>
 <SG2PR04MB3253BF73D742CF3A816C1B61A49D0@SG2PR04MB3253.apcprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ffc06274-9349-1883-3cb6-73a0d0cc0cf4@siemens.com>
Date: Tue, 16 Jun 2020 16:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <SG2PR04MB3253BF73D742CF3A816C1B61A49D0@SG2PR04MB3253.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Wong <tsnuser@outlook.com>, Lange Norbert <norbert.lange@andritz.com>, =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, "Meng, Fino" <fino.meng@intel.com>, "Pirou, Florent" <florent.pirou@intel.com>

On 16.06.20 16:00, Peter Wong wrote:
> Can we compile linuxptp (cobalt POSIX wrap) to run on RTnet=A0 + Xenomai
> I210 driver so that we only need one NIC to run TSN on RTnet?=A0
>=20

There is nothing like that upstream so far. Maybe Fino or Florent
already have some plans, though I expect them to target newer hardware.

Jan

> ------------------------------------------------------------------------
> *From:* Xenomai <xenomai-bounces@xenomai.org> on behalf of Jan Kiszka
> via Xenomai <xenomai@xenomai.org>
> *Sent:* Tuesday, June 16, 2020 5:44 PM
> *To:* Lange Norbert <norbert.lange@andritz.com>; St=E9phane Ancelot
> <sancelot@numalliance.com>; Xenomai (xenomai@xenomai.org)
> <xenomai@xenomai.org>
> *Subject:* Re: TSN support on xenomai
> =A0
> On 16.06.20 11:41, Lange Norbert wrote:
>>=20
>>=20
>>> -----Original Message-----
>>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Jan Kiszka
>>> via Xenomai
>>> Sent: Dienstag, 16. Juni 2020 10:58
>>> To: St=E9phane Ancelot <sancelot@numalliance.com>; xenomai@xenomai.org
>>> Subject: Re: TSN support on xenomai
>>>
>>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>>> ATTACHMENTS.
>>>
>>>
>>> On 16.06.20 10:55, St=E9phane Ancelot via Xenomai wrote:
>>>> Hi,
>>>>
>>>> This is natively supported in standard linux kernel
>>>>
>>>
>>> Right. What is missing it linking the Xenomai timebase with that of the=
 kernel
>>> so that we would benefit from Linux doing the sync for us already.
>>=20
>> But that means you can't use the synchronizing NIC with RTNet / Realtime=
 traffic.
>>=20
>> Regarding linking timebases, it would help (for various things)
>> If you could easily read those various timebases from the kernel. The re=
st can happen in
>> userspace.
>>=20
>> I actually have 3: Linux Monotonic, Xenomai Monotonic, and a PPS synchro=
nized IEEE1588 clock,
>> Cant fold them into one but sometimes need to map between these.
>> Solved this by letting the NIC read out all 3 and providing them to (Xen=
omai) userspace.
>>=20
>> Better would be a shared mmap (with 2 or more buffers), so that Linux ta=
sks can asynchronously get that info too.
>>=20
>=20
> Latest Intel hardware supports mapping for the PTP time to the system
> time (tsc) natively. You only need to read out the conversion factors in
> the end. That's what we want to have as well.
>=20
> If using that will create a conflict with using the NIC for RT traffic?
> Likely. But that needs to be sorted out in the future, not only on Intel =
hw.
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>=20

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

