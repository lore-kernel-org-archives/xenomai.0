MIME-Version: 1.0
In-Reply-To: <4E7CBFE0.1030202@domain.hid>
References: <CAMJ=MEeOYUsNXMOUwLyxTo5kDcTTER90bXUpPiwao0YGZMpTeQ@mail.gmail.com>
	<4E7C9020.3040204@domain.hid>
	<CAMJ=MEfvWpKn=AhbX_cgX-fAvX-uU=iZ1cys+JjdcUcUL9CYiQ@mail.gmail.com>
	<4E7CBFE0.1030202@domain.hid>
Date: Fri, 23 Sep 2011 21:58:08 +0200
Message-ID: <CAMJ=MEfNfidDPdLCGbdj91-XAhG-q6n3svoW_2f3UHbXetna5g@domain.hid>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai-forge: SEGFAULT is pSOS skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, Sep 23, 2011 at 7:20 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/23/2011 07:05 PM, Ronny Meeus wrote:
>> On Fri, Sep 23, 2011 at 3:56 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 09/22/2011 10:15 PM, Ronny Meeus wrote:
>>>> Hello
>>>>
>>>> I have created some time ago a test application for the PSOS interface
>>>> of Xenomai.
>>>
>>> If you agree, I would like to integrate this test in xenomai-head
>>> regression testsuite.
>>>
>>> --
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0Gilles.
>>>
>>
>> No problem, the test can be integrated.
>> Another option is to wait until the code is more clean and the
>> performance measurement is finished.
>> I'm planning to do this in the near future.
>
> I am rather interested in a test (or several tests) whose exit status
> indicates whether the tests it contains worked, and which does not take
> a long time to execute. The simpler, the better, as this way the test
> has fewer chances to contain bugs.
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

Gilles,

short tests have advantages but long running tests as well.
By running the test program for a long time you can sometimes identify
for example memory leaks, fragmentation or race conditions.

For example all standard psos test (in the testsuite directory) run
without issue on my PC while the test I have created reveals an issue.
So I think both types of tests can be useful.

Ronny

