Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <53EA690E.50101@xenomai.org>
Date: Sat, 16 Aug 2014 16:59:00 -0400
Message-Id: <62F8D98A-B570-40B9-80D2-E06866C75693@gatech.edu>
References: <D36F9745-B497-4700-8BDC-92281227E1D4@gatech.edu>
 <53EA690E.50101@xenomai.org>
Content-Type: text/plain;
	charset=windows-1252
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Will this approach work with Xenomai 3.x, too?

Yogi

On Aug 12, 2014, at 3:20 PM, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:

> On 08/12/2014 08:56 PM, Yogi A. Patel wrote:
>> Hi -
>>=20
>> I am interested in using Xenomai with multiple cores. When I run =93cat=

>> /proc/cpuinfo | grep =93model name=94 I see that there are two CPUs
>> listed.
>>=20
>> My system using data acquisition from a NI DAQ (using ANALOGY
>> driver), processes it with some model, and then provides some output
>> through the NI DAQ.
>>=20
>> I would like to make the system faster (both real-time and
>> computation) by off loading the acquisition and data processing parts
>> to one CPU and then letting the user interactions and the GUI
>> (Qt-based) processed by the other CPU.
>>=20
>> Is this possible? If so, any examples on how to do this?
>=20
> Xenomai never migrates a thread running in primary mode, so the job of
> deciding on which cpu to run a task is left to Linux. So, simply use
> sched_setaffinity to decide on which cpu to run a thread.
>=20
> --=20
>                                                                Gilles.

