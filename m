From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C740201.5050606@domain.hid>
References: <4C73EC62.80703@domain.hid>
	<1282669146.1961.153.camel@domain.hid>
	<4C73FBD5.6080808@domain.hid>  <4C740201.5050606@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Aug 2010 10:31:01 +0200
Message-ID: <1282725061.1709.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] hostrt patches (was: [RFT] ipipe patch for
 2.6.35.3-x86)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Tue, 2010-08-24 at 19:31 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Philippe Gerum wrote:
> >> Btw, could you pick Wolfgang's host rt clock patch in your queue as
> >> well? I only have a few minor issues with it, which are no showstopper.
> >> The only thing to care of before merging this to mainline, is that no
> >> other arch does support this feature yet, so it is important to make it
> >> fully optional in -noarch, and Xenomai-wise also.
> >>
> >> We likely need some __IPIPE_FEATURE_* symbol to be defined in
> >> arch/x86/include/ipipe_base.h for this purpose, so that depending code
> >> could test for presence.
> > 
> > Will have a look.
> 
> Checked again: thanks to HAVE_IPIPE_HOSTRT, there should no need for any
> feature bit. Will build-check this once more tomorrow.
> 
> What issue did you see?

Comments will follow on Wolfgang's posts.

> 
> Jan
> 

-- 
Philippe.



