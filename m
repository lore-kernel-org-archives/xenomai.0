Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Sigevent, sigaction
Date: Fri, 27 Jan 2006 08:31:09 -0000
Message-ID: <353F6272FE0A6544AA97D47F761F486B01707E94@domain.hid>
From: "Doyle, Alan" <alan.doyle@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Jan,

I was looking for the definition of sigevent particularly:-

typedef struct sigevent
  {
    sigval_t sigev_value;
    int sigev_signo;
    int sigev_notify;

    union
      {
	int _pad[__SIGEV_PAD_SIZE];

	struct
	  {
	    void (*_function) (sigval_t);	/* Function to start.
*/
	    void *_attribute;			/* Really
pthread_attr_t.  */
	  } _sigev_thread;
      } _sigev_un;
  } sigevent_t;

I was looking only in the Xenomai code, from Giles email I should also
have looked in the linux source where I found it in siginfo.h. Afraid
I'm not just new to Xenomai but Linux also!

Regards

-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Sent: 26 January 2006 16:10
To: Doyle, Alan
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-core] Sigevent, sigaction


Doyle, Alan wrote:
> I've downloaded Xenomai-2.0.3 and have been lookingh into signal=20
> handling. Structs sigevent & sigaction are used in the code but I=20
> can't find where they are declared. Can anyone help ?

Maybe browsing for them (identifier or full-text search) on this site
helps you (I do not understand yet what you are precisely looking for):

http://www.rts.uni-hannover.de/xenomai/lxr

Note that hart-RT signals are not yet supported in user space. RT user
space threads can only receive Linux signals, which will switch the
threads to secondary (non-deterministic) mode.

Jan


