References: <CA+C+_XQi7Nji4Ecq2VH4KfVxRdtWouE4=APu4bhfo8Yk4dZ-Zg@mail.gmail.com>
 <20150107101233.GC31996@hermes.click-hack.org>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20150107101233.GC31996@hermes.click-hack.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FCA47A3-7859-424A-B427-B2C45939C567@gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Date: Wed, 7 Jan 2015 05:06:43 -0800
Subject: Re: [Xenomai] Resource utilization
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Heap utilization, cache faults, page faults, BSS size, thread stack high wat=
er mark, context switch count, kernel objects in use, etc...  Thanks.  I for=
got about VFS nodes.

Sent from my iPad

> On Jan 7, 2015, at 2:12 AM, Gilles Chanteperdrix <gilles.chanteperdrix@xen=
omai.org> wrote:
>=20
>> On Tue, Jan 06, 2015 at 10:20:04AM -0600, Mathew Benson wrote:
>> First, I'd like to thank all contributors for Xenomai.  I'm an embedded
>> software engineer accustomed to working with the more expensive closed
>> RTOSs.  So far, I'm really happy with Xenomai.
>>=20
>> Second, is there a mechanism to monitor resource utilization from user
>> space?  My application used to measure CPU idle time by busy waiting and
>> counting in a low priority thread.  Not the best solution, but usually ve=
ry
>> portable.  However, the nucleus detects the Linux kernel is getting starv=
ed
>> and flags it as a failure.
>=20
> You will get the same information with /proc/xenomai/stat
>=20
>=20
>> I could move this thread to secondary mode, but
>> I would rather use a native API if one exists.
>=20
> That would be another information (the first information is xenomai
> load, the second information is the total load). For this
> information, your approach is the only available.
>=20
>>=20
>> Similar to the previous question, what other metrics are
>> available?
>=20
> other metrics?
>=20
> --=20
>                        Gilles.

