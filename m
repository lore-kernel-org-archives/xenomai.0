From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15632.30733.393799.700979@domain.hid>
Date: Wed, 19 Jun 2002 14:24:45 +0200
Subject: Re: [Adeos-main] Re: My first tests with adeos!!!
In-Reply-To: <20020619051755.75505.qmail@domain.hid>
References: <3D0F0BA2.969434A3@domain.hid>
	<20020619051755.75505.qmail@domain.hid>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: mohan kumar <mohan_knb@domain.hid>
Cc: adeos-main@gna.org

Hi Mohan,

mohan kumar writes:
 > hi,
 > I think iam not clear...

Now you are ;o)

I just want to let you know that I'm digging this problem (using your
code snippet) which also appears with the current CVS head
version. I'll tell you more asap. My first observations point to a
random bug in the deferred interrupt dispatch code when returning from
the user domain handler.

Btw, the current CVS version implements the basics of SMP support, but
it is _not_ complete. However, it still works (well on my test
platforms it does) in UP mode. If you want to fetch the older non-SMP
code, use the "pre-smp" tag when checking it out.

Finally, be aware that I've added some fields to the adattr_t domain
attribute struct to control additional functionalities. Mainly,
"domid" is just an external numerical domain id you can set to
anything but 0 (reserved to the root Linux domain), and "dswitch"
which is a domain switch handler called each time the domain is
resumed by Adeos to process interrupts. 

 > 
 > But i will work with the new code in CVS and mail u
 > the results.

Thanks.

Cheers,

Philippe.

