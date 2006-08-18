Message-ID: <44E606B9.6050406@domain.hid>
Date: Fri, 18 Aug 2006 12:28:09 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
	<44E5F0B4.8070405@domain.hid> <44E6009E.7020304@domain.hid>
In-Reply-To: <44E6009E.7020304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Test, benchmark
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jim Cromie wrote:
>   
>> ...
>> just responding to small part now..
>>
>> this patch adds switchtest, switchbench (and drops switch) and irqbench.
>>
>> each test-prog has a corresponding $XENOT_<progname>
>> with which you can inject new test arguments individually.
>> Most of these can be undef'd, except for XENOT_IRQBENCH,
>> which needs to be set in order for test to run (since the test requires
>> additional resources, as you noted above)
>>     
>
> I doesn't necessarily require additional parameters (default is the
> first serial port on PCs).
>
> Why not adding a switch to xeno_test instead? Something like "-a
> <additional-tests>" (e.g. "-a irqbench,whateverbench"). However, please
> don't forget to document this extension (man page?).
>
> Jan
>
>   
several reasons for my preference:

- xeno-test is already cluttered with options, many of which propagate 
down to tests
- as more tests are added, more option-clashing is inevitable.
    this makes pass-downs more complicated.
- prog-specific options isolate us from option clashes / churn
- assuming -a <prog>,
    need to handle multiples on line (I havent done that with shell getopts)
    I have to wonder if all shells have uniform getopt behavior -
       we want to work on bash, sh, ash, dash ...
- I get to duck the manpage update ;-)

