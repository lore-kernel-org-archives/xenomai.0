From: Sripath Roy Koganti <koganti_sripathroy@kluniversity.in>
Date: Sun, 4 Sep 2016 10:14:47 +0000
Message-ID: <SG2PR01MB123080E8CF4DBBDE8EAF43BCFFE70@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB1230494FDA7DE90A9E80E605FFE30@SG2PR01MB1230.apcprd01.prod.exchangelabs.com>,
 <b4e48b4c-be3d-06ab-7f70-42c1205b5d94@xenomai.org>
In-Reply-To: <b4e48b4c-be3d-06ab-7f70-42c1205b5d94@xenomai.org>
Content-Language: en-IN
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Benchmarking the hardware by creating tasks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks


I would like to generate 10 different tasks and wish to test the context sw=
itching times between those tasks when run in preemptive mode.


Can i go with modifying the switch-test program.



Regards
Sripath Roy Koganti

________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: 02 September 2016 13:20:24
To: Sripath Roy Koganti; xenomai@xenomai.org
Subject: Re: [Xenomai] Benchmarking the hardware by creating tasks

On 08/31/2016 08:14 AM, Sripath Roy Koganti wrote:
> Hi
>
>
> I am a new user to Xenomai and a beginner lever programmer. I just starte=
d working on this framework or any RTOS. I need help/suggestions with the f=
ollowing
>
>
>   *   I want to generate few tasks one set with simple logic (arithmetic)=
 and other set involving floating point ops and wish to test the latency an=
d context switch times between the tasks. Can you suggest any simpler tasks=
 which could help me do that.
>   *
>   *   Also wish to test the above tasks by assigning various priorities a=
nd evaluate functioning of various schd algorithms on multicore environment=
.
>
> I have seen various benchmark tests which are predefined, but i wish to c=
reate the tasks on my own by setting the priorities. Also where can i study=
 the source of the benchmark tests
>
>
>
> It really helps to understand the functioning of the Framework by providi=
ng resources about tasks creation and implementation.
>
>

You have many programs in code source form available from the Xenomai
distro, notably under the demo/ and testsuite/ directories. A way to
measure latency is specifically illustrated by testsuite/latency.
Interpreting the various options of the latency program and how they
translate into actual code is made easier by reading this manpage:
http://www.xenomai.org/documentation/xenomai-3/html/man1/latency/index.html

Assuming you want to run a dual kernel configuration, the POSIX services
such code uses are documented here:
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt_=
_api.html

Some code from the demo tree is implemented with the alchemy API
instead, which is documented here:
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy=
.html

--
Philippe.
