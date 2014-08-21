Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <53F04C0A.1050303@xenomai.org>
Date: Thu, 21 Aug 2014 13:21:44 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <72378704-FEF6-466B-A5EA-595F0B6F708E@gatech.edu>
References: <D36F9745-B497-4700-8BDC-92281227E1D4@gatech.edu>
 <53EA690E.50101@xenomai.org>
 <62F8D98A-B570-40B9-80D2-E06866C75693@gatech.edu>
 <53F04C0A.1050303@xenomai.org>
Subject: Re: [Xenomai] Parallel Computing?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi -

I have been trying to figure this out - and had a similar question.

When configuring the kernel, there is an option to =93enable max number =
of cpus=94. When I enable this, the compile fails and said that there =
was an error in =93gatekeeper with set_num_cpus=94.=20

Has anyone else experienced a similar error?

Yogi

On Aug 17, 2014, at 2:30 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 08/16/2014 10:59 PM, Yogi A. Patel wrote:
>> Will this approach work with Xenomai 3.x, too?
>>=20
>=20
> Yes.
>=20
>> Yogi
>>=20
>> On Aug 12, 2014, at 3:20 PM, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:
>>=20
>>> On 08/12/2014 08:56 PM, Yogi A. Patel wrote:
>>>> Hi -
>>>>=20
>>>> I am interested in using Xenomai with multiple cores. When I run =
=93cat
>>>> /proc/cpuinfo | grep =93model name=94 I see that there are two CPUs
>>>> listed.
>>>>=20
>>>> My system using data acquisition from a NI DAQ (using ANALOGY
>>>> driver), processes it with some model, and then provides some =
output
>>>> through the NI DAQ.
>>>>=20
>>>> I would like to make the system faster (both real-time and
>>>> computation) by off loading the acquisition and data processing =
parts
>>>> to one CPU and then letting the user interactions and the GUI
>>>> (Qt-based) processed by the other CPU.
>>>>=20
>>>> Is this possible? If so, any examples on how to do this?
>>>=20
>>> Xenomai never migrates a thread running in primary mode, so the job =
of
>>> deciding on which cpu to run a task is left to Linux. So, simply use
>>> sched_setaffinity to decide on which cpu to run a thread.
>>>=20
>>> --=20
>>>                                                               =
Gilles.
>>=20
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>=20
>=20
>=20
> --=20
> Philippe.


