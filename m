From: Alex Plits <alex_plits@radwin.com>
Date: Tue, 23 Aug 2016 17:14:16 +0000
Message-ID: <DB6PR0601MB21674058568F45BD554818828FEB0@DB6PR0601MB2167.eurprd06.prod.outlook.com>
References: <447fdp9oue.fsf@be-well.ilk.org>
 <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
 <441t3rlwfe.fsf@be-well.ilk.org>
 <20160620152246.GA18662@hermes.click-hack.org>
 <44wpljkchx.fsf@be-well.ilk.org>
 <20160620171848.GB18662@hermes.click-hack.org>
 <44h9cmz8y1.fsf@be-well.ilk.org> <44eg7i1x8y.fsf@be-well.ilk.org>
 <44ziq6ze1c.fsf@be-well.ilk.org>
 <CAMcKmiFjiUv7bChKbVgwKg-Nx7aFqy3=H6ph55Vcv98cOSXexQ@mail.gmail.com>
In-Reply-To: <CAMcKmiFjiUv7bChKbVgwKg-Nx7aFqy3=H6ph55Vcv98cOSXexQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <brozgeo@gmail.com>, Lowell Gilbert <kludge@be-well.ilk.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Had the same issue (ARMv7/Cobalt/3.0.2), did not find any solution, fail ba=
ck to debugging using the SIGDEBUG signaling catching.

Best Regards,
Alex Plits.

-----Original Message-----
From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of George Broz
Sent: =E9=E5=ED=A0=E2 23 =E0=E5=E2=E5=F1=E8 2016 04:35
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] slackspot

> Lowell Gilbert <kludge@be-well.ilk.org> writes:
>
>> Lowell Gilbert <kludge@be-well.ilk.org> writes:
>>
>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
>>>> Ok. Could you post an example allowing us to reproduce the issue ?
>>>
>>> I can. It took me a little longer than I figured because I had=20
>>> accidentally deleted the MODULE_LICENSE. Is it possible to get the=20
>>> kernel makefiles to tell you *why* it isn't linking in libraries you=20
>>> asked for?
>>
>>>  http://be-well.ilk.org/~lowell/example.tar
>>> It's about a hundred lines each for the application and kernel module.
>>
>> Has anyone tried this out? My real application is meeting its latency=20
>> requirements, but I'm pretty sure it's having more of an impact on=20
>> the rest of the system than it needs to do.
>
> I've tried changing the event to a semaphore, and changing the "read"
> ioctl to a device read, and I'm still seeing huge numbers of state switch=
es.

Hi Lowell,

Did you ever figure out how to get slackspot working? I'm experiencing the =
same issue - debug/relax is empty but the MSW counter is regularly incremen=
ting for my Xenomai application. Using 3.0.2 on ARM. Enabled XENO_.._TRACE_=
RELAX in the kernel and set PTHREAD_WARNSW on the task. Any help appreciate=
d.


Thanks,
--George

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

