MIME-Version: 1.0
In-Reply-To: <D9A6A459-6F45-4191-B6B8-EECC0147FBAE@usc.edu>
References: <A54FA449-A0A8-4DCF-96C0-078ED6729C4C@usc.edu>
	<20110103223909.GA2862@domain.hid>
	<D9A6A459-6F45-4191-B6B8-EECC0147FBAE@usc.edu>
Date: Sun, 18 Sep 2011 22:15:34 +0200
Message-ID: <CAMesUR6JnYk=9ZzB+dbeSW0Bmmj-zDfczLJkeZ-24ckMGevBcA@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Analogy DIO data acquisition with NI6259
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Wed, Sep 14, 2011 at 5:38 AM, Stefan Schaal <sschaal@domain.hid> wrote:
> This is a summary and conclusion of using a NI6259 with Xenomai/Analogy f=
or digital data I/O. First of all, many thanks to Alexis whose Analogy bran=
ch really allowed us to succeed! We would just like share the final results=
 of our implementation with the hope that this might help others.
>
> Goals:
> We needed a 19 bit parallel I/O for bi-directional communication between =
a host computer and a robot controller. The 32bit DIO of the NI6259 seemed =
to well suited. The communication protocol needs about 300 DIO commands per=
 ms, where every about 20 commands the DIO port needs to switch from write =
to read and then back.
>
> Problems:
> Initially we tried a4l_sync_dio() (synchronous communication). We measure=
d that one a4l_sync_dio() takes about 5us. Additionally, the switch from re=
ad to write mode also seems to take some additional time. Thus, the communi=
cation speed was not sufficient.
>
> A 2nd attempt was to use instructions and instruction lists using a4l_snd=
_insnlist() and a4l_snd_insn(). We measure that this can bring down one dat=
a acquisition to about 3.5us when all commands are queued up in an instruct=
ion list, but due to the read/write switch we needed, we cannot use very lo=
ng instruction lists, and the read/write switch takes too long. Thus, the c=
ommunication speed did not improve a lot.
>
> A 3rd attempt was to use CMD structures. Following comedi examples, we cr=
eate a 200ns clock and triggered the CMD streaming with this clock. This al=
lows VERY fast DIO. But, again, the read/write switches that are needed fre=
quently made CMD structures inefficient as we could not cue up a lot of DIO=
 commands before the next read/write switch, and in order to do the read/wr=
ite switch, the CMD has to be aborted. We also noted that starting a CMD ha=
s some delays.
>
> We realized that none of these approaches was feasible.
>
> Solution:
> We create a simple IC-based circuit that allowed to branch the read/write=
 DIO protocol such that we could use one DIO channel of the NI6259 for writ=
e only (never switched to read), and the 2nd DIO channel on the NI6259 for =
read only (no switching). By avoiding the read/write switching, all three i=
deas from above are possible and run fast enough (after some optimization o=
f our communication protocol). We ended up using a4l_sync_dio() as it is th=
e easiest to use, and yielded sufficient speed. With the CMD approach, we w=
ould be able to go a factor 5-10 faster even.
>
> For you info, our interface C-code is attached. This is not general purpo=
se software, but should allow other to get the idea of what we do.

Many thanks for this feedback!


>
> Best wishes, and thanks again to Alexis!
>
> -Stefan
>
>

Alexis.

