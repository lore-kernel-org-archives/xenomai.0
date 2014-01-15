References: <10FA295E-2AE2-402F-8C2D-4653C9E0BD4E@gatech.edu>
 <CAMesUR6di8omZ+N26f__FcedVPVE67Xm6xjeabgvOZxMt8YytA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAMesUR6di8omZ+N26f__FcedVPVE67Xm6xjeabgvOZxMt8YytA@mail.gmail.com>
Message-Id: <FC0EB8FF-E108-4F1F-93BC-7AB5BBD8733D@gatech.edu>
From: "Yogi A. Patel" <yapatel@gatech.edu>
Date: Tue, 14 Jan 2014 23:02:35 -0500
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Analogy Calibrate NI-DAQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexis Berlemont <alexis.berlemont@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

To get started - what I need is the following:

I know that the older NI cards did hardware calibration and the new cards do=
 software calibration.=20

Now, I know that comedi has functions for it - so I am wondering how useful i=
t would be to start with the comedi code and modify for analogy.=20

I believe the best route to start is try to get the software calibration wor=
king since the newer cards all use that method. Is there documentation on ho=
w the DAQs go about doing this calibration?

Also, where do I clone a copy of the development code from? And what reposit=
ory do I send pull requests to?

That should get me started - thank you!

--
Yogi A. Patel
(url): www.yapatel.org | @yapatel525

> On Jan 14, 2014, at 2:01, Alexis Berlemont <alexis.berlemont@gmail.com> wr=
ote:
>=20
> Hi,
>=20
> Sorry for answering so late. Here is a short mail of apology.
>=20
> My free time has been drastically reduced these last few years; that
> is the reason why I was unable to provide many features which were
> planned into analogy (and notably the tool you need).
>=20
> Your contribution on this subject would be more than welcome.
>=20
> What kind of information do you need ?
>=20
> Regards,
>=20
> Alexis.
>=20
>> On Sat, Jan 11, 2014 at 5:04 PM, Yogi A. Patel <yapatel@gatech.edu> wrote=
:
>> Hi -
>>=20
>> I develop a real-time electrophysiology platform called RTXI (www.rtxi.or=
g) and have run into a slight issue. We recently switched over from RTAI to X=
enomai (for multiple reasons) and I can't seem to find an equivalent to come=
di_soft_calibarate for the National Instruments DAQs that we use.
>>=20
>> Was such a tool ever made? If not, would anyone be able to point me in th=
e direction to making such a tool for the Analogy drivers? I've written low-=
level drivers before (somewhat) - and wouldn't mind writing this - just need=
 some guidance.
>>=20
>> --
>> Yogi A. Patel
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
