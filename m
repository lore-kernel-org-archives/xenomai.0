MIME-Version: 1.0
Message-ID: <trinity-c7adab7a-6515-4020-bf0e-ed57924e93e6-1447866660248@3capp-webde-bap53>
From: JK.Behnke@web.de
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2015 18:11:00 +0100
In-Reply-To: <20151118162434.GB27240@hermes.click-hack.org>
References: <trinity-3b905084-1366-4586-b761-0f15088b0d82-1447853696479@3capp-webde-bap53>
 <20151118135249.GA24942@hermes.click-hack.org>
 <trinity-1434a025-2abb-4454-9acd-44193ddea637-1447857385104@3capp-webde-bap53>,
 <20151118162434.GB27240@hermes.click-hack.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles,

>On Wed, Nov 18, 2015 at 03:36:25PM +0100, JK=2EBehnke@web=2Ede wrote:
>> Hello Gilles,
>>
>> thanks for your quick response=2E
>> See my comments/questions below=2E
>>
>> >On Wed, Nov 18, 2015 at 02:34:56PM +0100, JK=2EBehnke@web=2Ede wrote:
>> >> Hello,
>> >>
>> >> I'm currently debugging a problem in my xenomai application=2E
>> >> In order ot get timing information I do the following inside the
>> >> read-handler of my rtdm driver=2E
>> >>
>> >> // --- start code snippet ---------------------------------
>> >> nanosecs_abs_t t1, t2;
>> >> rtdm_lock_get_irqsave(&lockobj, lockctx);
>> >>
>> >> t1=3Drtdm_clock_read();
>> >> rtdm_task_busy_sleep(10000); // code block to be measured=2E
>> >> t2=3Drtdm_clock_read();
>> >>
>> >> rtdm_lock_put_irqrestore(&lockobj, lockctx);
>> >> // --- end code snippet ---------------------------------
>> >>
>> >> I observe the following time differences t2-t1:
>> >> min=3D10176 ns, max=3D10737 ns, avg=3D10314 ns
>> >>
>> >> This means in this case the average overhead of the two rtdm_clock_r=
ead
>> >> calls is
>> >> approximately 314 ns/2 =3D 157 ns=2E
>> >
>> >No, this means that the average overhead of rtdm_clock_read is
>> >314ns=2E
>> >
>> >what you do is:
>> >read time
>> >convert to ns
>> >busy sleep
>> >read time
>> >convert to ns
>> >
>> >As you can see, between the two time reads, there is only one
>> >conversion to nanoseconds, (which we assume is the bulk of the
>> >overhead)=2E And more generally, the overhead of the second time read
>> >is not counted either=2E
>> >
>> >
>> >>
>> >> Is that realistic?
>> >
>> >This seems to be a lot=2E The "tsc" test will measure the average
>> >difference between two time reads, and the "arith" test will measure
>> >the average time for a "multiply then shift" operation, adding the
>> >two should give you an idea of the overhead=2E From what I recall,
>> >reading the tsc on an atom N230 (a very old one) had an overhead
>> >around 20ns=2E
>> Where do I find the "tsc test", which test application do I have to run=
?
>
>The application is named "tsc"=2E

Thanks, meanwhile I found the tsc tool under /usr/xenomai/bin/regression

Here are my "tsc" results
Atom E640 (1=2E0 GHz): min: 26, max: 936, avg: 34=2E0001 -> 0=2E0262211 us=
=C2=A0 =3D=3D> 26 ns
Atom E660 (1=2E3 GHz): min: 26, max: 1105, avg: 34=2E0001 -> 0=2E0262211 u=
s =3D=3D> 26 ns

The "arith" tool delivered these results (only lines containing "llmulshft=
")
Atom E640 (1=2E0 GHz):
inlined llmulshft: 0x79364d92ffffffe1: 29=2E088 ns, rejected 0/10000=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D=3D> 29 ns
out of line llmulshft: 0x79364d92ffffffe1: 40=2E097 ns, rejected 0/10000 =
=3D=3D> 40 ns
inlined llmulshft: 0x86c9b26d0000001e: 30=2E222 ns, rejected 0/10000=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D=3D> 30 ns
out of line llmulshft: 0x86c9b26d0000001e: 44=2E118 ns, rejected 1/10000 =
=3D=3D> 44 ns

Atom E660 (1=2E3 GHz):
inlined llmulshft: 0x79364d92ffffffe1: 22=2E372 ns, rejected 1/10000=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D=3D> 22 ns
out of line llmulshft: 0x79364d92ffffffe1: 30=2E851 ns, rejected 0/10000 =
=3D=3D> 31 ns
inlined llmulshft: 0x86c9b26d0000001e: 23=2E916 ns, rejected 0/10000=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D=3D> 24 ns
out of line llmulshft: 0x86c9b26d0000001e: 33=2E936 ns, rejected 1/10000 =
=3D=3D> 34 ns
What do you think about these results?
>
>>
>>
>> >
>> >> Are there any other functions I might use to measure execution time =
of
>> >> an arbitrary code block?
>> >
>> >You may want to use the tsc=2E The native skin has rt_timer_tsc and
>> >rt_timer_tsc2ns=2E Since you are in kernel space, you may want to
>> >use the I-pipe tsc read function, which should reduce even more the
>> >overhead=2E
>> Where do I find the I-pipe tsc read function=2E
>> I can't find it in the documentation=2E
>
>That is because it is an internal function=2E Look at the
>implementation of rt_timer_tsc=2E The name is xnarch_get_cpu_tsc();

OK, I'll have look at it=2E


Thanks
Jochen
=C2=A0

