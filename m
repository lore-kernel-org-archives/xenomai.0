References: <5641F09E.3040608@free.fr>
 <20151110142814.GA4629@hermes.click-hack.org> <564318FF.4030007@siemens.com>
 <56432BF5.3000606@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56433451.5030009@xenomai.org>
Date: Wed, 11 Nov 2015 13:28:01 +0100
MIME-Version: 1.0
In-Reply-To: <56432BF5.3000606@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] panic macro interference with xerces api.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, =?UTF-8?Q?St=c3=a9phane_ANCELOT?= <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/11/2015 12:52 PM, Philippe Gerum wrote:
> On 11/11/2015 11:31 AM, Jan Kiszka wrote:
>> On 2015-11-10 15:28, Gilles Chanteperdrix wrote:
>>> On Tue, Nov 10, 2015 at 02:26:54PM +0100, St=E9phane ANCELOT wrote:
>>>> Hi,
>>>>
>>>> I don't know if there might be a  big impact, but I noticed, depending=
=20
>>>> on the order we include headers , that
>>>> there was a panic macro interfering with xercesc api headers.
>>>>
>>>> #include <alchemy/task.h>
>>>> #include <xercesc/dom/DOMException.hpp>
>>>>
>>>>
>>>> /usr/xenomai-3.0-igb/include/boilerplate/ancillaries.h:64:10: error:=20
>>>> expected identifier before '__func__'
>>>>    __panic(__func__, __fmt, ##__args)
>>>
>>> Well, if the two headers define the same macro, there are not many
>>> solutions: arrange for not having to include them in the same file.
>>> It should not be too hard, since a real-time thread using
>>> alchemy/task.h has no business using an xml library, probably only
>>> using linux services which a real-time task can not use without
>>> switching to secondary mode.
>>
>> Isn't *panic an internal service? Then we can maybe avoid that it is
>> exposed to applications. If it's not internal, it should probably carry
>> some "xenomai" prefix in its (fairly generic) name.
>>
>=20
> Sure, this service is aimed at being fairly generic and general-purpose,
> with backtracing support, timing data, error code translation and such.
> With respect to layering, I would rather expect an XML lib not to mess
> with the namespace of core services, instead of asking the xenomai libs
> which do deliver core services to apps to prefix its own services.
>=20
> I may move those helpers in some specific file to hide them, but no, I
> really don't want to go for xenomai_panic(), because it really should
> work the other way around (although nobody is likely to care about this
> on the apache side).
>=20

Actually, the only issue is about defining the panic helpers as macros,
so that we can pull the source/line information automatically. The
namespace issue should not affect C++.

--=20
Philippe.

