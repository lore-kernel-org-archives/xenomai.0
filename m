From: Alexis Berlemont <berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] rtdm_event_timedwait hang-up
Date: Tue, 21 Mar 2006 01:48:10 +0100
References: <200603201434.15258@domain.hid> <441EE01D.6020400@domain.hid>
	<441EE5D4.9000204@domain.hid>
In-Reply-To: <441EE5D4.9000204@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603210148.11118.berlemont.hauw@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Hi,

> >>>I heard rumours of some COMEDI (www.comedi.org) port over RTDM recently,
> >>>don't know the current status.
> >>
> >>Indeed. The rumour is called Alex.
> >
> > Yes, I know. I just don't wanted to drag someone to public, saying: "Hey
> > man, already doing your job?" ;)
>
> It's part of the anti-shyness treatment I'm administering to Alex...
>
> > But, as we all know him now, what is the current status then?

My comedi port over RTDM is not completely over (and far from perfect). The 
mmap functionnalities have not been rewritten yet. However, I have been 
working on
-> the port of the comedi infrastructure layer (comedi/comedi_fops.c 
comedi/drivers.c comedi/range.c comedidev.h etc.) 
-> the rewriting of the driver comedi_test.c (which becomes comedi_test1.c)
-> other test stuff has been written in comedi_test2.c (replications functions 
to test comedi_write operations)
-> the ports of comedi_config and comedilib (partially done for comedilib), 
etc.

This stuff is working (minor bugs appart) and I could give you a version in 
the next few days (I have to check "make dist" ;) and minor things).

But there are plenty of things I am not happy with :
-> the original comedilib version is not really well suited for rtdm. In this 
library for many reasons; for example, you can find calls to malloc/free 
functions. If I stick to the original implementation, I have to either to ask 
for adding alloc stuff in user mode in rtdm skin or use another skin to 
manage allocations. None of these solutions seems interesting for me for many 
reasons. A lot of people  must be thinking I am overkill, it is true that the 
comedilib allocations should be done at init time (comedi_open, comedi_close) 
then no need to fulfull real-time constraints but I think comedi should be 
fully rtdm compliant; this would avoid tricky corner cases for 
developpers/users. The best and simplest solution for me would be some slight 
modifications in the comedilib API but I doubt everyone is OK with that.

-> I think the comedi structures organization (comedi_device, subdevice, 
async, etc.) should be reviewed considering the rtdm architecture. Of course, 
these modifications should not induce big changes in the comedi drivers 
source.

-> etc.

In fact, I wanted to propose two versions :
-> a first implementation as close as possible from the original 
implementation and API.
-> a second one a bit more adapted for rtdm.

Thus, we could have compared the two versions and see if everyone agrees with 
the idea of adapting comedi infrastructure. It would have been a good 
opportunity to work closely with comedi developers community.

Unfortunately, my second version is not finished yet. I still have some work 
on it (non negligible). (I know I know I am slower than a turtle which learns 
programming with an amstrad cpc 6128 and damaged floppy disks ). 

If someone is interested in getting a version right now, I will try to send to 
him a tarball as soon as possible. Compared to original comedi deliveries, I 
have not created two autotools tarballs (comedi and comedilib) but only one.

 Regards.

Alexis.



