Message-ID: <53F04C0A.1050303@xenomai.org>
Date: Sun, 17 Aug 2014 08:30:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <D36F9745-B497-4700-8BDC-92281227E1D4@gatech.edu>
 <53EA690E.50101@xenomai.org>
 <62F8D98A-B570-40B9-80D2-E06866C75693@gatech.edu>
In-Reply-To: <62F8D98A-B570-40B9-80D2-E06866C75693@gatech.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Parallel Computing?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 08/16/2014 10:59 PM, Yogi A. Patel wrote:
> Will this approach work with Xenomai 3.x, too?
>

Yes.

> Yogi
>=20
> On Aug 12, 2014, at 3:20 PM, Gilles Chanteperdrix <gilles.chanteperdrix@x=
enomai.org> wrote:
>=20
>> On 08/12/2014 08:56 PM, Yogi A. Patel wrote:
>>> Hi -
>>>
>>> I am interested in using Xenomai with multiple cores. When I run =93cat
>>> /proc/cpuinfo | grep =93model name=94 I see that there are two CPUs
>>> listed.
>>>
>>> My system using data acquisition from a NI DAQ (using ANALOGY
>>> driver), processes it with some model, and then provides some output
>>> through the NI DAQ.
>>>
>>> I would like to make the system faster (both real-time and
>>> computation) by off loading the acquisition and data processing parts
>>> to one CPU and then letting the user interactions and the GUI
>>> (Qt-based) processed by the other CPU.
>>>
>>> Is this possible? If so, any examples on how to do this?
>>
>> Xenomai never migrates a thread running in primary mode, so the job of
>> deciding on which cpu to run a task is left to Linux. So, simply use
>> sched_setaffinity to decide on which cpu to run a thread.
>>
>> --=20
>>                                                                Gilles.
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>=20


--=20
Philippe.

