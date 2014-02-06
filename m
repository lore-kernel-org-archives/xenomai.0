From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Thu, 06 Feb 2014 23:46:40 +0100
Message-ID: <1564203.ZFLZKtcx78@indiana>
In-Reply-To: <52F4036C.4010401@xenomai.org>
References: <201402061158.29746.leo@alaxarxa.net>
 <201402061627.18322.leo@alaxarxa.net> <52F4036C.4010401@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] Xddp and socket: Address family not supported by
	protocol
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Sergi Ruiz Parra <sergi.ruiz.parra@upc.edu>, xenomai@xenomai.org

El Dijous, 6 de febrer de 2014, a les 22:49:32, Gilles Chanteperdrix va 
escriure:
[...]

> > 
> >>> (CPU time limit exceeded). It's not easy for us with that.
> >> 
> >> SIGXCPU is in fact Xenomai's SIGDEBUG. See
> >> examples/native/sigdebug.c to find out why you receive SIGDEBUG.
> >> My bet would be that you are missing mlockall. That said, Xenomai
> >> should issue the mlockall automatically, you simply have to take
> >> care of putting xenomai libraries at the end of the link-edit
> >> command line, so that xenomai libraries are loaded first.
> > 
> > Ok,
> > 
> > 
> > now it works, half work. So, it could be equivalent if I call the
> > mlockall function in the entry point of the lib? I mean, if I
> > create a init function of the lib and when I load it, mlockall is
> > called.
> 
> If the library uses xenomai posix skin services (through wrapping),

no, AFAIR we don't use the posix skin. Just for the examples.

> mlockall is not sufficient, the xenomai posix skin library has an
> initialization function which must be called first. Getting a library
> written for Linux implementation to work with xenomai requires several
> changes (which the document posted in answer to your first question
> tries to document). So, if you do not need this library to run in
> primary mode, I suggest you stick to your original plan which was to
> use RTDM without the posix skin wrapping.

Ok, I will look the document. I would prefer to have a clean implementation of 
pure xenomai native.

> >>> So, can we use the xddp protocol from native? Which functions
> >>> we should
> > 
> > use to
> > 
> >>> send/receive, etc?
> >> 
> >> See:
> > http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__userapi.h
> > tml> 
> >  good, done. Perfect. However we are having problems because _only_
> > 
> > one label is created. I suppose that there's no limit of the number
> > of sockets created in the RT thread, no?
> 
> Please try and reduce the problematic program to the minimal
> self-contained test case which we can run to reproduce the issue you have.

Yes, I'm almost sure that we are doing something wrong. However, I think that 
to create a modification example from the xddp-echo or label could be a good 
idea. Tomorrow more,

Thanks for all,

Leopold

-- 
--
Linux User 152692     PGP: 0xF944807E
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?


