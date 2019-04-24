From: "Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems, Inc]"
 <steven.seeger@nasa.gov>
Subject: Re: Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
Date: Wed, 24 Apr 2019 07:09:10 +0000
Message-ID: <DM6PR09MB3402E93589AAFCD31CE4EC2A853C0@DM6PR09MB3402.namprd09.prod.outlook.com>
References: <BB5C4F5E3633C64999D0577F81995AE70286E71C@XMAIL.tecom.nnov.ru>
 <55438112-789f-da93-99ed-0320b6486fa3@siemens.com>
 <DM6PR09MB3402364C4B51AF4E5095788D853C0@DM6PR09MB3402.namprd09.prod.outlook.com>,
 <8333b206-e819-c3e7-1394-3698baf2a075@siemens.com>
In-Reply-To: <8333b206-e819-c3e7-1394-3698baf2a075@siemens.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Alexander Sharabanov <sharabanov.a@tecomgroup.ru>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Unfortunately NASA has seen fit to require us to use this horrible outlook =
365 webmail thing, and apparently it does not support the typical inline qu=
oting that we use on this list. I will have to try and figure out a solutio=
n but of course I'm already extremely busy and that is just another thing f=
or the to-do list.

You are correct that the arinc653 work will not be tied to ppc32 at all. It=
 could all be part of noarch. However, we have a todo item here to work out=
 with our lawyers if the licensing issues on the arinc653 specification are=
 such that this work can be made public. I'd like it to be, for sure. Not t=
o compete or take money away from any commercial implementation, but to aid=
 groups like mine in various organizations out there who want to examine ar=
inc-653 and do prototyping without the high cost of entry. Stay tuned for n=
ews on this. FYI, most of arinc-653 part 1 required services is already imp=
lemented. I have one more batch of work to do on the kernel side but so far=
 it's looking pretty good. We have already taken some applications written =
against arinc-653 and run them on Xenomai with SCHED_TP.

I should definitely update to a more recent 4.14. I see noarch bits for 4.1=
4.110, so I just rebased all my work on top of that and it was pretty clean=
. (Any conflicts were not in specific IPIPE bits.) I don't have my boards w=
ith me right now, but I will be working with them later this week and can t=
est. I will try and get the patch out by the end of the week.

ppc32 is what we are calling it to prevent confusion with the now-dead ppc =
terminology, as ppc64 is no longer supported by Xenomai.

As for 4.4, I believe that was pre-noarch days. Philippe and I had decided =
that any future work on ppc would be done based on the noarch 4.14 branch. =
I assume at some point there will need to be a noarch branch for another ke=
rnel. I've not been as involved with the Xenomai project or mailing list as=
 I'd like, but my time is limited in this area right now.

As for 4.19, I figured I would wait until noarch is stable there. Right now=
 I see a wip branch. Would you like me to look into a 4.19 ipipe patch on t=
op of that? It may not be that hard for PPC.

I am sad to see what you wrote about ppc being dropped from GCC. I was not =
aware of that. I know that PPC is still very much in use in the aerospace i=
ndustry. I guess a commercial player will need to pay some folks to support=
 GCC and other FOSS projects for the architecture. There probably isn't any=
 reason that the same tools we have all used for years can't still be used =
for years, however. Who knows.

I know that most of you guys are doing ARM these days. I almost had a chanc=
e to do some arm work here, but I'm apparently grouped in with the wrong se=
t of folks so I didn't get to. Maybe someday.

Steven

